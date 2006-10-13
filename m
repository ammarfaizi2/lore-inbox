Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751991AbWJMXCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbWJMXCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbWJMXCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:02:42 -0400
Received: from web58108.mail.re3.yahoo.com ([68.142.236.131]:31882 "HELO
	web58108.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1751991AbWJMXCl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:02:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QR2VhA+/Ar6jy3hCuDwsEdj9c9uF39864v3OvMGiLvoGJYBNYDo94qVYvFq4rtZai+UeD8tbCDV9uqmecDColsZidZUMw7zujRoexm56RgxYfopKgVKyplITVT7iRBYj0afWENbQuWoTzs1csh62StcAenjT2phFvIXn5tAueIg=  ;
Message-ID: <20061013230240.84447.qmail@web58108.mail.re3.yahoo.com>
Date: Fri, 13 Oct 2006 16:02:40 -0700 (PDT)
From: Open Source <opensource3141@yahoo.com>
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13 (CRITICAL???)
To: Alan Stern <stern@rowland.harvard.edu>
Cc: =?iso-8859-1?Q?WolfgangM=FCes?= <wolfgang@iksw-muees.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Yes, user mode processes are susceptible to other delays,
but that's really not the problem here.  My application is
*clearly* being hit by this difference in CONFIG_HZ.
All the evidence points to this fact.

People often bring this up user mode versus kernel
mode as a criticism when it doesn't really apply.
All I was saying is that we should get away
from the talk of kernel versus user mode and narrow
the problem to something more specific.

As for the issue regarding ehci_work and ehci_irq:
There are many many comments in the code that say
that urb linking happens asynchronously.  It is hard for
me to fully appreciate how everything is put together
because I am not an expert with the host controller code
in the kernel. Is there some way we can get to the bottom of this?

Either the problem is in the ehci code or in devio.c.  In
devio.c the user space process calls an ioctl to reap the
urb (blocking until it is complete).  The asynchronous
callback for the urb is called when the urb is unlinked
and that callback (async_completed in devio.c) signals
the wait object that the ioctl has added to the wait queue.
But, I don't see anything inherently wrong with how things
are setup there.

In any case, something is wrong.  I want to be as helpful
as possible to get to the bottom of this, but it might be tough
to do it without some insight from the gurus who wrote this code.
Even if the problem will be hard to fix, we should have a
clear understanding of what is causing it.  As it stands it doesn't
seem like even the experts know exactly where this
delay is being caused.

Thanks.


----- Original Message ----
From: Alan Stern <stern@rowland.harvard.edu>
To: Open Source <opensource3141@yahoo.com>
Cc: WolfgangMües <wolfgang@iksw-muees.de>; linux-usb-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Sent: Friday, October 13, 2006 2:08:46 PM
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13 (CRITICAL???)

On Fri, 13 Oct 2006, Open Source wrote:

> Hi Wolfgang (and all),
> 
> Thanks for the input.  However, I am not understanding
> exactly why kernel mode is treated any differently than
> user mode for this sort of thing.  I am looking at the code
> in ehci-q.c and ehci-hcd.c.
> 
> It seems like the unlinking of completed URBs
> happens asynchronously on a timer.  This is a
> surprise to me since I thought this was happening
> on an IRQ from the host controller.  But if what I'm
> surmising is correct it would explain everything
> I am seeing.  I'm not able to ascertain how
> user mode drivers are treated differently than
> kernel mode drivers in this regard.  From what I
> can tell, all drivers would be broken equally!
> Can anyone who has more experience
> with this code confirm this for me?

I don't think so.  You must be mis-reading the code.  The only timers used 
in ehci-hcd are a couple of watchdogs; they shouldn't affect the normal 
URB completions which occur within ehci_work(), called by ehci_irq().

What Wolfgang meant was that user processes are subject to unpredictable 
delays from all kinds of sources.

Alan Stern






