Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319421AbSILDI5>; Wed, 11 Sep 2002 23:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319422AbSILDI5>; Wed, 11 Sep 2002 23:08:57 -0400
Received: from dp.samba.org ([66.70.73.150]:9453 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319421AbSILDIz>;
	Wed, 11 Sep 2002 23:08:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Daniel Phillips <phillips@arcor.de>, Oliver Neukum <oliver@neukum.name>,
       Roman Zippel <zippel@linux-m68k.org>,
       Alexander Viro <viro@math.psu.edu>, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface 
In-reply-to: Your message of "Thu, 12 Sep 2002 03:09:33 +0100."
             <20020912030933.A13608@kushida.apsleyroad.org> 
Date: Thu, 12 Sep 2002 13:13:16 +1000
Message-Id: <20020912031345.760A32C061@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020912030933.A13608@kushida.apsleyroad.org> you write:
> I don't see the point in this at all.

Yes, I'm starting to realize that.

Frankly, I'm sick of pointing out the same problems individually to
every shallow thinker who thinks that "it's easy".

The fundamental problems with modules are as follows:
A) Many places in the kernel do not increment module reference counts
   for you, and it is difficult currently write a module which safely
   looks after its own reference counts (see 
   net/ipv4/netfilter/ip_conntrack_core.c's ip_conntrack_cleanup())

B) We do not handle the "half init problem" where a module fails to load, eg.
	a = register_xxx();
	b = register_yyy();
	if (!b) {
		unregister_xxx(a);
		return -EBARF;
	}
  Someone can start using "a", and we are in trouble when we remove
  the failed module.

Suggested solutions come in several forms, with different mixtures of
the following:

1) Poor man's pageable kernel:

	o Every interface in the kernel takes a struct module *, and
	  looks after the reference counts before and after it jumps in.

		o Variants with/without try_inc_mod_count() or
		  two-stage unload.

	o try_inc_mod_count variant solves the half-init problem

2) Modules carry their own overhead:

	o Modules can look after their own reference counts.

		o "don't sleep until you've grabbed a refcount" & wait
		   for quiescence.

		o Two-stage module delete (stop & destroy).

		o More advanced variations allow "restart" of stopped
		  module if race is lost.

	o Still leaves the half-init problem

3) Deprecate module unload:

	o Don't unload modules except by kernel hacking config option.

		o Unloading in-use modules: "don't do that".

	o Still leaves the half-init problem

4) Two-stage module init

	o "Reserve" (can fail) and "use" (can't fail).

	o Solves ONLY the half-init problem

5) Primordial Soup:

	o Module loading/activation and deactivation/destruction occur
	  in a state similar to the kernel at boot.

		o You need to stop all tasks but the loader and some kernel
		  threads, even if module load sleeps.

		o You probably want to defer almost all interrupts, too.

		o Or you can make module_init in interrupt context,
		  which breaks lots of register_xxx interfaces.


(1) PRO: Simple to write modules.
    CON: try_inc_mod_count is a source of random subsystem failure.
    CON: Everyone pays the inc/dec price even if they're not a module.
    CON: Massive infrastructure change
    CON: Modules started as a cute hack, are they really worth this cost?

(2) PRO: Non-modules don't pay the overhead for inc/dec.
    CON: Harder to write modules than (1).
    CON: Gracefully handling the "lost the race between stop and
	 cleanup" adds complexity

(3) PRO: Infrastructure simple.
    PRO: Module implementation simple.
    CON: Some broken drivers (eg. 16-bit PCMCIA) require unload to
	 reset (PCMCIA rewrite and/or suspend hooks can help here).
    CON: Judging "unused" from userspace is fun & racy on real systems.
    CON: We never remove features from Linux.

(4) PRO: Some drivers register things before setting up their internal
	 state already (which works fine at boot).  This would solve
	 that, too.
    PRO: Can be implemented naively, so if a module doesn't have
	 two-stage init, we just never free the module memory (still
	 dangerous since there other resources, but no worse than
	 before).
    CON: Requires more work for module authors in future.

(5) PRO: Infrastructure simple.
    PRO: Module implementation simple.
    PRO: Would fix drivers which register too early, too.
    CON: I'm not smart enough to implement it (esp. before 31 October).
    CON: Scheduler magic lots of fun to keep common case efficient.
    CON: Deferring interrupts may have interesting side effects.
    CON: May not be possible without deadlock?
    CON: "stop the world" during module load may piss off some.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
