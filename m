Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281690AbRLAVfM>; Sat, 1 Dec 2001 16:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281705AbRLAVfC>; Sat, 1 Dec 2001 16:35:02 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:30476 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281704AbRLAVes>; Sat, 1 Dec 2001 16:34:48 -0500
Message-ID: <3C094CDF.A3FF1D26@zip.com.au>
Date: Sat, 01 Dec 2001 13:34:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Holmes <jholmes@psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: IO degradation in 2.4.17-pre2 vs. 2.4.16
In-Reply-To: <3C092CAB.4D1541F4@psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Holmes wrote:
> 
> I saw in a previous thread that the interactivity improvements in
> 2.4.17-pre2 had some adverse effect on IO throughput and since I was
> already evaluating 2.4.16 for a somewhat large fileserving project, I
> threw 2.4.17-pre2 on to see what has changed.  Throughput while serving
> a large number of clients is important to me, so my tests have included
> using dbench to try to see how things scale as clients increase.
> 
> 2.4.16:
> 
> ...
> Throughput 210.989 MB/sec (NB=263.736 MB/sec  2109.89 MBit/sec)  16 procs
> ...
> 
> 2.4.17-pre2:
> 
> ...
> Throughput 153.672 MB/sec (NB=192.09 MB/sec  1536.72 MBit/sec)  16 procs
> ...

This is expected, and tunable.

The thing about dbench is this:  it creates files and then it
quickly deletes them.  It is really, really important to understand
this!

If the kernel allows processes to fill all of memory with dirty
data and to *not* start IO on that data, then this really helps
dbench, because when the delete comes along, that data gets tossed
away and is never written.

If you have enough memory, an entire dbench run can be performed
and it will do no disk IO at all.
 
The 2.4.17-pre2 change meant that the kernel starts writeout of
dirty data earlier, and will cause the writer to block, to
prevent it from filling all memory with write() data.  This is
how the kernel is actually supposed to work, but it wasn't working
right, and the mistake benefitted dbench.  The net effect is that
a dbench run does a lot more IO.

If your normal operating workload creates files and does *not* 
delete them within a few seconds, then the -pre2 change won't
make much difference at all, as your bonnie++ figures show.

If your normal operating workloads _does_ involve very short-lived
files then you can optimise for that load by increasing the
kernel's dirty buffer thresholds:

mnm:/home/akpm> cat /proc/sys/vm/bdflush 
40      0       0       0       500     3000    60      0       0
^^                                              ^^
  nfract                                          nfract_sync

These two numbers are percentages.

nfract: percentage of physical memory at which a write()r will
start writeout.

nfract_sync: percentage of physical memory at which a write()r
will block on some writeout (writer throttling).

You'll find that running

	echo 80 0 0 0 500 3000 90 0 0  > /proc/sys/vm/bdflush

will boost your dbench throughput muchly.

dbench is a good stability and stress tester.  It is not a good
benchmark, and it is not representative of most real-world
workloads.

-
