Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263043AbTCWMWg>; Sun, 23 Mar 2003 07:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263048AbTCWMWg>; Sun, 23 Mar 2003 07:22:36 -0500
Received: from sysdoor.net ([62.212.103.239]:56333 "EHLO celia")
	by vger.kernel.org with ESMTP id <S263043AbTCWMWd>;
	Sun, 23 Mar 2003 07:22:33 -0500
Date: Sun, 23 Mar 2003 13:33:32 +0100
From: Michael Vergoz <mvergoz@sysdoor.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp overhead, and rwlocks considered harmful
Message-Id: <20030323133332.4693024e.mvergoz@sysdoor.com>
In-Reply-To: <20030322175816.225a1f23.akpm@digeo.com>
References: <20030322175816.225a1f23.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I would like to noticed to you that the SMP capacity can't be used on one process under Linux.

when you run 'time dd if=/dev/zero of=foo bs=1 count=1M', the capacity of 1 processor will use since your command sets is executed in ONE process.

In different with FreeBSD, there is a processor STATE _per_ process, so the kernel can 'load balance' the current syscall execution.

To 'SMPized' your programme, you have to create X process (X corresponding to the machine processors numbers.). And exec your syscall since these process.

Is there a small of my test :
[DEBUG] at 3e7da90d - Scheduler.c: Initialized.
[DEBUG] at 3e7da90d - Interrupt.c: Entrering in Linux process management.
[INFOS] at 3e7da90d - LinuxProcessor.c: There is 4 proccessor(s) on this machine.
[INFOS] at 3e7da90d - LinuxProcessor.c: Initialize processor #0 (Intel(R) Xeon(TM) CPU 2.40GHz)
[INFOS] at 3e7da90d - LinuxProcessor.c: Initialize processor #1 (Intel(R) Xeon(TM) CPU 2.40GHz)
[INFOS] at 3e7da90d - LinuxProcessor.c: Initialize processor #2 (Intel(R) Xeon(TM) CPU 2.40GHz)
[INFOS] at 3e7da90d - LinuxProcessor.c: Initialize processor #3 (Intel(R) Xeon(TM) CPU 2.40GHz)
[INFOS] at 3e7da90d - LinuxProcessor.c: Waiting processor(s) initialization...
[INFOS] at 3e7da97b - LinuxProcessor.c: Processor #2 initialized. (pid=9771)
[INFOS] at 3e7da97c - LinuxProcessor.c: Processor #3 initialized. (pid=9772)
[INFOS] at 3e7da97d - LinuxProcessor.c: Processor #0 initialized. (pid=9769)
[INFOS] at 3e7da97e - LinuxProcessor.c: Processor #1 initialized. (pid=9770)
[INFOS] at 3e7da915 - LinuxProcessor.c: All processor(s) is ready.
[DEBUG] at 3e7da915 - LinuxInterrupt.c: Interrupt execution trip average : 24.220 ms
[DEBUG] at 3e7da916 - LinuxInterrupt.c: Interrupt execution trip average : 1.200 ms
[DEBUG] at 3e7da916 - LinuxInterrupt.c: Interrupt execution trip average : 1.240 ms
[DEBUG] at 3e7da917 - LinuxInterrupt.c: Interrupt execution trip average : 1.200 ms
[DEBUG] at 3e7da917 - LinuxInterrupt.c: Interrupt execution trip average : 1.240 ms
[DEBUG] at 3e7da918 - LinuxInterrupt.c: Interrupt execution trip average : 1.360 ms
[DEBUG] at 3e7da918 - LinuxInterrupt.c: Interrupt execution trip average : 1.300 ms
[DEBUG] at 3e7da919 - LinuxInterrupt.c: Interrupt execution trip average : 1.440 ms
[DEBUG] at 3e7da919 - LinuxInterrupt.c: Interrupt execution trip average : 1.360 ms
[DEBUG] at 3e7da91a - LinuxInterrupt.c: Interrupt execution trip average : 1.260 ms
[DEBUG] at 3e7da91a - LinuxInterrupt.c: Interrupt execution trip average : 1.500 ms
[DEBUG] at 3e7da91b - LinuxInterrupt.c: Interrupt execution trip average : 1.340 ms
[DEBUG] at 3e7da91b - LinuxInterrupt.c: Interrupt execution trip average : 1.460 ms
[DEBUG] at 3e7da91c - LinuxInterrupt.c: Interrupt execution trip average : 1.460 ms
[DEBUG] at 3e7da91c - LinuxInterrupt.c: Interrupt execution trip average : 1.340 ms
[DEBUG] at 3e7da91d - LinuxInterrupt.c: Interrupt execution trip average : 1.300 ms
[DEBUG] at 3e7da91e - LinuxInterrupt.c: Interrupt execution trip average : 1.420 ms
[DEBUG] at 3e7da91e - LinuxInterrupt.c: Interrupt execution trip average : 1.560 ms
[DEBUG] at 3e7da91f - LinuxInterrupt.c: Interrupt execution trip average : 1.360 ms
[DEBUG] at 3e7da91f - LinuxInterrupt.c: Interrupt execution trip average : 1.360 ms

