Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUCGQSb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbUCGQSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:18:31 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:51346 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262190AbUCGQSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:18:20 -0500
Date: Sun, 7 Mar 2004 17:18:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
Subject: Re: External kernel modules, second try
Message-ID: <20040307161808.GB2027@mars.ravnborg.org>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
	"kbuild-devel@lists.sourceforge.net" <kbuild-devel@lists.sourceforge.net>
References: <1078620297.3156.139.camel@nb.suse.de> <20040307125348.GA2020@mars.ravnborg.org> <1078666334.3594.31.camel@nb.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078666334.3594.31.camel@nb.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 02:32:14PM +0100, Andreas Gruenbacher wrote:
> 
> > What I have in mind is something like this:
> > - Get rid of current use of SUBDIRS. It is no longer used in any
> >   arch Makefiles.
> > - Introduce a KBUILD_EXTMOD variable that is only set when building
> >   external modules
> > - Introduce a new method to be used when compiling external modules:
> >   make M=dir-to-module
> > - Keeping the SUbDIRS notation for backward compatibility
> > - When using SUBDIRS or M= the 'modules' target is implicit.
> 
> Why not keep the SUBDIRS notation for external modules only then? That's
> what was documented to work since a long time; I see no big benefit in
> changing it if it can be avoided.

Since a long time is from 2.5.5x roughly.
The SUBDIRS= notation is not intuitive, and the M= notation follow
the other similar options: O=, C=.

SUBDIRS will be kept, but warned for in 2.7. Removed when 2.8 opens or similar.
So I see no breakage here.

> > - Find a magic way to include a Kconfig file for the external module
> 
> This is where it gets pretty messy. You would also have a different
> configuration in the external module. I have no clear idea how that can
> work reasonably cleanly.
If the solution becomes messy then I will just drop it.
I do not see a big need here anyway.
It will also create troubles: Can we modify .config etc.

> > - Allow kbuild Makefiles to be named Kbuild, so local stuff can be in
> >   a file named Makefile file
> >
> >   note: this can be achieved using makefile/Makefile today but
> >   it makes sense since there is not much 'Make' syntax left in
> >   kbuild makefiles today.
> 
> The Makefile can already include both the kbuild and local stuff (same
> snippet I sent you in personal communication already):
I know - but the incentive here was to seperate stuff out that does not
belong in a Kbuild makefile.
In 2.7 I may write a simple parser to create one single big Makefile,
and then it will be good to have very simple Makefiles only.

> Now with mainline, when building external modules they will end up not
> having modversions. This is caused by the way .tmp_versions is handled,
> and is a real problem. There are two different ways how we are building
> external modules today:
> 
>   (1) after the kernel source tree was just compiled, so the kernel
>       source tree still contains all the object files,
> 
>   (2) in a separate step, against an almost clean kernel source tree.
>       Almost-clean means the tree contains a set of configuration files,
>       and the modversions dump file.
> 
> The modversions dump file elegantly solves both cases.

You already convinced me about the usefullness of the modversions file.
Can you try to make a patch that _only_ incorporate the modversions
functionality. This we could ask Andrew to apply when reviewed.
See it as first step.

Then I will try to work out something for the functionality outlined
before.

> > Agree - should be easy to test using a CD.
> > Are there an easy way to mount just a directory structure RO?
> 
> Not sure what you mean exactly. My main motivation is this: we have a
> whole bunch of external modules that we build one after the other. Those
> external modules are notoriously nasty: We had cases where the modules
> fondled in kernel headers in the original tree. Of course then the next
> modules would build against a broken tree. To stop and detect such
> madness, I want to give modules a kernel source tree to which they have
> no write access, by chowning to a different user. Trees on read-only
> media are irrelevant IMHO.

Actually we agree, I just did not think of chowing the files/dirs to 
catch the problems.

	Sam
