Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUFUA33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUFUA33 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 20:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbUFUA33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 20:29:29 -0400
Received: from [195.255.196.126] ([195.255.196.126]:229 "EHLO gw.compusonic.fi")
	by vger.kernel.org with ESMTP id S261252AbUFUA30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 20:29:26 -0400
Date: Mon, 21 Jun 2004 03:29:24 +0300 (EEST)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Dev Mazumdar <dev@opensound.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH 0/2] kbuild updates
In-Reply-To: <20040620220319.GA10407@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0406210242300.16975@zeus.compusonic.fi>
References: <20040620211905.GA10189@mars.ravnborg.org>
 <1087767034.14794.42.camel@nosferatu.lan> <20040620220319.GA10407@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004, Sam Ravnborg wrote:

> > Many external modules, libs, etc use
> > /lib/modules/`uname -r`/build to locate the _source_, and this will
> > break them all.
> Examples please. What I have seen so far is modules that was not
> adapted to use kbuild when being build.
> If they fail to do so they are inherently broken.
For example our installation script expects that
/lib/modules/`uname -r`/build behaves like a symbolic link that points to
/usr/src/linux-`uname -r`. If /lib/modules/`uname -r`/build doesn't exist
then /usr/src/linux-`uname -r` will be attempted instead.

"make -C $KERNELDIR SUBDIRS=$MYDIR \
      CC=what_we_think_is_the_right_gcc_version" modules

This approach seems to work with the "stock" kernels as well as with all
the distribution kernels what we have tried so far (except the latest
kernel from SuSE that used different directory scheme).

It's relatively easy to use the dual directory scheme provided that the
object and source directories always have the same naming. However it's
possible that in the future there will be much more projects that need to
compile external modules. So it would be easier in general if the
(possible) dual directory scheme is "hidden" from the external projects.

It should be easy difficult to patch the Makefile in
/lib/modules/`uname -r`/build to locate the object directory without
requiring the caller to pass it as a parameter to the "make modules"
command.


There is one special problem that doesn't affect users who have compiled
their kernel themselves. Many distributions don't include gcc, make and
related tools in the default installation so large amount of customer
sites don't have them installed. In addition different gcc version may
have to be used to compile the kernel than the one that is the default gcc
command in the system. So before anything can be compiled the installation
scripts have to check also if the required tools are installed. If they
are not available then the customer needs to be instructed to install
them. Because the installation procedure depents on the distribution it's
very difficult to help the customer in any way. For this reason it would
be better if the re is some kind of unbrella script for building the
module. In the vanilla kernels it simply executes the right make command.
If the distribution vendors see it necessary they can improve the script
and add features like automatic installation of the required modules or
whatever else.

Does something like the following sound good?

sh /lib/modules/`uname -r`/build/make_module $MYSUBDIR CC=$CC

$MYSUBDIR is the absolute path to the directory where the module sources
are located.

$CC is optional parameter that the calling module can use if it thinks it
knows the right gcc version. If nothing is given then plain gcc is
assumed. If the script knows the right compiler then it overrides this
parameter.

In the minimalistic form the script is just

#!/bin/sh
make -C /lib/modules/`uname -r`/build SUBDIRS="$1" $2 modules

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
