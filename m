Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVIKQmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVIKQmM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVIKQmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:42:12 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:43673 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964872AbVIKQmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:42:12 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Fix bogus BUG_ON in pktcdvd
From: Peter Osterlund <petero2@telia.com>
Date: 11 Sep 2005 18:42:01 +0200
Message-ID: <m3irx7v9nq.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the packet writing driver, if the drive reports a packet size
larger than the driver can handle, bail out safely instead of
triggering a BUG_ON.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -946,7 +946,6 @@ try_next_bio:
 	pd->current_sector = zone + pd->settings.size;
 	pkt->sector = zone;
 	pkt->frames = pd->settings.size >> 2;
-	BUG_ON(pkt->frames > PACKET_MAX_SIZE);
 	pkt->write_size = 0;
 
 	/*
@@ -1636,6 +1635,10 @@ static int pkt_probe_settings(struct pkt
 		printk("pktcdvd: detected zero packet size!\n");
 		pd->settings.size = 128;
 	}
+	if (pd->settings.size > PACKET_MAX_SECTORS) {
+		printk("pktcdvd: packet size is too big\n");
+		return -ENXIO;
+	}
 	pd->settings.fp = ti.fp;
 	pd->offset = (be32_to_cpu(ti.track_start) << 2) & (pd->settings.size - 1);
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
