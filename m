Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbSI3I32>; Mon, 30 Sep 2002 04:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbSI3I32>; Mon, 30 Sep 2002 04:29:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25763 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261965AbSI3I31>;
	Mon, 30 Sep 2002 04:29:27 -0400
Date: Mon, 30 Sep 2002 10:34:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Luben Tuikov <luben@splentec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, Andrew Morton <akpm@digeo.com>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doingfiletransfers
Message-ID: <20020930083409.GI27420@suse.de>
References: <200209281552.g8SFqKS04855@localhost.localdomain> <3D963A73.F593F5F7@splentec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D963A73.F593F5F7@splentec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28 2002, Luben Tuikov wrote:
> James Bottomley wrote:
> > 
> > > 5) Proper transaction ordering across a queue full.  The aic7xxx
> > >    driver "requeues" all transactions that have not yet been sent
> > >    to the device replacing the transaction that experienced the queue
> > >    full back at the head so that ordering is maintained.
> > 
> > I'm lost here.  We currently implement TCQ with simple tags which have no
> > guarantee of execution order in the drive I/O scheduler.  Why would we want to
> > bother preserving the order of what will become essentially an unordered queue?
> > 
> > This will become an issue when (or more likely if) journalled fs rely on the
> > barrier being implemented down to the medium, and the mid layer does do
> > reqeueing in the correct order in that case, except for the tiny race where
> > the command following the queue full could be accepted by the device before
> > the queue is blocked.
> 
> Justin has the right idea.
> 
> TCQ goes hand in hand with Task Attributes. I.e. a tagged task
> is an I_T_L_Q nexus and has a task attribute (Simple, Ordered, Head
> of Queue, ACA; cf. SAM-3, 4.9.1).
> 
> Maybe the generator of tags (block layer, user process through sg, etc)
> should also set the tag attribute of the task, as per SAM-3.
> Most often (as currently implicitly) this would be a Simple task attribute.
> Why not the block layer borrow the idea from SAM-3, I see IDE only
> coming closer to SCSI...

Block layer being the tag generator (and manager), yes I 100% agree that
if we extend the support of block level tagging slightly it is very
possible to simply generate the type of tag required (as already replied
to Patrick, REQ_BARRIER would be an ordered task attribut, etc).

Currently IDE tcq has no notion of tag options, unfortunately.

> This way there'd be no need for explicit barriers. They can be implemented
> through Ordered and Head of Queue Tasks, everything else is Simple
> attribute task (IO scheduler can play with those as it wishes).
> 
> This would provide for a more general basis the whole game (IO scheduling,
> TCQ, IO barriers, etc).

Agree

-- 
Jens Axboe

