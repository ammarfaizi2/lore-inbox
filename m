Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266389AbUFZUJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266389AbUFZUJk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 16:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266387AbUFZUJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 16:09:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41961 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266389AbUFZUGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 16:06:54 -0400
Date: Sat, 26 Jun 2004 13:06:45 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com
Cc: tburke@redhat.com, zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       <stern@rowland.harvard.edu>, <mdharm-usb@one-eyed-alien.net>,
       <david-b@pacbell.net>, <oliver@neukum.org>
Subject: drivers/block/ub.c
Message-Id: <20040626130645.55be13ce@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys,

I have drafted up an implementation of a USB storage driver as I wish
it done (called "ub"). The main goal of the project is to produce a driver
which never oopses, and above all, never locks up the machine. To this
point I did all my debugging while running X11 and yapping on IRC. If this
goal requires to sacrifice performance, so be it. This is how ub differs
from the usb-storage.

The current usb-storage works quite well on servers where netdump can
be brought to bear, but on desktop its debuggability leaves some room
for improvement. In all other respects, it is superior to ub. Since
characteristics of usb-storage and ub are different I expect them to
coexist potentially indefinitely (if ub finds any use at all).

Please refer to the attached patch. It is quite raw, for instance the
disconnect is not processed at all, although I do have a plan for it.
This posting is largely a "release early release often" excercise, as
Papa ESR taught us. But you can see the design outline clearly now,
I hope, and I'm interested in feedback on that.

Best wishes,
-- Pete

diff -urpN -X dontdiff linux-2.6.7/drivers/block/Kconfig linux-2.6.7-ub/drivers/block/Kconfig
--- linux-2.6.7/drivers/block/Kconfig	2004-06-16 16:53:48.000000000 -0700
+++ linux-2.6.7-ub/drivers/block/Kconfig	2004-06-16 17:47:14.000000000 -0700
@@ -301,6 +301,14 @@ config BLK_DEV_CARMEL
 
 	  Use devices /dev/carmel/$N and /dev/carmel/$Np$M.
 
+config BLK_DEV_UB
+	tristate "Low Performance USB Block driver"
+	depends on USB
+	help
+	  This driver supports USB attached storage devices.
+
+	  If unsure, say N.
+
 config BLK_DEV_RAM
 	tristate "RAM disk support"
 	---help---
diff -urpN -X dontdiff linux-2.6.7/drivers/block/Makefile linux-2.6.7-ub/drivers/block/Makefile
--- linux-2.6.7/drivers/block/Makefile	2004-05-10 17:39:54.000000000 -0700
+++ linux-2.6.7-ub/drivers/block/Makefile	2004-06-16 17:47:14.000000000 -0700
@@ -42,4 +42,5 @@ obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryp
 
 obj-$(CONFIG_VIODASD)		+= viodasd.o
 obj-$(CONFIG_BLK_DEV_CARMEL)	+= carmel.o
+obj-$(CONFIG_BLK_DEV_UB)	+= ub.o
 
