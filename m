Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVBRT7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVBRT7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVBRT7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:59:06 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:21766 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261452AbVBRTzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:55:21 -0500
Date: Fri, 18 Feb 2005 14:55:12 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch libata-dev-2.6 2/5] libata: sync SMART ioctls with ATA pass thru spec (T10/04-262r7)
Message-ID: <20050218195512.GC3197@tuxdriver.com>
Mail-Followup-To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
References: <20050218195027.GB3197@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218195027.GB3197@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor modifications to the SMART-related ioctls in libata, in
compliance with the latest ATA pass thru spec (T10/04-262r7).

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/scsi/libata-scsi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- sata-smart-2.6/drivers/scsi/libata-scsi.c.orig	2005-02-01 16:24:01.687622085 -0500
+++ sata-smart-2.6/drivers/scsi/libata-scsi.c	2005-02-01 16:49:18.213876086 -0500
@@ -109,14 +109,16 @@ int ata_cmd_ioctl(struct scsi_device *sc
 			return -ENOMEM;
 
 		scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
+		scsi_cmd[2]  = 0x0e;     /* no off.line or cc, read from dev,
+		                            block count in sector count field */
 		sreq->sr_data_direction = DMA_FROM_DEVICE;
 	} else {
 		scsi_cmd[1]  = (3 << 1); /* Non-data */
+		/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
 		sreq->sr_data_direction = DMA_NONE;
 	}
 
 	scsi_cmd[0] = ATA_16;
-	scsi_cmd[2] = 0x1f;     /* no off.line or cc, yes all registers */
 
 	scsi_cmd[4] = args[2];
 	if (args[0] == WIN_SMART) { /* hack -- ide driver does this too... */
@@ -179,7 +181,7 @@ int ata_task_ioctl(struct scsi_device *s
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
 	scsi_cmd[0]  = ATA_16;
 	scsi_cmd[1]  = (3 << 1); /* Non-data */
-	scsi_cmd[2]  = 0x1f;     /* no off.line or cc, yes all registers */
+	/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
 	scsi_cmd[4]  = args[1];
 	scsi_cmd[6]  = args[2];
 	scsi_cmd[8]  = args[3];
-- 
John W. Linville
linville@tuxdriver.com
