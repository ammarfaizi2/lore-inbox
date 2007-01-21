Return-Path: <linux-kernel-owner+w=401wt.eu-S1751784AbXAUX3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbXAUX3N (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 18:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbXAUX3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 18:29:13 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:47436 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751784AbXAUX3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 18:29:12 -0500
Message-ID: <45B3F707.6090808@panasas.com>
Date: Mon, 22 Jan 2007 01:28:07 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       open-iscsi@googlegroups.com, Daniel.E.Messinger@seagate.com,
       Liran Schour <LIRANS@il.ibm.com>, Benny Halevy <bhalevy@panasas.com>
Subject: [RFC 5/6] bidi support: varlen + OSD support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2007 23:27:45.0478 (UTC) FILETIME=[C14C1E60:01C73DB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Add support for varlen CDBs or large vendor specific commands in
  struct request.
- Add support for above at SCSI level API's and devices.
- Add the OSD device type.

Signed-off-by: Benny Halevy <bhalevy@panasas.com>
Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>

---
 block/ll_rw_blk.c         |    2 ++
 drivers/scsi/scsi.c       |   11 ++++++++---
 drivers/scsi/scsi_debug.c |    6 +++++-
 drivers/scsi/scsi_lib.c   |   24 +++++++++++++++++++++---
 drivers/scsi/scsi_scan.c  |    1 +
 include/linux/blkdev.h    |    6 ++++++
 include/scsi/scsi.h       |    2 ++
 include/scsi/scsi_cmnd.h  |   20 +++++++++++++++++++-
 include/scsi/scsi_host.h  |    8 +++-----
 9 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 1358b35..04bc43e 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -256,6 +256,8 @@ static void rq_init(request_queue_t *q,
 	rq->q = q;
 	rq->special = NULL;
 	rq->data = NULL;
+	rq->varlen_cdb_len = 0;
+	rq->varlen_cdb = NULL;
 	rq->sense = NULL;
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 24cffd9..f835496 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -485,6 +485,7 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 	unsigned long flags = 0;
 	unsigned long timeout;
 	int rtn = 0;
+	int cdb_size;

 	/* check if the device is still usable */
 	if (unlikely(cmd->device->sdev_state == SDEV_DEL)) {
@@ -566,9 +567,13 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 	 * Before we queue this command, check if the command
 	 * length exceeds what the host adapter can handle.
 	 */
-	if (CDB_SIZE(cmd) > cmd->device->host->max_cmd_len) {
-		SCSI_LOG_MLQUEUE(3,
-				printk("queuecommand : command too long.\n"));
+	cdb_size = cmd->request->varlen_cdb ?
+		cmd->request->varlen_cdb_len : COMMAND_SIZE(cmd->cmnd[0]);
+	if (cdb_size > cmd->device->host->max_cmd_len) {
+		SCSI_LOG_MLQUEUE(0,
+			printk("queuecommand : command too long. "
+			       "cdb_size(%d) host->max_cmd_len(%d)\n",
+			       cdb_size, cmd->device->host->max_cmd_len));
 		cmd->result = (DID_ABORT << 16);

 		scsi_done(cmd);
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 30ee3d7..8520873 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1993,8 +1993,12 @@ static int scsi_debug_slave_configure(st
 	if (SCSI_DEBUG_OPT_NOISE & scsi_debug_opts)
 		printk(KERN_INFO "scsi_debug: slave_configure <%u %u %u %u>\n",
 		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
-	if (sdp->host->max_cmd_len != SCSI_DEBUG_MAX_CMD_LEN)
+	if (sdp->host->max_cmd_len < SCSI_DEBUG_MAX_CMD_LEN) {
+		printk(KERN_INFO
+		       "scsi_debug: max_cmd_len(%d) < SCSI_DEBUG_MAX_CMD_LEN\n",
+		       sdp->host->max_cmd_len);
 		sdp->host->max_cmd_len = SCSI_DEBUG_MAX_CMD_LEN;
+	}
 	devip = devInfoReg(sdp);
 	sdp->hostdata = devip;
 	if (sdp->host->cmd_per_lun)
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 92d3d44..d672ade 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -189,8 +189,17 @@ int scsi_execute(struct scsi_device *sde
 					buffer, bufflen, __GFP_WAIT))
 		goto out;

-	req->cmd_len = COMMAND_SIZE(cmd[0]);
+	if (cmd[0] == VARLEN_CDB) {
+		req->varlen_cdb_len = scsi_varlen_cdb_length(cmd);
+		req->varlen_cdb = (unsigned char *)cmd; /* varlen cmd is pointed to */
+	}
+	req->cmd_len = min(
+		req->varlen_cdb_len ? req->varlen_cdb_len : COMMAND_SIZE(cmd[0]),
+		MAX_COMMAND_SIZE);
 	memcpy(req->cmd, cmd, req->cmd_len);
+	if (req->cmd_len < MAX_COMMAND_SIZE)
+		memset(&req->cmd[req->cmd_len], 0, MAX_COMMAND_SIZE-req->cmd_len);
+
 	req->sense = sense;
 	req->sense_len = 0;
 	req->retries = retries;
@@ -452,8 +461,6 @@ int scsi_execute_bidi_async(struct scsi_
 	if (err)
 		goto free_req;

-	req->cmd_len = cmd_len;
-	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	if (is_bidi) {
 		if (bidi_read_buff->use_sg)
 			err = scsi_req_map_sg(
@@ -469,7 +476,18 @@ int scsi_execute_bidi_async(struct scsi_
 		}
 	}

+	BUG_ON( (cmd[0]==VARLEN_CDB) && (scsi_varlen_cdb_length(cmd) > cmd_len) );
+	/* Unlike scsi_excute, scsi_execute_bidi_xxx supports big commands that are not VARLEN_CDB */
+	if ((cmd[0] == VARLEN_CDB) || (cmd_len > MAX_COMMAND_SIZE)) {
+		req->varlen_cdb_len = cmd_len;
+		req->varlen_cdb = cmd;
+	}
+	req->cmd_len = min( cmd_len ? cmd_len : COMMAND_SIZE(cmd[0]),
+		MAX_COMMAND_SIZE);
 	memcpy(req->cmd, cmd, req->cmd_len);
+	if(req->cmd_len < MAX_COMMAND_SIZE)
+		memset(&req->cmd[req->cmd_len], 0, MAX_COMMAND_SIZE-req->cmd_len);
+
 	req->sense = sioc->sense;
 	req->sense_len = 0;
 	req->timeout = timeout;
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 14e635a..2aad10c 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -750,6 +750,7 @@ static int scsi_add_lun(struct scsi_devi
 	case TYPE_COMM:
 	case TYPE_RAID:
 	case TYPE_RBC:
+	case TYPE_OSD:
 		sdev->writeable = 1;
 		break;
 	case TYPE_WORM:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eff3960..d805ae4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -294,6 +294,7 @@ struct request {
 	unsigned long start_time;

 	unsigned short ioprio;
+	unsigned short varlen_cdb_len; /* length of varlen_cdb buffer */

 	void *special;
 	char *buffer;			/* FIXME: should be Deprecated */
@@ -309,6 +310,11 @@ struct request {
 	 */
 	unsigned int cmd_len;
 	unsigned char cmd[BLK_MAX_CDB];
+	unsigned char *varlen_cdb;      /* an optional variable-length cdb.
+	                                 * first 16 bytes are copied also into cmd[].
+					 * points to a user buffer that must be valid
+					 * until end of request
+					 */

 	unsigned int sense_len;
 	void *sense;
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 5c0e979..49eec7c 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -96,6 +96,7 @@ #define RELEASE_10            0x57
 #define MODE_SENSE_10         0x5a
 #define PERSISTENT_RESERVE_IN 0x5e
 #define PERSISTENT_RESERVE_OUT 0x5f
+#define VARLEN_CDB            0x7f
 #define REPORT_LUNS           0xa0
 #define MAINTENANCE_IN        0xa3
 #define MOVE_MEDIUM           0xa5
@@ -219,6 +220,7 @@ #define TYPE_COMM           0x09    /* C
 #define TYPE_RAID           0x0c
 #define TYPE_ENCLOSURE      0x0d    /* Enclosure Services Device */
 #define TYPE_RBC	    0x0e
+#define TYPE_OSD            0x11
 #define TYPE_NO_LUN         0x7f

 /* Returns a human-readable name for the device */
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 78ae417..ae17fff 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -11,6 +11,24 @@ struct scatterlist;
 struct Scsi_Host;
 struct scsi_device;

+#define SCSI_MAX_VARLEN_CDB_LEN 260
+
+/* defined in T10 SCSI Primary Commands-3 */
+struct scsi_varlen_cdb_hdr {
+	unsigned char opcode;                 /* opcode always == VARLEN_CDB */
+	unsigned char control;
+	unsigned char misc[5];
+	unsigned char additional_cdb_length;  /* total cdb length - 8 */
+	unsigned char service_action[2];
+	/* service specific data follows */
+};
+
+static inline int
+scsi_varlen_cdb_length(const void *hdr)
+{
+	return ((struct scsi_varlen_cdb_hdr*)hdr)->additional_cdb_length + 8;
+}
+
 /*
  * This structure maps data buffers into a scatter-gather list for DMA purposes.
  * Embedded in struct scsi_cmnd.
@@ -76,7 +94,7 @@ struct scsi_cmnd {
 	int allowed;
 	int timeout_per_command;

-	unsigned char cmd_len;
+	unsigned char cmd_len;         /* fixed cdb command length (<= 16) */
 	enum dma_data_direction sc_data_direction;

 	/* These elements define the operation we are about to perform */
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 7f1f411..9b77d6c 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -559,13 +559,11 @@ struct Scsi_Host {
 	/*
 	 * The maximum length of SCSI commands that this host can accept.
 	 * Probably 12 for most host adapters, but could be 16 for others.
+	 * or 260 if the driver supports variable length cdbs.
 	 * For drivers that don't set this field, a value of 12 is
-	 * assumed.  I am leaving this as a number rather than a bit
-	 * because you never know what subsequent SCSI standards might do
-	 * (i.e. could there be a 20 byte or a 24-byte command a few years
-	 * down the road?).
+	 * assumed.
 	 */
-	unsigned char max_cmd_len;
+	unsigned short max_cmd_len;

 	int this_id;
 	int can_queue;
-- 
