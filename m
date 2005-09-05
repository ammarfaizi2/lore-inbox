Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVIESjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVIESjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVIESjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:39:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42683 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932369AbVIESjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:39:17 -0400
Date: Mon, 5 Sep 2005 19:39:16 +0100
From: viro@ZenIV.linux.org.uk
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] 2.6.13-git3-bird1
Message-ID: <20050905183916.GJ5155@ZenIV.linux.org.uk>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905155522.GA8057@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 07:55:22PM +0400, Alexey Dobriyan wrote:
> On Mon, Sep 05, 2005 at 04:58:48AM +0100, viro@ZenIV.linux.org.uk wrote:
> > 	While waaaaay overdue, "fixes and sparse annotations" tree is finally
> > going public.  This version is basically a starting point - there will be
> > much more stuff to merge.
> 
> > 	Current patchset is on ftp.linux.org.uk/pub/people/viro/ -
> > patch-2.6.13-git3-bird1.bz2 is combined patch, patchset/* is the splitup.
> > Long description of patches is in patchset/set*, short log is in the end of
> > this posting.  Current build and sparse logs are in logs/*/{log17b,S-log17b}.
> 
> Those who want to help with endian annotations (sparse -Wbitwise) are
> welcome at ftp://ftp.berlios.de/pub/linux-sparse/logs/
> 
> [allmodconfig + CONFIG_DEBUG_INFO=n] x [alpha, i386, parisc, ppc, ppc64,
> s390, sh, sh64, sparc, sparc64, x86_64]
> 
> -git5 is compiling right now.

BTW, endianness annotation patches are welcome - that's one of the reasons
why that tree had been started.

Speaking of targets, please consider allmodconfig-with-subset ones.  On the
same anonftp there is a script (kmk) and config for it (kmk.rc).  Intended
use (with I[0-2]-* patches from the patchset):

kmk <target> <normal make arguments>

in the source tree.  It picks cross-toolchain according to target and runs
make with appropriate O=...

Toolchain description is picked from ~/kmkrc or /etc/kmk.rc (user and
system-wide, resp.).  It's a shell script sourced by kmk; it sets two
variables (CONFIGDIR - place where target descriptions will be found
and BUILDBASE - where we keep the build trees) and describes the available
cross-toolchain.  See the example on ftp.linux.org.uk - it should be
fairly self-explanatory.  This one has build trees on ../build/$target
and configs in ../config/$target; see config/* on the same anonftp for
live example of target descriptions.

Main difference from normal kbuild targets is for allmodconfig - saying
kmk $target allmodconfig
will create .config in $BUILDBASE/$target with as much as possible set
to y/m while subset mentioned in $CONFIGDIR/$target is kept fixed.  Note
that you can both set and clear options in target descriptions.

Since kmk ends up calling make, all normal uses are preserved - incrmentals,
building individual targets/subdirectories, etc.  All kbuild stuff works.

Note that you can pass additional flags to sparse by having CF=<extra flags>
in kmk (actually, make) options.  So CF=-Wbitwise will do everything you
need without mutilating makefiles.

That turns out to be very important for parallel builds for many targets -
you really, really want to have them all done on the same source tree.
Makes for much faster builds, avoids problems with propagation of patches
between the source trees and reduces the disk and cache footprint of the
entire thing.  Use of -j, OTOH, doesn't buy you anything - it gets worse
cache utilization *and* messes the build logs.
