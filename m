Return-Path: <linux-kernel-owner+w=401wt.eu-S932729AbXARXF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbXARXF1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 18:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbXARXF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 18:05:26 -0500
Received: from mail.pxnet.com ([195.227.45.3]:34775 "EHLO lx1.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932729AbXARXF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 18:05:26 -0500
Date: Fri, 19 Jan 2007 00:05:14 +0100
Message-Id: <200701182305.l0IN5EJg010779@lx1.pxnet.com>
From: Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 2.6.20-rc5] Gigaset ISDN driver error handling fixes (resend)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@osdl.org>
CC: Hansjoerg Lipp <hjlipp@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies if anyone is getting this more than once. I still haven't
seen it appear on the list after two attempts, so I'm sending it again,
this time through a different server.

Subject: [PATCH] Gigaset ISDN driver error handling fixes
From: Tilman Schmidt <tilman@imap.cc>

Fix several flaws in the error handling of the Siemens Gigaset ISDN
driver, including one that would cause an Oops when connecting more
than one device of the same type.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>

---

--- linux-2.6.20-rc5-orig/drivers/isdn/gigaset/common.c	2007-01-15 00:50:22.000000000 +0100
+++ linux-2.6.20-rc5-work/drivers/isdn/gigaset/common.c	2007-01-17 11:45:44.000000000 +0100
@@ -356,16 +356,17 @@ static struct cardstate *alloc_cs(struct
 {
 	unsigned long flags;
 	unsigned i;
-	static struct cardstate *ret = NULL;
+	struct cardstate *ret = NULL;
 
 	spin_lock_irqsave(&drv->lock, flags);
 	for (i = 0; i < drv->minors; ++i) {
 		if (!(drv->flags[i] & VALID_MINOR)) {
-			drv->flags[i] = VALID_MINOR;
-			ret = drv->cs + i;
-		}
-		if (ret)
+			if (try_module_get(drv->owner)) {
+				drv->flags[i] = VALID_MINOR;
+				ret = drv->cs + i;
+			}
 			break;
+		}
 	}
 	spin_unlock_irqrestore(&drv->lock, flags);
 	return ret;
@@ -376,6 +377,8 @@ static void free_cs(struct cardstate *cs
 	unsigned long flags;
 	struct gigaset_driver *drv = cs->driver;
 	spin_lock_irqsave(&drv->lock, flags);
+	if (drv->flags[cs->minor_index] & VALID_MINOR)
+		module_put(drv->owner);
 	drv->flags[cs->minor_index] = 0;
 	spin_unlock_irqrestore(&drv->lock, flags);
 }
@@ -579,7 +582,7 @@ static struct bc_state *gigaset_initbcs(
 	} else if ((bcs->skb = dev_alloc_skb(SBUFSIZE + HW_HDR_LEN)) != NULL)
 		skb_reserve(bcs->skb, HW_HDR_LEN);
 	else {
-		warn("could not allocate skb\n");
+		warn("could not allocate skb");
 		bcs->inputstate |= INS_skip_frame;
 	}
 
@@ -632,17 +635,25 @@ struct cardstate *gigaset_initcs(struct 
 	int i;
 
 	gig_dbg(DEBUG_INIT, "allocating cs");
-	cs = alloc_cs(drv);
-	if (!cs)
-		goto error;
+	if (!(cs = alloc_cs(drv))) {
+		err("maximum number of devices exceeded");
+		return NULL;
+	}
+	mutex_init(&cs->mutex);
+	mutex_lock(&cs->mutex);
+
 	gig_dbg(DEBUG_INIT, "allocating bcs[0..%d]", channels - 1);
 	cs->bcs = kmalloc(channels * sizeof(struct bc_state), GFP_KERNEL);
-	if (!cs->bcs)
+	if (!cs->bcs) {
+		err("out of memory");
 		goto error;
+	}
 	gig_dbg(DEBUG_INIT, "allocating inbuf");
 	cs->inbuf = kmalloc(sizeof(struct inbuf_t), GFP_KERNEL);
-	if (!cs->inbuf)
+	if (!cs->inbuf) {
+		err("out of memory");
 		goto error;
+	}
 
 	cs->cs_init = 0;
 	cs->channels = channels;
@@ -654,8 +665,6 @@ struct cardstate *gigaset_initcs(struct 
 	spin_lock_init(&cs->ev_lock);
 	cs->ev_tail = 0;
 	cs->ev_head = 0;
-	mutex_init(&cs->mutex);
-	mutex_lock(&cs->mutex);
 
 	tasklet_init(&cs->event_tasklet, &gigaset_handle_event,
 		     (unsigned long) cs);
@@ -684,8 +693,10 @@ struct cardstate *gigaset_initcs(struct 
 
 	for (i = 0; i < channels; ++i) {
 		gig_dbg(DEBUG_INIT, "setting up bcs[%d].read", i);
-		if (!gigaset_initbcs(cs->bcs + i, cs, i))
+		if (!gigaset_initbcs(cs->bcs + i, cs, i)) {
+			err("could not allocate channel %d data", i);
 			goto error;
+		}
 	}
 
 	++cs->cs_init;
@@ -720,8 +731,10 @@ struct cardstate *gigaset_initcs(struct 
 	make_valid(cs, VALID_ID);
 	++cs->cs_init;
 	gig_dbg(DEBUG_INIT, "setting up hw");
-	if (!cs->ops->initcshw(cs))
+	if (!cs->ops->initcshw(cs)) {
+		err("could not allocate device specific data");
 		goto error;
+	}
 
 	++cs->cs_init;
 
@@ -743,8 +756,8 @@ struct cardstate *gigaset_initcs(struct 
 	mutex_unlock(&cs->mutex);
 	return cs;
 
-error:	if (cs)
-		mutex_unlock(&cs->mutex);
+error:
+	mutex_unlock(&cs->mutex);
 	gig_dbg(DEBUG_INIT, "failed");
 	gigaset_freecs(cs);
 	return NULL;
@@ -1040,7 +1053,6 @@ void gigaset_freedriver(struct gigaset_d
 	spin_unlock_irqrestore(&driver_lock, flags);
 
 	gigaset_if_freedriver(drv);
-	module_put(drv->owner);
 
 	kfree(drv->cs);
 	kfree(drv->flags);
@@ -1072,10 +1084,6 @@ struct gigaset_driver *gigaset_initdrive
 	if (!drv)
 		return NULL;
 
-	if (!try_module_get(owner))
-		goto out1;
-
-	drv->cs = NULL;
 	drv->have_tty = 0;
 	drv->minor = minor;
 	drv->minors = minors;
@@ -1087,11 +1095,11 @@ struct gigaset_driver *gigaset_initdrive
 
 	drv->cs = kmalloc(minors * sizeof *drv->cs, GFP_KERNEL);
 	if (!drv->cs)
-		goto out2;
+		goto error;
 
 	drv->flags = kmalloc(minors * sizeof *drv->flags, GFP_KERNEL);
 	if (!drv->flags)
-		goto out3;
+		goto error;
 
 	for (i = 0; i < minors; ++i) {
 		drv->flags[i] = 0;
@@ -1108,11 +1116,8 @@ struct gigaset_driver *gigaset_initdrive
 
 	return drv;
 
-out3:
+error:
 	kfree(drv->cs);
-out2:
-	module_put(owner);
-out1:
 	kfree(drv);
 	return NULL;
 }
