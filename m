Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUGXW17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUGXW17 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 18:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUGXW17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 18:27:59 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45281 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262837AbUGXW1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 18:27:52 -0400
Date: Sun, 25 Jul 2004 00:25:18 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-velocity problem
Message-ID: <20040725002518.A14684@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.44.0407242015350.4553-100000@wit.wit.mht.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0407242015350.4553-100000@wit.wit.mht.bme.hu>; from ferenc.kubinszky@wit.mht.bme.hu on Sat, Jul 24, 2004 at 08:31:26PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu> :
[...]
> It seems to me that the problem is caused by "ifup -a". There is a screen
> shot (sorry I'm lazy to type in).
> 
> http://wit.mht.bme.hu/~kubi/kernelpanic_via-velocity.jpg
> 
> How can I test the driver more precisely?

It looks like the suspect (eth0) registers an event notifier and goes
foobar when the other interface (lo) triggers an NETDEV_UP.

Can you try the (gross) patch below against 2.6.8-rc1-mm1 ?

diff -puN drivers/net/via-velocity.c~via-velocity-wol-strangeness drivers/net/via-velocity.c
--- linux-2.6.8-rc1/drivers/net/via-velocity.c~via-velocity-wol-strangeness	2004-07-25 00:18:20.000000000 +0200
+++ linux-2.6.8-rc1-fr/drivers/net/via-velocity.c	2004-07-25 00:18:20.000000000 +0200
@@ -262,6 +262,7 @@ static u32 check_connection_type(struct 
 static int velocity_set_media_mode(struct velocity_info *vptr, u32 mii_status);
 
 #ifdef CONFIG_PM
+
 static int velocity_suspend(struct pci_dev *pdev, u32 state);
 static int velocity_resume(struct pci_dev *pdev);
 
@@ -270,9 +271,26 @@ static int velocity_netdev_event(struct 
 static struct notifier_block velocity_inetaddr_notifier = {
       .notifier_call	= velocity_netdev_event,
 };
-static int velocity_notifier_registered;
 
-#endif				/* CONFIG_PM */
+static spinlock_t velocity_dev_list_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(velocity_dev_list);
+
+static void velocity_register_notifier(void)
+{
+	register_inetaddr_notifier(&velocity_inetaddr_notifier);
+}
+
+static void velocity_unregister_notifier(void)
+{
+	unregister_inetaddr_notifier(&velocity_inetaddr_notifier);
+}
+
+#else				/* CONFIG_PM */
+
+#define velocity_register_notifier()	do {} while (0)
+#define velocity_unregister_notifier()	do {} while (0)
+
+#endif				/* !CONFIG_PM */
 
 /*
  *	Internal board variants. At the moment we have only one
@@ -327,6 +345,14 @@ static void __devexit velocity_remove1(s
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct velocity_info *vptr = dev->priv;
 
+#ifdef CONFIG_PM
+	unsigned long flags;
+
+	spin_lock_irqsave(&velocity_dev_list_lock, flags);
+	if (!list_empty(&velocity_dev_list))
+		list_del(&vptr->list);
+	spin_unlock_irqrestore(&velocity_dev_list_lock, flags);
+#endif
 	unregister_netdev(dev);
 	iounmap(vptr->mac_regs);
 	pci_release_regions(pdev);
@@ -782,13 +808,16 @@ static int __devinit velocity_found1(str
 	/* and leave the chip powered down */
 	
 	pci_set_power_state(pdev, 3);
-out:
 #ifdef CONFIG_PM
-	if (ret == 0 && !velocity_notifier_registered) {
-		velocity_notifier_registered = 1;
-		register_inetaddr_notifier(&velocity_inetaddr_notifier);
+	{
+		unsigned long flags;
+
+		spin_lock_irqsave(&velocity_dev_list_lock, flags);
+		list_add(&vptr->list, &velocity_dev_list);
+		spin_unlock_irqrestore(&velocity_dev_list_lock, flags);
 	}
 #endif
+out:
 	return ret;
 
 err_iounmap:
@@ -843,6 +872,8 @@ static void __devinit velocity_init_info
 
 	spin_lock_init(&vptr->lock);
 	spin_lock_init(&vptr->xmit_lock);
+
+	INIT_LIST_HEAD(&vptr->list);
 }
 
 /**
@@ -2211,8 +2242,11 @@ static struct pci_driver velocity_driver
 static int __init velocity_init_module(void)
 {
 	int ret;
-	ret = pci_module_init(&velocity_driver);
 
+	velocity_register_notifier();
+	ret = pci_module_init(&velocity_driver);
+	if (ret < 0)
+		velocity_unregister_notifier();
 	return ret;
 }
 
@@ -2227,12 +2261,7 @@ static int __init velocity_init_module(v
  
 static void __exit velocity_cleanup_module(void)
 {
-#ifdef CONFIG_PM
-	if (velocity_notifier_registered) {
-		unregister_inetaddr_notifier(&velocity_inetaddr_notifier);
-		velocity_notifier_registered = 0;
-	}
-#endif
+	velocity_unregister_notifier();
 	pci_unregister_driver(&velocity_driver);
 }
 
@@ -3252,13 +3281,20 @@ static int velocity_resume(struct pci_de
 static int velocity_netdev_event(struct notifier_block *nb, unsigned long notification, void *ptr)
 {
 	struct in_ifaddr *ifa = (struct in_ifaddr *) ptr;
-	struct net_device *dev;
-	struct velocity_info *vptr;
 
 	if (ifa) {
-		dev = ifa->ifa_dev->dev;
-		vptr = dev->priv;
-		velocity_get_ip(vptr);
+		struct net_device *dev = ifa->ifa_dev->dev;
+		struct velocity_info *vptr;
+		unsigned long flags;
+
+		spin_lock_irqsave(&velocity_dev_list_lock, flags);
+		list_for_each_entry(vptr, &velocity_dev_list, list) {
+			if (vptr->dev == dev) {
+				velocity_get_ip(vptr);
+				break;
+			}
+		}
+		spin_unlock_irqrestore(&velocity_dev_list_lock, flags);
 	}
 	return NOTIFY_DONE;
 }
diff -puN drivers/net/via-velocity.h~via-velocity-wol-strangeness drivers/net/via-velocity.h
--- linux-2.6.8-rc1/drivers/net/via-velocity.h~via-velocity-wol-strangeness	2004-07-25 00:18:20.000000000 +0200
+++ linux-2.6.8-rc1-fr/drivers/net/via-velocity.h	2004-07-25 00:18:20.000000000 +0200
@@ -1733,8 +1733,7 @@ struct velocity_opt {
 };
 
 struct velocity_info {
-	struct velocity_info *next;
-	struct velocity_info *prev;
+	struct list_head list;
 
 	struct pci_dev *pdev;
 	struct net_device *dev;

_
