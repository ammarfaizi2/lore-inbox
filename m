Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262538AbSI0RQY>; Fri, 27 Sep 2002 13:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262544AbSI0RQY>; Fri, 27 Sep 2002 13:16:24 -0400
Received: from host194.steeleye.com ([66.206.164.34]:10757 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262538AbSI0RQR>; Fri, 27 Sep 2002 13:16:17 -0400
Message-Id: <200209271721.g8RHLTn05231@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file 
 transfers
In-Reply-To: Message from "Justin T. Gibbs" <gibbs@scsiguy.com> 
   of "Fri, 27 Sep 2002 10:26:47 MDT." <2441376224.1033144007@aslan.btc.adaptec.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Sep 2002 13:21:29 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which part of the OS are you talking about?

I'm not, I'm talking about the pure physical characteristics of the transport 
bus.

> I also do not believe that the command overhead is as significant as
> you suggest.  I've personally seen a non-packetized SCSI bus perform
> over 15K transactions per-second.

Well, lets assume the simplest setup possible: select + tag msg + 10 byte 
command + disconnect + reselect + status; that's 17 bytes async.  The maximum 
bus speed async narrow is about 4Mb/s, so those 17 bytes take around 4us to 
transmit.  On a wide Ultra2 bus, the data rate is about 80Mb/s so it takes 
50us to transmit 4k or 800us to transmit 64k.  However, the major killer in 
this model is going to be disconnection delay at around 200us (dwarfing 
arbitration delay, bus settle time etc).  For 4k packets you spend about 3 
times longer arbitrating for the bus than you do transmitting data.  For 64k 
packets it's 25% of your data transmit time in arbitration.  Your theoretical 
throughput for 4k packets is thus 20Mb/s.  In my book that's a significant 
loss on an 80Mb/s bus.

On Fabric busses, you move to the network model and collision probabilities 
which increase as the packet size goes down.

gibbs@scsiguy.com said:
> Because of read-ahead, the OS should never send 16 4k contiguous reads
> to the I/O layer for the same application.

read ahead is basically a very simplistic form of I/O scheduling.  

> Hooks for sending ordered tags have been in the aic7xxx driver, at
> least in FreeBSD's version, since '97.  As soon as the Linux cmd
> blocks have such information it will be trivial to have the aic7xxx
> driver issue the appropriate tag types.

They already do in 2.5, see scsi_populate_tag_msg() in scsi.h.  This assumes 
you're using the generic tag queueing, which the aic7xxx doesn't, but you 
could easily key the tag type off REQ_BARRIER.

> But this misses the point.  Andrew's original speculation was that
> writes were "passing reads" once the read was submitted to the drive.

The speculation is based on the observation that for transactions consisting 
of multiple writes and small reads, the reads take a long time to complete.  
That translates to starving a read in favour of a bunch of contiguous writes.  
I'm sure we've all seen SCSI drives indulge in this type of unfair behaviour 
(it does make sense to keep servicing writes if they're direct follow on's 
from the previously serviced ones).

> I would like to understand the evidence behind that assertion since
> all drive's I've worked with automatically give a higher priority to
> read traffic than writes since writes can be buffered but reads
> cannot.

The evidence is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103302456113997&w=1

James


