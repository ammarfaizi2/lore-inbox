Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbUK0ERu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbUK0ERu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbUK0EMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:12:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:35521 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262271AbUKZTQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:16:53 -0500
Date: Fri, 26 Nov 2004 17:06:49 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, drepper@redhat.com
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20041126170649.GA8188@mail.shareable.org>
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117084703.GL10340@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've looked at the problem of lost-wakeups problem with NPTL condition
variables and 2.6 futex, with the help of Jakub's finely presented
pseudo-code.  Unless I've made a mistake, it is fixable in userspace.

[ It might be more efficient to fix it in kernel space - on the other
  hand, doing so might also make kernel futexes slower.  In general, I
  prefer if the kernel futex semantics can be as "loose" as possible
  to minimise the locking they are absolutely required to do.  Who
  knows, we might come up with an algorithm that uses even less
  cross-CPU traffic in the kernel, if the semantics permit it.
  However, I appreciate that a more "atomic" kernel semantic is easier
  to understand, and it is possible to implement that if it is really
  worth doing.  I would like to see benchmarks proving it doesn't slow
  down normal futex stress tests though.  It might not be slower at all. ]

Ok.  Userspace solutions first.

Logically, waiters have four states: Awake, About to sleep, Sleeping
and Drowsy.  These don't correspond to places in the code; they are
just logical states for the purpose of reasoning.

Waiters go to sleep through a sequence, from Awake to About to sleep,
then to Sleeping.  This is prompted by the call to pthread_condvar_wait.

Waking up is prompted by passing around WAKE tokens.

The combined operation "futex++" followed by FUTEX_WAKE is always done
as an ordered sequence, which we'll call offering a WAKE token.

That operation offers a WAKE token to all waiters, and if there exists
any single waiter in a state that will consume the token, that waiter
consumes the token and transitions immediately to Awake.

The waker offering a WAKE token knows if a waiter accepts the token
that it offers.  A waiter knows if it accepts a token.  Tokens are
conserved exactly (like energy and momentum).  This is important.

In the Sleeping state, waiters are woken by consuming a WAKE token, as
soon as one becomes available.

In the About to sleep state, two transitions are possible.  If time
passes with no WAKE tokens, they become Sleeping.  If a WAKE token is
offered, they do not consume it, but they transition to a state called
Drowsy instead.

In the Drowsy state, time can pass and it will transition to Awake.
However, it can also accept a WAKE token in that state.  This is
optional: if a token is offered, it might not accept it.  This is
different from Sleeping, where if a token is offered it will
definitely accepted it.

These are all the transitions of a waiter:

     Awake -> About to sleep    [Called pthread_condvar_wait]

     About to sleep -> Sleeping [Time passes]
     About to sleep -> Drowsy   [Tickled by WAKE token but did not accept it]

     Sleeping -> Awake          [Accept one WAKE token - guaranteed to accept]

     Drowsy -> Awake            [Time passes]
     Drowsy -> Awake            [Accept one WAKE token - may refuse]



             +--------------+  time passes  +----------+
             |About to sleep| ------------> | Sleeping |
             +--------------+               +----------+
                    |                            |
       tickled by   |                            |
      token but did |                            | WAKE token
      not accept it |                            | (guaranteed to accept)
                    V         time passes        V
              +----------+  --------------> +---------+
              |  Drowsy  |                  |  Awake  |
              +----------+  --------------> +---------+
                              WAKE token
                              (may refuse)


The states actually correspond to the following real events.  The
condvar private mutex ensures that reading the futex value occurs
before it is incremented:

      About to sleep == starting from mutex release by the waiter, until
                        whichever comes first from FUTEX_WAKE and queue_me

      Sleeping       == if FUTEX_WAKE comes after queue_me, this state
                        begins at queue_me

      Drowsy         == if FUTEX_WAKE comes before queue_me, the FUTEX_WAKE
                        event is called "tickled by token" and this is the
                        moment when Drowsy begins

      Awake          == if FUTEX_WAKE comes before queue_me, Awake begins
                        at unqueue_me or a subsequent FUTEX_WAKE, whichever
                        comes first (these are the two transitions from
                        Drowsy).

                        if FUTEX_WAKE comes after queue_me, Awake begins
                        at the moment of FUTEX_WAKE (this is the transition
                        from Sleeping)


