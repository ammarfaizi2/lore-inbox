Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVB0Pt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVB0Pt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 10:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVB0Pt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 10:49:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25361 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261420AbVB0PsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:48:13 -0500
Date: Sun, 27 Feb 2005 16:48:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Erich Chen <erich@areca.com.tw>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: [2.6.11-rc4-mm1 patch] drivers/scsi/arcmsr/arcmsr.c cleanups
Message-ID: <20050227154810.GA6148@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 01:42:33AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc3-mm1:
>...
> +areca-raid-linux-scsi-driver-fix.patch
> 
>  New RAID driver (this patch is having a hard life and needs a re-review)
>...


This patch contains the following cleanups:
- make needlessly global functions static
- move arcmsr_scsi_host_template from arcmsr.h to arcmsr.c
  (code doesn't belong into header files)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Some notes:
- BOOLEAN/TRUE/FALSE, own get_min/get_max aren't kernel coding style
- the own subdirectory for this driver seems to be overkill
- aren't the "if defined(__x86_64__)" wrong for other 64bit
  architectures?

 drivers/scsi/arcmsr/arcmsr.c |  110 +++++++++++++++++++++++------------
 drivers/scsi/arcmsr/arcmsr.h |   34 ----------
 2 files changed, 73 insertions(+), 71 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/arcmsr/arcmsr.h.old	2005-02-27 16:06:56.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/arcmsr/arcmsr.h	2005-02-27 16:06:25.000000000 +0100
@@ -4802,38 +4802,4 @@
 **        (E) Checksum : checksum of length and status or data byte
 **************************************************************************
 */
-extern int arcmsr_proc_info(struct Scsi_Host *host, char *buffer, char **start,
-			    off_t offset, int length, int inout);
-extern int arcmsr_bios_param(struct scsi_device *sdev,
-			     struct block_device *bdev, sector_t capacity,
-			     int *info);
-extern int arcmsr_release(struct Scsi_Host *);
-extern int arcmsr_queue_command(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *));
-extern int arcmsr_cmd_abort(Scsi_Cmnd *);
-extern int arcmsr_bus_reset(Scsi_Cmnd *);
-extern int arcmsr_ioctl(Scsi_Device * dev, int ioctl_cmd, void *arg);
-extern const char *arcmsr_info(struct Scsi_Host *);
 
-static Scsi_Host_Template arcmsr_scsi_host_template = {
-	.module = THIS_MODULE,
-	.proc_name = "arcmsr",
-	.proc_info = arcmsr_proc_info,
-	.name = "ARCMSR ARECA SATA RAID HOST Adapter" ARCMSR_DRIVER_VERSION,	/* *name */
-	.release = arcmsr_release,
-	.info = arcmsr_info,
-	.ioctl = arcmsr_ioctl,
-	.queuecommand = arcmsr_queue_command,
-	.eh_strategy_handler = NULL,
-	.eh_abort_handler = arcmsr_cmd_abort,
-	.eh_device_reset_handler = NULL,
-	.eh_bus_reset_handler = arcmsr_bus_reset,
-	.eh_host_reset_handler = NULL,
-	.bios_param = arcmsr_bios_param,
-	.can_queue = ARCMSR_MAX_OUTSTANDING_CMD,
-	.this_id = ARCMSR_SCSI_INITIATOR_ID,
-	.sg_tablesize = ARCMSR_MAX_SG_ENTRIES,
-	.max_sectors = ARCMSR_MAX_XFER_SECTORS,
-	.cmd_per_lun = ARCMSR_MAX_CMD_PERLUN,
-	.unchecked_isa_dma = 0,
-	.use_clustering = DISABLE_CLUSTERING,
-};
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/arcmsr/arcmsr.c.old	2005-02-27 16:06:52.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/arcmsr/arcmsr.c	2005-02-27 16:06:25.000000000 +0100
@@ -121,15 +121,26 @@
 static int arcmsr_halt_notify(struct notifier_block *nb, unsigned long event,
 			      void *buf);
 static void arcmsr_free_pci_pool(PACB pACB);
