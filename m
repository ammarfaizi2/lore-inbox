Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWBSPxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWBSPxk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 10:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWBSPxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 10:53:40 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:13216 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750774AbWBSPxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 10:53:39 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] pktcdvd: Rename functions and make their return values sane
References: <m37j7rbb4s.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 19 Feb 2006 16:53:30 +0100
In-Reply-To: <m37j7rbb4s.fsf@telia.com>
Message-ID: <m33bifbb0l.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boolean functions should return non-zero when they mean "true",
otherwise the calling code looks weird. (As suggested by Linus.)

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 5276d66..12ff6d8 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1498,9 +1498,9 @@ static int pkt_set_write_settings(struct
 }
 
 /*
- * 0 -- we can write to this track, 1 -- we can't
+ * 1 -- we can write to this track, 0 -- we can't
  */
-static int pkt_good_track(track_information *ti)
+static int pkt_writable_track(track_information *ti)
 {
 	/*
 	 * only good for CD-RW at the moment, not DVD-RW
@@ -1510,28 +1510,28 @@ static int pkt_good_track(track_informat
 	 * FIXME: only for FP
 	 */
 	if (ti->fp == 0)
-		return 0;
+		return 1;
 
 	/*
 	 * "good" settings as per Mt Fuji.
 	 */
 	if (ti->rt == 0 && ti->blank == 0 && ti->packet == 1)
-		return 0;
+		return 1;
 
 	if (ti->rt == 0 && ti->blank == 1 && ti->packet == 1)
-		return 0;
+		return 1;
 
 	if (ti->rt == 1 && ti->blank == 0 && ti->packet == 1)
-		return 0;
+		return 1;
 
 	printk("pktcdvd: bad state %d-%d-%d\n", ti->rt, ti->blank, ti->packet);
-	return 1;
+	return 0;
 }
 
 /*
- * 0 -- we can write to this disc, 1 -- we can't
+ * 1 -- we can write to this disc, 0 -- we can't
  */
-static int pkt_good_disc(struct pktcdvd_device *pd, disc_information *di)
+static int pkt_writable_disc(struct pktcdvd_device *pd, disc_information *di)
 {
 	switch (pd->mmc3_profile) {
 		case 0x0a: /* CD-RW */
@@ -1540,10 +1540,10 @@ static int pkt_good_disc(struct pktcdvd_
 		case 0x1a: /* DVD+RW */
 		case 0x13: /* DVD-RW */
 		case 0x12: /* DVD-RAM */
-			return 0;
+			return 1;
 		default:
 			VPRINTK("pktcdvd: Wrong disc profile (%x)\n", pd->mmc3_profile);
-			return 1;
+			return 0;
 	}
 
 	/*
@@ -1552,25 +1552,25 @@ static int pkt_good_disc(struct pktcdvd_
 	 */
 	if (di->disc_type == 0xff) {
 		printk("pktcdvd: Unknown disc. No track?\n");
-		return 1;
+		return 0;
 	}
 
 	if (di->disc_type != 0x20 && di->disc_type != 0) {
 		printk("pktcdvd: Wrong disc type (%x)\n", di->disc_type);
-		return 1;
+		return 0;
 	}
 
 	if (di->erasable == 0) {
 		printk("pktcdvd: Disc not erasable\n");
-		return 1;
+		return 0;
 	}
 
 	if (di->border_status == PACKET_SESSION_RESERVED) {
 		printk("pktcdvd: Can't write to last track (reserved)\n");
-		return 1;
+		return 0;
 	}
 
-	return 0;
+	return 1;
 }
 
 static int pkt_probe_settings(struct pktcdvd_device *pd)
@@ -1595,7 +1595,7 @@ static int pkt_probe_settings(struct pkt
 		return ret;
 	}
 
-	if (pkt_good_disc(pd, &di))
+	if (!pkt_writable_disc(pd, &di))
 		return -ENXIO;
 
 	switch (pd->mmc3_profile) {
@@ -1620,7 +1620,7 @@ static int pkt_probe_settings(struct pkt
 		return ret;
 	}
 
-	if (pkt_good_track(&ti)) {
+	if (!pkt_writable_track(&ti)) {
 		printk("pktcdvd: can't write to this track\n");
 		return -ENXIO;
 	}

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
