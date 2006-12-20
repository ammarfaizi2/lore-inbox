Return-Path: <linux-kernel-owner+w=401wt.eu-S1030318AbWLTVAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWLTVAu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWLTVAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:00:50 -0500
Received: from havoc.gtf.org ([69.61.125.42]:34853 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030198AbWLTVAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:00:47 -0500
Date: Wed, 20 Dec 2006 16:00:42 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes
Message-ID: <20061220210042.GA25303@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW the Tejun cleanups are a fix, split into three reviewable pieces.

Also, my local iomap branch has advanced sufficiently enough that I
think it's high time to kill those libata warnings that spew on every
build.  (I hear the crowds roar)

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/ahci.c        |    8 ++
 drivers/ata/libata-scsi.c |  238 +++++++++++++++++++++++---------------------
 drivers/ata/pata_cs5530.c |    3 +-
 drivers/ata/pata_via.c    |    2 +-
 drivers/ata/sata_nv.c     |    8 --
 drivers/ata/sata_svw.c    |   41 +++++----
 drivers/ata/sata_vsc.c    |   43 +++++----
 7 files changed, 182 insertions(+), 161 deletions(-)

Andrew Morton (2):
      [libata] pata_cs5530: suspend/resume support tweak
      [libata] pata_via: suspend/resume support fix

Jeff Garzik (1):
      [libata] sata_svw, sata_vsc: kill iomem warnings

Peer Chen (1):
      [libata] Move some PCI IDs from sata_nv to ahci

Tejun Heo (3):
      libata: clean up variable name usage in xlat related functions
      libata: kill @cdb argument from xlat methods
      libata: take scmd->cmd_len into account when translating SCSI commands

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index dbae6d9..b517d24 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -402,6 +402,14 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(NVIDIA, 0x044d), board_ahci },		/* MCP65 */
 	{ PCI_VDEVICE(NVIDIA, 0x044e), board_ahci },		/* MCP65 */
 	{ PCI_VDEVICE(NVIDIA, 0x044f), board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045c), board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045d), board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045e), board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045f), board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x0550), board_ahci },		/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0551), board_ahci },		/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0552), board_ahci },		/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0553), board_ahci },		/* MCP67 */
 	{ PCI_VDEVICE(NVIDIA, 0x0554), board_ahci },		/* MCP67 */
 	{ PCI_VDEVICE(NVIDIA, 0x0555), board_ahci },		/* MCP67 */
 	{ PCI_VDEVICE(NVIDIA, 0x0556), board_ahci },		/* MCP67 */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a4790be..836947d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -51,7 +51,7 @@
 
 #define SECTOR_SIZE	512
 
-typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
+typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc);
 
 static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
 					const struct scsi_device *scsidev);
@@ -935,7 +935,6 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 /**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate
  *
  *	Sets up an ATA taskfile to issue STANDBY (to stop) or READ VERIFY
  *	(to start). Perhaps these commands should be preceded by
@@ -948,22 +947,25 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc,
-					     const u8 *scsicmd)
+static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 {
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
+	const u8 *cdb = scmd->cmnd;
+
+	if (scmd->cmd_len < 5)
+		goto invalid_fld;
 
 	tf->flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
 	tf->protocol = ATA_PROT_NODATA;
-	if (scsicmd[1] & 0x1) {
+	if (cdb[1] & 0x1) {
 		;	/* ignore IMMED bit, violates sat-r05 */
 	}
-	if (scsicmd[4] & 0x2)
+	if (cdb[4] & 0x2)
 		goto invalid_fld;       /* LOEJ bit set not supported */
-	if (((scsicmd[4] >> 4) & 0xf) != 0)
+	if (((cdb[4] >> 4) & 0xf) != 0)
 		goto invalid_fld;       /* power conditions not supported */
