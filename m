Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbUCGNcC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 08:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbUCGNbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 08:31:52 -0500
Received: from ns.suse.de ([195.135.220.2]:18597 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261962AbUCGNbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 08:31:38 -0500
Subject: Re: External kernel modules, second try
From: Andreas Gruenbacher <agruen@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
In-Reply-To: <20040307125348.GA2020@mars.ravnborg.org>
References: <1078620297.3156.139.camel@nb.suse.de>
	 <20040307125348.GA2020@mars.ravnborg.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1078666334.3594.31.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 07 Mar 2004 14:32:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-07 at 13:53, Sam Ravnborg wrote:
> On Sun, Mar 07, 2004 at 01:44:58AM +0100, Andreas Gruenbacher wrote:
> > Hello,
> > 
> > here is the patch I posted previously that adds support for modversions
> > in external kernel modules that are built outside the main kernel tree
> > (first posting archived here: http://lwn.net/Articles/69148/). Relative
> > to the original version, the attached version also works when compiling
> > with O=.
> Hi Andreas.
> I have started to look into this.
> The changes im Makefile when you use SUBDIRS as a flag does not look
> pretty.

Agreed. A more generic approach wouldn't hurt. You know now which itches
we have with this area of kbuild; I'm convinced we will work something
out.

> What I have in mind is something like this:
> - Get rid of current use of SUBDIRS. It is no longer used in any
>   arch Makefiles.
> - Introduce a KBUILD_EXTMOD variable that is only set when building
>   external modules
> - Introduce a new method to be used when compiling external modules:
>   make M=dir-to-module
> - Keeping the SUbDIRS notation for backward compatibility
> - When using SUBDIRS or M= the 'modules' target is implicit.

Why not keep the SUBDIRS notation for external modules only then? That's
what was documented to work since a long time; I see no big benefit in
changing it if it can be avoided.

> - make clean and make mrproper/distclen only deletes files in the
>   external module directory (as done in your patch)

Yes.

> - Error out if any updates are requires in the kernel tree

Yes.

> - Find a magic way to include a Kconfig file for the external module

This is where it gets pretty messy. You would also have a different
configuration in the external module. I have no clear idea how that can
work reasonably cleanly.

> - Allow kbuild Makefiles to be named Kbuild, so local stuff can be in
>   a file named Makefile file
>
>   note: this can be achieved using makefile/Makefile today but
>   it makes sense since there is not much 'Make' syntax left in
>   kbuild makefiles today.

The Makefile can already include both the kbuild and local stuff (same
snippet I sent you in personal communication already):

   ------------------------- 8< -------------------------
   # Standard kbuild makefile constructs go here:
   # mod-y := ...

   # Set to something different to install somewhere else:
   # MOD_DIR := extra

   .PHONY: modules install clean modules_add

   modules modules_add clean:
           $(MAKE) -C $(KERNEL_SOURCE) $@ SUBDIRS=$(CURDIR)
   install : modules_add
   ------------------------- 8< -------------------------

OTOH, if by local stuff you mean userspace, that *really* ought to go in
a different directory. Module writers for some reason don't like this
position, but we are building the modules for a whole bunch of kernels
(with different configurations), and userspace is only built once per
architecture. Merging the kernel and user-space parts is just wrong
(TM).

> Above will not be made in one go. My next step is to make a patch for the
> first four steps - to see the actual impact on current makefiles.

Yes, fair enough.

> Comments welcome!
> 
> Could you explain what is the actually gain of using the
> modversions file your patch creates. (modpost changes)

Now with mainline, when building external modules they will end up not
having modversions. This is caused by the way .tmp_versions is handled,
and is a real problem. There are two different ways how we are building
external modules today:

  (1) after the kernel source tree was just compiled, so the kernel
      source tree still contains all the object files,

  (2) in a separate step, against an almost clean kernel source tree.
      Almost-clean means the tree contains a set of configuration files,
      and the modversions dump file.

The modversions dump file elegantly solves both cases.

> > The patch also adds a modules_add target that does the equivalent of
> > modules_install for one external module.
> Looks good.
> 
> > The third change is to remove one instance of temporary file creation
> > inside the main kernel tree while external modules are built. I think
> > there are still other cases where temp files in the kernel tree are
> > used. IMHO they should all go away, so that a ``make -C $KERNEL_SOURCE
> > modules SUBDIRS=$PWD'' works against a read-only tree.
> Agree - should be easy to test using a CD.
> Are there an easy way to mount just a directory structure RO?

Not sure what you mean exactly. My main motivation is this: we have a
whole bunch of external modules that we build one after the other. Those
external modules are notoriously nasty: We had cases where the modules
fondled in kernel headers in the original tree. Of course then the next
modules would build against a broken tree. To stop and detect such
madness, I want to give modules a kernel source tree to which they have
no write access, by chowning to a different user. Trees on read-only
media are irrelevant IMHO.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

