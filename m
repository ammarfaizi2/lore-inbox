Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317975AbSG0HAD>; Sat, 27 Jul 2002 03:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSG0HAD>; Sat, 27 Jul 2002 03:00:03 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:61658 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317975AbSG0HAA>;
	Sat, 27 Jul 2002 03:00:00 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] new module interface 
In-reply-to: Your message of "Fri, 26 Jul 2002 12:12:06 +0200."
             <Pine.LNX.4.44.0207261109470.28515-100000@serv> 
Date: Sat, 27 Jul 2002 16:49:59 +1000
Message-Id: <20020727070413.EF52943E4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0207261109470.28515-100000@serv> you write:
> Hi,
> 
> On Fri, 26 Jul 2002, Rusty Russell wrote:
> > Well, you substituted the module pointer for an atomic counter.  Bit
> > of a wash, really.
> 
> Converting the module pointer into a counter is the easiest way to convert
> to the new interface. Behind that is a very important concept - complete
> seperation of module state management (done in kernel/module.c) and module
> usage management (done by the module). Both are independent in my patch,
> so the module has complete freedom how to do the later. This means it
> doesn't has to use a counter, the usecount function could be as well
> something like "return busy ? 1 : 0;" and the module won't be bothered
> with unloading. 

But your added flexibility doesn't actually buy you any more power.
It does mean (as implemented) that even without module support in your
kernel, filesystems have to be reference counted.

> On the other hand if a module needs something more
> complex, it can do so without bothering the remaining the module code
> (e.g. if I look at the LSM hooks, I'm really not sure how to sanely unload
> a module from that).

Exactly.  I don't see how it is a definitive win 8(

> > No, if you drop them newer binutils notices the link problem, hence
> > the __devexit_p(x) macro.
> 
> AFAIK we have that problem if we discard the sections immediately at link
> time, but we could also discard them at kernel init. On the other hand I'm
> not completely against wrapping the field initialization in a macro.

Yes.  I hate the macro wrapping myself though 8(

> > > Not yet. The problem is the module name, e.g. ext2 is called
> > > fs_ext2_super, it will need some kbuild changes to get the right module
> > > name.
> >
> > I need that too: the mythical "KBUILD_MODNAME".  Both Keith and Kai
> > promised it to me...
> 
> I found a solution for that yesterday. :)


> I looked at your patch and some interesting parts are missing, so it's
> difficult to comment. It's really small, but it also has lots of FIXMEs. :)
> My module pointer comment above applies to your patch as well. Since
> module unloading isn't implemented yet, it's difficult to say how you want
> to avoid the races.

I removed module unloading from the current patch, because of ongoing
debate (and as you know, this is a whole issue by itself 8).

The implementation in the older patches did:

	module->waiting = current;
	err = module->stop();
	if (err)
		return err;
	synchronize_kernel();
	module_put(module);
	while (atomic_read(&module->count)) {
		set_current_state(TASK_INTERRUPTIBLE);
		schedule();
	}

synchronize_kernel() waits for every CPU to schedule (with preemption,
it means wait for every preempted thread to voluntarily schedule).
This prevents the "MOD_DEC_USE_COUNT; return" race.

module_put() was a simple:
	if (atomic_dec_and_test(&module->count))
		wake_up_process(module->waiting);

> One thing I mentioned earlier is that I still think that module linkage
> is better done in user space, if we also keep all the symbol and
> dependency information in user space. Insmod just had to relocate the
> module and the kernel only needs the pointer to the module structure and
> finds the rest through it, so no adding of new sections/symbols or
> initialization of the module structure would be required, so insmod hadn'

I think the in-kernel linker is much neater, and much smaller than the
combined one.  One big advantage is that I don't have to do 64-bit
links on a 32-bit userspace.

> BTW I also looked at the automatic initcall generation script, I think I
> have a solution for a big part of the problem, that would at least allow
> to order the init calls of all normal modules. (Patches are coming
> hopefully soon. :) )

Yes.  I thought of treating each module as one "unit" for the purposes
of initialization order, and resolving the ordering within each module
as a separate problem, but I ran out of energy, and I'm not convinced
that some core code loops are not fundamental.  The problem is that if
there are still loops, they may well depend on .config so some poor
user with a different config can't compile the kernel 8(

And the explicit initcalls are pretty nice, too!

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
