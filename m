Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262594AbSI0VHw>; Fri, 27 Sep 2002 17:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbSI0VHw>; Fri, 27 Sep 2002 17:07:52 -0400
Received: from host194.steeleye.com ([66.206.164.34]:35592 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262594AbSI0VHv>; Fri, 27 Sep 2002 17:07:51 -0400
Message-Id: <200209272113.g8RLD1420775@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Andrew Morton <akpm@digeo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Jens Axboe <axboe@suse.de>, Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
In-Reply-To: Message from "Justin T. Gibbs" <gibbs@scsiguy.com> 
   of "Fri, 27 Sep 2002 13:52:09 MDT." <2580166224.1033156329@aslan.btc.adaptec.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Sep 2002 17:13:01 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since your drive cannot handle 253 tags, when saturated with commands,
> a new command is never submitted to the drive directly.  Instead the
> command waits in the aic7xxx driver's queue until space is available
> on the device.  In FreeBSD, this never happens as tag depth is known
> to, and adjusted by, the mid-layer.  In Linux I must report the queue
> depth without having sufficient load or history with the device to
> know anything about its capabilities so I have no choice but to
> throttle internally should the device support fewer tags than
> initially reported to the OS.  You can determine the actual device
> queue depth from "cat /proc/scsi/aic7xxx/#".  Run a bunch of I/O first
> so that the tag depth gets locked first. 

Linux is perfectly happy just to have you return 1 in queuecommand if the 
device won't accept the tag.  The can_queue parameter represents the maximum 
number of outstanding commands the mid-layer will ever send.  The mid-layer is 
happy to re-queue I/O below this limit if it cannot be accepted by the drive.  
In fact, that's more or less what queue plugging is about.

The only problem occurs if you return 1 from queuecommand with no other 
outstanding I/O for the device.

There should be no reason in 2.5 for a driver to have to implement an internal 
queue.

James


