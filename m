Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319444AbSILFvq>; Thu, 12 Sep 2002 01:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319445AbSILFvq>; Thu, 12 Sep 2002 01:51:46 -0400
Received: from dsl-213-023-043-193.arcor-ip.net ([213.23.43.193]:23428 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319444AbSILFvp>;
	Thu, 12 Sep 2002 01:51:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] Raceless module interface
Date: Thu, 12 Sep 2002 07:58:02 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lk@tantalophile.demon.co.uk, oliver@neukum.name, zippel@linux-m68k.org,
       viro@math.psu.edu, kaos@ocs.com.au, linux-kernel@vger.kernel.org
References: <20020912031345.760A32C061@lists.samba.org> <E17pKxR-0007by-00@starship> <20020912145244.4cc6fb98.rusty@rustcorp.com.au>
In-Reply-To: <20020912145244.4cc6fb98.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pMzL-0007fx-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 06:52, Rusty Russell wrote:
> On Thu, 12 Sep 2002 05:47:57 +0200
> Daniel Phillips <phillips@arcor.de> wrote:
> 
> > On Thursday 12 September 2002 05:13, Rusty Russell wrote:
> > > B) We do not handle the "half init problem" where a module fails to 
> > >    load, eg.
> > > 	a = register_xxx();
> > > 	b = register_yyy();
> > > 	if (!b) {
> > > 		unregister_xxx(a);
> > > 		return -EBARF;
> > > 	}
> > >   Someone can start using "a", and we are in trouble when we remove
> > >   the failed module.
> > 
> > No we are not.  The module remains in the 'stopped' state
> > throughout the entire initialization process, as it should and
> > does, in my model.
> 
> Um, so register_xxx interfaces all use try_inc_mod_count (ie. a
> struct module *  extra arg to register_xxx)?

In that case they are filesystems or some other thing that fits the
model closely enough for try_ind_mod_count to be efficient.  This
case is easy and solved as far as I'm concerned, do correct me if
I'm wrong.  Assuming I'm not wrong, on to a hard and interesting
case.

> Or those entry points
> are not protected by try_inc_mod_count, so it must bump the refcnt, so
> you need to sleep in load until the module becomes unused again.

Let's consider LSM as a really hard case, and let's suppose that the 
register_*'s just plug new functions into function tables.  These functions 
are just called indirectly, there is no module entry/exit accounting 
whatsoever, except that the inc/dec rule must be followed where module code 
itself might sleep.

Anyway, at the -EBARF point, all the function pointers have been restored to 
their original state, but we may have some tasks executing in the module 
already, which got in while _xxx was there.  The solution is to do the 
magic_wait_for_quiescence (yes I know it has a real name, I forgot it) before 
returning -EBARF.  Refcounts never come into it.

What did I miss?  It was too easy.

Ah, I'm glossing over how the "I need to sleep" intramodule refcounts 
interact with the magic quiescence test.  Let's see if some sleep fixes that. 
I doubt this is any central issue though.  We could, for instance, pass the 
address of the count variable to the quiescence tester, and it will be 
examined at schedule time, however that works (I promise to find out soon).

> You have the same issue in the "wait for schedule" case on unload,
> where someone jumps in while you are unregistering.

We don't.  Our LSM module will first restore all the function pointers to
their original state, then wait for everyone to schedule.

> My implementation
> decided to ignore this problem (ie. potentially wait forever with the
> module half-loaded) but it is an issue.

I don't see the endless wait.  It looks to me like it's just the time 
required for everyone to schedule, which is unbounded all right, but not in 
any interesting sense.

-- 
Daniel
