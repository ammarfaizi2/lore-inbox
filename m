Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSFTF6V>; Thu, 20 Jun 2002 01:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSFTF6U>; Thu, 20 Jun 2002 01:58:20 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12909 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314680AbSFTF6R>; Thu, 20 Jun 2002 01:58:17 -0400
Date: Thu, 20 Jun 2002 07:59:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre10aa3
Message-ID: <20020620055933.GA1308@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the o1 sched bits (so in turn breaks alpha :-/ any patch
fixing alpha is welcome of course).  Also not yet sure if DaveM is ok
with the removal of prepare_to_switch, his last comment on that is
negative as far I could see. However this was needed for x86, and it
appears it could make a differece for the uml hang too. However I
rejected the sched_yield changes that looked dubious, see below for
details, Robert you may want to apply this o1 stuff to your o1 sched
patch, it's all incremental to it against mainline.

Also merges some stuff from 19pre10jam2, not all the same, in particular
irq-balance is quite different, previous algorithm looked not really
good while auditing it, benchmarks will tell, any feedback on this in
particular would be welcome. Have a look at xosview to see the
difference.

Then drops the intepeer cache under Andi's suggestion (I pretty much
agree with his arguments about NAT etc.., and personally in particular
I'm glad the collision-prone write_seq ^ jiffies gone away).

Some elevator-fix as well, maybe I overlooked something but the -=count
in the cleanup callbacks looked completely broken, see the comment in
the patch too.

The rest should be quite strightforward, all details below.

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa3.gz
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa3/

Only in 2.4.19pre10aa2: 00_block-highmem-all-18b-12.gz
Only in 2.4.19pre10aa3: 00_block-highmem-all-19-1.gz

	Latest version from Jens + enable highio on serverworks.

Only in 2.4.19pre10aa3: 00_drop-inetpeer-cache-1.gz

	Drop inetpeer cache, we cannot make per-IP assumption
	or we'll break with NAT. This avoids AVL complexity
	in handling tcp connections. From Andi Kleen.

	Further comments from me: previous afinet.id could also collide during
	the connection because of the xor between jiffies and the initial
	write_seq. Still it can collide if it's too fast but it's very unlikely
	now. I also changed the GRAB_TIME from HZ/50 to HZ, so we don't waste
	id space, 32 packets per second looks saner (and in a 1 second
	timeframe the global id is not likely to overflow).

Only in 2.4.19pre10aa3: 00_elevator-fixes-1

	Merged the "merge_only" logic from Andrew's read-latency patch.
	Also noticed some apparently buggy stuff in the elevator, so corrected.
	There's no point to do "sequence--" when we insert new requests and to
	do "sequence -= count" when we merge (on top of the --!), if something
	it should be the opposite, merges are much lighter than new requests
	for the disk (let's ignore when we cannot merge because of
	max_sectors). So let's only rely on the --.

Only in 2.4.19pre10aa3: 00_ext3-0.9.18.gz

	Merged ext3 updates from 2.4.19pre10jam2.

Only in 2.4.19pre10aa3: 00_nfs-dcache-parent-optimize-1

	Trond's parent lookup optimization.

Only in 2.4.19pre10aa3: 00_spinlock-no-egcs-1

	Keep the spinlock structure the same across 2.95 and 3.x
	(I got a bugreport due a miscompiled kernel with egcs
	some week ago, so I don't care much about the buggy egcs
	anymore, stable is 2.95, and bleeding edge is 3.1.1).

Only in 2.4.19pre10aa2: 03_sched-pipe-bandwidth-1

	Obsoleted patch by 20_o1-sched-updates-A4-1, but the internals
	are exactly the same, so still the feature from Mike is retained.

	Also note I'm not using the _sync version in the read() path,
	only in the write() path, I explained why in some email to l-k
	(if you cannot find it ask). Due a mistake the previous
	sched-pipe-bandiwidth-1 had the _sync in the read instead of the
	write but conceptually I prefer it only in the write, even if
	I doubt any difference could be measured in real life (either one of
	the two places or both should be almost the same in practice, it's
	more a microfeature).

Only in 2.4.19pre10aa3: 07_cpqarray-sard-1
Only in 2.4.19pre10aa3: 07_cpqfc-compile-1

	cpq fc minor updates.

Only in 2.4.19pre10aa3: 07_e100-1.8.38.gz
Only in 2.4.19pre10aa3: 08_e100-includes-1
Only in 2.4.19pre10aa3: 09_e100-compilehack-1

	Merged e100 GPL driver from Intel (also make it link
	into the kernel).

Only in 2.4.19pre10aa3: 07_qlogicfc-1.gz
Only in 2.4.19pre10aa3: 08_qlogicfc-template-aa-1
Only in 2.4.19pre10aa3: 09_qlogic-link-1

	Latest qlogic FC driver for the qla2x00 devices. Ported
	to -aa enabled highio and vary_io, and fixed so that
	it can be linked into the kernel too.

Only in 2.4.19pre10aa3: 20_o1-sched-updates-A4-1

	O1 scheduler fixes from Ingo, includes the 03_sched-pipe-bandwidth-1
	feature from Mike.

Only in 2.4.19pre10aa3: 21_o1-A4-aa-1

	Some more incremental O1 cleanup on top of Ingo's changes (note:
	not all of them, in particular rejected the sched_yield changes
	that wrongly waits the timeslice to expire before giving the
	cpu to the next task in the runqueue). Also the rq_lock rejected,
	see the comment on the patch, -preempt is a no-way for 2.4, so
	we can a bit more efficient thanks to it.

Only in 2.4.19pre10aa3: 30_irq-balance-12

	Merged irq balance from 2.4.19pre10jam2. The algorithm here is very
	different from the original one that seems wasteful to me, this new
	one should do much better, benchmarks will tell. Also the
	implementation is more optimized, and buggy places like idle_timeout
	are also corrected. also have a look at the difference in xosview.

Only in 2.4.19pre10aa3: 50_uml-patch-2.4.18-34.gz

	Updated to -34 uml revision from Jeff.

Only in 2.4.19pre10aa3: 90_buddyinfo-1

	Statistics about the buddy allocator available from /proc/buddyinfo.

Only in 2.4.19pre10aa3: 94_discontigmem-meminfo-1

	Provides per-node mem info stats in /proc/meminfo. Note: unlike
	the original patch this is based on DISCONTIGMEM and not on NUMA.
	This feature only depends on discontigmem, so there's no reason
	to enable it only with numa selected (and the cost of it is not
	significant).

Only in 2.4.19pre10aa3: 94_numaq-tsc-1

	Disable tsc based gettimeofday on numaq. This is also different
	from the original patch, please check, thanks.

Andrea
