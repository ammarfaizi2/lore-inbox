Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUB0Bff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbUB0BeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:34:03 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28547
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261700AbUB0BdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:33:22 -0500
Date: Fri, 27 Feb 2004 02:33:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040227013319.GT8834@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this includes some relevant fix for 2.4, if I missed something important
please let me know. I'm not following 2.4 mainline anymore since it's a
lot of work and I'm trying to ship with a 2.6-aa soon.

The most interesting part of this update is a vm improvement for the
high end machines, this makes it possible to swap several gigs
efficiently while doing I/O on the very high end
>=32G machines, this is for all archs (it's unrelated to x86 or the zone
normal). See below for details.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa2.gz

Diff between 2.4.23aa1 and 2.4.23aa2:

Only in 2.4.23aa2: 00_blkdev-eof-1

	Allow reading last block (write not).

Only in 2.4.23aa1: 00_csum-trail-1

	Obsoleted (can't trigger anymore).

Only in 2.4.23aa2: 00_elf-interp-check-arch-1

	Make sure interpreter is of the right architecture.

Only in 2.4.23aa1: 00_extraversion-33
Only in 2.4.23aa2: 00_extraversion-34

	Rediff.

Only in 2.4.23aa2: 00_mremap-1

	Various mremap fixes.

Only in 2.4.23aa2: 00_ncpfs-1

	Limit dentry name length (from Andi).

Only in 2.4.23aa2: 00_rawio-crash-1

	Handle partial get_user_pages correctly.

Only in 2.4.23aa2: 05_vm_28-shmem-big-iron-1

	Make it possible to swap efficiently huge amounts of shm. The
	stock 2.4 VM algorithm aren't capable of dealing with huge amounts
	of shm in huge machines. This has been a showstopper in production on
	32G boxes swapping regularly (the shm in this case wasn't pure fs cache
	like in oracle so it really had to be swapped out).

	There are three basic problems that interact in non obvious manners, all
	three fixed in this patch.

	1) This one is well known and infact it's already fixed in 2.6 mainline,
	too bad the way it's fixed in 2.6 mainline makes 2.6 unusable at all
	in a workload like the one running in these 32G high end machines and
	2.6 now will have to be changed because of that. Anyways returning to
	2.4: the swap_out loop with pagetable walking doesn't scale for huge
	shared memory. This is obvious. With half a million of pages mapped
	some hundred times in the address space, when we've to swap shm, before
	we can writepage a single shm dirty page with page_count(page) == 1,
	we've first to walk and destroy the whole address space. It doesn't
	only unmap 1 single page, but it unmaps everything else too. All the
	address spaces in the machine are destroyed in order to make single
	shared shm pages freeable, and that generates a constant flood of
	expensive minor page faults. The way to fix it without any downside
	(except purerly theorical ones exposed by Andrew last year, and you
	can maliciously waste the same cpu using truncate) is a mix between
	objrmap (note: objrmap has nothing to with the rmap as in 2.6), and the
	pagetable walking code. In short during the pagetable walking I check
	if a page is freeable and if it's not yet, I execute the objrmap on it to
	make it immediatly freeable if the trylocking permits. This allow
	swap_out to make progress and to unmap one shared page at time, instead
	of unmapping all of them from all address spaces, before the first one
	becomes freeable/swappable. Some lib function in the patch is taken
	from the objrmap patch for 2.6 in the mbligh tree implemented by IBM
	(thanks to Martin and IBM for maintaining that patch uptodate for 2.6,
	that is a must-have starting point for the 2.6 VM too).  The original
	idea of using objrmap for the vm unmapping procedure is from David
	Miller (objrmap itself has always existed in every linux kernel out
	there, to provide mmap coherency through vmtruncate, and now
	it is being used from the 2.4-aa swap_out pagetable walking too).
	To give an idea the top profiled function during swapping 4G of shm on
	the 32G box now is try_to_unmap_shared_vma.

	2) the writepage callback of the shared memory converts a shm page
	into a swapcache page, but it doesn't start the I/O on the swapcache
	immediatly, this is a nosense and it's easy to fix by simply calling
	the swapcache writepage within the shm_writepage before returning
	(then of course we must not unlock the page anymore before returning,
	the I/O completion will unlock it).

	Not starting the I/O it means we'll start the I/O after another million
	pages and then after starting the I/O we'll notice the finally free
	page after another million page pass.

	There was a super swap storm was happening because of these issues,
	especially the interaction between point 1 and point 2 was detrimental
	(with 1 and 2 I mean the phase from unmapping the page to starting the
	I/O, the last phase from starting the I/O to effectivly noticing a
	freeable clean swapcache page is addressed in point 3 below).

	In short if you had to swap 4k of shm, the kernel would immadiatly move
	into swapcache more than 4G (G is not a typo ;) of shm, and then it was
	starting the I/O to swap all those 4G out because it was all dirty and
	freeable cache (from the shmfs fs) queued contigously in the lru. So
	after the first 4k of shm to be swapped out, every further allocation
	would generate a swapout for a very very long time. Reading a file
	would involve swapping the amount of data read as well, not to tell if
	you were reading into empty vmas, that would generate two times more
	swapping than the I/O itself. So machines that were swapping slightly
	(around 4G on a 32G box) were entering a swap storm mode with very huge
	stalls lasting several dozen minutes (you can imagine if every memory
	allocation was executing I/O before returning).

	Here a trace of that scenario as soon as the first 35M of address space
	become freeable and moved into swapcache, this is the point
	where basically all shm is already freeable but dirty, you see,
	machine hangs with 100% system load (8 cpus doing nothing but
	keeping throwing away address space with the background
	swap_out, and calling shm_writepage until all shm is converted
	to swapcache).

	procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
	r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
	33  1  35156 507544  80232 13523880    0  116     0   772  223 53603 24 76  0  0
	29  3  78944 505116  72184 13342024    0  124     0  2092  153 52579 27 73  0  0
	29  0 114916 505612  70576 13174984    0    0     4 10556  415 26109 31 69  0  0
	29  0 147924 506796  70588 13150352    0    0    12  7360  717  3944 32 68  0  0
	25  1 108764 507192  68968 12942260    0    0     8 10989 1111  4886 19 81  0  0
	27  0 266504 505104  64964 12717276    0    0     3  3122  223  2598 56 44  0  0
	24  0 418204 505184  29956 12550032    0    4     1  3426  224  5242 56 44  0  0
	16  0 613844 505084  29916 12361204    0    0     4    80  135  4522 23 77  0  0
	20  2 781416 505048  29916 12197904    0    0     0     0  111 10961 13 87  0  0
	22 0 1521712 505020  29880 11482256    0    0    40   839 1208  4182 13 87  0  0
	24 0 1629888 505108  29852 11374864    0    0     0    24  377   537 13 87  0  0
	27 0 1743756 505052  29852 11261732    0    0     0     0  364   598 11 89  0  0
	25 0 1870012 505136  29900 11135420    0    0     4   254  253   491  7 93  0  0
	24 0 2024436 505160  29900 10981496    0    0     0    24  125   484 10 90  0  0
	25 0 2287968 505280  29840 10718172    0    0     0     0  116  2603 11 89  0  0
	23 0 2436032 505316  29840 10570856    0    0     0     0  122   418  3 97  0  0
	25 0 2536336 505380  29840 10470516    0    0     0    24  115   389  2 98  0  0
	26 0 2691544 505564  29792 10316112    0    0     0     0  125   443  8 92  0  0
	27 0 2847872 505508  29836 10159752    0    0     0   226  138   482  7 93  0  0
	24 0 2985480 505380  29836 10022836    0    0     0   524  146   491  5 95  0  0
	24 0 3123600 505048  29792 9885668    0    0     0   149  112   397  2 98  0  0
	27 0 3274800 505116  29792 9734396    0    0     0     0  112   377  5 95  0  0
	28 0 3415516 505156  29792 9593624    0    0     0    24  109  1822  8 92  0  0
	26 0 3551020 505272  29700 9458072    0    0     0     0  113   453  7 93  0  0
	26 0 3682576 505052  29744 9326488    0    0     0   462  140   461  5 95  0  0
	26 0 3807984 505016  29744 9200960    0    0     0    24  125   458  3 97  0  0
	27 0 3924152 505020  29700 9085040    0    0     0     0  121   514  3 97  0  0
	28 0 4109196 505072  29700 8900812    0    0     0     0  120   417  6 94  0  0
	23 2 4451156 505284  29596 8558780    0    0     4    24  122   491  9 91  0  0
	23 0 4648772 505044  29600 8361080    0    0     4     0  124   544  5 95  0  0
	26 2 4821844 505068  29572 8187904    0    0     0   314  132   492  3 97  0  0

	After all address space has been destroyed multiple times
	and all shm has been converted into swapcache, the kernel can
	finally swapout the first 4kbyte of shm:

	6 23 4560356 506160  22188 8440104    0 64888   16 67280 3006 534109 6 88  5  0

	The rest is infinite swapping and machine total hung, since those 4.8G
	of swapcache are now freeable and dirty, and the kernel will not
	notice the freeable and clean swapcache generated by this 64M
	swapout, since it's being queued at the opposite side of the lru
	and we'll find another million pages to swap (i.e. writepage)
	before noticing that. So the kernel will effectively start
	generating the first 4k of free memory only after those half
	million pages have been swapped out.

	So point 1 and fixes the kernel so that we unmap only 64M of shm, and we
	swapout then immediatly, but we can still run into huge problems in
	having half million pages of shm queued in a row in the lru.

	3) After fixing 1 and 2 a file copy was still not running (yeah it was running
	but some 10 or 100 times slower than it had to, preventing any backup
	activity to work etc..) after the machine was 4G into swap. But at least
	the machine was swapping just fine, so the database and the
	application itself was doing pretty good (no swap storms anymore
	after fixing 1 and 2), it's the other apps allocating further
	cache that didn't work yet.

	So I tried reading an huge multi gigs file, I left the cp
	running for a dozen minutes at a terribly slow rate (despite the
	data was on the SAN), and I noticed this cp was pushing the
	database into swap another few gigs more, precisely as much as
	the size of the file. During the read the swapout greatly
	exceeded the reads from the disk (so-bi from vmstat). In short
	the cache allocated on the huge file, was beahaving like a
	memory leak. But it was not a memory leak, it was a very fine
	clean and freeable cache reacheable from the lru, too bad we
	still had an hundred thousand shm pages being unmapped (by the
	background obrjmap passes) to walk and to shm->writepage and
	swapcache->writepage before noticing the immediatly freeable
	gigs of clean cache of the file.

	In short the system was doing fine, but due the ordering of the lru, it was
	preferring to swap gigs and gigs of shm pushing the running db into
	swap, instead of shrinking the several unused (and absolutely
	not aged) gigs of clean cache. This wasn't too good also for
	efficient swapping because it was taking a long time before the
	vm could notice the clean swapcache, after it started the I/O on
	it.

	It was pretty clear after that, that we've to prioritize and to
	prefer discarding memory that is zerocost to collect, than to do
	extremely expensive things to release free memory instead. This
	change isn't absolutely fair, but the current behaviour of the
	vm is an order of magnitude worse in the high end. So the fix I
	implemented is to run a inactive_list/vm_cache_scan_ratio pass
	on the clean immediatly freeable cache in the inactive list
	before going into the ->writepage business and whala, copies
	were running back at 80M/sec like if no 4G were being swapped
	out at the same time. Since swap, data and binaries are all on
	different places (data on the SAN, swap on a local IDE, binaries
	on another local IDE), swapping while copying didn't hurt too
	much either.

	A better fix would be to have an anchor in the lru (can be a per-lru
	page_t with a PG_anchor set) and to avoid the clean-cache search to
	alter the point where we keep swapping with writepage, but it
	shouldn't matter that much and 2.4 being obsolete isn't very
	worthwhile to make it even better.

	On the low end (<8G) these effects that hangs machines for hours and makes
	any I/O impossible weren't visible because the lru is more mixed and there
	are never too many shm pages in a row. The less ram the less this effect
	is visible. However even on small machines now swapping shm should be
	more efficient now. The downside is that now the pure clean
	cache is penalized against dirty cache but I believe it worth to
	pay for this downside to survive and handle the very high end
	workloads.

	I didn't find very attractive doing these changes in 2.4 at this time,
	but 2.6 has no way to run in those workloads, and no 2.6 kernel is
	certified for some products yet etc.. This code is now running in
	production and people seems happy. I think this is the first
	linux ever with a chance of handling properly this high end
	workload on high end hardware, so if you had problems give this
	a spin. 2.6 obviously will lockup immediatly in this workloads
	due the integration of rmap in 2.6 (already verified just to be
	sure my math was correct) and 2.4 mainline as well will run oom
	(but no lockup in 2.4 mainline since it can handle zone normal
	failures gracefully unlike 2.6) since it lacks pte-highmem.

	If this slowdown the VM on the low end (i.e. 32M machine,
	probably the smaller box where I tested it is my laptop with 256M ;)
	try increasing the vm_cache_scan_ratio sysctl and for any
	regression please notify me. Thank you!

Only in 2.4.23aa1: 21_pte-highmem-mremap-smp-scale-1
Only in 2.4.23aa2: 21_pte-highmem-mremap-smp-scale-2

	Fix race condition if src is cleared under us while
	we allocate the pagetable (from 2.6 CVS, from Andrew).

Only in 2.4.23aa2: 30_20-nfs-directio-lfs-1

	Read right page with directio.

Only in 2.4.23aa2: 9999900_overflow-buffers-1

	paranoid check (dirty buffers should always be <= NORMAL_ZONE,
	and the other counters for clean and locked are never read,
	so this is a noop but it's safer).

Only in 2.4.23aa2: 9999900_scsi-deadlock-fix-1

	Avoid locking inversion.
