Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbREOWA3>; Tue, 15 May 2001 18:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbREOWAN>; Tue, 15 May 2001 18:00:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:41221 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261617AbREOV7H>; Tue, 15 May 2001 17:59:07 -0400
Date: Tue, 15 May 2001 23:58:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20pre2aa1
Message-ID: <20010515235859.A2415@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The main features of 2.2.20pre2aa1 are:

o	Support for 4Gigabyte of RAM on IA32 (me and Gerhard Wichert)
o	Support for 2T of RAM on alpha (me)
o	RAW-IO (doable with bigmem enabled too). Improvements are also been
	backported from 2.4.
o	SMP scheduler improvements. (me and partly from 2.3.x contributed by
	Ingo Molnar)
o	LFS (>2G file on 32bit architectures) also NFSv3 works over 2G
	(nfsv3-lfs work from me, Andi and fix from Jay Weber)
o	fixed race in wake-one LIFO in accept(2). Apache must be compiled with
	-DSINGLE_LISTEN_UNSERIALIZED_ACCEPT to take advantage of that.
o	lowlatency and SMP scalability in all copy-user and tcp_sendmsg
	checksum.
o	GFS support.
o	various fixes

Detailed description of 2.2.20pre2aa1 follows.

---------------------------------------------------------------------------
00_4_min_percent-1

	Increase the min percent of the buffer cache and page cache to 4%.
	(it wouldn't matter if the VM algorithms were better). (me)

00_IO-wait-3

	Avoid suprious unplug of the I/O queue. (me)

00_K7_P4-cachelines-2

	Allows the kernel to be compiled for K7 (AMD Athlon) or Pentium4.

	This compilations options _only_ make the kernel to assume respectively
	64byte cachelines or 128byte cachelines.

	Those assumptions are critical mostly on SMP systems, but even UP will
	take advantage of it because it will make most performance
	critical slab allocations to start on a cacheline boundary.

	Since the only difference between Ppro/K7/P4 compilations
	is the cacheline size assumed by the kernel you can safely boot
	a K7/P4 compiled kernel on a Ppro, it won't obviously generate
	cacheline pinpongs in SMP. There are only two downsides in 
	running on a Ppro (PII/PIII included) a K7/P4 compiled kernel:
	
	1)	some byte of memory wasted due the larger paddings (really not
		a big deal)
	2)	potential waste of cacheline sets. On PII and PIII and PPro
		the L1 dcache is 8kbyte or 16kbytes 2-way set associative (so
		there are 128 or 256 sets of cachelines) and by stressing the
		first 32bytes of the 128 byte aligned data structures (for
		example if the kernel is compiled for P4) you would take
		advantage of only 1/4 of the available L1 cache. (you would
		stress set 0, 4, 8, ... only) This is probably quite serious
		issue in terms of performance. So for Ppro/PII/PIII you're
		still suggested to use Ppro compilation option (if care to
		optimize the L1 cache usage).

	(me and Andi)

00_P4-local-APIC-1

	Fix a local APIC initaliziation ordering bug that triggers on the PIV.

