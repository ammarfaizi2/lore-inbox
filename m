Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262610AbSI0VYD>; Fri, 27 Sep 2002 17:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbSI0VYD>; Fri, 27 Sep 2002 17:24:03 -0400
Received: from magic.adaptec.com ([208.236.45.80]:40928 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262606AbSI0VYB>; Fri, 27 Sep 2002 17:24:01 -0400
Date: Fri, 27 Sep 2002 15:28:47 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
Message-ID: <2645346224.1033162127@aslan.btc.adaptec.com>
In-Reply-To: <200209272113.g8RLD1420775@localhost.localdomain>
References: <200209272113.g8RLD1420775@localhost.localdomain>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux is perfectly happy just to have you return 1 in queuecommand if the 
> device won't accept the tag.  The can_queue parameter represents the
> maximum  number of outstanding commands the mid-layer will ever send.
> The mid-layer is  happy to re-queue I/O below this limit if it cannot be
> accepted by the drive.   In fact, that's more or less what queue plugging
> is about.
> 
> The only problem occurs if you return 1 from queuecommand with no other 
> outstanding I/O for the device.
> 
> There should be no reason in 2.5 for a driver to have to implement an
> internal  queue.

Did this really get fixed in 2.5?  The internal queuing was completely
broken in 2.4.  Some of the known breakages were:

1) Device returns queue full with no outstanding commands from us
   (usually occurs in multi-initiator environments).

2) No delay after busy status so devices that will continually
   report BUSY if you hammer them with commands never come ready.

3) Queue is restarted as soon as any command completes even if
   you really need to throttle down the number of tags supported
   by the device.

4) No tag throttling.  If tag throttling is in 2.5, does it ever
   increment the tag depth to handle devices that report temporary
   resource shortages (Atlas II and III do this all the time, other
   devices usually do this only in multi-initiator environments).

5) Proper transaction ordering across a queue full.  The aic7xxx
   driver "requeues" all transactions that have not yet been sent
   to the device replacing the transaction that experienced the queue
   full back at the head so that ordering is maintained.

No thought was put into any of these issues in 2.4, so I decided not
to even think about trusting the mid-layer for this functionality.

--
Justin
