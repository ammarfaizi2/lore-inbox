Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289842AbSBOPQX>; Fri, 15 Feb 2002 10:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289854AbSBOPQT>; Fri, 15 Feb 2002 10:16:19 -0500
Received: from host194.steeleye.com ([216.33.1.194]:12040 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S289842AbSBOPQG>; Fri, 15 Feb 2002 10:16:06 -0500
Message-Id: <200202151515.g1FFFw801733@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support 
In-Reply-To: Message from Jens Axboe <axboe@suse.de> 
   of "Fri, 15 Feb 2002 10:02:24 +0100." <20020215090224.GB2727@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Feb 2002 10:15:58 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James.Bottomley@steeleye.com said:
> A further issue is that you haven't added anything to the error
> recovery code for this.  If error recovery is activated for the device
> at the reset level, all tags will be discarded by the device.  The eh
> will retry the failing command and then the other tagged commands will
> be re-issued from the scsi_bottom_half_handler (assuming the low level
> device driver immediately fails them with DID_RESET) in the order in
> which the low level driver failed them.  Thus you have potentially
> completely messed up the ordering when the commands all get retried.

axboe@suse.de said:
> I already have this fixed locally by just maintaining a fifo list of
> queued commands so we can retry them in the correct order. For 2.5
> there's a busy and free list (so no more scanning for a free command
> either), I would imagine that the easiest for 2.4 is to just maintain
> a busy list in addition to the current array of pending/free commands.

mason@suse.com said:
> I was wondering about this, we would need to change the error handler
> to  fail all the requests after the barrier.  I was hoping the driver
> did this for us ;-) 

Unfortunately, this is going to involve deep hackery inside the error handler. 
 The current initial premise is that it can simply retry the failing command 
by issuing an ABORT to the tag and resending it (which can cause a tag to move 
past your barrier).  In an error situation, it really wouldn't be wise to try 
to abort lots of potentially running tags to preserve the barrier ordering 
(because of the overload placed on a known failing component), so I think the 
error handler has to abandon the concept of aborting commands and move 
straight to device reset.  We then carefully resend the commands in FIFO order.

Additionally, you must handle the case that a device is reset by something 
else (in error handler terms, the cc_ua [check condition/unit attention]).  
Here also, the tags would have to be sent back down in FIFO order as soon as 
the condition is detected.

mason@suse.com said:
> Yes, this could get sticky.  Does anyone know if other OSes have
> already done this? 

Other OSs (well the ones I've heard about: Solaris and HP-UX) try to avoid 
ordered tags, mainly because of the performance impact they have---the drive 
tag service algorithms become inefficient in the presence of ordered tags 
since they're usually optimised for all simple tags.

James


