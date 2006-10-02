Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWJBPiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWJBPiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWJBPiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:38:07 -0400
Received: from server6.greatnet.de ([83.133.96.26]:52900 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964807AbWJBPiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:38:03 -0400
Message-ID: <45213277.30706@nachtwindheim.de>
Date: Mon, 02 Oct 2006 17:38:31 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fc4: Convertion to struct scsi_cmnd in fc4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the obsolete Scsi_Cmnd to struct scsi_cmnd in the
Fibre Channel driver (fc4).
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

 fc.c       |   28 +++++++++++++++-------------
 fcp_impl.h |   15 ++++++++-------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/fc4/fc.c b/drivers/fc4/fc.c
index 22d1747..ca4e67a 100644
--- a/drivers/fc4/fc.c
+++ b/drivers/fc4/fc.c
@@ -70,9 +70,9 @@ #endif							       
 
 #define FCP_CMND(SCpnt) ((fcp_cmnd *)&(SCpnt->SCp))
 #define FC_SCMND(SCpnt) ((fc_channel *)(SCpnt->device->host->hostdata[0]))
-#define SC_FCMND(fcmnd) ((Scsi_Cmnd *)((long)fcmnd - (long)&(((Scsi_Cmnd *)0)->SCp)))
+#define SC_FCMND(fcmnd)	((struct scsi_cmnd *)((long)fcmnd - (long)&(((struct scsi_cmnd *)0)->SCp)))
 
-static int fcp_scsi_queue_it(fc_channel *, Scsi_Cmnd *, fcp_cmnd *, int);
+static int fcp_scsi_queue_it(fc_channel *, struct scsi_cmnd *, fcp_cmnd *, int);
 void fcp_queue_empty(fc_channel *);
 
 static void fcp_scsi_insert_queue (fc_channel *fc, fcp_cmnd *fcmd)
@@ -378,14 +378,14 @@ #endif
 		printk ("FC: %segistering unknown type %02x\n", unregister ? "Unr" : "R", type);
 }
 
