Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUFRPzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUFRPzO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUFRPxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:53:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:45733 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265245AbUFRPv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:51:58 -0400
Subject: Re: Stop the Linux kernel madness
From: Andreas Gruenbacher <agruen@suse.de>
To: 4Front Technologies <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40D23701.1030302@opensound.com>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
	 <40D23701.1030302@opensound.com>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1087573691.19400.116.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 17:48:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 2004-06-18 at 02:27, 4Front Technologies wrote:
> Our commercial OSS drivers work perfectly with Linux 2.6.5, 2.6.6, 2.6.7
> and they are failing to install with SuSE's 2.6.5 kernel. The reason is that
> they have gone and changed the kernel headers which mean that nothing works.

Not really. The 2.6 kernel series allow to put output files in a
different directory than the sources -- see the O= option; there is a
little documentation in the main Makefile. Without the O= option, the
kernel sources and object files needed to compile external modules will
reside in the same directory. With the O= option, they will reside in
different directories. This means that a single /lib/modules/$(uname
-r)/build symlink is not sufficient anymore. Therefore we have the build
symlink pointing to the output files, and a new source symlink pointing
to the real source tree. This change hasn't found its way into mainline
yet, which is unfortunate. For the discussion, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=108628265102121&w=2 and
follow-ups. I keep pinging Sam Ravnborg (the kbuild maintainer), but
apparently he is busy with other projects at the moment.

In addition, there is an extra Makefile in /lib/modules/$(uname
-r)/build that has the usual targets needed for module building, so the
traditional way of building modules (make -C /lib/modules/$(uname
-r)/build modules SUBDIRS=$(pwd)) still works. There is no need to build
scripts, scripts_basic, or whatever in that directory.

Based on this difference, there are two principal ways to build external
modules since 2.6.7 (and through back-porting also in the current SUSE
kernels, which are based on 2.6.5).  We chose to ship the kernel sources
in /usr/src/linux in a (mostly) unconfigured state, and put the output
files needed for building external modules below /usr/src/linux-obj/. 

 This means that you have several choices:

  - Configure the kernel sources in /usr/src/linux as you wish.

  - Use one of the standard SUSE configurations.

I have written a HOWTO describing how to work with the SUSE kernel
sources, which is available as /usr/src/linux/README.SUSE in our
packages. An up-to-date online version is available at
http://www.suse.de/~agruen/kernel-doc/.

> For instance our kernel interface module doesn't compile anymore we see the following
> errors:
> 
> > make -C /lib/modules/`uname -r`/build scripts scripts_basic include/linux/version.h
> > make[1]: Entering directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
> > make[1]: Nothing to be done for `scripts'.
> > make[1]: *** No rule to make target `scripts_basic'.  Stop.
> > make[1]: Leaving directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
> > make: *** [ossbuild] Error 2
> >  
> > Trying to compile using INCLUDE=/lib/modules/2.6.5-7.75-bigsmp/build/include
> > In file included from /usr/include/asm/smp.h:18,
> >                  from /usr/include/linux/smp.h:17,
> >                  from /usr/include/linux/sched.h:23,
> >                  from /usr/include/linux/module.h:10,
> >                  from src/sndshield.c:49:
> > /usr/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
> > In file included from /usr/include/asm/smp.h:18,
> >                  from /usr/include/linux/smp.h:17,
> >                  from /usr/include/linux/sched.h:23,
> >                  from /usr/include/linux/module.h:10,
> 
> 
> 
> Why is this happening?. It's working fine with Linux 2.6.5 and also worked with
> Linux 2.6.4 kernels from SuSE 9.1


Sincerely,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG


