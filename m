Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbVIMTXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbVIMTXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVIMTXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:23:50 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:38357 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964970AbVIMTXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:23:48 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Douglas Gilbert <dougg@torque.net>, Christoph Hellwig <hch@infradead.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050912184629.GA13489@us.ibm.com>
References: <1126308304.4799.45.camel@mulgrave>
	 <20050910024454.20602.qmail@web51613.mail.yahoo.com>
	 <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net>
	 <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com>
	 <1126545680.4825.40.camel@mulgrave>  <20050912184629.GA13489@us.ibm.com>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 14:22:22 -0500
Message-Id: <1126639342.4809.53.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 11:46 -0700, Patrick Mansfield wrote:
> Though we still have problems with scsi_report_lun_scan code like:
> 
>                 } else if (lun > sdev->host->max_lun) {
> 
> max_lun just has to be large, at least greater than 0xc001 (49153), maybe
> even 0xffffffff, correct?
> 
> But then some sequential scanning could take a while. Maybe the above
> check is not needed.

Try this as a straw horse for doing full u64 luns.

I've converted all the mid-layer and the ULDs; I ran out of steam at the
lld's.

This should work transparently for all luns up to 255 (using
representation 00b), so I've limited all of our sequential LUN scans to
255

This actually boots ... but I don't have a system with >1 LUN currently.

James

diff --git a/drivers/scsi/constants.c b/drivers/scsi/constants.c
--- a/drivers/scsi/constants.c
+++ b/drivers/scsi/constants.c
@@ -1389,10 +1389,7 @@ EXPORT_SYMBOL(scsi_print_msg);
 void scsi_print_command(struct scsi_cmnd *cmd)
 {
 	/* Assume appended output (i.e. not at start of line) */
-	printk("scsi%d : destination target %d, lun %d\n", 
-		cmd->device->host->host_no, 
-		cmd->device->id, 
-		cmd->device->lun);
+	dev_printk("", &cmd->device->sdev_gendev, "\n");
 	printk(KERN_INFO "        command: ");
 	scsi_print_cdb(cmd->cmnd, cmd->cmd_len, 0);
 }
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -5817,9 +5817,9 @@ static int osst_probe(struct device *dev
 	}
 	drive->number = devfs_register_tape(SDp->devfs_name);
 
-	printk(KERN_INFO
-		"osst :I: Attached OnStream %.5s tape at scsi%d, channel %d, id %d, lun %d as %s\n",
-		SDp->model, SDp->host->host_no, SDp->channel, SDp->id, SDp->lun, tape_name(tpnt));
+	dev_printk(KERN_INFO, &SDp->sdev_gendev,
+		"osst :I: Attached OnStream %.5s tape as %s\n",
+		SDp->model, tape_name(tpnt));
 
 	return 0;
 
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -410,9 +410,7 @@ void scsi_log_send(struct scsi_cmnd *cmd
 				       SCSI_LOG_MLQUEUE_BITS);
 		if (level > 1) {
 			sdev = cmd->device;
-			printk(KERN_INFO "scsi <%d:%d:%d:%d> send ",
-			       sdev->host->host_no, sdev->channel, sdev->id,
-			       sdev->lun);
+			dev_printk(KERN_INFO, &sdev->sdev_gendev, "send ");
 			if (level > 2)
 				printk("0x%p ", cmd);
 			/*
@@ -456,9 +454,7 @@ void scsi_log_completion(struct scsi_cmn
 		if (((level > 0) && (cmd->result || disposition != SUCCESS)) ||
 		    (level > 1)) {
 			sdev = cmd->device;
-			printk(KERN_INFO "scsi <%d:%d:%d:%d> done ",
-			       sdev->host->host_no, sdev->channel, sdev->id,
-			       sdev->lun);
+			dev_printk(KERN_INFO, &sdev->sdev_gendev, "done ");
 			if (level > 2)
 				printk("0x%p ", cmd);
 			/*
@@ -970,10 +966,9 @@ void scsi_adjust_queue_depth(struct scsi
 			sdev->simple_tags = 1;
 			break;
 		default:
-			printk(KERN_WARNING "(scsi%d:%d:%d:%d) "
+			dev_printk(KERN_WARNING, &sdev->sdev_gendev,
 				"scsi_adjust_queue_depth, bad queue type, "
-				"disabled\n", sdev->host->host_no,
-				sdev->channel, sdev->id, sdev->lun); 
+				   "disabled\n");
 		case 0:
 			sdev->ordered_tags = sdev->simple_tags = 0;
 			sdev->queue_depth = tags;
@@ -1134,12 +1129,12 @@ EXPORT_SYMBOL(starget_for_each_device);
  * really want to use scsi_device_lookup_by_target instead.
  **/
 struct scsi_device *__scsi_device_lookup_by_target(struct scsi_target *starget,
-						   uint lun)
+						   u64 lun)
 {
 	struct scsi_device *sdev;
 
 	list_for_each_entry(sdev, &starget->devices, same_target_siblings) {
-		if (sdev->lun ==lun)
+		if (sdev->lun == lun)
 			return sdev;
 	}
 
@@ -1157,7 +1152,7 @@ EXPORT_SYMBOL(__scsi_device_lookup_by_ta
  * needs to be release with scsi_host_put once you're done with it.
  **/
 struct scsi_device *scsi_device_lookup_by_target(struct scsi_target *starget,
-						 uint lun)
+						 u64 lun)
 {
 	struct scsi_device *sdev;
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
@@ -1190,7 +1185,7 @@ EXPORT_SYMBOL(scsi_device_lookup_by_targ
  * really want to use scsi_device_lookup instead.
  **/
 struct scsi_device *__scsi_device_lookup(struct Scsi_Host *shost,
-		uint channel, uint id, uint lun)
+		uint channel, uint id, u64 lun)
 {
 	struct scsi_device *sdev;
 
@@ -1216,7 +1211,7 @@ EXPORT_SYMBOL(__scsi_device_lookup);
  * needs to be release with scsi_host_put once you're done with it.
  **/
 struct scsi_device *scsi_device_lookup(struct Scsi_Host *shost,
-		uint channel, uint id, uint lun)
+		uint channel, uint id, u64 lun)
 {
 	struct scsi_device *sdev;
 	unsigned long flags;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -237,11 +237,10 @@ static inline void scsi_eh_prt_fail_stat
 
 		if (cmd_cancel || cmd_failed) {
 			SCSI_LOG_ERROR_RECOVERY(3,
-				printk("%s: %d:%d:%d:%d cmds failed: %d,"
-				       " cancel: %d\n",
-				       __FUNCTION__, shost->host_no,
-				       sdev->channel, sdev->id, sdev->lun,
-				       cmd_failed, cmd_cancel));
+				dev_printk(KERN_INFO, &sdev->sdev_gendev,
+					   "%s: cmds failed: %d, cancel: %d\n",
+					   __FUNCTION__, cmd_failed,
+					   cmd_cancel));
 			cmd_cancel = 0;
 			cmd_failed = 0;
 			++devices_failed;
@@ -1170,13 +1169,9 @@ static void scsi_eh_offline_sdevs(struct
 	struct scsi_cmnd *scmd, *next;
 
 	list_for_each_entry_safe(scmd, next, work_q, eh_entry) {
-		printk(KERN_INFO "scsi: Device offlined - not"
-		       		" ready after error recovery: host"
-				" %d channel %d id %d lun %d\n",
-				scmd->device->host->host_no,
-				scmd->device->channel,
-				scmd->device->id,
-				scmd->device->lun);
+		dev_printk(KERN_INFO, &scmd->device->sdev_gendev,
+			   "scsi: Device offlined - not"
+			   " ready after error recovery\n");
 		scsi_device_set_state(scmd->device, SDEV_OFFLINE);
 		if (scmd->eh_eflags & SCSI_EH_CANCEL_CMD) {
 			/*
@@ -1338,10 +1333,8 @@ int scsi_decide_disposition(struct scsi_
 		return SUCCESS;
 
 	case RESERVATION_CONFLICT:
-		printk(KERN_INFO "scsi: reservation conflict: host"
-                                " %d channel %d id %d lun %d\n",
-		       scmd->device->host->host_no, scmd->device->channel,
-		       scmd->device->id, scmd->device->lun);
+		dev_printk(KERN_INFO, &scmd->device->sdev_gendev,
+			   "reservation conflict\n");
 		return SUCCESS; /* causes immediate i/o error */
 	default:
 		return FAILED;
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -122,13 +122,9 @@ static int ioctl_internal_command(struct
 				break;
 			}
 		default:	/* Fall through for non-removable media */
-			printk(KERN_INFO "ioctl_internal_command: <%d %d %d "
-			       "%d> return code = %x\n",
-			       sdev->host->host_no,
-			       sdev->channel,
-			       sdev->id,
-			       sdev->lun,
-			       result);
+			dev_printk(KERN_INFO, &sdev->sdev_gendev,
+				   "ioctl_internal_command return code = %x\n",
+				   result);
 			scsi_print_sense_hdr("   ", &sshdr);
 			break;
 		}
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1144,8 +1144,8 @@ static int scsi_prep_fn(struct request_q
 	 * online before trying any recovery commands
 	 */
 	if (unlikely(!scsi_device_online(sdev))) {
-		printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to offline device\n",
-		       sdev->host->host_no, sdev->id, sdev->lun);
+		dev_printk(KERN_ERR, &sdev->sdev_gendev,
+			   "rejecting I/O to offline device\n");
 		goto kill;
 	}
 	if (unlikely(sdev->sdev_state != SDEV_RUNNING)) {
@@ -1154,8 +1154,8 @@ static int scsi_prep_fn(struct request_q
 		if (sdev->sdev_state == SDEV_DEL) {
 			/* Device is fully deleted, no commands
 			 * at all allowed down */
-			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to dead device\n",
-			       sdev->host->host_no, sdev->id, sdev->lun);
+			dev_printk(KERN_ERR, &sdev->sdev_gendev,
+				   "rejecting I/O to dead device\n");
 			goto kill;
 		}
 		/* OK, we only allow special commands (i.e. not
@@ -1190,8 +1190,8 @@ static int scsi_prep_fn(struct request_q
 					specials_only == SDEV_BLOCK)
 				goto defer;
 			
-			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to device being removed\n",
-			       sdev->host->host_no, sdev->id, sdev->lun);
+			dev_printk(KERN_ERR, &sdev->sdev_gendev,
+				   "rejecting I/O to device being removed\n");
 			goto kill;
 		}
 			
@@ -1317,9 +1317,8 @@ static inline int scsi_dev_queue_ready(s
 		 */
 		if (--sdev->device_blocked == 0) {
 			SCSI_LOG_MLQUEUE(3,
-				printk("scsi%d (%d:%d) unblocking device at"
-				       " zero depth\n", sdev->host->host_no,
-				       sdev->id, sdev->lun));
+				dev_printk(KERN_INFO, &sdev->sdev_gendev,
+				   "unblocking device at zero depth\n"));
 		} else {
 			blk_plug_device(q);
 			return 0;
@@ -1438,8 +1437,8 @@ static void scsi_request_fn(struct reque
 			break;
 
 		if (unlikely(!scsi_device_online(sdev))) {
-			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to offline device\n",
-			       sdev->host->host_no, sdev->id, sdev->lun);
+			dev_printk(KERN_ERR, &sdev->sdev_gendev,
+				   "rejecting I/O to offline device\n");
 			scsi_kill_request(req, q);
 			continue;
 		}
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -103,7 +103,7 @@ extern void scsi_exit_procfs(void);
 
 /* scsi_scan.c */
 extern int scsi_scan_host_selected(struct Scsi_Host *, unsigned int,
-				   unsigned int, unsigned int, int);
+				   unsigned int, u64, int);
 extern void scsi_forget_host(struct Scsi_Host *);
 extern void scsi_rescan_device(struct device *);
 
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -149,8 +149,9 @@ static int proc_print_scsidevice(struct 
 	int i;
 
 	seq_printf(s,
-		"Host: scsi%d Channel: %02d Id: %02d Lun: %02d\n  Vendor: ",
-		sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
+		"Host: scsi%d Channel: %02d Id: %02d Lun: %02lld\n  Vendor: ",
+		sdev->host->host_no, sdev->channel, sdev->id,
+		   (unsigned long long)sdev->lun);
 	for (i = 0; i < 8; i++) {
 		if (sdev->vendor[i] >= 0x20)
 			seq_printf(s, "%c", sdev->vendor[i]);
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -79,12 +79,12 @@ static char *scsi_null_device_strs = "nu
 #define MAX_SCSI_LUNS	512
 
 #ifdef CONFIG_SCSI_MULTI_LUN
-static unsigned int max_scsi_luns = MAX_SCSI_LUNS;
+static u64 max_scsi_luns = MAX_SCSI_LUNS;
 #else
-static unsigned int max_scsi_luns = 1;
+static u64 max_scsi_luns = 1;
 #endif
 
-module_param_named(max_luns, max_scsi_luns, int, S_IRUGO|S_IWUSR);
+module_param_named(max_luns, max_scsi_luns, long, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(max_luns,
 		 "last scsi LUN (should be between 1 and 2^32-1)");
 
@@ -462,10 +462,9 @@ static int scsi_probe_lun(struct scsi_de
 	pass = 1;
 
  next_pass:
-	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: INQUIRY pass %d "
-			"to host %d channel %d id %d lun %d, length %d\n",
-			pass, sdev->host->host_no, sdev->channel,
-			sdev->id, sdev->lun, try_inquiry_len));
+	SCSI_LOG_SCAN_BUS(3, dev_printk(KERN_INFO, &sdev->sdev_gendev,
+				"scsi scan: INQUIRY pass %d length %d\n",
+				pass, try_inquiry_len));
 
 	/* Each pass gets up to three chances to ignore Unit Attention */
 	for (count = 0; count < 3; ++count) {
@@ -694,9 +693,9 @@ static int scsi_add_lun(struct scsi_devi
 	if (inq_result[7] & 0x10)
 		sdev->sdtr = 1;
 
-	sprintf(sdev->devfs_name, "scsi/host%d/bus%d/target%d/lun%d",
+	sprintf(sdev->devfs_name, "scsi/host%d/bus%d/target%d/lun%lld",
 				sdev->host->host_no, sdev->channel,
-				sdev->id, sdev->lun);
+				sdev->id, (unsigned long long)sdev->lun);
 
 	/*
 	 * End driverfs/devfs code.
@@ -790,7 +789,7 @@ static int scsi_add_lun(struct scsi_devi
  *     SCSI_SCAN_LUN_PRESENT: a new Scsi_Device was allocated and initialized
  **/
 static int scsi_probe_and_add_lun(struct scsi_target *starget,
-				  uint lun, int *bflagsp,
+				  u64 lun, int *bflagsp,
 				  struct scsi_device **sdevp, int rescan,
 				  void *hostdata)
 {
@@ -965,6 +964,13 @@ static void scsi_sequential_lun_scan(str
 		max_dev_lun = min(8U, max_dev_lun);
 
 	/*
+	 * regardless of what parameters we derived above, on no
+	 * account scan further than SCSI_SCAN_LIMIT_LUNS
+	 */
+	if (max_dev_lun > SCSI_SCAN_LIMIT_LUNS + 1)
+		max_dev_lun = SCSI_SCAN_LIMIT_LUNS + 1;
+
+	/*
 	 * We have already scanned LUN 0, so start at LUN 1. Keep scanning
 	 * until we reach the max, or no LUN is found and we are not
 	 * sparse_lun.
@@ -995,17 +1001,18 @@ static void scsi_sequential_lun_scan(str
  *     Given a struct scsi_lun of: 0a 04 0b 03 00 00 00 00, this function returns
  *     the integer: 0x0b030a04
  **/
-static int scsilun_to_int(struct scsi_lun *scsilun)
+u64 scsilun_to_int(struct scsi_lun *scsilun)
 {
 	int i;
-	unsigned int lun;
+	u64 lun;
 
 	lun = 0;
 	for (i = 0; i < sizeof(lun); i += 2)
-		lun = lun | (((scsilun->scsi_lun[i] << 8) |
+		lun = lun | (((scsilun->scsi_lun[i] << ((i + 1) * 8)) |
 			      scsilun->scsi_lun[i + 1]) << (i * 8));
 	return lun;
 }
+EXPORT_SYMBOL(scsilun_to_int);
 
 /**
  * int_to_scsilun: reverts an int into a scsi_lun
@@ -1025,7 +1032,7 @@ static int scsilun_to_int(struct scsi_lu
  *     scsi_lun of : struct scsi_lun of: 0a 04 0b 03 00 00 00 00
  *
  **/
-void int_to_scsilun(unsigned int lun, struct scsi_lun *scsilun)
+void int_to_scsilun(u64 lun, struct scsi_lun *scsilun)
 {
 	int i;
 
@@ -1060,7 +1067,7 @@ static int scsi_report_lun_scan(struct s
 	char devname[64];
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
 	unsigned int length;
-	unsigned int lun;
+	u64 lun;
 	unsigned int num_luns;
 	unsigned int retries;
 	int result;
@@ -1184,31 +1191,14 @@ static int scsi_report_lun_scan(struct s
 	for (lunp = &lun_data[1]; lunp <= &lun_data[num_luns]; lunp++) {
 		lun = scsilun_to_int(lunp);
 
-		/*
-		 * Check if the unused part of lunp is non-zero, and so
-		 * does not fit in lun.
-		 */
-		if (memcmp(&lunp->scsi_lun[sizeof(lun)], "\0\0\0\0", 4)) {
-			int i;
-
-			/*
-			 * Output an error displaying the LUN in byte order,
-			 * this differs from what linux would print for the
-			 * integer LUN value.
-			 */
-			printk(KERN_WARNING "scsi: %s lun 0x", devname);
-			data = (char *)lunp->scsi_lun;
-			for (i = 0; i < sizeof(struct scsi_lun); i++)
-				printk("%02x", data[i]);
-			printk(" has a LUN larger than currently supported.\n");
-		} else if (lun == 0) {
+		if (lun == 0) {
 			/*
 			 * LUN 0 has already been scanned.
 			 */
 		} else if (lun > sdev->host->max_lun) {
-			printk(KERN_WARNING "scsi: %s lun%d has a LUN larger"
+			printk(KERN_WARNING "scsi: %s lun%llu has a LUN larger"
 			       " than allowed by the host adapter\n",
-			       devname, lun);
+			       devname, (unsigned long long)lun);
 		} else {
 			int res;
 
@@ -1219,8 +1209,9 @@ static int scsi_report_lun_scan(struct s
 				 * Got some results, but now none, abort.
 				 */
 				printk(KERN_ERR "scsi: Unexpected response"
-				       " from %s lun %d while scanning, scan"
-				       " aborted\n", devname, lun);
+				       " from %s lun %lld while scanning, scan"
+				       " aborted\n", devname,
+				       (unsigned long long)lun);
 				break;
 			}
 		}
@@ -1265,7 +1256,7 @@ struct scsi_device *__scsi_add_device(st
 EXPORT_SYMBOL(__scsi_add_device);
 
 int scsi_add_device(struct Scsi_Host *host, uint channel,
-		    uint target, uint lun)
+		    uint target, u64 lun)
 {
 	struct scsi_device *sdev = 
 		__scsi_add_device(host, channel, target, lun, NULL);
@@ -1294,7 +1285,7 @@ void scsi_rescan_device(struct device *d
 EXPORT_SYMBOL(scsi_rescan_device);
 
 static void __scsi_scan_target(struct device *parent, unsigned int channel,
-		unsigned int id, unsigned int lun, int rescan)
+		unsigned int id, u64 lun, int rescan)
 {
 	struct Scsi_Host *shost = dev_to_shost(parent);
 	int bflags = 0;
@@ -1372,7 +1363,7 @@ static void __scsi_scan_target(struct de
  *     sequential scan of LUNs on the target id.
  **/
 void scsi_scan_target(struct device *parent, unsigned int channel,
-		      unsigned int id, unsigned int lun, int rescan)
+		      unsigned int id, u64 lun, int rescan)
 {
 	struct Scsi_Host *shost = dev_to_shost(parent);
 
@@ -1384,7 +1375,7 @@ void scsi_scan_target(struct device *par
 EXPORT_SYMBOL(scsi_scan_target);
 
 static void scsi_scan_channel(struct Scsi_Host *shost, unsigned int channel,
-			      unsigned int id, unsigned int lun, int rescan)
+			      unsigned int id, u64 lun, int rescan)
 {
 	uint order_id;
 
@@ -1415,10 +1406,11 @@ static void scsi_scan_channel(struct Scs
 }
 
 int scsi_scan_host_selected(struct Scsi_Host *shost, unsigned int channel,
-			    unsigned int id, unsigned int lun, int rescan)
+			    unsigned int id, u64 lun, int rescan)
 {
-	SCSI_LOG_SCAN_BUS(3, printk (KERN_INFO "%s: <%u:%u:%u:%u>\n",
-		__FUNCTION__, shost->host_no, channel, id, lun));
+	SCSI_LOG_SCAN_BUS(3, printk (KERN_INFO "%s: <%u:%u:%u:%lld>\n",
+		__FUNCTION__, shost->host_no, channel, id,
+					 (unsigned long long)lun));
 
 	if (((channel != SCAN_WILD_CARD) && (channel > shost->max_channel)) ||
 	    ((id != SCAN_WILD_CARD) && (id > shost->max_id)) ||
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -858,16 +858,16 @@ void scsi_sysfs_device_initialize(struct
 	device_initialize(&sdev->sdev_gendev);
 	sdev->sdev_gendev.bus = &scsi_bus_type;
 	sdev->sdev_gendev.release = scsi_device_dev_release;
-	sprintf(sdev->sdev_gendev.bus_id,"%d:%d:%d:%d",
+	/* Fixme: Might want to make hierarchical LUNs prettier here */
+	sprintf(sdev->sdev_gendev.bus_id,"%d:%d:%d:%llu",
 		sdev->host->host_no, sdev->channel, sdev->id,
-		sdev->lun);
+		(unsigned long long)sdev->lun);
 	
 	class_device_initialize(&sdev->sdev_classdev);
 	sdev->sdev_classdev.dev = &sdev->sdev_gendev;
 	sdev->sdev_classdev.class = &sdev_class;
-	snprintf(sdev->sdev_classdev.class_id, BUS_ID_SIZE,
-		 "%d:%d:%d:%d", sdev->host->host_no,
-		 sdev->channel, sdev->id, sdev->lun);
+	strlcpy(sdev->sdev_classdev.class_id,
+		sdev->sdev_gendev.bus_id, BUS_ID_SIZE);
 	sdev->scsi_level = SCSI_2;
 	transport_setup_device(&sdev->sdev_gendev);
 	spin_lock_irqsave(shost->host_lock, flags);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1534,8 +1534,8 @@ static int sd_probe(struct device *dev)
 	if (sdp->type != TYPE_DISK && sdp->type != TYPE_MOD && sdp->type != TYPE_RBC)
 		goto out;
 
-	SCSI_LOG_HLQUEUE(3, printk("sd_attach: scsi device: <%d,%d,%d,%d>\n", 
-			 sdp->host->host_no, sdp->channel, sdp->id, sdp->lun));
+	SCSI_LOG_HLQUEUE(3, dev_printk(KERN_INFO, &sdp->sdev_gendev,
+				       "sd_attach\n"));
 
 	error = -ENOMEM;
 	sdkp = kmalloc(sizeof(*sdkp), GFP_KERNEL);
@@ -1607,10 +1607,8 @@ static int sd_probe(struct device *dev)
 	dev_set_drvdata(dev, sdkp);
 	add_disk(gd);
 
-	printk(KERN_NOTICE "Attached scsi %sdisk %s at scsi%d, channel %d, "
-	       "id %d, lun %d\n", sdp->removable ? "removable " : "",
-	       gd->disk_name, sdp->host->host_no, sdp->channel,
-	       sdp->id, sdp->lun);
+	dev_printk(KERN_NOTICE, &sdp->sdev_gendev, "Attached scsi %sdisk %s\n",
+		   sdp->removable ? "removable " : "", gd->disk_name);
 
 	return 0;
 
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1497,10 +1497,9 @@ static int sg_alloc(struct gendisk *disk
 
  overflow:
 	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-	printk(KERN_WARNING
-	       "Unable to attach sg device <%d, %d, %d, %d> type=%d, minor "
-	       "number exceeds %d\n", scsidp->host->host_no, scsidp->channel,
-	       scsidp->id, scsidp->lun, scsidp->type, SG_MAX_DEVS - 1);
+	dev_printk(KERN_WARNING, &scsidp->sdev_gendev,
+		   "Unable to attach sg device type=%d, minor "
+		   "number exceeds %d\n", scsidp->type, SG_MAX_DEVS - 1);
 	error = -ENODEV;
 	goto out;
 }
@@ -1566,11 +1565,8 @@ sg_add(struct class_device *cl_dev)
 	} else
 		printk(KERN_WARNING "sg_add: sg_sys INvalid\n");
 
-	printk(KERN_NOTICE
-	       "Attached scsi generic sg%d at scsi%d, channel"
-	       " %d, id %d, lun %d,  type %d\n", k,
-	       scsidp->host->host_no, scsidp->channel, scsidp->id,
-	       scsidp->lun, scsidp->type);
+	dev_printk(KERN_NOTICE, &scsidp->sdev_gendev,
+		   "Attached scsi generic sg%d type %d\n", k,scsidp->type);
 
 	return 0;
 
@@ -3009,9 +3005,10 @@ static int sg_proc_seq_show_dev(struct s
 
 	sdp = it ? sg_get_dev(it->index) : NULL;
 	if (sdp && (scsidp = sdp->device) && (!sdp->detached))
-		seq_printf(s, "%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n",
+		seq_printf(s, "%d\t%d\t%d\t%lld\t%d\t%d\t%d\t%d\t%d\n",
 			      scsidp->host->host_no, scsidp->channel,
-			      scsidp->id, scsidp->lun, (int) scsidp->type,
+			      scsidp->id, (unsigned long long)scsidp->lun,
+			      (int) scsidp->type,
 			      1,
 			      (int) scsidp->queue_depth,
 			      (int) scsidp->device_busy,
@@ -3134,10 +3131,10 @@ static int sg_proc_seq_show_debug(struct
 				seq_printf(s, "detached pending close ");
 			else
 				seq_printf
-				    (s, "scsi%d chan=%d id=%d lun=%d   em=%d",
+				    (s, "scsi%d chan=%d id=%d lun=%lld   em=%d",
 				     scsidp->host->host_no,
 				     scsidp->channel, scsidp->id,
-				     scsidp->lun,
+				     (unsigned long long)scsidp->lun,
 				     scsidp->host->hostt->emulated);
 			seq_printf(s, " sg_tablesize=%d excl=%d\n",
 				   sdp->sg_tablesize, sdp->exclude);
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -621,10 +621,8 @@ static int sr_probe(struct device *dev)
 	disk->flags |= GENHD_FL_REMOVABLE;
 	add_disk(disk);
 
-	printk(KERN_DEBUG
-	    "Attached scsi CD-ROM %s at scsi%d, channel %d, id %d, lun %d\n",
-	    cd->cdi.name, sdev->host->host_no, sdev->channel,
-	    sdev->id, sdev->lun);
+	dev_printk(KERN_DEBUG, &sdev->sdev_gendev,
+	    "Attached scsi CD-ROM %s\n", cd->cdi.name);
 	return 0;
 
 fail_put:
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3885,9 +3885,8 @@ static int st_probe(struct device *dev)
 	if (SDp->type != TYPE_TAPE)
 		return -ENODEV;
 	if ((stp = st_incompatible(SDp))) {
-		printk(KERN_INFO
-		       "st: Found incompatible tape at scsi%d, channel %d, id %d, lun %d\n",
-		       SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
+		dev_printk(KERN_INFO, &SDp->sdev_gendev,
+			   "Found incompatible tape\n");
 		printk(KERN_INFO "st: The suggested driver is %s.\n", stp);
 		return -ENODEV;
 	}
@@ -4075,9 +4074,8 @@ static int st_probe(struct device *dev)
 	}
 	disk->number = devfs_register_tape(SDp->devfs_name);
 
-	printk(KERN_WARNING
-	"Attached scsi tape %s at scsi%d, channel %d, id %d, lun %d\n",
-	       tape_name(tpnt), SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
+	dev_printk(KERN_WARNING, &SDp->sdev_gendev,
+		   "Attached scsi tape %s", tape_name(tpnt));
 	printk(KERN_WARNING "%s: try direct i/o: %s (alignment %d B), max page reachable by HBA %lu\n",
 	       tape_name(tpnt), tpnt->try_dio ? "yes" : "no",
 	       queue_dma_alignment(SDp->request_queue) + 1, tpnt->max_pfn);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -66,7 +66,8 @@ struct scsi_device {
 					   jiffie count on our counter, they
 					   could all be from the same event. */
 
-	unsigned int id, lun, channel;
+	unsigned int id, channel;
+	u64 lun;
 
 	unsigned int manufacturer;	/* Manufacturer of device, for using 
 					 * vendor-specific cmd's */
@@ -179,20 +180,20 @@ static inline struct scsi_target *scsi_t
 extern struct scsi_device *__scsi_add_device(struct Scsi_Host *,
 		uint, uint, uint, void *hostdata);
 extern int scsi_add_device(struct Scsi_Host *host, uint channel,
-			   uint target, uint lun);
+			   uint target, u64 lun);
 extern void scsi_remove_device(struct scsi_device *);
 extern int scsi_device_cancel(struct scsi_device *, int);
 
 extern int scsi_device_get(struct scsi_device *);
 extern void scsi_device_put(struct scsi_device *);
 extern struct scsi_device *scsi_device_lookup(struct Scsi_Host *,
-					      uint, uint, uint);
+					      uint, uint, u64);
 extern struct scsi_device *__scsi_device_lookup(struct Scsi_Host *,
-						uint, uint, uint);
+						uint, uint, u64);
 extern struct scsi_device *scsi_device_lookup_by_target(struct scsi_target *,
-							uint);
+							u64);
 extern struct scsi_device *__scsi_device_lookup_by_target(struct scsi_target *,
-							  uint);
+							  u64);
 extern void starget_for_each_device(struct scsi_target *, void *,
 		     void (*fn)(struct scsi_device *, void *));
 
@@ -248,12 +249,13 @@ extern void scsi_device_resume(struct sc
 extern void scsi_target_quiesce(struct scsi_target *);
 extern void scsi_target_resume(struct scsi_target *);
 extern void scsi_scan_target(struct device *parent, unsigned int channel,
-			     unsigned int id, unsigned int lun, int rescan);
+			     unsigned int id, u64 lun, int rescan);
 extern void scsi_target_reap(struct scsi_target *);
 extern void scsi_target_block(struct device *);
 extern void scsi_target_unblock(struct device *);
 extern void scsi_remove_target(struct device *);
-extern void int_to_scsilun(unsigned int, struct scsi_lun *);
+extern void int_to_scsilun(u64, struct scsi_lun *);
+extern u64 scsilun_to_int(struct scsi_lun *);
 extern const char *scsi_device_state_name(enum scsi_device_state);
 extern int scsi_is_sdev_device(const struct device *);
 extern int scsi_is_target_device(const struct device *);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -494,7 +494,10 @@ struct Scsi_Host {
 	 * or lun (i.e. 8 for normal systems).
 	 */
 	unsigned int max_id;
-	unsigned int max_lun;
+	#define SCSI_UNLIMITED_LUNS	(0xffffffffffffffffULL)
+	/* Any luns beyond 255 *require* report luns to find */
+	#define SCSI_SCAN_LIMIT_LUNS	256
+	u64 max_lun;
 	unsigned int max_channel;
 
 	/*


