Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130247AbQLUQ7F>; Thu, 21 Dec 2000 11:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130865AbQLUQ6z>; Thu, 21 Dec 2000 11:58:55 -0500
Received: from monza.monza.org ([209.102.105.34]:1804 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S130247AbQLUQ6m>;
	Thu, 21 Dec 2000 11:58:42 -0500
Date: Thu, 21 Dec 2000 08:28:09 -0800
From: Tim Wright <timw@splhi.com>
To: Daniel Phillips <phillips@innominate.de>
Cc: Tim Wright <timw@splhi.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
Message-ID: <20001221082809.B1469@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Daniel Phillips <phillips@innominate.de>,
	Tim Wright <timw@splhi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <0012171922570J.00623@gimli> <20001218193405.A24041@scutter.internal.splhi.com> <3A3F5E74.3F1988AB@innominate.de> <20001219080759.A24812@scutter.internal.splhi.com> <3A400CC0.8F21D000@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 02:34:56AM +0100, Daniel Phillips wrote:
> 
> Yes, I see.  There are a lot of similarities to the situation I
> described.  The main difference between this situation and bdflush is
> that dmabuf_free isn't really waiting on dmabuf_alloc to fullfill a
> condition (other than to get out of its exclusion region) while bdflush
> can have n waiters.
> 
> If I could have a new primitive for this job it would be up_down(sem1,
> sem2), atomic with respect to a sleeper on sem1.  And please give me an
> up_all for good measure.  Then for a task wanting to wait on bdflush I
> could write:
> 
>         up_down(&bdflush_request, &bdflush_waiter);
> 
> And in bdflush, just:
> 
>         up_all(&bdflush_waiter);
>         down(&bdflush_request);
> 

OK,
I believe that this would look like the following on ptx (omitting all the
obvious stuff :-)

	lock_t bdflush_lock;
	sema_t bdflush_request;
	sema_t bdflush_waiters;
	...
	init_lock(&bdflush_lock);
	init_sema(&bdflush_request, 0);
	init_sema(&bdflush_waiters, 0);
	...

wakeup_bdflush(...)
{
	...
	(void) p_lock(&bdflush_lock, SPLBUF);
	v_sema(&bdflush_request);
	p_sema_v_lock(&bdflush_waiters, PZERO, &bdflush_lock);
}

bdflush(...)
{
	spl_t s;
	...
	s = p_lock(&bdflush_lock, SPLFS);
	vall_sema(&bdflush_waiters);
	v_lock(&bdflush_lock, s);

	if (!flushed || ...
	...
}

Once more, the use of p_sema_v_lock() avoids races.

> 
> > One can argue the relative merits of the different approaches. I suspect that
> > the above code is less bus-intensive relative to the atomic inc/dec/count ops,
> > but I may be wrong.
> 
> I couldn't say, because your mechanism would need to be elaborated a
> little to handle bdflush's multiple waiters, and I don't know exactly
> what your up_and_wait would look like.  Do spinlocks work for bdflush,
> or would you have to go to semaphores?  (If the latter you arrive at my
> up_down primitive, which is interesting.)  It's even hard to say whether
> my approach is faster or slower than the existing approach.  Ultimately,
> up() calls wake_up() and down() calls both add_wait_queue() and
> remove_wait_queue(), so I lose a little there.  I win in the common case
> of the non-blocking wakeup, which normally runs through Ben Lahaises's
> lovingly handcrafted fast path in up(), whereas the existing code uses
> the more involved wake_up_process().  What's clear is, they are all
> plenty fast enough for this application, and what I'm really trying for
> is readability.
> 

The above hopefully elaborates a little. I'm more than happy to give further
details etc. assuming it's not boring everybody to tears :-)
I agree with you that your changes improve the readability significantly.

Regards,
Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