-void arcmsr_pcidev_disattach(PACB pACB);
-BOOLEAN arcmsr_wait_msgint_ready(PACB pACB);
-void arcmsr_iop_init(PACB pACB);
-int arcmsr_iop_ioctlcmd(PACB pACB, int ioctl_cmd, void *arg);
-int arcmsr_initialize(PACB pACB, struct pci_dev *pPCI_DEV);
+static void arcmsr_pcidev_disattach(PACB pACB);
+static void arcmsr_iop_init(PACB pACB);
+static int arcmsr_iop_ioctlcmd(PACB pACB, int ioctl_cmd, void *arg);
+static int arcmsr_initialize(PACB pACB, struct pci_dev *pPCI_DEV);
 static irqreturn_t arcmsr_HwInterrupt(PACB pACB);
 static int arcmsr_device_probe(struct pci_dev *pPCI_DEV,
 			       const struct pci_device_id *id);
 static void arcmsr_device_remove(struct pci_dev *pPCI_DEV);
+static int arcmsr_bios_param(struct scsi_device *sdev,
+			     struct block_device *bdev,
+			     sector_t capacity, int *geom);
+static int arcmsr_bus_reset(Scsi_Cmnd * cmd);
+static int arcmsr_cmd_abort(Scsi_Cmnd * cmd);
+static const char *arcmsr_info(struct Scsi_Host *host);
+static int arcmsr_ioctl(Scsi_Device * dev, int ioctl_cmd, void *arg);
+static int arcmsr_proc_info(struct Scsi_Host *host, char *buffer, char **start,
+			    off_t offset, int length, int inout);
+static int arcmsr_queue_command(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *));
+static int arcmsr_release(struct Scsi_Host *host);
+
 /*
 **********************************************************************************
 **
@@ -169,13 +180,37 @@
 };
 
 MODULE_DEVICE_TABLE(pci, arcmsr_device_id_table);
-struct pci_driver arcmsr_pci_driver = {
+static struct pci_driver arcmsr_pci_driver = {
 	.name = "arcmsr",
 	.id_table = arcmsr_device_id_table,
 	.probe = arcmsr_device_probe,
 	.remove = arcmsr_device_remove,
 };
 
+static Scsi_Host_Template arcmsr_scsi_host_template = {
+	.module = THIS_MODULE,
+	.proc_name = "arcmsr",
+	.proc_info = arcmsr_proc_info,
+	.name = "ARCMSR ARECA SATA RAID HOST Adapter" ARCMSR_DRIVER_VERSION,	/* *name */
+	.release = arcmsr_release,
+	.info = arcmsr_info,
+	.ioctl = arcmsr_ioctl,
+	.queuecommand = arcmsr_queue_command,
+	.eh_strategy_handler = NULL,
+	.eh_abort_handler = arcmsr_cmd_abort,
+	.eh_device_reset_handler = NULL,
+	.eh_bus_reset_handler = arcmsr_bus_reset,
+	.eh_host_reset_handler = NULL,
+	.bios_param = arcmsr_bios_param,
+	.can_queue = ARCMSR_MAX_OUTSTANDING_CMD,
+	.this_id = ARCMSR_SCSI_INITIATOR_ID,
+	.sg_tablesize = ARCMSR_MAX_SG_ENTRIES,
+	.max_sectors = ARCMSR_MAX_XFER_SECTORS,
+	.cmd_per_lun = ARCMSR_MAX_CMD_PERLUN,
+	.unchecked_isa_dma = 0,
+	.use_clustering = DISABLE_CLUSTERING,
+};
+
 /*
 *********************************************************************
 *********************************************************************
@@ -213,8 +248,9 @@
 *********************************************************************
 *********************************************************************
 */
