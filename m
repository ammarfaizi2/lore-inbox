Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVCET2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVCET2M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVCET0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:26:49 -0500
Received: from chaos.sr.unh.edu ([132.177.249.105]:53896 "EHLO
	chaos.sr.unh.edu") by vger.kernel.org with ESMTP id S261152AbVCESuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:50:05 -0500
Date: Sat, 5 Mar 2005 13:48:50 -0500 (EST)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Adrian Bunk <bunk@stusta.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>,
       <keenanpepper@gmail.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
In-Reply-To: <20050305171556.GE6373@stusta.de>
Message-ID: <Pine.LNX.4.44.0503051314190.22005-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's usually solved through #define's (see e.g. lib/extable.c).

Well, you can obviously solve pretty much everything with #define's, but 
it's usually also the ugliest solution.

>From my point of view, the preferences for solving issues like the 
extable.c one are:

o Do it automatically. If the architectecture defines its own version, use
  that one -- otherwise use the default.
o Take care of it by configuration options.
  Let the arch have CONFIG_GENERIC_EXTABLE_SORT (or not), and use that to
  determine whether to compile / link sort_extable()
o Use a #define / #ifdef in the source file to conditionally compile 
  things.

Having a config option has the advantage that one can do

	obj-$(CONFIG_GENERIC_EXTABLE_SORT) += extable_sort.o

which leaves the source code free of ugly #ifdef's. Obviously that only 
works if extable.c is split into extable_sort.o and extable_search.o. If 
one goes that step (fine IMO), one can however just add these files to 
lib-y, i.e. use the first solution - everything happens automatically, no 
need for ARCH_ defines, no need for new CONFIG options.

> It's used by many filesystems plus some optional part of the USB code.
> 
> Basically, there are two choices:
> - always include a function
> - include a function only if required
> 
> The second one is possible, but object files are the wrong granularity - 
> why should it pull the whole parser.c if only match_strdup was required?

Yes, object files are not necessarily the right granularity -- in fact, 
traditionally libraries are composed of object files which pretty much 
follow a "one function per file" principle, to get this right.

However, two cases should be distinguished:

o providing a default implementation. Obviously, this one needs separate 
  files for separately needed units (like the extable.c example above)
o providing a library functionality. Grouping multiple functions together
  isn't necessarily wrong, it just may cause slight inefficencies (pulling
  in unneeded code). I really don't think we want to go to one function 
  per file but rather leave things grouped as they currently are. If 
  someone needs match_strdup, they'll pull in all of parser.o.

> You have all possibilities with #define's.

Yes, but also all the ugliness. There's a trade-off where the optimal 
smallest binary kernel image comes with a bloated, unreadable, full of 
'#ifdef' kernel source. Noone wants that. If you can optimize the binary 
kernel image in some automated way with little impact on the source code, 
that's fine. Otherwise, you'll give up a little space savings for easier 
maintainability.

> If you care about code size, CONFIG_PARSER gives the wrong granularity.

Going more fine-grained is out of the question, IMO. If anything, going 
less fine-grained, i.e. include all of parser.o unconditionally is the way 
to go here. Currently, the only more fine-grained way would be to have 
ext2 in KConfig CONFIG_MATCH_INT, CONFIG_MATCH_TOKEN. FAT would define
CONFIG_MATCH_INT, CONFIG_MATCH_TOKEN, CONFIG_MATCH_OCTAL, etc. That's 
insanity.

> Everything lib-y does can be done with obj- and #define's.
> And this way, it's done explicit.

That's true. But more often than not, we don't care about explicitness,
we care about cleanliness and readability. The ugliness is hidden 
somewhere, in includes, in Kconfig, in the build system. "module_init()" 
is very non-explicit, it does completely different things depending on 
whether a file is compiled into a module or the kernel. But we sure prefer 
the cleanliness of module_init() over having #ifdef's in each module which 
explicitly what happens.

As I said it's all a trade-off, and it has much to do with taste. Code 
looking clean is important. However, hiding too much and jumping through 
hoops just so that something looks clean while all the magic happens 
somewhere deep inside unbeknowst to all but few gurus isn't right, either.

This discussion doesn't really have much to do with the original issue 
anymore. Move parser.o to obj-y and be done with it -- in reality everyone 
needs it, anyway. EXPORT_SYMBOL() sometimes and kinda unpredictably not 
working in lib-y is tricky. But it produces obvious errors, unresolved 
symbols, not obscure un-debuggable bugs.

--Kai


