Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268292AbUIPRpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268292AbUIPRpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268298AbUIPRoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:44:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8941 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268400AbUIPRhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:37:07 -0400
Subject: Re: [PATCH-NEW] allow root to modify raw scsi command permissions
	list
From: Peter Jones <pjones@redhat.com>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: alan@lxorguk.ukuu.org.uk, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040916171016.13ca1333.Ballarin.Marc@gmx.de>
References: <1095173470.5728.3.camel@localhost.localdomain>
	 <20040915230813.6eac1d04.Ballarin.Marc@gmx.de>
	 <1095284325.20749.8.camel@localhost.localdomain>
	 <20040916013351.1422170f.Ballarin.Marc@gmx.de>
	 <1095291378.5945.4.camel@localhost.localdomain>
	 <20040916171016.13ca1333.Ballarin.Marc@gmx.de>
Content-Type: text/plain
Date: Thu, 16 Sep 2004 13:36:54 -0400
Message-Id: <1095356215.4727.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 17:10 +0200, Marc Ballarin wrote:
> Hi,
> I've created another version. I fixed the +1 -> +2 issue and added a
> debbuging function.
> I think this is needed because nowadays hardware hardly ships with
> in-depth documentation. It greatly helps in determinig needed filter
> rules.
> 
> Debugging is enabled with "echo 1 > /sys/block/hdX/filter/rcf_debug".
> If a command is blocked, messages like the following are given via
> printk:
> 	RCF: hdX: command XY not allowed in write-mode
> 	RCF: hdX: command YZ not allowed in read-mode
> 
> BTW: There is still a compiler warning about implicit declaration of
> rcf_verify_command when building scsi_ioctl.c

Oh, hrm.  Yeah, that needs to be declared in the header.  Thanks for
pointing it out.

