Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSKZFWo>; Tue, 26 Nov 2002 00:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266160AbSKZFWo>; Tue, 26 Nov 2002 00:22:44 -0500
Received: from dp.samba.org ([66.70.73.150]:45199 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266108AbSKZFWh>;
	Tue, 26 Nov 2002 00:22:37 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Subject: Re: Modules with list 
In-reply-to: Your message of "Mon, 25 Nov 2002 20:06:41 -0800."
             <200211260406.UAA22079@adam.yggdrasil.com> 
Date: Tue, 26 Nov 2002 16:04:21 +1100
Message-Id: <20021126052954.A49862C107@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211260406.UAA22079@adam.yggdrasil.com> you write:
> Rusty Russell wrote:
> >In message <200211252211.OAA02085@baldur.yggdrasil.com> you write:
> [...]
> >> 	4. failureless raceless module unloading by the module->rwsem_list
> >> 	   system that I described toward the bottom of this message:
> >> 	   http://marc.theaimsgroup.com/?l=linux-kernel&m=103773401411324&w=2
> 
> >OK, I've read this in detail now.  It's a fine scheme, but the devil
> >is inside here:
> 
> >struct device_driver *
> >get_driver_by_name(struct bus_type *bus_type, const char *name)
> >{
> >	down_read(&bus->rwsem);
> 
> >Now, that's perfectly fine for drivers, but try doing that on every
> >network packet.
> 
> 	You're looking up a driver by name or incrementing a module
> reference count on every network packet?  Where?  Show me, please.

TCP for example, sets the destructor function for the skb.  It can be
called an arbitrary time later.  Netfilter modules do a similar thing,
for similar reasons.  You'd better grab a reference to *something*.

> >No.  What you're missing is that there is a bogolock inside
> >try_module_get().  Think of it as a rwlock.
> 
> 	I don't know exactly what you mean by a bogolock (some
> reference to local_inc or your per-CPU reference counts?).

It's slightly magic (see the module.c code).  Functionally, think of
try_module_get() as having a "read_lock_irqsave(&bogolock, flags)/
read_unlock_irqrestore(&bogolock, flags)" around it, and
"stop_refcounts()" being "write_lock_irq(&bogolock)".

> 	With your scheme, you really do have unnecessary failures.
> For example, the system really can tell you that the iso9660
> filesystem is not found when, in fact, there is a module for it
> (because you asked at just the wrong moment, when it was being
> unloaded).

This would only happen if someone says "rmmod --wait".  In which case,
that's *exactly* the right thing to do.  The admin wanted that module
out of there for a reason.

> [...]
> >> 	4. This kind of race is not really specific to modules, although
> >> they may be the only example that comes up in practice.
> 
> >Your code here seems flawed.  You grab the write sem(s) in the remove
> >code to prevent anyone bumping the refcount.  If someone is recursing
> >(trying to grab another refcount while already holding one), you
> >*must* fail them, otherwise you'll deadlock.
> 
> 	No, the point is that these rwsem's do not just lock the
> try_module_get() call.  They lock a slightly larger section of code,
> so that the other process will block when it attempts to look up the
> resource containing the module pointer by name.  In your example, the
> module unload will complete, the other process will then be allowed to
> continue, and it will discover that whatever driver it was asking
> about is not currently loaded (for example, the iso9660 filesystem is
> not found, and it will run modprobe to reload it).

Process A calls "get_driver_by_name("foo")" successfully.  Module
reference count now 1.

Process B calls sys_delete_module: grabs sem in write mode, finds
refcount not 0, waits because --wait is specified (I assume that's
what the ... there does?).

Process A calls "get_driver_by_name("foo")" again.

Now, maybe process A should never do this.  But opening the same file
twice seems to be a similar case, no?  Maybe I need to see the rest of
the implementation.

> >This works *fine* until the object contains a function pointer to
> >inside a module: at this stage you need to make sure the module
> >doesn't disappear as well before the object is really deleted.
> 
> 	That's why open increments the module reference count,
> currently usually done via get_fops, as I'm sure you know, as I see
> you patched it to use try_module_get recently.  The module will not be
> unloaded and the storage will not be freed until the last file
> descriptor is closed, even if the device has been physically removed
> (hardware specific resources like consistent DMA memory, IRQ's, etc.
> could be released once the ->remove() function returns, but I digress).

We're fervently agreeing here I think, that, this is how it should
work.

> >Roman
> >solved this by refusing to deregister an object which was in use,
> >which isn't a really nice solution IMHO.
> 
> 	Solved what?  What was the problem?

Solved the problem of keeping explicit module reference counts (the
modules themselves did it).

> >They really are separate things, we just usually never bothered
> >refcounting our functions.  The obvious solution is to hold a
> >reference to the module as well, and that is in fact what this
> >solution does.
> 
> >Whatever else, it's conceptually simple.
> 
> 	I really do not understand what problem you're referring to.
> I believe that open() has incremented module reference counts for
> ages.  I'm not talking about eliminating or adding any calls that
> modify module reference counts, just tracking the locks that protect
> (or should protect) them and turning those locks into rw_sem's
> (really, I could have four separate lists for {rw_,}{semaphore,lock},
> but, so far, rw_semaphore seems fine for every case that I've examined).

Yes, filesystems are basically fairly clean already (nothing really
changed for them).  Filesystems are easy.  Devices are easy.

Networking is *hard*, which is why Dave and Alexey never merged any
"modularize ip" patches, and why I keep my own reference counts and
spin (potentially forever!) in ip_conntrack's cleanup code 8(

Hope that clarifies?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
