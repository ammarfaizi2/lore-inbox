Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUGGKH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUGGKH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 06:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUGGKH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 06:07:28 -0400
Received: from av4-2-sn3.vrr.skanova.net ([81.228.9.112]:9869 "EHLO
	av4-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S265040AbUGGKGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 06:06:54 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
References: <m2lli36ec9.fsf@telia.com> <20040704130544.GA3825@infradead.org>
From: Peter Osterlund <petero2@telia.com>
Date: 07 Jul 2004 12:06:44 +0200
In-Reply-To: <20040704130544.GA3825@infradead.org>
Message-ID: <m2r7rot9l7.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> > +static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
> > +{
> > +	struct block_device *bdev;
> > +
> > +	atomic_dec(&pd->refcnt);
> > +	if (atomic_read(&pd->refcnt) > 0)
> > +		return;
> > +
> > +	bdev = bdget(pd->pkt_dev);
> > +	if (bdev) {
> 
> You reallu should keep a reference to the underlying bdev as long as you use
> it

Remove pkt_dev from struct pktcdvd_device in the pktcdvd driver and
remove unnecessary calls to bdget(). Suggested by Christoph Hellwig.

Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/block/pktcdvd.c |   20 ++++----------------
 linux-petero/include/linux/pktcdvd.h |    1 -
 2 files changed, 4 insertions(+), 17 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-bdev drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-bdev	2004-07-06 21:39:26.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-06 23:47:54.243208280 +0200
@@ -1990,7 +1990,6 @@ static void pkt_release_dev(struct pktcd
 static int pkt_open(struct inode *inode, struct file *file)
 {
 	struct pktcdvd_device *pd = NULL;
-	struct block_device *pkt_bdev;
 	int ret;
 	int special_open, exclusive;
 
@@ -2047,11 +2046,7 @@ static int pkt_open(struct inode *inode,
 	 * needed here as well, since ext2 (among others) may change
 	 * the blocksize at mount time
 	 */
-	pkt_bdev = bdget(inode->i_rdev);
-	if (pkt_bdev) {
-		set_blocksize(pkt_bdev, CD_FRAMESIZE);
-		bdput(pkt_bdev);
-	}
+	set_blocksize(inode->i_bdev, CD_FRAMESIZE);
 
 done:
 	up(&pd->ctl_mutex);
@@ -2432,21 +2427,15 @@ out:
 	return ret;
 }
 
-static int pkt_remove_dev(struct pktcdvd_device *pd)
+static int pkt_remove_dev(struct pktcdvd_device *pd, struct block_device *bdev)
 {
-	struct block_device *bdev;
-
 	if (!IS_ERR(pd->cdrw.thread))
 		kthread_stop(pd->cdrw.thread);
 
 	/*
 	 * will also invalidate buffers for CD-ROM
 	 */
-	bdev = bdget(pd->pkt_dev);
-	if (bdev) {
-		invalidate_bdev(bdev, 1);
-		bdput(bdev);
-	}
+	invalidate_bdev(bdev, 1);
 
 	pkt_shrink_pktlist(pd);
 
@@ -2508,7 +2497,7 @@ static int pkt_ioctl(struct inode *inode
 		if (pd->refcnt != 1)
 			ret = -EBUSY;
 		else
-			ret = pkt_remove_dev(pd);
+			ret = pkt_remove_dev(pd, inode->i_bdev);
 		up(&pd->ctl_mutex);
 		return ret;
 
@@ -2579,7 +2568,6 @@ int pkt_init(void)
 
 		spin_lock_init(&pd->lock);
 		spin_lock_init(&pd->iosched.lock);
-		pd->pkt_dev = MKDEV(PACKET_MAJOR, i);
 		sprintf(pd->name, "pktcdvd%d", i);
 		init_waitqueue_head(&pd->wqueue);
 		init_MUTEX(&pd->ctl_mutex);
diff -puN include/linux/pktcdvd.h~packet-bdev include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~packet-bdev	2004-07-06 21:39:26.000000000 +0200
+++ linux-petero/include/linux/pktcdvd.h	2004-07-06 23:47:54.244208128 +0200
@@ -230,7 +230,6 @@ struct pktcdvd_device
 {
 	struct block_device	*bdev;		/* dev attached */
 	dev_t			dev;		/* dev attached */
-	dev_t			pkt_dev;	/* our dev */
 	char			name[20];
 	struct packet_settings	settings;
 	struct packet_stats	stats;
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
