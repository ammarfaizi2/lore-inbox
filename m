Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269743AbSISCBz>; Wed, 18 Sep 2002 22:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269745AbSISCBz>; Wed, 18 Sep 2002 22:01:55 -0400
Received: from dp.samba.org ([66.70.73.150]:26754 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269743AbSISCBv>;
	Wed, 18 Sep 2002 22:01:51 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Thu, 19 Sep 2002 00:59:37 +0200."
             <Pine.LNX.4.44.0209182313360.8911-100000@serv> 
Date: Thu, 19 Sep 2002 11:00:23 +1000
Message-Id: <20020919020654.9B68E2C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209182313360.8911-100000@serv> you write:
> Hi,
> 
> On Wed, 18 Sep 2002, Rusty Russell wrote:
> 
> > 	I've rewritten my in-kernel module loader: this version breaks
> > much less existing code.  Basically, we go to a model of
> > externally-controlled module refcounts with possibility of failure
> > (ie. try_inc_mod_count, now called try_module_get()).
> 
> You add a lot of complexity in an attempt to solve a quite simple problem.
> I agree that the module load mechanism could be simplified, but why do you
> want to do it in the kernel?

Count the total lines of code in the kernel.  It's less than it was
before.  Even for ia64, it's around the same IIRC.

Now add the userspace code, and it's obviously far simpler.  Not to
mention not having to worry about problems like insmod dying between
the two system calls...

I'm all for keeping things out of the kernel, but you can take things
too far.  I was originally reluctant, but the beauty and simplicity of
doing it in-kernel changed my mind.

> Some general module management in userspace
> is needed anyway and all you save is a single call to the kernel.

Huh?  Think about initramfs's insmod code.  Think about busybox.  Look
at my insmod code.

Sure, *modprobe* has some complexity to it, but a simple insmod is
trivial.

> Most of the module related changes are rather cosmetic. You still have to
> spread try_module_get() calls all over the kernel, one has to call it
> before calling a function which might sleep, this means we will add it
> everywhere just to be save.

Yes.  It should be added everywhere.  One idea is to mark interfaces
which are "safe", and if a module uses something else, refuse to
unload it.

> What makes it worse is that it's not generally usable, a per object
> reference count can also be used for module management, but the
> module count can't be used for object management. This means for
> modules with more dynamic interfaces, they have to do twice as much
> work.

Yes, you force reference counts in everything, whether you've got
modules (or module unloading) or not.  You *do not* want to do this,
for performance reasons if nothing else.

> I can only refer to my own patch again, which has most of the basic things
> needed to sanely get out of this mess:
> 
> 1. Allow module exit to fail. This gives modules far more control over
> module management and the generic module code can be simplified.

I really like this, myself (although I did it in two stages in my
earlier implementation, it's the same principle).  I could use it
really nicely.  You could use it really nicely.  I can name a dozen
more that would get it right.

<Sigh>

Unfortunately, saying "you must understand module races to write a
module" is not realistic 8(.  Look at this code for an example of
understanding of current modules among kernel developers: (lib/crc32.c):

/**
 * init_crc32(): generates CRC32 tables
 * 
 * On successful initialization, use count is increased.
 * This guarantees that the library functions will stay resident
 * in memory, and prevents someone from 'rmmod crc32' while
 * a driver that needs it is still loaded.
 * This also greatly simplifies drivers, as there's no need
 * to call an initialization/cleanup function from each driver.
 * Since crc32.o is a library module, there's no requirement
 * that the user can unload it.
 */
static int __init init_crc32(void)
{
	int rc1, rc2, rc;
	rc1 = crc32init_le();
	rc2 = crc32init_be();
	rc = rc1 || rc2;
	if (!rc) MOD_INC_USE_COUNT;
	return rc;
}

> 2. The new module layout simplifies module loading, much more than
> relocating isn't necessary, but keeps backward compability as long as
> necessary. This means new modules can be loaded with old modutils and
> modules using the old interface can be kept working for a while.

The backwards compatibility issue is simple to handle in userspace:
try sys_query_module, and exec insmod.old if it doesn't give ENOSYS.

Sure, I'm lazy, but I'll release a 0.4 which does that I promise 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
