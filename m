Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262697AbSJJBs1>; Wed, 9 Oct 2002 21:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262791AbSJJBs1>; Wed, 9 Oct 2002 21:48:27 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:61181 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S262697AbSJJBsW>;
	Wed, 9 Oct 2002 21:48:22 -0400
Date: Wed, 9 Oct 2002 21:53:49 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ewrk3: Add support for multiple NICs when modular (WAS: Looking for testers...)
Message-ID: <20021010015349.GA5664@www.kroptech.com>
References: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua> <20021009171452.GA9682@www.kroptech.com> <200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testing is in progress... Three NICs, 2 CPU SMP, preempt enabled. No problems so
far. For my own convenience I wanted support for multiple NICs when the driver
is built as a module, so here's a fairly simple patch to add that capability.
Against 2.5.41 + your cli/sti removal patch.

--Adam

--- linux-2.5.41/drivers/net/ewrk3.c	Wed Oct  9 21:29:15 2002
+++ linux-2.5.41-fix2/drivers/net/ewrk3.c	Wed Oct  9 21:40:23 2002
@@ -76,6 +76,7 @@
    kernel with the ewrk3 configuration turned off and reboot.
    5) insmod ewrk3.o
    [Alan Cox: Changed this so you can insmod ewrk3.o irq=x io=y]
+   [Adam Kropelin: now accepts irq=x1,x2 io=y1,y2 for multiple cards]
    6) run the net startup bits for your new eth?? interface manually
    (usually /etc/rc.inet[12] at boot time).
    7) enjoy!
@@ -130,10 +131,12 @@
    Add new multicasting code.
    0.41    20-Jan-96   Fix IRQ set up problem reported by
    <kenneth@bbs.sas.ntu.ac.sg>.
-   0.42    22-Apr-96      Fix alloc_device() bug <jari@markkus2.fimr.fi>
-   0.43    16-Aug-96      Update alloc_device() to conform to de4x5.c
-   0.44    08-Nov-01      use library crc32 functions <Matt_Domsch@dell.com>
-   0.45	   19-Jul-02	  fix unaligned access on alpha <martin@bruli.net>
+   0.42    22-Apr-96   Fix alloc_device() bug <jari@markkus2.fimr.fi>
+   0.43    16-Aug-96   Update alloc_device() to conform to de4x5.c
+   0.44    08-Nov-01   use library crc32 functions <Matt_Domsch@dell.com>
+   0.45    19-Jul-02   fix unaligned access on alpha <martin@bruli.net>
+   0.46    10-Oct-02   cli/sti removal <VDA@port.imtp.ilyichevsk.odessa.ua>
+   Multiple NIC support when module <akropel1@rochester.rr.com>
 
    =========================================================================
  */
@@ -167,7 +170,7 @@
 #include "ewrk3.h"
 
 static char version[] __initdata =
-"ewrk3.c:v0.43a 2001/02/04 davies@maniac.ultranet.com\n";
+"ewrk3.c:v0.46 2002/10/09 davies@maniac.ultranet.com\n";
 
 #ifdef EWRK3_DEBUG
 static int ewrk3_debug = EWRK3_DEBUG;
@@ -196,6 +199,7 @@
 #define EWRK3_IOP_INC 0x20	/* I/O address increment */
 #define EWRK3_TOTAL_SIZE 0x20	/* required I/O address length */
 
+/* If you change this, remember to also change MODULE_PARM array limits */
 #ifndef MAX_NUM_EWRK3S
 #define MAX_NUM_EWRK3S 21
 #endif
@@ -1853,35 +1857,62 @@
 }
 
 #ifdef MODULE
-static struct net_device thisEthwrk;
-static int io = 0x300;		/* <--- EDIT THESE LINES FOR YOUR CONFIGURATION */
-static int irq = 5;		/* or use the insmod io= irq= options           */
-
-MODULE_PARM(io, "i");
-MODULE_PARM(irq, "i");
-MODULE_PARM_DESC(io, "EtherWORKS 3 I/O base address");
-MODULE_PARM_DESC(irq, "EtherWORKS 3 IRQ number");
+static struct net_device *ewrk3_devs[MAX_NUM_EWRK3S];
+static int ndevs;
+static int io[MAX_NUM_EWRK3S+1] = { 0x300, 0, };		/* <--- EDIT THESE LINES FOR YOUR CONFIGURATION */
+static int irq[MAX_NUM_EWRK3S+1] = { 5, 0, };		/* or use the insmod io= irq= options           */
+
+/* '21' below should really be 'MAX_NUM_EWRK3S' */
+MODULE_PARM(io, "0-21i");
+MODULE_PARM(irq, "0-21i");
+MODULE_PARM_DESC(io, "EtherWORKS 3 I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherWORKS 3 IRQ number(s)");
 
 int init_module(void)
 {
-	thisEthwrk.base_addr = io;
-	thisEthwrk.irq = irq;
-	thisEthwrk.init = ewrk3_probe;
-	if (register_netdev(&thisEthwrk) != 0)
-		return -EIO;
-	return 0;
+	int i=0;
+
+	while( io[i] && irq[i] ) {
+		ewrk3_devs[ndevs] = kmalloc(sizeof(struct net_device), GFP_KERNEL);
+		if (!ewrk3_devs[ndevs])
+			goto error; 
+		memset(ewrk3_devs[ndevs], 0, sizeof(struct net_device));
+		ewrk3_devs[ndevs]->base_addr = io[i];
+		ewrk3_devs[ndevs]->irq = irq[i];
+		ewrk3_devs[ndevs]->init = ewrk3_probe;
+
+		if (register_netdev(ewrk3_devs[ndevs]) == 0)
+			ndevs++;
+		else
+			kfree(ewrk3_devs[ndevs]);
+
+		i++;
+	}
+
+	return ndevs ? 0 : -EIO;
+
+error:
+	cleanup_module();
+	return -ENOMEM;
 }
 
 void cleanup_module(void)
 {
-	unregister_netdev(&thisEthwrk);
-	if (thisEthwrk.priv) {
-		kfree(thisEthwrk.priv);
-		thisEthwrk.priv = NULL;
-	}
-	thisEthwrk.irq = 0;
+	int i;
 
-	release_region(thisEthwrk.base_addr, EWRK3_TOTAL_SIZE);
+	for( i=0; i<ndevs; i++ )
+	{
+		unregister_netdev(ewrk3_devs[i]);
+		if (ewrk3_devs[i]->priv) {
+			kfree(ewrk3_devs[i]->priv);
+			ewrk3_devs[i]->priv = NULL;
+		}
+		ewrk3_devs[i]->irq = 0;
+
+		release_region(ewrk3_devs[i]->base_addr, EWRK3_TOTAL_SIZE);
+		kfree(ewrk3_devs[i]);
+		ewrk3_devs[i] = NULL;
+	}
 }
 #endif				/* MODULE */
 MODULE_LICENSE("GPL");

--- linux-2.5.41/Documentation/networking/ewrk3.txt	Mon Mar 18 15:37:08 2002
+++ linux-2.5.41-fix2/Documentation/networking/ewrk3.txt	Wed Oct  9 21:44:24 2002
@@ -24,6 +24,7 @@
     kernel with the ewrk3 configuration turned off and reboot.
     5) insmod ewrk3.o
           [Alan Cox: Changed this so you can insmod ewrk3.o irq=x io=y]
+          [Adam Kropelin: Multiple cards now supported by irq=x1,x2 io=y1,y2]
     6) run the net startup bits for your new eth?? interface manually 
     (usually /etc/rc.inet[12] at boot time). 
     7) enjoy!

