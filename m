Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317221AbSFQWnP>; Mon, 17 Jun 2002 18:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSFQWnO>; Mon, 17 Jun 2002 18:43:14 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:50386 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317221AbSFQWnN>; Mon, 17 Jun 2002 18:43:13 -0400
Date: Mon, 17 Jun 2002 17:43:11 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initcall depends
In-Reply-To: <20020618074302.1bc72b56.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206171658470.22308-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Rusty Russell wrote:

> Unfortunately, this is rather painful:
> 
> 	1) File A contains an initcall.
> 	2) Find Module A which File A is part of.
> 	3) For each exported symbol used by Module A
> 		4) Find Module B which exports this symbol.
> 		5) Find Files B which make up Module B.
> 		6) For each initcall in Files B, insert a dependency.
> 
> Any clues for (2) and (5)?

I agree that it may be painful.

Parts of a solution could be (based on yours above).

o Define KBUILD_OBJECT during the build, which contains the
  name of the module the file we're building will/would end up.

o Use that to rename the __initcall_whatever to
  __initcall__module__whatever.

o Make a symlink tree pointing to the objects that will be linked in
  (Basically $(obj-y))

o Go through the symlink tree and for all objects which export objects
  and have __initcalls, record that relation.

o For all __initcall__moduleA__ in the objects to be linked into 
  vmlinux, find the object that defines it in the symlink tree (its name
  will be moduleA.o).

o Find the unresolved symbols in that object moduleA.o.

o For each unresolved symbol in moduleA.o, if you find the symbol in the 
  previously recorded pairs of (exported symbols, __initcall__moduleB), 
  move __initcall_moduleA behind __initcall_moduleB.

Probably some issues come up when actually trying to do this, but it 
sounds doable at least in principle.

Then again, there's also the possibility of completing initramsfs, making
it mandatory, compiling things always as modules and leaving it to
"depmod" in initramfs to do the right thing.

--Kai


