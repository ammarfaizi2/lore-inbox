Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLSQiu>; Tue, 19 Dec 2000 11:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbQLSQik>; Tue, 19 Dec 2000 11:38:40 -0500
Received: from monza.monza.org ([209.102.105.34]:34566 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129552AbQLSQig>;
	Tue, 19 Dec 2000 11:38:36 -0500
Date: Tue, 19 Dec 2000 08:07:59 -0800
From: Tim Wright <timw@splhi.com>
To: Daniel Phillips <phillips@innominate.de>
Cc: Tim Wright <timw@splhi.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
Message-ID: <20001219080759.A24812@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Daniel Phillips <phillips@innominate.de>,
	Tim Wright <timw@splhi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <0012171922570J.00623@gimli> <20001218193405.A24041@scutter.internal.splhi.com> <3A3F5E74.3F1988AB@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A3F5E74.3F1988AB@innominate.de>; from phillips@innominate.de on Tue, Dec 19, 2000 at 02:11:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,
On Tue, Dec 19, 2000 at 02:11:16PM +0100, Daniel Phillips wrote:
[...]
> I'm curious, is my method of avoiding the deadlock race the same as
> yours?  My solution is to keep a count of tasks that 'intend' to take
> the down():
> 
>         atomic_inc(&bdflush_waiters);
>         up(&bdflush_request);
>         down(&bdflush_waiter);
> 
> so that bdflush will issue the correct number of up's even if the waiter
> has not yet gone to sleep.  IOW, is your approach in DYNIX the same only
> in spirit, or in detail?
> 
> --
> Daniel

OK,
this is not how we generally would achieve the goal, although the approach
looks valid. We have a number of primitives available that are not currently
used in Linux (unless I'm losing my eyesight :-)
We use p_sema, and v_sema for down and up respectively (this was done many
years ago, and the names are in deference to Edsger Dijkstra.
For normal semaphores (as opposed to read/writer or other variants), we have
sema_t sema;
init_sema(&sema, 1);	/* initialize semaphore & set initial count */
p_sema(&sema, PZERO);	/* "grab" semaphore and set process priority */
			/* priority < PZERO == sleep uninterruptibly */
v_sema(&sema);		/* release semaphore (i.e. increment count) */
cp_sema(&sema);		/* Attempt to grab semaphore iff free else EBUSY */
vall_sema(&sema);	/* Wake up all sleepers on this semaphore */
blocked_sema(&sema);	/* boolean: any sleepers ? */
p_sema_v_lock(&sema, priority, &lock);	/* atomically release the lock AND */
			/* go to sleep on the semaphore */

Simple spinlock primitives are similar (e.g. p_lock ...), but the last
primitive above is the key to avoiding many races. The classic coding style
in DYNIX/ptx (this for buffer allocation) is then:

dmabuf_init(...);
{
	...
	init_sema(&dmabuf_wait, 0);
	init_lock(&dmabuf_mutex);
	...
}

dmabuf_alloc(...)
{
	spl_t saved_spl;
	...
	while (1) {
		saved_spl = p_lock(&dmabuf_mutex, SPLSWP);
		attempt to grab a free buffer;
		if (success){
			v_lock(&dmabuf_mutex, saved_spl);
			return;
		} else {
			p_sema_v_lock(&dmabuf_wait, PSWP+1, &dmabuf_mutex);
		}
	}
}

dmabuf_free(...)
{
	spl_t saved_spl;
	...
	saved_spl = p_lock(&dmabuf_mutex, SPLHI);
	free up buffer;
        if (blocked_sema(&dmabuf_wait)) {
                vall_sema(&dmabuf_wait);
        }
        v_lock(&dmabuf_mutex, s);                                               
}

As you can see, the spinlocks ensure no races, and the key is the atomicity
of p_sema_v_lock(). No-one can race in and sleep on dmabuf_wait, because
they have to hold dmabuf_mutex to do so. Exactly the same mechanism would
work for the bdflush problem.

One can argue the relative merits of the different approaches. I suspect that
the above code is less bus-intensive relative to the atomic inc/dec/count ops,
but I may be wrong.

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
