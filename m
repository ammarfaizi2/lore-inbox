Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSKZAat>; Mon, 25 Nov 2002 19:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbSKZAat>; Mon, 25 Nov 2002 19:30:49 -0500
Received: from dp.samba.org ([66.70.73.150]:39826 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265830AbSKZAao>;
	Mon, 25 Nov 2002 19:30:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: vandrove@vc.cvut.cz, zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modules with list 
In-reply-to: Your message of "Mon, 25 Nov 2002 14:11:59 -0800."
             <200211252211.OAA02085@baldur.yggdrasil.com> 
Date: Tue, 26 Nov 2002 11:35:09 +1100
Message-Id: <20021126003800.6BC312C2C0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211252211.OAA02085@baldur.yggdrasil.com> you write:
> 	Here is a list of changes that I'm thinking about trying to
> make to modules, in case anyone is interested or wants to show me the
> error of my ways.  Most of these changes do not depend on whether the
> module loader is in the kernel or a user level program.  I've labelled
> the items that are only applicable to user level modules with "user
> level version:".
> 
> 	1. Allow multiple MODULE_DEVICE_TABLE's of the same type in the
> 	   same .c file instead of the combined_dev_id_table hack that
> 	   is now used by modules that really need to load separate
> 	   but related drivers.

Makes sense, should be simple.

> 	2. Eventually have the same build command for modules and
> 	   compiled in objects so that distribution makes can ship an
> 	   "all modules" build and link script to allow much more
> 	   customization by users who do not want to recompile kernel code.

Hmm, I've never really aimed for this, and as you've noticed, there
are a few issues.

> 		2a. Compile module_init, subsys_init, etc. by the
> 		    same mechanism used by kernel objects.

Roman has a patch for this, which is quite nice.  (Look for "module
initcall depends" in the misc section on my patches page).  Basically,
Kai (IIRC) pointed out that module initialization are explicitly
ordered by their dependencies already, and voila (patch needs work to
apply).

Turns out the current scheme is "good enough" and noone seemed
interested, so it'll probably hang around until someone comes up with
a problem so horrible this patch is easier.

> 		2b. Pass module parameter by __setup() rather than
> 		    MODULE_PARM().

Well, s/__setup/__module_param_call/ and that seems like a fine plan.

> 		2c. Eliminate "#ifdef MODULE" init.h, module.h, and,
> 		    eventually, almost everywhere.
> 
> 		2d. In the core kernel, THIS_MODULE would point to
> 		    a struct module rather than being NULL (eliminating
> 		    many little banches).

I thought about doing this, but the branch cost IRL is trivial on
modern processors with decent branch prediction (since it will almost
always be the same way).

> 	3. To prevent rmmod's during modprobe, have
> 	    rmmod do flock(/proc/modules, LOCK_EX) and
> 	    modprobe do flock(/proc/modules, LOCK_SH).  Yes, you can
> 	    detect this already, but this way you it does not cause
> 	    failure and you do not need retry code.

Seems like a perfectly reasonable thing to do.

> 	Other wishes that probably do not effect module-init-tools,
> 	at least when the module loader is in the kernel:
> 
> 	4. failureless raceless module unloading by the module->rwsem_list
> 	   system that I described toward the bottom of this message:
> 	   http://marc.theaimsgroup.com/?l=linux-kernel&m=103773401411324&w=2

OK, I've read this in detail now.  It's a fine scheme, but the devil
is inside here:

struct device_driver *
get_driver_by_name(struct bus_type *bus_type, const char *name)
{
	down_read(&bus->rwsem);

Now, that's perfectly fine for drivers, but try doing that on every
network packet.  You can't use a semaphore, and if you introduce a
shared lock, Dave's going to rip your code out again (this is the guy
who wrote brlocks, remember).

BTW,

>	2. try_module_get() introduces new failures that other software
> has to anticipate.  For example, if I try to mount an ext3 file system
> and it happens that ext3 was being automatically removed (for lack of
> use) at this time, the attempt to get the ext3 filesystem can fail
> without request_module() being called to reload it.

No.  What you're missing is that there is a bogolock inside
try_module_get().  Think of it as a rwlock.

The result is that while your scheme has multiple locks held by
different subsystems which are registered with the module code, my
scheme has one lock in the module code registered with the different
subsystems.  The reason for this is simple: any really fast
lock/refcount structure is going to be fairly big (NR_CPUS *
SMP_CACHE_BYTES).  It's also simple, and I don't have to worry about
locking order.

The best bit, of course, is that when a radical new funky scheme comes
along which solves all these problems, the damage is contained to the
implementation of the interfaces.

>	3. try_module_get() introduces yet another "most fundamental"
> lock type.  We have a bunch of facilities vying to do that, and I
> think it's going to be a source of bugs.  It would be better to avoid
> introducing a new layer of locking if possible.

New code may have bugs, yes <shrug>.  But it's pretty simple. and a
bug is yet to be found here.

> 	4. This kind of race is not really specific to modules, although
> they may be the only example that comes up in practice.

Your code here seems flawed.  You grab the write sem(s) in the remove
code to prevent anyone bumping the refcount.  If someone is recursing
(trying to grab another refcount while already holding one), you
*must* fail them, otherwise you'll deadlock.

And then it becomes try_module_get().

>	4. This kind of race is not really specific to modules, although
> they may be the only example that comes up in practice.

Actually, it is.  For years, the networking code has used refcounts
and two-stage delete almost everywhere: it's now well accepted as an
orthodox method.  So when you "unregister" a socket etc, it removes
the element from lists, and decs the refcount.  Whoever decs the
refcount to zero frees it up (it's assumed that it will monotonically
decrease to zero, since there are no external references any more).
You know this already, of course.

This works *fine* until the object contains a function pointer to
inside a module: at this stage you need to make sure the module
doesn't disappear as well before the object is really deleted.  Roman
solved this by refusing to deregister an object which was in use,
which isn't a really nice solution IMHO.

They really are separate things, we just usually never bothered
refcounting our functions.  The obvious solution is to hold a
reference to the module as well, and that is in fact what this
solution does.

Whatever else, it's conceptually simple.

> 	5. At modprobe time, being able to decide to load a module
> 	   as non-removable to avoid loading .exit{,data} for a smaller
> 	   kernel footprint.  This might only require insmod changes
> 	   for the user level insmod.

Hmm, I already discard these if !CONFIG_MODULE_UNLOAD, but it'd be a
cute hack to let the user do this.

> 	6. kmalloc'ing small modules for less memory consumption and
> 	   perhaps so that they can avoid using TLB entries on certain
> 	   architectures (412 of 1129 modules on my system have
> 	   .text + .data < 4096).

Yeah, this is trivial with the current scheme, and was one of the
aims.  The alloc is arch-specific.

> 	7. User level version: optionally be able to move all symbols
> 	   to user land at the expense of losing kksymoops (would save
> 	   ~100kB on my system).
> 
> 	8. User level version (already done in kernel loader version):
> 	   eliminate dependence on struct module using a module-start.o
> 	   based on what Roman Zippel proposed at
> 	   http://marc.theaimsgroup.com/?l=linux-kernel&m=103740379811285&w=2
> 	   (but using a module-end.o file and eliminating the linker script).
> 
> 	9. User level version: load module contents with mmap(/dev/kmem),
> 	   reducing initial memory requirements by avoiding a malloc
> 	   and copy.
> 
> 	10. Move tracking of dependencies among loaded modules to
> 	    user land (and be able to reconstruct in some cases
> 	    from modules.dep).

Personally, I think the userspace module loaders are clearly inferior,
especially as you're gonna break userspace with almost every one of
these changes.  Sure, you can use a kernel-specific library to give
you back the interface flexibility, but why?  You gain complexity and
your kernel doesn't get any smaller anyway.

Anyway, I think supporting both doesn't make sense.  Either the
in-kernel module loader is better, in which case it should be kept, or
it isn't in which case it should be junked.

Thanks for the mail!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