On Mon, Nov 15, 2004 at 01:22:18PM +0000, Jamie Lokier wrote:
>   2. Future lost wakeups.
>
>      Future calls to pthread_cond_signal(cond) fail to wake wait_B,
>      even much later, because cond's NPTL data structure is
>      inconsistent.  It's invariant is broken.
>
>      This is a bug in NPTL and it's easy to fix.  Never increment wake
>      unconditionally.  Instead, increment it conditionally when (a)
>      FUTEX_WAKE returns 1, and also (b) when FUTEX_WAIT returns -EAGAIN.

This is easy to solve.

The key invariant which breaks is that (total_seq - wakeup_seq) is
equal to the number waiters which are effectively blocked.  This
corresponds to the states "Sleeping" and "About to sleep".

pthread_condvar_signal checks (total_seq - wakeup_seq), and if it's >
0, increments wakeup_seq.  To maintain the invariant it, at the same
time (i.e. inside the mutex), it offers a WAKE token (this is the
operational sequence futex++ followed by FUTEX_WAKE).  This is
supposed to make one waiter in "About to sleep" or "Sleeping"
transition to another state.

When there is only one waiter, this works.

When there are two or more waiters, this fails because one of them can
be "Drowsy".  That's not one of the states counted in (total_seq -
wakeup_seq), but it might accept the WAKE token, causing the attempt to
decrease the number in "About to sleep" and "Sleeping" to fail.

After the invariant is broken, no amount of calling
pthread_cond_signal will wake up all waiters.

Now, a waker cannot detect which state ("Sleeping" or "Drowsy")
accepted the token.  A woken waiter cannot detect it either.

Therefore the solution to this invariant _must_ involve not
distinguishing those states.

The solution to maintaining the invariant is to include "Drowsy" in
the states counted by (total_seq - wakeup_seq).  This means that
wakeup_seq must not be incremented by the waker if FUTEX_WAKE reports
the WAKE token is not accepted ("About to sleep" -> "Drowsy", it's
still in the counted set).  wakeup_set must also be incremented by the
waiter if FUTEX_WAIT reports that it did _not_ receive a token
("Drowsy" -> "Awake"), as this means the counted set has changed but
this has not yet been reflected in wakeup_seq.

This still fails to wake up some waiters transiently (see later), but
it solves this particular problem of the long term invariant breaking
- this is the more serious problem.

Here's the implementation.  You'll notice that we do something
significant: we look at the return value of futex operations.  That's
why they return a value! :)

    pthread_cond_signal (cond)
    {
      mutex_lock (lock);
      if (total_seq > wakeup_seq) {
<<<<<
        ++wakeup_seq, ++futex;
        futex (&futex, FUTEX_WAKE, 1);
=====
        ++futex;
        wakeup_seq += futex (&futex, FUTEX_WAKE, 1);
>>>>>
      }
      mutex_unlock (lock);
    }
    pthread_cond_wait (cond, mtx)
    {
      mutex_lock (lock);
      mutex_unlock (mtx->lock);
      ++total_seq;
      ++futex;
      mutex = mtx;
      bc_seq = broadcast_seq;
      seq = wakeup_seq;
      do {
        val = futex;
        mutex_unlock (lock);
<<<<<
        futex (&futex, FUTEX_WAIT, val);
        mutex_lock (lock);
=====
        result = futex (&futex, FUTEX_WAIT, val);
        mutex_lock (lock);
        if (result < 0)
          wakeup_seq++;
>>>>>
        if (bc_seq != broadcast_seq)
          goto out;
      } while (wakeup_seq == seq || woken_seq == wakeup_seq);
      ++woken_seq;
    out:
      mutex_unlock (lock);
      mutex_lock (mtx->lock);
    }

