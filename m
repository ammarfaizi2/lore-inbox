Return-Path: <linux-kernel-owner+w=401wt.eu-S965077AbXAJUVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbXAJUVc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 15:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbXAJUVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 15:21:32 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37489 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965077AbXAJUVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 15:21:32 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 10 Jan 2007 21:21:07 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [GIT PULL] ieee1394 fix
To: Linus Torvalds <torvalds@osdl.org>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-ID: <tkrat.d0d4cea2d223b048@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from the for-linus branch at

    git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394-2.6.git for-linus

to receive a fix for a regression since 2.6.19 inclusive.
(Or apply from this mail.)

 drivers/ieee1394/sbp2.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


commit 1a74bc68e4c0534d150e6454b45a70dab831fa32
Author: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date:   Wed Jan 10 20:17:15 2007 +0100

    ieee1394: sbp2: fix probing of some DVD-ROM/RWs
    
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
diff --git a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
index 2b5d7ab..4325aac 100644
--- a/drivers/ieee1394/sbp2.c
+++ b/drivers/ieee1394/sbp2.c
@@ -2020,6 +2020,8 @@ static int sbp2scsi_slave_configure(stru
 	blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
 	sdev->use_10_for_rw = 1;
 
+	if (sdev->type == TYPE_ROM)
+		sdev->use_10_for_ms = 1;
 	if (sdev->type == TYPE_DISK &&
 	    lu->workarounds & SBP2_WORKAROUND_MODE_SENSE_8)
 		sdev->skip_ms_page_8 = 1;


-- 
Stefan Richter
-=====-=-=== ---= -=-=-
http://arcgraph.de/sr/

