Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWFBRgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWFBRgV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 13:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWFBRgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 13:36:21 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:55751 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750813AbWFBRgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 13:36:20 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 19:34:30 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.16.19] sbp2: backport read_capacity workaround for iPod
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org
In-Reply-To: <447DC82A.3000501@s5r6.in-berlin.de>
Message-ID: <tkrat.26f002591ab59cf8@s5r6.in-berlin.de>
References: <tkrat.b9bf60697156ef7b@s5r6.in-berlin.de>
 <20060530231917.GI18769@moss.sous-sol.org>
 <447DC82A.3000501@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.887) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sbp2: backport read_capacity workaround for iPod

There is a firmware bug in several Apple iPods which prevents access to
these iPods under certain conditions. The disk size reported by the iPod
is one sector too big. Once access to the end of the disk is attempted,
the iPod becomes inaccessible. This problem has been known for USB iPods
for some time and has recently been discovered to exist with
FireWire/USB combo iPods too.

This patch is derived from the fix in Linux 2.6.17, commit
e9a1c52c7b19d10342226c12f170d7ab644427e2, to be applicable to 2.6.16.x
without prerequisite patches. It hard-wires a workaround for three known
affected model numbers (those of 4th generation iPod, iPod Photo, iPod
mini).

Note: This patch lacks Linux 2.6.17's ability to enable and disable the
workaround via a module parameter.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-06-02 18:37:13.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-06-02 19:10:05.000000000 +0200
@@ -2491,9 +2491,20 @@ static int sbp2scsi_slave_alloc(struct s
 
 static int sbp2scsi_slave_configure(struct scsi_device *sdev)
 {
+	struct scsi_id_instance_data *scsi_id =
+		(struct scsi_id_instance_data *)sdev->host->hostdata[0];
+
 	blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
+
+	if ((scsi_id->sbp2_firmware_revision & 0xffff00) == 0x0a2700 &&
+	    (scsi_id->ud->model_id == 0x000021 /* gen.4 iPod */ ||
+	     scsi_id->ud->model_id == 0x000023 /* iPod mini  */ ||
+	     scsi_id->ud->model_id == 0x00007e /* iPod Photo */ )) {
+		SBP2_INFO("enabling iPod workaround: decrement disk capacity");
+		sdev->fix_capacity = 1;
+	}
 	return 0;
 }
 

