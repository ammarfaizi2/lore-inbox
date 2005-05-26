Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVEZULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVEZULd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVEZULd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:11:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43508 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S261568AbVEZULV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:11:21 -0400
Subject: Re: RT patch acceptance
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, bhuey@lnxw.com,
       nickpiggin@yahoo.com.au, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050526193230.GY86087@muc.de>
References: <20050525001019.GA18048@nietzsche.lynx.com>
	 <1116981913.19926.58.camel@dhcp153.mvista.com>
	 <20050525005942.GA24893@nietzsche.lynx.com>
	 <1116982977.19926.63.camel@dhcp153.mvista.com>
	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>
	 <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>
Content-Type: text/plain
Date: Thu, 26 May 2005 13:11:09 -0700
Message-Id: <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 21:32 +0200, Andi Kleen wrote:
> > 
> > > I have no reason to believe this is any different with all
> > > this RT testing. 
> > > 
> > 
> > And that's why we have been testing and benchmarking, to
> > produce number sets that supersede faith, belief, and 
> > conjecture. But ultimately, you can trust your senses,
> > and I think the audio / video test would allow your eyes 
> > to see, and your ears to hear the difference.
> 
> I understand that you have some real improvements that are measurable.
> What I objected to was the claim that it actually made any difference
> to interactive users.
> 

Yes, the observation is subjective. 

I have been experiencing it since we got our first prototype up and
running, back in July or August last year. 

In addition, I have received unsolicited comments in this regard, from
just about everyone who has run the RT kernel on a desktop. And I have
heard others echo similar observations, on this list and elsewhere.

But yes, it is subjective without a placebo control group... 

The fact about the RT implementation is, that it eliminates ALL high
latencies, so you will never have the aggregate transient bursts, that
make your music skip, or make your mouse freeze on the screen, even for
just an instant.

These transients will occur on a desktop kernel, and no matter how
infrequent, once is too many for some class of applications. 

Since these transient events do occur, and folks may have learned to
ignore them, the *complete absence* of these transients IS absolutely
noticed by anyone who has worked with the non-preemptable and the
current preemptable kernels.

And I think that is what we are talking about. The feeling that the
desktop experience is smoother because the responsiveness of the
system interleaves mouse IRQs with the consequent task-based updates on
the screen. What is not noticable, is the additional latency in
processing the mouse interrupt in a thread.

I think the music example is most relevant. Think of a guy on stage
blaming his computer for a malfunctioning, noisy, guitar effect.

Or a frame glitch in an animation, or video game.

> > 
> > > -Andi (who also would prefer to not have interrupt threads, locks like
> > > a maze and related horribilities in the mainline kernel) 
> > 
> > I am definitely for breaking out an IRQ threads patch,
> > separate from the RT-mutex patches, even if just to
> > allow examination of that code without the clutter.
> 

Here, I am talking about separating out the patch, and applying it
first, not dropping it from the RT implementation. 

> What I dislike with RT mutexes is that they convert all locks.
> It doesnt make much sense to me to have a complex lock that
> only protects a few lines of code (and a lot of the spinlock
> code is like this). That is just a waste of cycles.
> 

It is NOT just a few lines of code. Millisecond latencies on high-
powered CPU systems means more code than is probably required to send a
rocket 'round the moon and back.

In addition, there are lock-ordering and lock-nesting issues (not to be
confused with the Scottish sea creature :) that make this approach non-
trivial whatsoever.

> But I always though we should have a new lock type that is between
> spinlocks and semaphores and is less heavyweight than a semaphore
> (which tends to be quite slow due to its many context switches). Something
> like a spinaphore, although it probably doesnt need full semaphore
> semantics (rarely any code in the kernel uses that anyways). It could
> spin for a short time and then sleep. Then convert some selected
> locks over. e.g. the mm_sem and the i_sem would be primary users of this.
> And maybe some of the heavier spinlocks.

This is a bottom up approach, that simply doesn't work. I spent months
considering this same scenario, so did a lot of other folks. This type
of hybrid solution would blow the complexity and patch size through the
roof, and render it unmaintainable. It is precisely why we introduced
the concept to LKML in the first place. Review the archives for a week
or two, after my RT post on October 9.

> 
> If you drop irq threads then you cannot convert all locks
> anymore or have to add ugly in_interrupt()checks. So any conversion like
> that requires converting locks.
> 
 
You will find a very good explanation of the dependencies in my original
post on October 9. Also, please see my comment above, under "allow
examination of that code without the clutter."

Sven
 

