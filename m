Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263826AbUFKLmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbUFKLmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 07:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUFKLmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 07:42:00 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57999 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263826AbUFKLkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 07:40:35 -0400
Date: Fri, 11 Jun 2004 20:41:48 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 2/4]Diskdump Update
In-reply-to: <A0C44FA7FE6022indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <A2C44FA9144378indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <A0C44FA7FE6022indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for scsi common layer.


diff -Nur linux-2.6.6.org/drivers/scsi/Kconfig linux-2.6.6/drivers/scsi/Kconfig
--- linux-2.6.6.org/drivers/scsi/Kconfig	2004-05-10 11:33:19.000000000 +0900
+++ linux-2.6.6/drivers/scsi/Kconfig	2004-06-09 22:24:30.590629105 +0900
@@ -55,6 +55,12 @@
 	  In this case, do not compile the driver for your SCSI host adapter
 	  (below) as a module either.
 
+config SCSI_DUMP
+	tristate "SCSI dump support"
+	depends on DISKDUMP && SCSI
+	help
+	   SCSI dump support
+
 config CHR_DEV_ST
 	tristate "SCSI tape support"
 	depends on SCSI
diff -Nur linux-2.6.6.org/drivers/scsi/Makefile linux-2.6.6/drivers/scsi/Makefile
--- linux-2.6.6.org/drivers/scsi/Makefile	2004-05-10 11:33:13.000000000 +0900
+++ linux-2.6.6/drivers/scsi/Makefile	2004-06-09 22:24:30.591605668 +0900
@@ -133,6 +133,8 @@
 obj-$(CONFIG_BLK_DEV_SR)	+= sr_mod.o
 obj-$(CONFIG_CHR_DEV_SG)	+= sg.o
 
+obj-$(CONFIG_SCSI_DUMP)		+= scsi_dump.o
+
 scsi_mod-y			+= scsi.o hosts.o scsi_ioctl.o constants.o \
 				   scsicam.o scsi_error.o scsi_lib.o \
 				   scsi_scan.o scsi_syms.o scsi_sysfs.o \
