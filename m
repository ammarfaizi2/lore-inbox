Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVCSSrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVCSSrm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 13:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVCSSrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 13:47:41 -0500
Received: from gelf.bodgit-n-scarper.com ([81.5.167.74]:25321 "EHLO
	mail.bodgit-n-scarper.com") by vger.kernel.org with ESMTP
	id S262590AbVCSSra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 13:47:30 -0500
Subject: Building Areca arcmsr driver outside kernel source tree
From: Matt Dainty <matt@bodgit-n-scarper.com>
To: linux-kernel@vger.kernel.org, Erich Chen <erich@areca.com.tw>
Content-Type: multipart/mixed; boundary="=-XNRVdGkDYpZSBVrvsQag"
Message-Id: <1111258047.3746.45.camel@lister.bodgit-n-scarper.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 19 Mar 2005 18:47:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XNRVdGkDYpZSBVrvsQag
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

To get the arcmsr driver working with CentOS/RHEL 4 and using the
facility to build kernel modules outside of the kernel source tree, I
found the attached patch was necessary to remove the dependencies on the
internal drivers/scsi/scsi*.h header files and to instead use the public
ones found under include/scsi/ which are provided by the kernel-*-devel
packages.

It builds, loads and appears to work with my limited testing on an
ARC1120. I was just wanting to know if this was the right way to fix it?
Once the driver is in the main kernel tree it's largely irrelevant, but
while CentOS/RHEL 4 use the older kernel without the driver it's a PITA
to maintain kernel packages with this one driver added, when a separate
package containing just the driver is much easier.

The patch is based on the 1.20.00.06 driver that was added to
2.6.11-mm4.

Thanks

Matt

--=-XNRVdGkDYpZSBVrvsQag
Content-Disposition: attachment; filename=areca.patch
Content-Type: text/x-patch; name=areca.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.9/drivers/scsi/arcmsr/arcmsr.c.orig	2005-03-19 17:50:52.623490488 +0000
+++ linux-2.6.9/drivers/scsi/arcmsr/arcmsr.c	2005-03-19 18:03:11.484166592 +0000
@@ -108,7 +108,9 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <scsi/scsi_host.h>
-#include "../scsi.h"
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
 #include "arcmsr.h"
 #endif
 /*
@@ -138,10 +140,11 @@
 			     struct block_device *bdev, sector_t capacity,
 			     int *info);
 static int arcmsr_release(struct Scsi_Host *);
-static int arcmsr_queue_command(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *));
-static int arcmsr_cmd_abort(Scsi_Cmnd *);
-static int arcmsr_bus_reset(Scsi_Cmnd *);
-static int arcmsr_ioctl(Scsi_Device * dev, int ioctl_cmd, void *arg);
+static int arcmsr_queue_command(struct scsi_cmnd * cmd,
+				void (*done) (struct scsi_cmnd *));
+static int arcmsr_cmd_abort(struct scsi_cmnd *);
+static int arcmsr_bus_reset(struct scsi_cmnd *);
+static int arcmsr_ioctl(struct scsi_device * dev, int ioctl_cmd, void *arg);
 static int __devinit arcmsr_device_probe(struct pci_dev *pPCI_DEV,
 					 const struct pci_device_id *id);
 static void arcmsr_device_remove(struct pci_dev *pPCI_DEV);
@@ -152,7 +155,7 @@
 static u_int8_t arcmsr_wait_msgint_ready(PACB pACB);
 static const char *arcmsr_info(struct Scsi_Host *);
 
-static Scsi_Host_Template arcmsr_scsi_host_template = {
+static struct scsi_host_template arcmsr_scsi_host_template = {
 	.module = THIS_MODULE,
 	.proc_name = "arcmsr",
 	.proc_info = arcmsr_proc_info,
@@ -417,7 +420,7 @@
 ************************************************************************
 ************************************************************************
 */
-static int arcmsr_scsi_host_template_init(Scsi_Host_Template * psht)
+static int arcmsr_scsi_host_template_init(struct scsi_host_template * psht)
 {
 	psht->proc_name = "arcmsr";
 	memset(pHCBARC, 0, sizeof(struct _HCBARC));
@@ -459,19 +462,19 @@
 static void arcmsr_pci_unmap_dma(PCCB pCCB)
 {
 	PACB pACB = pCCB->pACB;
-	Scsi_Cmnd *pcmd = pCCB->pcmd;
+	struct scsi_cmnd *pcmd = pCCB->pcmd;
 
 	if (pcmd->use_sg != 0) {
 		struct scatterlist *sl;
 
 		sl = (struct scatterlist *)pcmd->request_buffer;
 		pci_unmap_sg(pACB->pPCI_DEV, sl, pcmd->use_sg,
-			     scsi_to_pci_dma_dir(pcmd->sc_data_direction));
+			     pcmd->sc_data_direction);
 	} else if (pcmd->request_bufflen != 0) {
 		pci_unmap_single(pACB->pPCI_DEV,
 				 (dma_addr_t) (unsigned long)pcmd->SCp.ptr,
 				 pcmd->request_bufflen,
-				 scsi_to_pci_dma_dir(pcmd->sc_data_direction));
+				 pcmd->sc_data_direction);
 	}
 	return;
 }
@@ -575,7 +578,7 @@
 **
 **********************************************************************
 */
