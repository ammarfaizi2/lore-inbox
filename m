Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVE1Fkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVE1Fkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 01:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVE1Fkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 01:40:43 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:61195 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261955AbVE1FkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 01:40:18 -0400
Date: Fri, 27 May 2005 22:45:03 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050528054503.GA2958@nietzsche.lynx.com>
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4297EB57.5090902@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 01:53:59PM +1000, Nick Piggin wrote:
> Bill Huey (hui) wrote:
> 
> Run RT programs in your RT kernel, and GP programs in your Linux
> kernel. The only time one will have to cross into the other domain
> is when they want to communicate with one another.

OpenGL must be RT aware for the off screen buffer to be flipped. This
model isn't practical. With locking changes in X using something like
xcb in xlib, you might be able to achieve these goals. SGI IRIX is
enable to do things like this.

Please try to understand the app issues here, because you seem to have
a naive understanding of this.  [evil jab :)]

> That may be a complex problem, but it really doesn't get any simpler
> when doing it with a single kernel: all those subsystems still have
> to be contended with.
> 
> But it's getting a little hand-wavy, I think someone would have to
> really be at death's door before trusting Linux (even with PREEMPT_RT)
> and XFS to give hard RT IO guarantees any time in the next 5 or 10
> years.

True, but XFS was designed to deal with this in the first place. It's
not that remote a thing and if you have a nice SMP friendly system so
it's possible to restore that IRIX functionality in Linux.

> What I would do, I would write a block driver in the nanokernel, and
> write host drivers for both the Linux and the RT kernel. The nanokernel
> would give priority to RT kernel requests. Now its up to the RT kernel
> to provide guarantees. Job done. (Well OK, that's very handwavy too,
> but I think it is a solution that might actually be attainable, unlike
> Linux XFS :)).

There's a lot of unknowns here, but XFS is under utilized in Linux.
I can't really imagine how a RT host kernel could really respect
something as complicated as XFS with all of it's tree balancing stuff
and low level IO submissions with concurrent reads/writes. The nanokernel
adapation doesn't fly once you think about how complex that chain is.
The RT patch is priming that path to happen already and I would like to
see this used more.
 
> Well yeah, the RT kernel is going to have to implement all features
> that it needs to provide. I just happen to be of the (naive) opinion
> that adding functionality to a hard-RT kernel would be far easier
> than adding hard-RT to the Linux kernel.

The problem with that assertion is that it's pretty close to being
hard RT as is. It's not that "mysterious" and the results are very
solid. Try not to think about this in a piecewise manner, but how
an overall picture of things get used and what needs to happen to
get there as well as all of the work done so far.

> And not just from the technical "can it be done" sense, but you'll
> probably end up fighting the non-RT kernel devs every step of the
> way. So even if you had the perfect patchset there, it would probably
> take years to merge it all, if ever.

They don't understand the patch nor the problem space, so I ignore
them since they'll never push any edge that interesting. And Ingo's
comment about the RT patch riding on SMP locking as is should not
be something that's forgotten.

> [snip, making the Linux kernel hard-rt]
> 
> Yeah it is probably possible given enough time and effort, I grant
> you that.

It's pretty close dude. You have to be in some kind of denial or
something like that because multipule folks have stated this already.
What's left are problems with FS code, ext3, and the like that still
have remaining atomic critical sections.

> If your RT kernel has a TCP/IP stack, then I guess the call chain is
> socket(2) ;)
> 
> >Say you want to do this within an X11 application talking to
> >ALSA devices ? Obviously the dual kernel model is going to break down
> >very shortly after the set of requirements are known and submitted.
> 
> Well, you would do the RT work in the RT kernel, then communicate
> the results to the Linux kernel.

Write a mini-app and see how this methodology is going to work in
this system. Both Ingo and me have already pointed out that folks
already doing general purpose apps need a simple model to work with
since they need to cross many kernel systems as well as app layers.

Stop thinking in terms of a kernel programmer stuck in 1995, but
something a bit more "large picture" in nature.

> It isn't clear to me yet. I'm sure you can make your interrupt
> latencies look good, as with your scheduling latencies. But when

My project was getting a solid spike at 4 usec for irq-thread
startups and Ingo's stuff is better. It's already there.

> you talk about doing _real_ work, that will require an order of
> magnitude more changes than the PREEMPT_RT patch to make Linux
> hard-RT. And everyone will need to know about it, from device
> driver writers and CPU arch code up.

Uh, not really. Have you looked at the patch or are you inserting
hysteria in the discussion again ? :) Sounds like hysteria.

Ingo is probably going to follow up on this so I'll let him deal
with you. I suggest you read about the latency traces being worked
on a few months ago.

> >Super hard RT latencies are obivously going to not call into the
> >kernel for non-deterministic operations. These are more typical of
> 
> But just what is a non-deterministic operation in Linux? It is
> hard to know.

Pretty much any call other an things related to futex handling. That
doesn't invalidate my point since I wasn't making a broad claim in
first place.

> Suppose the PREEMPT_RT patch gets merged tomorrow. OK, now what
> if *you* needed a realtime TCP/IP socket. Where will you begin?

Start with the DragonFly BSD sources and talk to Jeffery Hsu about
his alt-q implementation. Their stack was parallelize recently and
can express this kind stuff with possible a special scheduler in
their preexisting token locking scheme. I'm not talking hard RT
here for RT enabled IO. Obvious this is going to be problematic
to a certain degree in a kernel and will have to be move more into
the realm of soft RT with high performance.
 
> Sorry, not much better... But don't waste too much time on me, and
> thanks, I appreciate the time you've given me so far.

Read the patch and follow the development. That's all I can say.
 
> I wouldn't consider a non response (or a late response) to mean that
> a point has been conceeded, or that I've won any kind of argument :-)

Well, you're wrong. :)

Well, uh, ummm, start writing RT media apps and you will know what
I'm talking about. Dual kernel stuff isn't going to fly with those
folks especially with an RT patch as good as this already in the
general kernel. More experience with this kind of programming makes
it clear where the failures are with a dual kernel approach.

bill

