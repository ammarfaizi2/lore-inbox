Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbVK3RN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbVK3RN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbVK3RN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:13:57 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:1873 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751462AbVK3RN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:13:56 -0500
Date: Wed, 30 Nov 2005 19:15:20 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Marcelo <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.x] prevent emulated SCSI hosts from wasting DMA memory
Message-ID: <20051130171520.GB15505@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emulated scsi hosts don't do DMA, so don't unnecessarily increase
the SCSI DMA pool.

Signed-off-by: Dan Aloni <da-x@monatomic.org>

---
commit 8f6409c7c270038ca4d154551e061f66a9580301
tree ab7fedd2e7dbaefe31c332fc487f45a005972571
parent a0837aece47b79a2bfd524e70e4f8a559c743c4c
author Dan Aloni <da-x@monatomic.org> Wed, 30 Nov 2005 18:14:11 +0200
committer Dan Aloni <da-x@monatomic.org> Wed, 30 Nov 2005 18:14:11 +0200

 drivers/scsi/scsi_dma.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/scsi_dma.c b/drivers/scsi/scsi_dma.c
index 5594828..52737d6 100644
--- a/drivers/scsi/scsi_dma.c
+++ b/drivers/scsi/scsi_dma.c
@@ -231,10 +231,17 @@ void scsi_resize_dma_pool(void)
 		need_isa_bounce_buffers = 0;
 
 	if (scsi_devicelist)
-		for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next)
+		for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
+			if (shpnt->hostt->emulated)
+				continue;
+
 			new_dma_sectors += SECTORS_PER_PAGE;	/* Increment for each host */
+		}
 
 	for (host = scsi_hostlist; host; host = host->next) {
+		if (host->hostt->emulated)
+			continue;
+
 		for (SDpnt = host->host_queue; SDpnt; SDpnt = SDpnt->next) {
 			/*
 			 * sd and sr drivers allocate scatterlists.


-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
