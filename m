Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSAHO4u>; Tue, 8 Jan 2002 09:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288083AbSAHO4l>; Tue, 8 Jan 2002 09:56:41 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:41496 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286316AbSAHO4a>; Tue, 8 Jan 2002 09:56:30 -0500
Date: Tue, 8 Jan 2002 15:55:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18pre2aa1
Message-ID: <20020108155553.A1894@inspiron.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This attempts to fix all the fs corruption troubles with get_blocks
failures (like -ENOSPC). Thanks to Andrew for the big help in closing
those. Please review.

I also couldn't resist to add the dyn_sched because I'm dealing with
servers that needs to run 2k tasks (with only a few of them running at
the same time loading cpu), so there the reclaculate loop was evil and
the change is simple enough to be kind of obviously correct (btw: I also
seen a similar patch posted to l-k a few years back from somebody at
SGI), the dyn_sched patch from Davide basically fixes this making the N
only the number of running tasks and the improvement should become
visible (possibly also on machines with houndred of tasks with only a
few running). Davide's patch isn't in its original form, I changed it
quite a bit to fix various bits and I think it's safe enough now, but
please compare rc2aa2 with this new one and tell me if you can notice
any loss of responsiveness (note: I wouldn't be surprised if it would be
more responsive, the dyn_prio doesn't go away at the end of the first
timeslice, so it will detect better the interactive tasks than the
previous algorithm). In my testing on the laptop it seems to work fine,
I cannot notice anything wrong with the scheduler. The troubles happened
in 2.5 are irrelevant, I should have fixed all the glitches before
including it in -aa (thanks to Linus, Davide and the others on l-k for
spotting them on the 2.5 side).  But still if you find any problem with
the scheduler backing out 30_dyn-sched-1 should cure it completly (and
of course please let me know in such case). thanks,

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre2aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre2aa1/

Only in 2.4.17rc2aa2: 00_find_or_create_page-1

	Merged in mainline.

Only in 2.4.17rc2aa2: 00_get_block-leftovers-1

	Obsoleted by more extensive patches in 18pre1aa1.

Only in 2.4.18pre1aa1: 00_ia64-dma-1

	Some block-highmem bit for ia64 from Andreas Schwab. However
	I'm not sure if ia64 compiles yet, it is possible the ia64
	patch is needed as well (it's not likely to apply without at least some
	trivial reject though).

Only in 2.4.18pre1aa1: 00_msync-ret-1

	Fix MS_ASYNC and try to report I/O errors as much as possible
	in the msync path. Fix from Andrew Morton.

Only in 2.4.18pre1aa1: 00_netconsole-3c59x-1

	Enable netconsole in 3c59x driver, from Andi Kleen.

Only in 2.4.18pre1aa1: 00_nfs-2.4.17-cto-1
Only in 2.4.18pre1aa1: 00_nfs-2.4.17-pathconf-1
Only in 2.4.18pre1aa1: 00_nfs-bkl-1
Only in 2.4.18pre1aa1: 00_nfs-rpc-ping-1
Only in 2.4.18pre1aa1: 00_nfs-seekdir-1

	NFS updates from Trond Myklebust. BTW, the svc tcp patches are broken,
	they oopsed on me with a simple mount of nfs via udp, so I left them
	out. this is the oops for the record:

Jan  7 20:24:43 athlon kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000028
Jan  7 20:24:43 athlon kernel:  printing eip:
Jan  7 20:24:43 athlon kernel: c01290b0
Jan  7 20:24:43 athlon kernel: *pde = 00000000
Jan  7 20:24:43 athlon kernel: Oops: 0000
Jan  7 20:24:43 athlon kernel: CPU:    0
Jan  7 20:24:43 athlon kernel: EIP:    0010:[kmem_cache_alloc+192/240]    Not tainted
Jan  7 20:24:43 athlon kernel: EFLAGS: 00010246
Jan  7 20:24:43 athlon kernel: eax: 00000000   ebx: c22bc200   ecx: c22bc39c   edx: c0340b88
Jan  7 20:24:43 athlon kernel: esi: c1fe6a40   edi: 00000000   ebp: 000001f0   esp: c2583f38
Jan  7 20:24:43 athlon kernel: ds: 0018   es: 0018   ss: 0018
Jan  7 20:24:43 athlon kernel: Process nfsd (pid: 820, stackpage=c2583000)
Jan  7 20:24:43 athlon kernel: Stack: 00000000 c2592000 c02f8000 7fffffff c22bc39c c0340b88 c2583f80 c0111715 
Jan  7 20:24:43 athlon kernel:        c22bc200 c1fe6a40 c0340b88 c0340b88 c0276ef7 00000000 000001f0 c22bc200 
Jan  7 20:24:43 athlon kernel:        c1fe1dc0 c0340b88 c0278b3a c1fe6a40 00000000 c2582000 00000000 00000000 
Jan  7 20:24:43 athlon kernel: Call Trace: [schedule_timeout+149/160] [svc_resbuf_alloc+23/112] [svc_recv+330/912] [nfsd+226/768] [kernel_thread+38/48
Jan  7 20:24:43 athlon kernel:    [nfsd+0/768] 
Jan  7 20:24:43 athlon kernel: 
Jan  7 20:24:43 athlon kernel: Code: f6 47 28 01 0f 84 5b ff ff ff 68 c1 04 00 00 68 80 81 28 c0 

Only in 2.4.18pre1aa1: 00_o_direct-leftovers-2

	Make sure not to left suprious blocks allocated with O_DIRECT.
	Fix is a little dirty but should be ok. Please review. Thanks.

Only in 2.4.18pre1aa1: 00_page-cache-release-1

	Move the lru handling into __free_pages internals to
	catch all pagecache users (obviously safe and faster given we
	had a branch for the BUG() anyways there).  From Benjamin LaHaise.

Only in 2.4.17rc2aa2: 00_ramdisk-buffercache-1
Only in 2.4.18pre1aa1: 00_ramdisk-buffercache-2

	Further ramdisk fixes on top of the previous patch.
	From Andrew Morton.

Only in 2.4.18pre1aa1: 00_reduce-module-races-1

	Use synchronize_kernel from the rcu_poll functionality to reduce the
	possibility of module unload race conditions (possibly definitely
	fixing at least some of them). From Andi Kleen.

Only in 2.4.17rc2aa2: 00_silent-stack-overflow-13
Only in 2.4.18pre1aa1: 00_silent-stack-overflow-14

	Rediffed due rejects.

Only in 2.4.18pre1aa1: 00_truncate-garbage-1

	FS corruption fixes while dealing with get_block failures.
	Patch from Andrew Morton, but note this has further fixes,
	the BH_New handling was still wrong in the latest patch in my
	inbox.

Only in 2.4.17rc2aa2: 10_parent-timeslice-8
Only in 2.4.18pre1aa1: 10_parent-timeslice-9

	Rediffed due rejects.

Only in 2.4.17rc2aa2: 10_vm-21
Only in 2.4.18pre1aa1: 10_vm-22

	Pass two times over all the pte before failing swap_out.

Only in 2.4.17rc2aa2: 20_highmem-debug-7
Only in 2.4.18pre1aa1: 20_highmem-debug-8

	Rediffed due rejects.

Only in 2.4.18pre1aa1: 30_dyn-sched-1

	Merged a fixed up version of the dynamic scheduler patch from Davide
	Libenzi. In particular sys_sched_yield looked wrong (shouldn't throw away
	the timeslice but only roll the task over) and idle tasks handling is
	now corrected too (also make sure not to do suprious reschedule of the idle
	tasks, set need_resched on idle tasks only via reschedule_idle). Also
	increased a bit the nice levels and give the dyn_sched at max only the
	double of power of a legacy timeslice.

	If you've any problem with this release, please try to backout the
	30_dyn-sched-1 patch as first thing. The main reason I merged it
	is that I'm dealing with boxes with thousands of tasks, but only a few
	of them running at the same time, and avoiding browse of the huge
	linked list should make an visible difference for those systems.

Only in 2.4.17rc2aa2: 50_uml-patch-2.4.16-2.bz2
Only in 2.4.18pre1aa1: 50_uml-patch-2.4.17-4.bz2

	Latest update from Jeff at user-mode-linux.sourceforge.net.

Only in 2.4.17rc2aa2: 60_atomic-alloc-7
Only in 2.4.18pre1aa1: 60_atomic-alloc-8

	Rediffed.

Only in 2.4.17rc2aa2: 60_tux-2.4.16-final-E2.bz2
Only in 2.4.18pre1aa1: 60_tux-2.4.17-final-A0.bz2

	Latest update from Ingo at www.redhat.com/~mingo/ .

Only in 2.4.17rc2aa2: 60_tux-vfs-3
Only in 2.4.18pre1aa1: 60_tux-vfs-4

	Rediffed.

Only in 2.4.17rc2aa2: 70_loop-deadlock-2

	Merged in mainline.

Andrea