-static void arcmsr_cmd_done(Scsi_Cmnd * pcmd)
+static void arcmsr_cmd_done(struct scsi_cmnd * pcmd)
 {
 	pcmd->scsi_done(pcmd);
 	return;
@@ -608,7 +611,7 @@
 {
 	unsigned long flag;
 	PACB pACB = pCCB->pACB;
-	Scsi_Cmnd *pcmd = pCCB->pcmd;
+	struct scsi_cmnd *pcmd = pCCB->pcmd;
 
 #if ARCMSR_DEBUG0
 	printk
@@ -635,7 +638,7 @@
 */
 static void arcmsr_report_SenseInfoBuffer(PCCB pCCB)
 {
-	Scsi_Cmnd *pcmd = pCCB->pcmd;
+	struct scsi_cmnd *pcmd = pCCB->pcmd;
 	PSENSE_DATA psenseBuffer = (PSENSE_DATA) pcmd->sense_buffer;
 #if ARCMSR_DEBUG0
 	printk("arcmsr_report_SenseInfoBuffer...........\n");
@@ -804,7 +807,7 @@
 ** PAGE_SIZE=4096 or 8192,PAGE_SHIFT=12
 **********************************************************************
 */
-static void arcmsr_build_ccb(PACB pACB, PCCB pCCB, Scsi_Cmnd * pcmd)
+static void arcmsr_build_ccb(PACB pACB, PCCB pCCB, struct scsi_cmnd * pcmd)
 {
 	PARCMSR_CDB pARCMSR_CDB = (PARCMSR_CDB) & pCCB->arcmsr_cdb;
 	int8_t *psge = (int8_t *) & pARCMSR_CDB->u;
@@ -831,7 +834,7 @@
 		sl = (struct scatterlist *)pcmd->request_buffer;
 		sgcount =
 		    pci_map_sg(pACB->pPCI_DEV, sl, pcmd->use_sg,
-			       scsi_to_pci_dma_dir(pcmd->sc_data_direction));
+			       pcmd->sc_data_direction);
 		/* map stor port SG list to our iop SG List. */
 		for (i = 0; i < sgcount; i++) {
 			/* Get the physical address of the current data pointer */
@@ -902,8 +905,7 @@
 		dma_addr =
 		    pci_map_single(pACB->pPCI_DEV, pcmd->request_buffer,
 				   pcmd->request_bufflen,
-				   scsi_to_pci_dma_dir(pcmd->
-						       sc_data_direction));
+				   pcmd->sc_data_direction);
 		pcmd->SCp.ptr = (char *)(unsigned long)dma_addr;
 		address_lo = cpu_to_le32(dma_addr_lo32(dma_addr));
 		address_hi = cpu_to_le32(dma_addr_hi32(dma_addr));
@@ -1651,7 +1653,7 @@
 **
 ************************************************************************
 */
-static int arcmsr_ioctl(Scsi_Device * dev, int ioctl_cmd, void *arg)
+static int arcmsr_ioctl(struct scsi_device * dev, int ioctl_cmd, void *arg)
 {
 	PACB pACB;
 	int32_t match = 0x55AA, i;
@@ -1855,7 +1857,8 @@
 **} Scsi_Pointer;
 ***********************************************************************
 */
-static int arcmsr_queue_command(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
+static int arcmsr_queue_command(struct scsi_cmnd * cmd,
+				void (*done) (struct scsi_cmnd *))
 {
 	struct Scsi_Host *host = cmd->device->host;
 	PACB pACB = (PACB) host->hostdata;
@@ -1966,7 +1969,7 @@
 **
 ****************************************************************************
 */
-static int arcmsr_bus_reset(Scsi_Cmnd * cmd)
+static int arcmsr_bus_reset(struct scsi_cmnd * cmd)
 {
 	PACB pACB;
 
@@ -1983,7 +1986,7 @@
 **
 *****************************************************************************************
 */
-static int arcmsr_seek_cmd2abort(Scsi_Cmnd * pabortcmd)
+static int arcmsr_seek_cmd2abort(struct scsi_cmnd * pabortcmd)
 {
 	PACB pACB = (PACB) pabortcmd->device->host->hostdata;
 	PCCB pCCB;
@@ -2068,7 +2071,7 @@
 **
 *****************************************************************************************
 */
-static int arcmsr_cmd_abort(Scsi_Cmnd * cmd)
+static int arcmsr_cmd_abort(struct scsi_cmnd * cmd)
 {
 	int error;
 
--- linux-2.6.9/drivers/scsi/arcmsr/arcmsr.h.orig	2005-03-19 17:55:45.642944760 +0000
+++ linux-2.6.9/drivers/scsi/arcmsr/arcmsr.h	2005-03-19 17:55:57.857087928 +0000
@@ -647,7 +647,7 @@
 	uint32_t reserved1;	/* 508-511 */
 	/*  ======================512+32 bytes========================  */
 #if BITS_PER_LONG == 64
-	Scsi_Cmnd *pcmd;	/* 512-515 516-519 pointer of linux scsi command */
+	struct scsi_cmnd *pcmd;	/* 512-515 516-519 pointer of linux scsi command */
 	struct _ACB *pACB;	/* 520-523 524-527 */
 
 	uint16_t ccb_flags;	/* 528-529 */
@@ -663,7 +663,7 @@
 #define		ARCMSR_CCB_ILLEGAL	        0xFFFF
 	uint32_t reserved2[3];	/* 532-535 536-539 540-543 */
 #else
-	Scsi_Cmnd *pcmd;	/* 512-515 pointer of linux scsi command */
+	struct scsi_cmnd *pcmd;	/* 512-515 pointer of linux scsi command */
 	struct _ACB *pACB;	/* 516-519 */
 
 	uint16_t ccb_flags;	/* 520-521 */

--=-XNRVdGkDYpZSBVrvsQag--