-	if (scsicmd[4] & 0x1) {
+	if (cdb[4] & 0x1) {
 		tf->nsect = 1;	/* 1 sector, lba=0 */
 
 		if (qc->dev->flags & ATA_DFLAG_LBA) {
@@ -996,7 +998,7 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc,
 	return 0;
 
 invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
 	return 1;
 }
@@ -1005,7 +1007,6 @@ invalid_fld:
 /**
  *	ata_scsi_flush_xlat - Translate SCSI SYNCHRONIZE CACHE command
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate (ignored)
  *
  *	Sets up an ATA taskfile to issue FLUSH CACHE or
  *	FLUSH CACHE EXT.
@@ -1016,8 +1017,7 @@ invalid_fld:
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &qc->tf;
 
@@ -1034,7 +1034,7 @@ static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *scs
 
 /**
  *	scsi_6_lba_len - Get LBA and transfer length
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Calculate LBA and transfer length for 6-byte commands.
  *
@@ -1042,18 +1042,17 @@ static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *scs
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-
-static void scsi_6_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
+static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
 	u64 lba = 0;
 	u32 len = 0;
 
 	VPRINTK("six-byte command\n");
 
-	lba |= ((u64)scsicmd[2]) << 8;
-	lba |= ((u64)scsicmd[3]);
+	lba |= ((u64)cdb[2]) << 8;
+	lba |= ((u64)cdb[3]);
 
-	len |= ((u32)scsicmd[4]);
+	len |= ((u32)cdb[4]);
 
 	*plba = lba;
 	*plen = len;
@@ -1061,7 +1060,7 @@ static void scsi_6_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
 
 /**
  *	scsi_10_lba_len - Get LBA and transfer length
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Calculate LBA and transfer length for 10-byte commands.
  *
@@ -1069,21 +1068,20 @@ static void scsi_6_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-
-static void scsi_10_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
+static void scsi_10_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
 	u64 lba = 0;
 	u32 len = 0;
 
 	VPRINTK("ten-byte command\n");
 
-	lba |= ((u64)scsicmd[2]) << 24;
-	lba |= ((u64)scsicmd[3]) << 16;
-	lba |= ((u64)scsicmd[4]) << 8;
-	lba |= ((u64)scsicmd[5]);
+	lba |= ((u64)cdb[2]) << 24;
+	lba |= ((u64)cdb[3]) << 16;
+	lba |= ((u64)cdb[4]) << 8;
+	lba |= ((u64)cdb[5]);
 
-	len |= ((u32)scsicmd[7]) << 8;
-	len |= ((u32)scsicmd[8]);
+	len |= ((u32)cdb[7]) << 8;
+	len |= ((u32)cdb[8]);
 
 	*plba = lba;
 	*plen = len;
@@ -1091,7 +1089,7 @@ static void scsi_10_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
 
 /**
  *	scsi_16_lba_len - Get LBA and transfer length
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Calculate LBA and transfer length for 16-byte commands.
  *
@@ -1099,27 +1097,26 @@ static void scsi_10_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-
-static void scsi_16_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
+static void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
 	u64 lba = 0;
 	u32 len = 0;
 
 	VPRINTK("sixteen-byte command\n");
 
-	lba |= ((u64)scsicmd[2]) << 56;
-	lba |= ((u64)scsicmd[3]) << 48;
-	lba |= ((u64)scsicmd[4]) << 40;
-	lba |= ((u64)scsicmd[5]) << 32;
-	lba |= ((u64)scsicmd[6]) << 24;
-	lba |= ((u64)scsicmd[7]) << 16;
-	lba |= ((u64)scsicmd[8]) << 8;
-	lba |= ((u64)scsicmd[9]);
+	lba |= ((u64)cdb[2]) << 56;
+	lba |= ((u64)cdb[3]) << 48;
+	lba |= ((u64)cdb[4]) << 40;
+	lba |= ((u64)cdb[5]) << 32;
+	lba |= ((u64)cdb[6]) << 24;
+	lba |= ((u64)cdb[7]) << 16;
+	lba |= ((u64)cdb[8]) << 8;
+	lba |= ((u64)cdb[9]);
 
-	len |= ((u32)scsicmd[10]) << 24;
-	len |= ((u32)scsicmd[11]) << 16;
-	len |= ((u32)scsicmd[12]) << 8;
-	len |= ((u32)scsicmd[13]);
+	len |= ((u32)cdb[10]) << 24;
+	len |= ((u32)cdb[11]) << 16;
+	len |= ((u32)cdb[12]) << 8;
+	len |= ((u32)cdb[13]);
 
 	*plba = lba;
 	*plen = len;
@@ -1128,7 +1125,6 @@ static void scsi_16_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
 /**
  *	ata_scsi_verify_xlat - Translate SCSI VERIFY command into an ATA one
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate
  *
  *	Converts SCSI VERIFY command to an ATA READ VERIFY command.
  *
@@ -1138,23 +1134,28 @@ static void scsi_16_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc)
 {
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_device *dev = qc->dev;
 	u64 dev_sectors = qc->dev->n_sectors;
+	const u8 *cdb = scmd->cmnd;
 	u64 block;
 	u32 n_block;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
 
-	if (scsicmd[0] == VERIFY)
-		scsi_10_lba_len(scsicmd, &block, &n_block);
-	else if (scsicmd[0] == VERIFY_16)
-		scsi_16_lba_len(scsicmd, &block, &n_block);
-	else
+	if (cdb[0] == VERIFY) {
+		if (scmd->cmd_len < 10)
+			goto invalid_fld;
+		scsi_10_lba_len(cdb, &block, &n_block);
+	} else if (cdb[0] == VERIFY_16) {
+		if (scmd->cmd_len < 16)
+			goto invalid_fld;
+		scsi_16_lba_len(cdb, &block, &n_block);
+	} else
 		goto invalid_fld;
 
 	if (!n_block)
@@ -1229,24 +1230,23 @@ static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, const u8 *sc
 	return 0;
 
 invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
 	return 1;
 
 out_of_range:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x21, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x21, 0x0);
 	/* "Logical Block Address out of range" */
 	return 1;
 
 nothing_to_do:
-	qc->scsicmd->result = SAM_STAT_GOOD;
+	scmd->result = SAM_STAT_GOOD;
 	return 1;
 }
 
 /**
  *	ata_scsi_rw_xlat - Translate SCSI r/w command into an ATA one
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate
  *
  *	Converts any of six SCSI read/write commands into the
  *	ATA counterpart, including starting sector (LBA),
@@ -1262,29 +1262,33 @@ nothing_to_do:
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
 {
+	struct scsi_cmnd *scmd = qc->scsicmd;
+	const u8 *cdb = scmd->cmnd;
 	unsigned int tf_flags = 0;
 	u64 block;
 	u32 n_block;
 	int rc;
 
-	if (scsicmd[0] == WRITE_10 || scsicmd[0] == WRITE_6 ||
-	    scsicmd[0] == WRITE_16)
+	if (cdb[0] == WRITE_10 || cdb[0] == WRITE_6 || cdb[0] == WRITE_16)
 		tf_flags |= ATA_TFLAG_WRITE;
 
 	/* Calculate the SCSI LBA, transfer length and FUA. */
-	switch (scsicmd[0]) {
+	switch (cdb[0]) {
 	case READ_10:
 	case WRITE_10:
-		scsi_10_lba_len(scsicmd, &block, &n_block);
-		if (unlikely(scsicmd[1] & (1 << 3)))
+		if (unlikely(scmd->cmd_len < 10))
+			goto invalid_fld;
+		scsi_10_lba_len(cdb, &block, &n_block);
+		if (unlikely(cdb[1] & (1 << 3)))
 			tf_flags |= ATA_TFLAG_FUA;
 		break;
 	case READ_6:
 	case WRITE_6:
-		scsi_6_lba_len(scsicmd, &block, &n_block);
+		if (unlikely(scmd->cmd_len < 6))
+			goto invalid_fld;
+		scsi_6_lba_len(cdb, &block, &n_block);
 
 		/* for 6-byte r/w commands, transfer length 0
 		 * means 256 blocks of data, not 0 block.
@@ -1294,8 +1298,10 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicm
 		break;
 	case READ_16:
 	case WRITE_16:
-		scsi_16_lba_len(scsicmd, &block, &n_block);
-		if (unlikely(scsicmd[1] & (1 << 3)))
+		if (unlikely(scmd->cmd_len < 16))
+			goto invalid_fld;
+		scsi_16_lba_len(cdb, &block, &n_block);
+		if (unlikely(cdb[1] & (1 << 3)))
 			tf_flags |= ATA_TFLAG_FUA;
 		break;
 	default:
@@ -1326,17 +1332,17 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicm
 		goto out_of_range;
 	/* treat all other errors as -EINVAL, fall through */
 invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
 	return 1;
 
 out_of_range:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x21, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x21, 0x0);
 	/* "Logical Block Address out of range" */
 	return 1;
 
 nothing_to_do:
-	qc->scsicmd->result = SAM_STAT_GOOD;
+	scmd->result = SAM_STAT_GOOD;
 	return 1;
 }
 
@@ -1456,7 +1462,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      ata_xlat_func_t xlat_func)
 {
 	struct ata_queued_cmd *qc;
-	u8 *scsicmd = cmd->cmnd;
 	int is_io = xlat_func == ata_scsi_rw_xlat;
 
 	VPRINTK("ENTER\n");
@@ -1488,7 +1493,7 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 
 	qc->complete_fn = ata_scsi_qc_complete;
 
-	if (xlat_func(qc, scsicmd))
+	if (xlat_func(qc))
 		goto early_finish;
 
 	/* select device, send command to hardware */
@@ -2344,7 +2349,6 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 /**
  *	atapi_xlat - Initialize PACKET taskfile
  *	@qc: command structure to be initialized
- *	@scsicmd: SCSI CDB associated with this PACKET command
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
@@ -2352,25 +2356,25 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	Zero on success, non-zero on failure.
  */
-
-static unsigned int atapi_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 {
-	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
 	int using_pio = (dev->flags & ATA_DFLAG_PIO);
-	int nodata = (cmd->sc_data_direction == DMA_NONE);
+	int nodata = (scmd->sc_data_direction == DMA_NONE);
 
 	if (!using_pio)
 		/* Check whether ATAPI DMA is safe */
 		if (ata_check_atapi_dma(qc))
 			using_pio = 1;
 
-	memcpy(&qc->cdb, scsicmd, dev->cdb_len);
+	memset(qc->cdb, 0, dev->cdb_len);
+	memcpy(qc->cdb, scmd->cmnd, scmd->cmd_len);
 
 	qc->complete_fn = atapi_qc_complete;
 
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;
 		DPRINTK("direction: write\n");
 	}
@@ -2392,12 +2396,12 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 
-		if (atapi_dmadir && (cmd->sc_data_direction != DMA_TO_DEVICE))
+		if (atapi_dmadir && (scmd->sc_data_direction != DMA_TO_DEVICE))
 			/* some SATA bridges need us to indicate data xfer direction */
 			qc->tf.feature |= ATAPI_DMADIR;
 	}
 