00_PIII-10.bz2

	SSE/SSE2 support (unmasked exception via mxcsr included).
	(mix of Doug Ledford, Ingo Molnar, Gabriel Paubert PIII patch for
	2.2.x and 2.4.x PIII support from Gareth Hughes, audited, fixed and
	changed by me to be dynamic. At the end it's very similar to the
	2.4.x support)

	Kernel now understands the `nofxsr' boot time parameter and it
	doesn't enable fxsr in that case (if there's any CPU that
	crashes at boot because it's buggy, nofxsr will workaround
	the hardware bug; it's also useful for asymetric multiprocessing
	where boot cpu can have fxsr capabilities and the other cpus hasn't)

00_SIGIO-reason-2.bz2

	Pass the reason for the sigio in the si_code (and a duplicate info
	in si_band) with the same API of 2.4.x. This avoids people
	having to poll a set of fd during the sigio handler. (current
	2.4.x has two bugs in that area but fixes are in Linus's mailbox)

00_SMP-scheduler-2.2.18pre21-H.bz2

	Better SMP reschedule_idle. (partly backported from 2.3.x, 2.3.x
	version was contributed by Ingo Molnar)

	Fixes the wmb() in schedule_tail that should really be a mb(), in
	theory one of the last reads in reschedule_idle could return garbage (in
	practice I think it can't trigger... at least on x86 :) (me)

00_VM-locked-1

	wait I/O completion as well while doing the Wait_IO second pass on the
	dirty cache (should fix last VM problem reported by VA while creating
	very large ext2 fs on lowmem machines)

00_VM_RESERVED-1

	Allows device drivers to set the VMA as reserved to avoid swap_out to
	try to unmap stuff from them (this avoid device drivers using ->nopage
	for lazily mapping scatter gather dma areas in userspace, to implement
	a noop swapout and it also avoids useless page faults). This is much
	more efficient than setting the physical pages as reserved.

00_alpha-epoch-2

	Fixes the RTC parsing done by the kernel at boot. (backported from
	2.4.x)

00_andi-mark_bh-1

	Fix from Andi for the compatibility 2.4 interface (mark_bh was lost).

00_buf-run_task_queue.gz

	Avoid a suprious useless unplug of the I/O queue. (me)

00_delack-timer-5.gz

	Additional paranoid stuff in TCP delayed acks code (if somebody
	can still reproduce lockups under heavy TCP load, the
	delack-timer-5 patch can be the solution). In 2.2.15 only what
	was obviously wrong is been fixed, but at the time I did
	delack-timer-5 I was convinced the stuff in 2.2.15 _might_ not be
	enough, so if you have still lockups under 2.2.15 let us know.
	delack-timer-5 is reported to definitely fix the TCP lockup. (me)

00_elv-merging-1

	Fix elevator merging when tasks blocks waiting for new requests. (me)

00_ide-probe-compile-1

	Declare rtc_lock external spinlock to fix compilation. (me)

00_inode-boot-dynamic-3

	Make the inode-max and ihash dynamic. Mean distribution in the
	hash is of 1. inode-max remains the same until 256M of ram.
	It then reaches 32k inodes with 512Mbyte of ram and 64k inodes
	with 1G of ram and then it stops growing. It's true dcache
	avoids most of the iget when everything fits in the working set,
	but as soon there's icache pollution iget will run all the time
	so it's not true iget hash table doesn't matter for performance.

	The ihash hasnfn is very bad in both 2.2.x and 2.4.x:

		unsigned long tmp = i_ino | (unsigned long) sb;		

	Think what happens if `sb' has many bits set to 1, it will generate an
	huge collision chain. It should have been at least an xor, not an or.
	So I changed it this way:

		unsigned long tmp = i_ino + (unsigned long) sb / (sizeof(struct super_block) & ~(sizeof(struct super_block) - 1));

	This will shift right sb with around `super_block size' granularity
	and it will share hash cachelines if the user asks for consecutive
	inode numbers (can be the case).

	(me)

00_java-proc.gz

	Revertd the semantic change that make differences between
	/proc/00000$$ and /proc/$$, this allows backwards compatibilty of
	a misfeature and it _won't_ hurt security. There's no downside
	in reverting the 2.2.13 semantic change.

00_kupdate-interval-no-policy-in-kernel-1

	Allows large kupdate intervals (don't change the interval unless
	you know what you're doing!)

00_kupdate-sigstop-2.2.11-1.gz

	Allows kupdate to be stopped via SIGSTOP (currently it must be
	stopped by setting interval to zero via sysctl). This returns
	useful in the airplane where you do killall -STOP
	kupdate... STOP kupdate at your own risk of course ;) (me)

00_loop-merging-instead-of-async-1

	Instead of making a single threaded async daemon to avoid unplugging
	the queue all the time, the blockdevice code is been changed
	to allow the loop device to handle merged requests. (me)

00_mremap-waste-virtual-stack-space-1.gz

	Avoids mremap to grow in virtual addresses (and so in turn
	it avoids to waste virtual address space).

00_nanosleep-4.gz

	Provide nanosleep usec resolution so that a signal flood doesn't
	hang glibc folks that correctly trust the rem field to resume  
	the nanosleep after a syscall interruption. (without the patch
	nanosleep resolution is instead 10msec on IA32 and around 1msec on
	alpha) (me)

00_notify-change-2g-ext2-1

	ext2 64bit fix

00_overcommit-1.gz

	Make sure to not understimate the available memory (the cache and
	buffers may be under the min percent) (me)

00_parent-timeslice-loss-fix-3

	If child exists _before_ it got the timeslice refresh parents
	gets its timeslice back. 2.4.x does that even if child got
	the refresh and it's wrong.

	This feature avoids programs like `bash scripts' to be starved while
	forking short-lived childs at high frequency.

	(me)

