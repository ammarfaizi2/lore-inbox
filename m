Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUFVSej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUFVSej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUFVSeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:34:06 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:51025 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265148AbUFVSch
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:32:37 -0400
Date: Tue, 22 Jun 2004 20:44:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Martin Schlemmer <azarah@nosferatu.za.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 0/2] kbuild updates
Message-ID: <20040622184423.GA6910@mars.ravnborg.org>
Mail-Followup-To: Jari Ruusu <jariruusu@users.sourceforge.net>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai Germaschewski <kai@germaschewski.name>
References: <20040620211905.GA10189@mars.ravnborg.org> <1087767034.14794.42.camel@nosferatu.lan> <20040620220319.GA10407@mars.ravnborg.org> <20040620221824.GA10586@mars.ravnborg.org> <40D7C3D3.30DB5F72@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D7C3D3.30DB5F72@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 08:29:55AM +0300, Jari Ruusu wrote:
> Sam Ravnborg wrote:
> > On Mon, Jun 21, 2004 at 12:03:19AM +0200, Sam Ravnborg wrote:
> > > If I get just one good example I will go for the object directory, but
> > > what I have seen so far is whining - no examples.
> > 
> > Now I recall why I did not like the object directory.
> > I will break all modules using the kbuild infrastructure!
> 
> No it does not. If 'export KBUILD_OUTPUT=/foo' command is used used before
> kernel is built, it is not any more difficult to compile external modules
> with that same env variable defined.
> 
> > Why, because there is no way the to find the output directory except
> > specifying both directories.
> > One could do:
> > make -C /lib/modules/`uname -r`/source O=/lib/modules/`uname -r`/build M=`pwd`
> > 
> > So the currect choice is:
> > 1) Break modules that actually dive into the src, grepping, including or whatever
> > 2) Break all modules using kbuild infrastructure, including the above ones
> 
> or 3) Add the missing object symlink. It does not break anything.

This is unfortunately not the case.
First a few facts.
The documented way to build external modules has for a while now been
to use the following command:

	make -C /lib/modules/`uname -r`/build SUBDIRS=`pwd` modules

Recently this was simplifed to

	make -C /lib/modules/`uname -r`/build M=`pwd`

As you pointed out in a previous post letting build point to the
output directory would break all existing drivers using the documented
approach, iff the kernel were compiled using a separate output directory.
So the breakage that was of a concern was how to build external
modules using the above command - but having the kernel build
using a separate output directory.
The was solved by adding a small makefile in the output directory.

So the situation with the patch posted is that all ordinary modules
compile independent of the kernel is compiled with separate output
directories or not.

The problem you point out is modules that to be backward compatible
needs access to the kernel source. This is solved in different ways:
a) Grepping the source direct
b) Compiling a small code fragment, and test if the .o file exists

Knowing your background you are most familiar with the a) approach.
Therefore I understand why you prefer to set an environment variable
and otherwise use your current makefile.
But doing so will break all 'ordinary' external modules.
The ordinary modules are adapted to use the above commands
to compile the module.
But if the build symlinks points to the source of the
kernel and the kernel uses separate directory for output files then
it is missing the possibility to:
- access .config
- use kbuild infrastructure
- include headers under asm symlink

All the abvoe are fatal.
The porposal to require the user to set KBUILD_OUTPUT before
compiling the module would fix this. But this is then a change
in the required command used to compile an 'ordinary' external module.
It would then look like:

	KBUILD_OUTPUT=/lib/modules/`uname -r`/object; make -C /lib/modules/`uname -r`/build M=`pwd`

This change is not acceptable.
The tradeoff is that external modules that needs access to the source
needs to be tweaked to support kernels build using separate output and
source directories.

So the final result is that external modules that needs access to
the source is broken iff the kernel uses separate output directories.


> > I go for 1), introducing minimal breakage.
> 
> You seem to be in some strange "I must destroy... I must destroy... I must
> destroy..." mental state. There is a no-breakage alternative and you just
> will not consider that at all.

Requiring user to set an environment variable in many common cases
are breakage.

	Sam
