Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVKHQeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVKHQeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVKHQeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:34:46 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:26009 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932462AbVKHQep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:34:45 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pktcdvd: Use bd_claim to get exclusive access
References: <m3mzkfayx5.fsf@telia.com> <m3irv3ayte.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Nov 2005 17:34:36 +0100
In-Reply-To: <m3irv3ayte.fsf@telia.com>
Message-ID: <m38xvzayjn.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use bd_claim() when opening the cdrom device to prevent user space
programs such as cdrecord, hald and kded from interfering with the
burning process.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 59e5982..78dbea3 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1955,9 +1955,12 @@ static int pkt_open_dev(struct pktcdvd_d
 	if ((ret = blkdev_get(pd->bdev, FMODE_READ, O_RDONLY)))
 		goto out;
 
+	if ((ret = bd_claim(pd->bdev, pd)))
+		goto out_putdev;
+
 	if ((ret = pkt_get_last_written(pd, &lba))) {
 		printk("pktcdvd: pkt_get_last_written failed\n");
-		goto out_putdev;
+		goto out_unclaim;
 	}
 
 	set_capacity(pd->disk, lba << 2);
@@ -1967,7 +1970,7 @@ static int pkt_open_dev(struct pktcdvd_d
 	q = bdev_get_queue(pd->bdev);
 	if (write) {
 		if ((ret = pkt_open_write(pd)))
-			goto out_putdev;
+			goto out_unclaim;
 		/*
 		 * Some CDRW drives can not handle writes larger than one packet,
 		 * even if the size is a multiple of the packet size.
@@ -1982,13 +1985,15 @@ static int pkt_open_dev(struct pktcdvd_d
 	}
 
 	if ((ret = pkt_set_segment_merging(pd, q)))
-		goto out_putdev;
+		goto out_unclaim;
 
 	if (write)
 		printk("pktcdvd: %lukB available on disc\n", lba << 1);
 
 	return 0;
 
+out_unclaim:
+	bd_release(pd->bdev);
 out_putdev:
 	blkdev_put(pd->bdev);
 out:
@@ -2007,6 +2012,7 @@ static void pkt_release_dev(struct pktcd
 	pkt_lock_door(pd, 0);
 
 	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
+	bd_release(pd->bdev);
 	blkdev_put(pd->bdev);
 }
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
