Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156758AbPJERYl>; Tue, 5 Oct 1999 13:24:41 -0400
Received: by vger.rutgers.edu id <S156945AbPJERVc>; Tue, 5 Oct 1999 13:21:32 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:16278 "EHLO pneumatic-tube.sgi.com") by vger.rutgers.edu with ESMTP id <S156923AbPJERUd>; Tue, 5 Oct 1999 13:20:33 -0400
Date: Tue, 5 Oct 1999 10:20:31 -0700 (PDT)
From: hawkes@babylon.engr.sgi.com (John Hawkes)
Message-Id: <199910051720.KAA91339@babylon.engr.sgi.com>
To: linux-kernel@vger.rutgers.edu
Subject: [PATCH] IA32 SMP spinlock metering
Sender: owner-linux-kernel@vger.rutgers.edu

Please consider this SMP i386 patch against 2.3.18 (or an analogous patch
against 2.2.12) to add a "spinlock metering" enhancement:
    http://oss.sgi.com/projects/lockmeter/download/

Spinlock metering is the runtime recording of data about spinlock usage --
how often each spinlock is acquired by each locker and held for how long,
how often an acquisition attempt faced contention and had to wait because
someone else owned that spinlock, and how much wait-time passed before the
lock was released and the contention went away.

The new code (accessed through the above URL) exists in two 10KB gzip'ed
pieces:  a kernel patch containing two new files and several modified files;
and a new "lockstat" command, which turns the functional act of metering on
or off in a metering-capable kernel, and which retrieves the kernel's
metering data and displays it to the user in a human-readable tabular format.

Lockstat uses the running kernel's System.map to translate the kernel's
reported virtual addresses into symbolic spinlock and procedure names,
whenever possible.  Wait-times and hold-times are displayed in microseconds.

After the kernel patch is applied to the kernel, a new config variable (in
the "Kernel hacking" subsection) controls whether or not metering gets
compiled into the kernel.  A metering-capable kernel has essentially the
same size as a non-metering-capable kernel because the non-metered
kernel's inline locking code gets replaced by procedure calls, and the
multiple-reader-single-writer locks get significantly smaller.

A metering-capable kernel is negligibly slower than a normal kernel when
metering is turned off.  It is 1-2% slower when default metering is turned
on, recording wait-times, and it is as much as 5-8% slower when the optional
"hold-time" metering functionality is turned on.  Thus, wait-time metering
is negligibly invasive to system performance and provides a black-box look
at which locks (and their callers) produce the longest contending waits,
and hold-time metering provides a more illuminating look at which callers
are actually holding these locks and for how long -- more interesting
information for the analyst, but at the higher cost of degraded kernel
performance.

Care has been taken to minimize runtime performance impact of lockmetering.
For example, the data structures that record the counts and times are
separated per CPU, which means there is no cache coherency overhead when
different CPUs update counts for the same spinlock being called by the same
caller.

As an example of the usefulness of this lockmetering code, I exercised 2x,
3x, and 4xCPU (4x400 MHz Xeon) configurations with an AIM7 workload that
had been modified to remove three synchronous disk subtests that otherwise
would contend on a single disk spindle and produce substantial idle time.
My test workload ran with effectively zero idle time, about 75% user and 25%
system time.

My test results:

The 4xCPU 2.3.11 kernel performs about 6-8% faster than the 2.2.10 kernel at
the highest loads.  The 2.3.11 kernel did almost 3x the number of spinlocks-
per-second vs. the 2.2.10 kernel, due to the finer granularity of 2.3's
locking schemes, but 2.3 exhibits lock contention on only 2% of these calls
vs. 18% in 2.2.  When 2.3 does contend, the mean wait-times are almost 2x
those in 2.2.  One possible hypothesis for the longer mean wait-times is
that 2.3 has eliminated the quick, trivial contentions, leaving the longer
contentions to raise the mean.

With this workload on this 4xCPU Xeon hardware, spinlock contention in
2.2.10 consumed about 8% of theoretically available CPU cycles (340
millisecs/sec of waiting out of the 4,000 millisecs/sec theoretically
available) vs. about 2% in 2.3.11 (95 millisecs of waiting out of 4,000
millisecs).

The kernel_flag usage is still significant in 2.3, but its contention is
greatly reduced.  In 2.2 I saw contention on 40% of the 41K-per-second
acquisitions, vs. 10% of the 19K-per-second acquisitions done in 2.3.
Despite the almost 2x increase in mean wait-time on the kernel_flag in 2.3,
the overall number of kernel_flag contention cycles in 2.3.11 is about 1/3
of that in 2.2.10.  That is, the 2.3 kernel goes after kernel_flag much less
frequently and sees much less contention on it; but when there is contention,
that contention results in a mean wait that is twice as long as in 2.2.

Further investigation using hold-time analysis showed that the biggest
kernel_flag pig in 2.3.11 is sys_close(), which holds the kernel_flag for as
long as 10-13 milliseconds (on a 400 MHz Xeon CPU) on a regular basis.

A broader discussion of spinlock metering is available at the SGI Open Source
website:  http://oss.sgi.com/projects/lockmeter

-- 
John Hawkes
(hawkes@engr.sgi.com)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