diff -urpN -X dontdiff linux-2.6.7/drivers/block/ub.c linux-2.6.7-ub/drivers/block/ub.c
--- linux-2.6.7/drivers/block/ub.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.7-ub/drivers/block/ub.c	2004-06-26 12:39:20.258021109 -0700
@@ -0,0 +1,1511 @@
+/*
+ * The low performance USB storage driver (ub).
+ *
+ * Copyright (c) 1999, 2000 Matthew Dharm (mdharm-usb@one-eyed-alien.net)
+ * Copyright (C) 2004 Pete Zaitcev
+ *
+ * This work is a part of Linux kernel, is derived from it,
+ * and is not licensed separately. See file COPYING for details.
+ *
+ * TODO
+ *  -- disconnect, poison tests
+ *  -- use serial numbers to hook onto same hosts (same minor) after disconnect
+ *  -- verify protocol (bulk) from USB descriptors
+ *  -- do inquiry and verify we got a disk and not a tape (for LUN mismatch)
+ *  -- normal queue instead of sc->busy and friends
+ *  -- normal pool of commands
+ *  -- timers for all URBs
+ *  -- highmem and sg
+ *  -- verify that requests get merged (count 1 sector, 8 sector requests)
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/blkdev.h>
+#include <linux/devfs_fs_kernel.h>
+
+#define DRV_NAME "ub"
+
+/*
+ * Definitions which have to be scattered once we understand the layout better.
+ */
+
+/* Transport (despite PR in the name) */
+#define US_PR_BULK	0x50		/* bulk only */
+
+/* Protocol */
+#define US_SC_SCSI	0x06		/* Transparent */
+
+/*
+ * SCSI opcodes: Common, Block, Streaming.
+ */
+#define TEST_UNIT_READY	0x00
+#define REQUEST_SENSE	0x03
+#define INQUIRY		0x12
+#define READ_10		0x28	/* Block */
+#define WRITE_10	0x2a	/* Block */
+
+#define SENSE_SIZE  18
+
+/*
+ * Sense keys
+ */
+#define NO_SENSE	0x00
+#define RECOVERED_ERROR	0x01
+#define NOT_READY	0x02
+#define MEDIUM_ERROR	0x03
+#define HARDWARE_ERROR	0x04
+#define ILLEGAL_REQUEST	0x05
+#define UNIT_ATTENTION	0x06
+#define DATA_PROTECT	0x07
+#define BLANK_CHECK	0x08
+#define COPY_ABORTED	0x0a
+#define ABORTED_COMMAND	0x0b
+#define VOLUME_OVERFLOW	0x0d
+#define MISCOMPARE	0x0e
+
+/*
+ */
+#define UB_MINORS_PER_MAJOR	8
+
+#define MAX_CDB_SIZE      16		/* Corresponds to Bulk */
+
+/*
+ */
+
+/* command block wrapper */
+struct bulk_cb_wrap {
+	u32	Signature;		/* contains 'USBC' */
+	u32	Tag;			/* unique per command id */
+	u32	DataTransferLength;	/* size of data */
+	u8	Flags;			/* direction in bit 0 */
+	u8	Lun;			/* LUN normally 0 */
+	u8	Length;			/* of of the CDB */
+	u8	CDB[MAX_CDB_SIZE];	/* max command */
+};
+
+#define US_BULK_CB_WRAP_LEN	31
+#define US_BULK_CB_SIGN		0x43425355	/*spells out USBC */
+#define US_BULK_FLAG_IN		1
+#define US_BULK_FLAG_OUT	0
+
+/* command status wrapper */
+struct bulk_cs_wrap {
+	u32	Signature;		/* should = 'USBS' */
+	u32	Tag;			/* same as original command */
+	u32	Residue;		/* amount not transferred */
+	u8	Status;			/* see below */
+};
+
+#define US_BULK_CS_WRAP_LEN	13
+#define US_BULK_CS_SIGN		0x53425355	/* spells out 'USBS' */
+/* This is for Olympus Camedia digital cameras */
+#define US_BULK_CS_OLYMPUS_SIGN	0x55425355	/* spells out 'USBU' */
+#define US_BULK_STAT_OK		0
+#define US_BULK_STAT_FAIL	1
+#define US_BULK_STAT_PHASE	2
+
+/* bulk-only class specific requests */
+#define US_BULK_RESET_REQUEST	0xff
+#define US_BULK_GET_MAX_LUN	0xfe
+
+/*
+ */
+struct ub_dev;
+
+#define UB_MAX_REQ_SG	1
+
+/*
+ * An instance of a SCSI command in transit.
+ */
+#define UB_DIR_NONE	0
+#define UB_DIR_READ	1
+#define UB_DIR_ILLEGAL2	2
+#define UB_DIR_WRITE	3
+
+enum ub_scsi_cmd_state {
+	UB_CMDST_INIT,			/* Initial state */
+	UB_CMDST_CMD,			/* Command submitted */
+	UB_CMDST_DATA,			/* Data phase */
+	UB_CMDST_CLR2STS,		/* Clearing before requesting status */
+	UB_CMDST_STAT,			/* Status phase */
+	UB_CMDST_CLEAR,			/* Clearing a stall (halt, actually) */
+	UB_CMDST_SENSE,			/* Sending Request Sense */
+	UB_CMDST_DONE			/* Final state */
+};
+
+struct ub_scsi_cmd {
+	unsigned char cdb[MAX_CDB_SIZE];
+	unsigned char cdb_len;
+
+	unsigned char dir;		/* 0 - none, 1 - read, 3 - write. */
+	enum ub_scsi_cmd_state state;
+	unsigned int tag;
+
+	int error;			/* Return code - valid upon done */
+	int act_len;			/* Return size */
+
+	int stat_count;			/* Retries getting status. */
+
+	/*
+	 * We do not support transfers from highmem pages
+	 * because the underlying USB framework does not.
+	 *
+	 * XXX Actually, there is a (very fresh and buggy) support
+	 * for transfers under control of struct scatterlist, usb_map_sg()
+	 * in 2.6.6, but it seems to have issues with highmem.
+	 */
+	char *data;			/* Requested buffer */
+	unsigned int len;		/* Requested length */
+	// struct scatterlist sgv[UB_MAX_REQ_SG];
+
+	void (*done)(struct ub_dev *, struct ub_scsi_cmd *);
+	void *back;
+};
+
+/*
+ */
+struct ub_capacity {
+	unsigned long nsec;		/* Linux size - 512 byte sectors */
+	unsigned int bsize;		/* Linux hardsect_size */
+	unsigned int bshift;		/* Shift between 512 and hard sects */
+};
+
+/*
+ * The SCSI command tracing structure.
+ */
+
+#define SCMD_ST_HIST_SZ   8
+#define SCMD_TRACE_SZ     5
+
+struct ub_scsi_cmd_trace {
+	unsigned int tag;
+	unsigned char op;
+	unsigned char dir;
+	unsigned int req_size, act_size;
+	int hcur;
+	enum ub_scsi_cmd_state st_hst[SCMD_ST_HIST_SZ];		/* u8? */
+};
+
+struct ub_scsi_trace {
+	int cur;
+	struct ub_scsi_cmd_trace vec[SCMD_TRACE_SZ];
+};
+
+/*
+ * The UB device instance.
+ */
+struct ub_dev {
+	spinlock_t lock;
+	unsigned int id;		/* Number among ub's */
+
+	unsigned int tagcnt;
+	int poison;
+	char name[8];
+	struct usb_device *dev;
+	struct usb_interface *intf;
+
+	struct ub_capacity capacity; 
+	struct gendisk *disk;
+
+	unsigned int send_bulk_pipe;  /* cached pipe values */
+	unsigned int recv_bulk_pipe;
+	unsigned int send_ctrl_pipe;
+	unsigned int recv_ctrl_pipe;
+
+	struct tasklet_struct urb_tasklet;
+
+	/* XXX Use Ingo's mempool (once we have more than one) */
+	int cmda[1];
+	struct ub_scsi_cmd cmdv[1];
+
+	int busy;
+	struct ub_scsi_cmd *top_cmd;	/* XXX Under ->busy until we have a queue */
+	struct ub_scsi_cmd top_rqs_cmd;	/* REQUEST SENSE */
+	unsigned char top_sense[SENSE_SIZE];
+
+	struct urb work_urb;
+	int last_pipe;			/* What might need clearing */
+	struct bulk_cb_wrap work_bcb;
+	struct bulk_cs_wrap work_bcs;
+	struct usb_ctrlrequest work_cr;
+
+	struct ub_scsi_trace tr;
+};
+
+/*
+ */
+static void ub_rw_cmd_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
+static void ub_end_rq(struct request *rq, int uptodate);
+static int ub_submit_scsi(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
+static void ub_scsi_urb_complete(struct urb *urb, struct pt_regs *pt);
+static void ub_scsi_urb_action(unsigned long _dev);
+static void ub_scsi_urb_compl(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
+static void ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
+static int ub_submit_clear_stall(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
+    int stalled_pipe);
+static int ub_submit_top_sense(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
+
+/*
+ */
+static struct usb_device_id ub_usb_ids[] = {
+	{ USB_DEVICE_VER(0x0781, 0x0002, 0x0009, 0x0009) },	/* SDDR-31 */
+	{ }
+};
+
+MODULE_DEVICE_TABLE(usb, ub_usb_ids);
+
+static unsigned int ub_host_id;
+
+/*
+ * The SCSI command tracing procedures.
+ */
+
+static void ub_cmdtr_new(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	int n;
+	struct ub_scsi_cmd_trace *t;
+
+	if ((n = sc->tr.cur + 1) == SCMD_TRACE_SZ) n = 0;
+	t = &sc->tr.vec[n];
+
+	memset(t, 0, sizeof(struct ub_scsi_cmd_trace));
+	t->tag = cmd->tag;
+	t->op = cmd->cdb[0];
+	t->dir = cmd->dir;
+	t->req_size = cmd->len;
+	t->st_hst[0] = cmd->state;
+
+	sc->tr.cur = n;
+}
+
+static void ub_cmdtr_state(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	int n;
+	struct ub_scsi_cmd_trace *t;
+
+	t = &sc->tr.vec[sc->tr.cur];
+	if ((n = t->hcur + 1) == SCMD_ST_HIST_SZ) n = 0;
+	t->st_hst[n] = cmd->state;
+	t->hcur = n;
+}
+
+static void ub_cmdtr_act_len(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	struct ub_scsi_cmd_trace *t;
+
+	t = &sc->tr.vec[sc->tr.cur];
+	t->act_size = cmd->act_len;
+}
+
+/* The struct disk_attribute must match drivers/block/genhd.c */
+struct disk_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct gendisk *, char *);
+};
+
+static ssize_t ub_sysdiag_show(struct gendisk *disk, char *page)
+{
+	struct ub_dev *sc = disk->private_data;
+	int cnt = 0;
+	unsigned long flags;
+	int nc, nh;
+	int i, j;
+	struct ub_scsi_cmd_trace *t;
+
+	spin_lock_irqsave(&sc->lock, flags);
+	if ((nc = sc->tr.cur + 1) == SCMD_TRACE_SZ) nc = 0;
+	for (j = 0; j < SCMD_TRACE_SZ; j++) {
+		t = &sc->tr.vec[nc];
+
+		cnt += sprintf(page + cnt, "%08x %02x", t->tag, t->op);
+		cnt += sprintf(page + cnt, " %d", t->dir);
+		cnt += sprintf(page + cnt, " [%5d %5d]", t->req_size, t->act_size);
+		if ((nh = t->hcur + 1) == SCMD_ST_HIST_SZ) nh = 0;
+		for (i = 0; i < SCMD_ST_HIST_SZ; i++) {
+			cnt += sprintf(page + cnt, " %d", t->st_hst[nh]);
+			if (++nh == SCMD_ST_HIST_SZ) nh = 0;
+		}
+		cnt += sprintf(page + cnt, "\n");
+
+		if (++nc == SCMD_TRACE_SZ) nc = 0;
+	}
+	spin_unlock_irqrestore(&sc->lock, flags);
+	return cnt;
+}
+
+static struct disk_attribute ub_sysdiag_attr = {
+        .attr = {.name = "diag", .mode = S_IRUGO },
+	.show = ub_sysdiag_show
+};
+
+static int ub_sysdiag_create(struct ub_dev *sc)
+{
+	return sysfs_create_file(&sc->disk->kobj, &ub_sysdiag_attr.attr);
+}
+
+/*
+ * The "command allocator".
+ */
+static struct ub_scsi_cmd *ub_get_cmd(struct ub_dev *sc)
+{
+	struct ub_scsi_cmd *ret;
+
+	if (sc->cmda[0])
+		return NULL;
+	ret = &sc->cmdv[0];
+	sc->cmda[0] = 1;
+	return ret;
+}
+
+static void ub_put_cmd(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	if (cmd != &sc->cmdv[0]) {
+		printk(KERN_WARNING DRV_NAME ": "
+		    "releasing a foreign cmd %p\n", cmd);
+		return;
+	}
+	if (!sc->cmda[0]) {
+		printk(KERN_WARNING DRV_NAME ": "
+		    "releasing a free cmd\n");
+		return;
+	}
+	sc->cmda[0] = 0;
+}
+
+/*
+ * The request function is our main entry point
+ */
+
+static inline int ub_bd_rq_fn_1(request_queue_t *q)
+{
+#if 0
+	int writing = 0, pci_dir, i, n_elem;
+	u32 tmp;
+	unsigned int msg_size;
+#endif
+	struct ub_dev *sc = q->queuedata;
+	struct request *rq;
+#if 0 /* We use rq->buffer for now */
+	struct scatterlist *sg;
+	int n_elem;
+#endif
+	struct ub_scsi_cmd *cmd;
+	int ub_dir;
+	unsigned int block, nblks;
+	int rc;
+
+	if ((rq = elv_next_request(q)) == NULL)
+		return 1;
+
+	if ((cmd = ub_get_cmd(sc)) == NULL) {
+		blk_stop_queue(q);
+		return 1;
+	}
+
+	blkdev_dequeue_request(rq);
+
+	if (rq_data_dir(rq) == WRITE)
+		ub_dir = UB_DIR_WRITE;
+	else
+		ub_dir = UB_DIR_READ;
+
+	/*
+	 * get scatterlist from block layer
+	 */
+#if 0 /* We use rq->buffer for now */
+	sg = &cmd->sgv[0];
+	n_elem = blk_rq_map_sg(q, rq, sg);
+	if (n_elem <= 0) {
+		ub_put_cmd(sc, cmd);
+		ub_end_rq(rq, 0);
+		blk_start_queue(q);
+		return 0;		/* request with no s/g entries? */
+	}
+
+	if (n_elem != 1) {		/* Paranoia */
+		printk(KERN_WARNING DRV_NAME ": request with %d segments\n",
+		    n_elem);
+		ub_put_cmd(sc, cmd);
+		ub_end_rq(rq, 0);
+		blk_start_queue(q);
+		return 0;
+	}
+#endif
+	/*
+	 * XXX Unfortunately, this check does not work. It is quite possible
+	 * to get bogus non-null rq->buffer if you allow sg by mistake.
+	 */
+	if (rq->buffer == NULL) {
+		/*
+		 * This must not happen if we set the queue right.
+		 * The block level must create bounce buffers for us.
+		 */
+		static int do_print = 1;
+		if (do_print) {
+			printk(KERN_WARNING DRV_NAME ": unmapped request\n");
+			do_print = 0;
+		}
+		ub_put_cmd(sc, cmd);
+		ub_end_rq(rq, 0);
+		blk_start_queue(q);
+		return 0;
+	}
+
+#if 0 /* Just to show what carmel does in this place... We won't need this. */
+	/* map scatterlist to PCI bus addresses */
+	n_elem = pci_map_sg(host->pdev, sg, n_elem, pci_dir);
+	if (n_elem <= 0) {
+		carm_end_rq(host, crq, 0);
+		return 1;		/* request with no s/g entries? */
+	}
+	crq->n_elem = n_elem;
+	crq->port = port;
+	host->hw_sg_used += n_elem;
+#endif
+
+	/*
+	 * build the command
+	 */
+	block = rq->sector;
+	nblks = rq->nr_sectors;
+
+	memset(cmd, 0, sizeof(struct ub_scsi_cmd));
+	cmd->cdb[0] = (ub_dir == UB_DIR_READ)? READ_10: WRITE_10;
+	/* 10-byte uses 4 bytes of LBA: 2147483648KB, 2097152MB, 2048GB */
+	cmd->cdb[2] = block >> 24;
+	cmd->cdb[3] = block >> 16;
+	cmd->cdb[4] = block >> 8;
+	cmd->cdb[5] = block;
+	cmd->cdb[7] = nblks >> 8;
+	cmd->cdb[8] = nblks;
+	cmd->cdb_len = 10;
+	cmd->dir = ub_dir;
+	cmd->state = UB_CMDST_INIT;
+	cmd->data = rq->buffer;
+	cmd->len = nblks * 512;
+	cmd->done = ub_rw_cmd_done;
+	cmd->back = rq;
+
+	cmd->tag = sc->tagcnt++;
+	if ((rc = ub_submit_scsi(sc, cmd)) != 0) {
+		/* P3 */ printk("ub: cannot submit rw (%d)\n", rc);
+		ub_put_cmd(sc, cmd);
+		ub_end_rq(rq, 0);
+		blk_start_queue(q);
+		return 0;
+	}
+
+	return 0;
+}
+
+static void ub_bd_rq_fn(request_queue_t *q)
+{
+	do { } while (ub_bd_rq_fn_1(q) == 0);
+}
+
+static void ub_rw_cmd_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	struct request *rq = cmd->back;
+	struct gendisk *disk = sc->disk;
+	request_queue_t *q = disk->queue;
+	int uptodate;
+
+	if (cmd->error == 0)
+		uptodate = 1;
+	else
+		uptodate = 0;
+
+	ub_put_cmd(sc, cmd);
+	ub_end_rq(rq, uptodate);
+	blk_start_queue(q);
+}
+
+static void ub_end_rq(struct request *rq, int uptodate)
+{
+	int rc;
+
+	rc = end_that_request_first(rq, uptodate, rq->hard_nr_sectors);
+	// assert(rc == 0);
+	end_that_request_last(rq);
+}
+
+/*
+ * Submit a SCSI operation.
+ *
+ * This is only called customarily from a soft interrupt or a process,
+ * so it can call back without worrying about a recursion.
+ *
+ * The Iron Law of Good Submit Routine is:
+ * Zero return - callback is done, Nonzero return - callback is not done.
+ * No exceptions.
+ *
+ * Host is assumed locked.
+ *
+ * XXX We only support Bulk for the moment.
+ */
+static int ub_submit_scsi(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	struct bulk_cb_wrap *bcb;
+	int rc;
+
+	/*
+	 * We do not trap into BUG() here because the consequences are
+	 * sporadic stack overflows. Better to warn than to die outright.
+	 */
+	if (in_irq()) {
+		static int first_warning = 1;
+		if (first_warning) {
+			printk(KERN_WARNING DRV_NAME ": "
+			    "submitting command from a hard irq\n");
+			first_warning = 0;
+		}
+	}
+
+	/* XXX Set up a queue */
+	if (cmd != &sc->top_rqs_cmd) {	/* XXX This is getting out of hand. */
+		if (sc->busy)
+			return -EBUSY;
+		sc->busy = 1;
+		sc->top_cmd = cmd;
+	} else {
+		if (!sc->busy) {
+			/* P3 */ printk("ub: sensing while not busy\n");
+			return -EBUSY;
+		}
+	}
+
+	ub_cmdtr_new(sc, cmd);
+
+	if (cmd->state != UB_CMDST_INIT ||
+	    (cmd->dir != UB_DIR_NONE && cmd->len == 0)) {
+		sc->top_cmd = NULL;
+		sc->busy = 0;
+		return -EINVAL;
+	}
+
+	bcb = &sc->work_bcb;
+
+	/* set up the command wrapper */
+	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
+	bcb->Tag = cmd->tag;		/* Endianness is not important */
+	bcb->DataTransferLength = cpu_to_le32(cmd->len);
+	bcb->Flags = (cmd->dir == UB_DIR_READ) ? 0x80 : 0;
+	bcb->Lun = 0;			/* No multi-LUN yet */
+	bcb->Length = cmd->cdb_len;
+
+	/* copy the command payload */
+	memcpy(bcb->CDB, cmd->cdb, MAX_CDB_SIZE);
+
+	sc->last_pipe = sc->send_bulk_pipe;
+	usb_fill_bulk_urb(&sc->work_urb, sc->dev, sc->send_bulk_pipe,
+	    bcb, US_BULK_CB_WRAP_LEN,
+	    ub_scsi_urb_complete, sc);
+
+	/* Fill what we shouldn't be filling just because usb-storage did. */
+	sc->work_urb.actual_length = 0;
+	sc->work_urb.error_count = 0;
+	sc->work_urb.status = 0;
+
+	/* XXX Add a timeout (always, because we have no aborts) */
+
+	if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
+
+		/* XXX Clear stalls */
+		printk("ub: cmd #%d submit failed (%d)\n", cmd->tag, rc); /* P3 */
+
+		cmd->state = UB_CMDST_DONE;
+		ub_cmdtr_state(sc, cmd);
+		sc->busy = 0;
+		sc->top_cmd = NULL;
+		return rc;
+	}
+
+	cmd->state = UB_CMDST_CMD;
+	ub_cmdtr_state(sc, cmd);
+	return 0;
+}
+
+/*
+ * Completion routine for the work URB.
+ *
+ * This can be called directly from usb_submit_urb (while we have
+ * the sc->lock taken) and from an interrupt (while we do NOT have
+ * the sc->lock taken). Therefore, bounce this off to a tasklet.
+ */
+static void ub_scsi_urb_complete(struct urb *urb, struct pt_regs *pt)
+{
+	struct ub_dev *sc = urb->context;
+
+	tasklet_schedule(&sc->urb_tasklet);
+}
+
+static void ub_scsi_urb_action(unsigned long _dev)
+{
+	struct ub_dev *sc = (struct ub_dev *) _dev;
+	unsigned long flags;
+	struct ub_scsi_cmd *cmd;
+
+	spin_lock_irqsave(&sc->lock, flags);
+	if (sc->busy) {
+		cmd = sc->top_cmd;
+		if (cmd->state == UB_CMDST_SENSE) {	/* XXX Kludgy */
+			cmd = &sc->top_rqs_cmd;
+		}
+		ub_scsi_urb_compl(sc, cmd);
+	} else {
+		/* Never happens */
+		/* P3 */ printk("ub: Action on idle device\n");
+	}
+	spin_unlock_irqrestore(&sc->lock, flags);
+}
+
+static void ub_scsi_urb_compl(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	struct urb *urb = &sc->work_urb;
+	struct bulk_cs_wrap *bcs;
+	int pipe;
+	int rc;
+
+/* P3 */ printk("ub: urb status %d pipe 0x%08x len %d act %d\n",
+ urb->status, urb->pipe, urb->transfer_buffer_length, urb->actual_length);
+
+	/* XXX if (sc->poison) */
+
+	if (cmd->state == UB_CMDST_CLEAR) {
+		if (urb->status == -EPIPE) {
+			/*
+			 * STALL while clearning STALL.
+			 * A STALL is illegal on a control pipe!
+			 * XXX Might try to reset the device here and retry.
+			 */
+			printk(KERN_NOTICE DRV_NAME ": "
+			    "stall on control pipe for device %u\n",
+			    sc->dev->devnum);
+			goto Bad_End;
+		}
+
+		/*
+		 * We ignore the result for the halt clear.
+		 */
+
+		/* reset the toggles and endpoint flags */
+		usb_endpoint_running(sc->dev, usb_pipeendpoint(sc->last_pipe),
+			usb_pipeout(sc->last_pipe));
+		usb_settoggle(sc->dev, usb_pipeendpoint(sc->last_pipe),
+			usb_pipeout(sc->last_pipe), 0);
+
+		if (cmd->cdb[0] == REQUEST_SENSE) {
+			cmd->error = -EPIPE;
+			cmd->state = UB_CMDST_DONE;
+			ub_cmdtr_state(sc, cmd);
+			if (cmd != &sc->top_rqs_cmd) {	/* XXX This is getting out of hand. */
+				sc->busy = 0;
+				sc->top_cmd = NULL;
+			}
+			(*cmd->done)(sc, cmd);
+			return;
+		}
+
+		memset(&sc->top_sense, 0, SENSE_SIZE);
+		if ((rc = ub_submit_top_sense(sc, cmd)) != 0) {
+			printk(KERN_NOTICE DRV_NAME ": "
+			    "unable to submit sense for device %u (%d)\n",
+			    sc->dev->devnum, rc);
+			goto Bad_End;
+		}
+		cmd->state = UB_CMDST_SENSE;
+		ub_cmdtr_state(sc, cmd);
+
+	} else if (cmd->state == UB_CMDST_CLR2STS) {
+		if (urb->status == -EPIPE) {
+			/*
+			 * STALL while clearning STALL.
+			 * A STALL is illegal on a control pipe!
+			 * XXX Might try to reset the device here and retry.
+			 */
+			printk(KERN_NOTICE DRV_NAME ": "
+			    "stall on control pipe for device %u\n",
+			    sc->dev->devnum);
+			goto Bad_End;
+		}
+
+		/*
+		 * We ignore the result for the halt clear.
+		 */
+
+		/* reset the toggles and endpoint flags */
+		usb_endpoint_running(sc->dev, usb_pipeendpoint(sc->last_pipe),
+			usb_pipeout(sc->last_pipe));
+		usb_settoggle(sc->dev, usb_pipeendpoint(sc->last_pipe),
+			usb_pipeout(sc->last_pipe), 0);
+
+		ub_state_stat(sc, cmd);
+
+	} else if (cmd->state == UB_CMDST_CMD) {
+		if (urb->status == -EPIPE) {
+			rc = ub_submit_clear_stall(sc, cmd, sc->last_pipe);
+			if (rc != 0) {
+				printk(KERN_NOTICE DRV_NAME ": "
+				    "unable to submit clear for device %u (%d)\n",
+				    sc->dev->devnum, rc);
+				/*
+				 * This is typically ENOMEM or some other such shit.
+				 * Retrying is pointless. Just do Bad End on it...
+				 */
+				goto Bad_End;
+			}
+			cmd->state = UB_CMDST_CLEAR;
+			ub_cmdtr_state(sc, cmd);
+			return;
+		}
+		if (urb->status != 0)
+			goto Bad_End;
+		if (urb->actual_length != US_BULK_CB_WRAP_LEN) {
+			/* XXX Must do reset here to unconfuse the device */
+			goto Bad_End;
+		}
+
+		if (cmd->dir == UB_DIR_NONE) {
+			ub_state_stat(sc, cmd);
+			return;
+		}
+
+		if (cmd->dir == UB_DIR_READ)
+			pipe = sc->recv_bulk_pipe;
+		else
+			pipe = sc->send_bulk_pipe;
+		sc->last_pipe = pipe;
+		usb_fill_bulk_urb(&sc->work_urb, sc->dev, pipe,
+		    cmd->data, cmd->len,
+		    ub_scsi_urb_complete, sc);
+		sc->work_urb.actual_length = 0;
+		sc->work_urb.error_count = 0;
+		sc->work_urb.status = 0;
+
+		if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
+
+			/* XXX Clear stalls */
+			printk("ub: data #%d submit failed (%d)\n", cmd->tag, rc); /* P3 */
+
+			cmd->error = rc;
+			cmd->state = UB_CMDST_DONE;
+			ub_cmdtr_state(sc, cmd);
+			if (cmd != &sc->top_rqs_cmd) {	/* XXX This is getting out of hand. */
+				sc->busy = 0;
+				sc->top_cmd = NULL;
+			}
+			(*cmd->done)(sc, cmd);
+			return;
+		}
+
+		cmd->state = UB_CMDST_DATA;
+		ub_cmdtr_state(sc, cmd);
+
+	} else if (cmd->state == UB_CMDST_DATA) {
+		if (urb->status == -EPIPE) {
+			rc = ub_submit_clear_stall(sc, cmd, sc->last_pipe);
+			if (rc != 0) {
+				printk(KERN_NOTICE DRV_NAME ": "
+				    "unable to submit clear for device %u (%d)\n",
+				    sc->dev->devnum, rc);
+				/*
+				 * This is typically ENOMEM or some other such shit.
+				 * Retrying is pointless. Just do Bad End on it...
+				 */
+				goto Bad_End;
+			}
+			cmd->state = UB_CMDST_CLR2STS;
+			ub_cmdtr_state(sc, cmd);
+			return;
+		}
+		if (urb->status == -EOVERFLOW) {
+			/*
+			 * A babble? Failure, but we must transfer CSW now.
+			 */
+			cmd->error = -EOVERFLOW;	/* A cheap trick... */
+		} else {
+			if (urb->status != 0)
+				goto Bad_End;
+		}
+
+		cmd->act_len = urb->actual_length;
+		ub_cmdtr_act_len(sc, cmd);
+
+		ub_state_stat(sc, cmd);
+
+	} else if (cmd->state == UB_CMDST_STAT) {
+		if (urb->status == -EPIPE) {
+			rc = ub_submit_clear_stall(sc, cmd, sc->last_pipe);
+			if (rc != 0) {
+				printk(KERN_NOTICE DRV_NAME ": "
+				    "unable to submit clear for device %u (%d)\n",
+				    sc->dev->devnum, rc);
+				/*
+				 * This is typically ENOMEM or some other such shit.
+				 * Retrying is pointless. Just do Bad End on it...
+				 */
+				goto Bad_End;
+			}
+			cmd->state = UB_CMDST_CLEAR;
+			ub_cmdtr_state(sc, cmd);
+			return;
+		}
+		if (urb->status != 0)
+			goto Bad_End;
+
+		if (urb->actual_length == 0) {
+			/*
+			 * Some broken devices add unnecessary zero-length
+			 * packets to the end of their data transfers.
+			 * Such packets show up as 0-length CSWs. If we
+			 * encounter such a thing, try to read the CSW again.
+			 */
+			if (++cmd->stat_count >= 4) {
+				printk(KERN_NOTICE DRV_NAME ": "
+				    "unable to get CSW on device %u\n",
+				    sc->dev->devnum);
+				goto Bad_End;
+			}
+
+			/*
+			 * ub_state_stat only not dropping the count...
+			 */
+			sc->last_pipe = sc->recv_bulk_pipe;
+			usb_fill_bulk_urb(&sc->work_urb, sc->dev,
+			    sc->recv_bulk_pipe, &sc->work_bcs,
+			    US_BULK_CS_WRAP_LEN, ub_scsi_urb_complete, sc);
+			sc->work_urb.actual_length = 0;
+			sc->work_urb.error_count = 0;
+			sc->work_urb.status = 0;
+
+			rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC);
+			if (rc != 0) {
+				/* XXX Clear stalls */
+				printk("ub: CSW #%d submit failed (%d)\n", cmd->tag, rc); /* P3 */
+
+				cmd->error = rc;
+				cmd->state = UB_CMDST_DONE;
+				ub_cmdtr_state(sc, cmd);
+				if (cmd != &sc->top_rqs_cmd) {	/* XXX This is getting out of hand. */
+					sc->busy = 0;
+					sc->top_cmd = NULL;
+				}
+				(*cmd->done)(sc, cmd);
+				return;
+			}
+			return;
+		}
+
+		/*
+		 * Check the returned Bulk protocol status.
+		 */
+
+		bcs = &sc->work_bcs;
+		rc = le32_to_cpu(bcs->Residue);
+		if (rc != cmd->len - cmd->act_len) {
+			/*
+			 * It is all right to transfer less, the caller has
+			 * to check. But it's not all right if the device
+			 * counts disagree with our counts.
+			 */
+			/* P3 */ printk("ub: resid %d len %d act %d\n",
+			    rc, cmd->len, cmd->act_len);
+			goto Bad_End;
+		}
+
+		if (bcs->Signature != cpu_to_le32(US_BULK_CS_SIGN) &&
+		    bcs->Signature != cpu_to_le32(US_BULK_CS_OLYMPUS_SIGN)) {
+			/* XXX Rate-limit, even for P3 tagged */
+			/* P3 */ printk("ub: signature 0x%x\n", bcs->Signature);
+			/* Windows ignores signatures, so do we. */
+		}
+
+		if (bcs->Tag != cmd->tag) {
+			/* P3 */ printk("ub: tag orig 0x%x reply 0x%x\n",
+			    cmd->tag, bcs->Tag);
+			goto Bad_End;
+		}
+
+		switch (bcs->Status) {
+		case US_BULK_STAT_OK:
+			break;
+
+		case US_BULK_STAT_FAIL:
+			/* P3 */ printk("ub: status FAIL\n");
+			goto Bad_End;
+
+		case US_BULK_STAT_PHASE:
+			/* XXX We must reset the transport here */
+			/* P3 */ printk("ub: status PHASE\n");
+			goto Bad_End;
+		}
+
+		cmd->state = UB_CMDST_DONE;
+		ub_cmdtr_state(sc, cmd);
+		if (cmd != &sc->top_rqs_cmd) {	/* XXX This is getting out of hand. */
+			sc->busy = 0;
+			sc->top_cmd = NULL;
+		}
+		(*cmd->done)(sc, cmd);
+
+	} else if (cmd->state == UB_CMDST_SENSE) {
+		if (urb->status == -EPIPE) {
+			/*
+			 * This is not possible, because other instance
+			 * of a command state machine processes this.
+			 * Definitely badend this shit, and do non-P3 warning.
+			 */
+			printk(KERN_NOTICE DRV_NAME ": "
+			    "stall while sensing device %u\n",
+			    sc->dev->devnum);
+			goto Bad_End;
+		}
+		if (urb->status != 0)
+			goto Bad_End;
+
+		/* 
+		 * We do not look at sense, because even if there was no
+		 * sense, we only get into UB_CMDST_SENSE from a STALL.
+		 * We request sense because we want to clear CHECK CONDITION
+		 * on devices with delusions of SCSI, and not because we
+		 * are curious in any way about the sense itself.
+		 */
+		/* if ((cmd->top_sense[2] & 0x0F) == NO_SENSE) ..... */
+
+		cmd->error = -EIO;
+		cmd->state = UB_CMDST_DONE;
+		ub_cmdtr_state(sc, cmd);
+		if (cmd != &sc->top_rqs_cmd) {	/* XXX This is getting out of hand. */
+			sc->busy = 0;
+			sc->top_cmd = NULL;
+		}
+		(*cmd->done)(sc, cmd);
+	} else {
+		printk(KERN_WARNING DRV_NAME ": "
+		    "wrong command state %d on device %u\n",
+		    cmd->state, sc->dev->devnum);
+		goto Bad_End;
+	}
+	return;
+
+Bad_End: /* 4chan R.I.P. XXX Remove later when have processing for aborts. */
+	cmd->error = -EIO;
+	cmd->state = UB_CMDST_DONE;
+	ub_cmdtr_state(sc, cmd);
+	if (cmd != &sc->top_rqs_cmd) {	/* XXX This is getting out of hand. */
+		sc->busy = 0;
+		sc->top_cmd = NULL;
+	}
+	(*cmd->done)(sc, cmd);
+}
+
+/*
+ * Factorization helper for the command state machine:
+ * Submit a CSW read and go to STAT state.
+ */
+static void ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	int rc;
+
+	sc->last_pipe = sc->recv_bulk_pipe;
+	usb_fill_bulk_urb(&sc->work_urb, sc->dev, sc->recv_bulk_pipe,
+	    &sc->work_bcs, US_BULK_CS_WRAP_LEN,
+	    ub_scsi_urb_complete, sc);
+	sc->work_urb.actual_length = 0;
+	sc->work_urb.error_count = 0;
+	sc->work_urb.status = 0;
+
+	if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
+
+		/* XXX Clear stalls */
+		printk("ub: CSW #%d submit failed (%d)\n", cmd->tag, rc); /* P3 */
+
+		cmd->error = rc;
+		cmd->state = UB_CMDST_DONE;
+		ub_cmdtr_state(sc, cmd);
+		if (cmd != &sc->top_rqs_cmd) {	/* XXX This is getting out of hand. */
+			sc->busy = 0;
+			sc->top_cmd = NULL;
+		}
+		(*cmd->done)(sc, cmd);
+		return;
+	}
+
+	cmd->stat_count = 0;
+	cmd->state = UB_CMDST_STAT;
+	ub_cmdtr_state(sc, cmd);
+}
+
+/*
+ * A helper for the command's state machine:
+ * Submit a stall clear.
+ */
+static int ub_submit_clear_stall(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
+    int stalled_pipe)
+{
+	int endp;
+	struct usb_ctrlrequest *cr;
+
+	endp = usb_pipeendpoint(stalled_pipe);
+	if (usb_pipein (stalled_pipe))
+		endp |= USB_DIR_IN;
+
+	cr = &sc->work_cr;
+	cr->bRequestType = USB_RECIP_ENDPOINT;
+	cr->bRequest = USB_REQ_CLEAR_FEATURE;
+	cr->wValue = cpu_to_le16(USB_ENDPOINT_HALT);
+	cr->wIndex = cpu_to_le16(endp);
+	cr->wLength = cpu_to_le16(0);
+
+	usb_fill_control_urb(&sc->work_urb, sc->dev, sc->send_ctrl_pipe,
+	    (unsigned char*) cr, NULL, 0,
+	    ub_scsi_urb_complete, sc);
+
+	sc->work_urb.actual_length = 0;
+	sc->work_urb.error_count = 0;
+	sc->work_urb.status = 0;
+
+	return usb_submit_urb(&sc->work_urb, GFP_ATOMIC);
+}
+
+/*
+ */
+static void ub_top_sense_done(struct ub_dev *sc, struct ub_scsi_cmd *scmd)
+{
+	unsigned char *sense = scmd->data;
+	struct ub_scsi_cmd *cmd;
+
+	printk("ub: sense bytes %d key 0x%x asc 0x%x ascq 0x%x\n",
+	    sense[7], sense[2] & 0x0F, sense[12], sense[13]); /* P3 */
+
+	if (!sc->busy) {	/* P3 */
+		printk(KERN_WARNING DRV_NAME ": sense done while idle\n");
+		return;
+	}
+	cmd = scmd->back;
+	if (cmd->state != UB_CMDST_SENSE) {
+		printk(KERN_WARNING DRV_NAME ": "
+		    "sense done with bad cmd state %d on device %u\n",
+		    cmd->state, sc->dev->devnum);
+		return;
+	}
+
+	ub_scsi_urb_compl(sc, cmd);
+}
+
+static int ub_submit_top_sense(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	struct ub_scsi_cmd *scmd;
+
+	scmd = &sc->top_rqs_cmd;
+
+	/* XXX Can be done at init */
+	scmd->cdb[0] = REQUEST_SENSE;
+	scmd->cdb_len = 6;
+	scmd->dir = UB_DIR_READ;
+	scmd->state = UB_CMDST_INIT;
+	scmd->data = sc->top_sense;
+	scmd->len = SENSE_SIZE;
+	scmd->done = ub_top_sense_done;
+	scmd->back = cmd;
+
+	scmd->tag = sc->tagcnt++;
+	return ub_submit_scsi(sc, scmd);
+}
+
+#if 0
+/* Determine what the maximum LUN supported is */
+int usb_stor_Bulk_max_lun(struct us_data *us)
+{
+	int result;
+
+	/* issue the command */
+	result = usb_stor_control_msg(us, us->recv_ctrl_pipe,
+				 US_BULK_GET_MAX_LUN, 
+				 USB_DIR_IN | USB_TYPE_CLASS | 
+				 USB_RECIP_INTERFACE,
+				 0, us->ifnum, us->iobuf, 1, HZ);
+
+	/* 
+	 * Some devices (i.e. Iomega Zip100) need this -- apparently
+	 * the bulk pipes get STALLed when the GetMaxLUN request is
+	 * processed.   This is, in theory, harmless to all other devices
+	 * (regardless of if they stall or not).
+	 */
+	if (result < 0) {
+		usb_stor_clear_halt(us, us->recv_bulk_pipe);
+		usb_stor_clear_halt(us, us->send_bulk_pipe);
+	}
+
+	US_DEBUGP("GetMaxLUN command result is %d, data is %d\n", 
+		  result, us->iobuf[0]);
+
+	/* if we have a successful request, return the result */
+	if (result == 1)
+		return us->iobuf[0];
+
+	/* return the default -- no LUNs */
+	return 0;
+}
+#endif
+
+static int ub_bd_ioctl(struct inode *inode, struct file *filp,
+    unsigned int cmd, unsigned long arg)
+{
+// void __user *usermem = (void *) arg;
+// struct carm_port *port = ino->i_bdev->bd_disk->private_data;
+// struct hd_geometry geom;
+
+#if 0
+	switch (cmd) {
+	case HDIO_GETGEO:
+		if (usermem == NULL)		// XXX Bizzare. Why?
+			return -EINVAL;
+
+		geom.heads = (u8) port->dev_geom_head;
+		geom.sectors = (u8) port->dev_geom_sect;
+		geom.cylinders = port->dev_geom_cyl;
+		geom.start = get_start_sect(ino->i_bdev);
+
+		if (copy_to_user(usermem, &geom, sizeof(geom)))
+			return -EFAULT;
+		return 0;
+
+	default: ;
+	}
+#endif
+
+	return -ENOTTY;
+}
+
+static struct block_device_operations ub_bd_fops = {
+	.owner	= THIS_MODULE,
+	.ioctl	= ub_bd_ioctl,
+	// .revalidate_disk = cciss_revalidate,
+};
+
+/*
+ * Read the SCSI capacity synchronously (for probing).
+ */
+static void ub_probe_read_cap_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	struct completion *cop = cmd->back;
+	complete(cop);
+}
+
+static int ub_probe_read_cap(struct ub_dev *sc, struct ub_capacity *ret)
+{
+	struct ub_scsi_cmd *cmd;
+	char *p;
+	enum { ALLOC_SIZE = sizeof(struct ub_scsi_cmd) + 8 };
+	unsigned long flags;
+	unsigned int bsize, shift;
+	unsigned long nsec;
+	struct completion compl;
+	int rc;
+
+	init_completion(&compl);
+
+	rc = -ENOMEM;
+	if ((cmd = kmalloc(ALLOC_SIZE, GFP_KERNEL)) == NULL)
+		goto err_alloc;
+	memset(cmd, 0, ALLOC_SIZE);
+	p = (char *)cmd + sizeof(struct ub_scsi_cmd);
+
+	cmd->cdb[0] = 0x25;
+	cmd->cdb_len = 10;
+	cmd->dir = UB_DIR_READ;
+	cmd->state = UB_CMDST_INIT;
+	cmd->data = p;
+	cmd->len = 8;
+	cmd->done = ub_probe_read_cap_done;
+	cmd->back = &compl;
+
+	spin_lock_irqsave(&sc->lock, flags);
+	cmd->tag = sc->tagcnt++;
+
+	rc = ub_submit_scsi(sc, cmd);
+	spin_unlock_irqrestore(&sc->lock, flags);
+
+	if (rc != 0) {
+		printk("ub: reading capacity: submit error (%d)\n", rc); /* P3 */
+		goto err_submit;
+	}
+
+	wait_for_completion(&compl);
+
+	if (cmd->error != 0) {
+		printk("ub: reading capacity: error %d\n", cmd->error); /* P3 */
+		rc = -EIO;
+		goto err_read;
+	}
+	if (cmd->act_len != 8) {
+		printk("ub: reading capacity: size %d\n", cmd->act_len); /* P3 */
+		rc = -EIO;
+		goto err_read;
+	}
+
+	nsec = be32_to_cpu(*(u32 *)p) + 1;
+	bsize = be32_to_cpu(*(u32 *)(p + 4));
+	switch (bsize) {
+	case 512:	shift = 0;	break;
+	case 1024:	shift = 1;	break;
+	case 2048:	shift = 2;	break;
+	case 4096:	shift = 3;	break;
+	default:
+		printk("ub: Bad sector size %u\n", bsize); /* P3 */
+		rc = -EDOM;
+		goto err_inv_bsize;
+	}
+
+	ret->bsize = bsize;
+	ret->bshift = shift;
+	ret->nsec = nsec << shift;
+	rc = 0;
+
+err_inv_bsize:
+err_read:
+err_submit:
+	kfree(cmd);
+err_alloc:
+	return rc;
+}
+
+/* Get the pipe settings */
+static int ub_get_pipes(struct ub_dev *sc, struct usb_device *dev,
+    struct usb_interface *intf)
+{
+	struct usb_host_interface *altsetting = intf->cur_altsetting;
+	struct usb_endpoint_descriptor *ep_in = NULL;
+	struct usb_endpoint_descriptor *ep_out = NULL;
+	struct usb_endpoint_descriptor *ep;
+	int i;
+
+	/*
+	 * Find the endpoints we need.
+	 * We are expecting a minimum of 2 endpoints - in and out (bulk).
+	 * We will ignore any others.
+	 */
+	for (i = 0; i < altsetting->desc.bNumEndpoints; i++) {
+		ep = &altsetting->endpoint[i].desc;
+
+		/* Is it a BULK endpoint? */
+		if ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
+				== USB_ENDPOINT_XFER_BULK) {
+			/* BULK in or out? */
+			if (ep->bEndpointAddress & USB_DIR_IN)
+				ep_in = ep;
+			else
+				ep_out = ep;
+		}
+	}
+
+	if (ep_in == NULL || ep_out == NULL) {
+		printk(KERN_NOTICE DRV_NAME ": "
+		    "device %u failed endpoint check\n",
+		    sc->dev->devnum);
+		return -EIO;
+	}
+
+	/* Calculate and store the pipe values */
+	sc->send_ctrl_pipe = usb_sndctrlpipe(dev, 0);
+	sc->recv_ctrl_pipe = usb_rcvctrlpipe(dev, 0);
+	sc->send_bulk_pipe = usb_sndbulkpipe(dev,
+		ep_out->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
+	sc->recv_bulk_pipe = usb_rcvbulkpipe(dev, 
+		ep_in->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
+
+	return 0;
+}
+
+/*
+ * Probing is done in the process context, which allows us to cheat
+ * and not to build a state machine for the discovery.
+ */
+static int ub_probe(struct usb_interface *intf,
+    const struct usb_device_id *id)
+{
+	struct ub_dev *sc;
+	request_queue_t *q;
+	struct gendisk *disk;
+	int rc;
+
+	rc = -EDOM;
+	if (ub_host_id >= 26)		/* XXX Lame naming scheme */
+		goto err_over;
+
+	rc = -ENOMEM;
+	if ((sc = kmalloc(sizeof(struct ub_dev), GFP_KERNEL)) == NULL)
+		goto err_core;
+	memset(sc, 0, sizeof(struct ub_dev));
+	spin_lock_init(&sc->lock);
+	sc->id = ub_host_id;
+	snprintf(sc->name, 8, "ub%c", sc->id + 'a');
+	usb_init_urb(&sc->work_urb);
+	tasklet_init(&sc->urb_tasklet, ub_scsi_urb_action, (unsigned long)sc);
+
+	sc->dev = interface_to_usbdev(intf);
+	// sc->intf = intf;
+	// sc->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+
+	usb_set_intfdata(intf, sc);
+	usb_get_dev(sc->dev);
+
+	/* XXX Verify that we can handle the device (from descriptors) */
+
+	ub_get_pipes(sc, sc->dev, intf);
+
+	/*
+	 * At this point, all USB initialization is done, do upper layer.
+	 * We really hate halfway initialized structures, so from the
+	 * invariants perspective, this ub_dev is fully constructed at
+	 * this point.
+	 */
+
+	if ((rc = register_blkdev(UB_MAJOR, sc->name)) != 0)
+		goto err_regblkdev;
+
+	devfs_mk_dir("ub");
+
+	if ((rc = ub_probe_read_cap(sc, &sc->capacity)) != 0) {
+		/* XXX Retry does actually happen, our code must be defective */
+		if ((rc = ub_probe_read_cap(sc, &sc->capacity)) != 0) {
+			sc->capacity.nsec = 100;
+			sc->capacity.bsize = 512;
+			sc->capacity.bshift = 0;
+		}
+	}
+	/* This is pretty much a long term P3 */
+	printk(KERN_INFO DRV_NAME ": device %u capacity nsec %ld bsize %u\n",
+	    sc->dev->devnum, sc->capacity.nsec, sc->capacity.bsize);
+
+	/*
+	 * Just one disk per sc currently, but maybe more.
+	 */
+	rc = -ENOMEM;
+	if ((disk = alloc_disk(UB_MINORS_PER_MAJOR)) == NULL)
+		goto err_diskalloc;
+
+	sc->disk = disk;
+	sprintf(disk->disk_name, "ub%c", sc->id + 'a');
+	sprintf(disk->devfs_name, "ub/%c", sc->id + 'a');
+	disk->major = UB_MAJOR;
+	disk->first_minor = 0;
+	disk->fops = &ub_bd_fops;
+	disk->private_data = sc;
+
+	rc = -ENOMEM;
+	if ((q = blk_init_queue(ub_bd_rq_fn, &sc->lock)) == NULL)
+		goto err_blkqinit;
+
+	disk->queue = q;
+
+        // blk_queue_bounce_limit(q, hba[i]->pdev->dma_mask);
+	blk_queue_max_hw_segments(q, UB_MAX_REQ_SG);
+	blk_queue_max_phys_segments(q, UB_MAX_REQ_SG);
+	// blk_queue_segment_boundary(q, CARM_SG_BOUNDARY);
+	// blk_queue_max_sectors(q, 512);
+	// blk_queue_hardsect_size(q, xxxxx);
+
+	/*
+	 * This is a serious infraction, caused by a deficiency in the
+	 * USB sg interface (usb_sg_wait()). We plan to remove this once
+	 * we get mileage on the driver and can justify a change to USB API.
+	 * See blk_queue_bounce_limit() to understand this part.
+	 */
+	q->bounce_pfn = blk_max_low_pfn;
+	q->bounce_gfp = GFP_NOIO;
+
+	q->queuedata = sc;
+
+	set_capacity(disk, sc->capacity.nsec);
+	add_disk(disk);
+
+	/* Upper level is all done, doing inits on a fully functional device */
+
+	ub_sysdiag_create(sc);
+
+	ub_host_id++;		/* Protected by dev->serialize in USB core */
+	return 0;
+
+err_blkqinit:
+	put_disk(disk);
+err_diskalloc:
+	devfs_remove("ub");
+	unregister_blkdev(UB_MAJOR, sc->name);
+err_regblkdev:
+	// blk_cleanup_queue(sc->oob_q);
+// err_ooballoc:
+	usb_set_intfdata(intf, NULL);
+	usb_put_dev(sc->dev);
+	kfree(sc);
+err_core:
+err_over:
+	return rc;
+}
+
+static void ub_disconnect(struct usb_interface *intf)
+{
+	struct ub_dev *sc = usb_get_intfdata(intf);
+	struct gendisk *disk = sc->disk;
+	request_queue_t *q = disk->queue;
+	unsigned long flags;
+
+	/*
+	 * Fence stall clearnings, operations triggered by unlinkings and so on.
+	 */
+	spin_lock_irqsave(&sc->lock, flags);
+	sc->poison = 1;
+	spin_unlock_irqrestore(&sc->lock, flags);
+
+	/*
+	 * Unregister the upper layer, this waits for all commands to end.
+	 * XXX Does it, actually? Verify!
+	 */
+	if (disk->flags & GENHD_FL_UP)
+		del_gendisk(disk);
+	if (q)
+		blk_cleanup_queue(q);
+	put_disk(disk);
+	sc->disk = NULL;
+
+	devfs_remove("ub");
+	unregister_blkdev(UB_MAJOR, sc->name);
+	// blk_cleanup_queue(sc->oob_q);
+
+	/*
+	 * At this point there must be no commands coming from anyone
+	 * and no URBs left in transit.
+	 */
+
+	usb_set_intfdata(intf, NULL);
+	usb_put_dev(sc->dev);
+	kfree(sc);
+}
+
+struct usb_driver ub_driver = {
+	.owner =	THIS_MODULE,
+	.name =		"ub",
+	.probe =	ub_probe,
+	.disconnect =	ub_disconnect,
+	.id_table =	ub_usb_ids,
+};
+
+static int __init ub_init(void)
+{
+
+	/* P3 */ printk("ub: sizeof ub_scsi_cmd %u ub_dev %u\n",
+			sizeof(struct ub_scsi_cmd), sizeof(struct ub_dev));
+	return usb_register(&ub_driver);
+}
+
+static void __exit ub_exit(void)
+{
+	usb_deregister(&ub_driver);
+}
+
+module_init(ub_init);
+module_exit(ub_exit);
+
+MODULE_LICENSE("GPL");
diff -urpN -X dontdiff linux-2.6.7/drivers/usb/storage/unusual_devs.h linux-2.6.7-ub/drivers/usb/storage/unusual_devs.h
--- linux-2.6.7/drivers/usb/storage/unusual_devs.h	2004-06-16 16:53:59.000000000 -0700
+++ linux-2.6.7-ub/drivers/usb/storage/unusual_devs.h	2004-06-16 17:47:14.000000000 -0700
@@ -486,11 +486,13 @@ UNUSUAL_DEV(  0x0781, 0x0001, 0x0200, 0x
 		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN ),
 
+#if 0 /* passed over to ub */
 UNUSUAL_DEV(  0x0781, 0x0002, 0x0009, 0x0009, 
 		"Sandisk",
 		"ImageMate SDDR-31",
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_IGNORE_SER ),
+#endif
 
 UNUSUAL_DEV(  0x0781, 0x0100, 0x0100, 0x0100,
 		"Sandisk",
diff -urpN -X dontdiff linux-2.6.7/drivers/usb/storage/usb.c linux-2.6.7-ub/drivers/usb/storage/usb.c
--- linux-2.6.7/drivers/usb/storage/usb.c	2004-06-16 16:53:59.000000000 -0700
+++ linux-2.6.7-ub/drivers/usb/storage/usb.c	2004-06-16 17:47:14.000000000 -0700
@@ -133,7 +133,6 @@ static struct usb_device_id storage_usb_
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_QIC, US_PR_BULK) },
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_UFI, US_PR_BULK) },
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8070, US_PR_BULK) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
 
 	/* Terminating entry */
 	{ }
diff -urpN -X dontdiff linux-2.6.7/include/linux/major.h linux-2.6.7-ub/include/linux/major.h
--- linux-2.6.7/include/linux/major.h	2004-04-21 12:01:24.000000000 -0700
+++ linux-2.6.7-ub/include/linux/major.h	2004-06-16 17:47:14.000000000 -0700
@@ -165,4 +165,6 @@
 
 #define VIOTAPE_MAJOR		230
 
+#define UB_MAJOR		125	/* USB Block - Experimental XXX */
+
 #endif
