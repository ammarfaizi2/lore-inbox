Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSG1Vz7>; Sun, 28 Jul 2002 17:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSG1Vz7>; Sun, 28 Jul 2002 17:55:59 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:28586 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317355AbSG1Vz5>; Sun, 28 Jul 2002 17:55:57 -0400
Date: Sun, 28 Jul 2002 16:59:14 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: [PATCH] automatic initcalls 
In-Reply-To: <20020728033359.7B2A2444C@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0207281633110.31099-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002, Rusty Russell wrote:

> In message <3D430123.739CA34D@linux-m68k.org> you write:
> > - I only look at modules which contain an initcall
> > - I only order initcalls of level 6 and 7
> 
> You don't seem to handle the ordering of initcalls within a module
> though: see net/ipv4/netfilter/ip_conntrack.o for an example of
> multiple inits which would be much better as separate initcalls.

I'm not at all familiar with this code, but traditionally there is only 
one initcall per module - extending this to multiple initcalls with 
automated unwinding if one of those fails may be something to look into, 
but I don't think it has much to do with the current discussion (I doubt 
your patch does the unwinding, does it?)

> The more I play with these magic approaches, the more I prefer an
> explicit "Must be done after this" and "must be done before this":
> otherwise we're going to need to keep adding new levels as we discover
> something that doesn't fit in the magic 7.
> 
> Especially since you don't cover any of the really interesting cases.
> Maybe if you could slowly extend it to cover the rest?  (Hah, I
> know!).

I think when I commented on your initial patch, I said that I would make 
sense to use the existing ordering information where available, but it 
surely doesn't solve all the world's problems, so your patch would help a 
lot in cleaning up the ordering of the early initcalls of not modularized 
parts of the kernel.

For modules, it's obvious that we cannot insmod a module unless it's 
unresolved symbols can be resolved, i.e. the code which provides them has 
to be compiled-in or a module providing them has been loaded before. This 
is also the only way to determine the order of loading modules we have, so 
we guarantee that once all unresolved symbols are made available, all 
necessary initializations have run - most people probably don't think of 
it this way, because it comes natural anyway.

My point was that I don't think it's necessarily a good idea to duplicate 
this info - hisax.o (an ISDN hardware driver) needs "register_isdn()", 
which is provided by isdn.o. Insmoding isdn.o will of course also run the 
necessary initializations for making register_isdn() ready to be called 
from driver modules. It has to remain this way, since otherwise insmoding 
modules in the wrong order would crash the kernel. Now, in your scheme you 
would add an dependency like
	__initcall(hisax_init, initcall_after(isdn_init))
which duplicates this info. Which, as all duplicated info is redundant and 
has the potential for getting out of sync, different behavior for built-in 
vs. modular, etc.

On the other hand, we have complicated ordering during init, like 
(probably wrong as I put it, but you get the picture):

	pci_driver_init()
	pci_pcibios_init()
	pci_direct_init()
	pci_legacy_init()
	acpi_pci_init()
	pci_init()

These parts are not modularized, so the argument above doesn't help. Here, 
I think it would be a great improvement to be able to give dependencies on 
what has to be run when explicitly.

So the ideal solution would, IMO, look like:

Replace the __initcall levels by two constructs:
o __initcall(foo_init, init_after/...)
o module_init()

The __initcalls are called first, in the order explicitly given. Only
then, the functions declared as module_init() would get called, in an
order determined by the dependencies on exported symbols - i.e. that would
be comparable with compiling them as modules and insmoding them in just
this order.

I didn't have the time to look at the patches in depth yet, but it looks 
like we've got the two pieces and just have to put them together.

--Kai




