Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291154AbSBGT1C>; Thu, 7 Feb 2002 14:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291163AbSBGT0w>; Thu, 7 Feb 2002 14:26:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40460 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291154AbSBGT0t>;
	Thu, 7 Feb 2002 14:26:49 -0500
Message-ID: <3C62D49A.4CBB6295@zip.com.au>
Date: Thu, 07 Feb 2002 11:25:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Martin Wirth <Martin.Wirth@dlr.de>, linux-kernel@vger.kernel.org,
        mingo@elte.hu, nigel@nrg.org
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C629F91.2869CB1F@dlr.de>,
		<3C629F91.2869CB1F@dlr.de> <1013107259.10430.29.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Thu, 2002-02-07 at 10:38, Martin Wirth wrote:
> > This is a request for comment on a new locking primitive
> > called a combilock.
> 
> Interesting ...
> 
> The question I raise is, how many locks do we have where we have a
> single resource we lock where in some codepaths the lock is used for
> short duration and in other places the lock is long-duration?

Quite a few.  Significant ones.  pagemap_lru_lock and lru_list_lock
come to mind.

> It would be useful to identify a few locks where this would benefit and
> apply the appropriate combi variant and do some benchmarking.
> 
> Some of the talk I've heard has been toward an adaptive lock.  These are
> locks like Solaris's that can spin or sleep, usually depending on the
> state of the lock's holder.  Another alternative, which I prefer since
> it is much less overhead, is a lock that spins-then-sleeps
> unconditionally.

I dunno.  The spin-a-bit-then-sleep lock has always struck me as
i_dont_know_what_the_fuck_im_doing_lock().  Martin's approach puts
the decision in the hands of the programmer, rather than saying
"Oh gee I goofed" at runtime.

I need to think about all of this some more...
 
> ...
> 
> > To really take any benefit from a preemptible kernel a lot of spin locks
> > will have to be replaced by mutex locks. The combi-lock approach may
> > convince more people who typically fear the higher scheduling pressure
> > of sleeping locks to do so, if they can decide on each instance which
> > approach (spin of sleep) will be taken.
> 
> We shouldn't engage in wholesale changing of spinlocks to semaphores
> without a priority-inheritance mechanism.  And _that_ is the bigger
> issue ...

hmmm.

Let's back off a bit.  What are we trying to achieve here?  What
problem are we trying to solve?  Is it to allow preemptability
inside the infamous long-held locks?   If so then I'd favour
a piecemeal approach to handling each one, rather than magic
bullets.  Now it may be that certain of the locks are best handled
via a new primitive, but that's not obviously true at this time, to me.

-
