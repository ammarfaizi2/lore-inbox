Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbRADW30>; Thu, 4 Jan 2001 17:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRADW3Q>; Thu, 4 Jan 2001 17:29:16 -0500
Received: from nrg.org ([216.101.165.106]:10278 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131061AbRADW3G>;
	Thu, 4 Jan 2001 17:29:06 -0500
Date: Thu, 4 Jan 2001 14:28:58 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Andi Kleen <ak@suse.de>
cc: Daniel Phillips <phillips@innominate.de>,
        ludovic fernandez <ludovic.fernandez@sun.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <20010104230930.A4219@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.05.10101041413050.4778-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Andi Kleen wrote:
> On Thu, Jan 04, 2001 at 01:39:57PM -0800, Nigel Gamble wrote:
> > Experience has shown that adaptive spinlocks are not worth the extra
> > overhead (if you mean the type that spin for a short time
> > and then decide to sleep).  It is better to use spin_lock_irqsave()
> > (which, by definition, disables kernel preemption without the need
> > to set a no-preempt flag) to protect regions where the lock is held
> > for a maximum of around 100us, and to use a sleeping mutex lock for
> > longer regions.  This is what I'm working towards.
> 
> What experience ?  Only real-time latency testing or SMP scalability 
> testing? 

Both.  We spent a lot of time on this when I was at SGI working on IRIX.
I think we ended up with excellent SMP scalability and good real-time
latency.  There is also some academic research that suggests that
the extra overhead of a dynamic adaptive spinlock usually outweighs
any possible gains.

> The case I was thinking about is a heavily contended lock like the
> inode semaphore of a file that is used by several threads on several
> CPUs in parallel or the mm semaphore of a often faulted shared mm. 
> 
> It's not an option to convert them to a spinlock, but often the delays
> are short enough that a short spin could make sense. 

I think the first order performance problem of a heavily contended lock
is not how it is implemented, but the fact that it is heavily contended.
In IRIX we spent a lot of time looking for these bottlenecks and
re-architecting to avoid them.  (This would mean minimizing the shared
accesses in your examples.)

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
