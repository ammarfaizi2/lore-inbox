Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVJ2SWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVJ2SWc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 14:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVJ2SWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 14:22:32 -0400
Received: from havoc.gtf.org ([69.61.125.42]:59523 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751236AbVJ2SW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 14:22:29 -0400
Date: Sat, 29 Oct 2005 14:22:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata updates
Message-ID: <20051029182228.GA14495@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain misc fixes and cleanups, and to merge
the ATA passthru (SMART support) feature.

 drivers/scsi/libata-core.c  |   18 -
 drivers/scsi/libata-scsi.c  |  790 ++++++++++++++++++++++++++++++++++++--------
 drivers/scsi/libata.h       |    3 
 drivers/scsi/pdc_adma.c     |   28 -
 drivers/scsi/sata_promise.c |    4 
 drivers/scsi/sata_qstor.c   |    2 
 drivers/scsi/sata_sil24.c   |   35 +
 drivers/scsi/sata_svw.c     |   22 -
 drivers/scsi/sata_vsc.c     |   20 -
 include/scsi/scsi.h         |    3 
 10 files changed, 740 insertions(+), 185 deletions(-)

Al Viro:
      sata_sil24 iomem annotations and fixes

Douglas Gilbert:
      [libata scsi] MODE SELECT, strengthen mode sense

Ed Kear:
      libata: add support for Promise SATA 300 TX2plus PDC40775

Jeff Garzik:
      [libata] ATA passthru (arbitrary ATA command execution)
      libata: Update 'passthru' branch for latest libata
      [libata passthru] add (DRIVER_SENSE << 24) to all check-conditions
      [libata passthru] update ATAPI completion for new error handling
      [libata pdc_adma] minor fixes and cleanups
      [libata sata_promise] add pci id
      [libata] ensure ->tf_read() hook reads Status and Error registers

Jeff Raubitschek:
      [libata passthru] fix leak on error

Randy Dunlap:
      libata-core cleanups (updated)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f53d7b8..b1b1c6f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -370,6 +370,8 @@ static void ata_tf_read_pio(struct ata_p
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
+	tf->command = ata_check_status(ap);
+	tf->feature = ata_chk_err(ap);
 	tf->nsect = inb(ioaddr->nsect_addr);
 	tf->lbal = inb(ioaddr->lbal_addr);
 	tf->lbam = inb(ioaddr->lbam_addr);
@@ -402,6 +404,8 @@ static void ata_tf_read_mmio(struct ata_
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
+	tf->command = ata_check_status(ap);
+	tf->feature = ata_chk_err(ap);
 	tf->nsect = readb((void __iomem *)ioaddr->nsect_addr);
 	tf->lbal = readb((void __iomem *)ioaddr->lbal_addr);
 	tf->lbam = readb((void __iomem *)ioaddr->lbam_addr);
@@ -4254,11 +4258,10 @@ int ata_device_add(const struct ata_prob
 
 	DPRINTK("ENTER\n");
 	/* alloc a container for our list of ATA ports (buses) */
-	host_set = kmalloc(sizeof(struct ata_host_set) +
+	host_set = kzalloc(sizeof(struct ata_host_set) +
 			   (ent->n_ports * sizeof(void *)), GFP_KERNEL);
 	if (!host_set)
 		return 0;
-	memset(host_set, 0, sizeof(struct ata_host_set) + (ent->n_ports * sizeof(void *)));
 	spin_lock_init(&host_set->lock);
 
 	host_set->dev = dev;
@@ -4298,10 +4301,8 @@ int ata_device_add(const struct ata_prob
 		count++;
 	}
 
-	if (!count) {
-		kfree(host_set);
-		return 0;
-	}
+	if (!count)
+		goto err_free_ret;
 
 	/* obtain irq, that is shared between channels */
 	if (request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
@@ -4359,6 +4360,7 @@ err_out:
 		ata_host_remove(host_set->ports[i], 1);
 		scsi_host_put(host_set->ports[i]->host);
 	}
+err_free_ret:
 	kfree(host_set);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
@@ -4468,15 +4470,13 @@ ata_probe_ent_alloc(struct device *dev, 
 {
 	struct ata_probe_ent *probe_ent;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       kobject_name(&(dev->kobj)));
 		return NULL;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
-
 	INIT_LIST_HEAD(&probe_ent->node);
 	probe_ent->dev = dev;
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 5885888..89a04b1 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -40,14 +40,56 @@
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
+#include <linux/hdreg.h>
 #include <asm/uaccess.h>
 
 #include "libata.h"
 
+#define SECTOR_SIZE	512
+
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
 static struct ata_device *
 ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev);
 
+#define RW_RECOVERY_MPAGE 0x1
+#define RW_RECOVERY_MPAGE_LEN 12
+#define CACHE_MPAGE 0x8
+#define CACHE_MPAGE_LEN 20
+#define CONTROL_MPAGE 0xa
+#define CONTROL_MPAGE_LEN 12
+#define ALL_MPAGES 0x3f
+#define ALL_SUB_MPAGES 0xff
+
+
+static const u8 def_rw_recovery_mpage[] = {
+	RW_RECOVERY_MPAGE,
+	RW_RECOVERY_MPAGE_LEN - 2,
+	(1 << 7) |	/* AWRE, sat-r06 say it shall be 0 */
+	    (1 << 6),	/* ARRE (auto read reallocation) */
+	0,		/* read retry count */
+	0, 0, 0, 0,
+	0,		/* write retry count */
+	0, 0, 0
+};
+
+static const u8 def_cache_mpage[CACHE_MPAGE_LEN] = {
+	CACHE_MPAGE,
+	CACHE_MPAGE_LEN - 2,
+	0,		/* contains WCE, needs to be 0 for logic */
+	0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0,		/* contains DRA, needs to be 0 for logic */
+	0, 0, 0, 0, 0, 0, 0
+};
+
+static const u8 def_control_mpage[CONTROL_MPAGE_LEN] = {
+	CONTROL_MPAGE,
+	CONTROL_MPAGE_LEN - 2,
+	2,	/* DSENSE=0, GLTSD=1 */
+	0,	/* [QAM+QERR may be 1, see 05-359r1] */
+	0, 0, 0, 0, 0xff, 0xff,
+	0, 30	/* extended self test time, see 05-359r1 */
+};
+
 
 static void ata_scsi_invalid_field(struct scsi_cmnd *cmd,
 				   void (*done)(struct scsi_cmnd *))
@@ -86,6 +128,150 @@ int ata_std_bios_param(struct scsi_devic
 	return 0;
 }
 
+/**
+ *	ata_cmd_ioctl - Handler for HDIO_DRIVE_CMD ioctl
+ *	@dev: Device to whom we are issuing command
+ *	@arg: User provided data for issuing command
+ *
+ *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
+ *
+ *	RETURNS:
+ *	Zero on success, negative errno on error.
+ */
+
+int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
+{
+	int rc = 0;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	u8 args[4], *argbuf = NULL;
+	int argsize = 0;
+	struct scsi_request *sreq;
+
+	if (NULL == (void *)arg)
+		return -EINVAL;
+
+	if (copy_from_user(args, arg, sizeof(args)))
+		return -EFAULT;
+
+	sreq = scsi_allocate_request(scsidev, GFP_KERNEL);
+	if (!sreq)
+		return -EINTR;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+
+	if (args[3]) {
+		argsize = SECTOR_SIZE * args[3];
+		argbuf = kmalloc(argsize, GFP_KERNEL);
+		if (argbuf == NULL) {
+			rc = -ENOMEM;
+			goto error;
+		}
+
+		scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
+		scsi_cmd[2]  = 0x0e;     /* no off.line or cc, read from dev,
+		                            block count in sector count field */
+		sreq->sr_data_direction = DMA_FROM_DEVICE;
+	} else {
+		scsi_cmd[1]  = (3 << 1); /* Non-data */
+		/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
+		sreq->sr_data_direction = DMA_NONE;
+	}
+
+	scsi_cmd[0] = ATA_16;
+
+	scsi_cmd[4] = args[2];
+	if (args[0] == WIN_SMART) { /* hack -- ide driver does this too... */
+		scsi_cmd[6]  = args[3];
+		scsi_cmd[8]  = args[1];
+		scsi_cmd[10] = 0x4f;
+		scsi_cmd[12] = 0xc2;
+	} else {
+		scsi_cmd[6]  = args[1];
+	}
+	scsi_cmd[14] = args[0];
+
+	/* Good values for timeout and retries?  Values below
+	   from scsi_ioctl_send_command() for default case... */
+	scsi_wait_req(sreq, scsi_cmd, argbuf, argsize, (10*HZ), 5);
+
+	if (sreq->sr_result) {
+		rc = -EIO;
+		goto error;
+	}
+
+	/* Need code to retrieve data from check condition? */
+
+	if ((argbuf)
+	 && copy_to_user((void *)(arg + sizeof(args)), argbuf, argsize))
+		rc = -EFAULT;
+error:
+	scsi_release_request(sreq);
+
+	if (argbuf)
+		kfree(argbuf);
+
+	return rc;
+}
+
+/**
+ *	ata_task_ioctl - Handler for HDIO_DRIVE_TASK ioctl
+ *	@dev: Device to whom we are issuing command
+ *	@arg: User provided data for issuing command
+ *
+ *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
+ *
+ *	RETURNS:
+ *	Zero on success, negative errno on error.
+ */
+int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
+{
+	int rc = 0;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	u8 args[7];
+	struct scsi_request *sreq;
+
+	if (NULL == (void *)arg)
+		return -EINVAL;
+
+	if (copy_from_user(args, arg, sizeof(args)))
+		return -EFAULT;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+	scsi_cmd[0]  = ATA_16;
+	scsi_cmd[1]  = (3 << 1); /* Non-data */
+	/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
+	scsi_cmd[4]  = args[1];
+	scsi_cmd[6]  = args[2];
+	scsi_cmd[8]  = args[3];
+	scsi_cmd[10] = args[4];
+	scsi_cmd[12] = args[5];
+	scsi_cmd[14] = args[0];
+
+	sreq = scsi_allocate_request(scsidev, GFP_KERNEL);
+	if (!sreq) {
+		rc = -EINTR;
+		goto error;
+	}
+
+	sreq->sr_data_direction = DMA_NONE;
+	/* Good values for timeout and retries?  Values below
+	   from scsi_ioctl_send_command() for default case... */
+	scsi_wait_req(sreq, scsi_cmd, NULL, 0, (10*HZ), 5);
+
+	if (sreq->sr_result) {
+		rc = -EIO;
+		goto error;
+	}
+
+	/* Need code to retrieve data from check condition? */
+
+error:
+	scsi_release_request(sreq);
+	return rc;
+}
+
 int ata_scsi_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg)
 {
 	struct ata_port *ap;
@@ -115,6 +301,16 @@ int ata_scsi_ioctl(struct scsi_device *s
 			return -EINVAL;
 		return 0;
 
+	case HDIO_DRIVE_CMD:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ata_cmd_ioctl(scsidev, arg);
+
+	case HDIO_DRIVE_TASK:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ata_task_ioctl(scsidev, arg);
+
 	default:
 		rc = -ENOTTY;
 		break;
@@ -173,23 +369,70 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 }
 
 /**
+ *	ata_dump_status - user friendly display of error info
+ *	@id: id of the port in question
+ *	@tf: ptr to filled out taskfile
+ *
+ *	Decode and dump the ATA error/status registers for the user so
+ *	that they have some idea what really happened at the non
+ *	make-believe layer.
+ *
+ *	LOCKING:
+ *	inherited from caller
+ */
+void ata_dump_status(unsigned id, struct ata_taskfile *tf)
+{
+	u8 stat = tf->command, err = tf->feature;
+
+	printk(KERN_WARNING "ata%u: status=0x%02x { ", id, stat);
+	if (stat & ATA_BUSY) {
+		printk("Busy }\n");	/* Data is not valid in this case */
+	} else {
+		if (stat & 0x40)	printk("DriveReady ");
+		if (stat & 0x20)	printk("DeviceFault ");
+		if (stat & 0x10)	printk("SeekComplete ");
+		if (stat & 0x08)	printk("DataRequest ");
+		if (stat & 0x04)	printk("CorrectedError ");
+		if (stat & 0x02)	printk("Index ");
+		if (stat & 0x01)	printk("Error ");
+		printk("}\n");
+
+		if (err) {
+			printk(KERN_WARNING "ata%u: error=0x%02x { ", id, err);
+			if (err & 0x04)		printk("DriveStatusError ");
+			if (err & 0x80) {
+				if (err & 0x04)	printk("BadCRC ");
+				else		printk("Sector ");
+			}
+			if (err & 0x40)		printk("UncorrectableError ");
+			if (err & 0x10)		printk("SectorIdNotFound ");
+			if (err & 0x02)		printk("TrackZeroNotFound ");
+			if (err & 0x01)		printk("AddrMarkNotFound ");
+			printk("}\n");
+		}
+	}
+}
+
+/**
  *	ata_to_sense_error - convert ATA error to SCSI error
- *	@qc: Command that we are erroring out
  *	@drv_stat: value contained in ATA status register
+ *	@drv_err: value contained in ATA error register
+ *	@sk: the sense key we'll fill out
+ *	@asc: the additional sense code we'll fill out
+ *	@ascq: the additional sense code qualifier we'll fill out
  *
- *	Converts an ATA error into a SCSI error. While we are at it
- *	we decode and dump the ATA error for the user so that they
- *	have some idea what really happened at the non make-believe
- *	layer.
+ *	Converts an ATA error into a SCSI error.  Fill out pointers to
+ *	SK, ASC, and ASCQ bytes for later use in fixed or descriptor
+ *	format sense blocks.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
-
-void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc, 
+			u8 *ascq)
 {
-	struct scsi_cmnd *cmd = qc->scsicmd;
-	u8 err = 0;
+	int i;
+
 	/* Based on the 3ware driver translation table */
 	static unsigned char sense_table[][4] = {
 		/* BBD|ECC|ID|MAR */
@@ -230,96 +473,184 @@ void ata_to_sense_error(struct ata_queue
 		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	  Medium error, recovered
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
-	int i = 0;
 
 	/*
 	 *	Is this an error we can process/parse
 	 */
-
-	if(drv_stat & ATA_ERR)
-		/* Read the err bits */
-		err = ata_chk_err(qc->ap);
-
-	/* Display the ATA level error info */
-
-	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
-	if(drv_stat & 0x80)
-	{
-		printk("Busy ");
-		err = 0;	/* Data is not valid in this case */
+	if (drv_stat & ATA_BUSY) {
+		drv_err = 0;	/* Ignore the err bits, they're invalid */
 	}
-	else {
-		if(drv_stat & 0x40)	printk("DriveReady ");
-		if(drv_stat & 0x20)	printk("DeviceFault ");
-		if(drv_stat & 0x10)	printk("SeekComplete ");
-		if(drv_stat & 0x08)	printk("DataRequest ");
-		if(drv_stat & 0x04)	printk("CorrectedError ");
-		if(drv_stat & 0x02)	printk("Index ");
-		if(drv_stat & 0x01)	printk("Error ");
-	}
-	printk("}\n");
-
-	if(err)
-	{
-		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
-		if(err & 0x04)		printk("DriveStatusError ");
-		if(err & 0x80)
-		{
-			if(err & 0x04)
-				printk("BadCRC ");
-			else
-				printk("Sector ");
+
+	if (drv_err) {
+		/* Look for drv_err */
+		for (i = 0; sense_table[i][0] != 0xFF; i++) {
+			/* Look for best matches first */
+			if ((sense_table[i][0] & drv_err) == 
+			    sense_table[i][0]) {
+				*sk = sense_table[i][1];
+				*asc = sense_table[i][2];
+				*ascq = sense_table[i][3];
+				goto translate_done;
+			}
 		}
-		if(err & 0x40)		printk("UncorrectableError ");
-		if(err & 0x10)		printk("SectorIdNotFound ");
-		if(err & 0x02)		printk("TrackZeroNotFound ");
-		if(err & 0x01)		printk("AddrMarkNotFound ");
-		printk("}\n");
+		/* No immediate match */
+		printk(KERN_WARNING "ata%u: no sense translation for "
+		       "error 0x%02x\n", id, drv_err);
+	}
 
-		/* Should we dump sector info here too ?? */
+	/* Fall back to interpreting status bits */
+	for (i = 0; stat_table[i][0] != 0xFF; i++) {
+		if (stat_table[i][0] & drv_stat) {
+			*sk = stat_table[i][1];
+			*asc = stat_table[i][2];
+			*ascq = stat_table[i][3];
+			goto translate_done;
+		}
 	}
+	/* No error?  Undecoded? */
+	printk(KERN_WARNING "ata%u: no sense translation for status: 0x%02x\n", 
+	       id, drv_stat);
+
+	/* For our last chance pick, use medium read error because
+	 * it's much more common than an ATA drive telling you a write
+	 * has failed.
+	 */
+	*sk = MEDIUM_ERROR;
+	*asc = 0x11; /* "unrecovered read error" */
+	*ascq = 0x04; /*  "auto-reallocation failed" */
+
+ translate_done:
+	printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
+	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
+	       *sk, *asc, *ascq);
+	return;
+}
+
+/*
+ *	ata_gen_ata_desc_sense - Generate check condition sense block.
+ *	@qc: Command that completed.
+ *
+ *	This function is specific to the ATA descriptor format sense
+ *	block specified for the ATA pass through commands.  Regardless
+ *	of whether the command errored or not, return a sense
+ *	block. Copy all controller registers into the sense
+ *	block. Clear sense key, ASC & ASCQ if there is no error.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_gen_ata_desc_sense(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned char *sb = cmd->sense_buffer;
+	unsigned char *desc = sb + 8;
 
+	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
 
-	/* Look for err */
-	while(sense_table[i][0] != 0xFF)
-	{
-		/* Look for best matches first */
-		if((sense_table[i][0] & err) == sense_table[i][0])
-		{
-			ata_scsi_set_sense(cmd, sense_table[i][1] /* sk */,
-					   sense_table[i][2] /* asc */,
-					   sense_table[i][3] /* ascq */ );
-			return;
-		}
-		i++;
+	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
+
+	/*
+	 * Read the controller registers.
+	 */
+	assert(NULL != qc->ap->ops->tf_read);
+	qc->ap->ops->tf_read(qc->ap, tf);
+
+	/*
+	 * Use ata_to_sense_error() to map status register bits
+	 * onto sense key, asc & ascq.
+	 */
+	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
+				   &sb[1], &sb[2], &sb[3]);
+		sb[1] &= 0x0f;
 	}
-	/* No immediate match */
-	if(err)
-		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
 
-	i = 0;
-	/* Fall back to interpreting status bits */
-	while(stat_table[i][0] != 0xFF)
-	{
-		if(stat_table[i][0] & drv_stat)
-		{
-			ata_scsi_set_sense(cmd, sense_table[i][1] /* sk */,
-					   sense_table[i][2] /* asc */,
-					   sense_table[i][3] /* ascq */ );
-			return;
-		}
-		i++;
+	/*
+	 * Sense data is current and format is descriptor.
+	 */
+	sb[0] = 0x72;
+
+	desc[0] = 0x09;
+
+	/*
+	 * Set length of additional sense data.
+	 * Since we only populate descriptor 0, the total
+	 * length is the same (fixed) length as descriptor 0.
+	 */
+	desc[1] = sb[7] = 14;
+
+	/*
+	 * Copy registers into sense buffer.
+	 */
+	desc[2] = 0x00;
+	desc[3] = tf->feature;	/* == error reg */
+	desc[5] = tf->nsect;
+	desc[7] = tf->lbal;
+	desc[9] = tf->lbam;
+	desc[11] = tf->lbah;
+	desc[12] = tf->device;
+	desc[13] = tf->command; /* == status reg */
+
+	/*
+	 * Fill in Extend bit, and the high order bytes
+	 * if applicable.
+	 */
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		desc[2] |= 0x01;
+		desc[4] = tf->hob_nsect;
+		desc[6] = tf->hob_lbal;
+		desc[8] = tf->hob_lbam;
+		desc[10] = tf->hob_lbah;
 	}
-	/* No error ?? */
-	printk(KERN_ERR "ata%u: called with no error (%02X)!\n", qc->ap->id, drv_stat);
-	/* additional-sense-code[-qualifier] */
-
-	if (cmd->sc_data_direction == DMA_FROM_DEVICE) {
-		ata_scsi_set_sense(cmd, MEDIUM_ERROR, 0x11, 0x4);
-		/* "unrecovered read error" */
-	} else {
-		ata_scsi_set_sense(cmd, MEDIUM_ERROR, 0xc, 0x2);
-		/* "write error - auto-reallocation failed" */
+}
+
+/**
+ *	ata_gen_fixed_sense - generate a SCSI fixed sense block
+ *	@qc: Command that we are erroring out
+ *
+ *	Leverage ata_to_sense_error() to give us the codes.  Fit our
+ *	LBA in here if there's room.
+ *
+ *	LOCKING:
+ *	inherited from caller
+ */
+void ata_gen_fixed_sense(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned char *sb = cmd->sense_buffer;
+
+	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
+
+	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
+
+	/*
+	 * Read the controller registers.
+	 */
+	assert(NULL != qc->ap->ops->tf_read);
+	qc->ap->ops->tf_read(qc->ap, tf);
+
+	/*
+	 * Use ata_to_sense_error() to map status register bits
+	 * onto sense key, asc & ascq.
+	 */
+	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
+				   &sb[2], &sb[12], &sb[13]);
+		sb[2] &= 0x0f;
+	}
+
+	sb[0] = 0x70;
+	sb[7] = 0x0a;
+
+	if (tf->flags & ATA_TFLAG_LBA && !(tf->flags & ATA_TFLAG_LBA48)) {
+		/* A small (28b) LBA will fit in the 32b info field */
+		sb[0] |= 0x80;		/* set valid bit */
+		sb[3] = tf->device & 0x0f;
+		sb[4] = tf->lbah;
+		sb[5] = tf->lbam;
+		sb[6] = tf->lbal;
 	}
 }
 
@@ -871,11 +1202,36 @@ nothing_to_do:
 static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+ 	int need_sense = drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ);
 
-	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
-		ata_to_sense_error(qc, drv_stat);
-	else
-		cmd->result = SAM_STAT_GOOD;
+	/* For ATA pass thru (SAT) commands, generate a sense block if
+	 * user mandated it or if there's an error.  Note that if we
+	 * generate because the user forced us to, a check condition
+	 * is generated and the ATA register values are returned
+	 * whether the command completed successfully or not. If there
+	 * was no error, SK, ASC and ASCQ will all be zero.
+	 */
+	if (((cmd->cmnd[0] == ATA_16) || (cmd->cmnd[0] == ATA_12)) &&
+ 	    ((cmd->cmnd[2] & 0x20) || need_sense)) {
+ 		ata_gen_ata_desc_sense(qc);
+	} else {
+		if (!need_sense) {
+			cmd->result = SAM_STAT_GOOD;
+		} else {
+			/* TODO: decide which descriptor format to use
+			 * for 48b LBA devices and call that here
+			 * instead of the fixed desc, which is only
+			 * good for smaller LBA (and maybe CHS?)
+			 * devices.
+			 */
+			ata_gen_fixed_sense(qc);
+		}
+	}
+
+	if (need_sense) {
+		/* The ata_gen_..._sense routines fill in tf */
+		ata_dump_status(qc->ap->id, &qc->tf);
+	}
 
 	qc->scsidone(cmd);
 
@@ -1266,13 +1622,9 @@ static void ata_msense_push(u8 **ptr_io,
 static unsigned int ata_msense_caching(u16 *id, u8 **ptr_io,
 				       const u8 *last)
 {
-	u8 page[] = {
-		0x8,				/* page code */
-		0x12,				/* page length */
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 10 zeroes */
-		0, 0, 0, 0, 0, 0, 0, 0		/* 8 zeroes */
-	};
+	u8 page[CACHE_MPAGE_LEN];
 
+	memcpy(page, def_cache_mpage, sizeof(page));
 	if (ata_id_wcache_enabled(id))
 		page[2] |= (1 << 2);	/* write cache enable */
 	if (!ata_id_rahead_enabled(id))
@@ -1296,15 +1648,9 @@ static unsigned int ata_msense_caching(u
 
 static unsigned int ata_msense_ctl_mode(u8 **ptr_io, const u8 *last)
 {
-	const u8 page[] = {0xa, 0xa, 6, 0, 0, 0, 0, 0, 0xff, 0xff, 0, 30};
-
-	/* byte 2: set the descriptor format sense data bit (bit 2)
-	 * since we need to support returning this format for SAT
-	 * commands and any SCSI commands against a 48b LBA device.
-	 */
-
-	ata_msense_push(ptr_io, last, page, sizeof(page));
-	return sizeof(page);
+	ata_msense_push(ptr_io, last, def_control_mpage,
+			sizeof(def_control_mpage));
+	return sizeof(def_control_mpage);
 }
 
 /**
@@ -1321,15 +1667,10 @@ static unsigned int ata_msense_ctl_mode(
 
 static unsigned int ata_msense_rw_recovery(u8 **ptr_io, const u8 *last)
 {
-	const u8 page[] = {
-		0x1,			  /* page code */
-		0xa,			  /* page length */
-		(1 << 7) | (1 << 6),	  /* note auto r/w reallocation */
-		0, 0, 0, 0, 0, 0, 0, 0, 0 /* 9 zeroes */
-	};
 
-	ata_msense_push(ptr_io, last, page, sizeof(page));
-	return sizeof(page);
+	ata_msense_push(ptr_io, last, def_rw_recovery_mpage,
+			sizeof(def_rw_recovery_mpage));
+	return sizeof(def_rw_recovery_mpage);
 }
 
 /**
@@ -1338,7 +1679,9 @@ static unsigned int ata_msense_rw_recove
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
- *	Simulate MODE SENSE commands.
+ *	Simulate MODE SENSE commands. Assume this is invoked for direct
+ *	access devices (e.g. disks) only. There should be no block
+ *	descriptor for other device types.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
@@ -1348,15 +1691,22 @@ unsigned int ata_scsiop_mode_sense(struc
 				  unsigned int buflen)
 {
 	u8 *scsicmd = args->cmd->cmnd, *p, *last;
-	unsigned int page_control, six_byte, output_len;
+	const u8 sat_blk_desc[] = {
+		0, 0, 0, 0,	/* number of blocks: sat unspecified */
+		0,
+		0, 0x2, 0x0	/* block length: 512 bytes */
+	};
+	u8 pg, spg;
+	unsigned int ebd, page_control, six_byte, output_len, alloc_len, minlen;
 
 	VPRINTK("ENTER\n");
 
 	six_byte = (scsicmd[0] == MODE_SENSE);
-
-	/* we only support saved and current values (which we treat
-	 * in the same manner)
+	ebd = !(scsicmd[1] & 0x8);      /* dbd bit inverted == edb */
+	/*
+	 * LLBA bit in msense(10) ignored (compliant)
 	 */
+
 	page_control = scsicmd[2] >> 6;
 	switch (page_control) {
 	case 0: /* current */
@@ -1369,29 +1719,42 @@ unsigned int ata_scsiop_mode_sense(struc
 		goto invalid_fld;
 	}
 
-	if (six_byte)
-		output_len = 4;
-	else
-		output_len = 8;
+	if (six_byte) {
+		output_len = 4 + (ebd ? 8 : 0);
+		alloc_len = scsicmd[4];
+	} else {
+		output_len = 8 + (ebd ? 8 : 0);
+		alloc_len = (scsicmd[7] << 8) + scsicmd[8];
+	}
+	minlen = (alloc_len < buflen) ? alloc_len : buflen;
 
 	p = rbuf + output_len;
-	last = rbuf + buflen - 1;
+	last = rbuf + minlen - 1;
+
+	pg = scsicmd[2] & 0x3f;
+	spg = scsicmd[3];
+	/*
+	 * No mode subpages supported (yet) but asking for _all_
+	 * subpages may be valid
+	 */
+	if (spg && (spg != ALL_SUB_MPAGES))
+		goto invalid_fld;
 
-	switch(scsicmd[2] & 0x3f) {
-	case 0x01:		/* r/w error recovery */
+	switch(pg) {
+	case RW_RECOVERY_MPAGE:
 		output_len += ata_msense_rw_recovery(&p, last);
 		break;
 
-	case 0x08:		/* caching */
+	case CACHE_MPAGE:
 		output_len += ata_msense_caching(args->id, &p, last);
 		break;
 
-	case 0x0a: {		/* control mode */
+	case CONTROL_MPAGE: {
 		output_len += ata_msense_ctl_mode(&p, last);
 		break;
 		}
 
-	case 0x3f:		/* all pages */
+	case ALL_MPAGES:
 		output_len += ata_msense_rw_recovery(&p, last);
 		output_len += ata_msense_caching(args->id, &p, last);
 		output_len += ata_msense_ctl_mode(&p, last);
@@ -1401,15 +1764,31 @@ unsigned int ata_scsiop_mode_sense(struc
 		goto invalid_fld;
 	}
 
+	if (minlen < 1)
+		return 0;
 	if (six_byte) {
 		output_len--;
 		rbuf[0] = output_len;
+		if (ebd) {
+			if (minlen > 3)
+				rbuf[3] = sizeof(sat_blk_desc);
+			if (minlen > 11)
+				memcpy(rbuf + 4, sat_blk_desc,
+				       sizeof(sat_blk_desc));
+		}
 	} else {
 		output_len -= 2;
 		rbuf[0] = output_len >> 8;
-		rbuf[1] = output_len;
+		if (minlen > 1)
+			rbuf[1] = output_len;
+		if (ebd) {
+			if (minlen > 7)
+				rbuf[7] = sizeof(sat_blk_desc);
+			if (minlen > 15)
+				memcpy(rbuf + 8, sat_blk_desc,
+				       sizeof(sat_blk_desc));
+		}
 	}
-
 	return 0;
 
 invalid_fld:
@@ -1623,7 +2002,12 @@ static int atapi_qc_complete(struct ata_
 	VPRINTK("ENTER, drv_stat == 0x%x\n", drv_stat);
 
 	if (unlikely(drv_stat & (ATA_BUSY | ATA_DRQ)))
-		ata_to_sense_error(qc, drv_stat);
+		/* FIXME: not quite right; we don't want the
+		 * translation of taskfile registers into
+		 * a sense descriptors, since that's only
+		 * correct for ATA, not ATAPI
+		 */
+		ata_gen_ata_desc_sense(qc);
 
 	else if (unlikely(drv_stat & ATA_ERR)) {
 		DPRINTK("request check condition\n");
@@ -1782,6 +2166,143 @@ ata_scsi_find_dev(struct ata_port *ap, c
 	return dev;
 }
 
+/*
+ *	ata_scsi_map_proto - Map pass-thru protocol value to taskfile value.
+ *	@byte1: Byte 1 from pass-thru CDB.
+ *
+ *	RETURNS:
+ *	ATA_PROT_UNKNOWN if mapping failed/unimplemented, protocol otherwise.
+ */
+static u8
+ata_scsi_map_proto(u8 byte1)
+{
+	switch((byte1 & 0x1e) >> 1) {
+		case 3:		/* Non-data */
+			return ATA_PROT_NODATA;
+
+		case 6:		/* DMA */
+			return ATA_PROT_DMA;
+
+		case 4:		/* PIO Data-in */
+		case 5:		/* PIO Data-out */
+			if (byte1 & 0xe0) {
+				return ATA_PROT_PIO_MULT;
+			}
+			return ATA_PROT_PIO;
+
+		case 10:	/* Device Reset */
+		case 0:		/* Hard Reset */
+		case 1:		/* SRST */
+		case 2:		/* Bus Idle */
+		case 7:		/* Packet */
+		case 8:		/* DMA Queued */
+		case 9:		/* Device Diagnostic */
+		case 11:	/* UDMA Data-in */
+		case 12:	/* UDMA Data-Out */
+		case 13:	/* FPDMA */
+		default:	/* Reserved */
+			break;
+	}
+
+	return ATA_PROT_UNKNOWN;
+}
+
+/**
+ *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
+ *	@qc: command structure to be initialized
+ *	@cmd: SCSI command to convert
+ *
+ *	Handles either 12 or 16-byte versions of the CDB.
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on failure.
+ */
+static unsigned int
+ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
+{
+	struct ata_taskfile *tf = &(qc->tf);
+	struct scsi_cmnd *cmd = qc->scsicmd;
+
+	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN)
+		return 1;
+
+	/*
+	 * 12 and 16 byte CDBs use different offsets to
+	 * provide the various register values.
+	 */
+	if (scsicmd[0] == ATA_16) {
+		/*
+		 * 16-byte CDB - may contain extended commands.
+		 *
+		 * If that is the case, copy the upper byte register values.
+		 */
+		if (scsicmd[1] & 0x01) {
+			tf->hob_feature = scsicmd[3];
+			tf->hob_nsect = scsicmd[5];
+			tf->hob_lbal = scsicmd[7];
+			tf->hob_lbam = scsicmd[9];
+			tf->hob_lbah = scsicmd[11];
+			tf->flags |= ATA_TFLAG_LBA48;
+		} else
+			tf->flags &= ~ATA_TFLAG_LBA48;
+
+		/*
+		 * Always copy low byte, device and command registers.
+		 */
+		tf->feature = scsicmd[4];
+		tf->nsect = scsicmd[6];
+		tf->lbal = scsicmd[8];
+		tf->lbam = scsicmd[10];
+		tf->lbah = scsicmd[12];
+		tf->device = scsicmd[13];
+		tf->command = scsicmd[14];
+	} else {
+		/*
+		 * 12-byte CDB - incapable of extended commands.
+		 */
+		tf->flags &= ~ATA_TFLAG_LBA48;
+
+		tf->feature = scsicmd[3];
+		tf->nsect = scsicmd[4];
+		tf->lbal = scsicmd[5];
+		tf->lbam = scsicmd[6];
+		tf->lbah = scsicmd[7];
+		tf->device = scsicmd[8];
+		tf->command = scsicmd[9];
+	}
+
+	/*
+	 * Filter SET_FEATURES - XFER MODE command -- otherwise,
+	 * SET_FEATURES - XFER MODE must be preceded/succeeded
+	 * by an update to hardware-specific registers for each
+	 * controller (i.e. the reason for ->set_piomode(),
+	 * ->set_dmamode(), and ->post_set_mode() hooks).
+	 */
+	if ((tf->command == ATA_CMD_SET_FEATURES)
+	 && (tf->feature == SETFEATURES_XFER))
+		return 1;
+
+	/*
+	 * Set flags so that all registers will be written,
+	 * and pass on write indication (used for PIO/DMA
+	 * setup.)
+	 */
+	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE);
+
+	if (cmd->sc_data_direction == DMA_TO_DEVICE)
+		tf->flags |= ATA_TFLAG_WRITE;
+
+	/*
+	 * Set transfer length.
+	 *
+	 * TODO: find out if we need to do more here to
+	 *       cover scatter/gather case.
+	 */
+	qc->nsect = cmd->bufflen / ATA_SECT_SIZE;
+
+	return 0;
+}
+
 /**
  *	ata_get_xlat_func - check if SCSI to ATA translation is possible
  *	@dev: ATA device
@@ -1814,6 +2335,11 @@ static inline ata_xlat_func_t ata_get_xl
 	case VERIFY:
 	case VERIFY_16:
 		return ata_scsi_verify_xlat;
+
+	case ATA_12:
+	case ATA_16:
+		return ata_scsi_pass_thru;
+
 	case START_STOP:
 		return ata_scsi_start_stop_xlat;
 	}
@@ -1972,7 +2498,7 @@ void ata_scsi_simulate(u16 *id,
 			ata_scsi_rbuf_fill(&args, ata_scsiop_report_luns);
 			break;
 
-		/* mandantory commands we haven't implemented yet */
+		/* mandatory commands we haven't implemented yet */
 		case REQUEST_SENSE:
 
 		/* all other commands */
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 3d60190..65c264b 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -50,13 +50,14 @@ extern void ata_dev_select(struct ata_po
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, const struct ata_taskfile *tf);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
+extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
+extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 
 
 /* libata-scsi.c */
 extern void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
 			 struct scsi_cmnd *cmd);
 extern void ata_scsi_scan_host(struct ata_port *ap);
-extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 9820f27..af99feb 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -46,7 +46,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pdc_adma"
-#define DRV_VERSION	"0.01"
+#define DRV_VERSION	"0.03"
 
 /* macro to calculate base address for ATA regs */
 #define ADMA_ATA_REGS(base,port_no)	((base) + ((port_no) * 0x40))
@@ -79,7 +79,6 @@ enum {
 	aNIEN			= (1 << 8), /* irq mask: 1==masked */
 	aGO			= (1 << 7), /* packet trigger ("Go!") */
 	aRSTADM			= (1 << 5), /* ADMA logic reset */
-	aRSTA			= (1 << 2), /* ATA hard reset */
 	aPIOMD4			= 0x0003,   /* PIO mode 4 */
 
 	/* ADMA_STATUS register bits */
@@ -452,24 +451,25 @@ static inline unsigned int adma_intr_pkt
 		struct adma_port_priv *pp;
 		struct ata_queued_cmd *qc;
 		void __iomem *chan = ADMA_REGS(mmio_base, port_no);
-		u8 drv_stat, status = readb(chan + ADMA_STATUS);
+		u8 drv_stat = 0, status = readb(chan + ADMA_STATUS);
 
 		if (status == 0)
 			continue;
 		handled = 1;
 		adma_enter_reg_mode(ap);
-		if ((ap->flags & ATA_FLAG_PORT_DISABLED))
+		if (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))
 			continue;
 		pp = ap->private_data;
 		if (!pp || pp->state != adma_state_pkt)
 			continue;
 		qc = ata_qc_from_tag(ap, ap->active_tag);
-		drv_stat = 0;
-		if ((status & (aPERR | aPSD | aUIRQ)))
-			drv_stat = ATA_ERR;
-		else if (pp->pkt[0] != cDONE)
-			drv_stat = ATA_ERR;
-		ata_qc_complete(qc, drv_stat);
+		if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+			if ((status & (aPERR | aPSD | aUIRQ)))
+				drv_stat = ATA_ERR;
+			else if (pp->pkt[0] != cDONE)
+				drv_stat = ATA_ERR;
+			ata_qc_complete(qc, drv_stat);
+		}
 	}
 	return handled;
 }
@@ -490,7 +490,7 @@ static inline unsigned int adma_intr_mmi
 			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 
 				/* check main status, clearing INTRQ */
-				u8 status = ata_chk_status(ap);
+				u8 status = ata_check_status(ap);
 				if ((status & ATA_BUSY))
 					continue;
 				DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
@@ -561,15 +561,15 @@ static int adma_port_start(struct ata_po
 	if ((pp->pkt_dma & 7) != 0) {
 		printk("bad alignment for pp->pkt_dma: %08x\n",
 						(u32)pp->pkt_dma);
-		goto err_out_kfree2;
+		dma_free_coherent(dev, ADMA_PKT_BYTES,
+						pp->pkt, pp->pkt_dma);
+		goto err_out_kfree;
 	}
 	memset(pp->pkt, 0, ADMA_PKT_BYTES);
 	ap->private_data = pp;
 	adma_reinit_engine(ap);
 	return 0;
 
-err_out_kfree2:
-	kfree(pp);
 err_out_kfree:
 	kfree(pp);
 err_out:
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index eee93b0..63911f1 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -195,6 +195,8 @@ static struct ata_port_info pdc_port_inf
 static struct pci_device_id pdc_ata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3570, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3571, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -207,6 +209,8 @@ static struct pci_device_id pdc_ata_pci_
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d73, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 
 	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 250dafa..1aaf330 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -433,7 +433,7 @@ static inline unsigned int qs_intr_mmio(
 			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 
 				/* check main status, clearing INTRQ */
-				u8 status = ata_chk_status(ap);
+				u8 status = ata_check_status(ap);
 				if ((status & ATA_BUSY))
 					continue;
 				DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 32d730b..51855d3 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -220,8 +220,8 @@ struct sil24_port_priv {
 
 /* ap->host_set->private_data */
 struct sil24_host_priv {
-	void *host_base;	/* global controller control (128 bytes @BAR0) */
-	void *port_base;	/* port registers (4 * 8192 bytes @BAR2) */
+	void __iomem *host_base;	/* global controller control (128 bytes @BAR0) */
+	void __iomem *port_base;	/* port registers (4 * 8192 bytes @BAR2) */
 };
 
 static u8 sil24_check_status(struct ata_port *ap);
@@ -349,10 +349,12 @@ static struct ata_port_info sil24_port_i
 static inline void sil24_update_tf(struct ata_port *ap)
 {
 	struct sil24_port_priv *pp = ap->private_data;
-	void *port = (void *)ap->ioaddr.cmd_addr;
-	struct sil24_prb *prb = port;
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct sil24_prb __iomem *prb = port;
+	u8 fis[6 * 4];
 
-	ata_tf_from_fis(prb->fis, &pp->tf);
+	memcpy_fromio(fis, prb->fis, 6 * 4);
+	ata_tf_from_fis(fis, &pp->tf);
 }
 
 static u8 sil24_check_status(struct ata_port *ap)
@@ -376,9 +378,9 @@ static int sil24_scr_map[] = {
 
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg)
 {
-	void *scr_addr = (void *)ap->ioaddr.scr_addr;
+	void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
-		void *addr;
+		void __iomem *addr;
 		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
 		return readl(scr_addr + sil24_scr_map[sc_reg] * 4);
 	}
@@ -387,9 +389,9 @@ static u32 sil24_scr_read(struct ata_por
 
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 {
-	void *scr_addr = (void *)ap->ioaddr.scr_addr;
+	void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
-		void *addr;
+		void __iomem *addr;
 		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
 		writel(val, scr_addr + sil24_scr_map[sc_reg] * 4);
 	}
@@ -454,7 +456,7 @@ static void sil24_qc_prep(struct ata_que
 static int sil24_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void *port = (void *)ap->ioaddr.cmd_addr;
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
 	dma_addr_t paddr = pp->cmd_block_dma + qc->tag * sizeof(*pp->cmd_block);
 
@@ -467,7 +469,7 @@ static void sil24_irq_clear(struct ata_p
 	/* unused */
 }
 
-static int __sil24_reset_controller(void *port)
+static int __sil24_reset_controller(void __iomem *port)
 {
 	int cnt;
 	u32 tmp;
@@ -493,7 +495,7 @@ static void sil24_reset_controller(struc
 {
 	printk(KERN_NOTICE DRV_NAME
 	       " ata%u: resetting controller...\n", ap->id);
-	if (__sil24_reset_controller((void *)ap->ioaddr.cmd_addr))
+	if (__sil24_reset_controller((void __iomem *)ap->ioaddr.cmd_addr))
                 printk(KERN_ERR DRV_NAME
                        " ata%u: failed to reset controller\n", ap->id);
 }
@@ -527,7 +529,7 @@ static void sil24_error_intr(struct ata_
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	struct sil24_port_priv *pp = ap->private_data;
-	void *port = (void *)ap->ioaddr.cmd_addr;
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	u32 irq_stat, cmd_err, sstatus, serror;
 
 	irq_stat = readl(port + PORT_IRQ_STAT);
@@ -574,7 +576,7 @@ static void sil24_error_intr(struct ata_
 static inline void sil24_host_intr(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
-	void *port = (void *)ap->ioaddr.cmd_addr;
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	u32 slot_stat;
 
 	slot_stat = readl(port + PORT_SLOT_STAT);
@@ -689,7 +691,8 @@ static int sil24_init_one(struct pci_dev
 	struct ata_port_info *pinfo = &sil24_port_info[board_id];
 	struct ata_probe_ent *probe_ent = NULL;
 	struct sil24_host_priv *hpriv = NULL;
-	void *host_base = NULL, *port_base = NULL;
+	void __iomem *host_base = NULL;
+	void __iomem *port_base = NULL;
 	int i, rc;
 
 	if (!printed_version++)
@@ -771,7 +774,7 @@ static int sil24_init_one(struct pci_dev
 	writel(0, host_base + HOST_CTRL);
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
-		void *port = port_base + i * PORT_REGS_SIZE;
+		void __iomem *port = port_base + i * PORT_REGS_SIZE;
 		unsigned long portu = (unsigned long)port;
 		u32 tmp;
 		int cnt;
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index e0f9570..46208f5 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -84,6 +84,8 @@
 /* Port stride */
 #define K2_SATA_PORT_OFFSET		0x100
 
+static u8 k2_stat_check_status(struct ata_port *ap);
+
 
 static u32 k2_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
@@ -136,16 +138,24 @@ static void k2_sata_tf_load(struct ata_p
 static void k2_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u16 nsect, lbal, lbam, lbah;
+	u16 nsect, lbal, lbam, lbah, feature;
 
-	nsect = tf->nsect = readw(ioaddr->nsect_addr);
-	lbal = tf->lbal = readw(ioaddr->lbal_addr);
-	lbam = tf->lbam = readw(ioaddr->lbam_addr);
-	lbah = tf->lbah = readw(ioaddr->lbah_addr);
+	tf->command = k2_stat_check_status(ap);
 	tf->device = readw(ioaddr->device_addr);
+	feature = readw(ioaddr->error_addr);
+	nsect = readw(ioaddr->nsect_addr);
+	lbal = readw(ioaddr->lbal_addr);
+	lbam = readw(ioaddr->lbam_addr);
+	lbah = readw(ioaddr->lbah_addr);
+
+	tf->feature = feature;
+	tf->nsect = nsect;
+	tf->lbal = lbal;
+	tf->lbam = lbam;
+	tf->lbah = lbah;
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readw(ioaddr->error_addr) >> 8;
+		tf->hob_feature = feature >> 8;
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 5af05fd..54273e0 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -153,16 +153,24 @@ static void vsc_sata_tf_load(struct ata_
 static void vsc_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u16 nsect, lbal, lbam, lbah;
+	u16 nsect, lbal, lbam, lbah, feature;
 
-	nsect = tf->nsect = readw(ioaddr->nsect_addr);
-	lbal = tf->lbal = readw(ioaddr->lbal_addr);
-	lbam = tf->lbam = readw(ioaddr->lbam_addr);
-	lbah = tf->lbah = readw(ioaddr->lbah_addr);
+	tf->command = ata_check_status(ap);
 	tf->device = readw(ioaddr->device_addr);
+	feature = readw(ioaddr->error_addr);
+	nsect = readw(ioaddr->nsect_addr);
+	lbal = readw(ioaddr->lbal_addr);
+	lbam = readw(ioaddr->lbam_addr);
+	lbah = readw(ioaddr->lbah_addr);
+
+	tf->feature = feature;
+	tf->nsect = nsect;
+	tf->lbal = lbal;
+	tf->lbam = lbam;
+	tf->lbah = lbah;
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readb(ioaddr->error_addr);
+		tf->hob_feature = feature >> 8;
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index b361172..6cb1e27 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -116,6 +116,9 @@ extern const char *const scsi_device_typ
 /* values for service action in */
 #define	SAI_READ_CAPACITY_16  0x10
 
+/* Values for T10/04-262r7 */
+#define	ATA_16		      0x85	/* 16-byte pass-thru */
+#define	ATA_12		      0xa1	/* 12-byte pass-thru */
 
 /*
  *  SCSI Architecture Model (SAM) Status codes. Taken from SAM-3 draft
