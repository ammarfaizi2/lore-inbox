Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932875AbWK0ScX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875AbWK0ScX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932934AbWK0ScX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:32:23 -0500
Received: from nebensachen.de ([195.225.107.202]:6535 "EHLO nebensachen.de")
	by vger.kernel.org with ESMTP id S932875AbWK0ScV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:32:21 -0500
X-Hashcash: 1:20:061127:jens.axboe@oracle.com::mRyZ/nUrUNoGfqPu:00000000000000000000000000000000000000002kds
X-Hashcash: 1:20:061127:pavel@ucw.cz::G1xUXU3hBki3n2JK:000007Ff6
X-Hashcash: 1:20:061127:chris@schlagmichtod.de::dSN7+CErL4zV5CO8:0000000000000000000000000000000000000004+l7
From: Elias Oltmanns <eo@nebensachen.de>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Pavel Machek <pavel@ucw.cz>, Christoph Schmid <chris@schlagmichtod.de>,
       linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
References: <7ibks-1fg-15@gated-at.bofh.it> <7kpjn-7th-23@gated-at.bofh.it>
	<7kDFF-8rd-29@gated-at.bofh.it>
X-Hashcash: 1:20:061127:linux-kernel@vger.kernel.org::FS4tBGW5qOvimDaD:0000000000000000000000000000000000T1w
Date: Mon, 27 Nov 2006 19:31:55 +0100
Message-ID: <87d5783fms.fsf@denkblock.local>
User-Agent: Gnus/5.110006 (No Gnus v0.6)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Jens Axboe <jens.axboe@oracle.com> wrote:
> On Tue, Nov 21 2006, Pavel Machek wrote:
>> Hi!
>> 
[...]
>> > After some googeling and digging in gamne i read that someone said that
>> > there are plans for some generic support for HD-parking in the kernel
>> > and thus making such patches obsolete.
[...]
>> I'm afraid we need your help with development here. Porting old patch
>> to 2.6.19-rc6 should be easy, and then you can start 'how do I
>> makethis generic' debate.
>
> 2.6.19 will finally have the generic block layer commands, so this can
> be implemented properly.

Eventually, I've ported the patch to 2.6.19-rc6 (attached). However,
I'll need some gentle guidance by you developers for the next steps,
I'm afraid. What exactly do you mean by "making this generic".
Perhaps, you could give me a hint as to which generic block layer
commands you have in mind that should be used in such a patch.


Here is a short description of what the patch does in its current
shape:

1. Adds functions to ide-disk.c and scsi_lib.c that issue an idle
   immediate with head unload or a standby immediate command as
   appropriate and stop the queue on command completion.
2. Adds matching queue unfreeze functions that also reenable hd power
   management (see source code).
3. Adds an option to the ide-disk and libata module respectively which
   allows to indicate whether idle immediate is supported by the
   drive. Unfortunately, the implemented auto detection feature often
   gives false negatives.
4. Adds a sysfs attribute chich can be used to trigger the disk park
   command and the associated queue freeze.
5. Adds an unfreeze timer that calls the unfreeze function on expiry.

Regards,

Elias

---
 block/ll_rw_blk.c         |  154 ++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c |    4
 drivers/ata/libata-scsi.c |   38 ++++++++
 drivers/ata/libata.h      |    1
 drivers/ide/ide-disk.c    |  155 ++++++++++++++++++++++++++++++++++
 drivers/ide/ide-io.c      |   14 +++
 drivers/scsi/scsi_lib.c   |  163 ++++++++++++++++++++++++++++++++++++
 include/linux/ata.h       |    1
 include/linux/blkdev.h    |   13 ++
 include/linux/ide.h       |    1
 10 files changed, 544 insertions(+)

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=hdaps_protect-2.6.19-rc6-1.patch

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 9eaee66..50e4517 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -36,10 +36,14 @@ #include <scsi/scsi_cmnd.h>
 
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
+static void blk_unfreeze_work(void *data);
+static void blk_unfreeze_timeout(unsigned long data);
 static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io);
 static void init_request_from_bio(struct request *req, struct bio *bio);
 static int __make_request(request_queue_t *q, struct bio *bio);
 static struct io_context *current_io_context(gfp_t gfp_flags, int node);
