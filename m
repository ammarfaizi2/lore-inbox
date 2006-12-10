Return-Path: <linux-kernel-owner+w=401wt.eu-S1754278AbWLJBDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbWLJBDh (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 20:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756821AbWLJBDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 20:03:37 -0500
Received: from nebensachen.de ([195.225.107.202]:54534 "EHLO nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278AbWLJBDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 20:03:35 -0500
From: Elias Oltmanns <eo@nebensachen.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jens Axboe <jens.axboe@oracle.com>,
       Christoph Schmid <chris@schlagmichtod.de>, linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
References: <7ibks-1fg-15@gated-at.bofh.it> <7kpjn-7th-23@gated-at.bofh.it>
	<7kDFF-8rd-29@gated-at.bofh.it> <87d5783fms.fsf@denkblock.local>
	<20061130171910.GD1860@elf.ucw.cz> <87k61bpuk4.fsf@denkblock.local>
	<20061202115709.GC4030@ucw.cz>
X-Hashcash: 1:20:061210:chris@schlagmichtod.de::PMR7YARgFS1HVtk4:0000000000000000000000000000000000000000Zeq
X-Hashcash: 1:20:061210:jens.axboe@oracle.com::9bXNVvCr0fRBMmf+:00000000000000000000000000000000000000001KMC
X-Hashcash: 1:20:061210:linux-kernel@vger.kernel.org::h7Nt4jVza7oMzCnP:0000000000000000000000000000000003m7d
X-Hashcash: 1:20:061210:pavel@ucw.cz::KiH16smiq/senwPo:00000ELJi
Date: Sun, 10 Dec 2006 02:02:26 +0100
In-Reply-To: <20061202115709.GC4030@ucw.cz> (Pavel Machek's message of "Sat\, 2
	Dec 2006 11\:57\:09 +0000")
Message-ID: <87wt50wokd.fsf@denkblock.local>
User-Agent: Gnus/5.110006 (No Gnus v0.6)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi Pavel,

Pavel Machek <pavel@ucw.cz> wrote:
>> >> +module_param_named(protect_method, libata_protect_method, int, 0444);
>> >> +MODULE_PARM_DESC(protect_method, "hdaps disk protection method  (0=autodetect, 1=unload, 2=standby)");
>> >
>> > Should this be configurable by module parameter? Why not tell each
>> > unload what to do?
[...]
>> > Is /sys interface right thing to do?
>> 
>> Probably, you're right here. Since this feature is actually drive
>> specific, it should not really be set globally as a libata or ide-disk
>> parameter but specifically for each drive connected. Perhaps we should
>> add another attribute to /sys/block/*/queue or enhance the scope of
>> /sys/block/*/queue/protect?
>
> Certainly better than current solution. Or maybe ioctl similar to wat
> hdparm uses?
> 							Pavel

I'm not quite sure what you have in mind wrt ioctls. I'm still
convinced that the administrator should take a conscious decision when
forcing an idle immediate with unload feature on a drive which doesn't
announce this capability according to the specs. This is because I
have no idea as to how drives might react if they don't support it.
Perhaps we should consult linux-ide on this topic.

Anyway, this is the reason why I favour the sysfs approach. The
decision can be made, for instance, in a udev rule during device
setup.

So, here is a patch in which your remarks and suggestions have been
incorporated. Additionally, I've added the requested kernel doc file
and another sysfs attribute called protect_method. The usage of this
attribute is described in Documentation/block/disk-protection.txt.

Patch applies to 2.6.19.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---
 Documentation/block/disk-protection.txt |   79 +++++++
 block/ll_rw_blk.c                       |  224 ++++++++++++++++++++++
 drivers/ata/libata-scsi.c               |   29 ++
 drivers/ide/ide-disk.c                  |  142 +++++++++++++
 drivers/ide/ide-io.c                    |   14 +
 drivers/scsi/scsi_lib.c                 |  163 ++++++++++++++++
 include/linux/ata.h                     |    1
 include/linux/blkdev.h                  |   14 +
 include/linux/ide.h                     |    1
 9 files changed, 667 insertions(+)

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=hdaps_protect-2.6.19-2.patch

diff --git a/Documentation/block/disk-protection.txt b/Documentation/block/disk-protection.txt
new file mode 100644
index 0000000..508cc5b
--- /dev/null
+++ b/Documentation/block/disk-protection.txt
@@ -0,0 +1,79 @@
+Hard disk protection
+====================
+
+
+Intro
+-----
+ATA/ATAPI-7 specifies the IDLE IMMEDIATE command with UNLOAD FEATURE.
+Issuing this command should cause the drive to switch to idle mode and
+unload disk heads. This feature is being used in modern laptops in
+conjunction with accelerometers and appropriate software to implement
+a shock protection facility. The idea is to stop all I/O operations on
+the internal hard drive and park its heads on the ramp when critical
+situations are anticipated. The desire to have such a feature
+available on GNU/Linux systems has been the original motivation to
+implement a generic disk parking interface in the Linux kernel.
+
+
+The interface
+-------------
+The interface works as follows: Writing an integer value to
+/sys/block/*/queue/protect will park the respective drive and freeze
+the block layer queue for the specified number of seconds. When the
+timeout expires and no further disk park request has been issued in
+the meantime, the queue is unfrozen and accumulated I/O operations are
+performed.
+
+IMPORTANT NOTE:
+Not all ATA drives implement IDLE IMMEDIATE with UNLOAD FEATURE and
+quite a few of those that do so, don't report this capability as
+described in the specs. When a disk park has been requested through
+sysfs as described above, the kernel will try to determine if the
+drive supports the UNLOAD FEATURE by default. The kernel will only
+rely on the IDLE IMMEDIATE with UNLOAD FEATURE command if it is
+convinced that this command is actually supported by the disk drive;
+otherwise, it will fall back to STANDBY IMMEDIATE. Resuming from the
+latter will take much longer and it is generally more likely to have a
+negative impact on the drive's lifetime due to the inclease of spin
+down and up cycles. If you want to use this interface in a shock
+protection framework and you know that your drive does indeed support
+the IDLE IMMEDIATE with UNLOAD FEATURE command despite not saying so,
+you can force the kernel to issue that command by doing the following
+on the command line:
+# echo -n unload > /sys/block/sda/queue/protect_method
+(replace sda by the drive identifier as appropriate).
+
+/sys/block/*/queue/protect_method accepts auto, unload and standby
+respectively. Reading from protect_method shows the available options
+surrounding the active one with brackets. When auto is active, this
+will change to whatever the kernel sees fit after the next disk park
+command has been issued.
+
+
+References
+----------
+
+There are several laptops from different brands featuring shock
+protection capabilities. As manufacturers have refused to support open
+source development of the required software components so far, Linux
+support for shock protection varies considerably between different
+hardware implementations. Ideally, this section should contain a list
+of poiters at different projects aiming at an implementation of shock
+protection on different systeems. Unfortunately, I only know of a
+single project which, although still considered experimental, is fit
+for use. Please feel free to add projects that have been the victims
+of my ignorance.
+
+- http://www.thinkwiki.org/wiki/HDAPS
+  See this page for information about Linux support of the hard disk
+  active protection syystem as implemented in IBM/Lenovo Thinkpads.
+
+
+CREDITS
+-------
+
+The patch to implement the interface described in this file has
+originally been published by Jon Escombe <lists@dresco.co.uk>.
+
+
+05 Dec 2006, Elias Oltmanns <eo@nebensachen.de>
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 9eaee66..a03ed2b 100644
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
@@ -232,6 +236,16 @@ void blk_queue_make_request(request_queu
 	q->unplug_timer.function = blk_unplug_timeout;
 	q->unplug_timer.data = (unsigned long)q;
 
+	q->max_unfreeze = 30;
+
+	INIT_WORK(&q->unfreeze_work, blk_unfreeze_work, q);
+
+	q->unfreeze_timer.function = blk_unfreeze_timeout;
+	q->unfreeze_timer.data = (unsigned long)q;
+
+	/* Set protect_method to auto detection initially */
+	q->protect_method = 2;
+
 	/*
 	 * by default assume old behaviour and bounce for any highmem page
 	 */
@@ -324,6 +338,18 @@ void blk_queue_issue_flush_fn(request_qu
 
 EXPORT_SYMBOL(blk_queue_issue_flush_fn);
 
+void blk_queue_issue_protect_fn(request_queue_t *q, issue_protect_fn *ipf)
+{
+	q->issue_protect_fn = ipf;
+}
+EXPORT_SYMBOL(blk_queue_issue_protect_fn);
+
+void blk_queue_issue_unprotect_fn(request_queue_t *q, issue_unprotect_fn *iuf)
+{
+	q->issue_unprotect_fn = iuf;
+}
+EXPORT_SYMBOL(blk_queue_issue_unprotect_fn);
+
 /*
  * Cache flushing for ordered writes handling
  */
@@ -1842,6 +1868,7 @@ request_queue_t *blk_alloc_queue_node(gf
 
 	memset(q, 0, sizeof(*q));
 	init_timer(&q->unplug_timer);
+	init_timer(&q->unfreeze_timer);
 
 	snprintf(q->kobj.name, KOBJ_NAME_LEN, "%s", "queue");
 	q->kobj.ktype = &queue_ktype;
@@ -3917,6 +3944,7 @@ int blk_register_queue(struct gendisk *d
 		return ret;
 	}
 
+	blk_protect_register(q);
 	return 0;
 }
 
@@ -3925,6 +3953,7 @@ void blk_unregister_queue(struct gendisk
 	request_queue_t *q = disk->queue;
 
 	if (q && q->request_fn) {
+		blk_protect_unregister(q);
 		elv_unregister_queue(q);
 
 		kobject_uevent(&q->kobj, KOBJ_REMOVE);
@@ -3932,3 +3961,198 @@ void blk_unregister_queue(struct gendisk
 		kobject_put(&disk->kobj);
 	}
 }
+
+/*
+ * Issue lower level unprotect function if no timers are pending.
+ */
+static void blk_unfreeze_work(void *data)
+{
+	request_queue_t *q = (request_queue_t *) data;
+	int pending;
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	pending = timer_pending(&q->unfreeze_timer);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+	if (!pending)
+		q->issue_unprotect_fn(q);
+}
+
+/*
+ * Called when the queue freeze timeout expires...
+ */
+static void blk_unfreeze_timeout(unsigned long data)
+{
+	request_queue_t *q = (request_queue_t *) data;
+
+	kblockd_schedule_work(&q->unfreeze_work);
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
+		/*
+		 * Adding 1 in order to guarantee nonzero value until timer
+		 * has actually expired.
+		 */
+		seconds = jiffies_to_msecs(q->unfreeze_timer.expires
+					   - jiffies) / 1000 + 1;
+	spin_unlock_irq(q->queue_lock);
+	return queue_var_show(seconds, (page));
+}
+
+/*
+ * When writing the 'protect' attribute, input is the number of seconds
+ * to freeze the queue for. We call a lower level helper function to
+ * park the heads and freeze/block the queue, then we make a block layer
+ * call to setup the thaw timeout. If input is 0, then we thaw the queue.
+ */
+static ssize_t queue_protect_store(struct request_queue *q,
+				   const char *page, size_t count)
+{
+	unsigned long freeze = 0;
+
+	queue_var_store(&freeze, page, count);
+
+	if (freeze>0) {
+		/* Park and freeze */
+		if (!blk_queue_stopped(q))
+			q->issue_protect_fn(q);
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
+static ssize_t
+queue_str_show(char *page, char *str, int status)
+{
+	ssize_t len;
+
+	if (status & 1)
+		len = sprintf(page, "[%s]", str);
+	else
+		len = sprintf(page, "%s", str);
+	if (status & 2)
+		len += sprintf(page+len, "\n");
+	else
+		len += sprintf(page+len, " ");
+	return len;
+}
+
+/*
+ * Returns current protect_method.
+ */
+static ssize_t queue_protect_method_show(struct request_queue *q, char *page)
+{
+	int len = 0;
+	int unload = q->protect_method;
+
+	len += queue_str_show(page+len, "auto", (unload & 2) >> 1);
+	len += queue_str_show(page+len, "unload", unload & 1);
+	len += queue_str_show(page+len, "standby", !unload ? 3 : 2);
+	return len;
+}
+
+/*
+ * Stores the device protect method.
+ */
+static ssize_t queue_protect_method_store(struct request_queue *q,
+				   const char *page, size_t count)
+{
+	spin_lock_irq(q->queue_lock);
+	if (!strcmp(page, "auto") || !strcmp(page, "auto\n"))
+		q->protect_method = 2;
+	else if (!strcmp(page, "unload") || !strcmp(page, "unload\n"))
+		q->protect_method = 1;
+	else if (!strcmp(page, "standby") || !strcmp(page, "standby\n"))
+		q->protect_method = 0;
+	else {
+		spin_unlock_irq(q->queue_lock);
+		return -EINVAL;
+	}
+	spin_unlock_irq(q->queue_lock);
+	return count;
+}
+
+static struct queue_sysfs_entry queue_protect_entry = {
+	.attr = { .name = "protect", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_protect_show,
+	.store = queue_protect_store,
+};
+static struct queue_sysfs_entry queue_protect_method_entry = {
+	.attr = { .name = "protect_method", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_protect_method_show,
+	.store = queue_protect_method_store,
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
+	/* create the attributes */
+	error = sysfs_create_file(&q->kobj, &queue_protect_entry.attr);
+	if (error) {
+		printk(KERN_ERR
+		       "blk_protect_register(): failed to create protect queue attribute!\n");
+		return error;
+	}
+	kobject_get(&q->kobj);
+
+	error = sysfs_create_file(&q->kobj, &queue_protect_method_entry.attr);
+	if (error) {
+		printk(KERN_ERR
+		       "blk_protect_register(): failed to create protect_method attribute!\n");
+		return error;
+	}
+	kobject_get(&q->kobj);
+
+	return 0;
+}
+
+static void blk_protect_unregister(request_queue_t *q)
+{
+	/* check that the lower level driver has a protect handler */
+	if (!q->issue_protect_fn)
+		return;
+
+	/* remove the attributes */
+	sysfs_remove_file(&q->kobj, &queue_protect_method_entry.attr);
+	kobject_put(&q->kobj);
+	sysfs_remove_file(&q->kobj, &queue_protect_entry.attr);
+	kobject_put(&q->kobj);
+}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 47ea111..4dd00ca 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -841,6 +841,33 @@ static void ata_scsi_dev_config(struct s
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
+	int unload = q->protect_method;
+	unsigned long flags;
+
+	if (unload == 2) {
+		unload = ata_id_has_unload(dev->id) ? 1 : 0;
+		spin_lock_irqsave(q->queue_lock, flags);
+		q->protect_method = unload;
+		spin_unlock_irqrestore(q->queue_lock, flags);
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
@@ -864,6 +891,8 @@ int ata_scsi_slave_config(struct scsi_de
 
 	if (dev)
 		ata_scsi_dev_config(sdev, dev);
+	blk_queue_issue_protect_fn(sdev->request_queue, ata_scsi_issue_protect_fn);	
+	blk_queue_issue_unprotect_fn(sdev->request_queue, ata_scsi_issue_unprotect_fn);	
 
 	return 0;	/* scsi layer doesn't check return value, sigh */
 }
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 0a05a37..8094ba0 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -731,6 +731,145 @@ static int idedisk_issue_flush(request_q
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
+	unsigned long flags;
+
+	/*
+	 * Check capability of the device -
+	 *  - if "idle immediate with unload" is supported we use that, else
+	 *    we use "standby immediate" and live with spinning down the drive..
+	 *    (Word 84, bit 13 of IDENTIFY DEVICE data)
+	 */
+	if (unload == 2) {
+		unload = drive->id->cfsse & (1 << 13) ? 1 : 0;
+		spin_lock_irqsave(q->queue_lock, flags);
+		q->protect_method = unload;
+		spin_unlock_irqrestore(q->queue_lock, flags);
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
@@ -986,6 +1125,9 @@ static void idedisk_setup (ide_drive_t *
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
index 3ac4890..cbb274d 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2259,3 +2259,166 @@ void scsi_kunmap_atomic_sg(void *virt)
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
index 7bfcde2..838e7b0 100644
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
@@ -403,6 +407,14 @@ struct request_queue
 	unsigned long		unplug_delay;	/* After this many jiffies */
 	struct work_struct	unplug_work;
 
+	/*
+	 * Auto-unfreeze state
+	 */
+	struct timer_list	unfreeze_timer;
+	int			max_unfreeze;	/* At most this many seconds */
+	struct work_struct	unfreeze_work;
+	int			protect_method;
+
 	struct backing_dev_info	backing_dev_info;
 
 	/*
@@ -760,6 +772,8 @@ extern int blk_do_ordered(request_queue_
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
