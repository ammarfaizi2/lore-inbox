Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUIOVBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUIOVBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUIOVAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:00:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:36495 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267466AbUIOU5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:57:02 -0400
X-Authenticated: #1725425
Date: Wed, 15 Sep 2004 23:08:13 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Peter Jones <pjones@redhat.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-NEW] allow root to modify raw scsi command permissions
 list
Message-Id: <20040915230813.6eac1d04.Ballarin.Marc@gmx.de>
In-Reply-To: <1095173470.5728.3.camel@localhost.localdomain>
References: <1095173470.5728.3.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this is a modified version of the previous patch.

Changes:
- always default to an empty filter table (see comment)
- the loading mechanism is changed. It is now only possible to change the
complete list at once. What you write into the file is what you see when
doing 'cat'.
- Adding or removing single commands is no longer possible. IMHO this task
(and further fanciness) is best left to userspace tools.
- instead of defining which list is changed through a keyword, the file decides.
Writes to ok_read_commands only change the commands safe for read. The
same is true for ok_write_commands and commands allowed for write.

IMHO those changes make usage more intuitive and easier for tools/scripts.

TODO:
- an rcf_debug feature is needed. Admins need a way to find out which
commands are actually needed. (echo 0/1 > filter/rcf_debug ?)
- the new sysfs interface is probably horribly written / unreliable. Someone
with actual experience in C and kernel programming needs to review this.
- is it possible to avoid the big code duplication in rcf_store_read and 
rcf_store_write?

Regards,
Marc

diff -Naur orig/linux-2.6.8.1/drivers/block/genhd.c linux-2.6.8.1/drivers/block/genhd.c
--- orig/linux-2.6.8.1/drivers/block/genhd.c	2004-08-19 13:53:46.000000000 +0200
+++ linux-2.6.8.1/drivers/block/genhd.c	2004-09-14 20:23:17.000000000 +0200
@@ -197,6 +197,7 @@
 			    disk->minors, NULL, exact_match, exact_lock, disk);
 	register_disk(disk);
 	blk_register_queue(disk);
+	blk_register_filter(disk);
 }
 
 EXPORT_SYMBOL(add_disk);
@@ -204,6 +205,7 @@
 
 void unlink_gendisk(struct gendisk *disk)
 {
+	blk_unregister_filter(disk);
 	blk_unregister_queue(disk);
 	blk_unregister_region(MKDEV(disk->major, disk->first_minor),
 			      disk->minors);
@@ -382,6 +384,13 @@
 		jiffies_to_msecs(disk_stat_read(disk, io_ticks)),
 		jiffies_to_msecs(disk_stat_read(disk, time_in_queue)));
 }
+
+static ssize_t disk_driver_read(struct gendisk * disk, char *page)
+{
+	return sprintf(page, "%s\n", disk->disk_name);
+
+}
+
 static struct disk_attribute disk_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },
 	.show	= disk_dev_read
@@ -402,6 +411,10 @@
 	.attr = {.name = "stat", .mode = S_IRUGO },
 	.show	= disk_stats_read
 };
+static struct disk_attribute disk_attr_driver = {
+	.attr = {.name = "driver", .mode = S_IRUGO },
+	.show	= disk_driver_read
+};
 
 static struct attribute * default_attrs[] = {
 	&disk_attr_dev.attr,
@@ -409,6 +422,7 @@
 	&disk_attr_removable.attr,
 	&disk_attr_size.attr,
 	&disk_attr_stat.attr,
+	&disk_attr_driver.attr,
 	NULL,
 };
 
