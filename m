Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbTAZRew>; Sun, 26 Jan 2003 12:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbTAZRew>; Sun, 26 Jan 2003 12:34:52 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:5576 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266859AbTAZRev>; Sun, 26 Jan 2003 12:34:51 -0500
Date: Sun, 26 Jan 2003 11:43:44 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Mark Fasheh <mark.fasheh@oracle.com>
cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
In-Reply-To: <20030123193540.GD13137@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0301261054250.15538-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, Mark Fasheh wrote:

> Can't the stuff in init/vermagic.c be moved into a header file? Maybe
> vermagic.h? Most of the code can be cut 'n pasted right out of vermagic.c
> and the bit that defines "const char vermagic[]..." could be placed inside a
> macro which modules would then stick in the bottom of one of their c files.
> This is what I'm getting at (warning I haven't checked this code or even
> tried to clean it up):

Your suggestion is sensible, yet it is just an indication that you're 
using the wrong way to build your external module.

The thing is, open source projects like the linux kernel tend to move 
fast, and they don't care about changing the interfaces are the way to 
build things much, since you get the source and can recompile yourself. 
Due to that fact, all solutions which try to build modules externally are 
bound to fail sooner or later. IMO the only sensible way to overcome this 
is to accept help from the kernel build system instead of adding one 
kludge after the other to your home-made Makefile.

The kernel build provides this facility today, use the

	make -C $KERNELSRC SUBDIRS=$PWD approach 

that Sam Ravnborg pointed out. It's true that it has not been clearly 
separated how much of the kernel source tree is needed to do that, (it's 
at least include/*, .config, scripts, init/, ...) so the rule is: You need 
the entire configured kernel tree.

Now, is that so bad? When you're building kernels yourself, you obviously 
have enough room for a full tree anyway. When you're using a distribution, 
you have to install the kernel source rpm anyway, to get the headers. For 
all I know, these days the headers are not distributed separately from the 
rest of the kernel source anymore..

You might say that this is a regression w.r.t 2.4. But actually, even in 
2.4, you need e.g. Makefile and arch/i386/Makefile to figure out the 
correct flags and things for your compile, and those are not headers, 
either.

> in my_external_module.c, and init/vermagic.c I'd just do:
> #include <linux/vermagic.h>
> KERNEL_VERSIONMAGIC();

This is a good solution to this specific problem. But it does not solve 
the rest, e.g. your Makefile doesn't set -fomit-frame-pointer depending on 
CONFIG_FRAME_POINTER. It doesn't set the proper march=x86 flags. IA-64 
even needs a special flag just for modules. And it'll get even worse with 
the reintroduction of module symbol versioning.

So the above would work around this specific problem, leaving the other
more subtle ones unsolved. And if you're using modules which have been
built in such a fragile way with subtle differences, I think it's
justified to have your kernel tainted.

--Kai


