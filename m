Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265933AbRGKAo6>; Tue, 10 Jul 2001 20:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265958AbRGKAot>; Tue, 10 Jul 2001 20:44:49 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22836 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265933AbRGKAon>; Tue, 10 Jul 2001 20:44:43 -0400
Date: Wed, 11 Jul 2001 02:45:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7pre5aa1
Message-ID: <20010711024506.B685@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.4.7pre3aa1 and 2.4.7pre5aa1:

Only in 2.4.7pre3aa1: 00_async-io-unlock-race-1
Only in 2.4.7pre3aa1: 00_cpus_allowed-1

	Merged in mainline.

Only in 2.4.7pre3aa1: 00_bh-async-1
Only in 2.4.7pre5aa1: 00_bh-async-2

	Rediffed against pre5 due trivial rejects.

Only in 2.4.7pre5aa1: 00_create_bounces-sleeps-1

	Kill KM_BOUNCE_WRITE and use kmap instead of kmap_atomic+cli in the
	write-bounce case since create_bounces is allowed to sleep.

Only in 2.4.7pre5aa1: 00_drop___unlock_buffer-1

	Rename __unlock_buffer to unlock_buffer. I did it before knowing Linus
	did it too sorry.

Only in 2.4.7pre5aa1: 00_drop_async-io-get_bh-1

	Drop the get_bh/atomic_inc around the async I/O, for any bh that uses
	set_buffer_async_io the page will be locked for the whole duration of
	the I/O (that's why you use set_buffer_async_io in first place) so the
	bh doesn't need the additional b_count protection during the I/O and we
	this way we can save some cycle.

Only in 2.4.7pre5aa1: 00_drop_end_buffer_write-1

	Drop end_buffer_write and replace with the sync_io callback to avoid
	wasting icache. Here too I should have waited for pre6 but I just
	did it.

Only in 2.4.7pre5aa1: 00_drop_write_unlocked-get_bh-1

	Micro-optimize a bit in write_unlocked_buffers: the get_bh is needed
	only if the buffer was dirty and we are going to do the I/O on it (all
	the rest is protected by the lru_list_lock).

Only in 2.4.7pre5aa1: 00_kiobuf-backout-get_bh-1

	Remove the get_bh/put_bh around the kiobuf driven I/O, the notifion of
	the refernece count and of I/O in flight belongs to the kiobuf not to
	the bh, the bh are just an array of ram in the kiobuf, and this way we
	save some cycle.

Only in 2.4.7pre3aa1: 00_ksoftirqd-7_ppc-2
Only in 2.4.7pre3aa1: 00_ksoftirqd-8

	ksoftirqd is in mainline. All ports needs to synchronize now.
	Alpha and x86 are uptodate in pre5. I uptodate uml in my tree
	to get it right too.

	For port maintainers: in short you need to do the:

		if (pending_softirq(cpu))
			do_softirq();

	check only when returning from irqs that can post softirq events (for
	example IPI never post softirq events currently, theoretically you
	could with the smp_call but nobody uses it that way at the moment). For
	example x86 and alpha do the check in C in the last few lines of C of
	the irq handler.

	You _don't_ need to check for pending softirq when returning
	from kernel to userspace any longer, that case is now handled with
	ksoftirqd, this gives higher performance in the ret-to-userspace and
	reschedule fast paths (that is the change made by Linus).

	As usual ksoftirqd keeps handling the overflow case.

Only in 2.4.7pre5aa1: 00_linus-brelse-fix-1

	This is a patch from Linus to fix a race condition he spotted in brelse
	that could trigger on architectures where the atomic_t changes don't
	imply SMP memory barriers at the CPU level.

Only in 2.4.7pre3aa1: 00_meminfo-wraparound-1
Only in 2.4.7pre5aa1: 00_meminfo-wraparound-2

	Rediffed to fixup trivial rejects.

Only in 2.4.7pre3aa1: 00_msync-fb0-1

	Merged in mainline.

Only in 2.4.7pre5aa1: 00_o_direct-10
Only in 2.4.7pre3aa1: 00_o_direct-9

	Fixed O_SYNC|O_DIRECT, when O_SYNC was used in combination with
	O_DIRECT it was returning a short write even if all the I/O was
	reaching the disk succesfully and the f_pos was updated correctly, (in
	my regression testing of O_SYNC|O_DIRECT I obviously forgotten to check
	for short writes, I was only checking for errors and it was working
	like a charm). Thanks to Peter for spotting and reporting this.

	Fixed also another bug that could forget to wait for I/O completion
	of async I/O for O_SYNC/fsync/fdatasync.

Only in 2.4.7pre3aa1: 51_uml-ac-to-aa-1.bz2
Only in 2.4.7pre5aa1: 51_uml-ac-to-aa-2.bz2

	Updated to pre5 ksoftirqd logic.

Available at:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre5aa1/
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre5aa1.bz2

A fixed O_DIRECT patch against vanilla 2.4.7pre5 is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.7pre5/o_direct-10

Andrea
