Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130846AbQLTCHy>; Tue, 19 Dec 2000 21:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130883AbQLTCHo>; Tue, 19 Dec 2000 21:07:44 -0500
Received: from hermes.mixx.net ([212.84.196.2]:17675 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130846AbQLTCH2>;
	Tue, 19 Dec 2000 21:07:28 -0500
Message-ID: <3A400CC0.8F21D000@innominate.de>
Date: Wed, 20 Dec 2000 02:34:56 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Wright <timw@splhi.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
In-Reply-To: <0012171922570J.00623@gimli> <20001218193405.A24041@scutter.internal.splhi.com> <3A3F5E74.3F1988AB@innominate.de> <20001219080759.A24812@scutter.internal.splhi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wright wrote:
> 
> Hi Daniel,
> On Tue, Dec 19, 2000 at 02:11:16PM +0100, Daniel Phillips wrote:
> [...]
> > I'm curious, is my method of avoiding the deadlock race the same as
> > yours?  My solution is to keep a count of tasks that 'intend' to take
> > the down():
> >
> >         atomic_inc(&bdflush_waiters);
> >         up(&bdflush_request);
> >         down(&bdflush_waiter);
> >
> > so that bdflush will issue the correct number of up's even if the waiter
> > has not yet gone to sleep.  IOW, is your approach in DYNIX the same only
> > in spirit, or in detail?
> >
> > --
> > Daniel
> 
> OK,
> this is not how we generally would achieve the goal, although the approach
> looks valid. We have a number of primitives available that are not currently
> used in Linux (unless I'm losing my eyesight :-)
> We use p_sema, and v_sema for down and up respectively (this was done many
> years ago, and the names are in deference to Edsger Dijkstra.
> For normal semaphores (as opposed to read/writer or other variants), we have
> sema_t sema;
> init_sema(&sema, 1);    /* initialize semaphore & set initial count */
> p_sema(&sema, PZERO);   /* "grab" semaphore and set process priority */
>                         /* priority < PZERO == sleep uninterruptibly */
> v_sema(&sema);          /* release semaphore (i.e. increment count) */
> cp_sema(&sema);         /* Attempt to grab semaphore iff free else EBUSY */
> vall_sema(&sema);       /* Wake up all sleepers on this semaphore */
> blocked_sema(&sema);    /* boolean: any sleepers ? */
> p_sema_v_lock(&sema, priority, &lock);  /* atomically release the lock AND */
>                         /* go to sleep on the semaphore */
> 
> Simple spinlock primitives are similar (e.g. p_lock ...), but the last
> primitive above is the key to avoiding many races. The classic coding style
> in DYNIX/ptx (this for buffer allocation) is then:
> 
> dmabuf_init(...);
> {
>         ...
>         init_sema(&dmabuf_wait, 0);
>         init_lock(&dmabuf_mutex);
>         ...
> }
> 
> dmabuf_alloc(...)
> {
>         spl_t saved_spl;
>         ...
>         while (1) {
>                 saved_spl = p_lock(&dmabuf_mutex, SPLSWP);
>                 attempt to grab a free buffer;
>                 if (success){
>                         v_lock(&dmabuf_mutex, saved_spl);
>                         return;
>                 } else {
>                         p_sema_v_lock(&dmabuf_wait, PSWP+1, &dmabuf_mutex);
>                 }
>         }
> }
> 
> dmabuf_free(...)
> {
>         spl_t saved_spl;
>         ...
>         saved_spl = p_lock(&dmabuf_mutex, SPLHI);
>         free up buffer;
>         if (blocked_sema(&dmabuf_wait)) {
>                 vall_sema(&dmabuf_wait);
>         }
>         v_lock(&dmabuf_mutex, s);
> }
> 
> As you can see, the spinlocks ensure no races, and the key is the atomicity
> of p_sema_v_lock(). No-one can race in and sleep on dmabuf_wait, because
> they have to hold dmabuf_mutex to do so. Exactly the same mechanism would
> work for the bdflush problem.

Yes, I see.  There are a lot of similarities to the situation I
described.  The main difference between this situation and bdflush is
that dmabuf_free isn't really waiting on dmabuf_alloc to fullfill a
condition (other than to get out of its exclusion region) while bdflush
can have n waiters.

If I could have a new primitive for this job it would be up_down(sem1,
sem2), atomic with respect to a sleeper on sem1.  And please give me an
up_all for good measure.  Then for a task wanting to wait on bdflush I
could write:

        up_down(&bdflush_request, &bdflush_waiter);

And in bdflush, just:

        up_all(&bdflush_waiter);
        down(&bdflush_request);

But I found I could do the job with existing primitives so I did.

Originally I wrote:

        int waiters = xchg(&bdflush_waiters.count, 0);
        while (waiters--)
                up(&bdflush_waiter);

which uses one less atomic op but, as Philip Rumpf pointed out to me,
doesn't work on Sparc.  Oh well.  On Intel, the extra read is
practically free.  I could have gone at it by making a new primitive:

int atomic_read_and_clear(atomic_t *p)
{
	int n = atomic_read(p);
	atomic_sub(p, n);
	return n;
}

and on arch i86 it would become:

	#define atomic_read_and_clear(p) (xchg(p, 0))

> One can argue the relative merits of the different approaches. I suspect that
> the above code is less bus-intensive relative to the atomic inc/dec/count ops,
> but I may be wrong.

I couldn't say, because your mechanism would need to be elaborated a
little to handle bdflush's multiple waiters, and I don't know exactly
what your up_and_wait would look like.  Do spinlocks work for bdflush,
or would you have to go to semaphores?  (If the latter you arrive at my
up_down primitive, which is interesting.)  It's even hard to say whether
my approach is faster or slower than the existing approach.  Ultimately,
up() calls wake_up() and down() calls both add_wait_queue() and
remove_wait_queue(), so I lose a little there.  I win in the common case
of the non-blocking wakeup, which normally runs through Ben Lahaises's
lovingly handcrafted fast path in up(), whereas the existing code uses
the more involved wake_up_process().  What's clear is, they are all
plenty fast enough for this application, and what I'm really trying for
is readability.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
