Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUH1U6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUH1U6g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUH1U6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:58:36 -0400
Received: from av3-2-sn3.vrr.skanova.net ([81.228.9.110]:34240 "EHLO
	av3-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S267828AbUH1U6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:58:06 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de>
	<m3llg5dein.fsf@telia.com> <20040824202951.GA24280@suse.de>
	<m3hdqsckoo.fsf@telia.com> <20040825065055.GA2321@suse.de>
	<m3u0unwplj.fsf@telia.com> <20040828130757.GA2397@suse.de>
	<m3zn4ff6jy.fsf@telia.com> <20040828124519.0caf23bf.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Aug 2004 22:57:56 +0200
In-Reply-To: <20040828124519.0caf23bf.akpm@osdl.org>
Message-ID: <m3vff3f0a3.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> > Is this a general VM limitation? Has anyone been able to saturate the
> >  write bandwidth of two different block devices at the same time, when
> >  they operate at vastly different speeds (45MB/s vs 5MB/s), and when
> >  the writes are large enough to cause memory pressure?
> 
> I haven't explicitly tested the pdflush code in a while, and I never tested
> on devices with such disparate bandwidth.  But it _should_ work.
> 
> The basic deign of the pdflush writeback path is:
> 
> 	for ( ; ; ) {
> 		for (each superblock) {
> 			if (no pdflush thread is working this sb's queue &&
> 			    the superblock's backingdev is not congested) {
> 				do some writeout, up to congestion, trying
> 				to not block on request queue exhaustion
> 			}
> 		}
> 		blk_congestion_wait()
> 	}
> 
> So it basically spins around all the queues keeping them full in a
> non-blocking manner.
> 
> There _are_ times when pdflush will accidentally block.  Say, doing a
> metadata read.  In that case other pdflush instances will keep other queues
> busy.
> 
> I tested it up to 12 disks.  Works OK.

OK, this should make sure that dirty data is flushed as fast as the
disks can handle, but is there anything that makes sure there will be
enough dirty data to flush for each disk?

Assume there are two processes writing one file each to two different
block devices. To be able to dirty more data a process will have to
allocate a page, and a page becomes available whenever one of the
disks finishes an I/O operation. If both processes have a 50/50 chance
to get the freed page, they will dirty data equally fast once steady
state has been reached, even if the block devices have very different
write bandwidths.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
