Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSGXQqS>; Wed, 24 Jul 2002 12:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSGXQqS>; Wed, 24 Jul 2002 12:46:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1020 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317399AbSGXQqR>; Wed, 24 Jul 2002 12:46:17 -0400
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory
	corruptionin2.5.27?]
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Ingo Molnar <mingo@elte.hu>,
       george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0207240927370.15114-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207240927370.15114-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Jul 2002 09:49:20 -0700
Message-Id: <1027529360.3581.1213.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 09:40, Linus Torvalds wrote:

> Just as an example, in the not too distant future what _will_ happen is
> that
> 
> 	spin_lock_irqsave()
> 	..
> 	spin_unlock_irqrestore()
> 
> will not necessarily increment the preemtion count. Why should they?
> They've disabled local interrupts, so there's no preemption to protect
> against. That's just an _obvious_ optimization.

So obvious it is even in my queue :)

I do not think we are ready yet - there is just way too much code that
does not pair up as you mention... but I have played with the patch and
some debugging to see just how feasible it is.  Fairly soon.

Note that other preemptible kernels (IRIX and BeOS, for example) do not
even have a preemption count -- all spinlocks also disable interrupts. 
Not that I am suggesting that, I am very fond of our preempt_count
mechanism, but its a point to consider even if it were feasible (e.g. we
did not have spinlocks held for hundreds of milliseconds).

> We can easily add a debugging check to spin_unlock() that says:
> 
> 	/* Somebody messed up, doesn't hold any other preemption thing
> 	 * than this lock that is now getting released, and has interrupts
> 	 * disabled
> 	 */
> 	BUG_ON(preempt_count() == 1 && interrupts_enabled())
> 
> No?

Pretty similar to the debugging I played with... as long as it goes away
eventually (who wants this in their unlock path?) we certainly should
add it at some point.

	Robert Love


