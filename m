Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUHBSQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUHBSQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUHBSQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:16:12 -0400
Received: from av2-1-sn3.vrr.skanova.net ([81.228.9.107]:40138 "EHLO
	av2-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S266720AbUHBSPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:15:38 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Aug 2004 20:15:35 +0200
In-Reply-To: <20040802015527.49088944.akpm@osdl.org>
Message-ID: <m365815rug.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm2/
> 
> Changes since 2.6.8-rc2-mm1:
> 
> +packet-door-unlock.patch
> +pkt_lock_door-warning-fix.patch

The door-unlock patch got mis-merged, which caused the need for the
warning fix patch.  pkt_lock_door should be called from
pkt_release_dev, not from pkt_generic_packet.  This patch fixes it.

Signed-off-by: Peter Osterlund <petero2@telia.com>


--- linux/drivers/block/pktcdvd.c	2004-08-02 19:53:53.465566752 +0200
+++ ../cdr/linux/drivers/block/pktcdvd.c	2004-08-02 20:03:10.960162040 +0200
@@ -72,7 +72,6 @@ static struct proc_dir_entry *pkt_proc;
 static int pkt_major;
 static struct semaphore ctl_mutex;	/* Serialize open/close/setup/teardown */
 
-static int pkt_lock_door(struct pktcdvd_device *pd, int lockflag);
 
 static struct pktcdvd_device *pkt_find_dev(request_queue_t *q)
 {
@@ -304,8 +303,6 @@ static int pkt_generic_packet(struct pkt
 	DECLARE_COMPLETION(wait);
 	int err = 0;
 
-	pkt_lock_door(pd, 0);
-
 	q = bdev_get_queue(pd->bdev);
 
 	rq = blk_get_request(q, (cgc->data_direction == CGC_DATA_WRITE) ? WRITE : READ,
@@ -1956,6 +1953,8 @@ static void pkt_release_dev(struct pktcd
 	if (flush && pkt_flush_cache(pd))
 		DPRINTK("pktcdvd: %s not flushing cache\n", pd->name);
 
+	pkt_lock_door(pd, 0);
+
 	q = bdev_get_queue(pd->bdev);
 	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
 	spin_lock_irq(q->queue_lock);

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