(Thanks for the helpful pseudo-code, btw).

Jakub Jelinek wrote:
> E.g. the futex IMHO must be incremented before FUTEX_WAKE, as otherwise
> the woken tasks wouldn't see the effect.

futex must be incremented before FUTEX_WAKE, but wakeup_seq does not
have to be incremented before FUTEX_WAKE - the private mutex means
that it can be incremented after.

>   1. A lost wakeup.
>
>      wait_A is woken, but wait_B is not, even though the second
>      pthread_cond_signal is "observably" after wait_B.
>
>      The operation order is observable in sense that wait_B could
>      update the data structure which is protected by cond+mutex, and
>      wake_Y could read that update prior to deciding to signal.
>
>      _Logically_, what happens is that wait_A is woken by wake_X, but
>      it does not immediately re-acquire the mutex.  In this time
>      window, wait_B and wake_Y both run, and then wait_A acquires the
>      mutex.  During this window, wait_A is able to absorb the second
>      signal.
>
>      It's not clear to me if POSIX requires wait_B to be signalled or
>      not in this case.

Ok, I have seen written and it makes sense that two signals should
result in both waiters woken in this case.  I think that's a
reasonable expectation.

Using those logical states, this lost wakeup occurs because wait_A is
woken by wake_X, entering the "Drowsy" state, and then it accepts a
WAKE token from wake_Y, to become "Awake".  Accepting a WAKE token in
the "Drowsy" state prevents wait_B from accepted it.  In extreme
cases, there can be a large number of threads in the "Drowsy" state,
absorbing a lot of wakeups together.

There are several ways to fix this (the 6th is my favourite):

    1. In the kernel, make the FUTEX_WAIT test-and-queue operation
       effectively atomic w.r.t. FUTEX_WAKE by more exclusive locks,
       as you have requested.

       Effect: Prevents the "Drowsy" state from accepting WAKE tokens.

    2. Subtler: In the kernel, lock FUTEX_WAIT test-and-queue operations
       w.r.t. _other_ FUTEX_WAIT operations on the same futex, but
       not exclusive w.r.t. FUTEX_WAKE operations.

       Effect: Does not prevent "Drowsy" from accepting WAKE tokens,
       but does prevent any "Sleeping" states from existing at the same
       time, so "Drowsy" never steals WAKE tokens.

       To be more precise, just the region from get_user to unqueue_me
       needs to be locked w.r.t. other FUTEX_WAITs, but explaining
       this requires a more complicated state machine.

       This one is too subtle to be allowed, imho.  Can you imagine
       the man page trying to explain it?

    3. Related to above, but purely userspace.  Lock a second private
       mutex around each call to FUTEX_WAIT.  At first sight this
       looks like it would be a performance killer, but it's not
       totally obvious whether it would be:

<<<<<
          result = futex (&futex, FUTEX_WAIT, val);
=====
          mutex_lock (lock2);
          result = futex (&futex, FUTEX_WAIT, val);
          mutex_unlock (lock2);
>>>>>

    4. A combination of low-impact kernel and userspace changes.

       In the kernel, change the return value of FUTEX_WAIT to report
       when the futex word didn't match but it received a wakeup anyway.

       Effect: Allows the waiter to detect that it absorbed a WAKE
       token in the "Drowsy" state, implying that it was maybe needed
       by another waiter, so it should re-transmit that token by
       calling FUTEX_WAKE.

       The kernel code change is trivial and has no performance impact
       on futexes in general, e.g. as used for mutexes, but here it
       might lead to redundant extra system calls in some cases.

       This strategy has a subtle behavioural quirk, which might be a
       flaw, I'm not sure, which is described at the end of answer 5 below.

       Kernel change looks like:

       out_unqueue:
          /* If we were woken (and unqueued), we succeeded, whatever. */
          if (!unqueue_me(&q))
