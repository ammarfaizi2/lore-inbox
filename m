Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbSI0OUv>; Fri, 27 Sep 2002 10:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbSI0OUv>; Fri, 27 Sep 2002 10:20:51 -0400
Received: from host194.steeleye.com ([66.206.164.34]:41489 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261432AbSI0OUt>; Fri, 27 Sep 2002 10:20:49 -0400
Message-Id: <200209271426.g8REQ3228125@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Jens Axboe <axboe@suse.de>, Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file 
 transfers
In-Reply-To: Message from "Justin T. Gibbs" <gibbs@scsiguy.com> 
   of "Fri, 27 Sep 2002 07:30:55 MDT." <389902704.1033133455@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Sep 2002 10:26:03 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gibbs@scsiguy.com said:
> Now consider the read case.  I maintain that any reasonable drive will
> *always* outperform the OS's transaction reordering/elevator
> algorithms for seek reduction.  This is the whole point of having high
> tag depths. In all I/O studies that have been performed todate, reads
> far outnumber writes *unless* you are creating an ISO image on your
> disk.  In my opinion it is much more important to optimize for the
> more common, concurrent read case, than it is for the sequential write
> case with intermittent reads.  Of course, you can fix the latter case
> too without any change to the driver's queue depth as outlined above.
> Why not have your cake and eat it too? 

But it's not just the drive's elevator that we depend on.  You have to 
transfer the data to the drive as well.  The worst case is SCSI-2 where all 
phases of the transfer except data are narrow and asynchronous.  We get 
abysmal performance in SCSI-2 if the OS gives us 16 contiguous 4k data chunks 
instead of one 64k one because of the high command setup overhead.

Even the protocols which can transfer the header at the same speed, like FC, 
benefit from having large data to header ratios in their frames.

Therefore, it is in SCSI's interest to have the OS merge requests if it can 
purely from the transport efficiency point of view.  Once we accept the 
necessity of having the OS do some elevator work it becomes detrimental to 
have this work repeated in the drive firmware.

I guess, however, that this issue will evaporate substantially once the 
aic7xxx driver uses ordered tags to represent the transaction integrity since 
the barriers will force the drive seek algorithm to follow the tag 
transmission order much more closely.

James


