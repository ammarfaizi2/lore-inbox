Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUG1WHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUG1WHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUG1WHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:07:46 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40329 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S265293AbUG1WHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:07:34 -0400
Date: Wed, 28 Jul 2004 15:07:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: olh@suse.de, linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       Sylvain Munaut <tnt@246tNt.com>, Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 check
Message-ID: <20040728220733.GA16468@smtp.west.cox.net>
References: <20040728154630.GN10891@smtp.west.cox.net> <20040728150052.4effe78a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728150052.4effe78a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 03:00:52PM -0700, Andrew Morton wrote:

> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > The following patch does three things.  First, it removes all instances
> > of:
> > ifeq ($(CONFIG_FOO),y)
> > AFLAGS += -Wa,-mfoo
> > endif
> > 
> > and makes us set them once in arch/ppc/Makefile, via
> > aflags-$(CONFIG_FOO), just like we do for CFLAGS.  Next it adds a test
> > for gcc-3.4 and binutils-2.14.  The problem with this combination is
> > that the -many flag is broken in binutils-2.14 and gcc-3.4 will pass it
> > down, causing other flags to be overridden and the compile to fail.
> > Changing gcc or binutils versions fixes this.  Finally, it changes
> > places in the Makefiles where we did:
> > ifeq ($(CONFIG_FOO),y)
> > obj-$(CONFIG_BAR) += foo_bar.o
> > endif
> > into
> > obj-$(CONFIG_FOO) += $(bar-y)
> > bar-$(CONFIG_BAR) += foo_bar.o
> 
> Unfortunately this has significant clashes with the mpc52xx bk tree
> which I'm carrying.
> 
> That patch has been sitting around for several weeks now - can we get it
> merged up first?

I talked with Kumar Gala at OLS, and I believe everyone (ppc) is happy
with mpc52xx stuff.  So yes, that can go out.

I've taken the binutils-2.14+gcc-3.4 bit out (and none of the other
cleanups) as it seems like we get 1-2 reports a week from this bad tools
combination:

Signed-off-by: Tom Rini <trini@kernel.crashing.org>
===== arch/ppc/Makefile 1.55 vs edited =====
--- 1.55/arch/ppc/Makefile	2004-07-05 03:27:10 -07:00
+++ edited/arch/ppc/Makefile	2004-07-15 07:20:40 -07:00
@@ -106,17 +106,24 @@
 else
 NEW_AS	:= 0
 endif
+# gcc-3.4 and binutils-2.14 are a fatal combination.
+GCC_VERSION	:= $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
+BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o /dev/null >/dev/null 2>&1 && echo 0 || echo 1)
 
-ifneq ($(NEW_AS),0)
 checkbin:
+ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
+	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
+	@echo 'correctly with gcc-3.4 and your version of binutils.'
+	@echo '*** Please upgrade your binutils or downgrade your gcc'
+	@false
+endif
+ifneq ($(NEW_AS),0)
 	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
 	@echo 'correctly with old versions of binutils.'
 	@echo '*** Please upgrade your binutils to ${GOODVER} or newer'
 	@false
-else
-checkbin:
-	@true
 endif
+	@true
 
 CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h \
 		arch/$(ARCH)/kernel/asm-offsets.s


-- 
Tom Rini
http://gate.crashing.org/~trini/
