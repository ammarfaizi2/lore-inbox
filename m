Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316899AbSFVVIq>; Sat, 22 Jun 2002 17:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316902AbSFVVIq>; Sat, 22 Jun 2002 17:08:46 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:55019 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316899AbSFVVIp>; Sat, 22 Jun 2002 17:08:45 -0400
Date: Sat, 22 Jun 2002 16:08:45 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Diego Calleja <diegocg@teleline.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: piggy broken in 2.5.24 build
In-Reply-To: <20020622225229.46805a91.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.44.0206221557330.7338-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2002, Diego Calleja wrote:

> I compiled 2.5.24, with make dep, make bzImage, make modules....
> After that, as usually, make dep; make bzImage ...doesn't change nor
> recompile anything After that, I changed an option with menuconfig,
> "VGA 16-color graphics console support",and "3DFX Banshee/Voodoo 3
> display support" (because i can't see somethnig when i boot with it)
> from built-in to module. Then I run make dep; and it did make some small
> changes, as expected.
> 
> 
> Then make bzImage compiled the entier kernel again, or at less a big big
> part of it, not only the changes made in menuconfig. make modules
> recompiled things again, wich are not affected with the changes (ie:
> iptables modules).
> 
> My questions is:
> 
> It's not expected to do the same as 2.4 kernels, i mean, recompile only
> the changes made, not the entire thing?

If you toggled VGA 16-color support, that adds or removes the symbols
from fbcon-vga-planes.c to the list of export symbols.

After the toggle, make dep detects that and adapts 
include/linux/modversions.h accordingly.

Now, if you "make" again, all files which include/linux/modversions.h need 
to be rebuilt, since it changed. And that's a lot of files, as you've 
noticed. The problem is that in reality, only a file which also *uses* one 
of these exported symbols really changes. But make cannot know that, so it 
recompiles everything which is possibly affected.

There's no easy way out from that, what you can of course do is turning 
off CONFIG_MODVERSIONS - in that case you'll see that only very little 
will be affected and rebuilt.

The fact that 2.4 recompiles little even in that case is since kbuild 
there has bugs in it which lead to it forgetting to recompile files 
(sometimes eventually resulting in "unresolved symbols in ...", which can
only be cured with make mrproper).

For the current kbuild, you should never need to do make mrproper, it 
should always recognize changes and rebuild what's necessary.

> PD: What are you doing with kbuild 2.5? What parts are you integrating?
> Wich parts you aren't going to integrate?

I'm currently still doing small bits, shipped files, asm-offsets 
generation and the like. I'm also preparing for separate build / src tree, 
which makes the current Makefiles and kbuild-2.5's Makefile.in's basically 
equivalent information-wise (though not syntactically).

If switching to kbuild-2.5's preprocessing phase will be necessary or make 
sense I do not even know myself yet. So some more patience is needed 
there.

--Kai


