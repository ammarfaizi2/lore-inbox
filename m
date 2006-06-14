Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWFNOIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWFNOIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWFNOI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:08:29 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:17838 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S964972AbWFNOIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:08:22 -0400
Date: Wed, 14 Jun 2006 16:08:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [patch 23/24] s390: rework of channel measurement facility.
Message-ID: <20060614140824.GX9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] rework of channel measurement facility.

Fixes for several channel measurement facility bugs:
* Blocks copied from the hardware might not be consistent. Solve this
  by moving the copying into idle state and repeating the copying.
* avg_sample_interval changed with every read, even though no new block
  was available. Solve this by storing a timestamp when the last new
  block was received.
* Several locking issues.
* Measurements were not reenabled after a disconnected device became
  available again.
* Remove #defines for ioctls that were never implemented.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cmf.c        |  623 ++++++++++++++++++++++++++++++------------
 drivers/s390/cio/device.h     |    4 
 drivers/s390/cio/device_fsm.c |   18 +
 include/asm-s390/cmb.h        |    4 
 4 files changed, 468 insertions(+), 181 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/cmf.c linux-2.6-patched/drivers/s390/cio/cmf.c
--- linux-2.6/drivers/s390/cio/cmf.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cmf.c	2006-06-14 14:30:04.000000000 +0200
@@ -3,9 +3,10 @@
  *
  * Linux on zSeries Channel Measurement Facility support
  *
- * Copyright 2000,2003 IBM Corporation
+ * Copyright 2000,2006 IBM Corporation
  *
- * Author: Arnd Bergmann <arndb@de.ibm.com>
+ * Authors: Arnd Bergmann <arndb@de.ibm.com>
+ *	    Cornelia Huck <cornelia.huck@de.ibm.com>
  *
  * original idea from Natarajan Krishnaswami <nkrishna@us.ibm.com>
  *
