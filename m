Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWBSP6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWBSP6c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 10:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWBSP6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 10:58:32 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:39627 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750781AbWBSP6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 10:58:31 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] pktcdvd: Fix the logic in the pkt_writable_track function
References: <m37j7rbb4s.fsf@telia.com> <m33bifbb0l.fsf@telia.com>
	<m3y8079wb7.fsf_-_@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 19 Feb 2006 16:58:20 +0100
In-Reply-To: <m3y8079wb7.fsf_-_@telia.com>
Message-ID: <m3u0av9w83.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the pkt_writable_track() function to make it work correctly for
all types of CD/DVD discs.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index dba5ce7..dec68d0 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1500,28 +1500,30 @@ static int pkt_set_write_settings(struct
 /*
  * 1 -- we can write to this track, 0 -- we can't
  */
-static int pkt_writable_track(track_information *ti)
+static int pkt_writable_track(struct pktcdvd_device *pd, track_information *ti)
 {
-	/*
-	 * only good for CD-RW at the moment, not DVD-RW
-	 */
+	switch (pd->mmc3_profile) {
+		case 0x1a: /* DVD+RW */
+		case 0x12: /* DVD-RAM */
+			/* The track is always writable on DVD+RW/DVD-RAM */
+			return 1;
+		default:
+			break;
+	}
 
-	/*
-	 * FIXME: only for FP
-	 */
-	if (ti->fp == 0)
-		return 1;
+	if (!ti->packet || !ti->fp)
+		return 0;
 
 	/*
 	 * "good" settings as per Mt Fuji.
 	 */
-	if (ti->rt == 0 && ti->blank == 0 && ti->packet == 1)
+	if (ti->rt == 0 && ti->blank == 0)
 		return 1;
 
-	if (ti->rt == 0 && ti->blank == 1 && ti->packet == 1)
+	if (ti->rt == 0 && ti->blank == 1)
 		return 1;
 
-	if (ti->rt == 1 && ti->blank == 0 && ti->packet == 1)
+	if (ti->rt == 1 && ti->blank == 0)
 		return 1;
 
 	printk("pktcdvd: bad state %d-%d-%d\n", ti->rt, ti->blank, ti->packet);
@@ -1606,7 +1608,7 @@ static int pkt_probe_settings(struct pkt
 		return ret;
 	}
 
-	if (!pkt_writable_track(&ti)) {
+	if (!pkt_writable_track(pd, &ti)) {
 		printk("pktcdvd: can't write to this track\n");
 		return -ENXIO;
 	}

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