-	qc->nbytes = cmd->request_bufflen;
+	qc->nbytes = scmd->request_bufflen;
 
 	return 0;
 }
@@ -2517,28 +2521,27 @@ ata_scsi_map_proto(u8 byte1)
 /**
  *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
  *	@qc: command structure to be initialized
- *	@scsicmd: SCSI command to convert
  *
  *	Handles either 12 or 16-byte versions of the CDB.
  *
  *	RETURNS:
  *	Zero on success, non-zero on failure.
  */
-static unsigned int
-ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &(qc->tf);
-	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
+	const u8 *cdb = scmd->cmnd;
 
-	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN)
+	if ((tf->protocol = ata_scsi_map_proto(cdb[1])) == ATA_PROT_UNKNOWN)
 		goto invalid_fld;
 
 	/* We may not issue DMA commands if no DMA mode is set */
 	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0)
 		goto invalid_fld;
 
-	if (scsicmd[1] & 0xe0)
+	if (cdb[1] & 0xe0)
 		/* PIO multi not supported yet */
 		goto invalid_fld;
 
@@ -2546,18 +2549,18 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	 * 12 and 16 byte CDBs use different offsets to
 	 * provide the various register values.
 	 */
-	if (scsicmd[0] == ATA_16) {
+	if (cdb[0] == ATA_16) {
 		/*
 		 * 16-byte CDB - may contain extended commands.
 		 *
 		 * If that is the case, copy the upper byte register values.
 		 */
-		if (scsicmd[1] & 0x01) {
-			tf->hob_feature = scsicmd[3];
-			tf->hob_nsect = scsicmd[5];
-			tf->hob_lbal = scsicmd[7];
-			tf->hob_lbam = scsicmd[9];
-			tf->hob_lbah = scsicmd[11];
+		if (cdb[1] & 0x01) {
+			tf->hob_feature = cdb[3];
+			tf->hob_nsect = cdb[5];
+			tf->hob_lbal = cdb[7];
+			tf->hob_lbam = cdb[9];
+			tf->hob_lbah = cdb[11];
 			tf->flags |= ATA_TFLAG_LBA48;
 		} else
 			tf->flags &= ~ATA_TFLAG_LBA48;
@@ -2565,26 +2568,26 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 		/*
 		 * Always copy low byte, device and command registers.
 		 */
-		tf->feature = scsicmd[4];
-		tf->nsect = scsicmd[6];
-		tf->lbal = scsicmd[8];
-		tf->lbam = scsicmd[10];
-		tf->lbah = scsicmd[12];
-		tf->device = scsicmd[13];
-		tf->command = scsicmd[14];
+		tf->feature = cdb[4];
+		tf->nsect = cdb[6];
+		tf->lbal = cdb[8];
+		tf->lbam = cdb[10];
+		tf->lbah = cdb[12];
+		tf->device = cdb[13];
+		tf->command = cdb[14];
 	} else {
 		/*
 		 * 12-byte CDB - incapable of extended commands.
 		 */
 		tf->flags &= ~ATA_TFLAG_LBA48;
 
-		tf->feature = scsicmd[3];
-		tf->nsect = scsicmd[4];
-		tf->lbal = scsicmd[5];
-		tf->lbam = scsicmd[6];
-		tf->lbah = scsicmd[7];
-		tf->device = scsicmd[8];
-		tf->command = scsicmd[9];
+		tf->feature = cdb[3];
+		tf->nsect = cdb[4];
+		tf->lbal = cdb[5];
+		tf->lbam = cdb[6];
+		tf->lbah = cdb[7];
+		tf->device = cdb[8];
+		tf->command = cdb[9];
 	}
 	/*
 	 * If slave is possible, enforce correct master/slave bit
@@ -2611,7 +2614,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	 */
 	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE);
 
-	if (cmd->sc_data_direction == DMA_TO_DEVICE)
+	if (scmd->sc_data_direction == DMA_TO_DEVICE)
 		tf->flags |= ATA_TFLAG_WRITE;
 
 	/*
@@ -2620,7 +2623,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	 * TODO: find out if we need to do more here to
 	 *       cover scatter/gather case.
 	 */
-	qc->nsect = cmd->request_bufflen / ATA_SECT_SIZE;
+	qc->nsect = scmd->request_bufflen / ATA_SECT_SIZE;
 
 	/* request result TF */
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
@@ -2628,7 +2631,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	return 0;
 
  invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x00);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x00);
 	/* "Invalid field in cdb" */
 	return 1;
 }
