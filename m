Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSFUT6V>; Fri, 21 Jun 2002 15:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316776AbSFUT6U>; Fri, 21 Jun 2002 15:58:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51980 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316774AbSFUT6T>;
	Fri, 21 Jun 2002 15:58:19 -0400
Message-ID: <3D138502.6A855C75@zip.com.au>
Date: Fri, 21 Jun 2002 12:56:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mgross <mgross@unix-os.sc.intel.com>
CC: "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
References: <01BDB7EEF8D4D3119D95009027AE99951B0E63EA@fmsmsx33.fm.intel.com> <3D12DCB4.872269F6@zip.com.au> <3D13747A.3030804@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mgross wrote:
> 
> ...
> >And please tell us some more details regarding the performance bottleneck.
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