diff -Nur linux-2.6.6.org/drivers/scsi/scsi.c linux-2.6.6/drivers/scsi/scsi.c
--- linux-2.6.6.org/drivers/scsi/scsi.c	2004-05-10 11:32:37.000000000 +0900
+++ linux-2.6.6/drivers/scsi/scsi.c	2004-06-09 22:24:30.592582230 +0900
@@ -691,6 +691,9 @@
 {
 	unsigned long flags;
 
+	if (crashdump_mode())
+		return;
+
 	/*
 	 * We don't have to worry about this one timing out any more.
 	 * If we are unable to remove the timer, then the command
diff -Nur linux-2.6.6.org/drivers/scsi/scsi_dump.c linux-2.6.6/drivers/scsi/scsi_dump.c
--- linux-2.6.6.org/drivers/scsi/scsi_dump.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.6/drivers/scsi/scsi_dump.c	2004-06-09 22:31:51.418748705 +0900
@@ -0,0 +1,574 @@
+/*
+ *  linux/drivers/scsi/scsi_dump.c
+ *
+ *  Copyright (C) 2004  FUJITSU LIMITED
+ *  Written by Nobuhiro Tachino (ntachino@jp.fujitsu.com)
+ *
+ * Some codes are derived from drivers/scsi/sd.c
+ */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/module.h>
+
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+
+#include <linux/blkdev.h>
+#include <linux/blkpg.h>
+
+#include <linux/genhd.h>
+#include <linux/utsname.h>
+#include <linux/crc32.h>
+#include <linux/diskdump.h>
+#include <linux/diskdumplib.h>
+#include <linux/delay.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_ioctl.h>
+#include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_dump.h>
+
+#include "scsi.h"
+#include "scsi_priv.h"
+
+#define MAX_RETRIES 5
+#define SD_TIMEOUT (60 * HZ)
+
+#define Dbg(x, ...)	pr_debug("scsi_dump: " x "\n", ## __VA_ARGS__)
+#define Err(x, ...)	pr_err  ("scsi_dump: " x "\n", ## __VA_ARGS__)
+#define Warn(x, ...)	pr_warn ("scsi_dump: " x "\n", ## __VA_ARGS__)
+#define Info(x, ...)	pr_info ("scsi_dump: " x "\n", ## __VA_ARGS__)
+
+/* blocks to 512byte sectors */
+#define BLOCK_SECTOR(s)	((s) << (DUMP_BLOCK_SHIFT - 9))
+
+static int quiesce_ok = 0;
+static struct scsi_cmnd scsi_dump_cmnd;
+static struct request scsi_dump_req;
+static uint32_t module_crc;
+
+static void rw_intr(struct scsi_cmnd * scmd)
+{
+	scmd->done = NULL;
+}
+
+/*
+ * Common code to make Scsi_Cmnd
+ */
+static void init_scsi_command(struct scsi_device *sdev, struct scsi_cmnd *scmd,
+		 	      void *buf, int len, unsigned char direction,
+			      int set_lun)
+{
+	scmd->request   = &scsi_dump_req;
+	scmd->sc_magic	= SCSI_CMND_MAGIC;
+	scmd->owner	= SCSI_OWNER_MIDLEVEL;
+	scmd->device	= sdev;
+	scmd->buffer	= scmd->request_buffer = buf;
+	scmd->bufflen	= scmd->request_bufflen = len;
+
+
+	scmd->sc_data_direction = direction;
+
+	memcpy(scmd->data_cmnd, scmd->cmnd, sizeof(scmd->cmnd));
+	scmd->cmd_len = COMMAND_SIZE(scmd->cmnd[0]);
+	scmd->old_cmd_len = scmd->cmd_len;
+
+
+	if (set_lun)
+		scmd->cmnd[1] |= (sdev->scsi_level <= SCSI_2) ?
+				  ((sdev->lun << 5) & 0xe0) : 0;
+
+	scmd->transfersize = sdev->sector_size;
+	if (direction == SCSI_DATA_WRITE)
+		scmd->underflow = len;
+
+	scmd->allowed = MAX_RETRIES;
+	scmd->timeout_per_command = SD_TIMEOUT;
+
+	/*
+	 * This is the completion routine we use.  This is matched in terms
+	 * of capability to this function.
+	 */
+	scmd->done = rw_intr;
+}
+
+static void init_mode_sense_command(struct scsi_device *sdev,
+				    struct scsi_cmnd *scmd, void *buf)
+{
+	memset(scmd, 0, sizeof(*scmd));
+	scmd->cmnd[0] = MODE_SENSE;
+	scmd->cmnd[1] = 0x00;		/* DBD=0 */
+	scmd->cmnd[2] = 0x08;		/* PCF=0 Page 8(Cache) */
+	scmd->cmnd[4] = 255;
+
+	init_scsi_command(sdev, scmd, buf, 256, SCSI_DATA_READ, 1);
+}
+
+static void init_mode_select_command(struct scsi_device *sdev,
+				     struct scsi_cmnd *scmd, void *buf, int len)
+{
+	memset(scmd, 0, sizeof(*scmd));
+	scmd->cmnd[0] = MODE_SELECT;
+	scmd->cmnd[1] = 0x10;		/* PF=1 SP=0 */
+	scmd->cmnd[4] = len;
+
+	init_scsi_command(sdev, scmd, buf, len, SCSI_DATA_WRITE, 1);
+}
+
+static void init_sync_command(struct scsi_device *sdev, struct scsi_cmnd * scmd)
+{
+	memset(scmd, 0, sizeof(*scmd));
+	scmd->cmnd[0] = SYNCHRONIZE_CACHE;
+
+	init_scsi_command(sdev, scmd, NULL, 0, SCSI_DATA_NONE, 0);
+}
+
+static void init_sense_command(struct scsi_device *sdev, struct scsi_cmnd *scmd,
+			       void *buf)
+{
+	memset(scmd, 0, sizeof(*scmd));
+	scmd->cmnd[0] = REQUEST_SENSE;
+	scmd->cmnd[4] = 255;
+
+	init_scsi_command(sdev, scmd, buf, 256, SCSI_DATA_READ, 1);
+}
+
+static int init_rw_command(struct disk_dump_partition *dump_part,
+			   struct scsi_device *sdev, struct scsi_cmnd * scmd,
+			   int rw, int block, void *buf, unsigned int len)
+{
+	int this_count = len >> 9;
+
+	memset(scmd, 0, sizeof(*scmd));
+
+	if (block + this_count > dump_part->nr_sects) {
+		Err("block number %d is larger than %lu",
+				block + this_count, dump_part->nr_sects);
+		return -EFBIG;
+	}
+
+	block += dump_part->start_sect;
+
+	/*
+	 * If we have a 1K hardware sectorsize, prevent access to single
+	 * 512 byte sectors.  In theory we could handle this - in fact
+	 * the scsi cdrom driver must be able to handle this because
+	 * we typically use 1K blocksizes, and cdroms typically have
+	 * 2K hardware sectorsizes.  Of course, things are simpler
+	 * with the cdrom, since it is read-only.  For performance
+	 * reasons, the filesystems should be able to handle this
+	 * and not force the scsi disk driver to use bounce buffers
+	 * for this.
+	 */
+	if (sdev->sector_size == 1024) {
+		block = block >> 1;
+		this_count = this_count >> 1;
+	}
+	if (sdev->sector_size == 2048) {
+		block = block >> 2;
+		this_count = this_count >> 2;
+	}
+	if (sdev->sector_size == 4096) {
+		block = block >> 3;
+		this_count = this_count >> 3;
+	}
+	switch (rw) {
+	case WRITE:
+		if (!sdev->writeable) {
+			Err("writable media");
+			return 0;
+		}
+		scmd->cmnd[0] = WRITE_10;
+		break;
+	case READ:
+		scmd->cmnd[0] = READ_10;
+		break;
+	default:
+		Err("Unknown command %d", rw);
+		return -EINVAL;
+	}
+
+	if (this_count > 0xffff)
+		this_count = 0xffff;
+
+	scmd->cmnd[2] = (unsigned char) (block >> 24) & 0xff;
+	scmd->cmnd[3] = (unsigned char) (block >> 16) & 0xff;
+	scmd->cmnd[4] = (unsigned char) (block >> 8) & 0xff;
+	scmd->cmnd[5] = (unsigned char) block & 0xff;
+	scmd->cmnd[7] = (unsigned char) (this_count >> 8) & 0xff;
+	scmd->cmnd[8] = (unsigned char) this_count & 0xff;
+
+	init_scsi_command(sdev, scmd, buf, len,
+			(rw == WRITE ? SCSI_DATA_WRITE : SCSI_DATA_READ), 1);
+	return 0;
+}
+
+/*
+ * Check the status of scsi command and determine whether it is
+ * success, fail, or retriable.
+ *
+ * Return code
+ * 	> 0: should retry
+ * 	= 0: success
+ * 	< 0: fail
+ */
+static int cmd_result(struct scsi_cmnd *scmd)
+{
+	int status;
+
+	status = status_byte(scmd->result);
+
+	switch (scsi_decide_disposition(scmd)) {
+	case FAILED:
+		break;
+	case NEEDS_RETRY:
+	case ADD_TO_MLQUEUE:
+		return 1 /* retry */;
+	case SUCCESS:
+		if (host_byte(scmd->result) != DID_OK)
+			break;
+
+		if (status == GOOD || status == INTERMEDIATE_GOOD
+				   || status == INTERMEDIATE_C_GOOD)
+			return 0;
+		if (status == CHECK_CONDITION &&
+		    scmd->sense_buffer[2] == RECOVERED_ERROR)
+			return 0;
+		break;
+	default:
+		Err("bad disposition: %d", scmd->result);
+		return -EIO;
+	}
+
+	Err("command %x failed with 0x%x", scmd->cmnd[0], scmd->result);
+	return -EIO;
+}
+
+static int send_command(struct scsi_cmnd *scmd)
+{
+	struct Scsi_Host *host = scmd->device->host;
+	struct scsi_device *sdev = scmd->device;
+	int ret;
+
+	do {
+		if (!scsi_device_online(sdev)) {
+			Err("Scsi disk is not online");
+			return -EIO;
+		}
+		if (sdev->changed) {
+			Err("SCSI disk has been changed. Prohibiting further I/O");
+			return -EIO;
+		}
+
+		spin_lock(host->host_lock);
+		host->hostt->queuecommand(scmd, rw_intr);
+		spin_unlock(host->host_lock);
+
+		while (scmd->done != NULL) {
+			host->hostt->dump_ops->poll(scmd->device);
+			udelay(100);
+			diskdump_update();
+		}
+		scmd->done = rw_intr;
+	} while ((ret = cmd_result(scmd)) > 0);
+
+	return ret;
+}
+
+/*
+ * If Write Cache Enable of disk device is not set, write I/O takes
+ * long long time.  So enable WCE temporary and issue SYNCHRONIZE CACHE
+ * after all write I/Os are done, Following system reboot will reset
+ * WCE bit to original value.
+ */
+static void
+enable_write_cache(struct scsi_device *sdev)
+{
+	char buf[256];
+	int ret;
+	int data_len;
+
+	Dbg("enable write cache");
+	memset(buf, 0, 256);
+
+	init_mode_sense_command(sdev, &scsi_dump_cmnd, buf);
+	if ((ret = send_command(&scsi_dump_cmnd)) < 0) {
+		Warn("MODE SENSE failed");
+		return;
+	}
+
+	if (buf[14] & 0x04)		/* WCE is already set */
+		return;
+
+	data_len = buf[0] + 1; /* Data length in mode parameter header */
+	buf[0] = 0;
+	buf[1] = 0;
+	buf[2] = 0;
+	buf[12] &= 0x7f;		/* clear PS */
+	buf[14] |= 0x04;		/* set WCE */
+
+	init_mode_select_command(sdev, &scsi_dump_cmnd, buf, data_len);
+	if ((ret = send_command(&scsi_dump_cmnd)) < 0) {
+		Warn("MODE SELECT failed");
+
+		init_sense_command(sdev, &scsi_dump_cmnd, buf);
+		if ((ret = send_command(&scsi_dump_cmnd)) < 0) {
+			Err("sense failed");
+		}
+	}
+}
+
+/*
+ * Check whether the dump device is sane enough to handle I/O.
+ *
+ * Return value:
+ * 	0:	the device is ok
+ * 	< 0:	the device is not ok
+ * 	> 0:	Cannot determine
+ */
+static int
+scsi_dump_sanity_check(struct disk_dump_device *dump_device)
+{
+	struct scsi_device *sdev = dump_device->device;
+	struct Scsi_Host *host = sdev->host;
+	int adapter_sanity = 0;
+	int sanity = 0;
+
+	if (!check_crc_module()) {
+		Err("checksum error. scsi dump module may be compromised.");
+		return -EINVAL;
+	}
+	/*
+	 * If host's spinlock is already taken, assume it's part
+	 * of crash and skip it.
+	 */
+	if (!scsi_device_online(sdev)) {
+		Warn("device not online: host %d channel %d id %d lun %d",
+			host->host_no, sdev->channel, sdev->id, sdev->lun);
+		return -EIO;
+	}
+	if (sdev->changed) {
+		Err("SCSI disk has been changed. Prohibiting further I/O: host %d channel %d id %d lun %d",
+			host->host_no, sdev->channel, sdev->id, sdev->lun);
+		return -EIO;
+	}
+
+	if (host->hostt->dump_ops->sanity_check) {
+		adapter_sanity = host->hostt->dump_ops->sanity_check(sdev);
+		if (adapter_sanity < 0) {
+			Warn("adapter status is not sane");
+			return adapter_sanity;
+		}
+	}
+
+	if (!spin_is_locked(host->host_lock)) {
+		sanity = 0;
+	} else {
+		Warn("host_lock is held: host %d channel %d id %d lun %d",
+			host->host_no, sdev->channel, sdev->id, sdev->lun);
+		return -EIO;
+	}
+	return sanity + adapter_sanity;
+}
+
+/*
+ * Try to reset the host adapter. If the adapter does not have its host reset
+ * handler, try to use its bus device reset handler.
+ */
+static int scsi_dump_reset(struct scsi_device *sdev)
+{
+	struct Scsi_Host *host = sdev->host;
+	struct scsi_host_template *hostt = host->hostt;
+	char buf[256];
+	int ret, i;
+
+	init_sense_command(sdev, &scsi_dump_cmnd, buf);
+
+	if (hostt->eh_host_reset_handler) {
+		spin_lock(host->host_lock);
+		ret = hostt->eh_host_reset_handler(&scsi_dump_cmnd);
+	} else if (hostt->eh_bus_reset_handler) {
+		spin_lock(host->host_lock);
+		ret = hostt->eh_bus_reset_handler(&scsi_dump_cmnd);
+	} else
+		return 0;
+	spin_unlock(host->host_lock);
+
+	if (ret != SUCCESS) {
+		Err("adapter reset failed");
+		return -EIO;
+	}
+
+	/* bus reset settle time. 5sec for old disk devices */
+	for (i = 0; i < 5000; i++) {
+		diskdump_update();
+		mdelay(1);
+	}
+
+	Dbg("request sense");
+	if ((ret = send_command(&scsi_dump_cmnd)) < 0) {
+		Err("sense failed");
+		return -EIO;
+	}
+	return 0;
+}
+
+static int
+scsi_dump_quiesce(struct disk_dump_device *dump_device)
+{
+	struct scsi_device *sdev = dump_device->device;
+	struct Scsi_Host *host = sdev->host;
+	int ret;
+
+	if (host->hostt->dump_ops->quiesce) {
+		ret = host->hostt->dump_ops->quiesce(sdev);
+		if (ret < 0)
+			return ret;
+	}
+
+	Dbg("do bus reset");
+	if ((ret = scsi_dump_reset(sdev)) < 0)
+		return ret;
+
+	if (sdev->scsi_level >= SCSI_2)
+		enable_write_cache(sdev);
+
+	quiesce_ok = 1;
+	return 0;
+}
+
+static int scsi_dump_rw_block(struct disk_dump_partition *dump_part, int rw,
+			      unsigned long dump_block_nr, void *buf, int len)
+{
+	struct disk_dump_device *dump_device = dump_part->device;
+	struct scsi_device *sdev = dump_device->device;
+	int block_nr = BLOCK_SECTOR(dump_block_nr);
+	int ret;
+
+	if (!quiesce_ok) {
+		Err("quiesce not called");
+		return -EIO;
+	}
+
+	ret = init_rw_command(dump_part, sdev, &scsi_dump_cmnd, rw,
+					block_nr, buf, DUMP_BLOCK_SIZE * len);
+	if (ret < 0) {
+		Err("init_rw_command failed");
+		return ret;
+	}
+	return send_command(&scsi_dump_cmnd);
+}
+
+static int
+scsi_dump_shutdown(struct disk_dump_device *dump_device)
+{
+	struct scsi_device *sdev = dump_device->device;
+	struct Scsi_Host *host = sdev->host;
+
+	if (sdev->scsi_level >= SCSI_2) {
+		init_sync_command(sdev, &scsi_dump_cmnd);
+		send_command(&scsi_dump_cmnd);
+	}
+
+	if (host->hostt->dump_ops->shutdown)
+		return host->hostt->dump_ops->shutdown(sdev);
+
+	return 0;
+}
+
+static void *scsi_dump_probe(dev_t dev)
+{
+	struct scsi_device *sdev;
+
+	sdev = sd_find_scsi_device(dev);
+	if (sdev == NULL)
+		return NULL;
+	if (!sdev->host->hostt->dump_ops)
+		return NULL;
+
+	return sdev;
+}
+
+
+struct disk_dump_device_ops scsi_dump_device_ops = {
+	.sanity_check	= scsi_dump_sanity_check,
+	.rw_block	= scsi_dump_rw_block,
+	.quiesce	= scsi_dump_quiesce,
+	.shutdown	= scsi_dump_shutdown,
+};
+
+static int scsi_dump_add_device(struct disk_dump_device *dump_device)
+{
+	struct scsi_device *sdev;
+	int error;
+
+	sdev = dump_device->device;
+	if (!sdev->host->hostt->dump_ops)
+		return -ENOTSUPP;
+
+	if ((error = scsi_device_get(sdev)) != 0)
+		return error;
+
+	memcpy(&dump_device->ops, &scsi_dump_device_ops,
+		sizeof(scsi_dump_device_ops));
+	if (sdev->host->max_sectors) {
+		dump_device->max_blocks =
+			(sdev->sector_size * sdev->host->max_sectors)
+			  >> DUMP_BLOCK_SHIFT;
+	}
+	return 0;
+}
+
+static void scsi_dump_remove_device(struct disk_dump_device *dump_device)
+{
+	struct scsi_device *sdev = dump_device->device;
+
+	scsi_device_put(sdev);
+}
+
+static struct disk_dump_type scsi_dump_type = {
+	.probe		= scsi_dump_probe,
+	.add_device	= scsi_dump_add_device,
+	.remove_device	= scsi_dump_remove_device,
+	.owner		= THIS_MODULE,
+};
+
+static int init_scsi_dump(void)
+{
+	int ret;
+
+	if ((ret = register_disk_dump_type(&scsi_dump_type)) < 0) {
+		Err("register failed");
+		return ret;
+	}
+	set_crc_modules();
+	return ret;
+}
+
+static void cleanup_scsi_dump(void)
+{
+	if (unregister_disk_dump_type(&scsi_dump_type) < 0)
+		Err("register failed");
+}
+
+module_init(init_scsi_dump);
+module_exit(cleanup_scsi_dump);
+MODULE_LICENSE("GPL");
diff -Nur linux-2.6.6.org/drivers/scsi/scsi_error.c linux-2.6.6/drivers/scsi/scsi_error.c
--- linux-2.6.6.org/drivers/scsi/scsi_error.c	2004-05-10 11:31:58.000000000 +0900
+++ linux-2.6.6/drivers/scsi/scsi_error.c	2004-06-09 22:24:30.595511918 +0900
@@ -402,6 +402,9 @@
  **/
 static void scsi_eh_done(struct scsi_cmnd *scmd)
 {
+	if (crashdump_mode())
+		return;
+
 	/*
 	 * if the timeout handler is already running, then just set the
 	 * flag which says we finished late, and return.  we have no
diff -Nur linux-2.6.6.org/drivers/scsi/scsi_syms.c linux-2.6.6/drivers/scsi/scsi_syms.c
--- linux-2.6.6.org/drivers/scsi/scsi_syms.c	2004-05-10 11:32:37.000000000 +0900
+++ linux-2.6.6/drivers/scsi/scsi_syms.c	2004-06-09 22:24:30.595511918 +0900
@@ -25,6 +25,7 @@
 #include "scsi.h"
 
 #include "scsi_logging.h"
+#include "scsi_priv.h"
 
 
 /*
@@ -107,3 +108,5 @@
  */
 EXPORT_SYMBOL(scsi_add_timer);
 EXPORT_SYMBOL(scsi_delete_timer);
+
+EXPORT_SYMBOL(scsi_decide_disposition);
diff -Nur linux-2.6.6.org/drivers/scsi/sd.c linux-2.6.6/drivers/scsi/sd.c
--- linux-2.6.6.org/drivers/scsi/sd.c	2004-05-10 11:33:05.000000000 +0900
+++ linux-2.6.6/drivers/scsi/sd.c	2004-06-09 22:24:30.596488480 +0900
@@ -192,6 +192,21 @@
 	up(&sd_ref_sem);
 }
 
+#if defined(CONFIG_DISKDUMP) || defined(CONFIG_DISKDUMP_MODULE)
+struct scsi_device *sd_find_scsi_device(dev_t dev)
+{
+	struct gendisk *disk;
+	int part;
+	disk = get_gendisk(dev, &part);
+	if(disk && disk->private_data)
+		return scsi_disk(disk)->device;
+	else
+		return NULL;
+}
+
+EXPORT_SYMBOL(sd_find_scsi_device);
+#endif
+
 /**
  *	sd_init_command - build a scsi (read or write) command from
  *	information in the request structure.
diff -Nur linux-2.6.6.org/include/scsi/scsi_dump.h linux-2.6.6/include/scsi/scsi_dump.h
--- linux-2.6.6.org/include/scsi/scsi_dump.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.6/include/scsi/scsi_dump.h	2004-06-09 22:24:30.596488480 +0900
@@ -0,0 +1,38 @@
+#ifndef _SCSI_DUMP_H
+#define _SCSI_DUMP_H
+
+/*
+ *  linux/include/scsi/scsi_dump.h
+ *
+ *  Copyright (C) 2004  FUJITSU LIMITED
+ *  Written by Nobuhiro Tachino (ntachino@jp.fujitsu.com)
+ *
+ */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+struct scsi_dump_ops {
+	int (*sanity_check)(struct scsi_device *);
+	int (*quiesce)(struct scsi_device *);
+	int (*shutdown)(struct scsi_device *);
+	void (*poll)(struct scsi_device *);
+};
+
+/* sd.c function */
+extern struct scsi_device *sd_find_scsi_device(dev_t);
+
+#endif /* _SCSI_DUMP_H */
diff -Nur linux-2.6.6.org/include/scsi/scsi_host.h linux-2.6.6/include/scsi/scsi_host.h
--- linux-2.6.6.org/include/scsi/scsi_host.h	2004-05-10 11:32:01.000000000 +0900
+++ linux-2.6.6/include/scsi/scsi_host.h	2004-06-09 22:24:30.597465043 +0900
@@ -345,6 +345,11 @@
 	 * module_init/module_exit.
 	 */
 	struct list_head legacy_hosts;
+
+	/*
+	 * operations for dump
+	 */
+	struct scsi_dump_ops *dump_ops;
 };
 
 /*