00_readahead-unplug-2

	Don't generate suprious unplug of the queue during readahead.

00_show-regs-x86-1

	Some more info out of SYSRQ+P.

00_silent-stack-overflow-5.gz

	Avoid stack to silenty overflow on the heap (make life easier
	to track down userspace issues). Perfect approch is not possible
	even using special LDT for the stack segment. The approch in the
	patch will work 99% of the time and it enforces a GAP between heap
	and stack of 1 page as default (configurable via sysctl, if
	turned to zero the feature is disabled completly). (me)

00_tsc-calibration-non-compile-time-1.gz

	TSC calibration must be dynamic and not a compile time thing
	because gettimeofday is dynamic and it depends on the TSCs
	to be in sync. (me)

00_version

	Change to the Makefile EXTRAVERSION.

00_wake-one-4

	Backport 2.4 waitqueues and in turn fixes an hanging condition in accept(2).

	(me)

05_string-io-ops-doug-1

	Use only ordered string operations while writing to IOMMU areas.
	the non __ versions can be reordered at compile time. (Doug Ledford)

10_bigmem-2.2.19pre3-21.bz2

	BIGMEM production code (IA32 and alpha). This one fixes
	a memory leak during swap (almost unreproducibe, found it
	while reading the sources only) and some alpha-bigmem
	bug. It's now possible to generate core dumps larger
	than 2G (the previous limitation was due a few ext2
	bugs and a binfmt_elf.c bug that need to be fixed in 2.4.x too).
	I just includes the large_shm patch so it should be possible to
	allocate more than 2g in one shm segment. (me and Gerhard Wichert)

	Includes >4G mtrr support developed by Boszormenyi Zoltan.

	Recently fixed sysinfo structure to be defined as:

		char _f[22-3*sizeof(long)+sizeof(short)];

	so that sysinfo(2) doesn't overflow the user buffer on 64bit platforms.

	Also 2.4.x is buggy in that respect and needs to be fixed, btw.

13_rawio-2.2.19aa2-9.bz2

	SCT's rawio bigmem capable. (Stephen C. Tweedie)
	Backported latest 2.4.4 improvements.

15_lvm-0.9.1_beta4-2.2.19pre13aa1-6.bz2

	beta4 LVM compatible with the 2.4.5pre2aa1 beta7 one. (Heinz Mauelshagen)

17_lvm-consisten-snapshot-API-1

	Implements the consistent snapshot API so that for example we can
	live snaphost reiserfs.

18_lvm-0.9.1_beta4-fix-hardsectsize-2

	Fixes hardblocksize bug present in beta4 lvm. (me)

	(the fix is been merged in lvm beta7 btw)

19_rawio-helper-array-1

	use the preallocated block array in the kiobuf to save stack. (me)