+static int blk_protect_register(request_queue_t *q);
+static void blk_protect_unregister(request_queue_t *q);
 
 /*
  * For the allocated request tables
@@ -232,6 +236,13 @@ void blk_queue_make_request(request_queu
 	q->unplug_timer.function = blk_unplug_timeout;
 	q->unplug_timer.data = (unsigned long)q;
 
+	q->max_unfreeze = 30;
+
+	INIT_WORK(&q->unfreeze_work, blk_unfreeze_work, q);
+
+	q->unfreeze_timer.function = blk_unfreeze_timeout;
+	q->unfreeze_timer.data = (unsigned long)q;
+
 	/*
 	 * by default assume old behaviour and bounce for any highmem page
 	 */
@@ -324,6 +335,18 @@ void blk_queue_issue_flush_fn(request_qu
 
 EXPORT_SYMBOL(blk_queue_issue_flush_fn);
 
+void blk_queue_issue_protect_fn(request_queue_t *q, issue_protect_fn *ipf)
+{
+       q->issue_protect_fn = ipf;
+}
+EXPORT_SYMBOL(blk_queue_issue_protect_fn);
+
+void blk_queue_issue_unprotect_fn(request_queue_t *q, issue_unprotect_fn *iuf)
+{
+       q->issue_unprotect_fn = iuf;
+}
+EXPORT_SYMBOL(blk_queue_issue_unprotect_fn);
+
 /*
  * Cache flushing for ordered writes handling
  */
@@ -1842,6 +1865,7 @@ request_queue_t *blk_alloc_queue_node(gf
 
 	memset(q, 0, sizeof(*q));
 	init_timer(&q->unplug_timer);
+	init_timer(&q->unfreeze_timer);
 
 	snprintf(q->kobj.name, KOBJ_NAME_LEN, "%s", "queue");
 	q->kobj.ktype = &queue_ktype;
@@ -3917,6 +3941,7 @@ int blk_register_queue(struct gendisk *d
 		return ret;
 	}
 
+	blk_protect_register(q);
 	return 0;
 }
 
@@ -3925,6 +3950,7 @@ void blk_unregister_queue(struct gendisk
 	request_queue_t *q = disk->queue;
 
 	if (q && q->request_fn) {
+		blk_protect_unregister(q);
 		elv_unregister_queue(q);
 
 		kobject_uevent(&q->kobj, KOBJ_REMOVE);
@@ -3932,3 +3958,131 @@ void blk_unregister_queue(struct gendisk
 		kobject_put(&disk->kobj);
 	}
 }
+
+/*
+ * Issue lower level unprotect function if no timers are pending.
+ */
+static void blk_unfreeze_work(void *data)
+{
+       request_queue_t *q = (request_queue_t *) data;
+       int pending;
+       unsigned long flags;
+
+       spin_lock_irqsave(q->queue_lock, flags);
+       pending = timer_pending(&q->unfreeze_timer);
+       spin_unlock_irqrestore(q->queue_lock, flags);
+       if (!pending)
+	       q->issue_unprotect_fn(q);
+}
+
+/*
+ * Called when the queue freeze timeout expires...
+ */
+static void blk_unfreeze_timeout(unsigned long data)
+{
+       request_queue_t *q = (request_queue_t *) data;
+
+       kblockd_schedule_work(&q->unfreeze_work);
+}
+
+/*
+ * The lower level driver parks and freezes the queue, and this block layer
+ *  function sets up the freeze timeout timer on return. If the queue is
+ *  already frozen then this is called to extend the timer...
+ */
+void blk_freeze_queue(request_queue_t *q, int seconds)
+{
+	/* Don't accept arbitrarily long freezes */
+	if (seconds >= q->max_unfreeze)
+		seconds = q->max_unfreeze;
+	/* set/reset the timer */
+	mod_timer(&q->unfreeze_timer, msecs_to_jiffies(seconds*1000) + jiffies);
+}
+
+/*
+ * When reading the 'protect' attribute, we return seconds remaining
+ * before unfreeze timeout expires
+ */
+static ssize_t queue_protect_show(struct request_queue *q, char *page)
+{
+	unsigned int seconds = 0;
+
+	spin_lock_irq(q->queue_lock);
+	if (blk_queue_stopped(q) && timer_pending(&q->unfreeze_timer))
+	   	/*
+		 * Adding 1 in order to guarantee nonzero value until timer
+		 * has actually expired.
+		 */
+		seconds = jiffies_to_msecs(q->unfreeze_timer.expires
+					   - jiffies) / 1000 + 1;
+	spin_unlock_irq(q->queue_lock);
+       return queue_var_show(seconds, (page));
+}
+
+/*
+ * When writing the 'protect' attribute, input is the number of seconds
+ * to freeze the queue for. We call a lower level helper function to
+ * park the heads and freeze/block the queue, then we make a block layer
+ * call to setup the thaw timeout. If input is 0, then we thaw the queue.
+ */
+static ssize_t queue_protect_store(struct request_queue *q, const char *page, size_t count)
+{
+	unsigned long freeze = 0;
+
+	queue_var_store(&freeze, page, count);
+
+	if(freeze>0) {
+		/* Park and freeze */
+		if (!blk_queue_stopped(q))
+		       q->issue_protect_fn(q);
+		/* set / reset the thaw timer */
+		spin_lock_irq(q->queue_lock);
+		blk_freeze_queue(q, freeze);
+		spin_unlock_irq(q->queue_lock);
+	} else {
+		spin_lock_irq(q->queue_lock);
+		freeze = del_timer(&q->unfreeze_timer);
+		spin_unlock_irq(q->queue_lock);
+		if (freeze)
+			q->issue_unprotect_fn(q);
+	}
+
+	return count;
+}
+
+static struct queue_sysfs_entry queue_protect_entry = {
+       .attr = {.name = "protect", .mode = S_IRUGO | S_IWUSR },
+       .show = queue_protect_show,
+       .store = queue_protect_store,
+};
+
+static int blk_protect_register(request_queue_t *q)
+{
+	int error = 0;
+
+	/* check that the lower level driver has a protect handler */
+	if (!q->issue_protect_fn)
+		return 1;
+
+	/* create the attribute */
+	error = sysfs_create_file(&q->kobj, &queue_protect_entry.attr);
+	if(error){
+		printk(KERN_ERR
+		       "blk_protect_register(): failed to create protect queue attribute!\n");
+		return error;
+	}
+
+	kobject_get(&q->kobj);
+	return 0;
+}
+
+static void blk_protect_unregister(request_queue_t *q)
+{
+	/* check that the lower level driver has a protect handler */
+	if (!q->issue_protect_fn)
+		return;
+
+	/* remove the attribute */
+	sysfs_remove_file(&q->kobj,&queue_protect_entry.attr);
+	kobject_put(&q->kobj);
+}
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 915a55a..df71abc 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -74,6 +74,10 @@ static struct workqueue_struct *ata_wq;
 
 struct workqueue_struct *ata_aux_wq;
 
+int libata_protect_method = 0;
+module_param_named(protect_method, libata_protect_method, int, 0444);
+MODULE_PARM_DESC(protect_method, "hdaps disk protection method (0=autodetect, 1=unload, 2=standby)");
+
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5c1fc46..8a72e12 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -841,6 +841,42 @@ static void ata_scsi_dev_config(struct s
 	}
 }
 
+extern int scsi_protect_queue(request_queue_t *q, int unload);
+extern int scsi_unprotect_queue(request_queue_t *q);
+
+static int ata_scsi_issue_protect_fn(request_queue_t *q)
+{
+	struct scsi_device *sdev = q->queuedata;
+	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev = &ap->device[sdev->id];
+	int unload;
+
+	if (libata_protect_method == 1) {
+		unload = 1;	
+		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): unload method requested, overriding drive capability check..\n");
+	}
+	else if (libata_protect_method == 2) {
+		unload = 0;	
+		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): standby method requested, overriding drive capability check..\n");
+	}
+	else if (ata_id_has_unload(dev->id)) {
+		unload = 1;
+		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): unload support reported by drive..\n");
+	}
+	else {
+		unload = 0;
+		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): unload support NOT reported by drive!..\n");
+	}
+
+	/* call scsi_protect_queue, requesting either unload or standby */
+	return scsi_protect_queue(q, unload);
+}
+
+static int ata_scsi_issue_unprotect_fn(request_queue_t *q)
+{
+	return scsi_unprotect_queue(q);
+}
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
@@ -864,6 +900,8 @@ int ata_scsi_slave_config(struct scsi_de
 
 	if (dev)
 		ata_scsi_dev_config(sdev, dev);
+	blk_queue_issue_protect_fn(sdev->request_queue, ata_scsi_issue_protect_fn);	
+	blk_queue_issue_unprotect_fn(sdev->request_queue, ata_scsi_issue_unprotect_fn);	
 
 	return 0;	/* scsi layer doesn't check return value, sigh */
 }
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0ed263b..da5b103 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -40,6 +40,7 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern struct workqueue_struct *ata_aux_wq;
+extern int libata_protect_method;
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 0a05a37..b3ff75a 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -72,6 +72,10 @@ #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/div64.h>
 
