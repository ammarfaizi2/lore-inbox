Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130958AbRAaO7m>; Wed, 31 Jan 2001 09:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132044AbRAaO7e>; Wed, 31 Jan 2001 09:59:34 -0500
Received: from hermes.mixx.net ([212.84.196.2]:26643 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130958AbRAaO7U>;
	Wed, 31 Jan 2001 09:59:20 -0500
Message-ID: <3A7827CA.AA840EB4@innominate.de>
Date: Wed, 31 Jan 2001 15:57:14 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] new, scalable timer implementation, smptimers-2.4.0-B1
In-Reply-To: <Pine.LNX.4.30.0101281752090.2612-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> a new, 'ultra SMP scalable' implementation of Linux kernel timers is now
> available for download:
> 
>     http://www.redhat.com/~mingo/scalable-timers/smptimers-2.4.0-B1
> 
> the patch is against 2.4.1-pre10 or ac12. The timer design in this
> implementation is a work of David Miller, Alexey Kuznetsov and myself.
> 
> Internals: the current 2.4 timer implementation uses a global spinlock for
> synchronizing access to the global timer lists. This causes excessive
> cacheline ping-pongs and visible performance degradation under very high
> TCP networking load (and other, timer-intensive operations).

Thanks Christoph for mentioning this post to me.  I'm one day into
scratching timer itches, and I concluded quickly that the
run_timer_queue meeds to be per-cpu, and the timer_enter flag needs to
be per-timer.  I'm relieved to see you already have this under control.

But there's still an issue: the timer->function(data) interface sucks,
for two big reasons:

  1) For multishot timers it's silly to drop the timer_list lock in
run_timer_queue then immediately re-acquire it in mod_timer, then drop
it, then re-acquire it in run_timer_queue to continue processing the
list.  This is unecessary, and we can easily cut down the locking dance
by half.  Yesterday I posted a patch that does this.  The original
motivation for the patch was to solve a problem that had in fact already
solved, and which my patch didn't solve anyway, but by lucky accident
the locking optimization fell out, and also a nicer interface.  I'll
update the patch (New Improved Stronger Whiter Timers) to be a little
more sensible today.  The bad news is it changes the interface.  The the
good news is, I hacked in a simple retrofit to the current existing
interface, so changing over to the new, improved interface can be done a
little at a time instead of changing 100 or so existing timer instances
at once.

  2) Passing timer->data to the timer event is the wrong thing to do. 
Instead, the timer struct pointer should be passed, so that the event
handler can tell which timer instance it's handling, or change its
internal state in some way without going through awkward contortions. 
For example, the event handler might want to update its event handler
function (to implement a state machine) or flip a bit in its ->data.

And a couple of small reasons:

  a)  It's just weird to require the timer to reschedule itself inside
its event, or even to permit that, not to mention unecessary and
inefficient (see above).

  b) The current API looks like it was designed primarly with one-shot
timers in mind.  Most timers events are multishot (because
sleep_on_timeout is better for most one-shot applications and because
multishot timers execute more often) so the API should be optimized for
multishot and one-shot should be a special case of multishot.

> The new implementation introduces per-CPU timer lists and per-CPU
> spinlocks that protect them. All timer operations, add_timer(),
> del_timer() and mod_timer() are still O(1) and cause no cacheline
> contention at all (because all data structures are separated). All
> existing semantics of Linux timers are preserved, so the patch is
> 'transparent' to all other subsystems.
>
> In addition, the role of TIMER_BH has been redefined, and run_local_timers
> is used directly from APIC timer interrupts to run timers (not from
> TIMER_BH). This means that timer expiry is per-CPU as well - it is global
> in vanilla 2.4. Every timer is started and expired on the CPU where it has
> been added. Timers get migrated between CPUs if mod_timer() is done on
> another CPU (because eg. a process using them migrates to another CPU.).
> In the typical case timer handling is completely localized to one CPU.
> 
> The new timers still maintain 'semantical compatibility' with older
> concepts such as the IRQ lock and manipulation of TIMER_BH state. These
> constructs are quite rare already, in 2.5 they can be removed completely.
> 
> the patch has been sanity tested on UP-pure, UP-APIC, UP-IOAPIC and SMP
> systems. Reports/comments/questions/suggestions welcome!

This is exactly the right way to implement timers on smp.  The event
interface is broken and needs to be fixed.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
