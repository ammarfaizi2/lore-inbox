Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270645AbTHEUL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270659AbTHEUL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:11:26 -0400
Received: from waste.org ([209.173.204.2]:39859 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270645AbTHEULW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:11:22 -0400
Date: Tue, 5 Aug 2003 15:10:54 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Mike Fedyk <mfedyk@matchmail.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [PATCH] automate patch names in kernel versions
Message-ID: <20030805201054.GA26701@waste.org>
References: <20030729204419.GE6049@waste.org> <20030805191718.GC970@matchmail.com> <20030805123349.6a3db1f9.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805123349.6a3db1f9.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 12:33:49PM -0700, Randy.Dunlap wrote:
> On Tue, 5 Aug 2003 12:17:18 -0700 Mike Fedyk <mfedyk@matchmail.com> wrote:
> 
> | On Tue, Jul 29, 2003 at 03:44:19PM -0500, Oliver Xymoron wrote:
> | > Perhaps times have changed enough that I can revive this idea from a
> | > few years ago:
> | > 
> | > http://groups.google.com/groups?q=patchname+oxymoron&hl=en&lr=&ie=UTF-8&selm=fa.jif8l5v.1b049jd%40ifi.uio.no&rnum=1
> | > 
> | > <quote year=1999>
> | > This four-line patch provides a means for listing what patches have
> | > been built into a kernel. This will help track non-standard kernel
> | > versions, such as those released by Redhat, or Alan's ac series, etc.
> | > more easily.
> | > 
> | > With this patch in place, each new patch can include a file of the
> | > form "patchname.[identifier]" in the top level source directory and
> | > [identifier] will then be added to the kernel version string. For
> | > instance, Alan's ac patches could include a file named patchdesc.ac2
> | > (containing a change log, perhaps), and the resulting kernel would be
> | > identified as 2.2.0-pre6+ac2, both at boot and by uname.
> | > 
> | > This may prove especially useful for tracking problems with kernels
> | > built by distribution packagers and problems reported by automated
> | > tools.
> | > </quote>
> | > 
> | > The patch now appends patches as -name rather than +name to avoid
> | > issues that might exist with packaging tools and scripts.
> | 
> | Has anything happened with this patch?
> | 
> | I for one would love it to be merged.
> 
> I saved it, as you did too apparently.
> Looks nice to me as well.

The powers that be may have noticed that the posted version was broken
in the case of no description files. This version gets the dependency
stuff right. The above description also doesn't mention that this
solves the patch conflict problem that results from touching
EXTRAVERSION directly.

diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/Makefile patched/Makefile
--- orig/Makefile	2003-07-31 10:39:39.000000000 -0500
+++ patched/Makefile	2003-07-31 11:39:02.000000000 -0500
@@ -25,7 +25,10 @@
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
-KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
+PATCHES=$(shell find -maxdepth 1 -name 'patchdesc.*[^~]' -printf '+%f' | \
+	sed -e 's/+patchdesc\./-/g')
+KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(PATCHES)
+
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
@@ -504,7 +507,11 @@
 	)
 endef
 
-include/linux/version.h: Makefile
+# We either have to keep track of the previous patchdesc.* files or check
+# version at every build
+.PHONY: always-check-version
+
+include/linux/version.h: Makefile always-check-version
 	$(call filechk,version.h)
 
 # ---------------------------------------------------------------------------

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
