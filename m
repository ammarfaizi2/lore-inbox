Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268042AbTBRWJ4>; Tue, 18 Feb 2003 17:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268043AbTBRWJz>; Tue, 18 Feb 2003 17:09:55 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:34695 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268042AbTBRWJi>; Tue, 18 Feb 2003 17:09:38 -0500
Date: Tue, 18 Feb 2003 17:19:33 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302182219.h1IMJXnL032017@locutus.cmf.nrl.navy.mil>
To: jgarzik@pobox.com
Subject: [PATCH]  s/uni driver resets 8-/16-bit mode in MT register
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the s/uni driver writes 0 to the MT register.  in the s/uni 622 
phy, bit 7 is not a test mode, but the 8- or 16-bit wide selector.
this patch keeps the s/uni driver from resetting this bit.


Index: drivers/atm/suni.c
===================================================================
RCS file: /afs/cmf/project/cvsroot/linux/drivers/atm/suni.c,v
retrieving revision 1.2
retrieving revision 1.1
diff -u -d -b -w -r1.2 -r1.1
--- linux/drivers/atm/suni.c	4 Mar 2002 21:16:19 -0000	1.2
+++ linux/drivers/atm/suni.c	4 Mar 2002 15:06:44 -0000	1.1
@@ -220,7 +220,7 @@
 static void suni_int(struct atm_dev *dev)
 {
 	poll_los(dev);
-	printk(KERN_NOTICE "%s%d: signal %s\n",dev->type,dev->number,
+	printk(KERN_NOTICE "%s(itf %d): signal %s\n",dev->type,dev->number,
 	    dev->signal == ATM_PHY_SIG_LOST ?  "lost" : "detected again");
 }
 
@@ -246,7 +246,7 @@
 		/* interrupt on loss of signal */
 	poll_los(dev); /* ... and clear SUNI interrupts */
 	if (dev->signal == ATM_PHY_SIG_LOST)
-		printk(KERN_WARNING "%s%d: no signal\n",dev->type,
+		printk(KERN_WARNING "%s(itf %d): no signal\n",dev->type,
 		    dev->number);
 	PRIV(dev)->loop_mode = ATM_LM_NONE;
 	suni_hz(0); /* clear SUNI counters */
@@ -298,11 +298,9 @@
 	unsigned char mri;
 
 	mri = GET(MRI); /* reset SUNI */
-	DPRINTK("%s%d: mri 0x%x type %d\n",dev->type, dev->number,
-				(mri & SUNI_MRI_TYPE) >> SUNI_MRI_TYPE_SHIFT);
 	PUT(mri | SUNI_MRI_RESET,MRI);
 	PUT(mri,MRI);
-	PUT((GET(MT) & SUNI_MT_DS27_53),MT); /* disable all tests */
+	PUT(0,MT); /* disable all tests */
 	REG_CHANGE(SUNI_TPOP_APM_S,SUNI_TPOP_APM_S_SHIFT,SUNI_TPOP_S_SONET,
 	    TPOP_APM); /* use SONET */
 	REG_CHANGE(SUNI_TACP_IUCHP_CLP,0,SUNI_TACP_IUCHP_CLP,
Index: drivers/atm/suni.h
===================================================================
RCS file: /afs/cmf/project/cvsroot/linux/drivers/atm/suni.h,v
retrieving revision 1.2
retrieving revision 1.1
diff -u -d -b -w -r1.2 -r1.1
--- linux/drivers/atm/suni.h	4 Mar 2002 21:16:19 -0000	1.2
+++ linux/drivers/atm/suni.h	4 Mar 2002 15:06:44 -0000	1.1
@@ -198,7 +198,6 @@
 #define SUNI_MT_IOTST		0x04	/* RW, enable test mode */
 #define SUNI_MT_DBCTRL		0x08	/* W, control data bus by CSB pin */
 #define SUNI_MT_PMCTST		0x10	/* W, PMC test mode */
-#define SUNI_MT_DS27_53		0x80	/* RW, select between 8- or 16- bit */
 
 
 #define SUNI_IDLE_PATTERN       0x6a    /* idle pattern */
