Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVF2PGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVF2PGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVF2PGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:06:21 -0400
Received: from silver.veritas.com ([143.127.12.111]:46442 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261324AbVF2PGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:06:11 -0400
Date: Wed, 29 Jun 2005 16:07:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Tomasz Torcz <zdzichu@irc.pl>
cc: "Ronny V. Vindenes" <s864@ii.uib.no>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13-rc1
In-Reply-To: <20050629145806.GA5803@irc.pl>
Message-ID: <Pine.LNX.4.61.0506291604340.14413@goblin.wat.veritas.com>
References: <4kEoS-Am-3@gated-at.bofh.it> <m37jgd9r8w.fsf@localhost.localdomain>
 <20050629145806.GA5803@irc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 29 Jun 2005 15:06:10.0936 (UTC) FILETIME=[15AE2F80:01C57CBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Tomasz Torcz wrote:
> On Wed, Jun 29, 2005 at 04:23:11PM +0200, Ronny V. Vindenes wrote:
> > 
> > On x86_64 with reiserfs and ext3 on dm (using cfq scheduler) the log
> > is full of this:
> > 
> > Badness in blk_remove_plug at drivers/block/ll_rw_blk.c:1424
> 
>  Also on x86, Reiserfs on LVM2, cfq, on sata_sil; Preemption set to
> Voluntary.

You should find the patch I posted just a little earlier fixes all that...

get_request is now expected to be holding on to queue_lock, with interrupts
disabled, when it returns NULL; but one path forgot that, causing all kinds
of nastiness under swap load - badness backtraces, strange failures, BUGs.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.13-rc1/drivers/block/ll_rw_blk.c	2005-06-29 11:54:08.000000000 +0100
+++ linux/drivers/block/ll_rw_blk.c	2005-06-29 14:41:04.000000000 +0100
@@ -1917,10 +1917,9 @@ get_rq:
 	 * limit of requests, otherwise we could have thousands of requests
 	 * allocated with any setting of ->nr_requests
 	 */
-	if (rl->count[rw] >= (3 * q->nr_requests / 2)) {
-		spin_unlock_irq(q->queue_lock);
+	if (rl->count[rw] >= (3 * q->nr_requests / 2))
 		goto out;
-	}
+
 	rl->count[rw]++;
 	rl->starved[rw] = 0;
 	if (rl->count[rw] >= queue_congestion_on_threshold(q))