Here's a new diff.  This has changes based on your debug changes.  It
also removes the (useless) "driver" sysfs entry, as it doesn't show what
I thought.  It'd still be nice to list what type of device this is
somewhere in /sys/block/*/ .

diff -urpN linux-2.5-export/drivers/block/Makefile pjones-2.5-export/drivers/block/Makefile
--- linux-2.5-export/drivers/block/Makefile	2004-09-15 12:42:18 -04:00
+++ pjones-2.5-export/drivers/block/Makefile	2004-09-16 13:20:40 -04:00
@@ -13,7 +13,7 @@
 # kblockd threads
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o rcf.o
 
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
diff -urpN linux-2.5-export/drivers/block/genhd.c pjones-2.5-export/drivers/block/genhd.c
--- linux-2.5-export/drivers/block/genhd.c	2004-09-15 12:41:22 -04:00
+++ pjones-2.5-export/drivers/block/genhd.c	2004-09-16 13:20:33 -04:00
@@ -197,6 +197,7 @@ void add_disk(struct gendisk *disk)
 			    disk->minors, NULL, exact_match, exact_lock, disk);
 	register_disk(disk);
 	blk_register_queue(disk);
+	blk_register_filter(disk);
 }
 
 EXPORT_SYMBOL(add_disk);
@@ -204,6 +205,7 @@ EXPORT_SYMBOL(del_gendisk);	/* in partit
 
 void unlink_gendisk(struct gendisk *disk)
 {
+	blk_unregister_filter(disk);
 	blk_unregister_queue(disk);
 	blk_unregister_region(MKDEV(disk->major, disk->first_minor),
 			      disk->minors);
@@ -382,6 +384,7 @@ static ssize_t disk_stats_read(struct ge
 		jiffies_to_msecs(disk_stat_read(disk, io_ticks)),
 		jiffies_to_msecs(disk_stat_read(disk, time_in_queue)));
 }
+
 static struct disk_attribute disk_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },
 	.show	= disk_dev_read
diff -urpN linux-2.5-export/drivers/block/rcf.c pjones-2.5-export/drivers/block/rcf.c
--- linux-2.5-export/drivers/block/rcf.c	1969-12-31 19:00:00 -05:00
+++ pjones-2.5-export/drivers/block/rcf.c	2004-09-16 13:20:44 -04:00
@@ -0,0 +1,338 @@
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
+	struct gendisk *disk;
+	struct inode *inode;
+
+	inode = file->f_dentry->d_inode;
+	if (!inode)
+		return -EINVAL;
+
+	disk = inode->i_bdev->bd_disk;
+	rcf = &disk->filter;
+
+	/* root can do any command. */
+	if (capable(CAP_SYS_RAWIO))
+		return 0;
+
+	/* Anybody who can open the device can do a read-safe command */
+	if (test_bit(cmd[0], rcf->read_ok))
+		return 0;
+
+	/* Write-safe commands require a writable open */
+	if (test_bit(cmd[0], rcf->write_ok) && (file->f_mode & FMODE_WRITE))
+		return 0;
+
+	/* Or else the user has no perms */
+	if (rcf->debug) {
+        	if(file->f_mode & FMODE_WRITE)
+			printk(KERN_WARNING
+				"RCF: %s: command %02x not allowed for write\n",
+				disk->disk_name, cmd[0]);
+		else
+			printk(KERN_WARNING
+				"RCF: %s: command %02x not allowed for read\n",
+				disk->disk_name, cmd[0]);
+       }
+	return -EPERM;
+}
+
+EXPORT_SYMBOL(rcf_verify_command);
+
+/* and now, the sysfs stuff */
+static ssize_t rcf_cmds_show(struct rawio_cmd_filter *rcf, char *page, int rw)
+{
+	char *npage = page;
+	unsigned long *okbits;
+	int x;
+	
+	if (rw == READ) 
+		okbits = rcf->read_ok;
+	else
+		okbits = rcf->write_ok;
+
+	for (x=0; x < RCF_MAX_NR_CMDS; x++)
+		if (test_bit(x, okbits)) {
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
+static ssize_t rcf_readcmds_show(struct rawio_cmd_filter *rcf, char *page)
+{
+	return rcf_cmds_show(rcf, page, READ);
+}
+
+static ssize_t rcf_writecmds_show(struct rawio_cmd_filter *rcf, char *page)
+{
+	return rcf_cmds_show(rcf, page, WRITE);
+}
+
+static ssize_t rcf_debug_show(struct rawio_cmd_filter *rcf, char *page)
+{
+
+	return sprintf(page, "%d\n", rcf->debug);
+}
+
+static ssize_t rcf_cmds_store(struct rawio_cmd_filter *rcf, const char *page,
+			size_t count, int rw)
+{
+	ssize_t ret=0;
+	unsigned long okbits[RCF_CMD_LONGS], *target_okbits;
+	int cmd, status, len;
+	substring_t ss;
+
+	memset(&okbits, 0, sizeof (okbits));
+
+	for (len = strlen(page); len > 0; len-=3) {
+		if (len < 2)
+			break;
+		ss.from = (char *)page+ret;
+		ss.to = (char *)page+ret+2;
+		ret+=3;
+		status = match_hex(&ss, &cmd);
+		/* either of these cases means invalid input, so do nothing. */
+		if (status || cmd >= RCF_MAX_NR_CMDS)
+			return -EINVAL;
+
+		set_bit(cmd, okbits);
+	}
+
+	if (rw == READ)
+		target_okbits = rcf->read_ok;
+	else
+		target_okbits = rcf->write_ok;
+	memmove(target_okbits, okbits, sizeof (okbits));
+
+	return count;
+}
+
+static ssize_t rcf_readcmds_store(struct rawio_cmd_filter *rcf,
+	const char *page, size_t count)
+{
+	return rcf_cmds_store(rcf, page, count, READ);
+}
+
+static ssize_t rcf_writecmds_store(struct rawio_cmd_filter *rcf,
+	const char *page, size_t count)
+{
+	return rcf_cmds_store(rcf, page, count, WRITE);
+}
+
+static ssize_t rcf_debug_store(struct rawio_cmd_filter *rcf,
+	const char *page, size_t count)
+{
+	if (page[0] == '0')
+		rcf->debug = 0;
+	else
+		rcf->debug = 1;
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
+	.store = rcf_readcmds_store,
+};
+
+static struct rcf_sysfs_entry rcf_writecmds_entry = {
+	.attr = {.name = "ok_write_commands", .mode = S_IRUGO | S_IWUSR },
+	.show = rcf_writecmds_show,
+	.store = rcf_writecmds_store,
+};
+
+static struct rcf_sysfs_entry rcf_debug_entry = {
+	.attr = {.name = "debug", .mode = S_IRUGO | S_IWUSR },
+	.show = rcf_debug_show,
+	.store = rcf_debug_store,
+};
+
+static struct attribute *default_attrs[] = {
+	&rcf_readcmds_entry.attr,
+	&rcf_writecmds_entry.attr,
+	&rcf_debug_entry.attr,
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
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	rcf = container_of(kobj, struct rawio_cmd_filter, kobj);
+	if (!entry->store)
+		return -EINVAL;
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
+	/* Basic read-only commands */
+	set_bit(TEST_UNIT_READY, rcf->read_ok);
+	set_bit(REQUEST_SENSE, rcf->read_ok);
+	set_bit(READ_6, rcf->read_ok);
+	set_bit(READ_10, rcf->read_ok);
+	set_bit(READ_12, rcf->read_ok);
+	set_bit(READ_16, rcf->read_ok);
+	set_bit(READ_BUFFER, rcf->read_ok);
+	set_bit(READ_LONG, rcf->read_ok);
+	set_bit(INQUIRY, rcf->read_ok);
+	set_bit(MODE_SENSE, rcf->read_ok);
+	set_bit(MODE_SENSE_10, rcf->read_ok);
+	set_bit(START_STOP, rcf->read_ok);
+	set_bit(GPCMD_VERIFY_10, rcf->read_ok);
+	set_bit(VERIFY_16, rcf->read_ok);
+	set_bit(READ_BUFFER, rcf->read_ok);
+	
+	/* Audio CD commands */
+	set_bit(GPCMD_PLAY_CD, rcf->read_ok);
+	set_bit(GPCMD_PLAY_AUDIO_10, rcf->read_ok);
+	set_bit(GPCMD_PLAY_AUDIO_MSF, rcf->read_ok);
+	set_bit(GPCMD_PLAY_AUDIO_TI, rcf->read_ok);
+	set_bit(GPCMD_PAUSE_RESUME, rcf->read_ok);
+	
+	/* CD/DVD data reading */
+	set_bit(GPCMD_READ_CD, rcf->read_ok);
+	set_bit(GPCMD_READ_CD_MSF, rcf->read_ok);
+	set_bit(GPCMD_READ_DISC_INFO, rcf->read_ok);
+	set_bit(GPCMD_READ_CDVD_CAPACITY, rcf->read_ok);
+	set_bit(GPCMD_READ_DVD_STRUCTURE, rcf->read_ok);
+	set_bit(GPCMD_READ_HEADER, rcf->read_ok);
+	set_bit(GPCMD_READ_TRACK_RZONE_INFO, rcf->read_ok);
+	set_bit(GPCMD_READ_SUBCHANNEL, rcf->read_ok);
+	set_bit(GPCMD_READ_TOC_PMA_ATIP, rcf->read_ok);
+	set_bit(GPCMD_REPORT_KEY, rcf->read_ok);
+	set_bit(GPCMD_SCAN, rcf->read_ok);
+	set_bit(GPCMD_GET_CONFIGURATION, rcf->read_ok);
+	set_bit(GPCMD_READ_FORMAT_CAPACITIES, rcf->read_ok);
+	set_bit(GPCMD_GET_EVENT_STATUS_NOTIFICATION, rcf->read_ok);
+	set_bit(GPCMD_GET_PERFORMANCE, rcf->read_ok);
+	set_bit(GPCMD_SEEK, rcf->read_ok);
+	set_bit(GPCMD_STOP_PLAY_SCAN, rcf->read_ok);
+	
+	/* Basic writing commands */
+	set_bit(WRITE_6, rcf->write_ok);
+	set_bit(WRITE_10, rcf->write_ok);
+	set_bit(WRITE_VERIFY, rcf->write_ok);
+	set_bit(WRITE_12, rcf->write_ok);
+	set_bit(WRITE_VERIFY_12, rcf->write_ok);
+	set_bit(WRITE_16, rcf->write_ok);
+	set_bit(WRITE_LONG, rcf->write_ok);
+	set_bit(ERASE, rcf->write_ok);
+	set_bit(GPCMD_MODE_SELECT_10, rcf->write_ok);
+	set_bit(MODE_SELECT, rcf->write_ok);
+	set_bit(GPCMD_BLANK, rcf->write_ok);
+	set_bit(GPCMD_CLOSE_TRACK, rcf->write_ok);
+	set_bit(GPCMD_FLUSH_CACHE, rcf->write_ok);
+	set_bit(GPCMD_FORMAT_UNIT, rcf->write_ok);
+	set_bit(GPCMD_REPAIR_RZONE_TRACK, rcf->write_ok);
+	set_bit(GPCMD_RESERVE_RZONE_TRACK, rcf->write_ok);
+	set_bit(GPCMD_SEND_DVD_STRUCTURE, rcf->write_ok);
+	set_bit(GPCMD_SEND_EVENT, rcf->write_ok);
+	set_bit(GPCMD_SEND_KEY, rcf->write_ok);
+	set_bit(GPCMD_SEND_OPC, rcf->write_ok);
+	set_bit(GPCMD_SEND_CUE_SHEET, rcf->write_ok);
+	set_bit(GPCMD_SET_SPEED, rcf->write_ok);
+	set_bit(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL, rcf->write_ok);
+	set_bit(GPCMD_LOAD_UNLOAD, rcf->write_ok);
+	set_bit(GPCMD_SET_STREAMING, rcf->write_ok);
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
diff -urpN linux-2.5-export/drivers/block/scsi_ioctl.c pjones-2.5-export/drivers/block/scsi_ioctl.c
--- linux-2.5-export/drivers/block/scsi_ioctl.c	2004-09-15 12:42:48 -04:00
+++ pjones-2.5-export/drivers/block/scsi_ioctl.c	2004-09-16 13:20:46 -04:00
@@ -105,105 +105,6 @@ static int sg_emulated_host(request_queu
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
@@ -220,7 +121,7 @@ static int sg_io(struct file *file, requ
 		return -EINVAL;
 	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
-	if (verify_command(file, cmd))
+	if (rcf_verify_command(file, cmd))
 		return -EPERM;
 
 	/*
@@ -370,7 +271,7 @@ static int sg_scsi_ioctl(struct file *fi
 	if (copy_from_user(buffer, sic->data + cmdlen, in_len))
 		goto error;
 
-	err = verify_command(file, rq->cmd);
+	err = rcf_verify_command(file, rq->cmd);
 	if (err)
 		goto error;
 
diff -urpN linux-2.5-export/include/linux/blkdev.h pjones-2.5-export/include/linux/blkdev.h
--- linux-2.5-export/include/linux/blkdev.h	2004-09-15 12:40:23 -04:00
+++ pjones-2.5-export/include/linux/blkdev.h	2004-09-16 13:20:31 -04:00
@@ -513,6 +513,9 @@ struct sec_size {
 	unsigned block_size_bits;
 };
 
+extern int rcf_verify_command(struct file *file, unsigned char *cmd);
+extern int blk_register_filter(struct gendisk *disk);
+extern void blk_unregister_filter(struct gendisk *disk);
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 extern void register_disk(struct gendisk *dev);
diff -urpN linux-2.5-export/include/linux/genhd.h pjones-2.5-export/include/linux/genhd.h
--- linux-2.5-export/include/linux/genhd.h	2004-09-15 12:39:54 -04:00
+++ pjones-2.5-export/include/linux/genhd.h	2004-09-16 13:20:27 -04:00
@@ -78,6 +78,16 @@ struct disk_stats {
 	unsigned io_ticks;
 	unsigned time_in_queue;
 };
+
+#define RCF_MAX_NR_CMDS	256
+#define	RCF_CMD_LONGS	(RCF_MAX_NR_CMDS / (sizeof (unsigned long) * 8))
+
+struct rawio_cmd_filter {
+	unsigned long read_ok[RCF_CMD_LONGS];
+	unsigned long write_ok[RCF_CMD_LONGS];
+	int debug;
+	struct kobject kobj;
+};
 	
 struct gendisk {
 	int major;			/* major number of driver */
@@ -88,6 +98,7 @@ struct gendisk {
 	struct hd_struct **part;	/* [indexed by minor] */
 	struct block_device_operations *fops;
 	struct request_queue *queue;
+	struct rawio_cmd_filter filter;
 	void *private_data;
 	sector_t capacity;
 

-- 
        Peter

"If the facts don't fit the theory, change the facts."
                -- Einstein

