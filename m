Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264810AbSJPCwq>; Tue, 15 Oct 2002 22:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264830AbSJPCwq>; Tue, 15 Oct 2002 22:52:46 -0400
Received: from dsl-213-023-038-160.arcor-ip.net ([213.23.38.160]:19100 "EHLO
	starship") by vger.kernel.org with ESMTP id <S264810AbSJPCwp>;
	Tue, 15 Oct 2002 22:52:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] In-kernel module loader 1/7
Date: Wed, 16 Oct 2002 04:59:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <20021016021949.DB2A92C2C1@lists.samba.org>
In-Reply-To: <20021016021949.DB2A92C2C1@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E181eOt-00044e-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 October 2002 01:53, Rusty Russell wrote:
> In message <E181Tcc-0003k0-00@starship> you write:
> > On Tuesday 15 October 2002 05:25, Rusty Russell wrote:
> > > It won't quite work if the hooks can sleep.  You can say "don't sleep"
> > > or have a wedge which does the "try_inc_mod_count()" then calls into
> > > the module (and returns some default if it can't inc the module count).
> > 
> > Right.  By coincidence, I found myself thinking about this very problem
> > as I re-materialized this morning.  If TRY_INC_MOD_COUNT also ors a flag
> > (which it does now, for other reasons) then:
> > 
> >    1) Clear the mod_inc flag
> >    2) Unhook the function hooks
> >    3) Schedule on each CPU
> >    4) If the mod_inc flag is set, repeat from (1)
> > 
> > This should perform acceptably well, and would only be done in cases
> > where the existing TRY_INC_MOD_COUNT strategy can't be used.
> 
> This is basically the same technique used in my current patch.  We set
> module->live = 0, sychronize_kernel(), then look at reference count.
> In this case, instead of setting a flag, try_inc_mod_count (aka
> try_module_get()) bumps the refcount, to similar effect to the flag.

Yes, my earlier-posted algorithm was just plain wrong.  So that's one
item out of the way.

> > > You can't disable preemption before calling in, because there is no
> > > way to sleep with preemption disabled. 8(
> > 
> > Why is that harder than bumping a counter that makes preempt_schedule
> > return without doing anything?
> 
> Definitely.  We could simply allow schedule() to be called when
> preempt is disabled, but it's a useful debugging tool to not do that.

It doesn't strike me as difficult or costly to accomodate this.

> And, of course, disabling preemption widely kind of defeats the point
> of having a preemptive kernel 8(

It only needs to be turned off when unloading one of the "hard" modules.
This would be an incrementing disable to accodate simultaneous unloads.
During the unload your desktop might get a little bit less interactive,
but that's better than not being able to unload at all.

> I really wish the security guys had gone down the macro path, with
> something like
> 
> #define security_check(func, default_val, ...)
> 	({ if (try_inc_mod_count(security_ops->owner))
> 		security_ops->func(__VA_ARGS__);
> 	   else
> 		default_val;
> 	})
> 
> This also allows the whole thing to vanish if
> CONFIG_SECURITY_CAPABILITIES=n, and allows more flexibility for
> schemes like "always run with preemption disabled around security ops"
> or whatever, rather than having to search for all the references to
> security_ops.

Then everybody would complain about the extra overhead, no matter how
small it is.  Conceptually, are there any outstanding issues with "hard"
way of unloading modules, assuming we can use the TRY_INC way[1] for
"easy" modules?  One I don't recall being discussed, is the inherent
difficulty of unhooking an interface like LSM, one function at a time.

[1] Or a related way, to be determined via the tag-team mud-wrestling
method.

--
Daniel
