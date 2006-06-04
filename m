Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932260AbWFDVdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWFDVdT (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWFDVdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:33:19 -0400
Received: from canuck.infradead.org ([205.233.218.70]:9352 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932260AbWFDVdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:33:18 -0400
Subject: Re: header cleanup and install
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 22:33:13 +0100
Message-Id: <1149456793.30024.21.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 13:50 -0700, Andrew Morton wrote:
> git-hdrcleanup.patch
> git-hdrinstall.patch
> 
>  This is Dave Woodhouse's work cleaning up the kernel headers and adding a
>  `make headerinstall' target which automates the exporting of kernel
>  headers as a userspace-usable package.

More specifically:

git-hdrcleanup is simple and boring janitorial stuff in headers --
nothing particularly new and exciting. Mostly it's just moving stuff
that shouldn't be user-visible inside existing instances of #ifdef
__KERNEL__ -- it doesn't even add many new ifdefs. A large chunk of it
is just removing the superfluous #include <linux/config.h> from every
file.

The only bit that's even vaguely interesting, if you're _desperate_ to
find something exciting in it, is the fact that I hid the broken
_syscallX macros from asm-*/unistd.h inside #ifdef __KERNEL__. They're
broken for 64-bit syscall arguments on architectures like MIPS, they
were even broken for PIC code on i386. Not only were they broken, but
also the kernel headers are _not_ a library of random crap for userspace
to use. Glibc doesn't use them, klibc doesn't use them, and dietlibc
folks were working on not using them last time I checked.


git-hdrinstall is just the 'make headers_install' thing, based on an
original implementation by Arnd Bergmann. It takes the set of headers
which are at all suitable for userspace and exports them with unifdef.
The idea is that distributions can have a _consistent_ set of headers to
build stuff like glibc and system tools against, rather than the horrid
mess we have now. Those files can also be diffed from one release to the
next, and we have a decent chance of actually _seeing_ what changed,
without all the noise. Having done that diff on my last few updates, it
does actually seem to work like that in practice.

>  That being said, it's relatively costly to carry such extensive patches
>  in -mm for long periods, so I'd ask Linus and the distro people to work
>  out what we want to do here promptly, please. 

The result of this is already shipping in Fedora rawhide, and it's a
godsend. I haven't heard much from the relevant package maintainers in
other distros recently, but they were generally in agreement last time I
heard. There's not a lot of 'working out' to be done -- we just need
Linus to take it.

Btw, no mention of the rbtree shrinkage. I plan to send that Linuswards
as soon as 2.6.17 is out too, OK? And the mtd tree too but that's just a
normal maintainer tree so I _expected_ you to omit that.

-- 
dwmw2

