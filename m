Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbUKLNtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbUKLNtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 08:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbUKLNtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 08:49:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45841 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262524AbUKLNsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 08:48:00 -0500
Date: Fri, 12 Nov 2004 14:47:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: markus.lidel@shadowconnect.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] I2O: some cleanups
Message-ID: <20041112134727.GA7707@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the patch below makes the following changes to code under 
drivers/message/i2o :
- remove unused code
- make needlessly global code static

Please review this patch and apply if it's correct.


diffstat output:
 drivers/message/i2o/debug.c      |  108 +------------------------------
 drivers/message/i2o/device.c     |   46 -------------
 drivers/message/i2o/exec-osm.c   |    5 -
 drivers/message/i2o/i2o_config.c |    3 
 drivers/message/i2o/i2o_proc.c   |   38 +++++-----
 drivers/message/i2o/i2o_scsi.c   |    6 -
 drivers/message/i2o/iop.c        |    7 +-
 include/linux/i2o.h              |    3 
 8 files changed, 36 insertions(+), 180 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/include/linux/i2o.h.old	2004-11-11 22:59:51.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/i2o.h	2004-11-11 23:08:03.000000000 +0100
@@ -263,7 +263,6 @@
 
 /* IOP functions */
 extern int i2o_status_get(struct i2o_controller *);
-extern int i2o_hrt_get(struct i2o_controller *);
 
 extern int i2o_event_register(struct i2o_device *, struct i2o_driver *, int,
 			      u32);
@@ -385,7 +384,6 @@
 
 /* Exec OSM functions */
 extern int i2o_exec_lct_get(struct i2o_controller *);
-extern int i2o_exec_lct_notify(struct i2o_controller *, u32);
 
 /* device to i2o_device and driver to i2o_driver convertion functions */
 #define to_i2o_driver(drv) container_of(drv,struct i2o_driver, driver)
@@ -633,7 +631,6 @@
 #define i2o_raw_writel(val, mem)	__raw_writel(cpu_to_le32(val), mem)
 
 extern int i2o_parm_field_get(struct i2o_device *, int, int, void *, int);
