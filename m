Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSIDXYJ>; Wed, 4 Sep 2002 19:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSIDXYI>; Wed, 4 Sep 2002 19:24:08 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:1231 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316204AbSIDXYG>;
	Wed, 4 Sep 2002 19:24:06 -0400
Date: Wed, 4 Sep 2002 16:28:40 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : Wavelan Pcmcia update
Message-ID: <20020904232840.GD21592@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi Jeff,

        Could you please push the following patch upstream ?
        A few cleanups for the good old Wavelan Pcmcia driver. Tested
on 2.5.32 SMP.

        Have fun...

        Jean

----------------------------------------------------------

diff -u -p linux/drivers/net/wireless/wavelan_cs.p.25.h linux/drivers/net/wireless/wavelan_cs.p.h
--- linux/drivers/net/wireless/wavelan_cs.p.25.h	Tue Sep  3 14:40:15 2002
+++ linux/drivers/net/wireless/wavelan_cs.p.h	Wed Sep  4 15:28:34 2002
@@ -400,6 +400,12 @@
  *		o got rid of wavelan_ioctl()
  *		o use a bunch of iw_handler instead
  *
+ * Changes made for release in 3.2.1 :
+ * ---------------------------------
+ *	- Set dev->trans_start to avoid filling the logs
+ *		(and generating useless abort commands)
+ *	- Avoid deadlocks in mmc_out()/mmc_in()
+ *
  * Wishes & dreams:
  * ----------------
  *	- Cleanup and integrate the roaming code
diff -u -p linux/drivers/net/wireless/wavelan_cs.25.c linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net/wireless/wavelan_cs.25.c	Tue Sep  3 14:40:05 2002
+++ linux/drivers/net/wireless/wavelan_cs.c	Wed Sep  4 15:26:11 2002
@@ -282,9 +282,11 @@ mmc_out(u_long		base,
 	u_short		o,
 	u_char		d)
 {
+  int count = 0;
+
   /* Wait for MMC to go idle */
-  while(inb(HASR(base)) & HASR_MMI_BUSY)
-    ;
+  while((count++ < 100) && (inb(HASR(base)) & HASR_MMI_BUSY))
+    udelay(10);
 
   outb((u_char)((o << 1) | MMR_MMI_WR), MMR(base));
   outb(d, MMD(base));
@@ -317,14 +319,16 @@ static inline u_char
 mmc_in(u_long	base,
        u_short	o)
 {
-  while(inb(HASR(base)) & HASR_MMI_BUSY)
-    ;
+  int count = 0;
+
+  while((count++ < 100) && (inb(HASR(base)) & HASR_MMI_BUSY))
+    udelay(10);
   outb(o << 1, MMR(base));		/* Set the read address */
 
   outb(0, MMD(base));			/* Required dummy write */
 
-  while(inb(HASR(base)) & HASR_MMI_BUSY)
-    ;
+  while((count++ < 100) && (inb(HASR(base)) & HASR_MMI_BUSY))
+    udelay(10);
   return (u_char) (inb(MMD(base)));	/* Now do the actual read */
 }
 
@@ -3581,6 +3585,9 @@ wv_packet_write(device *	dev,
   /* Send the transmit command */
   wv_82593_cmd(dev, "wv_packet_write(): transmit",
 	       OP0_TRANSMIT, SR0_NO_RESULT);
+
+  /* Make sure the watchdog will keep quiet for a while */
+  dev->trans_start = jiffies;
 
   /* Keep stats up to date */
   lp->stats.tx_bytes += length;
