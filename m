Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbQKBHXm>; Thu, 2 Nov 2000 02:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130759AbQKBHXc>; Thu, 2 Nov 2000 02:23:32 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:2308 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S129164AbQKBHXZ>; Thu, 2 Nov 2000 02:23:25 -0500
Date: Wed, 1 Nov 2000 23:23:44 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: linux-kernel@vger.kernel.org
Subject: [BUG?] two swapping processes freeze 2.4.0-test10 (but not 2.2.18pre19)
Message-ID: <Pine.LNX.4.21.0011012222210.1296-100000@shimura.math.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

My group runs computations on a small linux cluster of RedHat 7.0 dual
PIII-700's with 512MB RAM/512MB swap.  We have been experiencing some
lockups/poor performance on 2.4.x kernels when running two computations at
once.  I've narrowed it down to a reproducible problem under 2.4.0-test10
(gcc 2.91.66), using a test computation which will grow in memory
footprint to about 830MB over the course of a few minutes:

I simultaneously run "top d1" and two of the test computations.  All is
well (top updates smoothly) until physical RAM is exhausted.  However, as
soon as swap is touched, then top freezes and does not update.  In this
state, I can switch virtual consoles but not login to a new one; the
machine is pingable but does not respond to ssh.  Once swap is exhausted,
the OOM killer kicks in and kills one of the test computations; then all
is well and everything works as expected.

A few observations/comments:

(1) Under 2.2.18pre19, this problem does not occur.  Even while swapping,
top, sshd, etc work fine.

(2) If I run only one process, this problem does not occur.

(3) I sometimes find one of the machines frozen in the morning after
running two computations overnight (pingable, no ssh or console
switching).  The last time this happened (under 2.4.0-test10-pre6/gcc 2.96
[before I knew better]) there were some unusual log messages, which I
attached below, in case this is related.

(4) I noticed a recent message on the kernel mailing list that I thought
might be the same problem:

On Wed, 1 Nov 2000, Rik van Riel wrote (in "Re: [BUG] /proc/<pid>/stat
access stalls badly for swapping process, 2.4.0-test10"):

> I have one possible reason for this .... 
>
> 1) the procfs process does (in fs/proc/array.c::proc_pid_stat) 
>         down(&mm->mmap_sem); 
>
> 2) but, in order to do that, it has to wait until the process 
>    it is trying to stat has /finished/ its page fault, and is 
>    not into its next one ... 
>
> 3) combine this with the elevator starvation stuff (ask Jens 
>    Axboe for blk-7 to alleviate this issue) and you have a 
>    scenario where processes using /proc/<pid>/stat have the 
>    possibility to block on multiple processes that are in the 
>    process of handling a page fault (but are being starved) 

Any help would be greatly appreciated.  I am not on the kernel mailing
list but read it daily via an archive, so please cc: if you'd like a
timely response.

Best wishes,
Wayne


Oct 30 15:35:27 mf2 kernel: eed.
Oct 30 15:35:27 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 30 15:35:27 mf2 last message repeated 363 times
Oct 30 19:33:53 mf2 kernel: Out of Memory: Killed process 1485 (magma.exe).eed.
Oct 30 19:33:54 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 30 19:33:54 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 30 19:33:54 mf2 kernel: __alloc_pages: 0-order allocatied.
Oct 30 19:33:54 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 30 19:33:54 mf2 last message repeated 363 times
Oct 31 01:52:46 mf2 kernel: <ed.
Oct 31 01:52:46 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 31 01:52:46 mf2 last message repeated 363 times
Oct 31 02:47:53 mf2 kernel: eed.
Oct 31 02:47:57 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 31 02:47:58 mf2 last message repeated 89 times
Oct 31 02:47:58 mf2 kernel: __alloc_pages: 0-order allocation faied.
Oct 31 02:47:58 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 31 02:47:58 mf2 last message repeated 363 times
Oct 31 12:01:46 mf2 kernel: Out of Memory: Killed process 1691 (magma.exe).<3>__alloc_pages: 0-order allocation failed.
Oct 31 12:01:47 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 31 12:01:47 mf2 last message repeated 89 times
Oct 31 12:01:47 mf2 kernel: ed.
Oct 31 12:01:47 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 31 12:01:47 mf2 last message repeated 363 times
Oct 31 16:02:36 mf2 kernel: <ed.
Oct 31 16:02:45 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 31 16:02:46 mf2 last message repeated 89 times
Oct 31 16:02:46 mf2 kernel: __alloc_pages: 0-order allocation faied.
Oct 31 16:02:46 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 31 16:02:46 mf2 last message repeated 363 times
Oct 31 16:03:03 mf2 kernel: <ed.
Oct 31 16:03:03 mf2 kernel: __alloc_pages: 0-order allocation failed.
Oct 31 16:03:04 mf2 last message repeated 89 times
Oct 31 16:03:04 mf2 kernel: __alloc_pages: 0-order allocation faied.
Oct 31 16:03:04 mf2 kernel: __alloc_pages: 0-order allocation failed.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
