Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSFQBR6>; Sun, 16 Jun 2002 21:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSFQBR6>; Sun, 16 Jun 2002 21:17:58 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:6863 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316662AbSFQBR5>; Sun, 16 Jun 2002 21:17:57 -0400
Date: Sun, 16 Jun 2002 20:17:44 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initcall depends
In-Reply-To: <E17JkO6-0000nW-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206162007160.30474-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Rusty Russell wrote:

> Linus, please apply (thanks to Peter Moulder for script tweaks).
> 
> Lack of response clearly means everyone thinks this is a brilliant
> idea.  They're right 8)
> 
> Name: initcall depends
> Author: Rusty Russell, Peter Moulder
> Status: Tested in 2.5.21
> 
> D: Introduces initcall(function, name [, dependencies ]).  Dependencies
> D: are: init_after(name), init_before(name) and init_as_part_of(name).
> D: Replaces all the core_initcall, subsys_initcall etc, with three
> D: more general systems: "mm_initcalls", "bus_initcalls" and
> D: "driver_initcalls", which the other initcall define their orders in
> D: terms of.  The old __initcall is supported, and link order still
> D: controls their invocation order (after driver_initcalls are
> D: finished).

As you're taking the effort of running some code to figure out the right 
ordering anyway, have you considered using the the information which is 
already there today, for all code which can be compiled modular.

For example, say I have the driver for the Fritz!PCI ISDN card. It depends 
on the protocol driver for passive cards (hisax) being already 
initialized, and hisax depends on the ISDN layer already being 
initialized.

If these three units are compiled modular, the right init order will be 
enforced by the fact that I can only load isdn.o, then hisax.o, then 
hisax_fcpcipnp.o in that order. That's because hisax.o needs
register_isdn() which is exported by isdn.o and hisax_fcpcipnp.o needs
register_hisax() which is exported by hisax.o.

And there's even a program which figures out the right order, that's 
modprobe/depmod.

That doesn't help for all the early internal init cases, but for the huge
fraction of modularized code, the info is there, though not taken
advantage of.

--Kai


