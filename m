Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129896AbRAKU4F>; Thu, 11 Jan 2001 15:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbRAKUzz>; Thu, 11 Jan 2001 15:55:55 -0500
Received: from nrg.org ([216.101.165.106]:26152 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129896AbRAKUzq>;
	Thu, 11 Jan 2001 15:55:46 -0500
Date: Thu, 11 Jan 2001 12:55:35 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: "David S. Miller" <davem@redhat.com>
cc: andrewm@uow.edu.au, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101110519.VAA02784@pizda.ninka.net>
Message-ID: <Pine.LNX.4.05.10101111233241.5936-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, David S. Miller wrote:
> Opinion: Personally, I think the approach in Andrew's patch
> 	 is the way to go.
> 
> 	 Not because it can give the absolute best results.
> 	 But rather, it is because it says "here is where a lot
>          of time is spent".
> 
> 	 This has two huge benefits:
> 	 1) It tells us where possible algorithmic improvements may
> 	    be possible.  In some cases we may be able to improve the
> 	    code to the point where the pre-emption points are no
> 	    longer necessary and can thus be removed.

This is definitely an important goal.  But lock-metering code in a fully
preemptible kernel an also identify spots where algorithmic improvements
are most important.

> 	 2) It affects only code which can burn a lot of cpu without
> 	    scheduling.  Compare this to schemes which make the kernel
> 	    fully pre-emptable, causing _EVERYONE_ to pay the price of
> 	    low-latency.  If we were to later fine algorithmic
> 	    improvements to the high-latency pieces of code, we
>             couldn't then just "undo" support for pre-emption because
> 	    dependencies will have swept across the whole kernel
> 	    already.
> 
>             Pre-emption, by itself, also doesn't help in situations
> 	    where lots of time is spent while holding spinlocks.
> 	    There are several other operating systems which support
> 	    pre-emption where you will find hard coded calls to the
> 	    scheduler in time-consuming code.  Heh, it's almost like,
> 	    "what's the frigging point of pre-emption then if you
> 	    still have to manually check in some spots?"

Spinlocks should not be held for lots of time.  This adversely affects
SMP scalability as well as latency.  That's why MontaVista's kernel
preemption patch uses sleeping mutex locks instead of spinlocks for the
long held locks.  In a fully preemptible kernel that is implemented
correctly, you won't find any hard-coded calls to the scheduler in time
consuming code.  The scheduler should only be called in response to an
interrupt (IO or timeout) when we know that a higher priority process
has been made runnable, or when the running process sleeps (voluntarily
or when it has to wait for something) or exits.  This is the case in
both of the fully preemptible kernels which I've worked on (IRIX and
REAL/IX).

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
