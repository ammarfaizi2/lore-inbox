Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbTCTPLp>; Thu, 20 Mar 2003 10:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261537AbTCTPKR>; Thu, 20 Mar 2003 10:10:17 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:10918 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S261532AbTCTPJg>; Thu, 20 Mar 2003 10:09:36 -0500
Message-Id: <200303201520.h2KFK1Gi027610@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] cleanup nicstar, suni and idt77105 
In-reply-to: Your message of "Thu, 20 Mar 2003 00:29:04 PST."
             <20030320.002904.73362328.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 20 Mar 2003 10:20:01 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030320.002904.73362328.davem@redhat.com>,"David S. Miller" writes
:
>Can you send the correct patch for all three drivers not just
>the idt77105 parts?

ok.

>It really isn't rocket science to send patches properly.  When I say

errare humanum est.

Index: linux/drivers/atm/nicstar.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/nicstar.c,v
retrieving revision 1.1.1.1
diff -b -B -u -r1.1.1.1 nicstar.c
--- linux/drivers/atm/nicstar.c	20 Feb 2003 13:45:03 -0000	1.1.1.1
+++ linux/drivers/atm/nicstar.c	17 Mar 2003 19:50:30 -0000
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
Index: linux/drivers/atm/suni.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/suni.c,v
retrieving revision 1.1.1.2
diff -b -B -u -r1.1.1.2 suni.c
--- linux/drivers/atm/suni.c	17 Mar 2003 18:38:25 -0000	1.1.1.2
+++ linux/drivers/atm/suni.c	17 Mar 2003 19:50:31 -0000
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
Index: linux/drivers/atm/idt77105.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/idt77105.c,v
retrieving revision 1.1.1.1
diff -b -B -u -r1.1.1.1 idt77105.c
--- linux/drivers/atm/idt77105.c	20 Feb 2003 13:45:03 -0000	1.1.1.1
+++ linux/drivers/atm/idt77105.c	17 Mar 2003 19:50:30 -0000
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/capability.h>
 #include <linux/atm_idt77105.h>
+#include <linux/spinlock.h>
 #include <asm/system.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
@@ -38,6 +39,7 @@
         unsigned char old_mcr;          /* storage of MCR reg while signal lost */
 };
 
+static spinlock_t idt77105_priv_lock = SPIN_LOCK_UNLOCKED;
 
 #define PRIV(dev) ((struct idt77105_priv *) dev->phy_data)
 
@@ -144,12 +146,11 @@
 	unsigned long flags;
 	struct idt77105_stats stats;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&idt77105_priv_lock, flags);
 	memcpy(&stats, &PRIV(dev)->stats, sizeof(struct idt77105_stats));
 	if (zero)
 		memset(&PRIV(dev)->stats, 0, sizeof(struct idt77105_stats));
-	restore_flags(flags);
+	spin_unlock_irqrestore(&idt77105_priv_lock, flags);
 	if (arg == NULL)
 		return 0;
 	return copy_to_user(arg, &PRIV(dev)->stats,
@@ -267,11 +268,10 @@
 	if (!(PRIV(dev) = kmalloc(sizeof(struct idt77105_priv),GFP_KERNEL)))
 		return -ENOMEM;
 	PRIV(dev)->dev = dev;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&idt77105_priv_lock, flags);
 	PRIV(dev)->next = idt77105_all;
 	idt77105_all = PRIV(dev);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&idt77105_priv_lock, flags);
 	memset(&PRIV(dev)->stats,0,sizeof(struct idt77105_stats));
         
         /* initialise dev->signal from Good Signal Bit */
@@ -305,11 +305,9 @@
 	idt77105_stats_timer_func(0); /* clear 77105 counters */
 	(void) fetch_stats(dev,NULL,1); /* clear kernel counters */
         
-	cli();
-	if (!start_timer) restore_flags(flags);
-	else {
+	spin_lock_irqsave(&idt77105_priv_lock, flags);
+	if (start_timer) {
 		start_timer = 0;
-		restore_flags(flags);
                 
 		init_timer(&stats_timer);
 		stats_timer.expires = jiffies+IDT77105_STATS_TIMER_PERIOD;
@@ -321,32 +319,11 @@
 		restart_timer.function = idt77105_restart_timer_func;
 		add_timer(&restart_timer);
 	}
+	spin_unlock_irqrestore(&idt77105_priv_lock, flags);
 	return 0;
 }
 
 
-static const struct atmphy_ops idt77105_ops = {
-	idt77105_start,
-	idt77105_ioctl,
-	idt77105_int
-};
-
-
-int __init idt77105_init(struct atm_dev *dev)
-{
-	MOD_INC_USE_COUNT;
-
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
@@ -372,30 +349,33 @@
             }
         }
 
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
 
+static const struct atmphy_ops idt77105_ops = {
+	.start = 	idt77105_start,
+	.ioctl =	idt77105_ioctl,
+	.interrupt =	idt77105_int,
+	.stop =		idt77105_stop,
+};
 
-EXPORT_SYMBOL(idt77105_init);
-EXPORT_SYMBOL(idt77105_stop);
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
