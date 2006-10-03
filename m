Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWJCUUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWJCUUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 16:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWJCUUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 16:20:54 -0400
Received: from server6.greatnet.de ([83.133.96.26]:44484 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030320AbWJCUUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 16:20:53 -0400
Message-ID: <4522C63C.6000208@nachtwindheim.de>
Date: Tue, 03 Oct 2006 22:21:16 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Scsi_Cmnd convertion in psi240i driver
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the obsolete Scsi_Cmnd to struct scsi_cmnd in psi240i-driver.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

 psi240i.c |   31 ++++++++++++++++++-------------
 psi240i.h |    6 +++---
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/psi240i.c b/drivers/scsi/psi240i.c
index 5c2cdf5..b08654d 100644
--- a/drivers/scsi/psi240i.c
+++ b/drivers/scsi/psi240i.c
@@ -87,11 +87,11 @@ typedef struct
 	{
 	USHORT		 ports[13];
 	OUR_DEVICE	 device[8];
-	Scsi_Cmnd	*pSCmnd;
+	struct scsi_cmnd *pSCmnd;
 	IDE_STRUCT	 ide;
 	ULONG		 startSector;
 	USHORT		 sectorCount;
-	Scsi_Cmnd	*SCpnt;
+	struct scsi_cmnd *SCpnt;
 	VOID		*buffer;
 	USHORT		 expectingIRQ;
 	}	ADAPTER240I, *PADAPTER240I;
@@ -254,12 +254,12 @@ static ULONG DecodeError (struct Scsi_Ho
  ****************************************************************/
 static void Irq_Handler (int irq, void *dev_id, struct pt_regs *regs)
 	{
-	struct Scsi_Host   *shost;			// Pointer to host data block
-	PADAPTER240I		padapter;		// Pointer to adapter control structure
-	USHORT		 	   *pports;			// I/O port array
-	Scsi_Cmnd		   *SCpnt;
-	UCHAR				status;
-	int					z;
+	struct Scsi_Host *shost;	// Pointer to host data block
+	PADAPTER240I padapter;		// Pointer to adapter control structure
+	USHORT *pports;			// I/O port array
+	struct scsi_cmnd *SCpnt;
+	UCHAR status;
+	int z;
 
 	DEB(printk ("\npsi240i received interrupt\n"));
 
@@ -390,12 +390,17 @@ static irqreturn_t do_Irq_Handler (int i
  *	Returns:		Status code.
  *
  ****************************************************************/
-static int Psi240i_QueueCommand (Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
+static int Psi240i_QueueCommand(struct scsi_cmnd *SCpnt,
+				void (*done)(struct scsi_cmnd *))
 	{
-	UCHAR		   *cdb = (UCHAR *)SCpnt->cmnd;					// Pointer to SCSI CDB
-	PADAPTER240I	padapter = HOSTDATA (SCpnt->device->host); 			// Pointer to adapter control structure
-	POUR_DEVICE 		pdev	 = &padapter->device [SCpnt->device->id];// Pointer to device information
-	UCHAR			rc;											// command return code
+	UCHAR *cdb = (UCHAR *)SCpnt->cmnd;
+	// Pointer to SCSI CDB
+	PADAPTER240I padapter = HOSTDATA (SCpnt->device->host);
+	// Pointer to adapter control structure
+	POUR_DEVICE pdev = &padapter->device [SCpnt->device->id];
+	// Pointer to device information
+	UCHAR rc;
+	// command return code
 
 	SCpnt->scsi_done = done;
 	padapter->ide.ide.ides.spigot = pdev->spigot;
diff --git a/drivers/scsi/psi240i.h b/drivers/scsi/psi240i.h
index 6a59876..21ebb92 100644
--- a/drivers/scsi/psi240i.h
+++ b/drivers/scsi/psi240i.h
@@ -309,7 +309,7 @@ typedef struct _IDENTIFY_DATA2 {
 #endif	// PSI_EIDE_SCSIOP
 
 // function prototypes
-int Psi240i_Command			(Scsi_Cmnd *SCpnt);
-int Psi240i_Abort			(Scsi_Cmnd *SCpnt);
-int Psi240i_Reset			(Scsi_Cmnd *SCpnt, unsigned int flags);
+int Psi240i_Command(struct scsi_cmnd *SCpnt);
+int Psi240i_Abort(struct scsi_cmnd *SCpnt);
+int Psi240i_Reset(struct scsi_cmnd *SCpnt, unsigned int flags);
 #endif


