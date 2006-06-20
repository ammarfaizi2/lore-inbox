Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWFTLvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWFTLvs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWFTLvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:51:42 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53121 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030234AbWFTLvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:51:11 -0400
Message-Id: <20060620114832.031166000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:11 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Markus.Lidel@shadowconnect.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/13] I2O: Bugfixes to get I2O working again
Content-Disposition: inline; filename=i2o-bugfixes-to-get-i2o-working-again.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Markus Lidel <Markus.Lidel@shadowconnect.com>

- Fixed locking of struct i2o_exec_wait in Executive-OSM

- Removed LCT Notify in i2o_exec_probe() which caused freeing memory and
  accessing freed memory during first enumeration of I2O devices

- Added missing locking in i2o_exec_lct_notify()

- removed put_device() of I2O controller in i2o_iop_remove() which caused
  the controller structure get freed to early

- Fixed size of mempool in i2o_iop_alloc()

- Fixed access to freed memory in i2o_msg_get()

See http://bugzilla.kernel.org/show_bug.cgi?id=6561

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/message/i2o/exec-osm.c |   72 +++++++++++++++++++++--------------------
 drivers/message/i2o/iop.c      |    4 --
 include/linux/i2o.h            |    5 ++
 3 files changed, 42 insertions(+), 39 deletions(-)

--- linux-2.6.16.21.orig/drivers/message/i2o/exec-osm.c
+++ linux-2.6.16.21/drivers/message/i2o/exec-osm.c
@@ -55,6 +55,7 @@ struct i2o_exec_wait {
 	u32 m;			/* message id */
 	struct i2o_message *msg;	/* pointer to the reply message */
 	struct list_head list;	/* node in global wait list */
+	spinlock_t lock;	/* lock before modifying */
 };
 
 /* Exec OSM class handling definition */
@@ -80,6 +81,7 @@ static struct i2o_exec_wait *i2o_exec_wa
 		return NULL;
 
 	INIT_LIST_HEAD(&wait->list);
+	spin_lock_init(&wait->lock);
 
 	return wait;
 };
