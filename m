Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSFXWvj>; Mon, 24 Jun 2002 18:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315410AbSFXWvi>; Mon, 24 Jun 2002 18:51:38 -0400
Received: from chfdns01.ch.intel.com ([143.182.246.24]:35054 "EHLO
	pan.ch.intel.com") by vger.kernel.org with ESMTP id <S315406AbSFXWvg>;
	Mon, 24 Jun 2002 18:51:36 -0400
Message-ID: <01BDB7EEF8D4D3119D95009027AE99951B0E63FA@fmsmsx33.fm.intel.com>
From: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
To: "'Andrew Morton'" <akpm@zip.com.au>, mgross <mgross@unix-os.sc.intel.com>
Cc: "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: RE: ext3 performance bottleneck as the number of spindles gets la
	rge
Date: Mon, 24 Jun 2002 15:51:35 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
I ran your write-and-fsync program.  Here are the results:
#cntrlrs x #drives
2x2 avg = 25.04 MB/s        aggregate = 100 MB/s
2x4 avg =  9.17 MB/s        aggregate = 110 MB/s
4x2 avg = 14.55 MB/s        aggregate = 116.4 MB/s
4x6 avg =  4.94 MB/s        aggregate = 118.6 MB/s

Your program only addresses large I/O (1MB) against a fairly large file
(4GB). We did that as well with Bonnie++ (2GB file 1MB I/O requests).  The
results without the fsync option ran about 94 - 100 MB/s.  Our concern was
creating a more real world mix of I/O.  How well does the system scale
against a variety of I/O request sizes on various size files.  Where we saw
the worst overall scaling was with 8K requests.

Richard

mgross wrote:
> 
> ...
> >And please tell us some more details regarding the performance
bottleneck.
> >I assume that you mean that the IO rate per disk slows as more
> >disks are added to an adapter?  Or does the total throughput through
> >the adapter fall as more disks are added?
> >
> No, the IO block write throughput for the system goes down as drives are
> added under this work load.  We measure the system throughput not the
> per drive throughput, but one could infer the per drive throughput by
> dividing.
> 
> Running bonnie++ on with 300MB files doing 8Kb sequential writes we get
> the following system wide throughput as a function of the number of
> drives attached and by number of addapters.
> 
> One addapter
> 1 drive per addapter    127,702KB/Sec
> 2 drives per addapter  93,283 KB/Sec
> 6 drives per addapter   85,626 KB/Sec

127 megabytes/sec to a single disk?  Either that's a very
fast disk, or you're using very small bytes :)

> 2 addapters
> 1 drive per addapter    92,095 KB/Sec
> 2 drives per addapter  110,956 KB/Sec
> 6 drives per addapter   106,883 KB/Sec
> 
> 4 addapters
> 1 drive per addapter    121,125 KB/Sec
> 2 drives per addapter   117,575 KB/Sec
> 6 drives per addapter   116,570 KB/Sec
> 

Possibly what is happening here is that a significant amount
of dirty data is being left in memory and is escaping the
measurement period.   When you run the test against more disks,
the *total* amount of dirty memory is increased, so the kernel
is forced to perform more writeback within the measurement period.

So with two filesystems, you're actually performing more I/O.

You need to either ensure that all I/O is occurring *within the
measurement interval*, or make the test write so much data (wrt
main memory size) that any leftover unwritten stuff is insignificant.

bonnie++ is too complex for this work.  Suggest you use
http://www.zip.com.au/~akpm/linux/write-and-fsync.c
which will just write and fsync a file.  Time how long that
takes.  Or you could experiment with bonnie++'s fsync option.

My suggestion is to work with this workload:

for i in /mnt/1 /mnt/2 /mnt/3 /mnt/4 ...
do
	write-and-fsync $i/foo 4000 &
done

which will write a 4 gig file to each disk.  This will defeat
any caching effects and is just a way simpler workload, which
will allow you to test one thing in isolation.


So anyway.  All this possibly explains the "negative scalability"
in the single-adapter case.  For four adapters with one disk on
each, 120 megs/sec seems reasonable, assuming the sustained
write bandwidth of a single disk is 30 megs/sec.

For four adapters, six disks on each you should be doing better.
Something does appear to be wrong there.

-
