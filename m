Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272256AbTG3WGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272257AbTG3WGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:06:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:60869
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272256AbTG3WGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:06:22 -0400
Date: Thu, 31 Jul 2003 00:06:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linas@austin.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730220604.GA23835@dualathlon.random>
References: <20030730111639.GI23835@dualathlon.random> <Pine.LNX.4.44.0307301342260.17411-100000@localhost.localdomain> <20030730123458.GM23835@dualathlon.random> <20030730161810.B28284@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730161810.B28284@forte.austin.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 04:18:10PM -0500, linas@austin.ibm.com wrote:
> On Wed, Jul 30, 2003 at 02:34:58PM +0200, Andrea Arcangeli wrote:
> > 
> > so if it was really the itimer, it had to be on ppc s390 or ia64, not on
> > x86.  I never reproduced this myself. I will ask more info on bugzilla,
> > because I thought it was x86 but maybe it wasn't. As said in the
> > previous email, only non x86 archs can run the timer irq on a cpu
> > different than the one where it was inserted.
> 
> I think I started the thread, so let me backtrack.  I've got several
> ppc64 boxes running 2.4.21.    They hang, they don't crash.  Sometimes
> they're pingable, but that's all.  The little yellow button is wired 
> up to KDB, so I can break in and poke around and see what's happening.
> 
> Here's what I find:
> 
> __run_timers() is stuck in a infinite loop, because there's a 
> timer on the base.  However, this timer has timer->list.net == NULL,
> and so it can never be removed.  (As a side effect, other CPU's get 
> stuck in various places, sitting in spinlocks, etc. which is why the
> machine goes unresponsive)  So the question becomes "how did this 
> pointer get trashed?"
> 
> I thought I saw an "obvious race" in the 2.4 code, and it looked
> identical to the 2.6 code, and thus the email went out.  Now, I'm
> not so sure; I'm confused.  

the 2.4 code calls into run_all_timers for non x86 archs, that should
go away, and be replaced with calls of the local_run_timers in the per cpu
timer interrupts (not the global timer irq). Infact I wouldn't trust calling
run_all_timers anyways, that might be the racy thing, you're probably the first
one calling it.

> 
> However, given that its timer->list.net that is getting clobbered,
> then locking all occurrances of list_add and list_del should cure the
> problem.   I'm guessing that Andrea's patch to add a timer->lock 
> will protect all of the list_add's, list_del's that matter.  

you definitely need that patch on non x86 archs with the run_all_timers or the
race that I pointed out today will trigger (as agreed by Ingo too), so you
should try to reproduce with it applied.

I've also seen another patch floating around that looks like this:

@@ -214,8 +214,14 @@ repeat:
                        spin_unlock(&old_base->lock);
                        goto repeat;
                }
-       } else
+       } else {
                spin_lock(&new_base->lock);
+               if (timer->base != old_base) {
+                       spin_unlock(&new_base->lock);
+                       printk ("duuude found and fixed bug locking mod
timer\n");
+                       goto repeat;
+               }
+ 

but I don't think we need even this other one in 2.4 (2.4 never touches the
timer->base from the del_timer*):

                /*
                 * Subtle, we rely on timer->base being always
                 * valid and being updated atomically.
                 */
                if (timer->base != old_base) {
                        spin_unlock(&new_base->lock);
                        spin_unlock(&old_base->lock);
                        goto repeat;
                }

since we're serialized by the timer->lock in mod_timer, and del_timer
won't affect the timer->base in 2.4. And add_timer is forbidden to run at the
same time of mod_timer.

So I think we should change the code this way instead of applying the
above patch that looks wrong:

--- 2.4.22pre7aa1/kernel/timer.c.~1~    2003-07-19 02:34:09.000000000 +0200
+++ 2.4.22pre7aa1/kernel/timer.c        2003-07-30 23:43:03.000000000 +0200
@@ -210,15 +210,7 @@ repeat:
                        spin_lock(&old_base->lock);
                        spin_lock(&new_base->lock);
                }
-               /*
-                * Subtle, we rely on timer->base being always
-                * valid and being updated atomically.
-                */
-               if (timer->base != old_base) {
-                       spin_unlock(&new_base->lock);
-                       spin_unlock(&old_base->lock);
-                       goto repeat;
-               }
+               BUG_ON(timer->base != old_base);
        } else
                spin_lock(&new_base->lock);


Assuming you were running 2.4.21 w/o the extended timer->lock to add_timer and
del_timer, the only mistery at the moment is how can have  lcm@us.ibm.com
reproduced a race in setitimer on x86 and get it fixed with the patch I postd
to l-k earlier today that extends the same timer->lock of mod_timer, to
add_timer and del_timer* too.

I mean, that patch is perfectly safe, looks very sane, is strictly necessary on
all non x86* and ia64 archs, but it shouldn't be necessary on x86 as discussed
today with Ingo and Andrew.

I will keep that patch applied because this is 2.4 and it fixes stuff in
practice, but still we must be missing something about this code.

Andrea
