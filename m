Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbSI0SwS>; Fri, 27 Sep 2002 14:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbSI0SwS>; Fri, 27 Sep 2002 14:52:18 -0400
Received: from magic.adaptec.com ([208.236.45.80]:39338 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262587AbSI0SwP>; Fri, 27 Sep 2002 14:52:15 -0400
Date: Fri, 27 Sep 2002 12:56:59 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Jens Axboe <axboe@suse.de>, Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing
 file  transfers
Message-ID: <2543856224.1033153019@aslan.btc.adaptec.com>
In-Reply-To: <200209271721.g8RHLTn05231@localhost.localdomain>
References: <200209271721.g8RHLTn05231@localhost.localdomain>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, lets assume the simplest setup possible: select + tag msg + 10 byte 
> command + disconnect + reselect + status; that's 17 bytes async.  The
> maximum  bus speed async narrow is about 4Mb/s, so those 17 bytes take
> around 4us to  transmit.  On a wide Ultra2 bus, the data rate is about
> 80Mb/s so it takes  50us to transmit 4k or 800us to transmit 64k.
> However, the major killer in  this model is going to be disconnection
> delay at around 200us (dwarfing  arbitration delay, bus settle time etc).
> For 4k packets you spend about 3  times longer arbitrating for the bus
> than you do transmitting data.  For 64k  packets it's 25% of your data
> transmit time in arbitration.  Your theoretical  throughput for 4k
> packets is thus 20Mb/s.  In my book that's a significant  loss on an
> 80Mb/s bus.

This only matters if your benchmark is dependent on round-trip latency
(no read-ahead or write behind and no command overlap) or if you have
saturated the bus.  None of these are the case with the single drive
I/O benchmarks that have been talked about in this thread.  I suppose
I should have been more specific in saying, "the command overhead is
not a factor in the issues raised by this thread".  Now if you want
to use command overhead as a reason to use tagged queuing to mitigate
that overhead, by all means, go right ahead.

>> Hooks for sending ordered tags have been in the aic7xxx driver, at
>> least in FreeBSD's version, since '97.  As soon as the Linux cmd
>> blocks have such information it will be trivial to have the aic7xxx
>> driver issue the appropriate tag types.
> 
> They already do in 2.5, see scsi_populate_tag_msg() in scsi.h.  This
> assumes  you're using the generic tag queueing, which the aic7xxx
> doesn't, but you  could easily key the tag type off REQ_BARRIER.

Okay.

>> But this misses the point.  Andrew's original speculation was that
>> writes were "passing reads" once the read was submitted to the drive.
> 
> The speculation is based on the observation that for transactions
> consisting  of multiple writes and small reads, the reads take a long
> time to complete.

I've seen evidence that a series of reads takes a long time to complete,
but nothing that indicates that every read is starved beyond what you
would expect to see if a huge number of writes were issued between each
read.

> That translates to starving a read in favour of a
> bunch of contiguous writes.   I'm sure we've all seen SCSI drives indulge
> in this type of unfair behaviour  (it does make sense to keep servicing
> writes if they're direct follow on's  from the previously serviced ones).

Actually I haven't.  The closest I can come to this is a single read way
off on the far side of the disk starved by a continuous stream or reads
on the other side of the platter.  This behavior was fixed by all major
drive manufacturers that I know of back in 97 or 98.

>> I would like to understand the evidence behind that assertion since
>> all drive's I've worked with automatically give a higher priority to
>> read traffic than writes since writes can be buffered but reads
>> cannot.
> 
> The evidence is here:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103302456113997&w=1

Which unfortunately characterizes only a single symptom without breaking
it down on a transaction by transaction basis.  We need to understand
how many writes were queued by the OS to the drive between each read to
know if the drive is actually allowing writes to pass reads or not.

--
Justin