<<<<<
                  ret = 0;
=====
                  ret = 1;
>>>>>

       Userspace change looks like:

          result = futex (&futex, FUTEX_WAIT, val);
          mutex_lock (lock);
          if (result < 0)
            wakeup_seq++;
<<<<<
=====
          else if (result > 0)
            wakeup_seq += futex (&futex, FUTEX_WAKE, 1);
>>>>>

    5. Like 4, but in the kernel.  We change the kernel to _always_
       retransmit a wakeup if it's received by the unqueue_me() in the
       word-didn't-match branch.

       Effect: In the "Drowsy" state, a waiter may accept a WAKE token
       but then it will offer it again so they are never lost from
       "Sleeping" states.

       NOTE: This is NOT equivalent to changing the kernel to do
       test-and-queue atomically.  With this change, a FUTEX_WAKE
       operation can return to userspace _before_ the final
       destination of the WAKE token decides to begin FUTEX_WAIT.

       This will result in spurious extra wakeups, erring too far the
       other way, because of the difference from atomicity described
       in the preceding paragraph.

       Therefore, I don't like this.  It would fix the NPTL condition
       variables, but introduces two new problems:

           - It violates conservation of WAKE tokens (like energy and
             momentum), which some other futex-using code may depend
             on - unless the return value from FUTEX_WAIT is changed
             to report 1 when it receives a token or 2 when it
             forwards it successfully.

           - Some spurious wakeups at times when a wakeup is not
             required.

           - No logical benefit over doing it in userspace, but
             would take away flexibility if kernel always did it.

    6. Like 4, but this requires no kernel change, just userspace.
       Another counter is used to detect when retransmision is needed:

          pthread_cond_signal (cond)
          {
            mutex_lock (lock);
            if (total_seq > wakeup_seq) {
<<<<<
              ++wakeup_seq, ++futex;
              futex (&futex, FUTEX_WAKE, 1);
=====
              ++futex;
              ++missing;
              result = futex (&futex, FUTEX_WAKE, missing);
              wakeup_seq += result;
              missing -= result;
>>>>>
            }
            mutex_unlock (lock);
          }
          pthread_cond_wait (cond, mtx)
          {
            mutex_lock (lock);
            mutex_unlock (mtx->lock);
            ++total_seq;
            ++futex;
            mutex = mtx;
            bc_seq = broadcast_seq;
            seq = wakeup_seq;
            do {
              val = futex;
              mutex_unlock (lock);
<<<<<
              futex (&futex, FUTEX_WAIT, val);
              mutex_lock (lock);
=====
              result = futex (&futex, FUTEX_WAIT, val);
              mutex_lock (lock);
              if (result < 0) {
                ++wakeup_seq;
                --missing;
              }
              if (missing) {
                result = futex (&futex, FUTEX_WAKE, missing);
                wakeup_seq += result;
                missing -= result;
              }                
>>>>>
             if (bc_seq != broadcast_seq)
               goto out;
           } while (wakeup_seq == seq || woken_seq == wakeup_seq);
           ++woken_seq;
         out:
           mutex_unlock (lock);
           mutex_lock (mtx->lock);
         }

NOTE: The difference in 5 between kernel atomic wakeups and kernel
forwarded wakeups being observable has an analogous form in userspace
pthreads condition variables, with any of the 4, 5 or 6
implementations.  That is, anything that works by forwarding wakeups.

If an application calls pthread_cond_signal, then that returns, and
then the application calls pthread_cond_wait, forwarded wakeups could
result in that wait being woken by the signal which logically preceded
it.

This happens because the wake is "in flight" so to speak.

It would also result in a different wait, queued earlier than the
pthread_cond_signal call, not being woken because this one is woken in
its place.  The total number woken is fine.

