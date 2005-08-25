Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVHYOIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVHYOIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVHYOIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:08:34 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:59044 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965005AbVHYOId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:08:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=ExLCJ+glH+gaJrHLl53SkR0SMsxLO84w15rsoVBTQkFofH/SZQ7jF5PSYjiv/aZWLXgaIvdLqxH1DuuzETG3g/BRtKsC2G45tFxqec06PC6j3fPbN/ScTAgHvLP9+SFnBuE3NPYY93CKyCjM0wroCjZQ9iW8D+7l/K58liSSfG8=
Message-ID: <253818670508250708a9075a0@mail.gmail.com>
Date: Thu, 25 Aug 2005 10:08:29 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
To: Jon Escombe <lists@dresco.co.uk>
Subject: PATCH: ide: ide-disk freeze support for hdaps
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_328_29926469.1124978909883"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_328_29926469.1124978909883
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

Attached below is a patch heavily based on Jon Escombe's patch, but
implemented as a sysfs attribute as Jens described, with a timeout
(configurable by module/kernel parameter) to ensure the queue isn't
stopped forever.

The driver creates a sysfs attribute "/sys/block/hdX/device/freeze",
which when set (echo 1 >
/sys/block/hda/device/freeze/sys/block/hda/device/freeze) freezes the
queue and parks the head on the drive, protecting the drive
(theoretically) from severe damage, until the drive is thawed (echo 0
> /sys/block/hda/device/freeze) or a timeout is reached (default 10s).

The patch is meant for usage with the hdaps (hard drive active
protection system) for Thinkpads, however would also be useful for
similair systems implemented on powerbooks, and other laptops out
there.

I've tested it out on my T42p and it seems to work well, but as Jon
warns this is experimental...

Thanks,
Yani

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

------=_Part_328_29926469.1124978909883
Content-Type: text/plain; name=patch-linux-2.6.13-rc7-idefreeze.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.13-rc7-idefreeze.diff"


---

 drivers/ide/Kconfig    |   18 +++++
 drivers/ide/ide-disk.c |  163 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/ide-io.c   |   13 ++++
 3 files changed, 194 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -148,6 +148,24 @@ config BLK_DEV_IDEDISK
 
 	  If unsure, say Y.
 
+if BLK_DEV_IDEDISK
+
+config IDEDISK_FREEZE
+	bool "Enable IDE DISK Freeze support"
+	depends on EXPERIMENTAL 
+	help
+	  This will include support for freezing an IDE drive (parking the 
+	  head, freezing the queue), allowing hard drive protection drivers
+	  to park the head quickly and keep it parked. If you don't use such
+	  a driver, you can say N here.
+
+	  If you say yes here a sysfs attribute "/sys/block/hda/device/freeze"
+	  will be created which can be used to freeze/thaw the drive.
+	  
+	  If in doubt, say N.
+
+endif
+
 config IDEDISK_MULTI_MODE
 	bool "Use multi-mode by default"
 	help
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -48,6 +48,9 @@
 //#define DEBUG
 
 #include <linux/config.h>
+#ifdef CONFIG_IDEDISK_FREEZE
+#include <linux/device.h>
+#endif /* CONFIG_IDEDISK_FREEZE */
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -97,6 +100,158 @@ static struct ide_disk_obj *ide_disk_get
 	return idkp;
 }
 
