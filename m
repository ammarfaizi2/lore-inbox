Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSHFQ7l>; Tue, 6 Aug 2002 12:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSHFQ7l>; Tue, 6 Aug 2002 12:59:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313477AbSHFQ7k>;
	Tue, 6 Aug 2002 12:59:40 -0400
Message-ID: <3D50038B.CF1F572E@zip.com.au>
Date: Tue, 06 Aug 2002 10:12:43 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Bill Davidsen <davidsen@tmr.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19-rc5
References: <3D4F50F7.2DE00276@zip.com.au> <1028642837.2802.59.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> ...
> > If you want good dbench numbers:
> >
> > echo 70 > /proc/sys/vm/dirty_background_ratio
> > echo 75 > /proc/sys/vm/dirty_async_ratio
> > echo 80 > /proc/sys/vm/dirty_sync_ratio
> > echo 30000 > /proc/sys/vm/dirty_expire_centisecs
> 
> That last one looks like the biggest cheat.  Rather than optimizing for
> dbench, is there a set of pessimizing numbers which would optimally turn
> dbench into a semi-useful tool for measuring meaningful IO performance?
> Or is dbench really only useful for stress testing?
> 

We tend to use dbench in two modes nowadays.  One is the "RAM only"
mode, where the run completes before hitting disk at all.  That's
a very useful and repeatable test for CPU efficiency and lock contention.

The other mode is of course when there are enough clients and
enough dirty data for the test to go to disk.  As Rik says, this
tends to be subject to chaotic effects, and it is also extremely
non linear.

Because when the run slows down a little bit, it takes longer, so
more data becomes eligible for time-expiry-based writeback, which
causes more IO, which causes the run to take longer, etc, etc.

Yes, one does tend still to keep one's eye on the "heavy" dbench
throughput, but I suspect that tuning for this workload is a bad
thing overall.  This is because good dbench numbers come from
allowing a large amount of dirty data to float about in memory
(it will never get written out).  But for real workloads which
don't delete their own output 30 seconds later, we want to start
writeback earlier.  To use the disk bandwidth more smoothly
and to decrease memory allocation latency.