Sorry for my bad english :/

Best regards,
Michael



On Sat, 22 Mar 2003 17:58:16 -0800
Andrew Morton <akpm@digeo.com> wrote:

> 
> I've been looking at the CPU cost of the write() system call.  Time how long
> it takes to write a million bytes to an ext2 file, via a million
> one-byte-writes:
> 
> 	time dd if=/dev/zero of=foo bs=1 count=1M
> 
> This only uses one CPU.  It takes twice as long on SMP.
> 
> On a 2.7GHz P4-HT:
> 
> 	2.5.65-mm4, UP:
> 		0.34s user 1.00s system 99% cpu 1.348 total
> 	2.5.65-mm4, SMP:
> 		0.41s user 2.04s system 100% cpu 2.445 total
> 
> 	2.4.21-pre5, UP:
> 		0.34s user 0.96s system 106% cpu 1.224 total
> 	2.4.21-pre5, SMP:
> 		0.42s user 1.95s system 99% cpu 2.372 total
> 
> (The small additional overhead in 2.5 is expected - there are more function
> calls due to the addition of AIO and there is more setup due to the (large)
> writev speedups).
> 
> 
> On a 500MHz PIII Xeon:
> 
> 	500MHz PIII, UP:
> 		1.08s user 2.90s system 100% cpu 3.971 total
> 	500MHz PIII, SMP:
> 		1.13s user 4.86s system 99% cpu 5.999 total
> 
> 
> This pretty gross.  About six months back I worked out that across the
> lifecycle of a pagecache page (creation via write() through to reclaim via
> the page LRU) we take 27 spinlocks and rwlocks.  And this does not even
> include semaphores and atomic bitops (I used lockmeter).  I'm not sure it is
> this high any more - quite a few things were fixed up, but it is still high.
> 
> 
> Profiles for 2.5 on the P4 show that it's all in fget(), fput() and
> find_get_page().  Those locked operations are really hurting.
> 
> One thing is noteworthy: ia32's read_unlock() is buslocked, whereas
> spin_unlock() is not.  So let's see what happens if we convert file_lock
> from an rwlock to a spinlock:
> 
> 
> 2.5.65-mm4, SMP:
> 	0.34s user 2.00s system 100% cpu 2.329 total
> 
> That's a 5% speedup.
> 
> 
> And if we were to convert file->f_count to be a nonatomic "int", protected by
> files_lock it would probably speed things up further.
> 
> I've always been a bit skeptical about rwlocks - if you're holding the lock
> for long enough for a significant amount of reader concurrency, you're
> holding it for too long.  eg:  tasklist_lock.
> 
> 
> 
> SMP:
> 
> c0254a14 read_zero                                   189   0.3841
> c0250f5c clear_user                                  217   3.3906
> c0148a64 sys_write                                   251   3.9219
> c0148a24 sys_read                                    268   4.1875
> c014b00c __block_prepare_write                       485   0.5226
> c0130dd4 unlock_page                                 493   7.7031
> c0120220 current_kernel_time                         560   8.7500
> c0163190 __mark_inode_dirty                          775   3.5227
> c01488ec vfs_write                                   983   3.1506
> c0132d9c generic_file_write                          996  10.3750
> c01486fc vfs_read                                   1010   3.2372
> c014b3ac __block_commit_write                       1100   7.6389
> c0149500 fput                                       1110  39.6429
> c01322e4 generic_file_aio_write_nolock              1558   0.6292
> c0130fc0 find_lock_page                             2301  13.0739
> c01495f0 fget                                       2780  33.0952
> c0108ddc system_call                                4047  91.9773
> c0106f64 default_idle                              24624 473.5385
> 00000000 total                                     45321   0.0200
> 
> UP:
> 
> c023c9ac radix_tree_lookup                            13   0.1711
> c015362c inode_times_differ                           14   0.1944
> c015372c inode_update_time                            14   0.1000
> c012cb9c generic_file_write                           15   0.1630
> c012ca90 generic_file_write_nolock                    17   0.1214
> c0140e1c fget                                         17   0.3542
> c023deb8 __copy_from_user_ll                          17   0.1545
> c0241514 read_zero                                    17   0.0346
> c014001c vfs_read                                     18   0.0682
> c01401dc vfs_write                                    20   0.0758
> c01430d8 generic_commit_write                         20   0.1786
> c01402e4 sys_read                                     21   0.3281
> c0142968 __block_commit_write                         29   0.2014
> c023dc4c clear_user                                   34   0.5312
> c0140324 sys_write                                    38   0.5938
> c01425cc __block_prepare_write                        39   0.0422
> c012c0f4 generic_file_aio_write_nolock                89   0.0362
> c0108b54 system_call                                 406   9.2273
> 00000000 total                                       944   0.0004
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
