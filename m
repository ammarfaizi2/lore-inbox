Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWJALTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWJALTr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbWJALTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:19:47 -0400
Received: from server6.greatnet.de ([83.133.96.26]:5538 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751688AbWJALTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:19:45 -0400
Message-ID: <451FA40D.9030403@nachtwindheim.de>
Date: Sun, 01 Oct 2006 13:18:37 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Scsi_Cmnd convertion in arm subtree
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the obsolete Scsi_Cmnd to struct scsi_cmnd in the arm subdir
of the scsi-subsys.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

 acornscsi.c |   48 +++++++++++++++++++++++++-----------------------
 acornscsi.h |    4 ++--
 fas216.c    |   50 +++++++++++++++++++++++++++-----------------------
 fas216.h    |   36 +++++++++++++++++++-----------------
 queue.c     |   37 +++++++++++++++++++------------------
 queue.h     |   28 +++++++++++++++-------------
 scsi.h      |    2 +-
 7 files changed, 108 insertions(+), 97 deletions(-)

diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index 7621e3f..0525d67 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -194,7 +194,8 @@ #define STATUS_BUFFER_TO_PRINT	24
 unsigned int sdtr_period = SDTR_PERIOD;
 unsigned int sdtr_size   = SDTR_SIZE;
 
-static void acornscsi_done(AS_Host *host, Scsi_Cmnd **SCpntp, unsigned int result);
+static void acornscsi_done(AS_Host *host, struct scsi_cmnd **SCpntp,
+			   unsigned int result);
 static int acornscsi_reconnect_finish(AS_Host *host);
 static void acornscsi_dma_cleanup(AS_Host *host);
 static void acornscsi_abortcmd(AS_Host *host, unsigned char tag);
@@ -712,7 +713,7 @@ static
 intr_ret_t acornscsi_kick(AS_Host *host)
 {
     int from_queue = 0;
-    Scsi_Cmnd *SCpnt;
+    struct scsi_cmnd *SCpnt;
 
     /* first check to see if a command is waiting to be executed */
     SCpnt = host->origSCpnt;
@@ -796,15 +797,15 @@ #endif
 }    
 
 /*
- * Function: void acornscsi_done(AS_Host *host, Scsi_Cmnd **SCpntp, unsigned int result)
+ * Function: void acornscsi_done(AS_Host *host, struct scsi_cmnd **SCpntp, unsigned int result)
  * Purpose : complete processing for command
  * Params  : host   - interface that completed
  *	     result - driver byte of result
  */
-static
-void acornscsi_done(AS_Host *host, Scsi_Cmnd **SCpntp, unsigned int result)
+static void acornscsi_done(AS_Host *host, struct scsi_cmnd **SCpntp,
+			   unsigned int result)
 {
-    Scsi_Cmnd *SCpnt = *SCpntp;
+	struct scsi_cmnd *SCpnt = *SCpntp;
 
     /* clean up */
     sbic_arm_write(host->scsi.io_port, SBIC_SOURCEID, SOURCEID_ER | SOURCEID_DSP);
@@ -1318,7 +1319,7 @@ acornscsi_write_pio(AS_Host *host, char 
 static void
 acornscsi_sendcommand(AS_Host *host)
 {
-    Scsi_Cmnd *SCpnt = host->SCpnt;
+	struct scsi_cmnd *SCpnt = host->SCpnt;
 
     sbic_arm_write(host->scsi.io_port, SBIC_TRANSCNTH, 0);
     sbic_arm_writenext(host->scsi.io_port, 0);
@@ -1693,7 +1694,7 @@ #endif
 		acornscsi_sbic_issuecmd(host, CMND_ASSERTATN);
 		msgqueue_addmsg(&host->scsi.msgs, 1, ABORT);
 	    } else {
-		Scsi_Cmnd *SCpnt = host->SCpnt;
+		struct scsi_cmnd *SCpnt = host->SCpnt;
 
 		acornscsi_dma_cleanup(host);
 
@@ -2509,13 +2510,14 @@ acornscsi_intr(int irq, void *dev_id, st
  */
 
 /*
- * Function : acornscsi_queuecmd(Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
+ * Function : acornscsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
  * Purpose  : queues a SCSI command
  * Params   : cmd  - SCSI command
  *	      done - function called on completion, with pointer to command descriptor
  * Returns  : 0, or < 0 on error.
  */
-int acornscsi_queuecmd(Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
+int acornscsi_queuecmd(struct scsi_cmnd *SCpnt,
+		       void (*done)(struct scsi_cmnd *))
 {
     AS_Host *host = (AS_Host *)SCpnt->device->host->hostdata;
 
@@ -2565,17 +2567,18 @@ #endif
 }
 
 /*
- * Prototype: void acornscsi_reportstatus(Scsi_Cmnd **SCpntp1, Scsi_Cmnd **SCpntp2, int result)
+ * Prototype: void acornscsi_reportstatus(struct scsi_cmnd **SCpntp1, struct scsi_cmnd **SCpntp2, int result)
  * Purpose  : pass a result to *SCpntp1, and check if *SCpntp1 = *SCpntp2
  * Params   : SCpntp1 - pointer to command to return
  *	      SCpntp2 - pointer to command to check
  *	      result  - result to pass back to mid-level done function
  * Returns  : *SCpntp2 = NULL if *SCpntp1 is the same command structure as *SCpntp2.
  */
-static inline
-void acornscsi_reportstatus(Scsi_Cmnd **SCpntp1, Scsi_Cmnd **SCpntp2, int result)
+static inline void acornscsi_reportstatus(struct scsi_cmnd **SCpntp1,
+					  struct scsi_cmnd **SCpntp2,
+					  int result)
 {
-    Scsi_Cmnd *SCpnt = *SCpntp1;
+	struct scsi_cmnd *SCpnt = *SCpntp1;
 
     if (SCpnt) {
 	*SCpntp1 = NULL;
@@ -2591,13 +2594,12 @@ void acornscsi_reportstatus(Scsi_Cmnd **
 enum res_abort { res_not_running, res_success, res_success_clear, res_snooze };
 
 /*
- * Prototype: enum res acornscsi_do_abort(Scsi_Cmnd *SCpnt)
+ * Prototype: enum res acornscsi_do_abort(struct scsi_cmnd *SCpnt)
  * Purpose  : abort a command on this host
  * Params   : SCpnt - command to abort
  * Returns  : our abort status
  */
-static enum res_abort
-acornscsi_do_abort(AS_Host *host, Scsi_Cmnd *SCpnt)
+static enum res_abort acornscsi_do_abort(AS_Host *host, struct scsi_cmnd *SCpnt)
 {
 	enum res_abort res = res_not_running;
 
@@ -2684,12 +2686,12 @@ acornscsi_do_abort(AS_Host *host, Scsi_C
 }
 
 /*
- * Prototype: int acornscsi_abort(Scsi_Cmnd *SCpnt)
+ * Prototype: int acornscsi_abort(struct scsi_cmnd *SCpnt)
  * Purpose  : abort a command on this host
  * Params   : SCpnt - command to abort
  * Returns  : one of SCSI_ABORT_ macros
  */
-int acornscsi_abort(Scsi_Cmnd *SCpnt)
+int acornscsi_abort(struct scsi_cmnd *SCpnt)
 {
 	AS_Host *host = (AS_Host *) SCpnt->device->host->hostdata;
 	int result;
@@ -2770,16 +2772,16 @@ #endif
 }
 
 /*
- * Prototype: int acornscsi_reset(Scsi_Cmnd *SCpnt, unsigned int reset_flags)
+ * Prototype: int acornscsi_reset(struct scsi_cmnd *SCpnt, unsigned int reset_flags)
  * Purpose  : reset a command on this host/reset this host
  * Params   : SCpnt  - command causing reset
  *	      result - what type of reset to perform
  * Returns  : one of SCSI_RESET_ macros
  */
-int acornscsi_reset(Scsi_Cmnd *SCpnt, unsigned int reset_flags)
+int acornscsi_reset(struct scsi_cmnd *SCpnt, unsigned int reset_flags)
 {
-    AS_Host *host = (AS_Host *)SCpnt->device->host->hostdata;
-    Scsi_Cmnd *SCptr;
+	AS_Host *host = (AS_Host *)SCpnt->device->host->hostdata;
+	struct scsi_cmnd *SCptr;
     
     host->stats.resets += 1;
 
diff --git a/drivers/scsi/arm/acornscsi.h b/drivers/scsi/arm/acornscsi.h
index 2142290..d11424b 100644
--- a/drivers/scsi/arm/acornscsi.h
+++ b/drivers/scsi/arm/acornscsi.h
@@ -277,8 +277,8 @@ ({									\
 typedef struct acornscsi_hostdata {
     /* miscellaneous */
     struct Scsi_Host	*host;			/* host					*/
-    Scsi_Cmnd		*SCpnt;			/* currently processing command		*/
-    Scsi_Cmnd		*origSCpnt;		/* original connecting command		*/
+    struct scsi_cmnd	*SCpnt;			/* currently processing command		*/
+    struct scsi_cmnd	*origSCpnt;		/* original connecting command		*/
 
     /* driver information */
     struct {
diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 4cf7afc..e05f0c2 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -297,8 +297,8 @@ fas216_do_log(FAS216_Info *info, char ta
 	printk("scsi%d.%c: %s", info->host->host_no, target, buf);
 }
 
-static void
-fas216_log_command(FAS216_Info *info, int level, Scsi_Cmnd *SCpnt, char *fmt, ...)
+static void fas216_log_command(FAS216_Info *info, int level,
+			       struct scsi_cmnd *SCpnt, char *fmt, ...)
 {
 	va_list args;
 
@@ -1662,7 +1662,7 @@ irqreturn_t fas216_intr(FAS216_Info *inf
 	return handled;
 }
 
-static void __fas216_start_command(FAS216_Info *info, Scsi_Cmnd *SCpnt)
+static void __fas216_start_command(FAS216_Info *info, struct scsi_cmnd *SCpnt)
 {
 	int tot_msglen;
 
@@ -1754,7 +1754,7 @@ #endif
 	return info->device[target].parity_check;
 }
 
-static void fas216_start_command(FAS216_Info *info, Scsi_Cmnd *SCpnt)
+static void fas216_start_command(FAS216_Info *info, struct scsi_cmnd *SCpnt)
 {
 	int disconnect_ok;
 
@@ -1808,7 +1808,7 @@ #endif
 	__fas216_start_command(info, SCpnt);
 }
 
-static void fas216_allocate_tag(FAS216_Info *info, Scsi_Cmnd *SCpnt)
+static void fas216_allocate_tag(FAS216_Info *info, struct scsi_cmnd *SCpnt)
 {
 #ifdef SCSI2_TAG
 	/*
@@ -1842,7 +1842,8 @@ #endif
 	}
 }
 
-static void fas216_do_bus_device_reset(FAS216_Info *info, Scsi_Cmnd *SCpnt)
+static void fas216_do_bus_device_reset(FAS216_Info *info,
+				       struct scsi_cmnd *SCpnt)
 {
 	struct message *msg;
 
@@ -1890,7 +1891,7 @@ static void fas216_do_bus_device_reset(F
  */
 static void fas216_kick(FAS216_Info *info)
 {
-	Scsi_Cmnd *SCpnt = NULL;
+	struct scsi_cmnd *SCpnt = NULL;
 #define TYPE_OTHER	0
 #define TYPE_RESET	1
 #define TYPE_QUEUE	2
@@ -1978,8 +1979,8 @@ #define TYPE_QUEUE	2
 /*
  * Clean up from issuing a BUS DEVICE RESET message to a device.
  */
-static void
-fas216_devicereset_done(FAS216_Info *info, Scsi_Cmnd *SCpnt, unsigned int result)
+static void fas216_devicereset_done(FAS216_Info *info, struct scsi_cmnd *SCpnt,
+				    unsigned int result)
 {
 	fas216_log(info, LOG_ERROR, "fas216 device reset complete");
 
@@ -1996,8 +1997,8 @@ fas216_devicereset_done(FAS216_Info *inf
  *
  * Finish processing automatic request sense command
  */
-static void
-fas216_rq_sns_done(FAS216_Info *info, Scsi_Cmnd *SCpnt, unsigned int result)
+static void fas216_rq_sns_done(FAS216_Info *info, struct scsi_cmnd *SCpnt,
+			       unsigned int result)
 {
 	fas216_log_target(info, LOG_CONNECT, SCpnt->device->id,
 		   "request sense complete, result=0x%04x%02x%02x",
@@ -2030,7 +2031,7 @@ fas216_rq_sns_done(FAS216_Info *info, Sc
  * Finish processing of standard command
  */
 static void
-fas216_std_done(FAS216_Info *info, Scsi_Cmnd *SCpnt, unsigned int result)
+fas216_std_done(FAS216_Info *info, struct scsi_cmnd *SCpnt, unsigned int result)
 {
 	info->stats.fins += 1;
 
@@ -2142,8 +2143,8 @@ request_sense:
  */
 static void fas216_done(FAS216_Info *info, unsigned int result)
 {
-	void (*fn)(FAS216_Info *, Scsi_Cmnd *, unsigned int);
-	Scsi_Cmnd *SCpnt;
+	void (*fn)(FAS216_Info *, struct scsi_cmnd *, unsigned int);
+	struct scsi_cmnd *SCpnt;
 	unsigned long flags;
 
 	fas216_checkmagic(info);
@@ -2182,7 +2183,7 @@ static void fas216_done(FAS216_Info *inf
 	info->device[SCpnt->device->id].parity_check = 0;
 	clear_bit(SCpnt->device->id * 8 + SCpnt->device->lun, info->busyluns);
 
-	fn = (void (*)(FAS216_Info *, Scsi_Cmnd *, unsigned int))SCpnt->host_scribble;
+	fn = (void (*)(FAS216_Info *, struct scsi_cmnd *, unsigned int))SCpnt->host_scribble;
 	fn(info, SCpnt, result);
 
 	if (info->scsi.irq != NO_IRQ) {
@@ -2207,7 +2208,8 @@ no_command:
  * Returns: 0 on success, else error.
  * Notes: io_request_lock is held, interrupts are disabled.
  */
-int fas216_queue_command(Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
+int fas216_queue_command(struct scsi_cmnd *SCpnt,
+			 void (*done)(struct scsi_cmnd *))
 {
 	FAS216_Info *info = (FAS216_Info *)SCpnt->device->host->hostdata;
 	int result;
@@ -2254,7 +2256,7 @@ int fas216_queue_command(Scsi_Cmnd *SCpn
  *
  * Trigger restart of a waiting thread in fas216_command
  */
-static void fas216_internal_done(Scsi_Cmnd *SCpnt)
+static void fas216_internal_done(struct scsi_cmnd *SCpnt)
 {
 	FAS216_Info *info = (FAS216_Info *)SCpnt->device->host->hostdata;
 
@@ -2271,7 +2273,8 @@ static void fas216_internal_done(Scsi_Cm
  * Returns: scsi result code.
  * Notes: io_request_lock is held, interrupts are disabled.
  */
-int fas216_noqueue_command(Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
+int fas216_noqueue_command(struct scsi_cmnd *SCpnt,
+			   void (*done)(struct scsi_cmnd *))
 {
 	FAS216_Info *info = (FAS216_Info *)SCpnt->device->host->hostdata;
 
@@ -2350,7 +2353,8 @@ enum res_find {
  * Decide how to abort a command.
  * Returns: abort status
  */
-static enum res_find fas216_find_command(FAS216_Info *info, Scsi_Cmnd *SCpnt)
+static enum res_find fas216_find_command(FAS216_Info *info,
+					 struct scsi_cmnd *SCpnt)
 {
 	enum res_find res = res_failed;
 
@@ -2417,7 +2421,7 @@ static enum res_find fas216_find_command
  * Returns: FAILED if unable to abort
  * Notes: io_request_lock is taken, and irqs are disabled
  */
-int fas216_eh_abort(Scsi_Cmnd *SCpnt)
+int fas216_eh_abort(struct scsi_cmnd *SCpnt)
 {
 	FAS216_Info *info = (FAS216_Info *)SCpnt->device->host->hostdata;
 	int result = FAILED;
@@ -2474,7 +2478,7 @@ int fas216_eh_abort(Scsi_Cmnd *SCpnt)
  * Notes: We won't be re-entered, so we'll only have one device
  * reset on the go at one time.
  */
-int fas216_eh_device_reset(Scsi_Cmnd *SCpnt)
+int fas216_eh_device_reset(struct scsi_cmnd *SCpnt)
 {
 	FAS216_Info *info = (FAS216_Info *)SCpnt->device->host->hostdata;
 	unsigned long flags;
@@ -2555,7 +2559,7 @@ int fas216_eh_device_reset(Scsi_Cmnd *SC
  * Returns: FAILED if unable to reset.
  * Notes: Further commands are blocked.
  */
-int fas216_eh_bus_reset(Scsi_Cmnd *SCpnt)
+int fas216_eh_bus_reset(struct scsi_cmnd *SCpnt)
 {
 	FAS216_Info *info = (FAS216_Info *)SCpnt->device->host->hostdata;
 	unsigned long flags;
@@ -2655,7 +2659,7 @@ static void fas216_init_chip(FAS216_Info
  * Returns: FAILED if unable to reset.
  * Notes: io_request_lock is taken, and irqs are disabled
  */
-int fas216_eh_host_reset(Scsi_Cmnd *SCpnt)
+int fas216_eh_host_reset(struct scsi_cmnd *SCpnt)
 {
 	FAS216_Info *info = (FAS216_Info *)SCpnt->device->host->hostdata;
 
diff --git a/drivers/scsi/arm/fas216.h b/drivers/scsi/arm/fas216.h
index 540914d..00e5f05 100644
--- a/drivers/scsi/arm/fas216.h
+++ b/drivers/scsi/arm/fas216.h
@@ -218,11 +218,11 @@ typedef struct {
 	unsigned long		magic_start;
 	spinlock_t		host_lock;
 	struct Scsi_Host	*host;			/* host					*/
-	Scsi_Cmnd		*SCpnt;			/* currently processing command		*/
-	Scsi_Cmnd		*origSCpnt;		/* original connecting command		*/
-	Scsi_Cmnd		*reqSCpnt;		/* request sense command		*/
-	Scsi_Cmnd		*rstSCpnt;		/* reset command			*/
-	Scsi_Cmnd		*pending_SCpnt[8];	/* per-device pending commands		*/
+	struct scsi_cmnd	*SCpnt;			/* currently processing command		*/
+	struct scsi_cmnd	*origSCpnt;		/* original connecting command		*/
+	struct scsi_cmnd	*reqSCpnt;		/* request sense command		*/
+	struct scsi_cmnd	*rstSCpnt;		/* reset command			*/
+	struct scsi_cmnd	*pending_SCpnt[8];	/* per-device pending commands		*/
 	int			next_pending;		/* next pending device			*/
 
 	/*
@@ -328,21 +328,23 @@ extern int fas216_init (struct Scsi_Host
  */
 extern int fas216_add (struct Scsi_Host *instance, struct device *dev);
 
-/* Function: int fas216_queue_command (Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
+/* Function: int fas216_queue_command(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_cmnd *))
  * Purpose : queue a command for adapter to process.
  * Params  : SCpnt - Command to queue
  *	     done  - done function to call once command is complete
  * Returns : 0 - success, else error
  */
-extern int fas216_queue_command (Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+extern int fas216_queue_command(struct scsi_cmnd *,
+				void (*done)(struct scsi_cmnd *));
 
-/* Function: int fas216_noqueue_command (Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
+/* Function: int fas216_noqueue_command(istruct scsi_cmnd *SCpnt, void (*done)(struct scsi_cmnd *))
  * Purpose : queue a command for adapter to process, and process it to completion.
  * Params  : SCpnt - Command to queue
  *	     done  - done function to call once command is complete
  * Returns : 0 - success, else error
  */
-extern int fas216_noqueue_command (Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+extern int fas216_noqueue_command(struct scsi_cmnd *,
+				  void (*done)(struct scsi_cmnd *));
 
 /* Function: irqreturn_t fas216_intr (FAS216_Info *info)
  * Purpose : handle interrupts from the interface to progress a command
@@ -363,32 +365,32 @@ extern int fas216_print_host(FAS216_Info
 extern int fas216_print_stats(FAS216_Info *info, char *buffer);
 extern int fas216_print_devices(FAS216_Info *info, char *buffer);
 
-/* Function: int fas216_eh_abort(Scsi_Cmnd *SCpnt)
+/* Function: int fas216_eh_abort(struct scsi_cmnd *SCpnt)
  * Purpose : abort this command
  * Params  : SCpnt - command to abort
  * Returns : FAILED if unable to abort
  */
-extern int fas216_eh_abort(Scsi_Cmnd *SCpnt);
+extern int fas216_eh_abort(struct scsi_cmnd *SCpnt);
 
-/* Function: int fas216_eh_device_reset(Scsi_Cmnd *SCpnt)
+/* Function: int fas216_eh_device_reset(struct scsi_cmnd *SCpnt)
  * Purpose : Reset the device associated with this command
  * Params  : SCpnt - command specifing device to reset
  * Returns : FAILED if unable to reset
  */
-extern int fas216_eh_device_reset(Scsi_Cmnd *SCpnt);
+extern int fas216_eh_device_reset(struct scsi_cmnd *SCpnt);
 
-/* Function: int fas216_eh_bus_reset(Scsi_Cmnd *SCpnt)
+/* Function: int fas216_eh_bus_reset(struct scsi_cmnd *SCpnt)
  * Purpose : Reset the complete bus associated with this command
  * Params  : SCpnt - command specifing bus to reset
  * Returns : FAILED if unable to reset
  */
-extern int fas216_eh_bus_reset(Scsi_Cmnd *SCpnt);
+extern int fas216_eh_bus_reset(struct scsi_cmnd *SCpnt);
 
-/* Function: int fas216_eh_host_reset(Scsi_Cmnd *SCpnt)
+/* Function: int fas216_eh_host_reset(struct scsi_cmnd *SCpnt)
  * Purpose : Reset the host associated with this command
  * Params  : SCpnt - command specifing host to reset
  * Returns : FAILED if unable to reset
  */
-extern int fas216_eh_host_reset(Scsi_Cmnd *SCpnt);
+extern int fas216_eh_host_reset(struct scsi_cmnd *SCpnt);
 
 #endif /* FAS216_H */
diff --git a/drivers/scsi/arm/queue.c b/drivers/scsi/arm/queue.c
index 8caa590..cb11cce 100644
--- a/drivers/scsi/arm/queue.c
+++ b/drivers/scsi/arm/queue.c
@@ -29,7 +29,7 @@ #define DEBUG
 
 typedef struct queue_entry {
 	struct list_head   list;
-	Scsi_Cmnd	   *SCpnt;
+	struct scsi_cmnd   *SCpnt;
 #ifdef DEBUG
 	unsigned long	   magic;
 #endif
@@ -96,14 +96,14 @@ void queue_free (Queue_t *queue)
      
 
 /*
- * Function: int queue_add_cmd(Queue_t *queue, Scsi_Cmnd *SCpnt, int head)
+ * Function: int __queue_add(Queue_t *queue, struct scsi_cmnd *SCpnt, int head)
  * Purpose : Add a new command onto a queue, adding REQUEST_SENSE to head.
  * Params  : queue - destination queue
  *	     SCpnt - command to add
  *	     head  - add command to head of queue
  * Returns : 0 on error, !0 on success
  */
-int __queue_add(Queue_t *queue, Scsi_Cmnd *SCpnt, int head)
+int __queue_add(Queue_t *queue, struct scsi_cmnd *SCpnt, int head)
 {
 	unsigned long flags;
 	struct list_head *l;
@@ -134,7 +134,7 @@ empty:
 	return ret;
 }
 
-static Scsi_Cmnd *__queue_remove(Queue_t *queue, struct list_head *ent)
+static struct scsi_cmnd *__queue_remove(Queue_t *queue, struct list_head *ent)
 {
 	QE_t *q;
 
@@ -152,17 +152,17 @@ static Scsi_Cmnd *__queue_remove(Queue_t
 }
 
 /*
- * Function: Scsi_Cmnd *queue_remove_exclude (queue, exclude)
+ * Function: struct scsi_cmnd *queue_remove_exclude (queue, exclude)
  * Purpose : remove a SCSI command from a queue
  * Params  : queue   - queue to remove command from
  *	     exclude - bit array of target&lun which is busy
- * Returns : Scsi_Cmnd if successful (and a reference), or NULL if no command available
+ * Returns : struct scsi_cmnd if successful (and a reference), or NULL if no command available
  */
-Scsi_Cmnd *queue_remove_exclude(Queue_t *queue, unsigned long *exclude)
+struct scsi_cmnd *queue_remove_exclude(Queue_t *queue, unsigned long *exclude)
 {
 	unsigned long flags;
 	struct list_head *l;
-	Scsi_Cmnd *SCpnt = NULL;
+	struct scsi_cmnd *SCpnt = NULL;
 
 	spin_lock_irqsave(&queue->queue_lock, flags);
 	list_for_each(l, &queue->head) {
@@ -178,15 +178,15 @@ Scsi_Cmnd *queue_remove_exclude(Queue_t 
 }
 
 /*
- * Function: Scsi_Cmnd *queue_remove (queue)
+ * Function: struct scsi_cmnd *queue_remove (queue)
  * Purpose : removes first SCSI command from a queue
  * Params  : queue   - queue to remove command from
- * Returns : Scsi_Cmnd if successful (and a reference), or NULL if no command available
+ * Returns : struct scsi_cmnd if successful (and a reference), or NULL if no command available
  */
-Scsi_Cmnd *queue_remove(Queue_t *queue)
+struct scsi_cmnd *queue_remove(Queue_t *queue)
 {
 	unsigned long flags;
-	Scsi_Cmnd *SCpnt = NULL;
+	struct scsi_cmnd *SCpnt = NULL;
 
 	spin_lock_irqsave(&queue->queue_lock, flags);
 	if (!list_empty(&queue->head))
@@ -197,19 +197,20 @@ Scsi_Cmnd *queue_remove(Queue_t *queue)
 }
 
 /*
- * Function: Scsi_Cmnd *queue_remove_tgtluntag (queue, target, lun, tag)
+ * Function: struct scsi_cmnd *queue_remove_tgtluntag (queue, target, lun, tag)
  * Purpose : remove a SCSI command from the queue for a specified target/lun/tag
  * Params  : queue  - queue to remove command from
  *	     target - target that we want
  *	     lun    - lun on device
  *	     tag    - tag on device
- * Returns : Scsi_Cmnd if successful, or NULL if no command satisfies requirements
+ * Returns : struct scsi_cmnd if successful, or NULL if no command satisfies requirements
  */
-Scsi_Cmnd *queue_remove_tgtluntag (Queue_t *queue, int target, int lun, int tag)
+struct scsi_cmnd *queue_remove_tgtluntag(Queue_t *queue, int target, int lun,
+					 int tag)
 {
 	unsigned long flags;
 	struct list_head *l;
-	Scsi_Cmnd *SCpnt = NULL;
+	struct scsi_cmnd *SCpnt = NULL;
 
 	spin_lock_irqsave(&queue->queue_lock, flags);
 	list_for_each(l, &queue->head) {
@@ -275,13 +276,13 @@ int queue_probetgtlun (Queue_t *queue, i
 }
 
 /*
- * Function: int queue_remove_cmd(Queue_t *queue, Scsi_Cmnd *SCpnt)
+ * Function: int queue_remove_cmd(Queue_t *queue, struct scsi_cmnd *SCpnt)
  * Purpose : remove a specific command from the queues
  * Params  : queue - queue to look in
  *	     SCpnt - command to find
  * Returns : 0 if not found
  */
-int queue_remove_cmd(Queue_t *queue, Scsi_Cmnd *SCpnt)
+int queue_remove_cmd(Queue_t *queue, struct scsi_cmnd *SCpnt)
 {
 	unsigned long flags;
 	struct list_head *l;
diff --git a/drivers/scsi/arm/queue.h b/drivers/scsi/arm/queue.h
index 0c9dec4..3c519c9 100644
--- a/drivers/scsi/arm/queue.h
+++ b/drivers/scsi/arm/queue.h
@@ -32,46 +32,48 @@ extern int queue_initialise (Queue_t *qu
 extern void queue_free (Queue_t *queue);
 
 /*
- * Function: Scsi_Cmnd *queue_remove (queue)
+ * Function: struct scsi_cmnd *queue_remove (queue)
  * Purpose : removes first SCSI command from a queue
  * Params  : queue   - queue to remove command from
- * Returns : Scsi_Cmnd if successful (and a reference), or NULL if no command available
+ * Returns : struct scsi_cmnd if successful (and a reference), or NULL if no command available
  */
-extern Scsi_Cmnd *queue_remove (Queue_t *queue);
+extern struct scsi_cmnd *queue_remove (Queue_t *queue);
 
 /*
- * Function: Scsi_Cmnd *queue_remove_exclude_ref (queue, exclude)
+ * Function: struct scsi_cmnd *queue_remove_exclude_ref (queue, exclude)
  * Purpose : remove a SCSI command from a queue
  * Params  : queue   - queue to remove command from
  *	     exclude - array of busy LUNs
- * Returns : Scsi_Cmnd if successful (and a reference), or NULL if no command available
+ * Returns : struct scsi_cmnd if successful (and a reference), or NULL if no command available
  */
-extern Scsi_Cmnd *queue_remove_exclude (Queue_t *queue, unsigned long *exclude);
+extern struct scsi_cmnd *queue_remove_exclude(Queue_t *queue,
+					      unsigned long *exclude);
 
 #define queue_add_cmd_ordered(queue,SCpnt) \
 	__queue_add(queue,SCpnt,(SCpnt)->cmnd[0] == REQUEST_SENSE)
 #define queue_add_cmd_tail(queue,SCpnt) \
 	__queue_add(queue,SCpnt,0)
 /*
- * Function: int __queue_add(Queue_t *queue, Scsi_Cmnd *SCpnt, int head)
+ * Function: int __queue_add(Queue_t *queue, struct scsi_cmnd *SCpnt, int head)
  * Purpose : Add a new command onto a queue
  * Params  : queue - destination queue
  *	     SCpnt - command to add
  *	     head  - add command to head of queue
  * Returns : 0 on error, !0 on success
  */
-extern int __queue_add(Queue_t *queue, Scsi_Cmnd *SCpnt, int head);
+extern int __queue_add(Queue_t *queue, struct scsi_cmnd *SCpnt, int head);
 
 /*
- * Function: Scsi_Cmnd *queue_remove_tgtluntag (queue, target, lun, tag)
+ * Function: struct scsi_cmnd *queue_remove_tgtluntag (queue, target, lun, tag)
  * Purpose : remove a SCSI command from the queue for a specified target/lun/tag
  * Params  : queue  - queue to remove command from
  *	     target - target that we want
  *	     lun    - lun on device
  *	     tag    - tag on device
- * Returns : Scsi_Cmnd if successful, or NULL if no command satisfies requirements
+ * Returns : struct scsi_cmnd if successful, or NULL if no command satisfies requirements
  */
-extern Scsi_Cmnd *queue_remove_tgtluntag (Queue_t *queue, int target, int lun, int tag);
+extern struct scsi_cmnd *queue_remove_tgtluntag(Queue_t *queue, int target,
+						int lun, int tag);
 
 /*
  * Function: queue_remove_all_target(queue, target)
@@ -94,12 +96,12 @@ extern void queue_remove_all_target(Queu
 extern int queue_probetgtlun (Queue_t *queue, int target, int lun);
 
 /*
- * Function: int queue_remove_cmd (Queue_t *queue, Scsi_Cmnd *SCpnt)
+ * Function: int queue_remove_cmd (Queue_t *queue, struct scsi_cmnd *SCpnt)
  * Purpose : remove a specific command from the queues
  * Params  : queue - queue to look in
  *	     SCpnt - command to find
  * Returns : 0 if not found
  */
-int queue_remove_cmd(Queue_t *queue, Scsi_Cmnd *SCpnt);
+int queue_remove_cmd(Queue_t *queue, struct scsi_cmnd *SCpnt);
 
 #endif /* QUEUE_H */
diff --git a/drivers/scsi/arm/scsi.h b/drivers/scsi/arm/scsi.h
index 8c2600f..3a39579 100644
--- a/drivers/scsi/arm/scsi.h
+++ b/drivers/scsi/arm/scsi.h
@@ -66,7 +66,7 @@ static inline void put_next_SCp_byte(str
 	SCp->this_residual -= 1;
 }
 
-static inline void init_SCp(Scsi_Cmnd *SCpnt)
+static inline void init_SCp(struct scsi_cmnd *SCpnt)
 {
 	memset(&SCpnt->SCp, 0, sizeof(struct scsi_pointer));
 


