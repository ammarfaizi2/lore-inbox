Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSJPCNz>; Tue, 15 Oct 2002 22:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbSJPCNz>; Tue, 15 Oct 2002 22:13:55 -0400
Received: from dp.samba.org ([66.70.73.150]:49132 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264706AbSJPCNx>;
	Tue, 15 Oct 2002 22:13:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Tue, 15 Oct 2002 17:28:33 +0200."
             <E181Tcc-0003k0-00@starship> 
Date: Wed, 16 Oct 2002 09:53:26 +1000
Message-Id: <20021016021949.DB2A92C2C1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E181Tcc-0003k0-00@starship> you write:
> On Tuesday 15 October 2002 05:25, Rusty Russell wrote:
> > It won't quite work if the hooks can sleep.  You can say "don't sleep"
> > or have a wedge which does the "try_inc_mod_count()" then calls into
> > the module (and returns some default if it can't inc the module count).
> 
> Right.  By coincidence, I found myself thinking about this very problem
> as I re-materialized this morning.  If TRY_INC_MOD_COUNT also ors a flag
> (which it does now, for other reasons) then:
> 
>    1) Clear the mod_inc flag
>    2) Unhook the function hooks
>    3) Schedule on each CPU
>    4) If the mod_inc flag is set, repeat from (1)
> 
> This should perform acceptably well, and would only be done in cases
> where the existing TRY_INC_MOD_COUNT strategy can't be used.

This is basically the same technique used in my current patch.  We set
module->live = 0, sychronize_kernel(), then look at reference count.
In this case, instead of setting a flag, try_inc_mod_count (aka
try_module_get()) bumps the refcount, to similar effect to the flag.

> > You can't disable preemption before calling in, because there is no
> > way to sleep with preemption disabled. 8(
> 
> Why is that harder than bumping a counter that makes preempt_schedule
> return without doing anything?

Definitely.  We could simply allow schedule() to be called when
preempt is disabled, but it's a useful debugging tool to not do that.
And, of course, disabling preemption widely kind of defeats the point
of having a preemptive kernel 8(

I really wish the security guys had gone down the macro path, with
something like

#define security_check(func, default_val, ...)
	({ if (try_inc_mod_count(security_ops->owner))
		security_ops->func(__VA_ARGS__);
	   else
		default_val;
	})

This also allows the whole thing to vanish if
CONFIG_SECURITY_CAPABILITIES=n, and allows more flexibility for
schemes like "always run with preemption disabled around security ops"
or whatever, rather than having to search for all the references to
security_ops.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
