Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbSLZEV0>; Wed, 25 Dec 2002 23:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSLZEVZ>; Wed, 25 Dec 2002 23:21:25 -0500
Received: from dp.samba.org ([66.70.73.150]:53957 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262384AbSLZEVX>;
	Wed, 25 Dec 2002 23:21:23 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module. 
In-reply-to: Your message of "Mon, 23 Dec 2002 12:10:22 -0000."
             <20021223121022.GA32080@suse.de> 
Date: Thu, 26 Dec 2002 14:51:24 +1100
Message-Id: <20021226042938.281142C04D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021223121022.GA32080@suse.de> you write:
> On Mon, Dec 23, 2002 at 12:10:47PM +1100, Rusty Russell wrote:
>  > > This one is due to the way AGPGART does (or has done for the last 3
>  > > years) its module locking. It does a MOD_INC_USE_COUNT as soon as
>  > > someone calls the acquire routines.
>  > Which is racy under SMP, and under preempt, which is why it's
>  > deprecated.
> 
> Crapola. I've just realised why this is no longer relevant.
> I've moved what this was protecting into the per chipset modules.
> Right now its possible to load modules, start x (which loads DRM),
> then rmmod via_agp from under its feet. result - boom when something
> tries to use 3d.
> 
> Sure it's unlikely someone would be crazy enough to try and do this,
> and they deserve what they get, but it's not exactly clean, or nice.
> 
> So where is the documentation describing module locking de jour ?

Here's the FAQ again.  Note that the init stuff is not currently true
(you can enter a module doing init, with possibly bad results),
because Linus patched my code.  It's on my TODO list to revisit this
issue.

>  > > (So you can't unload agpgart whilst you've a 3d using app (like X)
>  > > open).  This seems quite sensible, but these days you can't unload
>  > > agpgart.ko anyway because the chipset module (via-agp.ko in your
>  > > case) already has it 'in use', so I'm tempted to drop those bits.
>  > If this is true (it usually is), you can simply drop them.
> 
> I'll need 'something' in the chipset drivers. The first thing that
> jumps to mind is to give the chipset drivers an 'acquire' op
> which does the locking much like the old agp_backend_acquire() does.

The problem is, a module basically can't lock itself.  Hence you
should expose an "owner" field when you register an interface, and
have the caller do the locking.  There are other possibly solutions,
but none of them were as simple as "lock down before you call in".

>  > There are other cases where the caller is not grabbing references, so
>  > MOD_INC_USE_COUNT is better than nothing (should the warning stay for
>  > 2.6?  Good question).
> 
> Why exactly isn't it safe any more?  If there's documentation on this,
> I'd love to read it. If there isn't, there really should be.

Consider the fictitious my_module.c:

	static void my_function_called_through_ptr(void)
	{
		MOD_INC_USE_COUNT;
		...

		MOD_DEC_USE_COUNT;
		return;
	}

If you get preempted before the MOD_INC_USE_COUNT, an unload could
occur, boom.  If you get preempted after the MOD_DEC_USE_COUNT, but
before the return, and an unload occurs, boom.

If it were not called through a pointer, (ie. called by name) then it
means the module calling it has a reference (this is done
automatically in symbol resolution, or symbol_get()), so no problem.

[ As an implementation detail, this is *not* a problem on SMP without
  preemption.  But that's an implementation detail, and it wasn't true
  with the previous module implementation. ]

Hope this helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Golden Rule: If you are calling though a function pointer into a
(different) module, you must hold a reference to that module.
Otherwise you risk sleeping in the module while it is unloaded.

Q: How do I get a reference to a module?
A: Usually, a successful call to try_module_get(owner).  You don't
   need to check for owner != NULL, BTW.

Q: When does try_module_get(owner) fail?
A: When the module is not ready to be entered (ie. still in
   init_module) or it is being removed.  This prevents you
   entering the module as it is being discarded (init might fail, or
   it's being removed).

Q: But the modules' init routine calls my register() routine which
   wants to call back into one of the function pointers immediately,
   and so try_module_get() fails! (because the module is not finished
   initializing yet)
A: You're being called from the module, so someone already has a
   reference (unless there's a bug), so you don't need a
   try_module_get().

   This does mean that if you were to register a structure for
   *another* module (does anyone do this?) you'd need to have a
   reference to it.

Q: How do I put the reference back?
A: Using module_put(owner) (owner == NULL is OK).

Q: Do I really need to put try_module_get() before every function ptr
   call?
A: If the function does not sleep (any cannot be preempted) ie. is
   called in softirq or hardirq context, you can omit this step, since
   you obviously won't sleep inside the module.

   Also, most structs have clear "start" and "stop" functions
   (eg. mount/umount), so you only need one try_module_get()
   on start, and module_put() on stop.

Q: Is it safe to call try_module_get() and module_put() from an
   interrtupt / softirq?
A: Yes.

Q: My code use "MOD_INC_USE_COUNT".  Do I still need to adjust my
   module count when someone calls one of my functions?
A: No, you never need to adjust your own module count.  There are five
   ways a function in your module can get called: firstly, it could be
   your module_init() function, in which case the module code holds a
   reference.  It could be another module using one of your
   EXPORT_SYMBOL'ed functions, in which case you cannot be removed
   since they would have to be removed first.  It could be a module
   which found an EXPORT_SYMBOL'ed function using symbol_get(), in
   which case they hold a reference count.  It could be through a
   function pointer which your module gave out previously, which is
   discussed above.  Finally, it could be from within your own module,
   in which case someone must already hold a reference.

Q: My code uses "__MOD_INC_USE_COUNT(reg->owner)", but now I get a
   warning at runtime that it is unsafe.  What do I need to do?
A: You need to use try_module_get(), and not call into the module if
   it fails (act as if it hasn't registered yet).  Note that you no
   longer need to check for NULL yourself, try_module_get() does that.

Q: My code used "GET_USE_COUNT(module)" to get the reference count.
A: Don't do that.  If module unloading is disabled, there is no
   reference count, and there is never a single value you can assign
   to.

Q: My code used "try_inc_mod_count(module)" to get the reference
   count.  Should I change it?
A: No hurry.  try_module_get() is exactly the same: the new name
   reflects that this is now the only way to get a reference.

Q: How does the code in try_module_get() work?
A: It disables preemption for a moment, checks the live flag, and then
   increments a per-cpu counter if the module is live.  This is even
   lighter-weight (in icache and cycles) than using a brlock, but has
   the same effect.  If CONFIG_MODULE_UNLOAD=n, it just becomes a
   check that the module is live.

Q: How does the module remove code work?
A: It stops the machine by scheduling threads for every other CPU,
   then they all disable interrupts.  At this stage we know that noone
   is in try_module_get(), so we can reliably read the counter.  If
   zero, or the rmmod user specified --wait, we set the live flag to
   false.  After this, the reference count should not increase, and
   each module_put() will wake us up, so we can check the counter
   again.

Q: Are these changes all so you could implement an in-kernel module
   linker?
A: No, they were to prevent load and unload races without altering
   every module, nor introducing drastic new requirements.

Q: Doesn't putting linking code into the kernel just add bloat?
A: The total linking code is about 200 generic lines, 100
   x86-specific lines.  The ia64 linking code is about 500 lines (it's
   the most complex).  Richard Henderson has a great suggestion for
   simplifying it furthur, which I'm implementing now.  "insmod" is
   now a single portable system call, meaning insmod can be written in
   about 20 lines of code.

   The previous code had to implement the two module loading
   system calls, the module querying system call, and the /proc/ksyms
   output, required a little more code than the current x86 linker.

Q: Why not just fix the old code?
A: Because having something so intimate with the kernel in userspace
   greatly restricts what changes the kernel can make.  Moving into
   the kernel means I have implemented modversions, typesafe
   extensible module parameters and kallsyms without altering
   userspace in any way.  Future extensions won't have to worry about
   the version of modutils problem.

Q: Why not implement two-stage insert / two-stage delete?
A: Because I implemented it first and it sucked.  And because this
   *is* two-stage insert and two-stage delete, without exposing it to
   the modules using it, with the added advantage that the second
   stage is atomic (activation/deactivation is simply changing
   mod->live, modulo locking implementation magic detailed above).
   This prevents the race between deactivating the module and finding
   that someone has starting using it as you are deactivating it.
