Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWD1SRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWD1SRm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 14:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWD1SRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 14:17:42 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:7063 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751784AbWD1SRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 14:17:42 -0400
From: Rob Landley <rob@landley.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Date: Fri, 28 Apr 2006 14:15:52 -0400
User-Agent: KMail/1.8.3
Cc: Sam Ravnborg <sam@ravnborg.org>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org
References: <1145672241.16166.156.camel@shinybook.infradead.org> <20060422142853.GB25926@mars.ravnborg.org> <20060422145000.GF5010@stusta.de>
In-Reply-To: <20060422145000.GF5010@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281415.53325.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 April 2006 10:50 am, Adrian Bunk wrote:
> > > These are two doable approaches with a new kabi/ that avoid needless
> > > breaking of userspace.
> >
> > First off:
> > There are many other users that poke direct in the kernel source also.
>
> Kernel space users?
> User space users?
>
> Can you give an example of what you are thinking of?

Busybox's losetup code wants linux/loop.c because nothing else #defines that 
structure, and cut and pasting it into a local header file is incredibly 
painful because portions of that structure vary by architecture, namely 
__kernel_dev_t has different sizes on alpha, arm, x86... meaning we have to 
#include linux/posix_types.h unless we want to hard wire into our code 
#ifdefs that type for every architecture out there.  This is _bypassing_ the 
fact that we already #include linux/version.h and check if we're building on 
2.6, and if so just use the 64 bit structure instead to avoid the whole 
_old_kernel_dev_t rename entirely.

We spent _two years_ trying to figure out a clean way to do all that.  There 
isn't one.

And no, util-linux isn't doing it cleanly either.  They just hide the ugliness 
by nesting #include files.  mount/loop.h #includes my_dev_t.h which #includes 
<linux/posix_types.h> and <linux/version.h> just like we do, because THERE IS 
NO ALTERNATIVE.

I've been using Mazur's cleaned up headers (still am, it's stuck on 2.6.12 but 
that still works until something better comes along).  I've been tracking 
various attempts to come up with a successor.

The gentoo people have been collecting patches to clean up the headers:
http://www.gentoo.org/cgi-bin/viewcvs.cgi/src/patchsets/gentoo-headers/?root=gentoo
Plus usable headers and a sanitizing script:
http://packages.gentoo.org/search/?sstring=linux-headers
http://packages.gentoo.org/search/?sstring=genkernel

The cross-linux-from-scratch people have been working on their own header 
sanitizing script:
http://headers.cross-lfs.org
http://cross-lfs.org/view/svn/ppc/final-system/linux-headers.html
http://ninja.linux-phreak.biz/pipermail/clfs-dev/2006-April/000007.html
http://ninja.linux-phreak.biz/pipermail/clfs-dev/2006-April/000019.html
http://ninja.linux-phreak.biz/pipermail/clfs-dev/2006-April/000027.html

Fedora recently migrated from a linux-kernel-headers package that smells a bit 
like Mazur's to the glibc-kernheaders package.  Debian has its own patches 
for this...  There have been LOTS of attempts to clean up all the #ifdef 
KERNEL stuff 

I'm am _thrilled_ that somebody's trying to create a path into the kernel for 
all these diverse efforts, because this is important to a lot of people and 
we can't wait two years for a big flag day kabi effort to possibly become 
useful someday.

The beauty of the "make headers_install" thing is I don't have to wait for it 
to be finished before I can use it.  It's no worse than the current 
situation, and it's something I can collect and maintain existing patches 
against, something I can _submit_ patches against.

P.S.  I spent yesterday dealing with this stuff.  Why?  I want to build a 
cross-compiler for arm, using gcc 4.1.0.  But gcc doesn't just require a 
cross version of binutils, it also requires headers for the target platform 
(because now stack unwinding is built even if you disable c++ support).  
These target headers come from your cross-compiled C library.  You need a 
cross compiler to build that C library.  And you need the library to build 
the cross compiler.

Luckily, uClibc has a "make headers" that can use the native compiler.  But 
the uClibc build requires the correct kernel headers preprepared for the 
target platform you're going to build for when you do that.  And so, I 
dredged up Mazur's 2.6.12 headers again.  It's that or use the raw ones from 
linux-2.6.16...


> > Secondly and more importantly:
> > Introducing kabi/ you will have a half solution where several users will
> > have to find their stuff in two places for a longer period.
> > kabi/ does not allow you to do it incrementally - it requires you to
> > move everything over from a start.
> > You may argue that you can just move over a little bit mroe than needed
> > but then we ruin the incremental approach.
>
> For kernel space, you can do it incrementally, since the whole kabi/
> stuff should be transparent for in-kernel uses.

kabi does not exist yet, and it will be useless to me until it's finished.  
Wake me when you've teleported from point A to point B with no road in 
between.  In the meantime, I'm happy to test the incremental cleanup and 
report any problems I have with it, possibly with patches if I manage to fix 
it myself.

Make headers_install interests me, as a consumer of said headers.  Today.  
Right now.  The kabi thing does not interest me, does not serve my needs, and 
will not get any effort from me to advance it.

> For user space, you need one switch.
> But this switch goes from the current mess with several independent
> user space header implementations to one official implementation.

We have an official implementation, the existing kernel headers.  Its's just 
broken.  The "make headers_install" approach sounds to me like a marvelous 
way to get consistently cleaned up versions of those kernel headers.  (I 
didn't say perfectly, I said consistently.  I can submit patches against 
consistently, and I know where to submit them _to_.)

Rob
-- 
Never bet against the cheap plastic solution.