@@ -2701,22 +2704,29 @@ static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 #endif
 }
 
-static inline int __ata_scsi_queuecmd(struct scsi_cmnd *cmd,
+static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 				      void (*done)(struct scsi_cmnd *),
 				      struct ata_device *dev)
 {
 	int rc = 0;
 
+	if (unlikely(!scmd->cmd_len)) {
+		ata_dev_printk(dev, KERN_WARNING, "WARNING: zero len CDB\n");
+		scmd->result = DID_ERROR << 16;
+		done(scmd);
+		return 0;
+	}
+
 	if (dev->class == ATA_DEV_ATA) {
 		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
-							      cmd->cmnd[0]);
+							      scmd->cmnd[0]);
 
 		if (xlat_func)
-			rc = ata_scsi_translate(dev, cmd, done, xlat_func);
+			rc = ata_scsi_translate(dev, scmd, done, xlat_func);
 		else
-			ata_scsi_simulate(dev, cmd, done);
+			ata_scsi_simulate(dev, scmd, done);
 	} else
-		rc = ata_scsi_translate(dev, cmd, done, atapi_xlat);
+		rc = ata_scsi_translate(dev, scmd, done, atapi_xlat);
 
 	return rc;
 }
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 1c62801..b1ca207 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -372,7 +372,8 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 static int cs5530_reinit_one(struct pci_dev *pdev)
 {
 	/* If we fail on resume we are doomed */
-	BUG_ON(cs5530_init_chip());
+	if (cs5530_init_chip())
+		BUG();
 	return ata_pci_device_resume(pdev);
 }
 	
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index ff93e8f..f0d4f7e 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -395,7 +395,7 @@ static void via_config_fifo(struct pci_dev *pdev, unsigned int flags)
 	enable &= 3;
 	
 	if (flags & VIA_SET_FIFO) {
-		u8 fifo_setting[4] = {0x00, 0x60, 0x00, 0x20};
+		static const u8 fifo_setting[4] = {0x00, 0x60, 0x00, 0x20};
 		u8 fifo;
 
 		pci_read_config_byte(pdev, 0x43, &fifo);
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 0d316eb..f6d498e 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -270,14 +270,6 @@ static const struct pci_device_id nv_pci_tbl[] = {
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA), GENERIC },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2), GENERIC },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), GENERIC },
-	{ PCI_VDEVICE(NVIDIA, 0x045c), GENERIC }, /* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045d), GENERIC }, /* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045e), GENERIC }, /* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045f), GENERIC }, /* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x0550), GENERIC }, /* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0551), GENERIC }, /* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0552), GENERIC }, /* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0553), GENERIC }, /* MCP67 */
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index d89c959..46d8a94 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -135,26 +135,31 @@ static void k2_sata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
 	if (tf->ctl != ap->last_ctl) {
-		writeb(tf->ctl, ioaddr->ctl_addr);
+		writeb(tf->ctl, (void __iomem *) ioaddr->ctl_addr);
 		ap->last_ctl = tf->ctl;
 		ata_wait_idle(ap);
 	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
-		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
-		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
-		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
-		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
+		writew(tf->feature | (((u16)tf->hob_feature) << 8),
+		       (void __iomem *) ioaddr->feature_addr);
+		writew(tf->nsect | (((u16)tf->hob_nsect) << 8),
+		       (void __iomem *) ioaddr->nsect_addr);
+		writew(tf->lbal | (((u16)tf->hob_lbal) << 8),
+		       (void __iomem *) ioaddr->lbal_addr);
+		writew(tf->lbam | (((u16)tf->hob_lbam) << 8),
+		       (void __iomem *) ioaddr->lbam_addr);
+		writew(tf->lbah | (((u16)tf->hob_lbah) << 8),
+		       (void __iomem *) ioaddr->lbah_addr);
 	} else if (is_addr) {
-		writew(tf->feature, ioaddr->feature_addr);
-		writew(tf->nsect, ioaddr->nsect_addr);
-		writew(tf->lbal, ioaddr->lbal_addr);
-		writew(tf->lbam, ioaddr->lbam_addr);
-		writew(tf->lbah, ioaddr->lbah_addr);
+		writew(tf->feature, (void __iomem *) ioaddr->feature_addr);
+		writew(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
+		writew(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
+		writew(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
+		writew(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE)
-		writeb(tf->device, ioaddr->device_addr);
+		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
 
 	ata_wait_idle(ap);
 }
@@ -166,12 +171,12 @@ static void k2_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 	u16 nsect, lbal, lbam, lbah, feature;
 
 	tf->command = k2_stat_check_status(ap);
-	tf->device = readw(ioaddr->device_addr);
-	feature = readw(ioaddr->error_addr);
-	nsect = readw(ioaddr->nsect_addr);
-	lbal = readw(ioaddr->lbal_addr);
-	lbam = readw(ioaddr->lbam_addr);
-	lbah = readw(ioaddr->lbah_addr);
+	tf->device = readw((void __iomem *)ioaddr->device_addr);
+	feature = readw((void __iomem *)ioaddr->error_addr);
+	nsect = readw((void __iomem *)ioaddr->nsect_addr);
+	lbal = readw((void __iomem *)ioaddr->lbal_addr);
+	lbam = readw((void __iomem *)ioaddr->lbam_addr);
+	lbah = readw((void __iomem *)ioaddr->lbah_addr);
 
 	tf->feature = feature;
 	tf->nsect = nsect;
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index e654b99..0fa1b89 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -149,21 +149,26 @@ static void vsc_sata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
 	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
-		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
-		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
-		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
-		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
+		writew(tf->feature | (((u16)tf->hob_feature) << 8),
+		       (void __iomem *) ioaddr->feature_addr);
+		writew(tf->nsect | (((u16)tf->hob_nsect) << 8),
+		       (void __iomem *) ioaddr->nsect_addr);
+		writew(tf->lbal | (((u16)tf->hob_lbal) << 8),
+		       (void __iomem *) ioaddr->lbal_addr);
+		writew(tf->lbam | (((u16)tf->hob_lbam) << 8),
+		       (void __iomem *) ioaddr->lbam_addr);
+		writew(tf->lbah | (((u16)tf->hob_lbah) << 8),
+		       (void __iomem *) ioaddr->lbah_addr);
 	} else if (is_addr) {
-		writew(tf->feature, ioaddr->feature_addr);
-		writew(tf->nsect, ioaddr->nsect_addr);
-		writew(tf->lbal, ioaddr->lbal_addr);
-		writew(tf->lbam, ioaddr->lbam_addr);
-		writew(tf->lbah, ioaddr->lbah_addr);
+		writew(tf->feature, (void __iomem *) ioaddr->feature_addr);
+		writew(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
+		writew(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
+		writew(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
+		writew(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE)
-		writeb(tf->device, ioaddr->device_addr);
+		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
 
 	ata_wait_idle(ap);
 }
@@ -175,12 +180,12 @@ static void vsc_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 	u16 nsect, lbal, lbam, lbah, feature;
 
 	tf->command = ata_check_status(ap);
-	tf->device = readw(ioaddr->device_addr);
-	feature = readw(ioaddr->error_addr);
-	nsect = readw(ioaddr->nsect_addr);
-	lbal = readw(ioaddr->lbal_addr);
-	lbam = readw(ioaddr->lbam_addr);
-	lbah = readw(ioaddr->lbah_addr);
+	tf->device = readw((void __iomem *) ioaddr->device_addr);
+	feature = readw((void __iomem *) ioaddr->error_addr);
+	nsect = readw((void __iomem *) ioaddr->nsect_addr);
+	lbal = readw((void __iomem *) ioaddr->lbal_addr);
+	lbam = readw((void __iomem *) ioaddr->lbam_addr);
+	lbah = readw((void __iomem *) ioaddr->lbah_addr);
 
 	tf->feature = feature;
 	tf->nsect = nsect;
@@ -327,8 +332,8 @@ static void __devinit vsc_sata_setup_port(struct ata_ioports *port, unsigned lon
 	port->ctl_addr		= base + VSC_SATA_TF_CTL_OFFSET;
 	port->bmdma_addr	= base + VSC_SATA_DMA_CMD_OFFSET;
 	port->scr_addr		= base + VSC_SATA_SCR_STATUS_OFFSET;
-	writel(0, base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
-	writel(0, base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
+	writel(0, (void __iomem *) base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
+	writel(0, (void __iomem *) base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
 }
 
 
