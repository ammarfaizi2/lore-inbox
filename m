Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262348AbSI1XUr>; Sat, 28 Sep 2002 19:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbSI1XUr>; Sat, 28 Sep 2002 19:20:47 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:6087
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S262345AbSI1XUp>; Sat, 28 Sep 2002 19:20:45 -0400
Message-ID: <3D963A73.F593F5F7@splentec.com>
Date: Sat, 28 Sep 2002 19:25:39 -0400
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, Andrew Morton <akpm@digeo.com>,
       Jens Axboe <axboe@suse.de>, Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
References: <200209281552.g8SFqKS04855@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.43.238.247] using ID <tluben@rogers.com> at Sat, 28 Sep 2002 19:25:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> 
> > 5) Proper transaction ordering across a queue full.  The aic7xxx
> >    driver "requeues" all transactions that have not yet been sent
> >    to the device replacing the transaction that experienced the queue
> >    full back at the head so that ordering is maintained.
> 
> I'm lost here.  We currently implement TCQ with simple tags which have no
> guarantee of execution order in the drive I/O scheduler.  Why would we want to
> bother preserving the order of what will become essentially an unordered queue?
> 
> This will become an issue when (or more likely if) journalled fs rely on the
> barrier being implemented down to the medium, and the mid layer does do
> reqeueing in the correct order in that case, except for the tiny race where
> the command following the queue full could be accepted by the device before
> the queue is blocked.

Justin has the right idea.

TCQ goes hand in hand with Task Attributes. I.e. a tagged task
is an I_T_L_Q nexus and has a task attribute (Simple, Ordered, Head
of Queue, ACA; cf. SAM-3, 4.9.1).

Maybe the generator of tags (block layer, user process through sg, etc)
should also set the tag attribute of the task, as per SAM-3.
Most often (as currently implicitly) this would be a Simple task attribute.
Why not the block layer borrow the idea from SAM-3, I see IDE only
coming closer to SCSI...

This way there'd be no need for explicit barriers. They can be implemented
through Ordered and Head of Queue Tasks, everything else is Simple
attribute task (IO scheduler can play with those as it wishes).

This would provide for a more general basis the whole game (IO scheduling,
TCQ, IO barriers, etc).

If the device is not SCSI or it doesn't provide for those (the applicable
bits in the INQ data and mode pages), then those can be succesfully
simulated in the kernel, but at lowest level as I mentioned before.

-- 
Luben