@@ -118,6 +120,7 @@ int i2o_msg_post_wait_mem(struct i2o_con
 	DECLARE_WAIT_QUEUE_HEAD(wq);
 	struct i2o_exec_wait *wait;
 	static u32 tcntxt = 0x80000000;
+	long flags;
 	int rc = 0;
 
 	wait = i2o_exec_wait_alloc();
@@ -139,33 +142,28 @@ int i2o_msg_post_wait_mem(struct i2o_con
 	wait->tcntxt = tcntxt++;
 	msg->u.s.tcntxt = cpu_to_le32(wait->tcntxt);
 
+	wait->wq = &wq;
+	/*
+	 * we add elements to the head, because if a entry in the list will
+	 * never be removed, we have to iterate over it every time
+	 */
+	list_add(&wait->list, &i2o_exec_wait_list);
+
 	/*
 	 * Post the message to the controller. At some point later it will
 	 * return. If we time out before it returns then complete will be zero.
 	 */
 	i2o_msg_post(c, msg);
 
-	if (!wait->complete) {
-		wait->wq = &wq;
-		/*
-		 * we add elements add the head, because if a entry in the list
-		 * will never be removed, we have to iterate over it every time
-		 */
-		list_add(&wait->list, &i2o_exec_wait_list);
-
-		wait_event_interruptible_timeout(wq, wait->complete,
-						 timeout * HZ);
+	wait_event_interruptible_timeout(wq, wait->complete, timeout * HZ);
 
-		wait->wq = NULL;
-	}
+	spin_lock_irqsave(&wait->lock, flags);
 
-	barrier();
+	wait->wq = NULL;
 
-	if (wait->complete) {
+	if (wait->complete)
 		rc = le32_to_cpu(wait->msg->body[0]) >> 24;
-		i2o_flush_reply(c, wait->m);
-		i2o_exec_wait_free(wait);
-	} else {
+	else {
 		/*
 		 * We cannot remove it now. This is important. When it does
 		 * terminate (which it must do if the controller has not
@@ -179,6 +177,13 @@ int i2o_msg_post_wait_mem(struct i2o_con
 		rc = -ETIMEDOUT;
 	}
 
+	spin_unlock_irqrestore(&wait->lock, flags);
+
+	if (rc != -ETIMEDOUT) {
+		i2o_flush_reply(c, wait->m);
+		i2o_exec_wait_free(wait);
+	}
+
 	return rc;
 };
 
@@ -206,7 +211,6 @@ static int i2o_msg_post_wait_complete(st
 {
 	struct i2o_exec_wait *wait, *tmp;
 	unsigned long flags;
-	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
 	int rc = 1;
 
 	/*
@@ -216,23 +220,24 @@ static int i2o_msg_post_wait_complete(st
 	 * already expired. Not much we can do about that except log it for
 	 * debug purposes, increase timeout, and recompile.
 	 */
-	spin_lock_irqsave(&lock, flags);
 	list_for_each_entry_safe(wait, tmp, &i2o_exec_wait_list, list) {
 		if (wait->tcntxt == context) {
-			list_del(&wait->list);
+			spin_lock_irqsave(&wait->lock, flags);
 
-			spin_unlock_irqrestore(&lock, flags);
+			list_del(&wait->list);
 
 			wait->m = m;
 			wait->msg = msg;
 			wait->complete = 1;
 
-			barrier();
-
-			if (wait->wq) {
-				wake_up_interruptible(wait->wq);
+			if (wait->wq)
 				rc = 0;
-			} else {
+			else
+				rc = -1;
+
+			spin_unlock_irqrestore(&wait->lock, flags);
+
+			if (rc) {
 				struct device *dev;
 
 				dev = &c->pdev->dev;
@@ -241,15 +246,13 @@ static int i2o_msg_post_wait_complete(st
 					 c->name);
 				i2o_dma_free(dev, &wait->dma);
 				i2o_exec_wait_free(wait);
-				rc = -1;
-			}
+			} else
+				wake_up_interruptible(wait->wq);
 
 			return rc;
 		}
 	}
 
-	spin_unlock_irqrestore(&lock, flags);
-
 	osm_warn("%s: Bogus reply in POST WAIT (tr-context: %08x)!\n", c->name,
 		 context);
 
@@ -315,14 +318,9 @@ static DEVICE_ATTR(product_id, S_IRUGO, 
 static int i2o_exec_probe(struct device *dev)
 {
 	struct i2o_device *i2o_dev = to_i2o_device(dev);
-	struct i2o_controller *c = i2o_dev->iop;
 
 	i2o_event_register(i2o_dev, &i2o_exec_driver, 0, 0xffffffff);
 
-	c->exec = i2o_dev;
-
-	i2o_exec_lct_notify(c, c->lct->change_ind + 1);
-
 	device_create_file(dev, &dev_attr_vendor_id);
 	device_create_file(dev, &dev_attr_product_id);
 
@@ -510,6 +508,8 @@ static int i2o_exec_lct_notify(struct i2
 	struct device *dev;
 	struct i2o_message *msg;
 
+	down(&c->lct_lock);
+
 	dev = &c->pdev->dev;
 
 	if (i2o_dma_realloc
@@ -532,6 +532,8 @@ static int i2o_exec_lct_notify(struct i2
 
 	i2o_msg_post(c, msg);
 
+	up(&c->lct_lock);
+
 	return 0;
 };
 
--- linux-2.6.16.21.orig/drivers/message/i2o/iop.c
+++ linux-2.6.16.21/drivers/message/i2o/iop.c
@@ -804,8 +804,6 @@ void i2o_iop_remove(struct i2o_controlle
 
 	/* Ask the IOP to switch to RESET state */
 	i2o_iop_reset(c);
-
-	put_device(&c->device);
 }
 
 /**
@@ -1059,7 +1057,7 @@ struct i2o_controller *i2o_iop_alloc(voi
 
 	snprintf(poolname, sizeof(poolname), "i2o_%s_msg_inpool", c->name);
 	if (i2o_pool_alloc
-	    (&c->in_msg, poolname, I2O_INBOUND_MSG_FRAME_SIZE * 4,
+	    (&c->in_msg, poolname, I2O_INBOUND_MSG_FRAME_SIZE * 4 + sizeof(u32),
 	     I2O_MSG_INPOOL_MIN)) {
 		kfree(c);
 		return ERR_PTR(-ENOMEM);
--- linux-2.6.16.21.orig/include/linux/i2o.h
+++ linux-2.6.16.21/include/linux/i2o.h
@@ -1116,8 +1116,11 @@ static inline struct i2o_message *i2o_ms
 
 	mmsg->mfa = readl(c->in_port);
 	if (unlikely(mmsg->mfa >= c->in_queue.len)) {
+		u32 mfa = mmsg->mfa;
+
 		mempool_free(mmsg, c->in_msg.mempool);
-		if(mmsg->mfa == I2O_QUEUE_EMPTY)
+
+		if (mfa == I2O_QUEUE_EMPTY)
 			return ERR_PTR(-EBUSY);
 		return ERR_PTR(-EFAULT);
 	}

--