+int idedisk_protect_method = 0;
+module_param_named(protect_method, idedisk_protect_method, int, 0444);
+MODULE_PARM_DESC(protect_method, "hdaps disk protection method (0=autodetect, 1=unload, 2=standby)");
+
 struct ide_disk_obj {
 	ide_drive_t	*drive;
 	ide_driver_t	*driver;
@@ -731,6 +735,154 @@ static int idedisk_issue_flush(request_q
 }
 
 /*
+ * todo:
+ *  - we freeze the queue regardless of success and rely on the 
+ *    ide_protect_queue function to thaw immediately if the command
+ *    failed (to be consistent with the libata handler)... should 
+ *    we also inspect here?
+ */
+void ide_end_protect_rq(struct request *rq, int error)
+{
+	struct completion *waiting = rq->end_io_data;
+
+	rq->end_io_data = NULL;
+	/* spin lock already accquired */
+	if (!blk_queue_stopped(rq->q))
+		blk_stop_queue(rq->q);
+
+	complete(waiting);
+}
+
+int ide_unprotect_queue(request_queue_t *q)
+{
+	struct request rq;
+	unsigned long flags;
+	int pending = 0, rc = 0;
+	ide_drive_t *drive = q->queuedata;
+	u8 args[7], *argbuf = args;
+
+	if (!blk_queue_stopped(q))
+		return -EIO;
+
+	/* Are there any pending jobs on the queue? */
+	pending = ((q->rq.count[READ] > 0) || (q->rq.count[WRITE] > 0)) ? 1 : 0;
+	
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_start_queue(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	/* The unload feature of the IDLE_IMMEDIATE command
+	   temporarily disables HD power management from spinning down
+	   the disk. Any other command will reenable HD pm, so, if
+	   there are no pending jobs on the queue, another
+	   CHECK_POWER_MODE1 command without the unload feature should do
+	   just fine. */
+	if (!pending) {
+		printk(KERN_DEBUG "ide_unprotect_queue(): No pending I/O, re-enabling power management..\n");
+		memset(args, 0, sizeof(args));
+		argbuf[0] = 0xe5; /* CHECK_POWER_MODE1 */
+		ide_init_drive_cmd(&rq);
+		rq.cmd_type = REQ_TYPE_ATA_TASK;
+		rq.buffer = argbuf;
+		rc = ide_do_drive_cmd(drive, &rq, ide_head_wait);
+	}
+
+	return rc;
+}
+
+int ide_protect_queue(request_queue_t *q, int unload)
+{
+	ide_drive_t *drive = q->queuedata;
+	struct request rq;
+	u8 args[7], *argbuf = args;
+	int ret = 0;
+	DECLARE_COMPLETION(wait);
+
+	memset(&rq, 0, sizeof(rq));
+	memset(args, 0, sizeof(args));
+
+	if (blk_queue_stopped(q))
+		return -EIO;
+
+	if (unload) {
+		argbuf[0] = 0xe1;
+		argbuf[1] = 0x44;
+		argbuf[3] = 0x4c;
+		argbuf[4] = 0x4e;
+		argbuf[5] = 0x55;
+	} else
+		argbuf[0] = 0xe0;
+
+	/* Issue the park command & freeze */
+	ide_init_drive_cmd(&rq);
+
+	rq.cmd_type = REQ_TYPE_ATA_TASK;
+	rq.buffer = argbuf;
+	rq.end_io_data = &wait;
+	rq.end_io = ide_end_protect_rq;
+
+	ret = ide_do_drive_cmd(drive, &rq, ide_next);
+	wait_for_completion(&wait);
+
+	if (ret)
+	{
+		printk(KERN_DEBUG "ide_protect_queue(): Warning: head NOT parked!..\n");
+		ide_unprotect_queue(q);
+		return ret;
+	}
+
+	if (unload) {
+		if (args[3] == 0xc4)
+			printk(KERN_DEBUG "ide_protect_queue(): head parked..\n");
+		else {
+			/* error parking the head */
+			printk(KERN_DEBUG "ide_protect_queue(): head NOT parked!..\n");
+			ret = -EIO;
+			ide_unprotect_queue(q);
+		}
+	} else
+		printk(KERN_DEBUG "ide_protect_queue(): head park not requested, used standby!..\n");
+
+	return ret;
+}	
+
+int idedisk_issue_protect_fn(request_queue_t *q)
+{
+	ide_drive_t *drive = q->queuedata;
+	int unload;
+
+	/*
+	 * Check capability of the device -
+	 *  - if "idle immediate with unload" is supported we use that, else
+	 *    we use "standby immediate" and live with spinning down the drive..
+	 *    (Word 84, bit 13 of IDENTIFY DEVICE data)
+	 */
+	if (idedisk_protect_method == 1) {
+		unload = 1;	
+		printk(KERN_DEBUG "idedisk_issue_protect_fn(): unload method requested, overriding drive capability check..\n");
+	}
+	else if (idedisk_protect_method == 2) {
+		unload = 0;	
+		printk(KERN_DEBUG "idedisk_issue_protect_fn(): standby method requested, overriding drive capability check..\n");
+	}
+	else if (drive->id->cfsse & (1 << 13)) {
+		unload = 1;
+		printk(KERN_DEBUG "idedisk_issue_protect_fn(): unload support reported by drive..\n");
+	}
+	else {
+		unload = 0;
+		printk(KERN_DEBUG "idedisk_issue_protect_fn(): unload support NOT reported by drive!..\n");
+	}
+
+	return ide_protect_queue(q, unload);
+}
+
+int idedisk_issue_unprotect_fn(request_queue_t *q)
+{
+	return ide_unprotect_queue(q);
+}
+
+/*
  * This is tightly woven into the driver->do_special can not touch.
  * DON'T do it again until a total personality rewrite is committed.
  */
@@ -986,6 +1138,9 @@ static void idedisk_setup (ide_drive_t *
 		drive->wcache = 1;
 
 	write_cache(drive, 1);
+
+	blk_queue_issue_protect_fn(drive->queue, idedisk_issue_protect_fn);
+	blk_queue_issue_unprotect_fn(drive->queue, idedisk_issue_unprotect_fn);
 }
 
 static void ide_cacheflush_p(ide_drive_t *drive)
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 2614f41..c026ae0 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1261,6 +1261,17 @@ #endif
 		}
 
 		/*
+		 * Don't accept a request when the queue is stopped (unless we
+		 * are resuming from suspend). Prevents existing queue entries 
+		 * being processed after queue is stopped by the hard disk 
+		 * protection mechanism...
+		 */
+		if (test_bit(QUEUE_FLAG_STOPPED, &drive->queue->queue_flags) && !blk_pm_resume_request(rq)) {
+			hwgroup->busy = 0;
+			break;
+		}
+
+		/*
 		 * Sanity: don't accept a request that isn't a PM request
 		 * if we are currently power managed. This is very important as
 		 * blk_stop_queue() doesn't prevent the elv_next_request()
@@ -1744,6 +1755,9 @@ int ide_do_drive_cmd (ide_drive_t *drive
 		where = ELEVATOR_INSERT_FRONT;
 		rq->cmd_flags |= REQ_PREEMPT;
 	}
+	if (action == ide_next)
+		where = ELEVATOR_INSERT_FRONT;
+
 	__elv_add_request(drive->queue, rq, where, 0);
 	ide_do_request(hwgroup, IDE_NO_IRQ);
 	spin_unlock_irqrestore(&ide_lock, flags);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d2c02df..5ab5b0b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2258,3 +2258,166 @@ void scsi_kunmap_atomic_sg(void *virt)
 	kunmap_atomic(virt, KM_BIO_SRC_IRQ);
 }
 EXPORT_SYMBOL(scsi_kunmap_atomic_sg);
+
+/*
+ * Structure required for synchronous io completion after queue freezing
+ */
+struct scsi_protect_io_context_sync {
+	struct scsi_device *sdev;
+	int result;
+	char *sense;
+	struct completion *waiting;
+};
+
+/*
+ * scsi_protect_wait_done()
+ * Command completion handler for scsi_protect_queue().
+ *
+ * Unable to call scsi_internal_device_block() as
+ * scsi_end_request() already has the spinlock. So,
+ * we put the necessary functionality inline.
+ *
+ * todo:
+ *  - we block the queue regardless of success and rely on the
+ *    scsi_protect_queue function to unblock if the command
+ *    failed... should we also inspect here?
+ */
+static void scsi_protect_wait_done(void *data, char *sense, int result, int resid)
+{
+	struct scsi_protect_io_context_sync *siocs = data;
+	struct completion *waiting = siocs->waiting;
+	request_queue_t *q = siocs->sdev->request_queue;
+
+	siocs->waiting = NULL;
+	siocs->result = result;
+	memcpy(siocs->sense, sense, SCSI_SENSE_BUFFERSIZE);
+
+	if (!scsi_device_set_state(siocs->sdev, SDEV_BLOCK))
+		blk_stop_queue(q);
+
+	complete(waiting);
+}
+
+/*
+ * scsi_unprotect_queue()
+ *  - release the queue that was previously blocked
+ */
+int scsi_unprotect_queue(request_queue_t *q)
+{
+	struct scsi_device *sdev = q->queuedata;
+	int rc = 0, pending = 0;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	struct scsi_sense_hdr sshdr;
+
+	if (sdev->sdev_state != SDEV_BLOCK)
+		return -ENXIO;
+
+	/* Are there any pending jobs on the queue? */
+	pending = ((q->rq.count[READ] > 0) || (q->rq.count[WRITE] > 0)) ? 1 : 0;
+
+	rc = scsi_internal_device_unblock(sdev);
+	if (rc)
+		return rc;
+
+	if (!pending) {
+		printk(KERN_DEBUG "scsi_unprotect_queue(): No pending I/O, re-enabling power management..\n");
+
+		memset(scsi_cmd, 0, sizeof(scsi_cmd));
+		scsi_cmd[0]  = ATA_16;
+		scsi_cmd[1]  = (3 << 1); /* Non-data */
+		/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
+		scsi_cmd[14] = 0xe5; /* CHECK_POWER_MODE1 */
+
+		/* Good values for timeout and retries?  Values below
+   		   from scsi_ioctl_send_command() for default case... */
+		if (scsi_execute_req(sdev, scsi_cmd, DMA_NONE, NULL, 0, &sshdr,
+		   		     (10*HZ), 5))
+			rc = -EIO;
+	}
+	return rc;
+}
+EXPORT_SYMBOL_GPL(scsi_unprotect_queue);
+
+/*
+ * scsi_protect_queue()
+ *  - build and issue the park/standby command..
+ *  - queue is blocked during command completion handler
+ */
+int scsi_protect_queue(request_queue_t *q, int unload)
+{
+	struct scsi_protect_io_context_sync siocs;
+	struct scsi_device *sdev = q->queuedata;
+	int rc = 0;
+	u8 args[7];
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	unsigned char sense[SCSI_SENSE_BUFFERSIZE];
+	unsigned char *desc;
+	DECLARE_COMPLETION_ONSTACK(wait);
+
+	if (sdev->sdev_state != SDEV_RUNNING)
+		return -ENXIO;
+
+	memset(args, 0, sizeof(args));
+	memset(sense, 0, sizeof(sense));
+
+	if (unload) {
+		args[0] = 0xe1;
+		args[1] = 0x44;
+		args[3] = 0x4c;
+		args[4] = 0x4e;
+		args[5] = 0x55;
+	} else
+		args[0] = 0xe0;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+	scsi_cmd[0]  = ATA_16;
+	scsi_cmd[1]  = (3 << 1); /* Non-data */
+	scsi_cmd[2]  = 0x20;     /* no off.line, or data xfer, request cc */
+	scsi_cmd[4]  = args[1];
+	scsi_cmd[6]  = args[2];
+	scsi_cmd[8]  = args[3];
+	scsi_cmd[10] = args[4];
+	scsi_cmd[12] = args[5];
+	scsi_cmd[14] = args[0];
+	siocs.sdev = sdev;
+	siocs.sense = sense;
+	siocs.waiting = &wait;
+
+	scsi_execute_async(sdev, scsi_cmd, COMMAND_SIZE(scsi_cmd[0]),
+			   DMA_NONE, NULL, 0, 0, (10*HZ), 5,
+			   &siocs, &scsi_protect_wait_done, GFP_NOWAIT);
+	wait_for_completion(&wait);
+
+	if (siocs.result != ((DRIVER_SENSE << 24) + SAM_STAT_CHECK_CONDITION)) {
+		printk(KERN_DEBUG "scsi_protect_queue(): head NOT parked!..\n");
+		scsi_unprotect_queue(q);		/* just in case we still managed to block */
+		rc = -EIO;
+		goto out;
+	}
+
+	desc = sense + 8;
+
+	/* Retrieve data from check condition */
+	args[1] = desc[3];
+	args[2] = desc[5];
+	args[3] = desc[7];
+	args[4] = desc[9];
+	args[5] = desc[11];
+	args[0] = desc[13];
+
+	if (unload) {
+		if (args[3] == 0xc4)
+			printk(KERN_DEBUG "scsi_protect_queue(): head parked..\n");
+		else {
+			/* error parking the head */
+			printk(KERN_DEBUG "scsi_protect_queue(): head NOT parked!..\n");
+			rc = -EIO;
+			scsi_unprotect_queue(q);
+		}
+	} else
+		printk(KERN_DEBUG "scsi_protect_queue(): head park not requested, used standby!..\n");
+
+out:
+	return rc;
+}
+EXPORT_SYMBOL_GPL(scsi_protect_queue);
diff --git a/include/linux/ata.h b/include/linux/ata.h
index d894419..7b943d2 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -282,6 +282,7 @@ #define ata_id_is_sata(id)	((id)[93] == 
 #define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
 #define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
 #define ata_id_hpa_enabled(id)	((id)[85] & (1 << 10))
+#define ata_id_has_unload(id)   ((id)[84] & (1 << 13))
 #define ata_id_has_fua(id)	((id)[84] & (1 << 6))
 #define ata_id_has_flush(id)	((id)[83] & (1 << 12))
 #define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7bfcde2..6f0120c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -346,6 +346,8 @@ typedef void (activity_fn) (void *data, 
 typedef int (issue_flush_fn) (request_queue_t *, struct gendisk *, sector_t *);
 typedef void (prepare_flush_fn) (request_queue_t *, struct request *);
 typedef void (softirq_done_fn)(struct request *);
+typedef int (issue_protect_fn) (request_queue_t *);
+typedef int (issue_unprotect_fn) (request_queue_t *);
 
 enum blk_queue_state {
 	Queue_down,
@@ -388,6 +390,8 @@ struct request_queue
 	issue_flush_fn		*issue_flush_fn;
 	prepare_flush_fn	*prepare_flush_fn;
 	softirq_done_fn		*softirq_done_fn;
+	issue_protect_fn	*issue_protect_fn;
+	issue_unprotect_fn	*issue_unprotect_fn;
 
 	/*
 	 * Dispatch queue sorting
@@ -403,6 +407,13 @@ struct request_queue
 	unsigned long		unplug_delay;	/* After this many jiffies */
 	struct work_struct	unplug_work;
 
+	/*
+	 * Auto-unfreeze state
+	 */
+	struct timer_list	unfreeze_timer;
+	int			max_unfreeze;	/* At most this many seconds */
+	struct work_struct	unfreeze_work;
+
 	struct backing_dev_info	backing_dev_info;
 
 	/*
@@ -760,6 +771,8 @@ extern int blk_do_ordered(request_queue_
 extern unsigned blk_ordered_cur_seq(request_queue_t *);
 extern unsigned blk_ordered_req_seq(struct request *);
 extern void blk_ordered_complete_seq(request_queue_t *, unsigned, int);
+extern void blk_queue_issue_protect_fn(request_queue_t *, issue_protect_fn *);
+extern void blk_queue_issue_unprotect_fn(request_queue_t *, issue_unprotect_fn *);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 9c20502..8613b94 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1090,6 +1090,7 @@ extern u64 ide_get_error_location(ide_dr
  */
 typedef enum {
 	ide_wait,	/* insert rq at end of list, and wait for it */
+	ide_next,	/* insert rq immediately after current request */
 	ide_preempt,	/* insert rq in front of current request */
 	ide_head_wait,	/* insert rq in front of current request and wait for it */
 	ide_end		/* insert rq at end of list, but don't wait for it */

--=-=-=--
