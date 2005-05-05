Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVEEDSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVEEDSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 23:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVEEDSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 23:18:44 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:11239
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262012AbVEEDSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 23:18:30 -0400
Subject: Re: [PATCH] Saving ARCH and CROSS_COMPILE in generated Makefile
From: Pavel Roskin <proski@gnu.org>
To: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20050504232338.GF18977@parcelfarce.linux.theplanet.co.uk>
References: <1115248267.12758.21.camel@dv.roinet.com>
	 <20050504232338.GF18977@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 May 2005 23:18:25 -0400
Message-Id: <1115263105.17646.1.camel@dv.roinet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Al!

Sorry, forgot to copy to LKML.

On Thu, 2005-05-05 at 00:23 +0100, Al Viro wrote:
> On Wed, May 04, 2005 at 07:11:07PM -0400, Pavel Roskin wrote:
> > Unfortunately, builds in the source directory would not profit from this
> > patch.  Perhaps we could always generate "makefile" or "GNUmakefile" in
> > the build directory, but it would be another patch.  Anyway, few people
> > cross-compile their kernels, and it's not unreasonable to encourage them
> > to use out-of-tree builds.
> > 
> > SUBARCH is not saved on purpose, since users are not supposed to
> > override it.
> 
> WTF not?  Consider, e.g. uml/i386 and uml/amd64.

Agreed.  See corrected patch below.  SUBARCH is not set when not
compiling for UML to avoid confusing but harmless output in Makefile
like

ARCH = arm
SUBARCH = i386

Actually, UML doesn't currently build outside the kernel tree because a
link to arch/um/Kconfig_arch is not created.  This will need a separate
fix.

I think SUBARCH ultimately should go to .config as a UML specific option
(but the build system will have to learn how to get default values from
the outside world).  Until then, I'm fine with saving SUBARCH.

> In any case, there's no reason to mess with that at all.  This stuff is
> trivally dealt with by a wrapper script that takes target name as its
> first argument (the rest is passed to make unchanged) and figures out
> ARCH, CROSS_COMPILE, SUBARCH and build directory by it.  End of story.

I'm using such script now.  It's called kmake.  I keep forgetting to run
kmake instead of make, so it's an annoyance for me (usually it end up
with a full screen of error messages, but I'm afraid I could get a mix
of object files for different architectures in some cases).  Maybe the
wrapper should read .config?  I'll rather contribute some code to Linux
than to a local script.

I've been working with embedded systems for many years, and I know that
it's very common to patch the top-level Makefile to set ARCH and
CROSS_COMPILE.  It is done so that all developers working on the code
don't have to write wrappers and remember to use them every time.

Having ARCH and CROSS_COMPILE hardcoded in Makefile is inconvenient if
one wants to compile the same source for another architecture to verify
portability of the changes.  That's exactly where having a separate
build directory is handy.

I know, what is considered trivial for one person is an annoyance for
another.  What if Linux required to add arguments to the make command
line to enable SMP and preemption?  After all, one could put those
arguments to the wrapper as well.  It's convenient that we can configure
the kernel once and forget about every choice we made.  I want the same
for ARCH and CROSS_COMPILE settings.

Signed-off-by: Pavel Roskin <proski@gnu.org>

--- scripts/mkmakefile
+++ scripts/mkmakefile
@@ -21,6 +21,12 @@
 
 MAKEFLAGS += --no-print-directory
 
+ARCH = $ARCH
+SUBARCH = `[ "$ARCH" = um ] && echo $SUBARCH`
+CROSS_COMPILE = $CROSS_COMPILE
+
+export ARCH SUBARCH CROSS_COMPILE
+
 all:
 	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT)
 
-- 
Regards,
Pavel Roskin

