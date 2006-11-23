Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757357AbWKWMqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357AbWKWMqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757363AbWKWMq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:46:28 -0500
Received: from server6.greatnet.de ([83.133.96.26]:18598 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1757357AbWKWMq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:46:26 -0500
Message-ID: <45659882.1060201@nachtwindheim.de>
Date: Thu, 23 Nov 2006 13:48:02 +0100
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH]: scsi: in2000 scsi_cmnd convertion
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the obsolete Scsi_Cmnd to struct scsi_cmnd and replace some whitespaces.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

 in2000.c |   99 +++++++++++++++++++++++++++++++--------------------------------
 in2000.h |   19 +++++++-----
 2 files changed, 62 insertions(+), 56 deletions(-)

diff --git a/drivers/scsi/in2000.c b/drivers/scsi/in2000.c
index 312190a..06bc89a 100644
--- a/drivers/scsi/in2000.c
+++ b/drivers/scsi/in2000.c
@@ -255,7 +255,7 @@ static unsigned long read_3393_count(str
  * will be a DATA_OUT phase with this command, false otherwise.
  * (Thanks to Joerg Dorchain for the research and suggestion.)
  */
-static int is_dir_out(Scsi_Cmnd * cmd)
+static int is_dir_out(struct scsi_cmnd * cmd)
 {
 	switch (cmd->cmnd[0]) {
 	case WRITE_6:
@@ -334,23 +334,24 @@ static uchar calc_sync_xfer(unsigned int
 
 static void in2000_execute(struct Scsi_Host *instance);
 
-static int in2000_queuecommand(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
+static int in2000_queuecommand(struct scsi_cmnd *cmd,
+		void (*done) (struct scsi_cmnd *))
 {
 	struct Scsi_Host *instance;
 	struct IN2000_hostdata *hostdata;
-	Scsi_Cmnd *tmp;
+	struct scsi_cmnd *tmp;
 
 	instance = cmd->device->host;
 	hostdata = (struct IN2000_hostdata *) instance->hostdata;
 
 	DB(DB_QUEUE_COMMAND, scmd_printk(KERN_DEBUG, cmd, "Q-%02x-%ld(", cmd->cmnd[0], cmd->pid))
 
-/* Set up a few fields in the Scsi_Cmnd structure for our own use:
+/* Set up a few fields in the scsi_cmnd structure for our own use:
  *  - host_scribble is the pointer to the next cmd in the input queue
  *  - scsi_done points to the routine we call when a cmd is finished
  *  - result is what you'd expect
  */
-	    cmd->host_scribble = NULL;
+	cmd->host_scribble = NULL;
 	cmd->scsi_done = done;
 	cmd->result = 0;
 
@@ -417,7 +418,7 @@ static int in2000_queuecommand(Scsi_Cmnd
 		cmd->host_scribble = (uchar *) hostdata->input_Q;
 		hostdata->input_Q = cmd;
 	} else {		/* find the end of the queue */
-		for (tmp = (Scsi_Cmnd *) hostdata->input_Q; tmp->host_scribble; tmp = (Scsi_Cmnd *) tmp->host_scribble);
+		for (tmp = (struct scsi_cmnd *) hostdata->input_Q; tmp->host_scribble; tmp = (struct scsi_cmnd *) tmp->host_scribble);
 		tmp->host_scribble = (uchar *) cmd;
 	}
 
@@ -444,7 +445,7 @@ static int in2000_queuecommand(Scsi_Cmnd
 static void in2000_execute(struct Scsi_Host *instance)
 {
 	struct IN2000_hostdata *hostdata;
-	Scsi_Cmnd *cmd, *prev;
+	struct scsi_cmnd *cmd, *prev;
 	int i;
 	unsigned short *sp;
 	unsigned short f;
@@ -467,13 +468,13 @@ static void in2000_execute(struct Scsi_H
 	 * for an idle target/lun.
 	 */
 
-	cmd = (Scsi_Cmnd *) hostdata->input_Q;
+	cmd = (struct scsi_cmnd *) hostdata->input_Q;
 	prev = NULL;
 	while (cmd) {
 		if (!(hostdata->busy[cmd->device->id] & (1 << cmd->device->lun)))
 			break;
 		prev = cmd;
-		cmd = (Scsi_Cmnd *) cmd->host_scribble;
+		cmd = (struct scsi_cmnd *) cmd->host_scribble;
 	}
 
 	/* quit if queue empty or all possible targets are busy */
@@ -490,7 +491,7 @@ static void in2000_execute(struct Scsi_H
 	if (prev)
 		prev->host_scribble = cmd->host_scribble;
 	else
-		hostdata->input_Q = (Scsi_Cmnd *) cmd->host_scribble;
+		hostdata->input_Q = (struct scsi_cmnd *) cmd->host_scribble;
 
 #ifdef PROC_STATISTICS
 	hostdata->cmd_cnt[cmd->device->id]++;
@@ -539,9 +540,9 @@ #endif
 		goto yes;
 	if (!(hostdata->input_Q))	/* input_Q empty? */
 		goto no;
-	for (prev = (Scsi_Cmnd *) hostdata->input_Q; prev; prev = (Scsi_Cmnd *) prev->host_scribble) {
+	for (prev = (struct scsi_cmnd *) hostdata->input_Q; prev; prev = (struct scsi_cmnd *) prev->host_scribble) {
 		if ((prev->device->id != cmd->device->id) || (prev->device->lun != cmd->device->lun)) {
-			for (prev = (Scsi_Cmnd *) hostdata->input_Q; prev; prev = (Scsi_Cmnd *) prev->host_scribble)
+			for (prev = (struct scsi_cmnd *) hostdata->input_Q; prev; prev = (struct scsi_cmnd *) prev->host_scribble)
 				prev->SCp.phase = 1;
 			goto yes;
 		}
@@ -743,7 +744,7 @@ static void transfer_pio(uchar * buf, in
 
 
 
-static void transfer_bytes(Scsi_Cmnd * cmd, int data_in_dir)
+static void transfer_bytes(struct scsi_cmnd * cmd, int data_in_dir)
 {
 	struct IN2000_hostdata *hostdata;
 	unsigned short *sp;
@@ -833,7 +834,7 @@ static irqreturn_t in2000_intr(int irqnu
 {
 	struct Scsi_Host *instance = dev_id;
 	struct IN2000_hostdata *hostdata;
-	Scsi_Cmnd *patch, *cmd;
+	struct scsi_cmnd *patch, *cmd;
 	uchar asr, sr, phs, id, lun, *ucp, msg;
 	int i, j;
 	unsigned long length;
@@ -909,7 +910,7 @@ #endif
  *    (Big thanks to Bill Earnest for getting me out of the mud in here.)
  */
 
-		cmd = (Scsi_Cmnd *) hostdata->connected;	/* assume we're connected */
+		cmd = (struct scsi_cmnd *) hostdata->connected;	/* assume we're connected */
 		CHECK_NULL(cmd, "fifo_int")
 
 		    if (hostdata->fifo == FI_FIFO_READING) {
@@ -991,7 +992,7 @@ #endif
  * detailed info from FIFO_READING and FIFO_WRITING (see below).
  */
 
-	cmd = (Scsi_Cmnd *) hostdata->connected;	/* assume we're connected */
+	cmd = (struct scsi_cmnd *) hostdata->connected;	/* assume we're connected */
 	sr = read_3393(hostdata, WD_SCSI_STATUS);	/* clear the interrupt */
 	phs = read_3393(hostdata, WD_COMMAND_PHASE);
 
@@ -1068,7 +1069,7 @@ #endif
 		    if (hostdata->state == S_RUNNING_LEVEL2)
 			hostdata->connected = NULL;
 		else {
-			cmd = (Scsi_Cmnd *) hostdata->selecting;	/* get a valid cmd */
+			cmd = (struct scsi_cmnd *) hostdata->selecting;	/* get a valid cmd */
 			CHECK_NULL(cmd, "csr_timeout")
 			    hostdata->selecting = NULL;
 		}
@@ -1090,7 +1091,7 @@ #endif
 
 	case CSR_SELECT:
 		DB(DB_INTR, printk("SELECT"))
-		    hostdata->connected = cmd = (Scsi_Cmnd *) hostdata->selecting;
+		    hostdata->connected = cmd = (struct scsi_cmnd *) hostdata->selecting;
 		CHECK_NULL(cmd, "csr_select")
 		    hostdata->selecting = NULL;
 
@@ -1491,7 +1492,7 @@ #endif
 		    if (hostdata->level2 <= L2_NONE) {
 
 			if (hostdata->selecting) {
-				cmd = (Scsi_Cmnd *) hostdata->selecting;
+				cmd = (struct scsi_cmnd *) hostdata->selecting;
 				hostdata->selecting = NULL;
 				hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 				cmd->host_scribble = (uchar *) hostdata->input_Q;
@@ -1532,13 +1533,13 @@ #endif
 
 		/* Now we look for the command that's reconnecting. */
 
-		cmd = (Scsi_Cmnd *) hostdata->disconnected_Q;
+		cmd = (struct scsi_cmnd *) hostdata->disconnected_Q;
 		patch = NULL;
 		while (cmd) {
 			if (id == cmd->device->id && lun == cmd->device->lun)
 				break;
 			patch = cmd;
-			cmd = (Scsi_Cmnd *) cmd->host_scribble;
+			cmd = (struct scsi_cmnd *) cmd->host_scribble;
 		}
 
 		/* Hmm. Couldn't find a valid command.... What to do? */
@@ -1553,7 +1554,7 @@ #endif
 		if (patch)
 			patch->host_scribble = cmd->host_scribble;
 		else
-			hostdata->disconnected_Q = (Scsi_Cmnd *) cmd->host_scribble;
+			hostdata->disconnected_Q = (struct scsi_cmnd *) cmd->host_scribble;
 		hostdata->connected = cmd;
 
 		/* We don't need to worry about 'initialize_SCp()' or 'hostdata->busy[]'
@@ -1639,7 +1640,7 @@ static int reset_hardware(struct Scsi_Ho
 
 
 
-static int in2000_bus_reset(Scsi_Cmnd * cmd)
+static int in2000_bus_reset(struct scsi_cmnd *cmd)
 {
 	struct Scsi_Host *instance;
 	struct IN2000_hostdata *hostdata;
@@ -1675,11 +1676,11 @@ static int in2000_bus_reset(Scsi_Cmnd * 
 	return SUCCESS;
 }
 
-static int __in2000_abort(Scsi_Cmnd * cmd)
+static int __in2000_abort(struct scsi_cmnd * cmd)
 {
 	struct Scsi_Host *instance;
 	struct IN2000_hostdata *hostdata;
-	Scsi_Cmnd *tmp, *prev;
+	struct scsi_cmnd *tmp, *prev;
 	uchar sr, asr;
 	unsigned long timeout;
 
@@ -1694,7 +1695,7 @@ static int __in2000_abort(Scsi_Cmnd * cm
  *     from the inout_Q.
  */
 
-	tmp = (Scsi_Cmnd *) hostdata->input_Q;
+	tmp = (struct scsi_cmnd *) hostdata->input_Q;
 	prev = NULL;
 	while (tmp) {
 		if (tmp == cmd) {
@@ -1707,7 +1708,7 @@ static int __in2000_abort(Scsi_Cmnd * cm
 			return SUCCESS;
 		}
 		prev = tmp;
-		tmp = (Scsi_Cmnd *) tmp->host_scribble;
+		tmp = (struct scsi_cmnd *) tmp->host_scribble;
 	}
 
 /*
@@ -1774,7 +1775,7 @@ static int __in2000_abort(Scsi_Cmnd * cm
  * an ABORT_SNOOZE and hope for the best...
  */
 
-	for (tmp = (Scsi_Cmnd *) hostdata->disconnected_Q; tmp; tmp = (Scsi_Cmnd *) tmp->host_scribble)
+	for (tmp = (struct scsi_cmnd *) hostdata->disconnected_Q; tmp; tmp = (struct scsi_cmnd *) tmp->host_scribble)
 		if (cmd == tmp) {
 			printk(KERN_DEBUG "scsi%d: unable to abort disconnected command.\n", instance->host_no);
 			return FAILED;
@@ -1796,7 +1797,7 @@ static int __in2000_abort(Scsi_Cmnd * cm
 	return SUCCESS;
 }
 
-static int in2000_abort(Scsi_Cmnd * cmd)
+static int in2000_abort(struct scsi_cmnd *cmd)
 {
 	int rc;
 
@@ -2175,7 +2176,7 @@ #ifdef PROC_INTERFACE
 	char tbuf[128];
 	unsigned long flags;
 	struct IN2000_hostdata *hd;
-	Scsi_Cmnd *cmd;
+	struct scsi_cmnd *cmd;
 	int x, i;
 	static int stop = 0;
 
@@ -2267,27 +2268,27 @@ #endif
 	if (hd->proc & PR_CONNECTED) {
 		strcat(bp, "\nconnected:     ");
 		if (hd->connected) {
-			cmd = (Scsi_Cmnd *) hd->connected;
+			cmd = (struct scsi_cmnd *) hd->connected;
 			sprintf(tbuf, " %ld-%d:%d(%02x)", cmd->pid, cmd->device->id, cmd->device->lun, cmd->cmnd[0]);
 			strcat(bp, tbuf);
 		}
 	}
 	if (hd->proc & PR_INPUTQ) {
 		strcat(bp, "\ninput_Q:       ");
-		cmd = (Scsi_Cmnd *) hd->input_Q;
+		cmd = (struct scsi_cmnd *) hd->input_Q;
 		while (cmd) {
 			sprintf(tbuf, " %ld-%d:%d(%02x)", cmd->pid, cmd->device->id, cmd->device->lun, cmd->cmnd[0]);
 			strcat(bp, tbuf);
-			cmd = (Scsi_Cmnd *) cmd->host_scribble;
+			cmd = (struct scsi_cmnd *) cmd->host_scribble;
 		}
 	}
 	if (hd->proc & PR_DISCQ) {
 		strcat(bp, "\ndisconnected_Q:");
-		cmd = (Scsi_Cmnd *) hd->disconnected_Q;
+		cmd = (struct scsi_cmnd *) hd->disconnected_Q;
 		while (cmd) {
 			sprintf(tbuf, " %ld-%d:%d(%02x)", cmd->pid, cmd->device->id, cmd->device->lun, cmd->cmnd[0]);
 			strcat(bp, tbuf);
-			cmd = (Scsi_Cmnd *) cmd->host_scribble;
+			cmd = (struct scsi_cmnd *) cmd->host_scribble;
 		}
 	}
 	if (hd->proc & PR_TEST) {
@@ -2318,19 +2319,19 @@ MODULE_LICENSE("GPL");
 
 
 static struct scsi_host_template driver_template = {
-	.proc_name       		= "in2000",
-	.proc_info       		= in2000_proc_info,
-	.name            		= "Always IN2000",
-	.detect          		= in2000_detect, 
-	.release			= in2000_release,
-	.queuecommand    		= in2000_queuecommand,
-	.eh_abort_handler		= in2000_abort,
-	.eh_bus_reset_handler		= in2000_bus_reset,
-	.bios_param      		= in2000_biosparam, 
-	.can_queue       		= IN2000_CAN_Q,
-	.this_id         		= IN2000_HOST_ID,
-	.sg_tablesize    		= IN2000_SG,
-	.cmd_per_lun     		= IN2000_CPL,
-	.use_clustering  		= DISABLE_CLUSTERING,
+	.proc_name		= "in2000",
+	.proc_info		= in2000_proc_info,
+	.name			= "Always IN2000",
+	.detect			= in2000_detect,
+	.release		= in2000_release,
+	.queuecommand		= in2000_queuecommand,
+	.eh_abort_handler	= in2000_abort,
+	.eh_bus_reset_handler	= in2000_bus_reset,
+	.bios_param		= in2000_biosparam,
+	.can_queue		= IN2000_CAN_Q,
+	.this_id		= IN2000_HOST_ID,
+	.sg_tablesize		= IN2000_SG,
+	.cmd_per_lun		= IN2000_CPL,
+	.use_clustering		= DISABLE_CLUSTERING,
 };
 #include "scsi_module.c"
diff --git a/drivers/scsi/in2000.h b/drivers/scsi/in2000.h
index 0fb8b06..480ae2a 100644
--- a/drivers/scsi/in2000.h
+++ b/drivers/scsi/in2000.h
@@ -283,10 +283,14 @@ struct IN2000_hostdata {
     unsigned int     dip_switch;       /* dip switch settings */
     unsigned int     hrev;             /* hardware revision of card */
     volatile uchar   busy[8];          /* index = target, bit = lun */
-    volatile Scsi_Cmnd *input_Q;       /* commands waiting to be started */
-    volatile Scsi_Cmnd *selecting;     /* trying to select this command */
-    volatile Scsi_Cmnd *connected;     /* currently connected command */
-    volatile Scsi_Cmnd *disconnected_Q;/* commands waiting for reconnect */
+	volatile struct scsi_cmnd *input_Q;
+					/* commands waiting to be started */
+	volatile struct scsi_cmnd *selecting;
+					/* trying to select this command */
+	volatile struct scsi_cmnd *connected;
+					/* currently connected command */
+	volatile struct scsi_cmnd *disconnected_Q;
+					/* commands waiting for reconnect*/
     uchar            state;            /* what we are currently doing */
     uchar            fifo;             /* what the FIFO is up to */
     uchar            level2;           /* extent to which Level-2 commands are used */
@@ -396,12 +400,13 @@ # define CLISPIN_UNLOCK(host,flags) spin
 							   flags)
 
 static int in2000_detect(struct scsi_host_template *) in2000__INIT;
-static int in2000_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-static int in2000_abort(Scsi_Cmnd *);
+static int in2000_queuecommand(struct scsi_cmnd *,
+		void (*done)(struct scsi_cmnd *));
+static int in2000_abort(struct scsi_cmnd *);
 static void in2000_setup(char *, int *) in2000__INIT;
 static int in2000_biosparam(struct scsi_device *, struct block_device *,
 		sector_t, int *);
-static int in2000_bus_reset(Scsi_Cmnd *);
+static int in2000_bus_reset(struct scsi_cmnd *);
 
 
 #define IN2000_CAN_Q    16