diff -Naur orig/linux-2.6.8.1/drivers/block/Makefile linux-2.6.8.1/drivers/block/Makefile
--- orig/linux-2.6.8.1/drivers/block/Makefile	2004-09-15 22:41:39.267361912 +0200
+++ linux-2.6.8.1/drivers/block/Makefile	2004-09-14 20:09:46.000000000 +0200
@@ -13,7 +13,7 @@
 # kblockd threads
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o rcf.o
 
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
diff -Naur orig/linux-2.6.8.1/drivers/block/rcf.c linux-2.6.8.1/drivers/block/rcf.c
--- orig/linux-2.6.8.1/drivers/block/rcf.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1/drivers/block/rcf.c	2004-09-15 22:39:51.874688080 +0200
@@ -0,0 +1,258 @@
+/*
+ * Copyright 2004 Peter M. Jones <pjones@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public Licens
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
+ *
+ */
+
+#include <linux/list.h>
+#include <linux/genhd.h>
+#include <linux/spinlock.h>
+#include <linux/parser.h>
+#include <asm/bitops.h>
+
+#include <scsi/scsi.h>
+#include <linux/cdrom.h>
+
+int rcf_verify_command(struct file *file, unsigned char *cmd)
+{
+	struct rawio_cmd_filter *rcf;
+	struct inode *inode;
+
+	inode = file->f_dentry->d_inode;
+	if (!inode)
+		return -EINVAL;
+
+	rcf = &inode->i_bdev->bd_disk->filter;
+
+	/* root can do any command. */
+	if (capable(CAP_SYS_RAWIO))
+		return 0;
+
+	/* if there's no filter allocated, bail out. */
+	if (unlikely(!rcf))
+		return -EPERM;
+
+	/* Anybody who can open the device can do a read-safe command */
+	if (test_bit(cmd[0], rcf->read_ok))
+		return 0;
+
+	/* Write-safe commands require a writable open */
+	if (test_bit(cmd[0], rcf->write_ok))
+		if (file->f_mode & FMODE_WRITE)
+			return 0;
+
+	/* Or else the user has no perms */
+	return -EPERM;
+}
+
+EXPORT_SYMBOL(rcf_verify_command);
+
+/* and now, the sysfs stuff */
+static ssize_t rcf_readcmds_show(struct rawio_cmd_filter *rcf, char *page)
+{
+	char *npage = page;
+	int x;
+	
+	for (x=0; x < RCF_MAX_NR_CMDS; x++)
+		if (test_bit(x, rcf->read_ok)) {
+			sprintf(npage, "%02x", x);
+			npage += 2;
+			if (x < RCF_MAX_NR_CMDS-1)
+				sprintf(npage++, " ");
+		}
+	if (npage != page)
+		npage += sprintf(npage, "\n");
+	
+	return (npage - page);
+}
+
+static ssize_t rcf_writecmds_show(struct rawio_cmd_filter *rcf, char *page)
+{
+	char *npage = page;
+	int x;
+	
+	for (x=0; x < RCF_MAX_NR_CMDS; x++)
+		if (test_bit(x, rcf->write_ok)) {
+			sprintf(npage, "%02x", x);
+			npage += 2;
+			if (x < RCF_MAX_NR_CMDS-1)
+				sprintf(npage++, " ");
+		}
+	if (npage != page)
+		npage += sprintf(npage, "\n");
+	
+	return (npage - page);
+}
+
+#define RCF_ADD	0
+#define RCF_DEL	1
+
+static ssize_t rcf_store_read(struct rawio_cmd_filter *rcf, const char *page,
+			size_t count)
+{
+	ssize_t ret=0;
+	int i=0;
+	int cmd, status;
+
+	substring_t ss;
+	
+	while(i < RCF_MAX_NR_CMDS)
+		clear_bit(i++, rcf->read_ok);
+	
+	while (page[ret] != 0) {
+		ss.from = (char *)page+ret++;
+		ss.to = (char *)page+(++ret);
+		status = match_hex(&ss, &cmd);
+		if (status)
+			return status;
+		if (cmd > RCF_MAX_NR_CMDS)
+			return -EINVAL;
+		set_bit(cmd, rcf->read_ok);
+		ret++;
+	}
+
+	return count;
+}
+
+static ssize_t rcf_store_write(struct rawio_cmd_filter *rcf, const char *page,
+			size_t count)
+{
+	ssize_t ret=0;
+	int i=0;
+	int cmd, status;
+
+	substring_t ss;
+	
+	while(i < RCF_MAX_NR_CMDS)
+		clear_bit(i++, rcf->write_ok);
+	
+	while (page[ret] != 0) {
+		ss.from = (char *)page+ret++;
+		ss.to = (char *)page+(++ret);
+		status = match_hex(&ss, &cmd);
+		if (status)
+			return status;
+		if (cmd > RCF_MAX_NR_CMDS)
+			return -EINVAL;
+		set_bit(cmd, rcf->write_ok);
+		ret++;
+	}
+
+	return count;
+}
+
+struct rcf_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct rawio_cmd_filter *, char *);
+	ssize_t (*store)(struct rawio_cmd_filter *, const char *, size_t);
+};
+
+static struct rcf_sysfs_entry rcf_readcmds_entry = {
+	.attr = {.name = "ok_read_commands", .mode = S_IRUGO | S_IWUSR },
+	.show = rcf_readcmds_show,
+	.store = rcf_store_read,
+};
+
+static struct rcf_sysfs_entry rcf_writecmds_entry = {
+	.attr = {.name = "ok_write_commands", .mode = S_IRUGO | S_IWUSR },
+	.show = rcf_writecmds_show,
+	.store = rcf_store_write,
+};
+
+static struct attribute *default_attrs[] = {
+	&rcf_readcmds_entry.attr,
+	&rcf_writecmds_entry.attr,
+	NULL,
+};
+
+#define to_rcf(atr) container_of((atr), struct rcf_sysfs_entry, attr)
+
+static ssize_t
+rcf_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
+{
+	struct rcf_sysfs_entry *entry = to_rcf(attr);
+	struct rawio_cmd_filter *rcf;
+
+	rcf = container_of(kobj, struct rawio_cmd_filter, kobj);
+	if (!entry->show)
+		return 0;
+	
+	return entry->show(rcf, page);
+}
+
+static ssize_t
+rcf_attr_store(struct kobject *kobj, struct attribute *attr,
+			const char *page, size_t length)
+{
+	struct rcf_sysfs_entry *entry = to_rcf(attr);
+	struct rawio_cmd_filter *rcf;
+
+	rcf = container_of(kobj, struct rawio_cmd_filter, kobj);
+	if (!entry->store)
+		return -EINVAL;
+	
+	return entry->store(rcf, page, length);
+}
+
+static struct sysfs_ops rcf_sysfs_ops = {
+	.show = rcf_attr_show,
+	.store = rcf_attr_store,
+};
+
+static struct kobj_type rcf_ktype = {
+	.sysfs_ops = &rcf_sysfs_ops,
+	.default_attrs = default_attrs,
+};
+
+static void rcf_set_defaults(struct rawio_cmd_filter *rcf)
+{
+/*
+By default deny everything. As pointed out in the original discussion
+filtering is very tricky since the same command can be used to low-level
+format a disk or simply change read modes for audio grabbing.
+This will still annoy users, but at least they can now fix the situation
+without patching the kernel.
+*/
+}
+
+int blk_register_filter(struct gendisk *disk)
+{
+	int ret;
+	struct rawio_cmd_filter *rcf = &disk->filter;
+
+	rcf->kobj.parent = kobject_get(&disk->kobj);
+	if (!rcf->kobj.parent)
+		return -EBUSY;
+
+	snprintf(rcf->kobj.name, KOBJ_NAME_LEN, "%s", "filter");
+	rcf->kobj.ktype = &rcf_ktype;
+
+	ret = kobject_register(&rcf->kobj);
+	if (ret < 0)
+		return ret;
+
+	rcf_set_defaults(&disk->filter);
+	
+	return 0;
+}
+
+void blk_unregister_filter(struct gendisk *disk)
+{
+	struct rawio_cmd_filter *rcf = &disk->filter;
+
+	kobject_unregister(&rcf->kobj);
+	kobject_put(&disk->kobj);
+}
diff -Naur orig/linux-2.6.8.1/drivers/block/scsi_ioctl.c linux-2.6.8.1/drivers/block/scsi_ioctl.c
--- orig/linux-2.6.8.1/drivers/block/scsi_ioctl.c	2004-09-15 22:41:39.275360696 +0200
+++ linux-2.6.8.1/drivers/block/scsi_ioctl.c	2004-09-14 20:09:46.000000000 +0200
@@ -105,105 +105,6 @@
 	return put_user(1, p);
 }
 
