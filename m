Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263348AbVHFRya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbVHFRya (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbVHFRya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 13:54:30 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:31705 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263341AbVHFRxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 13:53:48 -0400
Subject: RE: As of 2.6.13-rc1 Fusion-MPT very slow
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508011537250.23481@praktifix.dwd.de>
References: <91888D455306F94EBD4D168954A9457C035CB64A@nacos172.co.lsil.com>
	 <Pine.LNX.4.61.0508011537250.23481@praktifix.dwd.de>
Content-Type: text/plain
Date: Sat, 06 Aug 2005 12:53:10 -0500
Message-Id: <1123350790.5092.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 15:40 +0000, Holger Kiehl wrote:
> No I did not get it. Can you please send it to me or tell me where I can
> download it?

OK, since this has stalled, how about trying a different approach.

If you apply the attached patch it will cause fusion to use the
transport class domain validation.  That should show us which parameters
are causing the problem and exactly what the negotiations said.  We can
also tell you how to tweak the parameters.

It should apply to any recent -mm (unless Andrew does a turn to pick up
the fusion module rework).

Thanks,

James

diff --git a/drivers/message/fusion/Kconfig b/drivers/message/fusion/Kconfig
--- a/drivers/message/fusion/Kconfig
+++ b/drivers/message/fusion/Kconfig
@@ -9,6 +9,7 @@ config FUSION_SPI
 	tristate "Fusion MPT ScsiHost drivers for SPI"
 	depends on PCI && SCSI
 	select FUSION
+	select SCSI_SPI_ATTRS
 	---help---
 	  SCSI HOST support for a parallel SCSI host adapters.
 
diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -149,8 +149,6 @@ int		mptscsih_ioc_reset(MPT_ADAPTER *ioc
 int		mptscsih_event_process(MPT_ADAPTER *ioc, EventNotificationReply_t *pEvReply);
 
 static void	mptscsih_initTarget(MPT_SCSI_HOST *hd, int bus_id, int target_id, u8 lun, char *data, int dlen);
-static void	mptscsih_setTargetNegoParms(MPT_SCSI_HOST *hd, VirtDevice *target, char byte56);
-static void	mptscsih_set_dvflags(MPT_SCSI_HOST *hd, SCSIIORequest_t *pReq);
 static void	mptscsih_setDevicePage1Flags (u8 width, u8 factor, u8 offset, int *requestedPtr, int *configurationPtr, u8 flags);
 static void	mptscsih_no_negotiate(MPT_SCSI_HOST *hd, int target_id);
 static int	mptscsih_writeSDP1(MPT_SCSI_HOST *hd, int portnum, int target, int flags);
@@ -955,8 +953,6 @@ mptscsih_remove(struct pci_dev *pdev)
 	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
 	struct Scsi_Host 	*host = ioc->sh;
 	MPT_SCSI_HOST		*hd;
-	int 		 	count;
-	unsigned long	 	flags;
 	int sz1;
 
 	if(!host)
@@ -2502,7 +2498,7 @@ mptscsih_ioc_reset(MPT_ADAPTER *ioc, int
 		/* 4. Renegotiate to all devices, if SCSI
 		 */
 		if (ioc->bus_type == SCSI) {
-			dnegoprintk(("writeSDP1: ALL_IDS USE_NVRAM\n"));
+			printk("writeSDP1: ALL_IDS USE_NVRAM\n");
 			mptscsih_writeSDP1(hd, 0, 0, MPT_SCSICFG_ALL_IDS | MPT_SCSICFG_USE_NVRAM);
 		}
 
@@ -2761,7 +2757,6 @@ mptscsih_initTarget(MPT_SCSI_HOST *hd, i
 					vdev->tflags |= MPT_TARGET_FLAGS_VALID_56;
 				}
 			}
-			mptscsih_setTargetNegoParms(hd, vdev, data_56);
 		} else {
 			/* Initial Inquiry may not request enough data bytes to
 			 * obtain byte 57.  DV will; if target doesn't return
@@ -2772,7 +2767,6 @@ mptscsih_initTarget(MPT_SCSI_HOST *hd, i
 				 */
 					data_56 = data[56];
 					vdev->tflags |= MPT_TARGET_FLAGS_VALID_56;
-					mptscsih_setTargetNegoParms(hd, vdev, data_56);
 				}
 			}
 		}
