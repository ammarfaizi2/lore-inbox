Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317669AbSGZKJH>; Fri, 26 Jul 2002 06:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317670AbSGZKJH>; Fri, 26 Jul 2002 06:09:07 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:2823 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317669AbSGZKJG>; Fri, 26 Jul 2002 06:09:06 -0400
Date: Fri, 26 Jul 2002 12:12:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] new module interface 
In-Reply-To: <20020726034921.368CE4575@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0207261109470.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 26 Jul 2002, Rusty Russell wrote:

> > I introduced usecount() to gain more flexibility, currently one is forced
> > to pass the module pointer everywhere.
>
> Well, you substituted the module pointer for an atomic counter.  Bit
> of a wash, really.

Converting the module pointer into a counter is the easiest way to convert
to the new interface. Behind that is a very important concept - complete
seperation of module state management (done in kernel/module.c) and module
usage management (done by the module). Both are independent in my patch,
so the module has complete freedom how to do the later. This means it
doesn't has to use a counter, the usecount function could be as well
something like "return busy ? 1 : 0;" and the module won't be bothered
with unloading. On the other hand if a module needs something more
complex, it can do so without bothering the remaining the module code
(e.g. if I look at the LSM hooks, I'm really not sure how to sanely unload
a module from that).
We get this flexibility only by removing the usecount from the module
structure. As long as that usecount is used for synchronisation, we have
to pass around the module pointer everywhere to get to that damned
usecount.

> > I was thinking about it, but couldn't we just put these function in a
> > seperate section and discard them during init (maybe depending on some
> > hotplug switch)?
>
> No, if you drop them newer binutils notices the link problem, hence
> the __devexit_p(x) macro.

AFAIK we have that problem if we discard the sections immediately at link
time, but we could also discard them at kernel init. On the other hand I'm
not completely against wrapping the field initialization in a macro.

> > Not yet. The problem is the module name, e.g. ext2 is called
> > fs_ext2_super, it will need some kbuild changes to get the right module
> > name.
>
> I need that too: the mythical "KBUILD_MODNAME".  Both Keith and Kai
> promised it to me...

I found a solution for that yesterday. :)

I looked at your patch and some interesting parts are missing, so it's
difficult to comment. It's really small, but it also has lots of FIXMEs. :)
My module pointer comment above applies to your patch as well. Since
module unloading isn't implemented yet, it's difficult to say how you want
to avoid the races.
One thing I mentioned earlier is that I still think that module linkage
is better done in user space, if we also keep all the symbol and
dependency information in user space. Insmod just had to relocate the
module and the kernel only needs the pointer to the module structure and
finds the rest through it, so no adding of new sections/symbols or
initialization of the module structure would be required, so insmod hadn'

BTW I also looked at the automatic initcall generation script, I think I
have a solution for a big part of the problem, that would at least allow
to order the init calls of all normal modules. (Patches are coming
hopefully soon. :) )

bye, Roman

