Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318252AbSIOUar>; Sun, 15 Sep 2002 16:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318253AbSIOUar>; Sun, 15 Sep 2002 16:30:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:23444 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318252AbSIOUaq>;
	Sun, 15 Sep 2002 16:30:46 -0400
Message-ID: <3D84F2D3.2FDB1368@digeo.com>
Date: Sun, 15 Sep 2002 13:51:31 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org, Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Subject: Re: Revealing benchmarks and new version of contest.
References: <1032087616.3d846840e6eb1@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2002 20:35:35.0742 (UTC) FILETIME=[71E6BDE0:01C25CF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> IO Load Full:
> Kernel                  Time            CPU
> 2.4.19-ck7              2:34.04         43%
> 2.4.19                  3:14.52         40%
> 2.5.34(-mm4)            14:59.79        8%
> 2.4.19-ck7-rmap         1:32.34         74%
> 2.4.20-pre7             3:37.75         32%
> 2.5.34                  1:49.62         63%
> 

OK, I can reproduce this.  It's the elevator problem.

$ dd if=/dev/zero of=foo bs=1M count=8000 &
$ sleep 10
$ time cat kernel/*.c > /dev/null
cat kernel/*.c > /dev/null  0.01s user 0.51s system 0% cpu 1:41.76 total

Nearly two minutes to read three megabytes.

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  1  3   6172   3396    464 164988    0    0    12 30156 1163  1411  2 96  2
 0  2  1   6172   2832    472 165596    0    0     4 27048 1146   352  0 100  0
 1  1  2   6172   2496    492 165928    0    0     0 34144 1161   984  0 100  0
 1  1  2   6184   2448    500 166348    0    0    12 26076 1287  1318  2 98  0
 0  2  2   6184   2620    480 166132    0    0     0 42900 1118   402  0 100  0
 0  2  2   6184   3560    492 165256    0    0     4 15124 1100   187  8 92  0
 0  2  2   6184   2424    524 166380    0    0     4 31988 1082   379  0 100  0
 0  2  3   6184   2460    544 166324    0    0     0 20152 1082   276  0 100  0
 1  1  4   6184   2468    400 166312    0    0     0 31440 1135   473  3 97  0
 0  2  3   6188   2804    420 166272    0    0     8 35204 1093   422  3 97  0
 0  2  2   6188   2580    428 166548    0    0     4 18860 1104   191  0 90 10
 0  2  3   6228   3348    468 165892    0    0     0 40232 1109   542  0 100  0
 1  1  4   6228   2436    496 166800    0    0     0 18788 1097   355  0 100  0
 0  2  4   6228   3168    520 166028    0    0     8 29764 1093   376  3 97  0
 0  2  4   6228   2860    536 166324    0    0     0 18748 1068   303  0 100  0
 0  2  1   6228   2764    548 166396    0    0     4 33124 1148   259  7 93  0

No read activity.

(gdb) info threads
  88 Thread 21769  io_schedule () at /usr/src/25/include/asm/atomic.h:122
  87 Thread 21768  schedule_timeout (timeout=-937779520) at timer.c:866
  86 Thread 21767  schedule_timeout (timeout=-1032683840) at timer.c:866

(gdb) thread 88
[Switching to thread 88 (Thread 21769)]#0  io_schedule () at /usr/src/25/include/asm/atomic.h:122
122             __asm__ __volatile__(

(gdb) comm25
$7 = "cat\000\000og\000\000\000\000\000\000\000\000"

(gdb) bt
#0  io_schedule () at /usr/src/25/include/asm/atomic.h:122
#1  0xc01305b4 in __lock_page (page=0xc1120780) at filemap.c:370
#2  0xc0130a7f in do_generic_file_read (filp=0xc8db33c0, ppos=0xc8db33e0, desc=0xc07c3ecc, actor=0xc0130c10 <file_read_actor>)
    at /usr/src/25/include/linux/pagemap.h:86
#3  0xc0130f7f in __generic_file_aio_read (iocb=0xc07c3f04, iov=0xc07c3efc, nr_segs=1, ppos=0xc8db33e0) at filemap.c:867
#4  0xc0131032 in generic_file_read (filp=0xc8db33c0, buf=0x804dcc0 "sync", count=4096, ppos=0xc8db33e0) at filemap.c:895
#5  0xc0143040 in vfs_read (file=0xc8db33c0, buf=0x804dcc0 "sync", count=4096, pos=0xc8db33e0) at read_write.c:193
#6  0xc01431ee in sys_read (fd=3, buf=0x804dcc0 "sync", count=4096) at read_write.c:232
#7  0xc01090e3 in syscall_call () at stats.c:204

`cat' has issued a read and is waiting for IO to complete.




The disk elevator is supposed to stop servicing the streaming write
at some point and give the disk head to the reads, but that isn't
working.

The same happens with reads-versus-reads in some situations.  It's
complex, and I've been putting it off.  Jens has a new IO scheduler
in the works; and perhaps time spent investigating this would be wasted.

Why is it worse with -mm4?  With other kernels, `dd' ends up waiting
on one of its own locked pages and it goes for a big snooze, allowing the
queue to empty.  -mm4 won't do that.  It will keep the queue filled all
the time.

This is all happening because you're running io_fullmem against the
same disk as the one on which the kernel build is being performed.
That is a valid and interesting test, but it's more an IO scheduler
test than an VM test.   I'd suggest that you also test when the 
heavy write is against a different disk.

I'll go see if Jens' deadline-iosched-5 patch fixes it.
