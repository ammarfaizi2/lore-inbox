Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbVHJShc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbVHJShc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbVHJShc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:37:32 -0400
Received: from mail.dvmed.net ([216.237.124.58]:5793 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965247AbVHJShb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:37:31 -0400
Message-ID: <42FA4963.5060507@pobox.com>
Date: Wed, 10 Aug 2005 14:37:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x libata fixes
Content-Type: multipart/mixed;
 boundary="------------070305070007070704000300"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070305070007070704000300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from the 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the two fixes described in the attached diffstat/changelog/patch.


--------------070305070007070704000300
Content-Type: text/plain;
 name="libata-dev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev.txt"

 drivers/scsi/libata-scsi.c |    1 +
 drivers/scsi/sata_sx4.c    |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)



commit 42517438f9c1011a03e49a542cba32ac5a80dd8e
Author: Tejun Heo <htejun@gmail.com>
Date:   Wed Aug 10 13:38:27 2005 -0400

    libata: fix EH-related lockup by properly cleaning EH command list
    
    Yet another hack due to the fact that libata is the only user of SCSI's
    ->eh_strategy_handler() hook.

commit fae009847c9ea3d668bbee21ce1d76764eca5039
Author: Tejun Heo <htejun@gmail.com>
Date:   Sun Aug 7 14:53:40 2005 +0900

    [PATCH] sata: fix sata_sx4 dma_prep to not use sg->length
    
     sata_sx4 directly references sg->length to calculate total_len in
    pdc20621_dma_prep().  This is incorrect as dma_map_sg() could have
    merged multiple sg's into one and, in such case, sg->length doesn't
    reflect true size of the entry.  This patch makes it use
    sg_dma_len(sg).
    
    Signed-off-by: Tejun Heo <htejun@gmail.com>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>



diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -385,6 +385,7 @@ int ata_scsi_error(struct Scsi_Host *hos
 	 * appropriate place
 	 */
 	host->host_failed--;
+	INIT_LIST_HEAD(&host->eh_cmd_q);
 
 	DPRINTK("EXIT\n");
 	return 0;
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -468,7 +468,7 @@ static void pdc20621_dma_prep(struct ata
 	for (i = 0; i < last; i++) {
 		buf[idx++] = cpu_to_le32(sg_dma_address(&sg[i]));
 		buf[idx++] = cpu_to_le32(sg_dma_len(&sg[i]));
-		total_len += sg[i].length;
+		total_len += sg_dma_len(&sg[i]);
 	}
 	buf[idx - 1] |= cpu_to_le32(ATA_PRD_EOT);
 	sgt_len = idx * 4;

--------------070305070007070704000300--
