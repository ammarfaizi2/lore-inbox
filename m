Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425333AbWLHK2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425333AbWLHK2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 05:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425336AbWLHK2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 05:28:18 -0500
Received: from amsfep16-int.chello.nl ([62.179.120.11]:43214 "EHLO
	amsfep16-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425333AbWLHK2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 05:28:17 -0500
Subject: [PATCH] uml:
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: torvalds <torvalds@osdl.org>, Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 11:20:34 +0100
Message-Id: <1165573234.32332.15.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fixup the work on stack and exit scope trouble by placing the work_struct in
the uml_net_private data.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/um/drivers/net_kern.c |   15 +++++++++------
 arch/um/include/net_kern.h |    2 ++
 2 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6-git/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6-git.orig/arch/um/drivers/net_kern.c	2006-12-08 10:32:56.000000000 +0100
+++ linux-2.6-git/arch/um/drivers/net_kern.c	2006-12-08 11:14:28.000000000 +0100
@@ -72,9 +72,11 @@ static int uml_net_rx(struct net_device 
 	return pkt_len;
 }
 
-static void uml_dev_close(void* dev)
+static void uml_dev_close(struct work_struct *work)
 {
-	dev_close( (struct net_device *) dev);
+	struct uml_net_private *lp =
+		container_of(work, struct uml_net_private, work);
+	dev_close(lp->dev);
 }
 
 irqreturn_t uml_net_interrupt(int irq, void *dev_id)
@@ -89,7 +91,6 @@ irqreturn_t uml_net_interrupt(int irq, v
 	spin_lock(&lp->lock);
 	while((err = uml_net_rx(dev)) > 0) ;
 	if(err < 0) {
-		DECLARE_WORK(close_work, uml_dev_close, dev);
 		printk(KERN_ERR 
 		       "Device '%s' read returned %d, shutting it down\n", 
 		       dev->name, err);
@@ -97,9 +98,10 @@ irqreturn_t uml_net_interrupt(int irq, v
 		 * again lp->lock.
 		 * And dev_close() can be safely called multiple times on the
 		 * same device, since it tests for (dev->flags & IFF_UP). So
-		 * there's no harm in delaying the device shutdown. */
-		schedule_work(&close_work);
-#error this is not permitted - close_work will go out of scope
+		 * there's no harm in delaying the device shutdown.
+		 * Furthermore, the workqueue will not re-enqueue an already
+		 * enqueued work item. */
+		schedule_work(&lp->work);
 		goto out;
 	}
 	reactivate_fd(lp->fd, UM_ETH_IRQ);
@@ -366,6 +368,7 @@ static int eth_configure(int n, void *in
 	/* This points to the transport private data. It's still clear, but we
 	 * must memset it to 0 *now*. Let's help the drivers. */
 	memset(lp, 0, size);
+	INIT_WORK(&lp->work, uml_dev_close);
 
 	/* sysfs register */
 	if (!driver_registered) {
Index: linux-2.6-git/arch/um/include/net_kern.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/net_kern.h	2006-12-08 10:55:25.000000000 +0100
+++ linux-2.6-git/arch/um/include/net_kern.h	2006-12-08 11:00:26.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/skbuff.h>
 #include <linux/socket.h>
 #include <linux/list.h>
+#include <linux/workqueue.h>
 
 struct uml_net {
 	struct list_head list;
@@ -26,6 +27,7 @@ struct uml_net_private {
 	struct net_device *dev;
 	struct timer_list tl;
 	struct net_device_stats stats;
+	struct work_struct work;
 	int fd;
 	unsigned char mac[ETH_ALEN];
 	unsigned short (*protocol)(struct sk_buff *);