@@ -96,9 +97,9 @@ module_param(format, bool, 0444);
 /**
  * struct cmb_operations - functions to use depending on cmb_format
  *
- * all these functions operate on a struct cmf_device. There is only
- * one instance of struct cmb_operations because all cmf_device
- * objects are guaranteed to be of the same type.
+ * Most of these functions operate on a struct ccw_device. There is only
+ * one instance of struct cmb_operations because the format of the measurement
+ * data is guaranteed to be the same for every ccw_device.
  *
  * @alloc:	allocate memory for a channel measurement block,
  *		either with the help of a special pool or with kmalloc
@@ -107,6 +108,7 @@ module_param(format, bool, 0444);
  * @readall:	read a measurement block in a common format
  * @reset:	clear the data in the associated measurement block and
  *		reset its time stamp
+ * @align:	align an allocated block so that the hardware can use it
  */
 struct cmb_operations {
 	int (*alloc)  (struct ccw_device*);
@@ -115,11 +117,19 @@ struct cmb_operations {
 	u64 (*read)   (struct ccw_device*, int);
 	int (*readall)(struct ccw_device*, struct cmbdata *);
 	void (*reset) (struct ccw_device*);
+	void * (*align) (void *);
 
 	struct attribute_group *attr_group;
 };
 static struct cmb_operations *cmbops;
 
+struct cmb_data {
+	void *hw_block;   /* Pointer to block updated by hardware */
+	void *last_block; /* Last changed block copied from hardware block */
+	int size;	  /* Size of hw_block and last_block */
+	unsigned long long last_update;  /* when last_block was updated */
+};
+
 /* our user interface is designed in terms of nanoseconds,
  * while the hardware measures total times in its own
  * unit.*/
@@ -226,63 +236,229 @@ struct set_schib_struct {
 	unsigned long address;
 	wait_queue_head_t wait;
 	int ret;
+	struct kref kref;
 };
 
+static void cmf_set_schib_release(struct kref *kref)
+{
+	struct set_schib_struct *set_data;
+
+	set_data = container_of(kref, struct set_schib_struct, kref);
+	kfree(set_data);
+}
+
+#define CMF_PENDING 1
+
 static int set_schib_wait(struct ccw_device *cdev, u32 mme,
 				int mbfc, unsigned long address)
 {
-	struct set_schib_struct s = {
-		.mme = mme,
-		.mbfc = mbfc,
-		.address = address,
-		.wait = __WAIT_QUEUE_HEAD_INITIALIZER(s.wait),
-	};
+	struct set_schib_struct *set_data;
+	int ret;
 
 	spin_lock_irq(cdev->ccwlock);
-	s.ret = set_schib(cdev, mme, mbfc, address);
-	if (s.ret != -EBUSY) {
-		goto out_nowait;
+	if (!cdev->private->cmb) {
+		ret = -ENODEV;
+		goto out;
 	}
+	set_data = kzalloc(sizeof(struct set_schib_struct), GFP_ATOMIC);
+	if (!set_data) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	init_waitqueue_head(&set_data->wait);
+	kref_init(&set_data->kref);
+	set_data->mme = mme;
+	set_data->mbfc = mbfc;
+	set_data->address = address;
+
+	ret = set_schib(cdev, mme, mbfc, address);
+	if (ret != -EBUSY)
+		goto out_put;
 
 	if (cdev->private->state != DEV_STATE_ONLINE) {
-		s.ret = -EBUSY;
 		/* if the device is not online, don't even try again */
-		goto out_nowait;
+		ret = -EBUSY;
+		goto out_put;
 	}
+
 	cdev->private->state = DEV_STATE_CMFCHANGE;
-	cdev->private->cmb_wait = &s;
-	s.ret = 1;
+	set_data->ret = CMF_PENDING;
+	cdev->private->cmb_wait = set_data;
 
 	spin_unlock_irq(cdev->ccwlock);
-	if (wait_event_interruptible(s.wait, s.ret != 1)) {
+	if (wait_event_interruptible(set_data->wait,
+				     set_data->ret != CMF_PENDING)) {
 		spin_lock_irq(cdev->ccwlock);
-		if (s.ret == 1) {
-			s.ret = -ERESTARTSYS;
-			cdev->private->cmb_wait = 0;
+		if (set_data->ret == CMF_PENDING) {
+			set_data->ret = -ERESTARTSYS;
 			if (cdev->private->state == DEV_STATE_CMFCHANGE)
 				cdev->private->state = DEV_STATE_ONLINE;
 		}
 		spin_unlock_irq(cdev->ccwlock);
 	}
-	return s.ret;
-
-out_nowait:
+	spin_lock_irq(cdev->ccwlock);
+	cdev->private->cmb_wait = NULL;
+	ret = set_data->ret;
+out_put:
+	kref_put(&set_data->kref, cmf_set_schib_release);
+out:
 	spin_unlock_irq(cdev->ccwlock);
-	return s.ret;
+	return ret;
 }
 
 void retry_set_schib(struct ccw_device *cdev)
 {
-	struct set_schib_struct *s;
+	struct set_schib_struct *set_data;
 
-	s = cdev->private->cmb_wait;
-	cdev->private->cmb_wait = 0;
-	if (!s) {
+	set_data = cdev->private->cmb_wait;
+	if (!set_data) {
 		WARN_ON(1);
 		return;
 	}
-	s->ret = set_schib(cdev, s->mme, s->mbfc, s->address);
-	wake_up(&s->wait);
+	kref_get(&set_data->kref);
+	set_data->ret = set_schib(cdev, set_data->mme, set_data->mbfc,
+				  set_data->address);
+	wake_up(&set_data->wait);
+	kref_put(&set_data->kref, cmf_set_schib_release);
+}
+
+static int cmf_copy_block(struct ccw_device *cdev)
+{
+	struct subchannel *sch;
+	void *reference_buf;
+	void *hw_block;
+	struct cmb_data *cmb_data;
+
+	sch = to_subchannel(cdev->dev.parent);
+
+	if (stsch(sch->schid, &sch->schib))
+		return -ENODEV;
+
+	if (sch->schib.scsw.fctl & SCSW_FCTL_START_FUNC) {
+		/* Don't copy if a start function is in progress. */
+		if ((!sch->schib.scsw.actl & SCSW_ACTL_SUSPENDED) &&
+		    (sch->schib.scsw.actl &
+		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT)) &&
+		    (!sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS))
+			return -EBUSY;
+	}
+	cmb_data = cdev->private->cmb;
+	hw_block = cmbops->align(cmb_data->hw_block);
+	if (!memcmp(cmb_data->last_block, hw_block, cmb_data->size))
+		/* No need to copy. */
+		return 0;
+	reference_buf = kzalloc(cmb_data->size, GFP_ATOMIC);
+	if (!reference_buf)
+		return -ENOMEM;
+	/* Ensure consistency of block copied from hardware. */
+	do {
+		memcpy(cmb_data->last_block, hw_block, cmb_data->size);
+		memcpy(reference_buf, hw_block, cmb_data->size);
+	} while (memcmp(cmb_data->last_block, reference_buf, cmb_data->size));
+	cmb_data->last_update = get_clock();
+	kfree(reference_buf);
+	return 0;
+}
+
+struct copy_block_struct {
+	wait_queue_head_t wait;
+	int ret;
+	struct kref kref;
+};
+
+static void cmf_copy_block_release(struct kref *kref)
+{
+	struct copy_block_struct *copy_block;
+
+	copy_block = container_of(kref, struct copy_block_struct, kref);
+	kfree(copy_block);
+}
+
+static int cmf_cmb_copy_wait(struct ccw_device *cdev)
+{
+	struct copy_block_struct *copy_block;
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(cdev->ccwlock, flags);
+	if (!cdev->private->cmb) {
+		ret = -ENODEV;
+		goto out;
+	}
+	copy_block = kzalloc(sizeof(struct copy_block_struct), GFP_ATOMIC);
+	if (!copy_block) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	init_waitqueue_head(&copy_block->wait);
+	kref_init(&copy_block->kref);
+
+	ret = cmf_copy_block(cdev);
+	if (ret != -EBUSY)
+		goto out_put;
+
+	if (cdev->private->state != DEV_STATE_ONLINE) {
+		ret = -EBUSY;
+		goto out_put;
+	}
+
+	cdev->private->state = DEV_STATE_CMFUPDATE;
+	copy_block->ret = CMF_PENDING;
+	cdev->private->cmb_wait = copy_block;
+
+	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	if (wait_event_interruptible(copy_block->wait,
+				     copy_block->ret != CMF_PENDING)) {
+		spin_lock_irqsave(cdev->ccwlock, flags);
+		if (copy_block->ret == CMF_PENDING) {
+			copy_block->ret = -ERESTARTSYS;
+			if (cdev->private->state == DEV_STATE_CMFUPDATE)
+				cdev->private->state = DEV_STATE_ONLINE;
+		}
+		spin_unlock_irqrestore(cdev->ccwlock, flags);
+	}
+	spin_lock_irqsave(cdev->ccwlock, flags);
+	cdev->private->cmb_wait = NULL;
+	ret = copy_block->ret;
+out_put:
+	kref_put(&copy_block->kref, cmf_copy_block_release);
+out:
+	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	return ret;
+}
+
+void cmf_retry_copy_block(struct ccw_device *cdev)
+{
+	struct copy_block_struct *copy_block;
+
+	copy_block = cdev->private->cmb_wait;
+	if (!copy_block) {
+		WARN_ON(1);
+		return;
+	}
+	kref_get(&copy_block->kref);
+	copy_block->ret = cmf_copy_block(cdev);
+	wake_up(&copy_block->wait);
+	kref_put(&copy_block->kref, cmf_copy_block_release);
+}
+
+static void cmf_generic_reset(struct ccw_device *cdev)
+{
+	struct cmb_data *cmb_data;
+
+	spin_lock_irq(cdev->ccwlock);
+	cmb_data = cdev->private->cmb;
+	if (cmb_data) {
+		memset(cmb_data->last_block, 0, cmb_data->size);
+		/*
+		 * Need to reset hw block as well to make the hardware start
+		 * from 0 again.
+		 */
+		memset(cmbops->align(cmb_data->hw_block), 0, cmb_data->size);
+		cmb_data->last_update = 0;
+	}
+	cdev->private->cmb_start_time = get_clock();
+	spin_unlock_irq(cdev->ccwlock);
 }
 
 /**
@@ -343,8 +519,8 @@ struct cmb {
 /* insert a single device into the cmb_area list
  * called with cmb_area.lock held from alloc_cmb
  */
-static inline int
-alloc_cmb_single (struct ccw_device *cdev)
+static inline int alloc_cmb_single (struct ccw_device *cdev,
+				    struct cmb_data *cmb_data)
 {
 	struct cmb *cmb;
 	struct ccw_device_private *node;
@@ -358,10 +534,12 @@ alloc_cmb_single (struct ccw_device *cde
 
 	/* find first unused cmb in cmb_area.mem.
 	 * this is a little tricky: cmb_area.list
-	 * remains sorted by ->cmb pointers */
+	 * remains sorted by ->cmb->hw_data pointers */
 	cmb = cmb_area.mem;
 	list_for_each_entry(node, &cmb_area.list, cmb_list) {
-		if ((struct cmb*)node->cmb > cmb)
+		struct cmb_data *data;
+		data = node->cmb;
+		if ((struct cmb*)data->hw_block > cmb)
 			break;
 		cmb++;
 	}
@@ -372,7 +550,8 @@ alloc_cmb_single (struct ccw_device *cde
 
 	/* insert new cmb */
 	list_add_tail(&cdev->private->cmb_list, &node->cmb_list);
-	cdev->private->cmb = cmb;
+	cmb_data->hw_block = cmb;
+	cdev->private->cmb = cmb_data;
 	ret = 0;
 out:
 	spin_unlock_irq(cdev->ccwlock);
@@ -385,7 +564,19 @@ alloc_cmb (struct ccw_device *cdev)
 	int ret;
 	struct cmb *mem;
 	ssize_t size;
+	struct cmb_data *cmb_data;
+
+	/* Allocate private cmb_data. */
+	cmb_data = kzalloc(sizeof(struct cmb_data), GFP_KERNEL);
+	if (!cmb_data)
+		return -ENOMEM;
 
+	cmb_data->last_block = kzalloc(sizeof(struct cmb), GFP_KERNEL);
+	if (!cmb_data->last_block) {
+		kfree(cmb_data);
+		return -ENOMEM;
+	}
+	cmb_data->size = sizeof(struct cmb);
 	spin_lock(&cmb_area.lock);
 
 	if (!cmb_area.mem) {
@@ -414,29 +605,36 @@ alloc_cmb (struct ccw_device *cdev)
 	}
 
 	/* do the actual allocation */
-	ret = alloc_cmb_single(cdev);
+	ret = alloc_cmb_single(cdev, cmb_data);
 out:
 	spin_unlock(&cmb_area.lock);
-
+	if (ret) {
+		kfree(cmb_data->last_block);
+		kfree(cmb_data);
+	}
 	return ret;
 }
 
-static void
-free_cmb(struct ccw_device *cdev)
+static void free_cmb(struct ccw_device *cdev)
 {
 	struct ccw_device_private *priv;
-
-	priv = cdev->private;
+	struct cmb_data *cmb_data;
 
 	spin_lock(&cmb_area.lock);
 	spin_lock_irq(cdev->ccwlock);
 
+	priv = cdev->private;
+
 	if (list_empty(&priv->cmb_list)) {
 		/* already freed */
 		goto out;
 	}
 
+	cmb_data = priv->cmb;
 	priv->cmb = NULL;
+	if (cmb_data)
+		kfree(cmb_data->last_block);
+	kfree(cmb_data);
 	list_del_init(&priv->cmb_list);
 
 	if (list_empty(&cmb_area.list)) {
@@ -451,83 +649,97 @@ out:
 	spin_unlock(&cmb_area.lock);
 }
 
-static int
-set_cmb(struct ccw_device *cdev, u32 mme)
+static int set_cmb(struct ccw_device *cdev, u32 mme)
 {
 	u16 offset;
+	struct cmb_data *cmb_data;
+	unsigned long flags;
 
-	if (!cdev->private->cmb)
+	spin_lock_irqsave(cdev->ccwlock, flags);
+	if (!cdev->private->cmb) {
+		spin_unlock_irqrestore(cdev->ccwlock, flags);
 		return -EINVAL;
-
-	offset = mme ? (struct cmb *)cdev->private->cmb - cmb_area.mem : 0;
+	}
+	cmb_data = cdev->private->cmb;
+	offset = mme ? (struct cmb *)cmb_data->hw_block - cmb_area.mem : 0;
+	spin_unlock_irqrestore(cdev->ccwlock, flags);
 
 	return set_schib_wait(cdev, mme, 0, offset);
 }
 
-static u64
-read_cmb (struct ccw_device *cdev, int index)
+static u64 read_cmb (struct ccw_device *cdev, int index)
 {
-	/* yes, we have to put it on the stack
-	 * because the cmb must only be accessed
-	 * atomically, e.g. with mvc */
-	struct cmb cmb;
-	unsigned long flags;
+	struct cmb *cmb;
 	u32 val;
+	int ret;
+	unsigned long flags;
+
+	ret = cmf_cmb_copy_wait(cdev);
+	if (ret < 0)
+		return 0;
 
 	spin_lock_irqsave(cdev->ccwlock, flags);
 	if (!cdev->private->cmb) {
-		spin_unlock_irqrestore(cdev->ccwlock, flags);
-		return 0;
+		ret = 0;
+		goto out;
 	}
-
-	cmb = *(struct cmb*)cdev->private->cmb;
-	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	cmb = ((struct cmb_data *)cdev->private->cmb)->last_block;
 
 	switch (index) {
 	case cmb_ssch_rsch_count:
-		return cmb.ssch_rsch_count;
+		ret = cmb->ssch_rsch_count;
+		goto out;
 	case cmb_sample_count:
-		return cmb.sample_count;
+		ret = cmb->sample_count;
+		goto out;
 	case cmb_device_connect_time:
-		val = cmb.device_connect_time;
+		val = cmb->device_connect_time;
 		break;
 	case cmb_function_pending_time:
-		val = cmb.function_pending_time;
+		val = cmb->function_pending_time;
 		break;
 	case cmb_device_disconnect_time:
-		val = cmb.device_disconnect_time;
+		val = cmb->device_disconnect_time;
 		break;
 	case cmb_control_unit_queuing_time:
-		val = cmb.control_unit_queuing_time;
+		val = cmb->control_unit_queuing_time;
 		break;
 	case cmb_device_active_only_time:
-		val = cmb.device_active_only_time;
+		val = cmb->device_active_only_time;
 		break;
 	default:
-		return 0;
+		ret = 0;
+		goto out;
 	}
-	return time_to_avg_nsec(val, cmb.sample_count);
+	ret = time_to_avg_nsec(val, cmb->sample_count);
+out:
+	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	return ret;
 }
 
-static int
-readall_cmb (struct ccw_device *cdev, struct cmbdata *data)
+static int readall_cmb (struct ccw_device *cdev, struct cmbdata *data)
 {
-	/* yes, we have to put it on the stack
-	 * because the cmb must only be accessed
-	 * atomically, e.g. with mvc */
-	struct cmb cmb;
-	unsigned long flags;
+	struct cmb *cmb;
+	struct cmb_data *cmb_data;
 	u64 time;
+	unsigned long flags;
+	int ret;
 
+	ret = cmf_cmb_copy_wait(cdev);
+	if (ret < 0)
+		return ret;
 	spin_lock_irqsave(cdev->ccwlock, flags);
-	if (!cdev->private->cmb) {
-		spin_unlock_irqrestore(cdev->ccwlock, flags);
-		return -ENODEV;
+	cmb_data = cdev->private->cmb;
+	if (!cmb_data) {
+		ret = -ENODEV;
+		goto out;
 	}
-
-	cmb = *(struct cmb*)cdev->private->cmb;
-	time = get_clock() - cdev->private->cmb_start_time;
-	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	if (cmb_data->last_update == 0) {
+		ret = -EAGAIN;
+		goto out;
+	}
+	cmb = cmb_data->last_block;
+	time = cmb_data->last_update - cdev->private->cmb_start_time;
 
 	memset(data, 0, sizeof(struct cmbdata));
 
@@ -538,31 +750,32 @@ readall_cmb (struct ccw_device *cdev, st
 	data->elapsed_time = (time * 1000) >> 12;
 
 	/* copy data to new structure */
-	data->ssch_rsch_count = cmb.ssch_rsch_count;
-	data->sample_count = cmb.sample_count;
+	data->ssch_rsch_count = cmb->ssch_rsch_count;
+	data->sample_count = cmb->sample_count;
 
 	/* time fields are converted to nanoseconds while copying */
-	data->device_connect_time = time_to_nsec(cmb.device_connect_time);
-	data->function_pending_time = time_to_nsec(cmb.function_pending_time);
-	data->device_disconnect_time = time_to_nsec(cmb.device_disconnect_time);
+	data->device_connect_time = time_to_nsec(cmb->device_connect_time);
+	data->function_pending_time = time_to_nsec(cmb->function_pending_time);
+	data->device_disconnect_time =
+		time_to_nsec(cmb->device_disconnect_time);
 	data->control_unit_queuing_time
-		= time_to_nsec(cmb.control_unit_queuing_time);
+		= time_to_nsec(cmb->control_unit_queuing_time);
 	data->device_active_only_time
-		= time_to_nsec(cmb.device_active_only_time);
+		= time_to_nsec(cmb->device_active_only_time);
+	ret = 0;
+out:
+	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	return ret;
+}
 
-	return 0;
+static void reset_cmb(struct ccw_device *cdev)
+{
+	cmf_generic_reset(cdev);
 }
 
-static void
-reset_cmb(struct ccw_device *cdev)
+static void * align_cmb(void *area)
 {
-	struct cmb *cmb;
-	spin_lock_irq(cdev->ccwlock);
-	cmb = cdev->private->cmb;
-	if (cmb)
-		memset (cmb, 0, sizeof (*cmb));
-	cdev->private->cmb_start_time = get_clock();
-	spin_unlock_irq(cdev->ccwlock);
+	return area;
 }
 
 static struct attribute_group cmf_attr_group;
@@ -574,6 +787,7 @@ static struct cmb_operations cmbops_basi
 	.read	= read_cmb,
 	.readall    = readall_cmb,
 	.reset	    = reset_cmb,
+	.align	    = align_cmb,
 	.attr_group = &cmf_attr_group,
 };
 
@@ -610,22 +824,34 @@ static inline struct cmbe* cmbe_align(st
 	return (struct cmbe*)addr;
 }
 
-static int
-alloc_cmbe (struct ccw_device *cdev)
+static int alloc_cmbe (struct ccw_device *cdev)
 {
 	struct cmbe *cmbe;
-	cmbe = kmalloc (sizeof (*cmbe) * 2, GFP_KERNEL);
+	struct cmb_data *cmb_data;
+	int ret;
+
+	cmbe = kzalloc (sizeof (*cmbe) * 2, GFP_KERNEL);
 	if (!cmbe)
 		return -ENOMEM;
-
+	cmb_data = kzalloc(sizeof(struct cmb_data), GFP_KERNEL);
+	if (!cmb_data) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	cmb_data->last_block = kzalloc(sizeof(struct cmbe), GFP_KERNEL);
+	if (!cmb_data->last_block) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	cmb_data->size = sizeof(struct cmbe);
 	spin_lock_irq(cdev->ccwlock);
 	if (cdev->private->cmb) {
-		kfree(cmbe);
 		spin_unlock_irq(cdev->ccwlock);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_free;
 	}
-
-	cdev->private->cmb = cmbe;
+	cmb_data->hw_block = cmbe;
+	cdev->private->cmb = cmb_data;
 	spin_unlock_irq(cdev->ccwlock);
 
 	/* activate global measurement if this is the first channel */
@@ -636,14 +862,24 @@ alloc_cmbe (struct ccw_device *cdev)
 	spin_unlock(&cmb_area.lock);
 
 	return 0;
+out_free:
+	if (cmb_data)
+		kfree(cmb_data->last_block);
+	kfree(cmb_data);
+	kfree(cmbe);
+	return ret;
 }
 
-static void
-free_cmbe (struct ccw_device *cdev)
+static void free_cmbe (struct ccw_device *cdev)
 {
+	struct cmb_data *cmb_data;
+
 	spin_lock_irq(cdev->ccwlock);
-	kfree(cdev->private->cmb);
+	cmb_data = cdev->private->cmb;
 	cdev->private->cmb = NULL;
+	if (cmb_data)
+		kfree(cmb_data->last_block);
+	kfree(cmb_data);
 	spin_unlock_irq(cdev->ccwlock);
 
 	/* deactivate global measurement if this is the last channel */
@@ -654,89 +890,105 @@ free_cmbe (struct ccw_device *cdev)
 	spin_unlock(&cmb_area.lock);
 }
 
-static int
-set_cmbe(struct ccw_device *cdev, u32 mme)
+static int set_cmbe(struct ccw_device *cdev, u32 mme)
 {
 	unsigned long mba;
+	struct cmb_data *cmb_data;
+	unsigned long flags;
 
-	if (!cdev->private->cmb)
+	spin_lock_irqsave(cdev->ccwlock, flags);
+	if (!cdev->private->cmb) {
+		spin_unlock_irqrestore(cdev->ccwlock, flags);
 		return -EINVAL;
-	mba = mme ? (unsigned long) cmbe_align(cdev->private->cmb) : 0;
+	}
+	cmb_data = cdev->private->cmb;
+	mba = mme ? (unsigned long) cmbe_align(cmb_data->hw_block) : 0;
+	spin_unlock_irqrestore(cdev->ccwlock, flags);
 
 	return set_schib_wait(cdev, mme, 1, mba);
 }
 
 
-u64
-read_cmbe (struct ccw_device *cdev, int index)
+static u64 read_cmbe (struct ccw_device *cdev, int index)
 {
-	/* yes, we have to put it on the stack
-	 * because the cmb must only be accessed
-	 * atomically, e.g. with mvc */
-	struct cmbe cmb;
-	unsigned long flags;
+	struct cmbe *cmb;
+	struct cmb_data *cmb_data;
 	u32 val;
+	int ret;
+	unsigned long flags;
 
-	spin_lock_irqsave(cdev->ccwlock, flags);
-	if (!cdev->private->cmb) {
-		spin_unlock_irqrestore(cdev->ccwlock, flags);
+	ret = cmf_cmb_copy_wait(cdev);
+	if (ret < 0)
 		return 0;
-	}
 
-	cmb = *cmbe_align(cdev->private->cmb);
-	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	spin_lock_irqsave(cdev->ccwlock, flags);
+	cmb_data = cdev->private->cmb;
+	if (!cmb_data) {
+		ret = 0;
+		goto out;
+	}
+	cmb = cmb_data->last_block;
 
 	switch (index) {
 	case cmb_ssch_rsch_count:
-		return cmb.ssch_rsch_count;
+		ret = cmb->ssch_rsch_count;
+		goto out;
 	case cmb_sample_count:
-		return cmb.sample_count;
+		ret = cmb->sample_count;
+		goto out;
 	case cmb_device_connect_time:
-		val = cmb.device_connect_time;
+		val = cmb->device_connect_time;
 		break;
 	case cmb_function_pending_time:
-		val = cmb.function_pending_time;
+		val = cmb->function_pending_time;
 		break;
 	case cmb_device_disconnect_time:
-		val = cmb.device_disconnect_time;
+		val = cmb->device_disconnect_time;
 		break;
 	case cmb_control_unit_queuing_time:
-		val = cmb.control_unit_queuing_time;
+		val = cmb->control_unit_queuing_time;
 		break;
 	case cmb_device_active_only_time:
-		val = cmb.device_active_only_time;
+		val = cmb->device_active_only_time;
 		break;
 	case cmb_device_busy_time:
-		val = cmb.device_busy_time;
+		val = cmb->device_busy_time;
 		break;
 	case cmb_initial_command_response_time:
-		val = cmb.initial_command_response_time;
+		val = cmb->initial_command_response_time;
 		break;
 	default:
-		return 0;
+		ret = 0;
+		goto out;
 	}
-	return time_to_avg_nsec(val, cmb.sample_count);
+	ret = time_to_avg_nsec(val, cmb->sample_count);
+out:
+	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	return ret;
 }
 
-static int
-readall_cmbe (struct ccw_device *cdev, struct cmbdata *data)
+static int readall_cmbe (struct ccw_device *cdev, struct cmbdata *data)
 {
-	/* yes, we have to put it on the stack
-	 * because the cmb must only be accessed
-	 * atomically, e.g. with mvc */
-	struct cmbe cmb;
-	unsigned long flags;
+	struct cmbe *cmb;
+	struct cmb_data *cmb_data;
 	u64 time;
+	unsigned long flags;
+	int ret;
 
+	ret = cmf_cmb_copy_wait(cdev);
+	if (ret < 0)
+		return ret;
 	spin_lock_irqsave(cdev->ccwlock, flags);
-	if (!cdev->private->cmb) {
-		spin_unlock_irqrestore(cdev->ccwlock, flags);
-		return -ENODEV;
+	cmb_data = cdev->private->cmb;
+	if (!cmb_data) {
+		ret = -ENODEV;
+		goto out;
 	}
-
-	cmb = *cmbe_align(cdev->private->cmb);
-	time = get_clock() - cdev->private->cmb_start_time;
-	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	if (cmb_data->last_update == 0) {
+		ret = -EAGAIN;
+		goto out;
+	}
+	time = cmb_data->last_update - cdev->private->cmb_start_time;
 
 	memset (data, 0, sizeof(struct cmbdata));
 
@@ -746,35 +998,38 @@ readall_cmbe (struct ccw_device *cdev, s
 	/* conver to nanoseconds */
 	data->elapsed_time = (time * 1000) >> 12;
 
+	cmb = cmb_data->last_block;
 	/* copy data to new structure */
-	data->ssch_rsch_count = cmb.ssch_rsch_count;
-	data->sample_count = cmb.sample_count;
+	data->ssch_rsch_count = cmb->ssch_rsch_count;
+	data->sample_count = cmb->sample_count;
 
 	/* time fields are converted to nanoseconds while copying */
-	data->device_connect_time = time_to_nsec(cmb.device_connect_time);
-	data->function_pending_time = time_to_nsec(cmb.function_pending_time);
-	data->device_disconnect_time = time_to_nsec(cmb.device_disconnect_time);
+	data->device_connect_time = time_to_nsec(cmb->device_connect_time);
+	data->function_pending_time = time_to_nsec(cmb->function_pending_time);
+	data->device_disconnect_time =
+		time_to_nsec(cmb->device_disconnect_time);
 	data->control_unit_queuing_time
-		= time_to_nsec(cmb.control_unit_queuing_time);
+		= time_to_nsec(cmb->control_unit_queuing_time);
 	data->device_active_only_time
-		= time_to_nsec(cmb.device_active_only_time);
-	data->device_busy_time = time_to_nsec(cmb.device_busy_time);
+		= time_to_nsec(cmb->device_active_only_time);
+	data->device_busy_time = time_to_nsec(cmb->device_busy_time);
 	data->initial_command_response_time
-		= time_to_nsec(cmb.initial_command_response_time);
+		= time_to_nsec(cmb->initial_command_response_time);
 
-	return 0;
+	ret = 0;
+out:
+	spin_unlock_irqrestore(cdev->ccwlock, flags);
+	return ret;
 }
 
-static void
-reset_cmbe(struct ccw_device *cdev)
+static void reset_cmbe(struct ccw_device *cdev)
 {
-	struct cmbe *cmb;
-	spin_lock_irq(cdev->ccwlock);
-	cmb = cmbe_align(cdev->private->cmb);
-	if (cmb)
-		memset (cmb, 0, sizeof (*cmb));
-	cdev->private->cmb_start_time = get_clock();
-	spin_unlock_irq(cdev->ccwlock);
+	cmf_generic_reset(cdev);
+}
+
+static void * align_cmbe(void *area)
+{
+	return cmbe_align(area);
 }
 
 static struct attribute_group cmf_attr_group_ext;
@@ -786,6 +1041,7 @@ static struct cmb_operations cmbops_exte
 	.read	    = read_cmbe,
 	.readall    = readall_cmbe,
 	.reset	    = reset_cmbe,
+	.align	    = align_cmbe,
 	.attr_group = &cmf_attr_group_ext,
 };
 
@@ -803,14 +1059,19 @@ cmb_show_avg_sample_interval(struct devi
 	struct ccw_device *cdev;
 	long interval;
 	unsigned long count;
+	struct cmb_data *cmb_data;
 
 	cdev = to_ccwdev(dev);
-	interval  = get_clock() - cdev->private->cmb_start_time;
 	count = cmf_read(cdev, cmb_sample_count);
-	if (count)
+	spin_lock_irq(cdev->ccwlock);
+	cmb_data = cdev->private->cmb;
+	if (count) {
+		interval = cmb_data->last_update -
+			cdev->private->cmb_start_time;
 		interval /= count;
-	else
+	} else
 		interval = -1;
+	spin_unlock_irq(cdev->ccwlock);
 	return sprintf(buf, "%ld\n", interval);
 }
 
@@ -823,7 +1084,10 @@ cmb_show_avg_utilization(struct device *
 	int ret;
 
 	ret = cmf_readall(to_ccwdev(dev), &data);
-	if (ret)
+	if (ret == -EAGAIN || ret == -ENODEV)
+		/* No data (yet/currently) available to use for calculation. */
+		return sprintf(buf, "n/a\n");
+	else if (ret)
 		return ret;
 
 	utilization = data.device_connect_time +
@@ -982,6 +1246,13 @@ cmf_readall(struct ccw_device *cdev, str
 	return cmbops->readall(cdev, data);
 }
 
+/* Reenable cmf when a disconnected device becomes available again. */
+int cmf_reenable(struct ccw_device *cdev)
+{
+	cmbops->reset(cdev);
+	return cmbops->set(cdev, 2);
+}
+
 static int __init
 init_cmf(void)
 {
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-06-14 14:30:04.000000000 +0200
@@ -336,8 +336,11 @@ ccw_device_oper_notify(void *data)
 	if (!ret)
 		/* Driver doesn't want device back. */
 		ccw_device_do_unreg_rereg((void *)cdev);
-	else
+	else {
+		/* Reenable channel measurements, if needed. */
+		cmf_reenable(cdev);
 		wake_up(&cdev->private->wait_q);
+	}
 }
 
 /*
@@ -1093,6 +1096,13 @@ ccw_device_change_cmfstate(struct ccw_de
 	dev_fsm_event(cdev, dev_event);
 }
 
+static void ccw_device_update_cmfblock(struct ccw_device *cdev,
+				       enum dev_event dev_event)
+{
+	cmf_retry_copy_block(cdev);
+	cdev->private->state = DEV_STATE_ONLINE;
+	dev_fsm_event(cdev, dev_event);
+}
 
 static void
 ccw_device_quiesce_done(struct ccw_device *cdev, enum dev_event dev_event)
@@ -1247,6 +1257,12 @@ fsm_func_t *dev_jumptable[NR_DEV_STATES]
 		[DEV_EVENT_TIMEOUT]	= ccw_device_change_cmfstate,
 		[DEV_EVENT_VERIFY]	= ccw_device_change_cmfstate,
 	},
+	[DEV_STATE_CMFUPDATE] = {
+		[DEV_EVENT_NOTOPER]	= ccw_device_update_cmfblock,
+		[DEV_EVENT_INTERRUPT]	= ccw_device_update_cmfblock,
+		[DEV_EVENT_TIMEOUT]	= ccw_device_update_cmfblock,
+		[DEV_EVENT_VERIFY]	= ccw_device_update_cmfblock,
+	},
 };
 
 /*
diff -urpN linux-2.6/drivers/s390/cio/device.h linux-2.6-patched/drivers/s390/cio/device.h
--- linux-2.6/drivers/s390/cio/device.h	2006-06-14 14:29:41.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.h	2006-06-14 14:30:04.000000000 +0200
@@ -27,6 +27,7 @@ enum dev_state {
 	DEV_STATE_DISCONNECTED,
 	DEV_STATE_DISCONNECTED_SENSE_ID,
 	DEV_STATE_CMFCHANGE,
+	DEV_STATE_CMFUPDATE,
 	/* last element! */
 	NR_DEV_STATES
 };
@@ -118,5 +119,8 @@ int ccw_device_stlck(struct ccw_device *
 void ccw_device_set_timeout(struct ccw_device *, int);
 extern struct subchannel_id ccw_device_get_subchannel_id(struct ccw_device *);
 
+/* Channel measurement facility related */
 void retry_set_schib(struct ccw_device *cdev);
+void cmf_retry_copy_block(struct ccw_device *);
+int cmf_reenable(struct ccw_device *);
 #endif
diff -urpN linux-2.6/include/asm-s390/cmb.h linux-2.6-patched/include/asm-s390/cmb.h
--- linux-2.6/include/asm-s390/cmb.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/cmb.h	2006-06-14 14:30:04.000000000 +0200
@@ -44,10 +44,6 @@ struct cmbdata {
 #define BIODASDCMFENABLE	_IO(DASD_IOCTL_LETTER,32)
 /* enable channel measurement */
 #define BIODASDCMFDISABLE	_IO(DASD_IOCTL_LETTER,33)
-/* reset channel measurement block */
-#define BIODASDRESETCMB		_IO(DASD_IOCTL_LETTER,34)
-/* read channel measurement data */
-#define BIODASDREADCMB		_IOWR(DASD_IOCTL_LETTER,32,u64)
 /* read channel measurement data */
 #define BIODASDREADALLCMB	_IOWR(DASD_IOCTL_LETTER,33,struct cmbdata)
 
