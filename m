Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281210AbRKRI0E>; Sun, 18 Nov 2001 03:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281217AbRKRIZz>; Sun, 18 Nov 2001 03:25:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:57099 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281210AbRKRIZr>; Sun, 18 Nov 2001 03:25:47 -0500
Date: Sun, 18 Nov 2001 09:24:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: ben@google.com, brownfld@irridia.com, phillips@bonn-fries.net,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: 2.4.15pre6aa1 (fixes google VM problem)
Message-ID: <20011118092434.A1331@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be interesting if people experiencing the VM problems
originally reported by google (but also trivially reproducible with
simple cache operations) could verify that this update fixes those
troubles. I wrote some documentation on the bug and the relevant fix in
the vm-14 section below. Thanks.

If all works right on Monday I will port the fix to mainline (it's
basically only a matter of extracting a few bits from the vm-14 patch,
it's not really controversial but I didn't had much time to extract it
yet, the reason it's not in a self contained patch from the first place
is because of the way it was written). Comments are welcome of course, I
don't think there's another way around it though, even if we would
generate a logical swap cache not in function of the swap entry that
still wouldn't solve the problem of mlocked highmem users [or very
frequently accessed ptes] in the lowmem zones. The lowmem ram wasted for
this purpose is very minor compared to the total waste of all the
highmem zones, and the algorithm I implemented adapts in function of the
amount of highmem so the lowmem waste is proportial with the potential
highmem waste. However the lower_zone_reserve defaults could be changed,
I choosen the current defaults in a conservative manner.

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre6aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre6aa1/

Only in 2.4.15pre1aa1: 00_lvm-1.0.1-rc4-3.bz2
Only in 2.4.15pre6aa1: 00_lvm-1.0.1-rc4-4.bz2

	Rest of the rc4 diffs rediffed.

Only in 2.4.15pre1aa1: 00_rwsem-fair-23
Only in 2.4.15pre6aa1: 00_rwsem-fair-24
Only in 2.4.15pre1aa1: 00_rwsem-fair-23-recursive-4
Only in 2.4.15pre6aa1: 00_rwsem-fair-24-recursive-5

	Rediffed.

Only in 2.4.15pre1aa1: 00_strnlen_user-x86-ret1-1

	Merged in mainline.

Only in 2.4.15pre1aa1: 10_lvm-deadlock-fix-1

	Now in mainline.

Only in 2.4.15pre1aa1: 10_lvm-incremental-1
Only in 2.4.15pre6aa1: 10_lvm-incremental-2

	Part of it in mainline, rediffed the rest.

Only in 2.4.15pre1aa1: 10_vm-13
Only in 2.4.15pre6aa1: 10_vm-14

	This should be the first kernel out there without the google VM
	troubles (that are affecting more than just google testcase). The
	broken piece of VM was this kind of loop in the allocator:

	for (;;) {
		zone_t *z = *(zone++);
		if (!z)
			break;

		if (zone_free_pages(z, order) > z->pages_low) {
			page = rmqueue(z, order);
			if (page)
				return page;
		}
	}

	and the above logic is present in all 2.4 kernels out there (2.3 as well).
	So the bug has nearly nothing to do with the memory balancing engine as
	most of us would expect, it's an allocator zone balancing bug instead in
	a piece of code that one would assume to be obviously correct.

	The problem cames from the fact that all the ZONE_NORMAL can be allocated with
	unfreeable highmem users (like anon pages when no swap is available).
	If that happens the machine runs out of memory no matter what (even if
	there are 63G of cache clean ready to be freed).  Mainline deadlocks
	because of the infinite loop in the allocator, -aa was ""correctly""
	just killing tasks as soon as the normal zone was filled of mlocked
	cache or anon pages with no swap.

	The fix is to have a per-classzone per-zone set of watermarks (see the
	zone->watermarks[class_idx] array). Seems to work fine here. Of course
	this means potentially wasting some memory when the highmem zone is
	huge but there's no other way around it and the potential waste of all the
	highmem memory is huge compared to a very small waste of the normal
	zone (it could be more finegrined of course, for example we don't keep
	track if an allocation will generate a page freeable from the VM or
	not, but those are minor issues and not easily solvable anyways [we pin
	pages with a get_page and we certainly don't want to migrate pages
	across zones within get_page], and the core problem should be just fixed).

	Since the logic is generic and applies also to the zone dma vs zone
	normal (not only zone normal vs zone highmem) this should be tested a
	bit on the lowmem boxes too (I just took care of the lowmem boxes in
	theory, but I didn't tested it in practice).

	In short now we reserve a part of the lower zones for the lower
	classzone allocations. The algorithm I wrote calculates the "reserved
	portion" in function of the size of the higher zone (higher zone means
	the "zone" that matches the "classzone"). For example a 1G machine will
	reserve a very little part of the zone_normal. A 64G machine is going
	to reserve all the 800mbyte of zone normal for allocations from
	the normal classzone instead (this is fine because it would be a total
	waste if a 64G machine would risk to run OOM because the zone normal
	is all occupied by unfreeable highmem users that would much better stay
	in the highmem zone instead). The ratio between higher zone size and
	reserved lower zone size, is selectable via boot option ala memfrac=
	(the new option is called lower_zone_reserve=). Default values should
	work well (they as usual doesn't need to be perfect, but they can be
	changed if you've suggestions), the boot option is there just in case.

Only in 2.4.15pre6aa1: 10_vm-14-no-anonlru-1
Only in 2.4.15pre6aa1: 10_vm-14-no-anonlru-1-simple-cache-1

	Backed out the anon pages from the lru again, mainly to avoid to
	swapout too easily and because this is going to be tested on the
	big boxes with no swap at all anyways.

Only in 2.4.15pre1aa1: 50_uml-patch-2.4.13-5.bz2
Only in 2.4.15pre6aa1: 50_uml-patch-2.4.14-2.bz2

	Latest Jeff's uml update.

Only in 2.4.15pre1aa1: 60_tux-2.4.13-ac5-B0.bz2
Only in 2.4.15pre6aa1: 60_tux-2.4.13-ac5-B1.bz2

	Latest Ingo's tux update.

Andrea
