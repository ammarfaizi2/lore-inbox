Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268042AbTBYQyW>; Tue, 25 Feb 2003 11:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268050AbTBYQyW>; Tue, 25 Feb 2003 11:54:22 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:5854 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S268042AbTBYQyU>; Tue, 25 Feb 2003 11:54:20 -0500
Date: Tue, 25 Feb 2003 11:04:24 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Replacement for "make SUBDIRS=...." in 2.5.63?
In-Reply-To: <200302250633.WAA06979@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0302251039080.13501-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Adam J. Richter wrote:

> 	I see that if I do something like "make SUBDIRS=net/ipv4 modules",
> I get warnings like:
> 
> *** Warning: Overriding SUBDIRS on the command line can cause inconsistencies
> *** Uh-oh, you have stale module entries. You messed with SUBDIRS

The first warning only explicitly states a fact which has always been 
true: If you hide information from kbuild by not letting it descend into 
all subdirectories (but only the ones you specified on the command line), 
you do not get a guarantee that everything is properly up-to-date.

Simple example: After "make clean", you do "make SUBDIRS=drivers vmlinux" 
- it'll break, since the final link wants to link in kernel/built-in.o, 
mm/built-in.o, ... which just don't exist.

In that case the breakage is obvious, but it can be more subtle, e.g. when 
you change CONFIG_PREEMPT and then only do "make SUBDIRS=drivers vmlinux",
the drivers subtree will be built with CONFIG_PREEMPT set one way and
the rest will still be around with CONFIG_PREEMPT set the other way. The 
end result is an inconsistent and most likely broken vmlinux. 

So basically, the SUBDIRS warning reminds you that you better know what 
you're doing, and if you don't, you shouldn't play with the internals of 
kbuild (which SUBDIRS is). BTW, an entire pass through all dirs takes only 
about 4 secs here (when there's nothing to do), so the gain you can get 
from excluding part of the tree is rather limited anyway.

> 	What is the proper way to rebuild just one subdirectory?  How
> about for building externally provided modules?  Is this is a new
> limitation of kbuild?  If so, I think it will reduce my productivity,
> and probably developer productivity on average.  I need to rebuild
> small sets of modules or core kernel subdirectories frequently.  I'd
> like to know what benefits I get from this so that I can measure
> whether this really saves me time somehow.

The proper way is "make vmlinux/modules". If you are sure that nothing 
changed outside of that directory, make SUBDIRS=... is fine, but since 
kbuild cannot know that nothing else changed (you just prohibited checking 
the other dirs), it'll give the warning.

> 	I suspect that this was added to support putting module
> dependencies into the ".ko" files, which might be underlying issue
> that needs a cost/benefit review, but perhaps there is some other
> factor that I'm just unaware of.

As I said, the warning only states what was always true. However, the
reason it was added now is that the module postprocessing step needs a
list of all modules to get symbol versioning right (and it needs to be
sure that all those modules are up-to-date w.r.t the current .config etc).

In particular, if you add SUBDIRS=... to the command line, kbuild cannot 
know about the modules which exist in other subdirectories. So for now, it 
just re-uses the list of modules from the last time and adds the modules
built in $(SUBDIRS) to that list. In this case, kbuild has no means
to verify that the modules from the old list are still up-to-date (.config 
might have changed). It's even possible that they don't exist anymore. The 
latter case is detectable, and that's when you get the "Uh-oh, you have 
stale module entries" warning.

Adding dependency information at this stage just comes for free, as does
checking for unresolved symbols, that's why it's done as well. It's the
same thing which happens when running depmod. However, while it's fine for 
depmod to run at any later time (like the next boot), the module version 
postprocessing has to happen inside kbuild to guarantee that things are
up-to-date before recording checksums. Doing modversions within depmod 
would mean that all checksums always perfectly match, which makes them
kinda pointless...

I hope that clarifies things a bit. As I wrote earlier, I'll come up with 
a proper and simple way to build external modules once I find the time.

--Kai





