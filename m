Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268534AbUJPBsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268534AbUJPBsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 21:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUJPBsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 21:48:30 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:3393 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S268534AbUJPBs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 21:48:27 -0400
Date: Fri, 15 Oct 2004 19:46:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Tasklet usage?
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <004b01c4b321$f9d75cf0$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=response; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.dvqma04.n40gos@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently made a similar change for what sounds like a similar piece of 
hardware (though in our case it was filling a FIFO for output purposes, 
which cannot be allowed to run empty, when we receive a FIFO-almost-empty 
interrupt from the device).

The tasklet will not necessarily get run immediately, as other tasklets may 
be pending on that CPU. You should be able to reduce the likelihood of this 
happening by using tasklet_hi_schedule instead of tasklet_schedule, that 
should put it ahead of any network, SCSI, etc. tasklets that may be pending.

Tasklets can only get interrupted by hard interrupts (which as someone 
mentioned, is pretty much the point of them).

As far as rescheduling the tasklet, I believe if the tasklet hasn't started, 
it will only execute once regardless of how many times you call 
tasklet_schedule. If it has already started running, and the tasklet gets 
scheduled, it will run again once it finishes.

Locking-wise, for any critical regions shared between the hard IRQ handler 
and either the tasklet or user context, spin_lock_irqsave is what you need. 
However, critical regions shared only between user context and the tasklet 
can use spin_lock_bh instead (which disables only bottom-halves and 
tasklets, not interrupts).


----- Original Message ----- 
From: "Pierre Ossman" <drzeus-list@drzeus.cx>
Newsgroups: fa.linux.kernel
To: "LKML" <linux-kernel@vger.kernel.org>
Sent: Friday, October 15, 2004 7:15 AM
Subject: Tasklet usage?


> My driver needs to spend a lot of time inside the interrupt handler 
> (draining a FIFO). I suspect this might cause problems blocking other 
> interrupt handlers so I was thinking about moving this into a tasklet.
> Not being to familiar with tasklets, a few questions pop up.
>
> * Will a tasklet scheduled from the interrupt handler be executed as soon 
> as interrupt handling is done?
> * Can tasklets be preempted?
> * If a tasklet gets scheduled while running, will it be executed once 
> more? (Needed if I get another FIFO interrupt while the tasklet is just 
> exiting).
>
> The FIFO is a bit small so time is of the essence. That's why this routine 
> is in the interrupt handler to begin with.
>
> Rgds
> Pierre Ossman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

