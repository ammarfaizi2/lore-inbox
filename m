Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTFJPMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTFJPMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:12:52 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:60425 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262976AbTFJPMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:12:47 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>
Subject: [PATCH 2/2] xirc2ps_cs update
Date: Tue, 10 Jun 2003 15:24:15 -0400
User-Agent: KMail/1.5.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-net" <linux-net@vger.kernel.org>
References: <200306101517.17011.daniel.ritz@gmx.ch>
In-Reply-To: <200306101517.17011.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306101524.15648.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the second patch:
replaces busy_loop with a simple macro doing a schedule_timeout. busy_loop was never
called from interrupt conext anyway, so no need for that. and the sti() is gone.

rgds
-daniel


--- linux-2.5/drivers/net/pcmcia/xirc2ps_cs.c~1	2003-06-09 15:28:22.000000000 -0400
+++ linux-2.5/drivers/net/pcmcia/xirc2ps_cs.c	2003-06-10 14:17:04.000000000 -0400
@@ -431,22 +431,10 @@
 #define PutByte(reg,value) outb((value), ioaddr+(reg))
 #define PutWord(reg,value) outw((value), ioaddr+(reg))
 
-static void
-busy_loop(u_long len)
-{
-    if (in_interrupt()) {
-	u_long timeout = jiffies + len;
-	u_long flags;
-	save_flags(flags);
-	sti();
-	while (time_before_eq(jiffies, timeout))
-	    ;
-	restore_flags(flags);
-    } else {
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(len);
-    }
-}
+#define Wait(n) do { \
+	set_current_state(TASK_UNINTERRUPTIBLE); \
+	schedule_timeout(n); \
+} while (0)
 
 /*====== Functions used for debugging =================================*/
 #if defined(PCMCIA_DEBUG) && 0 /* reading regs may change system status */
@@ -1780,12 +1768,12 @@
     SelectPage(4);
     udelay(1);
     PutByte(XIRCREG4_GPR1, 0);	     /* clear bit 0: power down */
-    busy_loop(HZ/25);		     /* wait 40 msec */
+    Wait(HZ/25);		     /* wait 40 msec */
     if (local->mohawk)
 	PutByte(XIRCREG4_GPR1, 1);	 /* set bit 0: power up */
     else
 	PutByte(XIRCREG4_GPR1, 1 | 4);	 /* set bit 0: power up, bit 2: AIC */
-    busy_loop(HZ/50);		     /* wait 20 msec */
+    Wait(HZ/50);		     /* wait 20 msec */
 }
 
 static void
@@ -1799,9 +1787,9 @@
 
     hardreset(dev);
     PutByte(XIRCREG_CR, SoftReset); /* set */
-    busy_loop(HZ/50);		     /* wait 20 msec */
+    Wait(HZ/50);		     /* wait 20 msec */
     PutByte(XIRCREG_CR, 0);	     /* clear */
-    busy_loop(HZ/25);		     /* wait 40 msec */
+    Wait(HZ/25);		     /* wait 40 msec */
     if (local->mohawk) {
 	SelectPage(4);
 	/* set pin GP1 and GP2 to output  (0x0c)
@@ -1812,7 +1800,7 @@
     }
 
     /* give the circuits some time to power up */
-    busy_loop(HZ/2);		/* about 500ms */
+    Wait(HZ/2);		/* about 500ms */
 
     local->last_ptr_value = 0;
     local->silicon = local->mohawk ? (GetByte(XIRCREG4_BOV) & 0x70) >> 4
@@ -1831,7 +1819,7 @@
 	SelectPage(0x42);
 	PutByte(XIRCREG42_SWC1, 0x80);
     }
-    busy_loop(HZ/25);		     /* wait 40 msec to let it complete */
+    Wait(HZ/25);		     /* wait 40 msec to let it complete */
 
   #ifdef PCMCIA_DEBUG
     if (pc_debug) {
@@ -1890,7 +1878,7 @@
 	    printk(KERN_INFO "%s: MII selected\n", dev->name);
 	    SelectPage(2);
 	    PutByte(XIRCREG2_MSR, GetByte(XIRCREG2_MSR) | 0x08);
-	    busy_loop(HZ/50);
+	    Wait(HZ/50);
 	} else {
 	    printk(KERN_INFO "%s: MII detected; using 10mbs\n",
 		   dev->name);
@@ -1899,7 +1887,7 @@
 		PutByte(XIRCREG42_SWC1, 0xC0);
 	    else  /* enable 10BaseT */
 		PutByte(XIRCREG42_SWC1, 0x80);
-	    busy_loop(HZ/25);	/* wait 40 msec to let it complete */
+	    Wait(HZ/25);	/* wait 40 msec to let it complete */
 	}
 	if (full_duplex)
 	    PutByte(XIRCREG1_ECR, GetByte(XIRCREG1_ECR | FullDuplex));
@@ -1992,7 +1980,7 @@
 	 * Fixme: Better to use a timer here!
 	 */
 	for (i=0; i < 35; i++) {
-	    busy_loop(HZ/10);	 /* wait 100 msec */
+	    Wait(HZ/10);	 /* wait 100 msec */
 	    status = mii_rd(ioaddr,  0, 1);
 	    if ((status & 0x0020) && (status & 0x0004))
 		break;

