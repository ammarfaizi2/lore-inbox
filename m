Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbSKZD7m>; Mon, 25 Nov 2002 22:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbSKZD7m>; Mon, 25 Nov 2002 22:59:42 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:9395 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266356AbSKZD7i>; Mon, 25 Nov 2002 22:59:38 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 25 Nov 2002 20:06:41 -0800
Message-Id: <200211260406.UAA22079@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Modules with list
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>In message <200211252211.OAA02085@baldur.yggdrasil.com> you write:
[...]
>> 	4. failureless raceless module unloading by the module->rwsem_list
>> 	   system that I described toward the bottom of this message:
>> 	   http://marc.theaimsgroup.com/?l=linux-kernel&m=103773401411324&w=2

>OK, I've read this in detail now.  It's a fine scheme, but the devil
>is inside here:

>struct device_driver *
>get_driver_by_name(struct bus_type *bus_type, const char *name)
>{
>	down_read(&bus->rwsem);

>Now, that's perfectly fine for drivers, but try doing that on every
>network packet.

	You're looking up a driver by name or incrementing a module
reference count on every network packet?  Where?  Show me, please.
I find it hard to believe that that is necessary.  As far as I
can tell, nothing calls the only thing that is remotely performance
critical that increments module reference counts are open(2)/close(2),
and they do generally do many heavier operations that grabbing an
rwsem.

[...]

>BTW,

>>	2. try_module_get() introduces new failures that other software
>> has to anticipate.  For example, if I try to mount an ext3 file system
>> and it happens that ext3 was being automatically removed (for lack of
>> use) at this time, the attempt to get the ext3 filesystem can fail
>> without request_module() being called to reload it.

>No.  What you're missing is that there is a bogolock inside
>try_module_get().  Think of it as a rwlock.

	I don't know exactly what you mean by a bogolock (some
reference to local_inc or your per-CPU reference counts?).  However,
what you seem to miss is that the lock has to bracket a little more
code than just the inside of try_module_get.

	With your scheme, you really do have unnecessary failures.
For example, the system really can tell you that the iso9660
filesystem is not found when, in fact, there is a module for it
(because you asked at just the wrong moment, when it was being
unloaded).

[...]
>> 	4. This kind of race is not really specific to modules, although
>> they may be the only example that comes up in practice.

>Your code here seems flawed.  You grab the write sem(s) in the remove
>code to prevent anyone bumping the refcount.  If someone is recursing
>(trying to grab another refcount while already holding one), you
>*must* fail them, otherwise you'll deadlock.

	No, the point is that these rwsem's do not just lock the
try_module_get() call.  They lock a slightly larger section of code,
so that the other process will block when it attempts to look up the
resource containing the module pointer by name.  In your example, the
module unload will complete, the other process will then be allowed to
continue, and it will discover that whatever driver it was asking
about is not currently loaded (for example, the iso9660 filesystem is
not found, and it will run modprobe to reload it).

>>	4. This kind of race is not really specific to modules, although
>> they may be the only example that comes up in practice.

>Actually, it is.  For years, the networking code has used refcounts
>and two-stage delete almost everywhere: it's now well accepted as an
>orthodox method.  So when you "unregister" a socket etc, it removes
>the element from lists, and decs the refcount.  Whoever decs the
>refcount to zero frees it up (it's assumed that it will monotonically
>decrease to zero, since there are no external references any more).
>You know this already, of course.

	Yes.  I talked about it regarding my patch for adding code in
drivers/base/ to kmalloc the fixed block of private memory for device
drivers.  I think it's a good model for any kind of device that a file
descriptor can have open.

>This works *fine* until the object contains a function pointer to
>inside a module: at this stage you need to make sure the module
>doesn't disappear as well before the object is really deleted.

	That's why open increments the module reference count,
currently usually done via get_fops, as I'm sure you know, as I see
you patched it to use try_module_get recently.  The module will not be
unloaded and the storage will not be freed until the last file
descriptor is closed, even if the device has been physically removed
(hardware specific resources like consistent DMA memory, IRQ's, etc.
could be released once the ->remove() function returns, but I digress).

>Roman
>solved this by refusing to deregister an object which was in use,
>which isn't a really nice solution IMHO.

	Solved what?  What was the problem?

>They really are separate things, we just usually never bothered
>refcounting our functions.  The obvious solution is to hold a
>reference to the module as well, and that is in fact what this
>solution does.

>Whatever else, it's conceptually simple.

	I really do not understand what problem you're referring to.
I believe that open() has incremented module reference counts for
ages.  I'm not talking about eliminating or adding any calls that
modify module reference counts, just tracking the locks that protect
(or should protect) them and turning those locks into rw_sem's
(really, I could have four separate lists for {rw_,}{semaphore,lock},
but, so far, rw_semaphore seems fine for every case that I've examined).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
