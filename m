Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVLUODz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVLUODz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 09:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVLUODz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 09:03:55 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:32265 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932423AbVLUODy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 09:03:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <17320.35736.89250.390950@gargle.gargle.HOWL>
X-OriginalArrivalTime: 21 Dec 2005 14:03:17.0697 (UTC) FILETIME=[4AF1DB10:01C60637]
Content-class: urn:content-classes:message
Subject: Re: About 4k kernel stack size....
Date: Wed, 21 Dec 2005 09:02:22 -0500
Message-ID: <Pine.LNX.4.61.0512210901340.11568@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: About 4k kernel stack size....
Thread-Index: AcYGN0r7xe9XjJ8aQOGhkMlomhNCqg==
References: <20051218231401.6ded8de2@werewolf.auna.net><43A77205.2040306@rtr.ca><20051220133729.GC6789@stusta.de><170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com><46578.10.10.10.28.1135094132.squirrel@linux1><Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com> <17320.35736.89250.390950@gargle.gargle.HOWL>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Mike Snitzer" <snitzer@gmail.com>, "Adrian Bunk" <bunk@stusta.de>,
       "Mark Lord" <lkml@rtr.ca>, "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>, <nel@vger.kernel.org>,
       <mpm@selenic.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2005, Nikita Danilov wrote:

> linux-os \(Dick Johnson\) writes:
> >
>
> [...]
>
> > See, isn't rule-making fun? This whole 4k stack-
> > thing is really dumb. Other operating systems
> > use paged virtual memory for stacks, except
> > for the interrupt stack. If Linux used paged
> > virtual memory for stacks,
>
> ... then spin-locks couldn't be held across function calls.
>

Sure they can! In ix86 machines the local 'cli' within the
spin-lock code doesn't affect traps and faults, only the
activity of hardware (INTR). With a page-not-present fault,
(read stack-not-present fault) everything necessary to
restart is saved in EFLAGS and EIP pushed onto the existing
stack so that the faulting instruction can be restarted.
In other words, the address of the instruction that caused
the fault (perhaps CALL), is what will be put into EIP
once the fault-handler returns with an IRET. The fault
itself occurs on a completely different stack.

If one were to implement paged stacks, then the page-fault handler
would have to be modified. Currently, the handler reads/writes
swap which, of course, it can't do with the interrupts disabled.

So one would have to use the concept of the 'free list' like
RSX-11 and VAX/VMS did. The "swapper" needs to keep some free
pages resident in memory and evict dirty pages whenever it can
to maintain this free list.

In the case of spin-locks, the 'flags' variable is the only
thing that can be stored in local (stack) data. The lock object
needs to be global so others can access it. The flags variable
will certainly be restored as will all other stack data even
if it was evicted to the disk.

> >                            the pages would not
> > have to be contiguous so dynamic stack allocation
> > would practically never fail. But Linux doesn't
> > use paged virtual memory for stacks. So, there
> > needs to be some rule to control the amount
> > of kernel stack allocated to each task when it
> > executes a system call.
> >
> > This means, in the limit, that there are two
> > possibilities:
> >
> > (1)	Implement paged virtual memory for stack.
>
> As an exercise: subscribe to NT kernel development mailing list, and see
> the fun they have when page-in code trips over paged out kernel text
> page. As a rule, even code cannot pageable without very involving and
> fragile analysis. Not to say about stack.
>

NT is a poor copy of VAX/VMS. The DIGITAL Project Engineer for
VAX/VMS was hired as a consultant by Microsoft to develop it.
If he had copied VAX/VMS, it would have been essentially bug-free
because VMS had been successful for many years. Unfortunately,
copying was illegal, immoral, and fattening. So, you get something
'like' VMS for NT. It has bugs, perhaps more than any other
OS. This does not mean that the proved concepts used by
VMS for about 20 years are not valid. Note that it was the
business model of DIGITAL that killed it, not its technology.

> Nikita.
>

I am not advocating "N"k stacks. I'm just explaining that it
can be done and has been done, so the response that says it
can't is wrong. Further, it may be very possible that the
"dragged-down" feeling that you get on NT and others when
there is a lot of activity might be caused by this paging.
OTH Linux seems to work fine with no such dragged-down
response until, abruptly, it stops working by killing off
the very tasks that you needed to complete!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