30_rtclight-2.2.15pre13aa1-1.gz

	Needed by alpha SMP. (won't be needed anymore in 2.4.x)

40_lfs-2.2.19pre16aa1-26.bz2

	LFS: >2G file support for 32bit archs. This also includes
	the new getdents64 and fcntl64 syscalls in sync with the
	2.4.x user<-> kernel API. It also fixes some bug
	present in the previous 2.2.x LFS patches. Support for
	nfsv3 is complete as well on both server and client side.

47_nfsd-no_dup_disconnected_dentries-Chip-1

	Avoid duplicating disconnect dentries. (Chip)

50_robust-initrd-3

	Relocate the initrd image ASAP (btw, on alpha `ASAP' happens sooner
	than on IA32 due kseg), to avoid corrupting it while allocating the
	boot memory (like the mem_map_t array). This is good for robusteness
	and it's mainly interesting when bigmem is enabled.

70_cond-sched-1

	Implements conditional_schedule(). (Ingo Molnar from lowlatency patch)

71_copy-user-reschedule-3

	Add low latency schedule entry points into the copy_user(), this fixes
	read(2)/write(2) hangs. (Originally implemented by Ingo Molnar
	in the lowlatency patch, but this patch is not equivalent, it's 
	a very subset and it's different: the reason I put the
	conditional schedule _after_ the copy is because we want the
	higher timeslice possible once we return to userspace to avoid
	live locks during swap)

72_copy-user-unlock-1

	Drop the big kernel lock during copy-user that can release
	it anyways while getting faults. Improves SMP scalability. (me)

73_cksum-user-unlock-2

	Drop big kernel lock during TCP checksum (in tcp_sendmsg). Receiver
	side can't drop the big lock as it doesn't have a process context. (me)

74_copy-user-unlock-alpha-2

	Same as above for alpha architecture.

75_unlock-ppc-sparc-sparc64-1

	Same as above for ppc, sparc, sparc64 architectures.

80_smp-locking-1

	Fix implementation bugs in spinlocks and other SMP atomic operations
	that needs to declare "memory" as clobbered. Didn't removed the
	__dummy structures in 2.2.x to make sure not to trigger any compiler
	issue. (me)

90_NMI-watchdog-dynamic-1

	NMI wathdog is compiled in without configuration options.
	It's disabled by default. To enable it dynamically at boot
	pass the kernel the parameter "nmi_irq=0". nmi_irq=0 makes sense
	on SMP only. (original patch from Ingo Molnar, fixed to work again in
	late 2.2.x kernels and made it dynamic by me)

93_raid-2.2.18-A2_2.2.20pre2aa1-7.bz2

	RAID 0.90 updates from Ingo (it needs raidtools, not mdutils)

94_raidrebalance-2.2.18-A2_2.2.19pre3aa1-Mika-Kuoppala-1.bz2

	During reads from raid1 keep the two disks working on different
	areas of the raid1. (Mika Kuoppala)

95_GFS-00_bufcache.patch-1

	Add hooks in the buffer head that GFS needs.

95_GFS-01_cdb16.patch-1

	make scsi command length dynamic (max 16) instead of fixed to 12.
	(needed by GFS)

95_GFS-02_exportscsi.patch-1

	export rscsi_disks structure from sd.c for GFS. Note the equivalent
	patch in GFS latest release is buggy and I had to fix it up to allow
	sd_mod to be compied correctly. (just reported to GFS folks)

95_GFS-03_flock.patch-1

	Calls lowlevel f_ops->lock also from flock (not only from
	fcntl(F_*K)). needed by GFS.

95_GFS-04_ksyms.patch-1

	Export a few kernel functions for GFS module. (This was buggy
	too in the GFS latest release and it's just reported and fixed here)

95_GFS-05_pool_name.patch-1

	Added device_names to generic disk structure (for GFS).

95_GFS-06_sparc64_ioctl.patch-1

	Added few ioctl to sparc64 32bit ioctl wrapper for GFS.

95_GFS-07_stomith_x10_cm11a.patch-1

	Export change_termios to modules (for GFS).

95_GFS-08_task.patch-1

	Added fs_transaction field to the task structure (for GFS).

95_GFS-09_generic_map.patch-4

	Added generic map_fn/request_fn to ll_rw_block. The interface with
	MD and LVM got broken so it had to be fixed too. (for GFS).

95_GFS-10_pipe-fix-and-gfs-soft-inode-1

	Insert the GFS inode in the inode structure.
	GFS uses same inode for named pipes/unix sockets and
	GFS itself, so left some space before putting generic_ip pointer
	in the gfs_inode_info.

95_GFS-11_hard_panic.patch-1.bz2

	Implements hard_panic() function that will attempt to show the message
	nad reboot the machine after some second.

95_GFS-12_opaque-inode-2.bz2

	Pass the opaque cookie of iget4 back to the filesystem during
	the read_inode callback.

---------------------------------------------------------------------------

The 2.2.20pre2aa1 patch is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20pre2aa1.bz2

As usual all the separate patches are in:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20pre2aa1/

and they can be applyed in `ls` order to generate the 2.2.20pre2aa1.bz2
kernel.

Have fun.

Andrea

PS. If you'll run with more than 4giga of RAM on alpha, you'll need also
to fix procps if you want to read the correct MM values with `free`, `top`
and `vmstat`. procps takes all the memory information with byte
granularity in `int` words (and not long words). I fixed procps this way:

	ftp://ftp.suse.com/pub/people/andrea/procps/procps-2.0.2-bigmem-1.gz
