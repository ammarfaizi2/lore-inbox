Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVCCDJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVCCDJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVCCDEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:04:51 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:39606 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261454AbVCCDDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:03:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=H8+0gwqXBI33npPzvM6oVTC/YVGnr4Vz7MzIedsYtZkayWS/tRbsXPR5X+eTznf0dcw3GB/XY5X/YsMhwoL5CfGSmCDsHUkwJ2pH0wv0GqiPRfowE0J36F176bFyYWce4FIkwV2GcRcM9ETnCfvPfkS1nOVcx0ZCXtgOL2VWPEs=
Date: Thu, 3 Mar 2005 12:03:18 +0900
From: Tejun Heo <htejun@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH ide-dev-2.6] ide: ide_dma_intr oops fix
Message-ID: <20050303030318.GA25410@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Bartlomiej.

 This patch fixes ide_dma_intr() oops which occurs for TASKFILE ioctl
using DMA dataphses.  This is against the latest ide-dev-2.6 tree +
all your recent 9 patches.

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: linux-taskfile-ng/drivers/ide/ide-dma.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-dma.c	2005-03-03 11:59:16.485582413 +0900
+++ linux-taskfile-ng/drivers/ide/ide-dma.c	2005-03-03 12:00:07.753376048 +0900
@@ -175,10 +175,14 @@ ide_startstop_t ide_dma_intr (ide_drive_
 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
 		if (!dma_stat) {
 			struct request *rq = HWGROUP(drive)->rq;
-			ide_driver_t *drv;
 
-			drv = *(ide_driver_t **)rq->rq_disk->private_data;;
-			drv->end_request(drive, 1, rq->nr_sectors);
+			if (rq->rq_disk) {
+				ide_driver_t *drv;
+
+				drv = *(ide_driver_t **)rq->rq_disk->private_data;;
+				drv->end_request(drive, 1, rq->nr_sectors);
+			} else
+				ide_end_request(drive, 1, rq->nr_sectors);
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