The same thing can occur with solutions 4, 5 and 6.

Those spuriously delayed wakeups may or may not be a problem.  They
are observable so a program's behaviour could be written to depend on
them not occurring.  However, that's a pretty subtle thing to depend
on - not the sort of thing programs using condvars would normally do.

This time I _really_ have no idea if that would be forbidden by POSIX
or not.

I suspect some implementations of condvar work a bit like queued
signals or queued messages: where pthread_cond_signal while the signal
itself is in flight and may be delivered to a subsequently starting
wait, within a time window.  Then again, maybe they aren't.

> If you think it is fixable in userland, please write at least the pseudo
> code that you believe should work.  We have spent quite a lot of time
> on that code and don't believe this is solvable in userland.

I hope I have presented and explained the userland-only solutions.

Out of all of the above, solution 6 looks most promising to me.
Having a think about the wakeup ordering issues mentioned at the end,
though.

> I believe the only place this is solvable in is the kernel, by ensuring
> atomicity (i.e. queuing task iff curval == expected_val operation atomic
> wrt. futex_wake/futex_requeue in other tasks).  In the RHEL3 2.4.x backport
> this is easy, as spinlock is held around the user access (the page is first
> pinned, then lock taken, then value compared (but that is guaranteed to
> be non-blocking) and if equal queued, then unlocked and unpinned.
> In 2.6.x this is harder if the kernel cannot allow some spinlock to be
> taken while doing user access, but I guess the kernel needs to cope
> with this, e.g. by queueing the task early but mark it as maybe queued
> only.  If futex_wake sees such a bit, it would wait until futex_wait
> notifies it it has decided whether that one should be queued or not.
> Or something else, whatever, as long as the right semantics is ensured.

> Just FYI, current pseudo code is (not mentioning cancellation stuff here,
> code/data to deal with pthread_cond_destroy semantics, timedwait and
> pshared condvars):
>
> typedef struct { int lock, futex; uint64_t total_seq, wakeup_seq, woken_seq;
>                void *mutex; uint32_t broadcast_seq; } pthread_cond_t;

A few questions:

      1. Why are total_seq and so on 64 bit quantities?

         The comparison problem on overflow is solvable by changing
         (total_seq > wakeup_seq) to (int32_t) (total_seq -
         wakeup_seq) > 0, just like the kernel does with jiffies.

         If you imagine the number of waiters to exceed 2^31, you have
         bigger problems, because:

      2. futex is 32 bits and can overflow.  If a waiter blocks, then
         a waker is called 2^32 times in succession before the waiter
         can schedule again, the waiter will remain blocked after the
         waker returns.

         This is unlikely, except where it's done deliberately
         (e.g. SIGSTOP/CONT), and it's a bug and it only needs two
         threads!  It could perhaps be used for denial of service.

      3. Why is futex incremented in pthread_cond_wait?
         I don't see the reason for it.

      4. In pthread_cond_broadcast, why is the mutex_unlock(lock)
         dropped before calling FUTEX_CMP_REQUEUE?  Wouldn't it be
         better to drop the lock just after, in which case
         FUTEX_REQUEUE would be fine?

         pthread_cond_signal has no problem with holding the lock
         across FUTEX_WAKE, and I do not see any reason why that would
         be different for pthread_cond_broadcast.

> pthread_cond_broadcast (cond)
> {
>   mutex_lock (lock);
>   if (total_seq > wakeup_seq) {
>     woken_seq = wakeup_seq = total_seq;
>     futex = 2 * total_seq;
>     ++broadcast_seq;
>     val = futex;
>     mutex_unlock (lock);
>     if (futex (&futex, FUTEX_CMP_REQUEUE, 1, INT_MAX, &mutex->lock, val) < 0)
>       futex (&futex, FUTEX_WAKE, INT_MAX);
>     return;
>   }
>   mutex_unlock (lock);
> }

-- Jamie
