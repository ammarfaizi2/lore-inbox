Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWBGCXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWBGCXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWBGCWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:22:51 -0500
Received: from [198.99.130.12] ([198.99.130.12]:17899 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964939AbWBGCWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:22:48 -0500
Message-Id: <200602070224.k172O0oH009669@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/8] UML - Balance list_add and list_del in the network driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Feb 2006 21:24:00 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The network driver added an interface to the "opened" list when it was
configured, not when it was brought up, and removed it when it was taken
down.  A sequence of ifconfig up, ifconfig down, ... caused it to be removed
multiple times from the list without being added in between, resulting in
a crash.  This patch moves the add to when the interface is brought up.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/net_kern.c	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/net_kern.c	2006-02-06 17:35:58.000000000 -0500
@@ -131,9 +131,8 @@ static int uml_net_open(struct net_devic
 			     SA_INTERRUPT | SA_SHIRQ, dev->name, dev);
 	if(err != 0){
 		printk(KERN_ERR "uml_net_open: failed to get irq(%d)\n", err);
-		if(lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
-		lp->fd = -1;
 		err = -ENETUNREACH;
+		goto out_close;
 	}
 
 	lp->tl.data = (unsigned long) &lp->user;
@@ -145,9 +144,19 @@ static int uml_net_open(struct net_devic
 	 */
 	while((err = uml_net_rx(dev)) > 0) ;
 
- out:
 	spin_unlock(&lp->lock);
-	return(err);
+
+	spin_lock(&opened_lock);
+	list_add(&lp->list, &opened);
+	spin_unlock(&opened_lock);
+
+	return 0;
+out_close:
+	if(lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
+	lp->fd = -1;
+out:
+	spin_unlock(&lp->lock);
+	return err;
 }
 
 static int uml_net_close(struct net_device *dev)
@@ -161,9 +170,13 @@ static int uml_net_close(struct net_devi
 	if(lp->close != NULL)
 		(*lp->close)(lp->fd, &lp->user);
 	lp->fd = -1;
-	list_del(&lp->list);
 
 	spin_unlock(&lp->lock);
+
+	spin_lock(&opened_lock);
+	list_del(&lp->list);
+	spin_unlock(&opened_lock);
+
 	return 0;
 }
 
@@ -410,11 +423,7 @@ static int eth_configure(int n, void *in
 	if (device->have_mac)
 		set_ether_mac(dev, device->mac);
 
-	spin_lock(&opened_lock);
-	list_add(&lp->list, &opened);
-	spin_unlock(&opened_lock);
-
-	return(0);
+	return 0;
 }
 
 static struct uml_net *find_device(int n)

