Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTI2Vgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTI2Vgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:36:50 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:53647 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262986AbTI2VgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:36:07 -0400
Date: Mon, 29 Sep 2003 23:36:06 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Brian Gerst <bgerst@didntduck.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -mregparm=3 (was  Re: [PATCH] i386 do_machine_check() is redundant.
In-Reply-To: <20030929202604.GA23344@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org>
 <1064775868.5045.4.camel@laptop.fenrus.com> <Pine.LNX.4.58.0309292214100.3276@artax.karlin.mff.cuni.cz>
 <20030929202604.GA23344@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Sep 2003, Daniel Jacobowitz wrote:

> On Mon, Sep 29, 2003 at 10:20:45PM +0200, Mikulas Patocka wrote:
> > > > > Use machine_check_vector in the entry code instead.
> > > >
> > > > This is wrong. You just lost the "asmlinkage" thing, which means that it
> > > > breaks when asmlinkage matters.
> > > >
> > > > And yes, asmlinkage _can_ matter, even on x86. It disasbles regparm, for
> > > > one thing, so it makes a huge difference if the kernel is compiled with
> > > > -mregparm=3 (which used to work, and which I'd love to do, but gcc has
> > > > often been a tad fragile).
> > >
> > > gcc 3.2 and later are supposed to be ok (eg during 3.2 development a
> > > long standing bug with regparm was fixed and now is believed to work)...
> > > since our makefiles check gcc version already... this can be made gcc
> > > version dependent as well for sure..
> >
> > They are still buggy. gcc 3.3.1 miscompiles itself with -mregparm=3
> > (without -O or -O2 it works). (I am too lazy to spend several days trying
> > to find exactly which function in gcc was miscompiled, maybe I do it one
> > day). gcc 2.95.3 compiles gcc 3.3.1 with -mregparm=3 -O2 correctly.
> > gcc 3.4 doesn't seem to be better.
> >
> > gcc 2.7.2.3 has totally broken -mregparm=3, even quite simple programs
> > fail.
>
> You can't build GCC with -mregparm=3.  It changes the interface to
> system functions.  So unless your libc happened to be built with
> -mregparm=3, and extensively hacked to expect arguments in registers to
> the assembly stubs, it can't work.

Of course I linked it with libc compiled with regparm=3.

> It's interesting for kernel code, whole distributions, or things which
> are careful to have a glue layer.

BTW. libc headers surround all function parameters with __P, like
extern int printf __P ((__const char* __format, ...));

so you can change in include/sys/cdefs.h
#define __P(x) x
into
#define __P(x) x __attribute__((regparm(0)))

and compile programs with -mregparm=3 -ffreestanding even on normal linux
distribution. I didn't try it for larger program, for simple it works. (it
works as long as program doesn't call libc function via pointer to
function).

(without -ffreestanding gcc sometimes emits calls to library functions on
its own, and uses calling convention from command line, not convention
from prototype).

Mikulas