-#define CMD_READ_SAFE	0x01
-#define CMD_WRITE_SAFE	0x02
-#define safe_for_read(cmd)	[cmd] = CMD_READ_SAFE
-#define safe_for_write(cmd)	[cmd] = CMD_WRITE_SAFE
-
-static int verify_command(struct file *file, unsigned char *cmd)
-{
-	static const unsigned char cmd_type[256] = {
-
-		/* Basic read-only commands */
-		safe_for_read(TEST_UNIT_READY),
-		safe_for_read(REQUEST_SENSE),
-		safe_for_read(READ_6),
-		safe_for_read(READ_10),
-		safe_for_read(READ_12),
-		safe_for_read(READ_16),
-		safe_for_read(READ_BUFFER),
-		safe_for_read(READ_LONG),
-		safe_for_read(INQUIRY),
-		safe_for_read(MODE_SENSE),
-		safe_for_read(MODE_SENSE_10),
-		safe_for_read(START_STOP),
-		safe_for_read(GPCMD_VERIFY_10),
-		safe_for_read(VERIFY_16),
-		safe_for_read(READ_BUFFER),
-
-		/* Audio CD commands */
-		safe_for_read(GPCMD_PLAY_CD),
-		safe_for_read(GPCMD_PLAY_AUDIO_10),
-		safe_for_read(GPCMD_PLAY_AUDIO_MSF),
-		safe_for_read(GPCMD_PLAY_AUDIO_TI),
-		safe_for_read(GPCMD_PAUSE_RESUME),
-
-		/* CD/DVD data reading */
-		safe_for_read(GPCMD_READ_CD),
-		safe_for_read(GPCMD_READ_CD_MSF),
-		safe_for_read(GPCMD_READ_DISC_INFO),
-		safe_for_read(GPCMD_READ_CDVD_CAPACITY),
-		safe_for_read(GPCMD_READ_DVD_STRUCTURE),
-		safe_for_read(GPCMD_READ_HEADER),
-		safe_for_read(GPCMD_READ_TRACK_RZONE_INFO),
-		safe_for_read(GPCMD_READ_SUBCHANNEL),
-		safe_for_read(GPCMD_READ_TOC_PMA_ATIP),
-		safe_for_read(GPCMD_REPORT_KEY),
-		safe_for_read(GPCMD_SCAN),
-		safe_for_read(GPCMD_GET_CONFIGURATION),
-		safe_for_read(GPCMD_READ_FORMAT_CAPACITIES),
-		safe_for_read(GPCMD_GET_EVENT_STATUS_NOTIFICATION),
-		safe_for_read(GPCMD_GET_PERFORMANCE),
-		safe_for_read(GPCMD_SEEK),
-		safe_for_read(GPCMD_STOP_PLAY_SCAN),
-
-		/* Basic writing commands */
-		safe_for_write(WRITE_6),
-		safe_for_write(WRITE_10),
-		safe_for_write(WRITE_VERIFY),
-		safe_for_write(WRITE_12),
-		safe_for_write(WRITE_VERIFY_12),
-		safe_for_write(WRITE_16),
-		safe_for_write(WRITE_LONG),
-		safe_for_write(ERASE),
-		safe_for_write(GPCMD_MODE_SELECT_10),
-		safe_for_write(MODE_SELECT),
-		safe_for_write(GPCMD_BLANK),
-		safe_for_write(GPCMD_CLOSE_TRACK),
-		safe_for_write(GPCMD_FLUSH_CACHE),
-		safe_for_write(GPCMD_FORMAT_UNIT),
-		safe_for_write(GPCMD_REPAIR_RZONE_TRACK),
-		safe_for_write(GPCMD_RESERVE_RZONE_TRACK),
-		safe_for_write(GPCMD_SEND_DVD_STRUCTURE),
-		safe_for_write(GPCMD_SEND_EVENT),
-		safe_for_write(GPCMD_SEND_KEY),
-		safe_for_write(GPCMD_SEND_OPC),
-		safe_for_write(GPCMD_SEND_CUE_SHEET),
-		safe_for_write(GPCMD_SET_SPEED),
-		safe_for_write(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
-		safe_for_write(GPCMD_LOAD_UNLOAD),
-		safe_for_write(GPCMD_SET_STREAMING),
-	};
-	unsigned char type = cmd_type[cmd[0]];
-
-	/* Anybody who can open the device can do a read-safe command */
-	if (type & CMD_READ_SAFE)
-		return 0;
-
-	/* Write-safe commands just require a writable open.. */
-	if (type & CMD_WRITE_SAFE) {
-		if (file->f_mode & FMODE_WRITE)
-			return 0;
-	}
-
-	/* And root can do any command.. */
-	if (capable(CAP_SYS_RAWIO))
-		return 0;
-
-	/* Otherwise fail it with an "Operation not permitted" */
-	return -EPERM;
-}
-
 static int sg_io(struct file *file, request_queue_t *q,
 		struct gendisk *bd_disk, struct sg_io_hdr *hdr)
 {
@@ -220,7 +121,7 @@
 		return -EINVAL;
 	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
-	if (verify_command(file, cmd))
+	if (rcf_verify_command(file, cmd))
 		return -EPERM;
 
 	/*
@@ -370,7 +271,7 @@
 	if (copy_from_user(buffer, sic->data + cmdlen, in_len))
 		goto error;
 
-	err = verify_command(file, rq->cmd);
+	err = rcf_verify_command(file, rq->cmd);
 	if (err)
 		goto error;
 
diff -Naur orig/linux-2.6.8.1/include/linux/blkdev.h linux-2.6.8.1/include/linux/blkdev.h
--- orig/linux-2.6.8.1/include/linux/blkdev.h	2004-09-15 22:41:48.930892832 +0200
+++ linux-2.6.8.1/include/linux/blkdev.h	2004-09-14 20:09:46.000000000 +0200
@@ -512,6 +512,8 @@
 	unsigned block_size_bits;
 };
 
+extern int blk_register_filter(struct gendisk *disk);
+extern void blk_unregister_filter(struct gendisk *disk);
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 extern void register_disk(struct gendisk *dev);
diff -Naur orig/linux-2.6.8.1/include/linux/genhd.h linux-2.6.8.1/include/linux/genhd.h
--- orig/linux-2.6.8.1/include/linux/genhd.h	2004-09-15 22:41:48.945890552 +0200
+++ linux-2.6.8.1/include/linux/genhd.h	2004-09-14 20:09:46.000000000 +0200
@@ -78,6 +78,15 @@
 	unsigned io_ticks;
 	unsigned time_in_queue;
 };
+
+#define RCF_MAX_NR_CMDS	256
+#define	RCF_CMD_BYTES	(RCF_MAX_NR_CMDS / (sizeof (unsigned long) * 8))
+
+struct rawio_cmd_filter {
+	unsigned long read_ok[RCF_CMD_BYTES];
+	unsigned long write_ok[RCF_CMD_BYTES];
+	struct kobject kobj;
+};
 	
 struct gendisk {
 	int major;			/* major number of driver */
@@ -88,6 +97,7 @@
 	struct hd_struct **part;	/* [indexed by minor] */
 	struct block_device_operations *fops;
 	struct request_queue *queue;
+	struct rawio_cmd_filter filter;
 	void *private_data;
 	sector_t capacity;
 
