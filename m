Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbUFCQw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUFCQw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUFCQw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:52:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57323 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263162AbUFCQwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:52:53 -0400
Date: Thu, 3 Jun 2004 18:52:50 +0200
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: submit_bh leaves interrupts on upon return
Message-ID: <20040603165250.GO1946@suse.de>
References: <40BE93DC.6040501@drdos.com> <20040603085002.GG28915@suse.de> <40BF8E1F.1060009@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BF8E1F.1060009@drdos.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03 2004, Jeff V. Merkey wrote:
> Jens Axboe wrote:
> 
> >On Wed, Jun 02 2004, Jeff V. Merkey wrote:
> > 
> >
> >>Any reason why submit_bh should turn on interrupts after being called by 
> >>a process with ints off in 2.4.20?  I see it's possible to sleep during 
> >>elevatoring, but why does it need to leave interrupts on if the calling 
> >>state was with ints off.  
> >>   
> >>
> >
> >It's illegal to call it with interrupts off, so... __make_request()
> >doesn't save interrupt state, so you will always leave with interrupts
> >enabled.
> >
> > 
> >
> Jens
> 
> I noticed in the code it does not check for this when make_request is 
> called, so I altered the calling sequence to call with ints on. I don't 
> see much of a performance difference either way, so calling with ints on 
> was easy to instrument. I am posting about 80,000+ buffer heads per 
> second in with what I am doing, so filling out buffer_head structures 
> and submitting them ad hoc was causing some interrupt windows where the 
> chains were getting corrupted. I altered the calling sequence and added 
> atomic counters so I can submit and call with ints on to avoid the 
> corruption. One of the troublesome aspects of the manner in which 
> make_request is implemented in always needing a context of a thread for 
> sleeping to submit asynch I/O limits the ability to gang schedule large 
> disk I/O from the b_end_io callback. Would make performance a lot more 
> spectacular if it worked this way, but I am seeing good enough 
> performance with it left the way it is. 3Ware's 66Mhz ATA adapter in 
> this implementation is reaching almost 400 MB/S throughput on 2.4.20. I 
> have not tried this on 2.6 yet, but will later this month.

Submitting large numbers of buffer_heads from b_end_io is _nasty_, 2.4
io scheduler runtime isn't exactly world champion and you are doing this
at hard irq time. Not a good idea. Definitely not the true path to
performance, unless you don't care about anything else in the system.

At least in 2.6 you have a much faster io scheduler and the additionally
large bio, so you wont spend nearly as much time there if you are
clever. You still need process context, though, that hasn't changed.

-- 
Jens Axboe