+#ifdef CONFIG_IDEDISK_FREEZE
+/* IDE Freeze support - park the head and stop the queue, 
+ * 			for hard drive protection systems.
+ * Jon Escombe
+ * Yani Ioannou <yani.ioannou@gmail.com> 
+ */
+/* (spins down drive - more obvious for testing) */
+#define STANDBY_IMMEDIATE_ARGS {\
+	0xe0, 			\
+	0x44, 			\
+	0x00, 			\
+	0x4c, 			\
+	0x4e, 			\
+	0x55, 			\
+	0x00, 			\
+}
+
+#define UNLOAD_IMMEDIATE_ARGS {\
+	0xe1, 			\
+	0x44, 			\
+	0x00, 			\
+	0x4c, 			\
+	0x4e, 			\
+	0x55, 			\
+	0x00, 			\
+}
+
+#define IDE_FREEZE_TIMEOUT_SEC 10
+static int ide_freeze_timeout = IDE_FREEZE_TIMEOUT_SEC;
+module_param(ide_freeze_timeout, int, 0);
+MODULE_PARM_DESC(ide_freeze_timeout, 
+		"IDE Freeze timeout in seconds. (0<ide_freeze_timeout<65536, default=" 
+		__MODULE_STRING(IDE_FREEZE_TIMEOUT_SEC) ")");
+static void freeze_expire(unsigned long data);
+static struct timer_list freeze_timer = 
+	TIMER_INITIALIZER(freeze_expire, 0, 0);
+
+static ssize_t ide_freeze_show(struct device *dev, 
+		struct device_attribute *attr, char *buf){
+	ide_drive_t *drive = to_ide_device(dev);
+	int queue_stopped = 
+		test_bit(QUEUE_FLAG_STOPPED, &drive->queue->queue_flags);
+	
+	return snprintf(buf, 10, "%u\n", queue_stopped);
+}
+
+void ide_end_freeze_rq(struct request *rq)
+{
+	struct completion *waiting = rq->waiting;
+	u8 *argbuf = rq->buffer;
+
+	/* Spinlock is already acquired */
+	if (argbuf[3] == 0xc4) {
+		blk_stop_queue(rq->q);
+		printk(KERN_DEBUG "ide_end_freeze_rq(): Head parked\n");
+	}
+	else
+		printk(KERN_DEBUG "ide_end_freeze_rq(): Head not parked\n");
+	
+	complete(waiting);
+}
+
+static int ide_freeze_drive(ide_drive_t *drive)
+{
+	DECLARE_COMPLETION(wait);
+	struct request rq;
+	int error = 0;
+	
+	/* STANDBY IMMEDIATE COMMAND (testing) */
+	/* u8 argbuf[] = STANDBY_IMMEDIATE_ARGS; */
+
+	/* UNLOAD IMMEDIATE COMMAND */
+	u8 argbuf[] = UNLOAD_IMMEDIATE_ARGS;
+
+	/* Check we're not already frozen */
+	if(blk_queue_stopped(drive->queue)){
+		printk(KERN_DEBUG "ide_freeze_drive: Queue already stopped\n");
+		return error;
+	}
+	
+	memset(&rq, 0, sizeof(rq));
+	
+	ide_init_drive_cmd(&rq);
+
+	rq.flags = REQ_DRIVE_TASK;
+	rq.buffer = argbuf;
+	rq.waiting = &wait;
+	rq.end_io = ide_end_freeze_rq;
+
+	error = ide_do_drive_cmd(drive, &rq, ide_next);
+	wait_for_completion(&wait);
+	rq.waiting = NULL;
+	
+	if(error)
+		printk(KERN_ERR "ide_freeze_drive: Error sending command to drive %s: %d\n",
+				drive->name, error);
+	else{
+		printk(KERN_DEBUG "ide_freeze_drive: Queue stopped\n");
+		
+		freeze_timer.data = (unsigned long) drive;
+		mod_timer(&freeze_timer, jiffies+(ide_freeze_timeout*HZ));
+		printk(KERN_DEBUG "ide_freeze_drive: Timer (re)initialized to %ds timeout\n", 
+				ide_freeze_timeout);
+	}
+	return error;
+}
+
+static void ide_thaw_drive(ide_drive_t *drive)
+{
+	unsigned long flags;
+	if (!blk_queue_stopped(drive->queue))
+	{
+		printk(KERN_DEBUG "ide_thaw_drive(): Queue not stopped\n");
+		return;
+	}
+	
+	spin_lock_irqsave(&ide_lock, flags);
+	blk_start_queue(drive->queue);
+	spin_unlock_irqrestore(&ide_lock, flags);
+	printk(KERN_DEBUG "ide_thaw_drive(): Queue started\n");
+	del_timer(&freeze_timer);
+	printk(KERN_DEBUG "ide_thaw_drive: Timer stopped\n");
+}
+
+static void freeze_expire(unsigned long data)
+{
+	ide_drive_t *drive = (ide_drive_t *) data;
+	printk(KERN_DEBUG "freeze_expire(): Freeze timer timeout, thawing...\n");
+	ide_thaw_drive(drive);
+}
+	
+static ssize_t ide_freeze_store(struct device *dev, 
+		struct device_attribute *attr, const char *buf, size_t count){
+	ide_drive_t *drive = to_ide_device(dev);
+	int freeze = 0;
+	int error = 0;
+	
+	freeze = simple_strtoul(buf, NULL, 10);
+	
+	if(freeze)
+		error = ide_freeze_drive(drive);
+	else
+		ide_thaw_drive(drive);
+	
+	return error ? error : count;
+}
+
+static DEVICE_ATTR(freeze, S_IRUSR | S_IWUSR, ide_freeze_show, 
+		ide_freeze_store);
+
+#endif /* CONFIG_IDEDISK_FREEZE */
+
 static void ide_disk_release(struct kref *);
 
 static void ide_disk_put(struct ide_disk_obj *idkp)
@@ -1034,6 +1189,10 @@ static int ide_disk_remove(struct device
 	struct ide_disk_obj *idkp = drive->driver_data;
 	struct gendisk *g = idkp->disk;
 
+	#ifdef CONFIG_IDEDISK_FREEZE
+	device_remove_file(dev, &dev_attr_freeze);
+	#endif /* CONFIG_IDEDISK_FREEZE */
+	
 	ide_cacheflush_p(drive);
 
 	ide_unregister_subdriver(drive, idkp->driver);
@@ -1248,6 +1407,10 @@ static int ide_disk_probe(struct device 
 	} else
 		drive->attach = 1;
 
+	#ifdef CONFIG_IDEDISK_FREEZE
+	device_create_file(dev, &dev_attr_freeze);
+	#endif /* CONFIG_IDEDISK_FREEZE */
+	
 	g->minors = 1 << PARTN_BITS;
 	strcpy(g->devfs_name, drive->devfs_name);
 	g->driverfs_dev = &drive->gendev;
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1181,6 +1181,16 @@ static void ide_do_request (ide_hwgroup_
 		}
 
 		/*
+		 * Don't accept a request when the queue is stopped
+		 * (unless we are resuming from suspend)
+		 */
+		if (test_bit(QUEUE_FLAG_STOPPED, &drive->queue->queue_flags) && !blk_pm_resume_request(rq)) {
+			printk(KERN_ERR "%s: queue is stopped!\n", drive->name);
+			hwgroup->busy = 0;
+			break;
+		}
+
+		/*
 		 * Sanity: don't accept a request that isn't a PM request
 		 * if we are currently power managed. This is very important as
 		 * blk_stop_queue() doesn't prevent the elv_next_request()
@@ -1661,6 +1671,9 @@ int ide_do_drive_cmd (ide_drive_t *drive
 		where = ELEVATOR_INSERT_FRONT;
 		rq->flags |= REQ_PREEMPT;
 	}
+	if (action == ide_next)
+		where = ELEVATOR_INSERT_FRONT;
+
 	__elv_add_request(drive->queue, rq, where, 0);
 	ide_do_request(hwgroup, IDE_NO_IRQ);
 	spin_unlock_irqrestore(&ide_lock, flags);




------=_Part_328_29926469.1124978909883--
