Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVE1Dyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVE1Dyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 23:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVE1Dyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 23:54:32 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:2208 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261892AbVE1DyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 23:54:09 -0400
Message-ID: <4297EB57.5090902@yahoo.com.au>
Date: Sat, 28 May 2005 13:53:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com>
In-Reply-To: <20050527233645.GA2283@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:

I'm doing a bit of snipping here, coz this is getting too big.

> The typical work being done in dual kernel scenarios involves moving
> "all things needing RT" into the host RT kernel's domain. You use the

I would have thought you'd have a Linux guest, and a hard-RT guest
both running on a nanokernel. But for the purposes of this discussion
it probably isn't a huge difference.

> Think about X11, all of it. Is X11 something you want to run in the
> host kernel's domain ? What is that going to entail ? What do you do

You could probably have some sort of RT graphics drawing facility,
but I think X11 wouldn't be it :P

> That's a bit rough. You're stuck with programming in one domain and
> there's not possibility of directly "getting at" lower level drivers,
> special RT sockets, etc... because all of these subsystems have to
> be retargetted towards the RT host domain. There's a very big API
> program barrier to how you might want to write a common application
> to take advantage of hard RT constraints.
> 

Run RT programs in your RT kernel, and GP programs in your Linux
kernel. The only time one will have to cross into the other domain
is when they want to communicate with one another.


> the resources to make every kernel subsystems hard RT capable. You
> have this idea where you'd like get at SGI's XFS's homogenous object
> storage to stream video data with guaranteed IO rates. This needs to
> be running in an RT domain so that guarantees can be tightly controlled

That may be a complex problem, but it really doesn't get any simpler
when doing it with a single kernel: all those subsystems still have
to be contended with.

But it's getting a little hand-wavy, I think someone would have to
really be at death's door before trusting Linux (even with PREEMPT_RT)
and XFS to give hard RT IO guarantees any time in the next 5 or 10
years.

What I would do, I would write a block driver in the nanokernel, and
write host drivers for both the Linux and the RT kernel. The nanokernel
would give priority to RT kernel requests. Now its up to the RT kernel
to provide guarantees. Job done. (Well OK, that's very handwavy too,
but I think it is a solution that might actually be attainable, unlike
Linux XFS :)).

> Think about making that entire chain of subsystems available under RT
> control in a dual kernel system where you have a thick boundary
> marshalling this access ? You'd have to port much of the kernel into
> that host RT domain to even consider getting any kind of control over
> XFS. That's massive.
> 

Well yeah, the RT kernel is going to have to implement all features
that it needs to provide. I just happen to be of the (naive) opinion
that adding functionality to a hard-RT kernel would be far easier
than adding hard-RT to the Linux kernel.

And not just from the technical "can it be done" sense, but you'll
probably end up fighting the non-RT kernel devs every step of the
way. So even if you had the perfect patchset there, it would probably
take years to merge it all, if ever.

[snip, making the Linux kernel hard-rt]

Yeah it is probably possible given enough time and effort, I grant
you that.

> 
> 
> This is just the kernel. What if you wanted to, say, export a real time
> TCP/IP socket to a userspace RT app ? what's the subsystem call chain
> there ?

If your RT kernel has a TCP/IP stack, then I guess the call chain is
socket(2) ;)

> Say you want to do this within an X11 application talking to
> ALSA devices ? Obviously the dual kernel model is going to break down
> very shortly after the set of requirements are known and submitted.

Well, you would do the RT work in the RT kernel, then communicate
the results to the Linux kernel.

> Single image systems are clearly superior in that regard even with
> the existing lock structure adding indeterminancy via priority
> inheritance.
> 

It isn't clear to me yet. I'm sure you can make your interrupt
latencies look good, as with your scheduling latencies. But when
you talk about doing _real_ work, that will require an order of
magnitude more changes than the PREEMPT_RT patch to make Linux
hard-RT. And everyone will need to know about it, from device
driver writers and CPU arch code up.

> Super hard RT latencies are obivously going to not call into the
> kernel for non-deterministic operations. These are more typical of

But just what is a non-deterministic operation in Linux? It is
hard to know.

Suppose the PREEMPT_RT patch gets merged tomorrow. OK, now what
if *you* needed a realtime TCP/IP socket. Where will you begin?

[...]

>>I'm not sure if you exactly answered my concerns in that thread
>>(or I didn't understand). It would be great if you could help me
>>out a bit here, because I feel I must be missing something here.
> 
> 
> Was this better ? :) I'm blow a lot of development time writing up all
> of these emails this week.
> 

Sorry, not much better... But don't waste too much time on me, and
thanks, I appreciate the time you've given me so far.

I wouldn't consider a non response (or a late response) to mean that
a point has been conceeded, or that I've won any kind of argument :-)

Best,
Nick
Send instant messages to your online friends http://au.messenger.yahoo.com 
