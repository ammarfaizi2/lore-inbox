Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314600AbSEPIxN>; Thu, 16 May 2002 04:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSEPIxM>; Thu, 16 May 2002 04:53:12 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:54543 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S314600AbSEPIxL>;
	Thu, 16 May 2002 04:53:11 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205160833.JAA24899@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver
To: ptb@it.uc3m.es
Date: Thu, 16 May 2002 09:33:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com, kumbera@yahoo.com,
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <200205152143.g4FLhLs17344@oboe.it.uc3m.es> from "Peter T. Breuer" at May 15, 2002 11:43:21 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> (Addresses got munged locally, but as I'm postmaster, I get the mail
> after 26 bounces, so no hassle ...)
> 
Ok. I was wodering after the bounce message that I got :-)

> Let's see if I follow ...
> 
> > thanks for the info. I'm starting to form some ideas of what the problem
> > with nbd might be. Here is my initial idea of what might be going on:
> > 
> >  1. Something happens which starts lots of I/O (e.g. the ext3/xfs journal
> >     flush that Xiangping says usually triggers the problem)
> 
> Is this any kind of i/o? Such as swapping? You mean something which
> takes the i/o lock, or which generally exercises the i/o system .. And
> are there any particular characteristics to the "a lot" that you have
> in mind, such as maybe running us out of requests on that device (no), or 
> running us low on available free buffers (yes?).
> 
Probably swapping would trigger it too, though thats the "difficult" case
so I've been ignoring that one up till now :-)

> >  2. One of the threads doing the writes blocks running the device I/O
> 
> If a thread blocks running its own device i/o queue, that would be 
> a fatal error for most of the kernel. The i/o lock is held. And -
> correct me on this - interrupts are disabled?
> 
> So I assume you are talking about "a bug in something, somewhere".
> 
No. The kernel nbd drops the io request lock before it does anything
which might block, so its ok from that point of view. I suspect that
we'll find that its not a bug in one particular bit of code but two
subsystems which are making assumptions about how the other works, which
whilst being perfectly reasonable on their own conflict in a way which
causes the deadlock we see.

[snip]
> 
> >     only need to have each memory zones free pages just below pages_min
> >     at the right time to trigger this.
> 
> I don't understand the specific allusion, but I gather you are talking
> about low free pages. Yes, being run out of memory matches the reports.
> Particularly the people who are swapping over nbd under memory pressure
> are in that situation.
> 
> So - is that situation handled differently in the old VM?
> 
I'm not enough of an expert on the changes that have gone on to answer
that one, the VM isn't really my area of the kernel.

I think I've answered the other points that you make in my other reply
which I sent a few moments ago, let me know if I missed something.

It would be nice to have a per device "max dirty pages" limit. Also useful 
would be a per queue priority so that if the max dirty pages limit is reached 
for that device, then the driver gets higher priority on memory allocations 
until the number of dirty pages has dropped below an acceptable level. I
don't know how easy or desireable it would be to implement such a scheme
generally though.

Steve.
