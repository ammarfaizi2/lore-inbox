Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSCaOsd>; Sun, 31 Mar 2002 09:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293218AbSCaOsZ>; Sun, 31 Mar 2002 09:48:25 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:3880 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293187AbSCaOsS>; Sun, 31 Mar 2002 09:48:18 -0500
Date: Sun, 31 Mar 2002 16:48:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre5aa1 and splitted vm-33
Message-ID: <20020331164815.A1331@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has the new scalable pte-highmem, using the atomic kmaps for ptes
in the fast paths, but still using the persistent ones in the slow paths
where persistent kmaps avoids writing very ugly code for 64bit archs (at
least one of those paths is currently corrupting in Ingo/Arjan version
in 2.5.7, didn't checked the rest). It worked out at the first try, no
problem yet. 2.5 will need a total rewrite of the kmaps anyways, the
Ingo/Arjan version is definitely not a final thing and it's way too ugly
thinking 64bit, it's not by accident that I added the persistence to the
pagetable kmaps too (see below the comments on the pte-highmem changes
for more details). This instead should be the best solution for
pte-highmem in 2.4 (despite I had to backport some of the
64bit-senseless code to make NUMA-Q scale well).

This also splits the VM in pieces, thanks to Andrew great effort. I'm so
happy that some first important part is just included 2.4.19pre5,
thanks. I look forward to merge the rest ASAP too. I will be completly
responsive now that I'm in sync with the splitted version, to help
understanding documenting discussing those small orthogonal patches and
to change or drop them if somebody has better ideas or can find any
problem with them. So I recommend testing at least the vm-33.gz patch on
top of pre5 to everybody and to report any problem you might encounter.
The swap-level is also a sysctl, you can decrease the swap increasing
vm_mapped_ratio sysctl, this is mostly because choosing how much to swap
it is also a function of the speed of the swap space compared to the
speed of the ram, so having a sysctl controlling the magic constants may
return helpful in some scenario, same goes for the other new sysctl,
despite the default should remain optimal for all common machines. I'm
running it in all my boxes, from 3G machines running DBMS in ram, to 1G
machines running DBMS with 512M of shm in swap space, to my 32m firewall
to my 1G dualathlon desktop and my dualalpha, and it works fast for me
and the same for all the other people testing it so far.

The only known problem at the moment is an nfs performance regression with
the cto patch merged into pre5, reported by the very accurate Mario
Vanoni (and then we reported it to Trond too of course and I exect some
comment in the next days/weeks). The nocto option doesn't help either
for him, I think at least the nocto option should bring back the
original performance of pre4.  However it's not a showstopper for most
people, he handles some hundred thousand files via nfs and that's why he
notices the double of time it takes to do the same thing now. having a
short look at the cto patch it sounds like now it's doing a check on the
directory too for every file, maybe that's why it's two times slower, or
it maybe completly unrelated, but again I think at least the nocto
option should bring back the original pre4 performance if somebody
doesn't care in close-to-open coherency semantics.

The other thing to test is xfs, I adapted the kiobuf allocation to the
new kiobuf-slap patch in a few minutes but I didn't tested it at all
then.

URL:

	http://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre5aa1.gz
	http://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre5aa1/

Only the VM part against pristine 2.4.19pre5:

	http://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre5aa1/vm-33.gz
	http://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre5aa1/vm-33/

Only in 2.4.19pre3aa2: 00_alpha-extern-inline-1
Only in 2.4.19pre3aa2: 00_alpha-lseek-1
Only in 2.4.19pre3aa2: 00_alpha-page_address-1
Only in 2.4.19pre3aa2: 00_alpha-page_zone-1
Only in 2.4.19pre3aa2: 00_dnotify-fl_owner-2
Only in 2.4.19pre3aa2: 00_fdatasync-FIFO-1
Only in 2.4.19pre3aa2: 00_mmap-enomem-1
Only in 2.4.19pre3aa2: 00_mprotect_msync-ENOMEM-1
Only in 2.4.19pre3aa2: 00_multipath-routing-smp-1
Only in 2.4.19pre3aa2: 00_nfs-2.4.17-cto-3
Only in 2.4.19pre3aa2: 00_nfs-fix_create-1
Only in 2.4.19pre3aa2: 00_rb-export-1
Only in 2.4.19pre3aa2: 00_shmdt-retval-1
Only in 2.4.19pre3aa2: 00_zlib-1
Only in 2.4.19pre3aa2: 10_compiler.h-3

	Merged in mainline.

Only in 2.4.19pre3aa2: 00_block-highmem-all-18b-7.gz
Only in 2.4.19pre5aa1: 00_block-highmem-all-18b-8.gz
Only in 2.4.19pre3aa2: 00_gcc-3_1-compile-1
Only in 2.4.19pre5aa1: 00_gcc-3_1-compile-2
Only in 2.4.19pre3aa2: 00_lowlatency-fixes-4
Only in 2.4.19pre5aa1: 00_lowlatency-fixes-5
Only in 2.4.19pre3aa2: 00_module-gfp-6
Only in 2.4.19pre5aa1: 00_module-gfp-7
Only in 2.4.19pre3aa2: 00_silent-stack-overflow-16
Only in 2.4.19pre5aa1: 00_silent-stack-overflow-17
Only in 2.4.19pre3aa2: 10_rawio-vary-io-4
Only in 2.4.19pre5aa1: 10_rawio-vary-io-6
Only in 2.4.19pre5aa1: 20_highmem-debug-10
Only in 2.4.19pre3aa2: 20_highmem-debug-9
Only in 2.4.19pre3aa2: 20_numa-mm-2
Only in 2.4.19pre5aa1: 20_numa-mm-3
Only in 2.4.19pre3aa2: 60_net-exports-1
Only in 2.4.19pre5aa1: 60_net-exports-2

	Rediffed.

Only in 2.4.19pre3aa2: 00_nfs-tcp-tweaks-3
Only in 2.4.19pre5aa1: 00_nfs-tcp-tweaks-4

	New version from Trond.

Only in 2.4.19pre5aa1: 00_nfs-tcp-tweaks-4-rmv-cong-nonsense-3

	Backout the broken congestion control (really the new version
	attempts to change it a bit too, but it's still way to risky
	to change that "just-working-perfectly" stuff, I don't see what's
	the problem with the current algorithm, it seems much smarter as well).
	Problem in the tcp-tweaks patch found by Kurt Garloff.

Only in 2.4.19pre5aa1: 00_o_direct-open-check-1

	Move the check for O_DIRECT support into the open(2) syscall. Make
	sense, also the xine folks asked for that feature to cleanup
	some userspace. Patch from Chuck Lever.

Only in 2.4.19pre5aa1: 00_read_full_page-get_block-err-1

	Anton found get_block errors weren't handled correctly by
	block_read_full_page(). This is my proposed fix for the problem,
	implementation and patching is from Anton Altaparmakov.

Only in 2.4.19pre5aa1: 00_readahead-got-broken-somewhere-1

	Return using a readahead that allows the scsi and IDE to generate
	max sized commands (for scsi max size is the max_sectors that limits
	to 512k commands, for ide is either 127k or 128k depending on the
	drive). I had this thing in early 2.4 too, then it got merged but
	I didn't noticed somebody backed it out in late 2.4, so I'm fixing
	it again. Without this change some read benchmark has huge regressions.

Only in 2.4.19pre5aa1: 00_tty-poll-1

	Patch from Sapan J . Bhatia to fix flow control in tty/pty.

Only in 2.4.19pre5aa1: 00_vm86-1

	Merged two vm86 diffs from 2.4.19pre3-ac6 and 2.4.19pre4-ac2.

Only in 2.4.19pre5aa1: 00_vm_start-drivers-1

	Fix from Ben LaHaise to avoid rbtree corruption if the driver
	remaps the vma out of the range that the common code choosed.
	This has some minor modification from me, suggested by Ben,
	to be sure all drivers do_munmap or giveup if the new area
	is just occupied.

Only in 2.4.19pre3aa2: 10_vm-32
Only in 2.4.19pre5aa1: 05_vm_00_touch-buffer-1
Only in 2.4.19pre5aa1: 05_vm_03_vm_tunables-1
Only in 2.4.19pre5aa1: 05_vm_04_dump_stack-1
Only in 2.4.19pre5aa1: 05_vm_05_zone_accounting-1
Only in 2.4.19pre5aa1: 05_vm_06_swap_out-1
Only in 2.4.19pre5aa1: 05_vm_07_local_pages-1
Only in 2.4.19pre5aa1: 05_vm_08_try_to_free_pages_nozone-1
Only in 2.4.19pre5aa1: 05_vm_09_misc_junk-1
Only in 2.4.19pre5aa1: 05_vm_10_read_write_tweaks-1
Only in 2.4.19pre5aa1: 05_vm_11_lru_release_check-1
Only in 2.4.19pre5aa1: 05_vm_12_drain_cpu_caches-1
Only in 2.4.19pre5aa1: 05_vm_13_activate_page_cleanup-1
Only in 2.4.19pre5aa1: 05_vm_14_block_flushpage_check-1
Only in 2.4.19pre5aa1: 05_vm_15_active_page_swapout-1
Only in 2.4.19pre5aa1: 05_vm_16_active_free_zone_bhs-1
Only in 2.4.19pre5aa1: 05_vm_17_rest-2

	All the credits for this split of my VM updates that should finish
	the 2.4 VM saga goes to Andrew. Part of them (the first important ones)
	are just been integrated by Marcelo in pre5.  That's great.  I look
	forward to merge the other patches very soon too.  I will be greatly
	responsive on those patches now that the split happened. It took some
	time for me to audit all the intradiffs and to merge them into my tree.
	I also ported them to pre4 and pre5 vanilla here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre5/vm-33/* (for Marcelo)
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre5/vm-33.gz (for the users)

	So if you only want the vm updates and not the rest of the -aa patch, you
	can pick the vm-33.gz patch and apply it on top of a clean 2.4.19pre5.
	vm-33.gz is exactly equivalent of the above 16 patches in -aa.

	Thanks again to Andrew for taking care of this difficult effort.

	Please Marcelo, go to the patches/v2.4/2.4.19pre5 directory, start
	reading the first and tell me why you are not merging it, in case
	you disagree. You don't need to do it all at once of course (it's up to
	you, for me it's fine if you do all at once too), we can do one patch
	every few days, thanks to Andrew's splitting effort.

Only in 2.4.19pre5aa1: 10_tlb-state-1

	cacheline align the tlb_state array, currently it's like a shared
	spinlock bouncing all over. The idea is from -ac, this one
	is a cleaner implementation (no hardwired pad).

Only in 2.4.19pre5aa1: 20_kiobuf-slab-2

	Other patch from Chuck Lever to allocate the whole kiobuf from slab,
	using pointer to arrays, to have small structures not larger
	than one page (that would otherwise become sensitive to
	physical ram page granular fragmentation). While auditing and
	merging the patch I also did various small fixes, so please rely
	on this patch as a final version, because the original one had a few
	bugs/leftovers.

Only in 2.4.19pre3aa2: 20_pte-highmem-17
Only in 2.4.19pre5aa1: 20_pte-highmem-20

	Made the scalability changes required to be fast on NUMA-Q 16-way x86.
	This is the optimal production solution for 2.4, efficient and not too
	much invasive.  2.5 will get a rewrite of the whole kmap thing, atomic
	kmaps will disappear, and current blocking kmaps will disappear too,
	only one kind of kmap will be left and it will be both atomic and
	persistent.

Only in 2.4.19pre5aa1: 50_uml-patch-2.4.18-12.gz
Only in 2.4.19pre3aa2: 50_uml-patch-2.4.18-2-2.gz

	New version. Seems a bit buggy though (ask for details).

Only in 2.4.19pre3aa2: 51_uml-ac-to-aa-7
Only in 2.4.19pre5aa1: 51_uml-ac-to-aa-8
Only in 2.4.19pre5aa1: 52_alloc_pages-1
Only in 2.4.19pre3aa2: 56_uml-pte-highmem-1
Only in 2.4.19pre5aa1: 56_uml-pte-highmem-2

	Cured the usual compile time breakages while integrating into -aa.

Only in 2.4.19pre3aa2: 70_xfs-7.gz
Only in 2.4.19pre5aa1: 70_xfs-8.gz
Only in 2.4.19pre3aa2: 71_xfs-blksize-1
Only in 2.4.19pre5aa1: 71_xfs-kiobuf-slab-1
Only in 2.4.19pre3aa2: 72_xfs-fixes-1

	Merged various fixes, in particular delayed writes should now be
	really flushed by the VM, previously the fact the vm holds
	the page lock was forbidding that. New logic is much cleaner too.

	Due the change in the kiobuf allocation (the pagebuf layer uses the
	kiobuf, but only the VM part so it allocates it by hand to be faster),
	this patch also has some change to integrate well with the new slab
	kiobuf, but I didn't tested that part, so please test it and let me
	know if it doesn't work.

Only in 2.4.19pre3aa2: 81_x86_64-arch-1.gz
Only in 2.4.19pre5aa1: 81_x86_64-arch-2.gz
Only in 2.4.19pre3aa2: 82_x86-64-compile-aa-1
Only in 2.4.19pre5aa1: 82_x86-64-compile-aa-2
Only in 2.4.19pre3aa2: 82_x86-64-pte-highmem-1
Only in 2.4.19pre5aa1: 82_x86-64-pte-highmem-2

	Integrated latest x86-64 snapshot released from Andi.

Andrea