-static void fcp_scsi_done(Scsi_Cmnd *SCpnt);
+static void fcp_scsi_done(struct scsi_cmnd *SCpnt);
 
 static inline void fcp_scsi_receive(fc_channel *fc, int token, int status, fc_hdr *fch)
 {
 	fcp_cmnd *fcmd;
 	fcp_rsp  *rsp;
 	int host_status;
-	Scsi_Cmnd *SCpnt;
+	struct scsi_cmnd *SCpnt;
 	int sense_len;
 	int rsp_status;
 
@@ -757,13 +757,14 @@ void fcp_release(fc_channel *fcchain, in
 }
 
 
-static void fcp_scsi_done (Scsi_Cmnd *SCpnt)
+static void fcp_scsi_done(struct scsi_cmnd *SCpnt)
 {
 	if (FCP_CMND(SCpnt)->done)
 		FCP_CMND(SCpnt)->done(SCpnt);
 }
 
-static int fcp_scsi_queue_it(fc_channel *fc, Scsi_Cmnd *SCpnt, fcp_cmnd *fcmd, int prepare)
+static int fcp_scsi_queue_it(fc_channel *fc, struct scsi_cmnd *SCpnt,
+			     fcp_cmnd *fcmd, int prepare)
 {
 	long i;
 	fcp_cmd *cmd;
@@ -837,7 +838,8 @@ static int fcp_scsi_queue_it(fc_channel 
 	return 0;
 }
 
-int fcp_scsi_queuecommand(Scsi_Cmnd *SCpnt, void (* done)(Scsi_Cmnd *))
+int fcp_scsi_queuecommand(struct scsi_cmnd *SCpnt,
+			  void (* done)(struct scsi_cmnd *))
 {
 	fcp_cmnd *fcmd = FCP_CMND(SCpnt);
 	fc_channel *fc = FC_SCMND(SCpnt);
@@ -873,7 +875,7 @@ void fcp_queue_empty(fc_channel *fc)
 	}
 }
 
-int fcp_scsi_abort(Scsi_Cmnd *SCpnt)
+int fcp_scsi_abort(struct scsi_cmnd *SCpnt)
 {
 	/* Internal bookkeeping only. Lose 1 cmd_slots slot. */
 	fcp_cmnd *fcmd = FCP_CMND(SCpnt);
@@ -910,7 +912,7 @@ int fcp_scsi_abort(Scsi_Cmnd *SCpnt)
 }
 
 #if 0
-void fcp_scsi_reset_done(Scsi_Cmnd *SCpnt)
+void fcp_scsi_reset_done(struct scsi_cmnd *SCpnt)
 {
 	fc_channel *fc = FC_SCMND(SCpnt);
 
@@ -921,7 +923,7 @@ #endif
 
 #define FCP_RESET_TIMEOUT (2*HZ)
 
-int fcp_scsi_dev_reset(Scsi_Cmnd *SCpnt)
+int fcp_scsi_dev_reset(struct scsi_cmnd *SCpnt)
 {
 #if 0 /* broken junk, but if davem wants to compile this driver, let him.. */
 	unsigned long flags;
@@ -931,7 +933,7 @@ #if 0 /* broken junk, but if davem wants
         DECLARE_MUTEX_LOCKED(sem);
 
 	if (!fc->rst_pkt) {
-		fc->rst_pkt = (Scsi_Cmnd *) kmalloc(sizeof(SCpnt), GFP_KERNEL);
+		fc->rst_pkt = (struct scsi_cmnd *) kmalloc(sizeof(SCpnt), GFP_KERNEL);
 		if (!fc->rst_pkt) return FAILED;
 		
 		fcmd = FCP_CMND(fc->rst_pkt);
@@ -999,7 +1001,7 @@ #endif
 	return SUCCESS;
 }
 
-static int __fcp_scsi_host_reset(Scsi_Cmnd *SCpnt)
+static int __fcp_scsi_host_reset(struct scsi_cmnd *SCpnt)
 {
 	fc_channel *fc = FC_SCMND(SCpnt);
 	fcp_cmnd *fcmd = FCP_CMND(SCpnt);
@@ -1020,7 +1022,7 @@ static int __fcp_scsi_host_reset(Scsi_Cm
 	else return FAILED;
 }
 
-int fcp_scsi_host_reset(Scsi_Cmnd *SCpnt)
+int fcp_scsi_host_reset(struct scsi_cmnd *SCpnt)
 {
 	unsigned long flags;
 	int rc;
diff --git a/drivers/fc4/fcp_impl.h b/drivers/fc4/fcp_impl.h
index c397c84..1ac6133 100644
--- a/drivers/fc4/fcp_impl.h
+++ b/drivers/fc4/fcp_impl.h
@@ -39,7 +39,7 @@ struct _fc_channel; 
 typedef struct fcp_cmnd {
 	struct fcp_cmnd		*next;
 	struct fcp_cmnd		*prev;
-	void			(*done)(Scsi_Cmnd *);
+	void			(*done)(struct scsi_cmnd *);
 	unsigned short		proto;
 	unsigned short		token;
 	unsigned int		did;
@@ -94,14 +94,14 @@ #endif
 	long			*scsi_bitmap;
 	long			scsi_bitmap_end;
 	int			scsi_free;
-	int			(*encode_addr)(Scsi_Cmnd *, u16 *, struct _fc_channel *, fcp_cmnd *);
+	int			(*encode_addr)(struct scsi_cmnd *, u16 *, struct _fc_channel *, fcp_cmnd *);
 	fcp_cmnd		*scsi_que;
 	char			scsi_name[4];
 	fcp_cmnd		**cmd_slots;
 	int			channels;
 	int			targets;
 	long			*ages;
-	Scsi_Cmnd		*rst_pkt;
+	struct scsi_cmnd	*rst_pkt;
 	fcp_posmap		*posmap;
 	/* LOGIN stuff */
 	fcp_cmnd		*login;
@@ -155,9 +155,10 @@ #define for_each_online_fc_channel(fc) 	
 	for_each_fc_channel(fc)				\
 		if (fc->state == FC_STATE_ONLINE)
 
-int fcp_scsi_queuecommand(Scsi_Cmnd *, void (* done)(Scsi_Cmnd *));
-int fcp_scsi_abort(Scsi_Cmnd *);
-int fcp_scsi_dev_reset(Scsi_Cmnd *);
-int fcp_scsi_host_reset(Scsi_Cmnd *);
+int fcp_scsi_queuecommand(struct scsi_cmnd *,
+			  void (* done) (struct scsi_cmnd *));
+int fcp_scsi_abort(struct scsi_cmnd *);
+int fcp_scsi_dev_reset(struct scsi_cmnd *);
+int fcp_scsi_host_reset(struct scsi_cmnd *);
 
 #endif /* !(_FCP_SCSI_H) */


