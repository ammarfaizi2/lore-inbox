Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVIKQpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVIKQpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVIKQpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:45:05 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:12703 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964871AbVIKQpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:45:03 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] pktcdvd: More accurate I/O accounting
References: <m3irx7v9nq.fsf@telia.com> <m3ek7vv9lr.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Sep 2005 18:44:54 +0200
In-Reply-To: <m3ek7vv9lr.fsf@telia.com>
Message-ID: <m3acijv9ix.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the /proc statistics, only count writes that upper layers have
requested. Don't count additional writes created inside the packet
driver to satisfy the requirement to only write full packets.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -736,12 +736,6 @@ static void pkt_gather_data(struct pktcd
 	atomic_set(&pkt->io_wait, 0);
 	atomic_set(&pkt->io_errors, 0);
 
-	if (pkt->cache_valid) {
-		VPRINTK("pkt_gather_data: zone %llx cached\n",
-			(unsigned long long)pkt->sector);
-		goto out_account;
-	}
-
 	/*
 	 * Figure out which frames we need to read before we can write.
 	 */
@@ -750,6 +744,7 @@ static void pkt_gather_data(struct pktcd
 	for (bio = pkt->orig_bios; bio; bio = bio->bi_next) {
 		int first_frame = (bio->bi_sector - pkt->sector) / (CD_FRAMESIZE >> 9);
 		int num_frames = bio->bi_size / CD_FRAMESIZE;
+		pd->stats.secs_w += num_frames * (CD_FRAMESIZE >> 9);
 		BUG_ON(first_frame < 0);
 		BUG_ON(first_frame + num_frames > pkt->frames);
 		for (f = first_frame; f < first_frame + num_frames; f++)
@@ -757,6 +752,12 @@ static void pkt_gather_data(struct pktcd
 	}
 	spin_unlock(&pkt->lock);
 
+	if (pkt->cache_valid) {
+		VPRINTK("pkt_gather_data: zone %llx cached\n",
+			(unsigned long long)pkt->sector);
+		goto out_account;
+	}
+
 	/*
 	 * Schedule reads for missing parts of the packet.
 	 */
@@ -790,7 +791,6 @@ out_account:
 		frames_read, (unsigned long long)pkt->sector);
 	pd->stats.pkt_started++;
 	pd->stats.secs_rg += frames_read * (CD_FRAMESIZE >> 9);
-	pd->stats.secs_w += pd->settings.size;
 }
 
 /*

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
