Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273672AbRIWWsC>; Sun, 23 Sep 2001 18:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273688AbRIWWrx>; Sun, 23 Sep 2001 18:47:53 -0400
Received: from CPE-61-9-148-170.vic.bigpond.net.au ([61.9.148.170]:22912 "EHLO
	wagner") by vger.kernel.org with ESMTP id <S273672AbRIWWri>;
	Sun, 23 Sep 2001 18:47:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5 
In-Reply-To: Your message of "Sun, 23 Sep 2001 12:43:36 +0200."
             <20010923124336.D30515@nightmaster.csn.tu-chemnitz.de> 
Date: Mon, 24 Sep 2001 08:42:25 +1000
Message-Id: <E15lHxB-0005dt-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010923124336.D30515@nightmaster.csn.tu-chemnitz.de> you write:
> On Sun, Sep 23, 2001 at 04:37:43PM +1000, Rusty Russell wrote:
> > OLD:	module_init(initfn)
> > NEW:	init_and_startcall(initfn, startfn);
> > COMMENTS:
> > 	Please use a semicolon at the end.  Modulable code should
> > 	transition to a two-stage init (initfn sets everything up
> > 	and may fail, and startfn which exposes the module to the rest
> > 	of the kernel and can't fail).  Some modules only need
> > 	initfn or startfn, in which case use initcall() or startcall().
>  
> Why separating them?

Hi Ingo,

	Glad you like the PARAM stuff.  To answer your question,
consider the following standard case in module initialization:

	int init(void)
	{
		int ret;

		ret = register_something();
		if (ret != 0) return ret;

		ret = register_something_else();
		if (ret != 0) {
			unregister_something();
			return ret;
		}
		return 0;
	}

Imagine register_something() succeeds, but register_something_else()
fails.  Someone could be accessing the module (through
register_something()): what do we do?  We can't free the module and
return the error to insmod...

Mind you, many modules currently ignore errors anyway...

> > OLD:	void exitfn(void) { ...; }
> > 	module_exit(void)
> > NEW:	int stopfn(void) { ...; return 0; }
> > 	void exitfn(void) { ...; }
> > 	stopcall(stopfn);
> > 	exitcall(exitfn);
> > COMMENTS:
> > 	If there are neither, then module is not unloadable.  This is
> > 	perfectly OK.  If stopfn returns 0 (otherwise it should be
> > 	-errno) it must have deregistered itself from the rest of the
> > 	kernel (ie. module count can never increase again), but still
> > 	be usable to anyone using it currently.  Once exitfn is
> > 	called, it is guaranteed to be unused.
> 
> Same question here: Why you changed this? 
> 
> What is meant with "usable to anyone using it currently"? 

Someone could still have a reference to the module when stopfn is
called.  If you register an interrupt handler, say, there could be
someone running it on another CPU right now.

> Does it mean the variables of it can still be read/written? 

Yes: after stopfn, no NEW things can access the module, but it must be
still usable for anyone who got access to the module before.

> Can the startcall or the initcall still be called after stopcall? 

No: at this stage the module will have to be reloaded, exactly because
of assumptions like zero-initialization.

> Can IO to ports still be issued and "transactions" still be
> finished after stopcall has been issued?

Yes... The module is still "live", it's just you must unregister
anything which might allow new accesses (eg. proc entries,
filesystems, IRQ handlers, etc).  Sometime after the module count
falls to zero, exitfn will be called and the module actually freed.

Hope that clarifies,
Rusty.
--
Premature optmztion is rt of all evl. --DK
