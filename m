Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbTCEQGZ>; Wed, 5 Mar 2003 11:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbTCEQGY>; Wed, 5 Mar 2003 11:06:24 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:27541 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267659AbTCEQGS>; Wed, 5 Mar 2003 11:06:18 -0500
Message-Id: <200303051616.h25GGTGi006786@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][ATM] cleanup nicstar, suni and idt77105
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 05 Mar 2003 11:16:29 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch removes the mod_inc_use_count/mod_dec_use_count from the
suni and idt77105 drivers (automatic ref counting of the suni_init
and idt77105_init symbols handles things nicely).  #ifdef MODULE,
init_module and exit_module are gone. the cli() in idt77105 was
converted to a spinlock.  and since both phy drivers now have .stop
functions, the nicstar can unload itself when using either.

Index: linux/drivers/atm/nicstar.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/nicstar.c,v
retrieving revision 1.1
diff -u -r1.1 nicstar.c
--- linux/drivers/atm/nicstar.c	20 Feb 2003 13:45:03 -0000	1.1
+++ linux/drivers/atm/nicstar.c	5 Mar 2003 01:05:21 -0000
@@ -354,11 +354,8 @@
 
       card = cards[i];
 
-#ifdef CONFIG_ATM_NICSTAR_USE_IDT77105
-      if (card->max_pcr == ATM_25_PCR) {
-        idt77105_stop(card->atmdev);
-      }
-#endif /* CONFIG_ATM_NICSTAR_USE_IDT77105 */
+      if (card->atmdev->phy && card->atmdev->phy->stop)
+        card->atmdev->phy->stop(card->atmdev);
 
       /* Stop everything */
       writel(0x00000000, card->membase + CFG);
@@ -905,22 +902,13 @@
    card->atmdev->phy = NULL;
 
 #ifdef CONFIG_ATM_NICSTAR_USE_SUNI
-   if (card->max_pcr == ATM_OC3_PCR) {
+   if (card->max_pcr == ATM_OC3_PCR)
       suni_init(card->atmdev);
-
-      MOD_INC_USE_COUNT;
-      /* Can't remove the nicstar driver or the suni driver would oops */
-   }
 #endif /* CONFIG_ATM_NICSTAR_USE_SUNI */
 
 #ifdef CONFIG_ATM_NICSTAR_USE_IDT77105
-   if (card->max_pcr == ATM_25_PCR) {
+   if (card->max_pcr == ATM_25_PCR)
       idt77105_init(card->atmdev);
-      /* Note that for the IDT77105 PHY we don't need the awful
-       * module count hack that the SUNI needs because we can
-       * stop the '105 when the nicstar module is cleaned up.
-       */
-   }
 #endif /* CONFIG_ATM_NICSTAR_USE_IDT77105 */
 
    if (card->atmdev->phy && card->atmdev->phy->start)
Index: linux/drivers/atm/idt77105.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/idt77105.c,v
retrieving revision 1.2
diff -u -r1.2 idt77105.c
--- linux/drivers/atm/idt77105.c	26 Feb 2003 02:23:53 -0000	1.2
+++ linux/drivers/atm/idt77105.c	5 Mar 2003 00:40:49 -0000
@@ -308,7 +308,6 @@
 	spin_lock_irqsave(&idt77105_priv_lock, flags);
 	if (start_timer) {
 		start_timer = 0;
-		spin_unlock_irqrestore(&idt77105_priv_lock, flags);
                 
 		init_timer(&stats_timer);
 		stats_timer.expires = jiffies+IDT77105_STATS_TIMER_PERIOD;
@@ -319,34 +318,12 @@
 		restart_timer.expires = jiffies+IDT77105_RESTART_TIMER_PERIOD;
 		restart_timer.function = idt77105_restart_timer_func;
 		add_timer(&restart_timer);
-		return 0;
 	}
 	spin_unlock_irqrestore(&idt77105_priv_lock, flags);
 	return 0;
 }
 
 
-static const struct atmphy_ops idt77105_ops = {
-	.start = 	idt77105_start,
-	.ioctl =	idt77105_ioctl,
-	.interrupt =	idt77105_int,
-	.stop =		idt77105_stop,
-};
-
-
-int __init idt77105_init(struct atm_dev *dev)
-{
-	dev->phy = &idt77105_ops;
-	return 0;
-}
-
-
-/*
- * TODO: this function should be called through phy_ops
- * but that will not be possible for some time as there is
- * currently a freeze on modifying that structure
- * -- Greg Banks, 13 Sep 1999
- */
 int idt77105_stop(struct atm_dev *dev)
 {
 	struct idt77105_priv *walk, *prev;
@@ -376,24 +353,29 @@
 }
 
 
+static const struct atmphy_ops idt77105_ops = {
+	.start = 	idt77105_start,
+	.ioctl =	idt77105_ioctl,
+	.interrupt =	idt77105_int,
+	.stop =		idt77105_stop,
+};
 
-EXPORT_SYMBOL(idt77105_init);
-
-MODULE_LICENSE("GPL");
-
-#ifdef MODULE
 
-int init_module(void)
+int idt77105_init(struct atm_dev *dev)
 {
+	dev->phy = &idt77105_ops;
 	return 0;
 }
 
+EXPORT_SYMBOL(idt77105_init);
 
-void cleanup_module(void)
+static void __exit idt77105_exit(void)
 {
         /* turn off timers */
         del_timer(&stats_timer);
         del_timer(&restart_timer);
 }
 
-#endif
+module_exit(idt77105_exit);
+
+MODULE_LICENSE("GPL");
Index: linux/drivers/atm/idt77105.h
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/idt77105.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 idt77105.h
--- linux/drivers/atm/idt77105.h	20 Feb 2003 13:45:03 -0000	1.1.1.1
+++ linux/drivers/atm/idt77105.h	5 Mar 2003 00:34:51 -0000
@@ -76,8 +76,7 @@
 #define IDT77105_CTRSEL_RHEC	0x01	/* W, Rx HEC Error Counter */
 
 #ifdef __KERNEL__
-int idt77105_init(struct atm_dev *dev) __init;
-int idt77105_stop(struct atm_dev *dev);
+int idt77105_init(struct atm_dev *dev);
 #endif
 
 /*
Index: linux/drivers/atm/suni.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/suni.c,v
retrieving revision 1.3
diff -u -r1.3 suni.c
--- linux/drivers/atm/suni.c	26 Feb 2003 15:43:30 -0000	1.3
+++ linux/drivers/atm/suni.c	5 Mar 2003 01:04:15 -0000
@@ -307,24 +307,6 @@
 	return 0;
 }
 
-
 EXPORT_SYMBOL(suni_init);
 
-
 MODULE_LICENSE("GPL");
-
-#ifdef MODULE
-
-
-int init_module(void)
-{
-	return 0;
-}
-
-
-void cleanup_module(void)
-{
-	/* Nay */
-}
-
-#endif

