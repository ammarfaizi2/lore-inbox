Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319459AbSILG5Z>; Thu, 12 Sep 2002 02:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319458AbSILG5Z>; Thu, 12 Sep 2002 02:57:25 -0400
Received: from dp.samba.org ([66.70.73.150]:7856 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319459AbSILG5Y>;
	Thu, 12 Sep 2002 02:57:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: lk@tantalophile.demon.co.uk, oliver@neukum.name, zippel@linux-m68k.org,
       viro@math.psu.edu, kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface 
In-reply-to: Your message of "Thu, 12 Sep 2002 07:58:02 +0200."
             <E17pMzL-0007fx-00@starship> 
Date: Thu, 12 Sep 2002 17:00:37 +1000
Message-Id: <20020912070214.570C52C0A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17pMzL-0007fx-00@starship> you write:
> On Thursday 12 September 2002 06:52, Rusty Russell wrote:
> > Um, so register_xxx interfaces all use try_inc_mod_count (ie. a
> > struct module *  extra arg to register_xxx)?
> 
> In that case they are filesystems or some other thing that fits the
> model closely enough for try_ind_mod_count to be efficient.  This
> case is easy and solved as far as I'm concerned, do correct me if
> I'm wrong.  Assuming I'm not wrong, on to a hard and interesting
> case.

No, let's talk about a simple notifier chain.  Say you want to know
when CPUs go up and down...

> > Or those entry points
> > are not protected by try_inc_mod_count, so it must bump the refcnt, so
> > you need to sleep in load until the module becomes unused again.
> 
> Let's consider LSM as a really hard case, and let's suppose that the 
> register_*'s just plug new functions into function tables.  These functions 
> are just called indirectly, there is no module entry/exit accounting 
> whatsoever, except that the inc/dec rule must be followed where module code 
> itself might sleep.
> 
> Anyway, at the -EBARF point, all the function pointers have been restored to 
> their original state, but we may have some tasks executing in the module 
> already, which got in while _xxx was there.  The solution is to do the 
> magic_wait_for_quiescence (yes I know it has a real name, I forgot it) before
> returning -EBARF.  Refcounts never come into it.
> 
> What did I miss?  It was too easy.

The notifier routine did the right thing, and did:

	MOD_INC_USE_COUNT();
	wait_for_some_event();

It's sitting there now, sleeping inside the module (which has refcnt
1) and we returned -EBARF from module_init().

> I doubt this is any central issue though.  We could, for instance, pass the 
> address of the count variable to the quiescence tester, and it will be 
> examined at schedule time, however that works (I promise to find out soon).

You can sleep in some way before actually kfreeing the failed-to-load
module memory; preempt makes this a bit trickier but the theory is the
same (it was preempt that broke my implementation, yes it was that
long ago).  The point is that you could be sleeping for a *long*
time...

> I don't see the endless wait.  It looks to me like it's just the time 
> required for everyone to schedule, which is unbounded all right, but not in 
> any interesting sense.

It's not the waiting to schedule.  It's the waiting for the refcnt to
drop to zero.

I don't mind saying "we don't have to handle that corner case", but
you're left with the messiness of two classes of kernel interface:
those which handle your refcounting and those which don't.  And the
module author better get right which ones are which (remember, we're
talking about people who are *not* kernel gurus, writing their first
and last kernel module on paid time for their company).

This is where the "how important is module unload?" thing somes in.
You could get rid of the bugs by having a list of "module count safe"
interfaces (ie. exported symbols), and if a module uses any others,
you simply refuse to unload it.  Then no modules need *ever* worry
about their own reference counts.

Now, the trick I have in my back pocket is a distributed reference
count scheme (unimplemented so far on Linux, but another idea stolen
from Paul McKenney's Dynix/PTX team).  You use per-cpu counts *until*
you want to see if the count is zero (ie. module unload), at which
case you flip them into (slow) shared-counter mode (handwave,
handwave, I know).

So it *might* be cheap to apply this to every interface, and migrate
interfaces across into the "module safe" category on an as-we-need-it
basis.

Hope that clarifies my thinking this week...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
