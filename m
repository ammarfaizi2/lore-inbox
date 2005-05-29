Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVE2E2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVE2E2y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 00:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVE2E1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 00:27:14 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:57078 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261235AbVE2EXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 00:23:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=ghfvCP7Ef20QLM+9M+mt5wdoaaHDhO7GNqrvSOUkwh29nfcpr+5hL+LY4yjelWY6D8Tiemp/wslqb7CcGeAys6xuUMaTYPar2+pHqGb7vCyu/W/XzHho2pA0RFfzv+ft1+NCz/LmKur+CCHY0uA1IyPqiJ/siKvb8npAvKDsltI=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050529042034.5FF4CF1C@htj.dyndns.org>
In-Reply-To: <20050529042034.5FF4CF1C@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm1 05/06] blk: turn on QUEUE_ORDERED_FLUSH by default if ordered tag isn't supported
Message-ID: <20050529042034.9342AF62@htj.dyndns.org>
Date: Sun, 29 May 2005 13:23:43 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05_blk_scsi_turn_on_flushing_by_default.patch

	As flushing can now be used by devices which only support
	simple tags, there's no need to use
	Scsi_Host_Template->ordered_flush to enable it selectively.
	This patch removes ->ordered_flush and enables flushing
	implicitly when ordered tag isn't supported.  If the device
	doesn't support flushing, it can just return -EOPNOTSUPP for
	flush requests.  blk layer will switch to QUEUE_OREDERED_NONE
	automatically.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/ahci.c         |    1 -
 drivers/scsi/ata_piix.c     |    1 -
 drivers/scsi/hosts.c        |    9 ---------
 drivers/scsi/sata_nv.c      |    1 -
 drivers/scsi/sata_promise.c |    1 -
 drivers/scsi/sata_sil.c     |    1 -
 drivers/scsi/sata_sis.c     |    1 -
 drivers/scsi/sata_svw.c     |    1 -
 drivers/scsi/sata_sx4.c     |    1 -
 drivers/scsi/sata_uli.c     |    1 -
 drivers/scsi/sata_via.c     |    1 -
 drivers/scsi/sata_vsc.c     |    1 -
 drivers/scsi/scsi_lib.c     |    2 +-
 include/scsi/scsi_host.h    |    1 -
 14 files changed, 1 insertion(+), 22 deletions(-)

Index: blk-fixes/drivers/scsi/ahci.c
===================================================================
--- blk-fixes.orig/drivers/scsi/ahci.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/ahci.c	2005-05-29 13:20:32.000000000 +0900
@@ -200,7 +200,6 @@ static Scsi_Host_Template ahci_sht = {
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations ahci_ops = {
Index: blk-fixes/drivers/scsi/ata_piix.c
===================================================================
--- blk-fixes.orig/drivers/scsi/ata_piix.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/ata_piix.c	2005-05-29 13:20:32.000000000 +0900
@@ -123,7 +123,6 @@ static Scsi_Host_Template piix_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations piix_pata_ops = {
Index: blk-fixes/drivers/scsi/hosts.c
===================================================================
--- blk-fixes.orig/drivers/scsi/hosts.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/hosts.c	2005-05-29 13:20:32.000000000 +0900
@@ -264,17 +264,8 @@ struct Scsi_Host *scsi_host_alloc(struct
 	shost->cmd_per_lun = sht->cmd_per_lun;
 	shost->unchecked_isa_dma = sht->unchecked_isa_dma;
 	shost->use_clustering = sht->use_clustering;
-	shost->ordered_flush = sht->ordered_flush;
 	shost->ordered_tag = sht->ordered_tag;
 
-	/*
-	 * hosts/devices that do queueing must support ordered tags
-	 */
-	if (shost->can_queue > 1 && shost->ordered_flush) {
-		printk(KERN_ERR "scsi: ordered flushes don't support queueing\n");
-		shost->ordered_flush = 0;
-	}
-
 	if (sht->max_host_blocked)
 		shost->max_host_blocked = sht->max_host_blocked;
 	else
Index: blk-fixes/drivers/scsi/sata_nv.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_nv.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_nv.c	2005-05-29 13:20:32.000000000 +0900
@@ -206,7 +206,6 @@ static Scsi_Host_Template nv_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations nv_ops = {
Index: blk-fixes/drivers/scsi/sata_promise.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_promise.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_promise.c	2005-05-29 13:20:32.000000000 +0900
@@ -102,7 +102,6 @@ static Scsi_Host_Template pdc_ata_sht = 
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations pdc_ata_ops = {
Index: blk-fixes/drivers/scsi/sata_sil.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sil.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sil.c	2005-05-29 13:20:32.000000000 +0900
@@ -134,7 +134,6 @@ static Scsi_Host_Template sil_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations sil_ops = {
Index: blk-fixes/drivers/scsi/sata_sis.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sis.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sis.c	2005-05-29 13:20:32.000000000 +0900
@@ -90,7 +90,6 @@ static Scsi_Host_Template sis_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations sis_ops = {
Index: blk-fixes/drivers/scsi/sata_svw.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_svw.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_svw.c	2005-05-29 13:20:32.000000000 +0900
@@ -288,7 +288,6 @@ static Scsi_Host_Template k2_sata_sht = 
 	.proc_info		= k2_sata_proc_info,
 #endif
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 
Index: blk-fixes/drivers/scsi/sata_sx4.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sx4.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sx4.c	2005-05-29 13:20:32.000000000 +0900
@@ -188,7 +188,6 @@ static Scsi_Host_Template pdc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations pdc_20621_ops = {
Index: blk-fixes/drivers/scsi/sata_uli.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_uli.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_uli.c	2005-05-29 13:20:32.000000000 +0900
@@ -82,7 +82,6 @@ static Scsi_Host_Template uli_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations uli_ops = {
Index: blk-fixes/drivers/scsi/sata_via.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_via.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_via.c	2005-05-29 13:20:32.000000000 +0900
@@ -102,7 +102,6 @@ static Scsi_Host_Template svia_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations svia_sata_ops = {
Index: blk-fixes/drivers/scsi/sata_vsc.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_vsc.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_vsc.c	2005-05-29 13:20:32.000000000 +0900
@@ -205,7 +205,6 @@ static Scsi_Host_Template vsc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 
Index: blk-fixes/drivers/scsi/scsi_lib.c
===================================================================
--- blk-fixes.orig/drivers/scsi/scsi_lib.c	2005-05-29 13:20:31.000000000 +0900
+++ blk-fixes/drivers/scsi/scsi_lib.c	2005-05-29 13:20:32.000000000 +0900
@@ -1428,7 +1428,7 @@ struct request_queue *scsi_alloc_queue(s
 	 */
 	if (shost->ordered_tag)
 		blk_queue_ordered(q, QUEUE_ORDERED_TAG);
-	else if (shost->ordered_flush) {
+	else {
 		blk_queue_ordered(q, QUEUE_ORDERED_FLUSH);
 		q->prepare_flush_fn = scsi_prepare_flush_fn;
 	}
Index: blk-fixes/include/scsi/scsi_host.h
===================================================================
--- blk-fixes.orig/include/scsi/scsi_host.h	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/include/scsi/scsi_host.h	2005-05-29 13:20:32.000000000 +0900
@@ -366,7 +366,6 @@ struct scsi_host_template {
 	/*
 	 * ordered write support
 	 */
-	unsigned ordered_flush:1;
 	unsigned ordered_tag:1;
 
 	/*

