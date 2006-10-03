Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbWJCTaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbWJCTaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbWJCTaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:30:52 -0400
Received: from server6.greatnet.de ([83.133.96.26]:30687 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030513AbWJCTav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:30:51 -0400
Message-ID: <4522BA82.60604@nachtwindheim.de>
Date: Tue, 03 Oct 2006 21:31:14 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Scsi_Cmnd conversion in qlogicfas408 driver
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change obsolete Scsi_Cmnd to struct scsi_cmnd in the Qlocic FAS408 driver.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

 qlogicfas408.c |   18 +++++++++---------
 qlogicfas408.h |   30 +++++++++++++++---------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/qlogicfas408.c b/drivers/scsi/qlogicfas408.c
index 52fb2ec..2a75485 100644
--- a/drivers/scsi/qlogicfas408.c
+++ b/drivers/scsi/qlogicfas408.c
@@ -209,7 +209,7 @@ static int ql_wai(struct qlogicfas408_pr
  *	caller must hold host lock
  */
 
-static void ql_icmd(Scsi_Cmnd * cmd)
+static void ql_icmd(struct scsi_cmnd *cmd)
 {
 	struct qlogicfas408_priv *priv = get_priv_by_cmd(cmd);
 	int 	qbase = priv->qbase;
@@ -256,7 +256,7 @@ static void ql_icmd(Scsi_Cmnd * cmd)
  *	Process scsi command - usually after interrupt 
  */
 
-static unsigned int ql_pcmd(Scsi_Cmnd * cmd)
+static unsigned int ql_pcmd(struct scsi_cmnd *cmd)
 {
 	unsigned int i, j;
 	unsigned long k;
@@ -407,7 +407,7 @@ static unsigned int ql_pcmd(Scsi_Cmnd * 
 
 static void ql_ihandl(int irq, void *dev_id, struct pt_regs *regs)
 {
-	Scsi_Cmnd *icmd;
+	struct scsi_cmnd *icmd;
 	struct Scsi_Host *host = (struct Scsi_Host *)dev_id;
 	struct qlogicfas408_priv *priv = get_priv_by_host(host);
 	int qbase = priv->qbase;
@@ -447,7 +447,8 @@ irqreturn_t qlogicfas408_ihandl(int irq,
  *	Queued command
  */
 
-int qlogicfas408_queuecommand(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
+int qlogicfas408_queuecommand(struct scsi_cmnd *cmd,
+			      void (*done) (struct scsi_cmnd *))
 {
 	struct qlogicfas408_priv *priv = get_priv_by_cmd(cmd);
 	if (scmd_id(cmd) == priv->qinitid) {
@@ -470,9 +471,8 @@ int qlogicfas408_queuecommand(Scsi_Cmnd 
  *	Return bios parameters 
  */
 
-int qlogicfas408_biosparam(struct scsi_device * disk,
-		        struct block_device *dev,
-			sector_t capacity, int ip[])
+int qlogicfas408_biosparam(struct scsi_device *disk, struct block_device *dev,
+			   sector_t capacity, int ip[])
 {
 /* This should mimic the DOS Qlogic driver's behavior exactly */
 	ip[0] = 0x40;
@@ -494,7 +494,7 @@ #endif
  *	Abort a command in progress
  */
  
-int qlogicfas408_abort(Scsi_Cmnd * cmd)
+int qlogicfas408_abort(struct scsi_cmnd *cmd)
 {
 	struct qlogicfas408_priv *priv = get_priv_by_cmd(cmd);
 	priv->qabort = 1;
@@ -508,7 +508,7 @@ int qlogicfas408_abort(Scsi_Cmnd * cmd)
  *	the PCMCIA qlogic_stub code. This wants fixing
  */
 
-int qlogicfas408_bus_reset(Scsi_Cmnd * cmd)
+int qlogicfas408_bus_reset(struct scsi_cmnd *cmd)
 {
 	struct qlogicfas408_priv *priv = get_priv_by_cmd(cmd);
 	unsigned long flags;
diff --git a/drivers/scsi/qlogicfas408.h b/drivers/scsi/qlogicfas408.h
index 4b3df20..ee3e23e 100644
--- a/drivers/scsi/qlogicfas408.h
+++ b/drivers/scsi/qlogicfas408.h
@@ -75,15 +75,15 @@ #define SYNCOFFST 0
 /*----------------------------------------------------------------*/
 
 struct qlogicfas408_priv {
-	 int		qbase;		/* Port */
-	 int		qinitid;	/* initiator ID */
-	 int		qabort;		/* Flag to cause an abort */
-	 int		qlirq;		/* IRQ being used */
-	 int		int_type;	/* type of irq, 2 for ISA board, 0 for PCMCIA */
-	 char		qinfo[80];	/* description */
-	 Scsi_Cmnd 	*qlcmd;		/* current command being processed */
-	 struct Scsi_Host *shost;	/* pointer back to host */
-	 struct qlogicfas408_priv *next; /* next private struct */
+	int qbase;		/* Port */
+	int qinitid;		/* initiator ID */
+	int qabort;		/* Flag to cause an abort */
+	int qlirq;		/* IRQ being used */
+	int int_type;		/* type of irq, 2 for ISA board, 0 for PCMCIA */
+	char qinfo[80];		/* description */
+	struct scsi_cmnd *qlcmd;	/* current command being processed */
+	struct Scsi_Host *shost;	/* pointer back to host */
+	struct qlogicfas408_priv *next; /* next private struct */
 };
 
 /* The qlogic card uses two register maps - These macros select which one */
@@ -103,12 +103,12 @@ #define get_priv_by_cmd(x) (struct qlogi
 #define get_priv_by_host(x) (struct qlogicfas408_priv *)&((x)->hostdata[0])
 
 irqreturn_t qlogicfas408_ihandl(int irq, void *dev_id, struct pt_regs *regs);
-int qlogicfas408_queuecommand(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *));
-int qlogicfas408_biosparam(struct scsi_device * disk,
-		        struct block_device *dev,
-			sector_t capacity, int ip[]);
-int qlogicfas408_abort(Scsi_Cmnd * cmd);
-int qlogicfas408_bus_reset(Scsi_Cmnd * cmd);
+int qlogicfas408_queuecommand(struct scsi_cmnd *cmd,
+			      void (*done) (struct scsi_cmnd *));
+int qlogicfas408_biosparam(struct scsi_device * disk, struct block_device *dev,
+			   sector_t capacity, int ip[]);
+int qlogicfas408_abort(struct scsi_cmnd *cmd);
+int qlogicfas408_bus_reset(struct scsi_cmnd *cmd);
 const char *qlogicfas408_info(struct Scsi_Host *host);
 int qlogicfas408_get_chip_type(int qbase, int int_type);
 void qlogicfas408_setup(int qbase, int id, int int_type);