-int arcmsr_bios_param(struct scsi_device *sdev, struct block_device *bdev,
-		      sector_t capacity, int *geom)
+static int arcmsr_bios_param(struct scsi_device *sdev,
+			     struct block_device *bdev,
+			     sector_t capacity, int *geom)
 {
 	int heads, sectors, cylinders, total_capacity;
 
@@ -409,7 +445,7 @@
 **
 **********************************************************************
 */
-void arcmsr_pci_unmap_dma(PCCB pCCB)
+static void arcmsr_pci_unmap_dma(PCCB pCCB)
 {
 	PACB pACB = pCCB->pACB;
 	Scsi_Cmnd *pcmd = pCCB->pcmd;
@@ -528,7 +564,7 @@
 **
 **********************************************************************
 */
-void arcmsr_cmd_done(Scsi_Cmnd * pcmd)
+static void arcmsr_cmd_done(Scsi_Cmnd * pcmd)
 {
 	pcmd->scsi_done(pcmd);
 	return;
@@ -540,7 +576,7 @@
 **
 ************************************************************************
 */
-void arcmsr_flush_adapter_cache(PACB pACB)
+static void arcmsr_flush_adapter_cache(PACB pACB)
 {
 #if ARCMSR_DEBUG0
 	printk("arcmsr_flush_adapter_cache..............\n");
@@ -557,7 +593,7 @@
 **
 **********************************************************************
 */
-void arcmsr_ccb_complete(PCCB pCCB)
+static void arcmsr_ccb_complete(PCCB pCCB)
 {
 	unsigned long flag;
 	PACB pACB = pCCB->pACB;
@@ -586,7 +622,7 @@
 **       if scsi error do auto request sense
 **********************************************************************
 */
-void arcmsr_report_SenseInfoBuffer(PCCB pCCB)
+static void arcmsr_report_SenseInfoBuffer(PCCB pCCB)
 {
 	Scsi_Cmnd *pcmd = pCCB->pcmd;
 	PSENSE_DATA psenseBuffer = (PSENSE_DATA) pcmd->sense_buffer;
@@ -611,7 +647,7 @@
 ** to insert pCCB into tail of pACB wait exec ccbQ
 *********************************************************************
 */
-void arcmsr_queue_wait2go_ccb(PACB pACB, PCCB pCCB)
+static void arcmsr_queue_wait2go_ccb(PACB pACB, PCCB pCCB)
 {
 	unsigned long flag;
 	int i = 0;
@@ -639,7 +675,7 @@
 **
 *********************************************************************
 */
-void arcmsr_abort_allcmd(PACB pACB)
+static void arcmsr_abort_allcmd(PACB pACB)
 {
 	CHIP_REG_WRITE32(&pACB->pmu->inbound_msgaddr0,
 			 ARCMSR_INBOUND_MESG0_ABORT_CMD);
@@ -653,7 +689,7 @@
 **
 **********************************************************************
 */
-BOOLEAN arcmsr_wait_msgint_ready(PACB pACB)
+static BOOLEAN arcmsr_wait_msgint_ready(PACB pACB)
 {
 	uint32_t Index;
 	uint8_t Retries = 0x00;
@@ -678,7 +714,7 @@
 **        Return Value: Nothing.
 ****************************************************************************
 */
-void arcmsr_iop_reset(PACB pACB)
+static void arcmsr_iop_reset(PACB pACB)
 {
 	PCCB pCCB;
 	uint32_t intmask_org, mask;
@@ -760,7 +796,7 @@
 ** PAGE_SIZE=4096 or 8192,PAGE_SHIFT=12
 **********************************************************************
 */
-void arcmsr_build_ccb(PACB pACB, PCCB pCCB, Scsi_Cmnd * pcmd)
+static void arcmsr_build_ccb(PACB pACB, PCCB pCCB, Scsi_Cmnd * pcmd)
 {
 	PARCMSR_CDB pARCMSR_CDB = (PARCMSR_CDB) & pCCB->arcmsr_cdb;
 	int8_t *psge = (int8_t *) & pARCMSR_CDB->u;
@@ -931,7 +967,7 @@
 **
 **************************************************************************
 */
-void arcmsr_post_wait2go_ccb(PACB pACB)
+static void arcmsr_post_wait2go_ccb(PACB pACB)
 {
 	unsigned long flag;
 	PCCB pCCB;
@@ -965,7 +1001,7 @@
 **     Output:
 **********************************************************************
 */
-void arcmsr_post_Qbuffer(PACB pACB)
+static void arcmsr_post_Qbuffer(PACB pACB)
 {
 	uint8_t *pQbuffer;
 	PQBUFFER pwbuffer = (PQBUFFER) & pACB->pmu->ioctl_wbuffer;
@@ -996,7 +1032,7 @@
 **
 ************************************************************************
 */
-void arcmsr_stop_adapter_bgrb(PACB pACB)
+static void arcmsr_stop_adapter_bgrb(PACB pACB)
 {
 #if ARCMSR_DEBUG0
 	printk("arcmsr_stop_adapter_bgrb..............\n");
@@ -1271,7 +1307,7 @@
 **
 ************************************************************************
 */
-int arcmsr_iop_ioctlcmd(PACB pACB, int ioctl_cmd, void *arg)
+static int arcmsr_iop_ioctlcmd(PACB pACB, int ioctl_cmd, void *arg)
 {
 	CMD_IOCTL_FIELD cmdioctlfld;
 	PCMD_IOCTL_FIELD pcmdioctlfld = &cmdioctlfld;
@@ -1617,7 +1653,7 @@
 **
 ************************************************************************
 */
-int arcmsr_ioctl(Scsi_Device * dev, int ioctl_cmd, void *arg)
+static int arcmsr_ioctl(Scsi_Device * dev, int ioctl_cmd, void *arg)
 {
 	PACB pACB;
 	int32_t match = 0x55AA, i;
@@ -1649,7 +1685,7 @@
 **
 **************************************************************************
 */
-PCCB arcmsr_get_freeccb(PACB pACB)
+static PCCB arcmsr_get_freeccb(PACB pACB)
 {
 	PCCB pCCB;
 	unsigned long flag;
@@ -1821,7 +1857,7 @@
 **} Scsi_Pointer;
 ***********************************************************************
 */
-int arcmsr_queue_command(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
+static int arcmsr_queue_command(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
 {
 	struct Scsi_Host *host = cmd->device->host;
 	PACB pACB = (PACB) host->hostdata;
@@ -1872,7 +1908,7 @@
 **
 **********************************************************************
 */
-void arcmsr_start_adapter_bgrb(PACB pACB)
+static void arcmsr_start_adapter_bgrb(PACB pACB)
 {
 #if ARCMSR_DEBUG0
 	printk
@@ -1892,7 +1928,7 @@
 **
 **********************************************************************
 */
-void arcmsr_iop_init(PACB pACB)
+static void arcmsr_iop_init(PACB pACB)
 {
 	uint32_t intmask_org, mask, outbound_doorbell, firmware_state = 0;
 
@@ -1932,7 +1968,7 @@
 **
 ****************************************************************************
 */
-int arcmsr_bus_reset(Scsi_Cmnd * cmd)
+static int arcmsr_bus_reset(Scsi_Cmnd * cmd)
 {
 	PACB pACB;
 
@@ -1949,7 +1985,7 @@
 **
 *****************************************************************************************
 */
-int arcmsr_seek_cmd2abort(Scsi_Cmnd * pabortcmd)
+static int arcmsr_seek_cmd2abort(Scsi_Cmnd * pabortcmd)
 {
 	PACB pACB = (PACB) pabortcmd->device->host->hostdata;
 	PCCB pCCB;
@@ -2048,7 +2084,7 @@
 **
 *****************************************************************************************
 */
-int arcmsr_cmd_abort(Scsi_Cmnd * cmd)
+static int arcmsr_cmd_abort(Scsi_Cmnd * cmd)
 {
 	int error;
 
@@ -2112,7 +2148,7 @@
 **
 *********************************************************************
 */
-const char *arcmsr_info(struct Scsi_Host *host)
+static const char *arcmsr_info(struct Scsi_Host *host)
 {
 	static char buf[256];
 	PACB pACB;
@@ -2212,7 +2248,7 @@
 **}
 ************************************************************************
 */
-int arcmsr_initialize(PACB pACB, struct pci_dev *pPCI_DEV)
+static int arcmsr_initialize(PACB pACB, struct pci_dev *pPCI_DEV)
 {
 	uint32_t intmask_org, page_base, page_offset, mem_base_start;
 	dma_addr_t dma_addr;
@@ -2339,7 +2375,7 @@
 *********************************************************************
 *********************************************************************
 */
-int arcmsr_set_info(char *buffer, int length)
+static int arcmsr_set_info(char *buffer, int length)
 {
 #if ARCMSR_DEBUG0
 	printk("arcmsr_set_info.............\n");
@@ -2352,7 +2388,7 @@
 **
 *********************************************************************
 */
-void arcmsr_pcidev_disattach(PACB pACB)
+static void arcmsr_pcidev_disattach(PACB pACB)
 {
 	PCCB pCCB;
 	uint32_t intmask_org, mask;
@@ -2489,8 +2525,8 @@
 if(YN) SPRINTF(" Yes ");\
 else SPRINTF(" No ")
 
-int arcmsr_proc_info(struct Scsi_Host *host, char *buffer, char **start,
-		     off_t offset, int length, int inout)
+static int arcmsr_proc_info(struct Scsi_Host *host, char *buffer, char **start,
+			    off_t offset, int length, int inout)
 {
 	uint8_t i;
 	char *pos = buffer;
@@ -2528,7 +2564,7 @@
 **
 ************************************************************************
 */
-int arcmsr_release(struct Scsi_Host *host)
+static int arcmsr_release(struct Scsi_Host *host)
 {
 	PACB pACB;
 	uint8_t match = 0xff, i;


