Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVIHW0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVIHW0T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVIHW0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:26:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:40638 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965050AbVIHWW5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:57 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] W1: w1_netlink: New init/fini netlink callbacks.
In-Reply-To: <20050905214431.GA5897@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:40 -0700
Message-Id: <11262181602327@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] W1: w1_netlink: New init/fini netlink callbacks.

They are guarded with NETLINK_DISABLE compile time options,
so if CONFIG_NET is disabled, no linking errors occur.
Bug noticed by Adrian Bunk <bunk@stusta.de>.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2d8331792ea3f5ccfd147288afba148537337019
tree 7d144ae862363a5fd6bfa031cca04a42cc79d879
parent 1b11d78cf87a7014f96e5b7fa2e1233cc8081a00
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Wed, 27 Jul 2005 13:10:11 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:25 -0700

 drivers/w1/w1_int.c     |   16 ++++++----------
 drivers/w1/w1_netlink.c |   26 ++++++++++++++++++++++++++
 drivers/w1/w1_netlink.h |    2 ++
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -88,17 +88,14 @@ static struct w1_master * w1_alloc_dev(u
 
 	dev->groups = 1;
 	dev->seq = 1;
-	dev->nls = netlink_kernel_create(NETLINK_W1, 1, NULL, THIS_MODULE);
-	if (!dev->nls) {
-		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
-			NETLINK_NFLOG, dev->dev.bus_id);
-	}
+	dev_init_netlink(dev);
 
 	err = device_register(&dev->dev);
 	if (err) {
 		printk(KERN_ERR "Failed to register master device. err=%d\n", err);
-		if (dev->nls && dev->nls->sk_socket)
-			sock_release(dev->nls->sk_socket);
+
+		dev_fini_netlink(dev);
+
 		memset(dev, 0, sizeof(struct w1_master));
 		kfree(dev);
 		dev = NULL;
@@ -107,11 +104,10 @@ static struct w1_master * w1_alloc_dev(u
 	return dev;
 }
 
-static void w1_free_dev(struct w1_master *dev)
+void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
-	if (dev->nls && dev->nls->sk_socket)
-		sock_release(dev->nls->sk_socket);
+	dev_fini_netlink(dev);
 	memset(dev, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
 	kfree(dev);
 }
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -57,10 +57,36 @@ void w1_netlink_send(struct w1_master *d
 nlmsg_failure:
 	return;
 }
+
+int dev_init_netlink(struct w1_master *dev)
+{
+	dev->nls = netlink_kernel_create(NETLINK_W1, 1, NULL, THIS_MODULE);
+	if (!dev->nls) {
+		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
+			NETLINK_W1, dev->dev.bus_id);
+	}
+
+	return 0;
+}
+
+void dev_fini_netlink(struct w1_master *dev)
+{
+	if (dev->nls && dev->nls->sk_socket)
+		sock_release(dev->nls->sk_socket);
+}
 #else
 #warning Netlink support is disabled. Please compile with NET support enabled.
 
 void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
 {
 }
+
+int dev_init_netlink(struct w1_master *dev)
+{
+	return 0;
+}
+
+void dev_fini_netlink(struct w1_master *dev)
+{
+}
 #endif
diff --git a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
--- a/drivers/w1/w1_netlink.h
+++ b/drivers/w1/w1_netlink.h
@@ -52,6 +52,8 @@ struct w1_netlink_msg
 #ifdef __KERNEL__
 
 void w1_netlink_send(struct w1_master *, struct w1_netlink_msg *);
+int dev_init_netlink(struct w1_master *dev);
+void dev_fini_netlink(struct w1_master *dev);
 
 #endif /* __KERNEL__ */
 #endif /* __W1_NETLINK_H */

