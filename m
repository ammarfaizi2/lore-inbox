Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVIKQsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVIKQsM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVIKQsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:48:11 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:40101 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964947AbVIKQsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:48:10 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] pktcdvd: BUG_ON cleanups
References: <m3irx7v9nq.fsf@telia.com> <m3ek7vv9lr.fsf@telia.com>
	<m3acijv9ix.fsf_-_@telia.com> <m364t7v9gr.fsf_-_@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Sep 2005 18:47:57 +0200
In-Reply-To: <m364t7v9gr.fsf_-_@telia.com>
Message-ID: <m31x3vv9du.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some redundant BUG_ON() statements in pktcdvd and move one
run-time check to compile-time.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    9 +++------
 include/linux/pktcdvd.h |    3 +++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -669,7 +669,6 @@ static void pkt_make_local_copy(struct p
 		}
 		offs += CD_FRAMESIZE;
 		if (offs >= PAGE_SIZE) {
-			BUG_ON(offs > PAGE_SIZE);
 			offs = 0;
 			p++;
 		}
@@ -804,10 +803,11 @@ static struct packet_data *pkt_get_packe
 			list_del_init(&pkt->list);
 			if (pkt->sector != zone)
 				pkt->cache_valid = 0;
-			break;
+			return pkt;
 		}
 	}
-	return pkt;
+	BUG();
+	return NULL;
 }
 
 static void pkt_put_packet_data(struct pktcdvd_device *pd, struct packet_data *pkt)
@@ -951,7 +951,6 @@ try_next_bio:
 	}
 
 	pkt = pkt_get_packet_data(pd, zone);
-	BUG_ON(!pkt);
 
 	pd->current_sector = zone + pd->settings.size;
 	pkt->sector = zone;
@@ -2211,7 +2210,6 @@ static int pkt_make_request(request_queu
 	 * No matching packet found. Store the bio in the work queue.
 	 */
 	node = mempool_alloc(pd->rb_pool, GFP_NOIO);
-	BUG_ON(!node);
 	node->bio = bio;
 	spin_lock(&pd->lock);
 	BUG_ON(pd->bio_queue_size < 0);
@@ -2419,7 +2417,6 @@ static int pkt_ioctl(struct inode *inode
 	struct pktcdvd_device *pd = inode->i_bdev->bd_disk->private_data;
 
 	VPRINTK("pkt_ioctl: cmd %x, dev %d:%d\n", cmd, imajor(inode), iminor(inode));
-	BUG_ON(!pd);
 
 	switch (cmd) {
 	/*
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -166,6 +166,9 @@ struct packet_iosched
 /*
  * 32 buffers of 2048 bytes
  */
+#if (PAGE_SIZE % CD_FRAMESIZE) != 0
+#error "PAGE_SIZE must be a multiple of CD_FRAMESIZE"
+#endif
 #define PACKET_MAX_SIZE		32
 #define PAGES_PER_PACKET	(PACKET_MAX_SIZE * CD_FRAMESIZE / PAGE_SIZE)
 #define PACKET_MAX_SECTORS	(PACKET_MAX_SIZE * CD_FRAMESIZE >> 9)

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
