Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbSJQOub>; Thu, 17 Oct 2002 10:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbSJQOua>; Thu, 17 Oct 2002 10:50:30 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:28070 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261498AbSJQOu3>; Thu, 17 Oct 2002 10:50:29 -0400
Date: Thu, 17 Oct 2002 09:56:08 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Daniel Phillips <phillips@arcor.de>, <S@samba.org>,
       Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20021017075539.8DE762C0CA@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210170930410.6301-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002, Rusty Russell wrote:

> > But that one is easy: the zero check just takes the same spinlock as 
> > TRY_INC_MOD_COUNT, then sets can't-increment only in the case the count
> > is zero, considerably simpler than:
> 
> The current spinlock is horrible.  You could use a brlock, of course,
> but I didn't mainly because of code bloat and speed.  My current code
> looks like:
> 
> static inline int try_module_get(struct module *module)
> {
> 	int ret = 1;
> 
> 	if (module) {
> 		unsigned int cpu = get_cpu();
> 		if (likely(module->ref[cpu].live))
> 			local_inc(&module->ref[cpu].counter);
> 		else
> 			ret = 0;
> 		put_cpu();
> 	}
> 	return ret;
> }

Since I made the mistake of getting involved into this discussion lately,
I wonder if this new method is going to be mandatory (the only one
available) or optional. I think there's two different kind of users, for
one modules which use an API which provides its own infrastructure for
dealing with modules via ->owner, on the other hand things like netfilter
(that's probably where you are coming from) where calls into a module,
which need protection are really frequent.

Note that for the vast majority of modules, dealing with unload races is 
as simple as setting ->owner, for example filesystems, network drivers.

Sure, we need a global lock (unload_lock) when calling into these modules
initially, but these "binding/unbinding" calls are really rare. For
filesystems, they happen once per mount, for network drivers only for
ifconfig up/down. Afterwards, calling into the module (e.g. accessing the
mounted filesystem, xmitting/receiving data) doesn't have any overhead at
all compared to a linked-in filesystem/driver (well, ignore TLB misses)

I don't see a good reason to change this, in particular, since it provides 
useful information to the user, that is the mod_use_count. It means "Is it 
possible to successfully unload the module now?", and since looking at
the count and the actual unload is protected by unload_lock, the unload 
will either succeed basically immediately, or fail with -EBUSY right away.

I see that your approach makes frequent calls into the module cheaper, but
I'm not totally convinced that the current safe interfaces need to change
just to accomodate rare cases like netfilter (there's most likely some
more cases like it, but the majority of modules is not).

Anyway, I may see further problems, but let me check first: Is your count
supposed to only count users which are currently executing in the module's
.text, or is it also to count references to data allocated in the module?
(I.e. when I register_netdev(), does that keep a reference to the module
even after the code has left the module's .text?)

--Kai

