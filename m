Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbUCKQFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUCKQEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:04:47 -0500
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:55906 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261451AbUCKQEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:04:23 -0500
Subject: [PATCH] 2.6.4 synclinkmp.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1079021063.1950.10.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Mar 2004 10:04:24 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for synclinkmp.c against 2.6.4

* Track driver API changes
* Remove cast (kernel janitor)
* Replace page_free call with kfree (to match kmalloc allocation)

Please apply.

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.4/drivers/char/synclinkmp.c	2004-03-11 08:37:38.000000000 -0600
+++ linux-2.6.4-mg1/drivers/char/synclinkmp.c	2004-03-11 08:46:21.000000000 -0600
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.14 2003/09/05 15:26:03 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.19 2004/03/08 15:29:23 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -494,7 +494,7 @@
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.14 $";
+static char *driver_version = "$Revision: 4.19 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -1653,11 +1653,12 @@
 	info->if_ptr = &info->pppdev;
 	info->netdev = info->pppdev.dev = d;
 
-	sppp_attach(&info->pppdev);
-
 	d->irq = info->irq_level;
 	d->priv = info;
 
+	sppp_attach(&info->pppdev);
+	cb_setup(d);
+
 	if (register_netdev(d)) {
 		printk(KERN_WARNING "%s: register_netdev failed.\n", d->name);
 		sppp_detach(info->netdev);
@@ -1828,7 +1829,7 @@
 
 static int sppp_cb_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	SLMP_INFO *info = (SLMP_INFO *)dev->priv;
+	SLMP_INFO *info = dev->priv;
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):ioctl %s cmd=%08X\n", __FILE__,__LINE__,
 			info->netname, cmd );
@@ -2604,7 +2605,7 @@
 	del_timer(&info->status_timer);
 
 	if (info->tx_buf) {
-		free_page((unsigned long) info->tx_buf);
+		kfree(info->tx_buf);
 		info->tx_buf = 0;
 	}
 



