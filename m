Return-Path: <linux-kernel-owner+w=401wt.eu-S965325AbXAKHvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965325AbXAKHvs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 02:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965328AbXAKHvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 02:51:48 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34423 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965325AbXAKHvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 02:51:47 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Thu, 11 Jan 2007 08:50:27 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.19.y] ieee1394: sbp2: fix probing of some DVD-ROM/RWs
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org
Message-ID: <tkrat.d4c825f325c015da@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 98e238cd42be6c0852da519303cf0182690f8d9f in Linux 2.6.19,
"ieee1394: sbp2: don't prefer MODE SENSE 10", some FireWire DVD-ROMs and
DVD-RWs were mistaken as CD-ROM because sr_mod now sent MODE SENSE 6.
The MMC command set includes only MODE SENSE 10.
http://bugzilla.kernel.org/show_bug.cgi?id=7800

This fix lets sbp2 switch scsi_device.use_10_for_rw on for MMC LUs.
This should rather be done in the command set driver sr_mod, not in the
sbp2 transport driver, and an according patch will follow for a next
Linux release.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
same as commit 1a74bc68e4c0534d150e6454b45a70dab831fa32

Index: linux-2.6.19.1/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.19.1.orig/drivers/ieee1394/sbp2.c
+++ linux-2.6.19.1/drivers/ieee1394/sbp2.c
@@ -2530,6 +2530,8 @@ static int sbp2scsi_slave_configure(stru
 	blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
 	sdev->use_10_for_rw = 1;
 
+	if (sdev->type == TYPE_ROM)
+		sdev->use_10_for_ms = 1;
 	if (sdev->type == TYPE_DISK &&
 	    scsi_id->workarounds & SBP2_WORKAROUND_MODE_SENSE_8)
 		sdev->skip_ms_page_8 = 1;

-- 
Stefan Richter
-=====-=-=== ---= -=-==
http://arcgraph.de/sr/

