Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262532AbSI0TbO>; Fri, 27 Sep 2002 15:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbSI0TbO>; Fri, 27 Sep 2002 15:31:14 -0400
Received: from packet.digeo.com ([12.110.80.53]:25222 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261726AbSI0TbM>;
	Fri, 27 Sep 2002 15:31:12 -0400
Message-ID: <3D94B33F.EB3B9D41@digeo.com>
Date: Fri, 27 Sep 2002 12:36:31 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
References: <3D94AC8B.4AB6EB09@digeo.com> <2561606224.1033154176@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2002 19:36:24.0924 (UTC) FILETIME=[2A67E9C0:01C2665D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> >> Which unfortunately characterizes only a single symptom without breaking
> >> it down on a transaction by transaction basis.  We need to understand
> >> how many writes were queued by the OS to the drive between each read to
> >> know if the drive is actually allowing writes to pass reads or not.
> >>
> >
> > Given that I measured a two-second read latency with four tags,
> > that would be about 60 megabytes of write traffic after the
> > read was submitted.  Say, 120 requests.  That's with a tag
> > depth of four.
> 
> I still don't follow your reasoning.  Your benchmark indicates the
> latency for several reads (cat kernel/*.c), not the per-read latency.
> The two are quite different and unless you know the per-read latency and
> whether it was affected by filling the drive's entire cache with
> pent up writes (again these are writes that are above and beyond
> those still assigned tags) you are still speculating that writes
> are passing reads.
> 
> If you can tell me exactly how you ran your benchmark, I'll find the
> information I want by using a SCSI bus analyzer to sniff the traffic
> on the bus.

I did it by tracing.  4 meg printk buffer, teach printk to timestamp
its output, add tracing printk's, then stare at the output.

The patches are at

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.38/2.5.38-mm1/experimental/printk-big-buf.patch
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.38/2.5.38-mm1/experimental/elevator-debug.patch

One sample trace is at
http://www.zip.com.au/~akpm/linux/patches/trace.txt

Watch the read of sector 528598.  It was inserted into the
elevator at 24989.185 seconds, was taken off the elevator by
the driver at 24989.186 seconds and was completed in bio_endio()
at 24992.273 seconds.  That trace was taken with 253 tags.  I
don't have a 4-tag trace handy but it was much the same, with
a two-second lag.

I am assuming that the driver submits the request to the disk
shortly after calling elv_next_request().  If I'm wrong, and
the driver itself is hanging onto the request for a significant
amount of time then the disk is not the source of the delay.
