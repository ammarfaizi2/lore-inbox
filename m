Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282655AbRLRNIq>; Tue, 18 Dec 2001 08:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282705AbRLRNIi>; Tue, 18 Dec 2001 08:08:38 -0500
Received: from [194.234.65.222] ([194.234.65.222]:7046 "EHLO mustard.heime.net")
	by vger.kernel.org with ESMTP id <S282655AbRLRNIa>;
	Tue, 18 Dec 2001 08:08:30 -0500
Date: Tue, 18 Dec 2001 14:08:06 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Ingo Molnar <mingo@redhat.com>
cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] raid-2.5.1-I7
In-Reply-To: <Pine.LNX.4.33.0112172006060.29197-101000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.30.0112181407010.29293-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this have anything to do with the bug I've reported about 2.4.x
slowing down i/o after heavy sequencial read-only from >=50 files
concurrently? (see BUG raid subsys)

roy

On Mon, 17 Dec 2001, Ingo Molnar wrote:

>
> the attached patch (against 2.5.1-final) includes the next round of RAID-1
> improvements. First it completes the raid1.c cleanups i planned, and it
> also adds a number of new RAID-1 performance features.
>
> Changelog:
>
>  - cleaned up the resync engine. It got much simpler and easier to
>    maintain, while still saturating the disks. Resync doesnt get stuck
>    under heavy load anymore. (this code can be switched to use explicit IO
>    barrier requests in the future.)
>
>  - rewrote the read balancing code to use three estimators: a per-array
>    'next expected sequential IO' position, plus an IRQ-driven 'estimated
>    disk head' position. The head position is now updated from all the IO
>    completion routines: end of READ, end of WRITE, end of resync-READ, end
>    of resync-WRITE. I've added per-disk tracking of pending requests,
>    and the read balancer now detects idle disks and utilizes them before
>    trying to read-balance between busy disks. I've also removed the
>    sector_count limit that artificially switched the current disk. These
>    changes make read balancing more accurate and more effective.
>
>  - the old raid1 code used to have a limitation: it has always read from
>    the first disk until the resync finished. Now the code will
>    read-balance READ requests up to the resync boundary. This should
>    further improve performance during resyncs.
>
>  - added the 'idle IO resync' feature which we used to have in the 2.2
>    patches, but via a different implementation that does not touch the
>    generic block IO code. Resync happens only when there is no normal IO
>    pending on the array. This feature should make resync a more seemless
>    operation. Resync behavior can be tuned via the speed_limit_min and
>    speed_limit_max sysctl tunables. Default for the minimum resync speed
>    is 500 KB/sec, the maximum is 200 MB/sec.
>
>  - fixed a number of sector_t <=> unsigned long bugs still left.
>
> despite these new features added, the patch makes raid1.c 8% smaller, so
> it's a win-win situation :-) I've tested the patch on UP and SMP as well,
> and it's working just fine for me both in degraded-mode and normal mode,
> but the usual warnings (do not use on production system, etc.) apply.
>
> Comments, reports, suggestions welcome,
>
> 	Ingo
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