-extern int i2o_parm_field_set(struct i2o_device *, int, int, void *, int);
 extern int i2o_parm_table_get(struct i2o_device *, int, int, int, void *, int,
 			      void *, int);
 /* FIXME: remove
--- linux-2.6.10-rc1-mm5-full/drivers/message/i2o/debug.c.old	2004-11-11 22:58:13.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/message/i2o/debug.c	2004-11-11 23:10:17.000000000 +0100
@@ -4,40 +4,14 @@
 #include <linux/pci.h>
 #include <linux/i2o.h>
 
-static int verbose;
 extern struct i2o_driver **i2o_drivers;
 extern unsigned int i2o_max_drivers;
 static void i2o_report_util_cmd(u8 cmd);
 static void i2o_report_exec_cmd(u8 cmd);
-void i2o_report_fail_status(u8 req_status, u32 * msg);
-void i2o_report_common_status(u8 req_status);
+static void i2o_report_fail_status(u8 req_status, u32 * msg);
+static void i2o_report_common_status(u8 req_status);
 static void i2o_report_common_dsc(u16 detailed_status);
 
-void i2o_dump_status_block(i2o_status_block * sb)
-{
-	pr_debug("Organization ID: %d\n", sb->org_id);
-	pr_debug("IOP ID:          %d\n", sb->iop_id);
-	pr_debug("Host Unit ID:    %d\n", sb->host_unit_id);
-	pr_debug("Segment Number:  %d\n", sb->segment_number);
-	pr_debug("I2O Version:     %d\n", sb->i2o_version);
-	pr_debug("IOP State:       %d\n", sb->iop_state);
-	pr_debug("Messanger Type:  %d\n", sb->msg_type);
-	pr_debug("Inbound Frame Size:      %d\n", sb->inbound_frame_size);
-	pr_debug("Init Code:               %d\n", sb->init_code);
-	pr_debug("Max Inbound MFrames:     %d\n", sb->max_inbound_frames);
-	pr_debug("Current Inbound MFrames: %d\n", sb->cur_inbound_frames);
-	pr_debug("Max Outbound MFrames:    %d\n", sb->max_outbound_frames);
-	pr_debug("Product ID String: %s\n", sb->product_id);
-	pr_debug("Expected LCT Size: %d\n", sb->expected_lct_size);
-	pr_debug("IOP Capabilities:  %d\n", sb->iop_capabilities);
-	pr_debug("Desired Private MemSize: %d\n", sb->desired_mem_size);
-	pr_debug("Current Private MemSize: %d\n", sb->current_mem_size);
-	pr_debug("Current Private MemBase: %d\n", sb->current_mem_base);
-	pr_debug("Desired Private IO Size: %d\n", sb->desired_io_size);
-	pr_debug("Current Private IO Size: %d\n", sb->current_io_size);
-	pr_debug("Current Private IO Base: %d\n", sb->current_io_base);
-};
-
 /*
  * Used for error reporting/debugging purposes.
  * Report Cmd name, Request status, Detailed Status.
@@ -91,71 +65,12 @@
 #endif
 }
 
-/**
- *	i2o_report_controller_unit - print information about a tid
- *	@c: controller
- *	@d: device
- *
- *	Dump an information block associated with a given unit (TID). The
- *	tables are read and a block of text is output to printk that is
- *	formatted intended for the user.
- */
-
-void i2o_report_controller_unit(struct i2o_controller *c, struct i2o_device *d)
-{
-	char buf[64];
-	char str[22];
-	int ret;
-
-	if (verbose == 0)
-		return;
-
-	printk(KERN_INFO "Target ID %03x.\n", d->lct_data.tid);
-	if ((ret = i2o_parm_field_get(d, 0xF100, 3, buf, 16)) >= 0) {
-		buf[16] = 0;
-		printk(KERN_INFO "     Vendor: %s\n", buf);
-	}
-	if ((ret = i2o_parm_field_get(d, 0xF100, 4, buf, 16)) >= 0) {
-		buf[16] = 0;
-		printk(KERN_INFO "     Device: %s\n", buf);
-	}
-	if (i2o_parm_field_get(d, 0xF100, 5, buf, 16) >= 0) {
-		buf[16] = 0;
-		printk(KERN_INFO "     Description: %s\n", buf);
-	}
-	if ((ret = i2o_parm_field_get(d, 0xF100, 6, buf, 8)) >= 0) {
-		buf[8] = 0;
-		printk(KERN_INFO "        Rev: %s\n", buf);
-	}
-
-	printk(KERN_INFO "    Class: ");
-	//sprintf(str, "%-21s", i2o_get_class_name(d->lct_data.class_id));
-	printk(KERN_DEBUG "%s\n", str);
-
-	printk(KERN_INFO "  Subclass: 0x%04X\n", d->lct_data.sub_class);
-	printk(KERN_INFO "     Flags: ");
-
-	if (d->lct_data.device_flags & (1 << 0))
-		printk(KERN_DEBUG "C");	// ConfigDialog requested
-	if (d->lct_data.device_flags & (1 << 1))
-		printk(KERN_DEBUG "U");	// Multi-user capable
-	if (!(d->lct_data.device_flags & (1 << 4)))
-		printk(KERN_DEBUG "P");	// Peer service enabled!
-	if (!(d->lct_data.device_flags & (1 << 5)))
-		printk(KERN_DEBUG "M");	// Mgmt service enabled!
-	printk(KERN_DEBUG "\n");
-}
-
-/*
-module_param(verbose, int, 0644);
-MODULE_PARM_DESC(verbose, "Verbose diagnostics");
-*/
 /*
  * Used for error reporting/debugging purposes.
  * Following fail status are common to all classes.
  * The preserved message must be handled in the reply handler.
  */