@@ -2781,225 +2775,6 @@ mptscsih_initTarget(MPT_SCSI_HOST *hd, i
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*
- *  Update the target negotiation parameters based on the
- *  the Inquiry data, adapter capabilities, and NVRAM settings.
- *
- */
-static void
-mptscsih_setTargetNegoParms(MPT_SCSI_HOST *hd, VirtDevice *target, char byte56)
-{
-	ScsiCfgData *pspi_data = &hd->ioc->spi_data;
-	int  id = (int) target->target_id;
-	int  nvram;
-	VirtDevice	*vdev;
-	int ii;
-	u8 width = MPT_NARROW;
-	u8 factor = MPT_ASYNC;
-	u8 offset = 0;
-	u8 version, nfactor;
-	u8 noQas = 1;
-
-	target->negoFlags = pspi_data->noQas;
-
-	/* noQas == 0 => device supports QAS. Need byte 56 of Inq to determine
-	 * support. If available, default QAS to off and allow enabling.
-	 * If not available, default QAS to on, turn off for non-disks.
-	 */
-
-	/* Set flags based on Inquiry data
-	 */
-	version = target->inq_data[2] & 0x07;
-	if (version < 2) {
-		width = 0;
-		factor = MPT_ULTRA2;
-		offset = pspi_data->maxSyncOffset;
-		target->tflags &= ~MPT_TARGET_FLAGS_Q_YES;
-	} else {
-		if (target->inq_data[7] & 0x20) {
-			width = 1;
-		}
-
-		if (target->inq_data[7] & 0x10) {
-			factor = pspi_data->minSyncFactor;
-			if (target->tflags & MPT_TARGET_FLAGS_VALID_56) {
-				/* bits 2 & 3 show Clocking support */
-				if ((byte56 & 0x0C) == 0)
-					factor = MPT_ULTRA2;
-				else {
-					if ((byte56 & 0x03) == 0)
-						factor = MPT_ULTRA160;
-					else {
-						factor = MPT_ULTRA320;
-						if (byte56 & 0x02)
-						{
-							ddvtprintk((KERN_INFO "Enabling QAS due to byte56=%02x on id=%d!\n", byte56, id));
-							noQas = 0;
-						}
-						if (target->inq_data[0] == TYPE_TAPE) {
-							if (byte56 & 0x01)
-								target->negoFlags |= MPT_TAPE_NEGO_IDP;
-						}
-					}
-				}
-			} else {
-				ddvtprintk((KERN_INFO "Enabling QAS on id=%d due to ~TARGET_FLAGS_VALID_56!\n", id));
-				noQas = 0;
-			}
-
-			offset = pspi_data->maxSyncOffset;
-
-			/* If RAID, never disable QAS
-			 * else if non RAID, do not disable
-			 *   QAS if bit 1 is set
-			 * bit 1 QAS support, non-raid only
-			 * bit 0 IU support
-			 */
-			if (target->raidVolume == 1) {
-				noQas = 0;
-			}
-		} else {
-			factor = MPT_ASYNC;
-			offset = 0;
-		}
-	}
-
-	if ( (target->inq_data[7] & 0x02) == 0) {
-		target->tflags &= ~MPT_TARGET_FLAGS_Q_YES;
-	}
-
-	/* Update tflags based on NVRAM settings. (SCSI only)
-	 */
-	if (pspi_data->nvram && (pspi_data->nvram[id] != MPT_HOST_NVRAM_INVALID)) {
-		nvram = pspi_data->nvram[id];
-		nfactor = (nvram & MPT_NVRAM_SYNC_MASK) >> 8;
-
-		if (width)
-			width = nvram & MPT_NVRAM_WIDE_DISABLE ? 0 : 1;
-
-		if (offset > 0) {
-			/* Ensure factor is set to the
-			 * maximum of: adapter, nvram, inquiry
-			 */
-			if (nfactor) {
-				if (nfactor < pspi_data->minSyncFactor )
-					nfactor = pspi_data->minSyncFactor;
-
-				factor = max(factor, nfactor);
-				if (factor == MPT_ASYNC)
-					offset = 0;
-			} else {
-				offset = 0;
-				factor = MPT_ASYNC;
-		}
-		} else {
-			factor = MPT_ASYNC;
-		}
-	}
-
-	/* Make sure data is consistent
-	 */
-	if ((!width) && (factor < MPT_ULTRA2)) {
-		factor = MPT_ULTRA2;
-	}
-
-	/* Save the data to the target structure.
-	 */
-	target->minSyncFactor = factor;
-	target->maxOffset = offset;
-	target->maxWidth = width;
-
-	target->tflags |= MPT_TARGET_FLAGS_VALID_NEGO;
-
-	/* Disable unused features.
-	 */
-	if (!width)
-		target->negoFlags |= MPT_TARGET_NO_NEGO_WIDE;
-
-	if (!offset)
-		target->negoFlags |= MPT_TARGET_NO_NEGO_SYNC;
-
-	if ( factor > MPT_ULTRA320 )
-		noQas = 0;
-
-	/* GEM, processor WORKAROUND
-	 */
-	if ((target->inq_data[0] == TYPE_PROCESSOR) || (target->inq_data[0] > 0x08)) {
-		target->negoFlags |= (MPT_TARGET_NO_NEGO_WIDE | MPT_TARGET_NO_NEGO_SYNC);
-		pspi_data->dvStatus[id] |= MPT_SCSICFG_BLK_NEGO;
-	} else {
-		if (noQas && (pspi_data->noQas == 0)) {
-			pspi_data->noQas |= MPT_TARGET_NO_NEGO_QAS;
-			target->negoFlags |= MPT_TARGET_NO_NEGO_QAS;
-
-			/* Disable QAS in a mixed configuration case
-	 		*/
-
-			ddvtprintk((KERN_INFO "Disabling QAS due to noQas=%02x on id=%d!\n", noQas, id));
-			for (ii = 0; ii < id; ii++) {
-				if ( (vdev = hd->Targets[ii]) ) {
-					vdev->negoFlags |= MPT_TARGET_NO_NEGO_QAS;
-					mptscsih_writeSDP1(hd, 0, ii, vdev->negoFlags);
-				}
-			}
-		}
-	}
-
-	/* Write SDP1 on this I/O to this target */
-	if (pspi_data->dvStatus[id] & MPT_SCSICFG_NEGOTIATE) {
-		ddvtprintk((KERN_INFO "MPT_SCSICFG_NEGOTIATE on id=%d!\n", id));
-		mptscsih_writeSDP1(hd, 0, id, hd->negoNvram);
-		pspi_data->dvStatus[id] &= ~MPT_SCSICFG_NEGOTIATE;
-	} else if (pspi_data->dvStatus[id] & MPT_SCSICFG_BLK_NEGO) {
-		ddvtprintk((KERN_INFO "MPT_SCSICFG_BLK_NEGO on id=%d!\n", id));
-		mptscsih_writeSDP1(hd, 0, id, MPT_SCSICFG_BLK_NEGO);
-		pspi_data->dvStatus[id] &= ~MPT_SCSICFG_BLK_NEGO;
-	}
-}
-
-/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/* If DV disabled (negoNvram set to USE_NVARM) or if not LUN 0, return.
- * Else set the NEED_DV flag after Read Capacity Issued (disks)
- * or Mode Sense (cdroms).
- *
- * Tapes, initTarget will set this flag on completion of Inquiry command.
- * Called only if DV_NOT_DONE flag is set
- */
-static void
-mptscsih_set_dvflags(MPT_SCSI_HOST *hd, SCSIIORequest_t *pReq)
-{
-	u8 cmd;
-	ScsiCfgData *pSpi;
-
-	ddvtprintk((" set_dvflags: id=%d lun=%d negoNvram=%x cmd=%x\n", 
-		pReq->TargetID, pReq->LUN[1], hd->negoNvram, pReq->CDB[0]));
-
-	if ((pReq->LUN[1] != 0) || (hd->negoNvram != 0))
-		return;
-
-	cmd = pReq->CDB[0];
-
-	if ((cmd == READ_CAPACITY) || (cmd == MODE_SENSE)) {
-		pSpi = &hd->ioc->spi_data;
-		if ((pSpi->isRaid & (1 << pReq->TargetID)) && pSpi->pIocPg3) {
-			/* Set NEED_DV for all hidden disks
-			 */
-			Ioc3PhysDisk_t *pPDisk =  pSpi->pIocPg3->PhysDisk;
-			int		numPDisk = pSpi->pIocPg3->NumPhysDisks;
-
-			while (numPDisk) {
-				pSpi->dvStatus[pPDisk->PhysDiskID] |= MPT_SCSICFG_NEED_DV;
-				ddvtprintk(("NEED_DV set for phys disk id %d\n", pPDisk->PhysDiskID));
-				pPDisk++;
-				numPDisk--;
-			}
-		}
-		pSpi->dvStatus[pReq->TargetID] |= MPT_SCSICFG_NEED_DV;
-		ddvtprintk(("NEED_DV set for visible disk id %d\n", pReq->TargetID));
-	}
-}
-
-/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
  * If no Target, bus reset on 1st I/O. Set the flag to
  * prevent any future negotiations to this device.
  */
@@ -3100,6 +2875,8 @@ mptscsih_writeSDP1(MPT_SCSI_HOST *hd, in
 	u8			 negoFlags;
 	u8			 maxwidth, maxoffset, maxfactor;
 
+	printk("HERE2\n");
+
 	if (ioc->spi_data.sdp1length == 0)
 		return 0;
 
@@ -3199,8 +2976,8 @@ mptscsih_writeSDP1(MPT_SCSI_HOST *hd, in
 			return -EAGAIN;
 		}
 
-		ddvprintk((MYIOC_s_INFO_FMT "WriteSDP1 (mf=%p, id=%d, req=0x%x, cfg=0x%x)\n",
-			hd->ioc->name, mf, id, requested, configuration));
+		printk(MYIOC_s_INFO_FMT "WriteSDP1 (mf=%p, id=%d, req=0x%x, cfg=0x%x)\n",
+			hd->ioc->name, mf, id, requested, configuration);
 
 
 		/* Set the request and the data pointers.
@@ -4223,12 +4000,12 @@ mptscsih_qas_check(MPT_SCSI_HOST *hd, in
 		if ((pTarget != NULL) && (!pTarget->raidVolume)) {
 			if ((pTarget->negoFlags & hd->ioc->spi_data.noQas) == 0) {
 				pTarget->negoFlags |= hd->ioc->spi_data.noQas;
-				dnegoprintk(("writeSDP1: id=%d flags=0\n", id));
+				printk("writeSDP1: id=%d flags=0\n", id);
 				mptscsih_writeSDP1(hd, 0, ii, 0);
 			}
 		} else {
 			if (mptscsih_is_phys_disk(hd->ioc, ii) == 1) {
-				dnegoprintk(("writeSDP1: id=%d SCSICFG_USE_NVRAM\n", id));
+				printk("writeSDP1: id=%d SCSICFG_USE_NVRAM\n", id);
 				mptscsih_writeSDP1(hd, 0, ii, MPT_SCSICFG_USE_NVRAM);
 			}
 		}
diff --git a/drivers/message/fusion/mptscsih.h b/drivers/message/fusion/mptscsih.h
--- a/drivers/message/fusion/mptscsih.h
+++ b/drivers/message/fusion/mptscsih.h
@@ -67,7 +67,7 @@
  * capabilities.
  */
 
-#define MPTSCSIH_ENABLE_DOMAIN_VALIDATION
+#undef MPTSCSIH_ENABLE_DOMAIN_VALIDATION
 
 
 /* SCSI driver setup structure. Settings can be overridden
diff --git a/drivers/message/fusion/mptspi.c b/drivers/message/fusion/mptspi.c
--- a/drivers/message/fusion/mptspi.c
+++ b/drivers/message/fusion/mptspi.c
@@ -62,6 +62,8 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
+#include <scsi/scsi_transport.h>
+#include <scsi/scsi_transport_spi.h>
 
 #include "mptbase.h"
 #include "mptscsih.h"
@@ -98,10 +100,130 @@ static int mpt_pq_filter = 0;
 module_param(mpt_pq_filter, int, 0);
 MODULE_PARM_DESC(mpt_pq_filter, " Enable peripheral qualifier filter: enable=1  (default=0)");
 
+static struct scsi_transport_template *mptspi_transport_template = NULL;
+
 static int	mptspiDoneCtx = -1;
 static int	mptspiTaskCtx = -1;
 static int	mptspiInternalCtx = -1; /* Used only for internal commands */
 
+static int mptspi_target_alloc(struct scsi_target *starget)
+{
+	struct Scsi_Host *shost = dev_to_shost(&starget->dev);
+	struct _MPT_SCSI_HOST *hd = (struct _MPT_SCSI_HOST *)shost->hostdata;
+	static void mptspi_write_offset(struct scsi_target *, int);
+	static void mptspi_write_width(struct scsi_target *, int);
+
+	if (hd == NULL)
+		return -ENODEV;
+
+	if (hd->ioc->spi_data.nvram &&
+	    hd->ioc->spi_data.nvram[starget->id] != MPT_HOST_NVRAM_INVALID) {
+		u32 nvram = hd->ioc->spi_data.nvram[starget->id];
+		spi_min_period(starget) = (nvram & MPT_NVRAM_SYNC_MASK) >> MPT_NVRAM_SYNC_SHIFT;
+		spi_max_width(starget) = nvram & MPT_NVRAM_WIDE_DISABLE ? 0 : 1;
+	} else {
+		spi_min_period(starget) = hd->ioc->spi_data.minSyncFactor;
+		spi_max_width(starget) = hd->ioc->spi_data.maxBusWidth;
+	}
+	spi_max_offset(starget) = hd->ioc->spi_data.maxSyncOffset;
+
+	spi_offset(starget) = 0;
+	mptspi_write_width(starget, 0);
+
+	return 0;
+}
+
+static int mptspi_read_page0(struct scsi_target *starget,
+			     struct _CONFIG_PAGE_SCSI_DEVICE_0 *pass_pg0)
+{
+	struct Scsi_Host *shost = dev_to_shost(&starget->dev);
+	struct _MPT_SCSI_HOST *hd = (struct _MPT_SCSI_HOST *)shost->hostdata;
+	struct _MPT_ADAPTER *ioc = hd->ioc;
+	struct _CONFIG_PAGE_SCSI_DEVICE_0 *pg0;
+	dma_addr_t pg0_dma;
+	int size;
+	struct _x_config_parms cfg;
+	struct _CONFIG_PAGE_HEADER hdr;
+	int err = -EBUSY;
+
+	size = ioc->spi_data.sdp0length * 4;
+	/*
+	if (ioc->spi_data.sdp0length & 1)
+		size += size + 4;
+	size += 2048;
+	*/
+
+	pg0 = dma_alloc_coherent(&ioc->pcidev->dev, size, &pg0_dma, GFP_KERNEL);
+	if (pg0 == NULL) {
+		dev_printk(KERN_ERR, &starget->dev, "dma_alloc_coherent for parameters failed\n");
+		return -EINVAL;
+	}
+
+	memset(&hdr, 0, sizeof(hdr));
+
+	hdr.PageVersion = ioc->spi_data.sdp0version;
+	hdr.PageLength = ioc->spi_data.sdp0length;
+	hdr.PageNumber = 0;
+	hdr.PageType = MPI_CONFIG_PAGETYPE_SCSI_DEVICE;
+
+	memset(&cfg, 0, sizeof(cfg));
+
+	cfg.hdr = &hdr;
+	cfg.physAddr = pg0_dma;
+	cfg.action = MPI_CONFIG_ACTION_PAGE_READ_CURRENT;
+	cfg.dir = 0;
+	cfg.pageAddr = (starget->channel << 8) | starget->id;
+
+	if (mpt_config(ioc, &cfg)) {
+		dev_printk(KERN_ERR, &starget->dev, "mpt_config failed\n");
+		goto out_free;
+	}
+	err = 0;
+	memcpy(pass_pg0, pg0, size);
+
+ out_free:
+	dma_free_coherent(&ioc->pcidev->dev, size, pg0, pg0_dma);
+	return err;
+}
+
+static void mptspi_read_parameters(struct scsi_target *starget)
+{
+	int nego;
+	struct _CONFIG_PAGE_SCSI_DEVICE_0 pg0;
+
+	mptspi_read_page0(starget, &pg0);
+
+	nego = le32_to_cpu(pg0.NegotiatedParameters);
+
+	spi_iu(starget) = (nego & MPI_SCSIDEVPAGE0_NP_IU) ? 1 : 0;
+	spi_dt(starget) = (nego & MPI_SCSIDEVPAGE0_NP_DT) ? 1 : 0;
+	spi_qas(starget) = (nego & MPI_SCSIDEVPAGE0_NP_QAS) ? 1 : 0;
+	//spi_hold_mcs(starget) = (nego & MPI_SCSIDEVPAGE0_NP_HOLD_MCS) ? 1 : 0;
+	spi_wr_flow(starget) = (nego & MPI_SCSIDEVPAGE0_NP_WR_FLOW) ? 1 : 0;
+	spi_rd_strm(starget) = (nego & MPI_SCSIDEVPAGE0_NP_RD_STRM) ? 1 : 0;
+	spi_rti(starget) = (nego & MPI_SCSIDEVPAGE0_NP_RTI) ? 1 : 0;
+	spi_pcomp_en(starget) = (nego & MPI_SCSIDEVPAGE0_NP_PCOMP_EN) ? 1 : 0;
+	spi_period(starget) = (nego & MPI_SCSIDEVPAGE0_NP_NEG_SYNC_PERIOD_MASK) >> MPI_SCSIDEVPAGE0_NP_SHIFT_SYNC_PERIOD;
+	spi_offset(starget) = (nego & MPI_SCSIDEVPAGE0_NP_NEG_SYNC_OFFSET_MASK) >> MPI_SCSIDEVPAGE0_NP_SHIFT_SYNC_OFFSET;
+	spi_width(starget) = (nego & MPI_SCSIDEVPAGE0_NP_WIDE) ? 1 : 0;
+}
+
+static int mptspi_slave_configure(struct scsi_device *sdev)
+{
+	int ret = mptscsih_slave_configure(sdev);
+
+	if (ret)
+		return ret;
+
+	if (!spi_initial_dv(sdev->sdev_target)) {
+		spi_dv_device(sdev);
+		mptspi_read_parameters(sdev->sdev_target);
+		spi_display_xfer_agreement(sdev->sdev_target);
+	}
+
+	return 0;
+}
+
 static struct scsi_host_template mptspi_driver_template = {
 	.proc_name			= "mptspi",
 	.proc_info			= mptscsih_proc_info,
@@ -109,8 +231,9 @@ static struct scsi_host_template mptspi_
 	.info				= mptscsih_info,
 	.queuecommand			= mptscsih_qcmd,
 	.slave_alloc			= mptscsih_slave_alloc,
-	.slave_configure		= mptscsih_slave_configure,
+	.slave_configure		= mptspi_slave_configure,
 	.slave_destroy			= mptscsih_slave_destroy,
+	.target_alloc			= mptspi_target_alloc,
 	.change_queue_depth 		= mptscsih_change_queue_depth,
 	.eh_abort_handler		= mptscsih_abort,
 	.eh_device_reset_handler	= mptscsih_dev_reset,
@@ -125,6 +248,265 @@ static struct scsi_host_template mptspi_
 	.use_clustering			= ENABLE_CLUSTERING,
 };
 
+static int mptspi_write_page1(struct scsi_target *starget,
+			       struct _CONFIG_PAGE_SCSI_DEVICE_1 *pass_pg1)
+{
+	struct Scsi_Host *shost = dev_to_shost(&starget->dev);
+	struct _MPT_SCSI_HOST *hd = (struct _MPT_SCSI_HOST *)shost->hostdata;
+	struct _MPT_ADAPTER *ioc = hd->ioc;
+	struct _CONFIG_PAGE_SCSI_DEVICE_1 *pg1;
+	dma_addr_t pg1_dma;
+	int size;
+	struct _x_config_parms cfg;
+	struct _CONFIG_PAGE_HEADER hdr;
+	int err = -EBUSY;
+
+	size = ioc->spi_data.sdp1length * 4;
+
+	pg1 = dma_alloc_coherent(&ioc->pcidev->dev, size, &pg1_dma, GFP_KERNEL);
+	if (pg1 == NULL) {
+		dev_printk(KERN_ERR, &starget->dev, "dma_alloc_coherent for parameters failed\n");
+		return -EINVAL;
+	}
+
+	memset(&hdr, 0, sizeof(hdr));
+
+	hdr.PageVersion = ioc->spi_data.sdp1version;
+	hdr.PageLength = ioc->spi_data.sdp1length;
+	hdr.PageNumber = 1;
+	hdr.PageType = MPI_CONFIG_PAGETYPE_SCSI_DEVICE;
+
+	memset(&cfg, 0, sizeof(cfg));
+
+	cfg.hdr = &hdr;
+	cfg.physAddr = pg1_dma;
+	cfg.action = MPI_CONFIG_ACTION_PAGE_WRITE_CURRENT;
+	cfg.dir = 1;
+	cfg.pageAddr = (starget->channel << 8) | starget->id;
+
+	memcpy(pg1, pass_pg1, size);
+
+	pg1->Header.PageVersion = hdr.PageVersion;
+	pg1->Header.PageLength = hdr.PageLength;
+	pg1->Header.PageNumber = hdr.PageNumber;
+	pg1->Header.PageType = hdr.PageType;
+
+	if (mpt_config(ioc, &cfg)) {
+		dev_printk(KERN_ERR, &starget->dev, "mpt_config failed\n");
+		goto out_free;
+	}
+	err = 0;
+
+ out_free:
+	dma_free_coherent(&ioc->pcidev->dev, size, pg1, pg1_dma);
+	return err;
+}
+
+static u32 mptspi_getRP(struct scsi_target *starget)
+{
+	u32 nego = 0;
+
+	nego |= spi_iu(starget) ? MPI_SCSIDEVPAGE1_RP_IU : 0;
+	nego |= spi_dt(starget) ? MPI_SCSIDEVPAGE1_RP_DT : 0;
+	nego |= spi_qas(starget) ? MPI_SCSIDEVPAGE1_RP_QAS : 0;
+	//nego |= spi_hold_mcs(starget) ? MPI_SCSIDEVPAGE1_RP_HOLD_MCS : 0;
+	nego |= spi_wr_flow(starget) ? MPI_SCSIDEVPAGE1_RP_WR_FLOW : 0;
+	nego |= spi_rd_strm(starget) ? MPI_SCSIDEVPAGE1_RP_RD_STRM : 0;
+	nego |= spi_rti(starget) ? MPI_SCSIDEVPAGE1_RP_RTI : 0;
+	nego |= spi_pcomp_en(starget) ? MPI_SCSIDEVPAGE1_RP_PCOMP_EN : 0;
+
+	nego |= (spi_period(starget) <<  MPI_SCSIDEVPAGE1_RP_SHIFT_MIN_SYNC_PERIOD) & MPI_SCSIDEVPAGE1_RP_MIN_SYNC_PERIOD_MASK;
+	nego |= (spi_offset(starget) << MPI_SCSIDEVPAGE1_RP_SHIFT_MAX_SYNC_OFFSET) & MPI_SCSIDEVPAGE1_RP_MAX_SYNC_OFFSET_MASK;
+	nego |= spi_width(starget) ?  MPI_SCSIDEVPAGE1_RP_WIDE : 0;
+
+	return nego;
+}
+
+static void mptspi_write_offset(struct scsi_target *starget, int offset)
+{
+	struct _CONFIG_PAGE_SCSI_DEVICE_1 pg1;
+	u32 nego;
+
+	if (offset < 0)
+		offset = 0;
+
+	if (offset > 255)
+		offset = 255;
+
+	if (spi_offset(starget) == -1)
+		mptspi_read_parameters(starget);
+
+	spi_offset(starget) = offset;
+
+	nego = mptspi_getRP(starget);
+
+	pg1.RequestedParameters = cpu_to_le32(nego);
+	pg1.Reserved = 0;
+	pg1.Configuration = 0;
+
+	mptspi_write_page1(starget, &pg1);
+}
+
+static void mptspi_write_period(struct scsi_target *starget, int period)
+{
+	struct _CONFIG_PAGE_SCSI_DEVICE_1 pg1;
+	u32 nego;
+
+	if (period < 8)
+		period = 8;
+
+	if (period > 255)
+		period = 255;
+
+	if (spi_period(starget) == -1)
+		mptspi_read_parameters(starget);
+
+	if (period == 8) {
+		spi_iu(starget) = 1;
+		spi_dt(starget) = 1;
+	} else if (period == 9) {
+		spi_dt(starget) = 1;
+	}
+
+	spi_period(starget) = period;
+
+	nego = mptspi_getRP(starget);
+
+	pg1.RequestedParameters = cpu_to_le32(nego);
+	pg1.Reserved = 0;
+	pg1.Configuration = 0;
+
+	mptspi_write_page1(starget, &pg1);
+}
+
+static void mptspi_write_dt(struct scsi_target *starget, int dt)
+{
+	struct _CONFIG_PAGE_SCSI_DEVICE_1 pg1;
+	u32 nego;
+
+	if (spi_period(starget) == -1)
+		mptspi_read_parameters(starget);
+
+	if (!dt && spi_period(starget) < 10)
+		spi_period(starget) = 10;
+
+	spi_dt(starget) = dt;
+
+	nego = mptspi_getRP(starget);
+
+	
+	pg1.RequestedParameters = cpu_to_le32(nego);
+	pg1.Reserved = 0;
+	pg1.Configuration = 0;
+
+	mptspi_write_page1(starget, &pg1);
+}
+
+static void mptspi_write_iu(struct scsi_target *starget, int iu)
+{
+	struct _CONFIG_PAGE_SCSI_DEVICE_1 pg1;
+	u32 nego;
+
+	if (spi_period(starget) == -1)
+		mptspi_read_parameters(starget);
+
+	if (!iu && spi_period(starget) < 9)
+		spi_period(starget) = 9;
+
+	spi_iu(starget) = iu;
+
+	nego = mptspi_getRP(starget);
+
+	
+	pg1.RequestedParameters = cpu_to_le32(nego);
+	pg1.Reserved = 0;
+	pg1.Configuration = 0;
+
+	mptspi_write_page1(starget, &pg1);
+}
+
+#define MPTSPI_SIMPLE_TRANSPORT_PARM(parm) 				\
+static void mptspi_write_##parm(struct scsi_target *starget, int parm)\
+{									\
+	struct _CONFIG_PAGE_SCSI_DEVICE_1 pg1;				\
+	u32 nego;							\
+									\
+	spi_rd_strm(starget) = parm;					\
+									\
+	nego = mptspi_getRP(starget);					\
+									\
+	pg1.RequestedParameters = cpu_to_le32(nego);			\
+	pg1.Reserved = 0;						\
+	pg1.Configuration = 0;						\
+									\
+	mptspi_write_page1(starget, &pg1);				\
+}
+
+MPTSPI_SIMPLE_TRANSPORT_PARM(qas)
+MPTSPI_SIMPLE_TRANSPORT_PARM(rd_strm)
+MPTSPI_SIMPLE_TRANSPORT_PARM(wr_flow)
+MPTSPI_SIMPLE_TRANSPORT_PARM(rti)
+MPTSPI_SIMPLE_TRANSPORT_PARM(hold_mcs)
+MPTSPI_SIMPLE_TRANSPORT_PARM(pcomp_en)
+
+static void mptspi_write_width(struct scsi_target *starget, int width)
+{
+	struct _CONFIG_PAGE_SCSI_DEVICE_1 pg1;
+	u32 nego;
+
+	if (!width) {
+		spi_dt(starget) = 0;
+		if (spi_period(starget) < 10)
+			spi_period(starget) = 10;
+	}
+
+	spi_width(starget) = width;
+
+	nego = mptspi_getRP(starget);
+	
+	pg1.RequestedParameters = cpu_to_le32(nego);
+	pg1.Reserved = 0;
+	pg1.Configuration = 0;
+
+	mptspi_write_page1(starget, &pg1);
+}
+
+static struct spi_function_template mptspi_transport_functions = {
+	.get_offset	= mptspi_read_parameters,
+	.set_offset	= mptspi_write_offset,
+	.show_offset	= 1,
+	.get_period	= mptspi_read_parameters,
+	.set_period	= mptspi_write_period,
+	.show_period	= 1,
+	.get_width	= mptspi_read_parameters,
+	.set_width	= mptspi_write_width,
+	.show_width	= 1,
+	.get_iu		= mptspi_read_parameters,
+	.set_iu		= mptspi_write_iu,
+	.show_iu	= 1,
+	.get_dt		= mptspi_read_parameters,
+	.set_dt		= mptspi_write_dt,
+	.show_dt	= 1,
+	.get_qas	= mptspi_read_parameters,
+	.set_qas	= mptspi_write_qas,
+	.show_qas	= 1,
+	.get_wr_flow	= mptspi_read_parameters,
+	.set_wr_flow	= mptspi_write_wr_flow,
+	.show_wr_flow	= 1,
+	.get_rd_strm	= mptspi_read_parameters,
+	.set_rd_strm	= mptspi_write_rd_strm,
+	.show_rd_strm	= 1,
+	.get_rti	= mptspi_read_parameters,
+	.set_rti	= mptspi_write_rti,
+	.show_rti	= 1,
+	.get_pcomp_en	= mptspi_read_parameters,
+	.set_pcomp_en	= mptspi_write_pcomp_en,
+	.show_pcomp_en	= 1,
+	.get_hold_mcs	= mptspi_read_parameters,
+	.set_hold_mcs	= mptspi_write_hold_mcs,
+	.show_hold_mcs	= 1,
+};
+
 
 /****************************************************************************
  * Supported hardware
@@ -365,7 +747,6 @@ mptspi_probe(struct pci_dev *pdev, const
 		mpt_saf_te,
 		mpt_pq_filter));
 #endif
-
 	ioc->spi_data.forceDv = 0;
 	ioc->spi_data.noQas = 0;
 
@@ -381,6 +762,11 @@ mptspi_probe(struct pci_dev *pdev, const
 	hd->scandv_wait_done = 0;
 	hd->last_queue_full = 0;
 
+	/* Some versions of the firmware don't support page 0; without
+	 * that we can't get the parameters */
+	if (hd->ioc->spi_data.sdp0length != 0)
+		sh->transportt = mptspi_transport_template;
+
 	error = scsi_add_host (sh, &ioc->pcidev->dev);
 	if(error) {
 		dprintk((KERN_ERR MYNAM
@@ -422,6 +808,10 @@ mptspi_init(void)
 
 	show_mptmod_ver(my_NAME, my_VERSION);
 
+	mptspi_transport_template = spi_attach_transport(&mptspi_transport_functions);
+	if (!mptspi_transport_template)
+		return -ENODEV;
+
 	mptspiDoneCtx = mpt_register(mptscsih_io_done, MPTSPI_DRIVER);
 	mptspiTaskCtx = mpt_register(mptscsih_taskmgmt_complete, MPTSPI_DRIVER);
 	mptspiInternalCtx = mpt_register(mptscsih_scandv_complete, MPTSPI_DRIVER);


