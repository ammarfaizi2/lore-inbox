Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTBDIAN>; Tue, 4 Feb 2003 03:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbTBDIAN>; Tue, 4 Feb 2003 03:00:13 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:3766 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267156AbTBDIAG>; Tue, 4 Feb 2003 03:00:06 -0500
Message-Id: <200302040805.h1485lhI002898@eeyore.valparaiso.cl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, greg@kroah.com, jgarzik@pobox.com
Subject: Re: [PATCH] Module alias and device table support. 
In-Reply-To: Your message of "Mon, 03 Feb 2003 21:52:45 +1100."
             <20030203105342.15D152C056@lists.samba.org> 
Date: Tue, 04 Feb 2003 09:05:46 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> said:
> In message <200302030831.h138VZ4p011397@eeyore.valparaiso.cl> you write:
> > Rusty Russell <rusty@rustcorp.com.au> said:
> > > Well, "modprobe foo" will only give you the "new_foo" driver if (1) the
> > > foo driver isn't found, and (2) the new driver author decides that
> > > it's a valid replacement.
> > 
> > So the alias only works if the original isn't found?
> 
> It's defined to be that way for aliases taken from the modules
> themselves, for this very reason: the admin has no control over it.

That's exactly what bothers me. This gives several ways to go to the same
place, and the rules of which one applies when _will_ confuse your friendy
local BOFH (who does 237 other things besides messing with modules).

> It's undefined for the "in the config file case" (they curently *do*
> override, but that's an implementation detail).  It'd be clearer to
> explicitly say "you can't override module names with "alias", use
> "install" instead, IMHO.

Urgh. What is "alias" then for? It has been used for ages as a way of "call
module foo by name bar, possibly with this further arguments". Why change
that gratuitously?

> > Weird... I'd just
> > rename the dang thing and get over it. A distribution kernel won't be able
> > to use this anyway, as they'll either build both alternatives or just one
> > of them and adjust configuration to match.

> I'm not so sure.  There have been several cases where a more than one
> driver supports the same card, but the old one is kept around "just in
> case".  Backwards compatibility during such a transition would be
> really nice.

Yep. foo --> old-foo, (new) foo is ... foo! ;-)

Or just like today: foo stays foo, new foo is nfoo. When (if) nfoo ends up
stable enough, and works everywhere, and can be taken as an all-around
replacement for old foo, old foo gets the axe (eventually). AFAIR, there
has never been a case of "new driver works everywhere, period" that was not
just a replacement for the old one. If you have both around, you _don't_
want the driver author(s) deciding which one to call foo.. If there is just
one, no problem.

> In most cases the admin, not the dist ribution, is the one setting the
> module options: losing them when you upgrade the kernel is not good.

Exactly. The admin won't be messing around with MODULE_ALIAS macros for a
random collection of modules everytime she downloads latest-n-greatest, but
she will certainly check /etc/modules.conf (just as today); she won't want
to recompile the distribution kernel just to fix wrong aliases. People
backward compatibility and minimal upgrading pain (to get your random BOFH
to recompile a kernel is _not_ trivial today!) is much more important than
code backward compatibility, IMHO. [I'm speaking from the perspective of
the user/sysadmin, _not_ the kernel hacker here].

> > > Whether (2) is ever justified, I'm happy leaving to the individual
> > > author (I know, that makes me a wimp).

> > Don't trust authors too much when it comes to guessing at random individual
> > installations... ;-)

> Well, true, but if they don't, there's a deeper problem.

Wellcome to the real world. There are literally thnousands of different
configurations out there. I wouldn't dare cast any part of the
configuration in binary for use everywhere.

> > > Consider another example: convenience aliases such as char-major-xxx.
> > > Now, I'm not convinced they're a great idea anyway, but if people are
> > > going to do this, I'd rather they did it in the kernel, rather than
> > > some random userspace program.

> > The module munging programs and their configuration are (logically) a part
> > of the kernel (configuration). So this goes against the current wave of
> > exporting as much as possible from the kernel.

> Well, one major point of the module rewrite is that kernel internals
> belong in the kernel sources.  If you disagree with that, we're
> probably not going to make progress.

Kernel internals yes; kernel configuration no. Several different ways of
doing the same thing, with subtle overridings and invisible/out of reach
parts is no-no-no in my book.

[...]

> > Maybe I'm just being a bit too conservative here. But I still think this is
> > too dangerous for little (or even no) real gain.
> 
> Possibly.  However I beg you to consider how you would introduce a new
> cypher into 2.6.3.

How were new cyphers added in 2.5.x recently? No need for strange aliases
in-kernel, they get integrated via API. Outside the kernel, leave it to the
sysadmin, explicitly. If such an addition is done, I'd want to control the
use of the new cypher myself (because I don't upgrade all machines at the
same time, whatever), not just getting it suddenly used everywhere when I
mention "cypher", and I get to run around in circles trying to find out why
shiny new A isn't talking to old B anymore.

> > Could you please provide examples of use in generic, distribution kernels?
> > Contrast with configuration in /etc/modules.conf and/or modprobe (I think
> > placing this stuff in modprobe is wrong, but that is the way it is today). 
> 
> Ignoring the hotplug stuff which is going to use it, consider adding a
> new binary format for XYZ3000 compatibility.  For 2.4, you have to do:
> 
> 	1) Write the new binfmt_XYZ3000 module.
> 
> 	2) Write a patch to the modutils to place it in the built-in
> 	   modules config.  Keith's quite receptive with this.
> 
> 	3) Tell your users to upgrade modutils or place "alias
> 	   binfmt-764 binfmt_XYZ3000" in their /etc/modules.conf (or
> 	   /etc/modprobe.d/local for Debian).
> 
> For 2.5:
> 	1) Write the new binfmt_XYZ3000 module.
> 
> 	2) Place MODULE_ALIAS("binfmt-764") at the bottom.
> 
> Hope that clarifies?

Yep. But (a) How often does this happen? Which other areas could benefit? 
(b) $BIG_DISTRIBUTION_VENDOR is quite capable of distributing
/etc/modules.conf or modutils with the change; kernel hackers are used to
this kind of change (no, I haven't seen Aunt Tillie lately).


Seems we will always disagree :(
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