-void i2o_report_fail_status(u8 req_status, u32 * msg)
+static void i2o_report_fail_status(u8 req_status, u32 * msg)
 {
 	static char *FAIL_STATUS[] = {
 		"0x80",		/* not used */
@@ -213,7 +128,7 @@
  * Used for error reporting/debugging purposes.
  * Following reply status are common to all classes.
  */
-void i2o_report_common_status(u8 req_status)
+static void i2o_report_common_status(u8 req_status)
 {
 	static char *REPLY_STATUS[] = {
 		"SUCCESS",
@@ -476,20 +391,6 @@
 	}
 };
 
-void i2o_systab_debug(struct i2o_sys_tbl *sys_tbl)
-{
-	u32 *table;
-	int count;
-	u32 size;
-
-	table = (u32 *) sys_tbl;
-	size = sizeof(struct i2o_sys_tbl) + sys_tbl->num_entries
-	    * sizeof(struct i2o_sys_tbl_entry);
-
-	for (count = 0; count < (size >> 2); count++)
-		printk(KERN_INFO "sys_tbl[%d] = %0#10x\n", count, table[count]);
-}
-
 void i2o_dump_hrt(struct i2o_controller *c)
 {
 	u32 *rows = (u32 *) c->hrt.virt;
@@ -577,5 +478,4 @@
 	}
 }
 
-EXPORT_SYMBOL(i2o_dump_status_block);
 EXPORT_SYMBOL(i2o_dump_message);
--- linux-2.6.10-rc1-mm5-full/drivers/message/i2o/device.c.old	2004-11-11 23:00:07.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/message/i2o/device.c	2004-11-11 23:00:46.000000000 +0100
@@ -211,8 +211,8 @@
  *	Returns a pointer to the I2O device on success or negative error code
  *	on failure.
  */
-struct i2o_device *i2o_device_add(struct i2o_controller *c,
-				  i2o_lct_entry * entry)
+static struct i2o_device *i2o_device_add(struct i2o_controller *c,
+					 i2o_lct_entry * entry)
 {
 	struct i2o_device *dev;
 
@@ -547,47 +547,6 @@
 }
 
 /*
- *	Set a scalar group value or a whole group.
- */
-int i2o_parm_field_set(struct i2o_device *i2o_dev, int group, int field,
-		       void *buf, int buflen)
-{
-	u16 *opblk;
-	u8 resblk[8 + buflen];	/* 8 bytes for header */
-	int size;
-
-	opblk = kmalloc(buflen + 64, GFP_KERNEL);
-	if (opblk == NULL) {
-		printk(KERN_ERR "i2o: no memory for operation buffer.\n");
-		return -ENOMEM;
-	}
-
-	opblk[0] = 1;		/* operation count */
-	opblk[1] = 0;		/* pad */
-	opblk[2] = I2O_PARAMS_FIELD_SET;
-	opblk[3] = group;
-
-	if (field == -1) {	/* whole group */
-		opblk[4] = -1;
-		memcpy(opblk + 5, buf, buflen);
-	} else {		/* single field */
-
-		opblk[4] = 1;
-		opblk[5] = field;
-		memcpy(opblk + 6, buf, buflen);
-	}
-
-	size = i2o_parm_issue(i2o_dev, I2O_CMD_UTIL_PARAMS_SET, opblk,
-			      12 + buflen, resblk, sizeof(resblk));
-
-	kfree(opblk);
-	if (size > buflen)
-		return buflen;
-
-	return size;
-}
-
-/*
  * 	if oper == I2O_PARAMS_TABLE_GET, get from all rows
  * 		if fieldcount == -1 return all fields
  *			ibuf and ibuflen are unused (use NULL, 0)
@@ -669,6 +628,5 @@
 EXPORT_SYMBOL(i2o_device_claim);
 EXPORT_SYMBOL(i2o_device_claim_release);
 EXPORT_SYMBOL(i2o_parm_field_get);
-EXPORT_SYMBOL(i2o_parm_field_set);
 EXPORT_SYMBOL(i2o_parm_table_get);
 EXPORT_SYMBOL(i2o_parm_issue);
--- linux-2.6.10-rc1-mm5-full/drivers/message/i2o/exec-osm.c.old	2004-11-11 23:01:32.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/message/i2o/exec-osm.c	2004-11-11 23:02:05.000000000 +0100
@@ -33,6 +33,8 @@
 
 struct i2o_driver i2o_exec_driver;
 
+static int i2o_exec_lct_notify(struct i2o_controller *c, u32 change_ind);
+
 /* Module internal functions from other sources */
 extern int i2o_device_parse_lct(struct i2o_controller *);
 
@@ -436,7 +438,7 @@
  *	replies immediately after the request. If change_ind > 0 the reply is
  *	send after change indicator of the LCT is > change_ind.
  */
-int i2o_exec_lct_notify(struct i2o_controller *c, u32 change_ind)
+static int i2o_exec_lct_notify(struct i2o_controller *c, u32 change_ind)
 {
 	i2o_status_block *sb = c->status_block.virt;
 	struct device *dev;
@@ -503,4 +505,3 @@
 
 EXPORT_SYMBOL(i2o_msg_post_wait_mem);
 EXPORT_SYMBOL(i2o_exec_lct_get);
-EXPORT_SYMBOL(i2o_exec_lct_notify);
--- linux-2.6.10-rc1-mm5-full/drivers/message/i2o/i2o_config.c.old	2004-11-11 23:02:39.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/message/i2o/i2o_config.c	2004-11-11 23:03:02.000000000 +0100
@@ -51,7 +51,6 @@
 extern int i2o_parm_issue(struct i2o_device *, int, void *, int, void *, int);
 
 static spinlock_t i2o_config_lock = SPIN_LOCK_UNLOCKED;
-struct wait_queue *i2o_wait_queue;
 
 #define MODINC(x,y) ((x) = ((x) + 1) % (y))
 
@@ -79,7 +78,7 @@
  *	multiplexed by the i2o_core code
  */
 
-struct i2o_driver i2o_config_driver = {
+static struct i2o_driver i2o_config_driver = {
 	.name = "Config-OSM"
 };
 
--- linux-2.6.10-rc1-mm5-full/drivers/message/i2o/i2o_proc.c.old	2004-11-11 23:04:05.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/message/i2o/i2o_proc.c	2004-11-11 23:06:22.000000000 +0100
@@ -290,7 +290,7 @@
 	"CARDBUS"
 };
 
-int i2o_seq_show_hrt(struct seq_file *seq, void *v)
+static int i2o_seq_show_hrt(struct seq_file *seq, void *v)
 {
 	struct i2o_controller *c = (struct i2o_controller *)seq->private;
 	i2o_hrt *hrt = (i2o_hrt *) c->hrt.virt;
@@ -391,7 +391,7 @@
 	return 0;
 }
 
-int i2o_seq_show_lct(struct seq_file *seq, void *v)
+static int i2o_seq_show_lct(struct seq_file *seq, void *v)
 {
 	struct i2o_controller *c = (struct i2o_controller *)seq->private;
 	i2o_lct *lct = (i2o_lct *) c->lct;
@@ -521,7 +521,7 @@
 	return 0;
 }
 
-int i2o_seq_show_status(struct seq_file *seq, void *v)
+static int i2o_seq_show_status(struct seq_file *seq, void *v)
 {
 	struct i2o_controller *c = (struct i2o_controller *)seq->private;
 	char prodstr[25];
@@ -718,7 +718,7 @@
 	return 0;
 }
 
-int i2o_seq_show_hw(struct seq_file *seq, void *v)
+static int i2o_seq_show_hw(struct seq_file *seq, void *v)
 {
 	struct i2o_controller *c = (struct i2o_controller *)seq->private;
 	static u32 work32[5];
@@ -775,7 +775,7 @@
 }
 
 /* Executive group 0003h - Executing DDM List (table) */
-int i2o_seq_show_ddm_table(struct seq_file *seq, void *v)
+static int i2o_seq_show_ddm_table(struct seq_file *seq, void *v)
 {
 	struct i2o_controller *c = (struct i2o_controller *)seq->private;
 	int token;
@@ -851,7 +851,7 @@
 }
 
 /* Executive group 0004h - Driver Store (scalar) */
-int i2o_seq_show_driver_store(struct seq_file *seq, void *v)
+static int i2o_seq_show_driver_store(struct seq_file *seq, void *v)
 {
 	struct i2o_controller *c = (struct i2o_controller *)seq->private;
 	u32 work32[8];
@@ -874,7 +874,7 @@
 }
 
 /* Executive group 0005h - Driver Store Table (table) */
-int i2o_seq_show_drivers_stored(struct seq_file *seq, void *v)
+static int i2o_seq_show_drivers_stored(struct seq_file *seq, void *v)
 {
 	typedef struct _i2o_driver_store {
 		u16 stored_ddm_index;
@@ -953,7 +953,7 @@
 }
 
 /* Generic group F000h - Params Descriptor (table) */
-int i2o_seq_show_groups(struct seq_file *seq, void *v)
+static int i2o_seq_show_groups(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	int token;
@@ -1029,7 +1029,7 @@
 }
 
 /* Generic group F001h - Physical Device Table (table) */
-int i2o_seq_show_phys_device(struct seq_file *seq, void *v)
+static int i2o_seq_show_phys_device(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	int token;
@@ -1070,7 +1070,7 @@
 }
 
 /* Generic group F002h - Claimed Table (table) */
-int i2o_seq_show_claimed(struct seq_file *seq, void *v)
+static int i2o_seq_show_claimed(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	int token;
@@ -1110,7 +1110,7 @@
 }
 
 /* Generic group F003h - User Table (table) */
-int i2o_seq_show_users(struct seq_file *seq, void *v)
+static int i2o_seq_show_users(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	int token;
@@ -1164,7 +1164,7 @@
 }
 
 /* Generic group F005h - Private message extensions (table) (optional) */
-int i2o_seq_show_priv_msgs(struct seq_file *seq, void *v)
+static int i2o_seq_show_priv_msgs(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	int token;
@@ -1213,7 +1213,7 @@
 }
 
 /* Generic group F006h - Authorized User Table (table) */
-int i2o_seq_show_authorized_users(struct seq_file *seq, void *v)
+static int i2o_seq_show_authorized_users(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	int token;
@@ -1254,7 +1254,7 @@
 }
 
 /* Generic group F100h - Device Identity (scalar) */
-int i2o_seq_show_dev_identity(struct seq_file *seq, void *v)
+static int i2o_seq_show_dev_identity(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	static u32 work32[128];	// allow for "stuff" + up to 256 byte (max) serial number
@@ -1292,7 +1292,7 @@
 	return 0;
 }
 
-int i2o_seq_show_dev_name(struct seq_file *seq, void *v)
+static int i2o_seq_show_dev_name(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 
@@ -1302,7 +1302,7 @@
 }
 
 /* Generic group F101h - DDM Identity (scalar) */
-int i2o_seq_show_ddm_identity(struct seq_file *seq, void *v)
+static int i2o_seq_show_ddm_identity(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	int token;
@@ -1339,7 +1339,7 @@
 }
 
 /* Generic group F102h - User Information (scalar) */
-int i2o_seq_show_uinfo(struct seq_file *seq, void *v)
+static int i2o_seq_show_uinfo(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	int token;
@@ -1371,7 +1371,7 @@
 }
 
 /* Generic group F103h - SGL Operating Limits (scalar) */
-int i2o_seq_show_sgl_limits(struct seq_file *seq, void *v)
+static int i2o_seq_show_sgl_limits(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	static u32 work32[12];
@@ -1418,7 +1418,7 @@
 }
 
 /* Generic group F200h - Sensors (scalar) */
-int i2o_seq_show_sensors(struct seq_file *seq, void *v)
+static int i2o_seq_show_sensors(struct seq_file *seq, void *v)
 {
 	struct i2o_device *d = (struct i2o_device *)seq->private;
 	int token;
--- linux-2.6.10-rc1-mm5-full/drivers/message/i2o/i2o_scsi.c.old	2004-11-11 23:06:46.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/message/i2o/i2o_scsi.c	2004-11-11 23:07:13.000000000 +0100
@@ -460,7 +460,7 @@
  *	If a I2O controller is added, we catch the notification to add a
  *	corresponding Scsi_Host.
  */
-void i2o_scsi_notify_controller_add(struct i2o_controller *c)
+static void i2o_scsi_notify_controller_add(struct i2o_controller *c)
 {
 	struct i2o_scsi_host *i2o_shost;
 	int rc;
@@ -492,7 +492,7 @@
  *	If a I2O controller is removed, we catch the notification to remove the
  *	corresponding Scsi_Host.
  */
-void i2o_scsi_notify_controller_remove(struct i2o_controller *c)
+static void i2o_scsi_notify_controller_remove(struct i2o_controller *c)
 {
 	struct i2o_scsi_host *i2o_shost;
 	i2o_shost = i2o_scsi_get_host(c);
@@ -717,7 +717,7 @@
  *	Returns 0 if the command is successfully aborted or negative error code
  *	on failure.
  */
-int i2o_scsi_abort(struct scsi_cmnd *SCpnt)
+static int i2o_scsi_abort(struct scsi_cmnd *SCpnt)
 {
 	struct i2o_device *i2o_dev;
 	struct i2o_controller *c;
--- linux-2.6.10-rc1-mm5-full/drivers/message/i2o/iop.c.old	2004-11-11 23:08:11.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/message/i2o/iop.c	2004-11-11 23:08:44.000000000 +0100
@@ -38,6 +38,8 @@
  */
 static struct i2o_dma i2o_systab;
 
+static int i2o_hrt_get(struct i2o_controller *c);
+
 /* Module internal functions from other sources */
 extern struct i2o_driver i2o_exec_driver;
 extern int i2o_exec_lct_get(struct i2o_controller *);
@@ -564,7 +566,7 @@
  *
  *	Returns 0 on success or a negative errno code on failure.
  */
-int i2o_iop_init_outbound_queue(struct i2o_controller *c)
+static int i2o_iop_init_outbound_queue(struct i2o_controller *c)
 {
 	u8 *status = c->status.virt;
 	u32 m;
@@ -1050,7 +1052,7 @@
  *
  *	Returns 0 on success or negativer error code on failure.
  */
-int i2o_hrt_get(struct i2o_controller *c)
+static int i2o_hrt_get(struct i2o_controller *c)
 {
 	int rc;
 	int i;
@@ -1310,5 +1312,4 @@
 EXPORT_SYMBOL(i2o_iop_find_device);
 EXPORT_SYMBOL(i2o_event_register);
 EXPORT_SYMBOL(i2o_status_get);
-EXPORT_SYMBOL(i2o_hrt_get);
 EXPORT_SYMBOL(i2o_controllers);

