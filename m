Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261803AbTCQRdR>; Mon, 17 Mar 2003 12:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261812AbTCQRdQ>; Mon, 17 Mar 2003 12:33:16 -0500
Received: from dp.samba.org ([66.70.73.150]:32475 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261803AbTCQRdL>;
	Mon, 17 Mar 2003 12:33:11 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Patrick Mochel <mochel@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Werner Almesberger <wa@almesberger.net>
Cc: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.name>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PCI driver module unload race? 
In-reply-to: Your message of "Tue, 11 Mar 2003 09:27:27 MDT."
             <Pine.LNX.4.33.0303110916540.1003-100000@localhost.localdomain> 
Date: Mon, 17 Mar 2003 00:05:51 +1100
Message-Id: <20030317174406.9ABE42C26D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0303110916540.1003-100000@localhost.localdomain> you 
write:
> The driver has an unload_sem that is locked until the driver's refcount 
> goes to 0. When it does, it's unlocked. A driver_unregister() call will 
> try and take this semaphore while unregistering, meaning it will block 
> until outstanding references go away. 

That sounds like an odd way of doing it.  More normal would be either
a rw lock of some kind (ie. always hold read when calling through
functions), or if recursion is a worry, a lock, an atomic reference
count, and a "who is waiting for it to be unloaded" task ptr.  As one
example, see net/core/netfilter.c: nf_unregister_hook uses a br_lock,
nf_unregister_sockopt uses the refcount approach.

Any way it's done, the effect is the same: deregisteration sleeps
until the object is unused.

> I don't particularly love it, but it's simple enough and it works.  
> Ideally, we'd have one reference count and this wouldn't be an issue.  
> However, with the evolution of the driver core and the module core in 2.5,
> these details haven't had a chance to be worked. I hope in 2.7, we can
> achieve more unification between the two. 

Unfortunately, I think that will require changing every module *and*
every registration function, and noone has produced a reasonable model
which has the "unload only if noone is using the module" semantics
(which requires atomic "deactivation" of interfaces, like
try_module_get).

Currently, if you go for a full dynamic interface (ie. can be
unregistered and structures destroyed at any time, not just on module
unload), you don't have a race, but you don't bump module refcounts
which users expect (ie. module appears "unused" and hangs on rmmod),
which can be a problem depending on the interface (mainly whether the
rmmod hang would be infinite).

If you just use a module pointer and try_module_get, the interface
can't be safely used in *general* (Werner's "unregister_xxx then
kfree(xxx)" problem), but as long as the lifetime of the objects are
tied to module lifetime (as many are), it works.

Yes, this means some code has to do both.  But it's simple, doesn't
significantly effect code using the interface, and is easy to rip out
when Something Better comes along.

> Greg, and Rusty, are right. Dealing with this is a PITA, and I think will 
> always be. I'm willing to take the Nancy Reagan platform, too. 

And another reason that I like the "easy to remove" nature of
try_module_get, for all its flaws.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
