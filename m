Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWBSQAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWBSQAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 11:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWBSQAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 11:00:22 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:6379 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750787AbWBSQAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 11:00:21 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] pktcdvd: Only return -EROFS when appropriate
References: <m37j7rbb4s.fsf@telia.com> <m33bifbb0l.fsf@telia.com>
	<m3y8079wb7.fsf_-_@telia.com> <m3u0av9w83.fsf_-_@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 19 Feb 2006 17:00:13 +0100
In-Reply-To: <m3u0av9w83.fsf_-_@telia.com>
Message-ID: <m3pslj9w4y.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to open the device for writing, only return -EROFS if
the disc appears to be readable but not writable.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index dec68d0..772b63c 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1598,7 +1598,7 @@ static int pkt_probe_settings(struct pkt
 	}
 
 	if (!pkt_writable_disc(pd, &di))
-		return -ENXIO;
+		return -EROFS;
 
 	pd->type = di.erasable ? PACKET_CDRW : PACKET_CDR;
 
@@ -1610,7 +1610,7 @@ static int pkt_probe_settings(struct pkt
 
 	if (!pkt_writable_track(pd, &ti)) {
 		printk("pktcdvd: can't write to this track\n");
-		return -ENXIO;
+		return -EROFS;
 	}
 
 	/*
@@ -1624,7 +1624,7 @@ static int pkt_probe_settings(struct pkt
 	}
 	if (pd->settings.size > PACKET_MAX_SECTORS) {
 		printk("pktcdvd: packet size is too big\n");
-		return -ENXIO;
+		return -EROFS;
 	}
 	pd->settings.fp = ti.fp;
 	pd->offset = (be32_to_cpu(ti.track_start) << 2) & (pd->settings.size - 1);
@@ -1666,7 +1666,7 @@ static int pkt_probe_settings(struct pkt
 			break;
 		default:
 			printk("pktcdvd: unknown data mode\n");
-			return 1;
+			return -EROFS;
 	}
 	return 0;
 }
@@ -1877,7 +1877,7 @@ static int pkt_open_write(struct pktcdvd
 
 	if ((ret = pkt_probe_settings(pd))) {
 		VPRINTK("pktcdvd: %s failed probe\n", pd->name);
-		return -EROFS;
+		return ret;
 	}
 
 	if ((ret = pkt_set_write_settings(pd))) {

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
