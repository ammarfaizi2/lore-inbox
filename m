Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbTCWGXq>; Sun, 23 Mar 2003 01:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262837AbTCWGXq>; Sun, 23 Mar 2003 01:23:46 -0500
Received: from h-64-105-35-106.SNVACAID.covad.net ([64.105.35.106]:31620 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262835AbTCWGXo>; Sun, 23 Mar 2003 01:23:44 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 22 Mar 2003 22:34:41 -0800
Message-Id: <200303230634.WAA02236@adam.yggdrasil.com>
To: akpm@digeo.com, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: smp overhead, and rwlocks considered harmful
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-03-23, Andrew Morton wrote:
>I've been looking at the CPU cost of the write() system call.  Time how long
>it takes to write a million bytes to an ext2 file, via a million
>one-byte-writes:
[...]
>One thing is noteworthy: ia32's read_unlock() is buslocked, whereas
>spin_unlock() is not.  So let's see what happens if we convert file_lock
>from an rwlock to a spinlock:
>
>
>2.5.65-mm4, SMP:
>        0.34s user 2.00s system 100% cpu 2.329 total
>
>That's a 5% speedup.
>
>
>And if we were to convert file->f_count to be a nonatomic "int", protected by
>files_lock it would probably speed things up further.
>
>I've always been a bit skeptical about rwlocks - if you're holding the lock
>for long enough for a significant amount of reader concurrency, you're
>holding it for too long.  eg:  tasklist_lock.

	A million one byte writes is probably not the use case for
which we want to trade off, against against other cases that are more
common or more performance critical.

	I'm not saying that you're necessarily wrong.  I haven't
looked into typical rwlock usage enough to have a well founded opinion
about it, and it's obvious that you have done some detailed research
on at least this specific case.  I am saying that I think I'd have to
see essentially no negative effects on workloads that we care more
about before being convinced that converting rwlocks to spinlocks is a
good trade-off either globally or in specific cases.

	Also, what is optimal on a one CPU system running an SMP
kernel may be different from what is optimal on a bigger machine.  So,
if it turns out that you're right in the 1-2 CPU case and wrong in the
64 CPU NUMA case, then perhaps we want some maybe_rwlock primitive
that is a spinlock if one CONFIG_RWLOCK_EXPENSIVE flag is set and an
rwlock if it is not set for code that does not *rely* on the ability
to have more than one owner of a read lock.  I want to emphasize that
I'm not suggesting that anyone implement this complexity unless this
prediction turns out to be true.  I'm just speculating on one
potential scenario.

	Speaking of scaling up, I think it might be useful to have a
version of rw_semaphore and perhaps of rwlock that used per_cpu memory
(probably throgh dcounter) so that calls to read_{up,down} without any
intervening calls to write_{up,down} would cause no inter-cpu cache
consistency traffic.  (This idea was inspired by Roman Zippel's posting
of an implementation of module usage counters along these lines.)

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
