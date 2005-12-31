Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVLaA1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVLaA1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVLaA1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:27:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750775AbVLaA1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:27:11 -0500
Date: Fri, 30 Dec 2005 16:23:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Adrian Bunk <bunk@stusta.de>, "Bryan O'Sullivan" <bos@pathscale.com>,
       Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
In-Reply-To: <20051230234400.GM3356@waste.org>
Message-ID: <Pine.LNX.4.64.0512301559160.3249@g5.osdl.org>
References: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com>
 <adazmmmc9hl.fsf@cisco.com> <1135780804.1527.82.camel@serpentine.pathscale.com>
 <20051228145114.GL3356@waste.org> <20051230234628.GB3811@stusta.de>
 <20051230234400.GM3356@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Dec 2005, Matt Mackall wrote:
> > 
> > Where's the problem with the __HAVE_ARCH_* mechanism?
> 
> The head penguin peed on it last week.

Actually "sprkinling with penguin pee" means that something is blessed 
(it's like a kernel baptism). Maybe that's not very civilized, but hey, 
penguins don't have thumbs, and are thus kind of limited in their actions. 
Don't be speciest.

So the head penguin didn't pee on it, it turned its back in disgust, and 
hoped that it would freeze to death in the arctic winter.

And no, I don't like the __HAVE_ARCH_xxx mechanisms at all. They are 
pointless, and hard to follow. If an architecture wants to use a generic 
mechanism, it should do one of the following (or a combination):

 - use the config file mechanism, and use

	obj-$(CONFIG_GENERIC_FOO) += generic-foo.c

   in a Makefile to link in the generic version.

   Examples: CONFIG_RWSEM_GENERIC_SPINLOCK.

 - just include the generic header from its own header, eg just do a

	#include <asm-generic/div64.h>

   or similar.

Now, the latter in particular is very easy to follow: if you look into the 
<asm/div64.h> file and see that it just includes <asm-generic/div64.h>, 
it's very obvious what is going on and where to find the real 
implementation. You never have to wonder what the indirection means. 

Similarly, anybody that fixes the generic header file can _trivially_ grep 
for its use. So the code stays clean, and there are absolutely zero 
compile-time conditionals, and the linkages both ways are obvious. And 
architectures that do _not_ use the generic routines are totally 
unaffected by them, and they don't need to specify any flags like "I have 
my own routines" to disable things.

Now, the CONFIG_GENERIC_FOO thing is a bit less obvious, and you may have 
to know about that config option in order to realize that a particular 
architecture is using a generic library routine, but at least with those 
Kconfig options, the language to describe them is clean these days, and 
it's _the_ standard way to express configuration information. So it may be 
a bit subtler and more indirect, but once you get used to it, it too is 
very clean.

In contrast, the __HAVE_ARCH_xxx thing has zero upsides. It just causes 
#ifdef mess in C source files, and unnecessary noise in standard header 
files. I know it's been there for a long time, but just grep for 
__HAVE_ARCH_MEMCPY and cry. Why the hell should all the architectures that 
have their own optimized memcpy() have to tell the rest of the world about 
it?

[ Yeah, I know why: bad implementation choice. It could easily have been 
  done with the asm-generic approach or CONFIG_GENERIC_MEMCPY, but it 
  wasn't. Note that the __HAVE_ARCH_xxx thing isn't even a standard form: 
  sometimes it's the negation: __ARCH_WANT_xxx, and sometimes it's called
  something else entirely, like USE_ELF_CORE_DUMP or HAVE_PCI_MMAP, or
  ARCH_HAS_PREFETCH or HAVE_CSUM_COPY_USER. My point being that it's 
  totally ad-hoc and random. ]

So we do have tons of ugly stuff, I just am trying to argue for not making 
more of it (I don't think it's a big enough deal that it would be worth it 
trying to clean up old uses).

If you look at the mutex patches, for example, I think everybody will 
agree that they look much _better_ after they moved to just using the 
trivial "#include <asm-generic/mutex-xyzzy.h>" format. At least I don't 
_think_ this is just a personal weird hang-up of mine. It's literally a 
cleanliness issue.

			Linus
