Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUFTXtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUFTXtv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 19:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUFTXtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 19:49:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:51662 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265979AbUFTXth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 19:49:37 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [PATCH 0/2] kbuild updates
Date: Mon, 21 Jun 2004 01:51:43 +0200
User-Agent: KMail/1.6.2
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <20040620211905.GA10189@mars.ravnborg.org> <200406210026.43988.agruen@suse.de> <1087771141.14794.89.camel@nosferatu.lan>
In-Reply-To: <1087771141.14794.89.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406210151.43325.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC trimmed]

On Monday 21 June 2004 00:39, Martin Schlemmer wrote:
> On Mon, 2004-06-21 at 00:26, Andreas Gruenbacher wrote:
> > On Sunday 20 June 2004 23:52, Martin Schlemmer wrote:
> > > On Sun, 2004-06-20 at 23:42, Arjan van de Ven wrote:
> > > > > Given, but to 'use' the kbuild infrastructure, you must still call
> > > > > it via:
> > > > >
> > > > >   make -C _path_to_sources M=`pwd`
> > > >
> > > > I see no problem with requiring this though; requiring a correct
> > > > makefile is perfectly fine with me, and this is the only and
> > > > documented way for 2.6 already.
> > > > (And it's also the only way to build modules against Fedora Core 2
> > > > kernels by the way)
> > >
> > > I did not mean I have a problem with that.  Say you take svgalib, and
> > > you want the build system to automatically compile the kernel module,
> > > you might do something like:
> > >
> > > ---
> > > build_2_6_module:
> > > 	@make -C /lib/modules/`uname -r`/build M=`PWD`
> > > ---
> > >
> > > will break with proposed patch ...
> >
> > No it won't.
> >
> > You always need to figure out $(objtree) to build external modules, with
> > or without a separate output directory. Many modules don't need to know
> > $(srctree) explicitly at all.
> >
> > In case you want to do something depending on the sources/confguration,
> > there are two ways:
> >   - follow the new source symlink,
> >   - let kbuild take you to $(srctree): When the makefile in the M
> > directory is included, the current working directory is $(srctree).
> > besides, all the usual variables like $(srctree), $(objtree), CONFIG_*
> > variables, etc. are all available. That's a good time to check for
> > features, etc.
>
> But my original concern (that the only way to figure where the source
> are for the running kernel will be broken) is still valid.

User-space stuff that needs access to kernel headers at build time is a 
problem. But for those programs, depending on the running kernel instead of 
simply looking in /usr/src/linux is an even bigger problem: What guarantees 
that the first time the program is run, the kernel will still be the same? So 
depending on the running kernel is definitely wrong. Depending 
on /usr/src/linux is also wrong; ideally those programs should look 
in /usr/include/{linux,asm}. Unfortunately these headers are not always 
recent enough, and so recently added definitions may be missing.

> And to do 
> all that you mentioned above, you still need to figure out _where_ the
> kernel source are ...

No. Use ``make -C /lib/modules/$(uname -r)/build M=$(pwd)''
[or ``make -C /lib/modules/$(uname -r)/build modules SUBDIRS=$(pwd)'']
and in Makefile, use conditionals to adapt to the configuration. 
Documentation/kbuild/makefiles.txt is your friend. Use
``make -C /lib/modules/$(uname -r)/build modules_install M=$(pwd)''
to install the modules.
Caution: the last command is dangerous; it will wipe away all other modules 
with kernels that don't have M= support.

In case you really think you must circumvent kbuild, check if the source 
symlink exists, etc.

> > > And the point I wanted to make was that AFIAK
> > > '/lib/modules/`uname -r`/build' is an interface to figure
> > > out where the _sources_ for the current running kernel are
> > > located.
> >
> > That's a misconception. At the minimum, you want to be able to build the
> > module. Directly messing with the sources is usually wrong. I know
> > external module authors like to do that nevertheless; in a few cases it's
> > actually useful. Most of the time it really is not. Most external modules
> > have totally braindead/broken makefiles.
>
> I never said anything about messing with the source.  But anything that
> needs access to the running kernel's headers need to know where the
> sources are - and that could have been figured out by looking at the
> 'build' symlink.

See above.

> Say you maintain an opensource (just to throw out the 'its closed
> source, so screw them' arguments) external module that supports both
> 2.4 and 2.6, and easy way to implement it is to have:
>
> makefile - make will first look for this, and then process it.
>            in here you check what kernel is running (via uname -r
>            or whatever), and then create the proper 'Makefile'
>            symlink, and then call make with arguments to properly
>            handle the external module build process for that
>            version kernel.

And what prevents you from doing exactly that? The only question is how to 
invoke kbuild, but that hasn't changed.

> Makefile-pre_M_flag - 100% valid kbuild Makefile for kernels that
>                       do not support M=
>
> Makefile-post_M_flag - 100% valid kbuild Makefile for kernels
>                        supporting M=

Right now I would collapse the pre/post Makefiles and use SUBDIRS instead. 
There is no easy and reliable test for M= support, and it's only cosmetic. 
Sam will probably disagree.

> Makefile-2_4 - 100% valid kbuild/whatever Makefile for 2.4 kernels
>                (Ok, I am not so sure about how 2.4 handles things
>                these days anymore ...)
>
> now the clueless user just calls 'make && make install' and it should
> work perfectly.
>
> Or you create an install.sh that does things properly, or whatever,
> but point remains that you need to know where the source are ...

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
