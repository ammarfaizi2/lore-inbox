Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWARAaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWARAaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWARAaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:30:24 -0500
Received: from [151.97.230.9] ([151.97.230.9]:11491 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964919AbWARA1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:27:37 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/9] uml: fix spinlock recursion and sleep-inside-spinlock in error path
Date: Wed, 18 Jan 2006 01:19:33 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118001931.14622.17211.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

In this error path, when the interface has had a problem, we call dev_close(),
which is disallowed for two reasons:

*) takes again the UML internal spinlock, inside the ->stop method of this
   device
*) can be called in process context only, while we're in interrupt context.

I've also thought that calling dev_close() may be a wrong policy to follow, but
it's not up to me to decide that.

However, we may end up with multiple dev_close() queued on the same device.
But the initial test for (dev->flags & IFF_UP) makes this harmless, though -
and dev_close() is supposed to care about races with itself. So there's no harm
in delaying the shutdown, IMHO.

Something to mark the interface as "going to shutdown" would be appreciated, but
dev_deactivate has the same problems as dev_close(), so we can't use it either.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_kern.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 98350bb..178f68b 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -68,6 +68,11 @@ static int uml_net_rx(struct net_device 
 	return pkt_len;
 }
 
+static void uml_dev_close(void* dev)
+{
+	dev_close( (struct net_device *) dev);
+}
+
 irqreturn_t uml_net_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_id;
@@ -80,15 +85,21 @@ irqreturn_t uml_net_interrupt(int irq, v
 	spin_lock(&lp->lock);
 	while((err = uml_net_rx(dev)) > 0) ;
 	if(err < 0) {
+		DECLARE_WORK(close_work, uml_dev_close, dev);
 		printk(KERN_ERR 
 		       "Device '%s' read returned %d, shutting it down\n", 
 		       dev->name, err);
-		dev_close(dev);
+		/* dev_close can't be called in interrupt context, and takes
+		 * again lp->lock.
+		 * And dev_close() can be safely called multiple times on the
+		 * same device, since it tests for (dev->flags & IFF_UP). So
+		 * there's no harm in delaying the device shutdown. */
+		schedule_work(&close_work);
 		goto out;
 	}
 	reactivate_fd(lp->fd, UM_ETH_IRQ);
 
- out:
+out:
 	spin_unlock(&lp->lock);
 	return(IRQ_HANDLED);
 }

