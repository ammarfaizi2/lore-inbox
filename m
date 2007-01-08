Return-Path: <linux-kernel-owner+w=401wt.eu-S932558AbXAHIwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbXAHIwQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbXAHIwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:52:16 -0500
Received: from brick.kernel.dk ([62.242.22.158]:28607 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558AbXAHIwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:52:15 -0500
Date: Mon, 8 Jan 2007 09:52:46 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Torsten Kaiser <kernel@bardioc.dyndns.org>
Cc: Andrew Morton <akpm@osdl.org>, Fengguang Wu <fengguang.wu@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.20-rc3-mm1] raid1 mount blocks for ever
Message-ID: <20070108085245.GR11203@kernel.dk>
References: <368051775.16914@ustc.edu.cn> <200701061052.00455.kernel@bardioc.dyndns.org> <20070106100255.GH11203@kernel.dk> <200701061130.07467.kernel@bardioc.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701061130.07467.kernel@bardioc.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06 2007, Torsten Kaiser wrote:
> On Saturday 06 January 2007 11:02, Jens Axboe wrote:
> > On Sat, Jan 06 2007, Torsten Kaiser wrote:
> > > On Saturday 06 January 2007 04:59, Andrew Morton wrote:
> > > > http://userweb.kernel.org/~akpm/2.6.20-rc3-mm1x.bz2 is basically
> > > > 2.6.20-rc3-mm1, minus git-block.patch.  Can you and Torsten please
> > > > test that, see if the hangs go away?
> > >
> > > Works for me too.
> >
> > Torsten, can you test XFS with barriers disabled? I have a feeling that
> > is where the problem lies.
> 
> With your patch from Bug 7775: Same hang detected by NMI watchdog

Does this fix it? Only apply this one, not the patch from 7775.

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index ec40e44..bae57e0 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -1542,7 +1542,7 @@ static inline void queue_sync_plugs(request_queue_t *q)
 	 * If the current process is plugged and has barriers submitted,
 	 * we will livelock if we don't unplug first.
 	 */
-	blk_unplug_current();
+	blk_replug_current_nested();
 
 	synchronize_qrcu(&q->qrcu);
 }

-- 
Jens Axboe

