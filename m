Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269077AbUJQH4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269077AbUJQH4y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 03:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269078AbUJQH4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 03:56:54 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:53545 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S269077AbUJQH4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 03:56:50 -0400
Date: Sun, 17 Oct 2004 11:57:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: using cc-option in arch/ppc64/boot/Makefile
Message-ID: <20041017095700.GB16186@mars.ravnborg.org>
Mail-Followup-To: Hollis Blanchard <hollisb@us.ibm.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200410141611.32198.hollisb@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410141611.32198.hollisb@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 04:11:32PM +0000, Hollis Blanchard wrote:
> Hi Sam, I would like to use "cc-option-yn" in arch/ppc64/boot/Makefile.
> 
> All recent 64-bit gcc/binutils can produce 32-bit code by passing -m32 (or 
> similar) to them. arch/ppc64/boot/zImage is actually a 32-bit executable, and 
> the Makefile still requires a separate 32-bit cross-compiler to build it (in 
> addition to the 64-bit cross-compiler used for the vmlinux). To decide if 
> $(CC) can handle -m32, I'd like to use cc-option-yn (as in 
> arch/ppc64/Makefile).
> 
> I've tried moving the cc-option stuff out of the top-level Makefile into 
> something that can be included from arch/ppc64/boot/Makefile, but so far the 
> right magic has escaped me. Any ideas?

Something like this should do the trick?
You could also include everything in your Makefile but I prefer Makefile.lib
to make it a bit more general.

I need to sanitize Makefile.lib before I like to do it in mainline though.

	Sam

===== scripts/Makefile.lib 1.26 vs edited =====
--- 1.26/scripts/Makefile.lib	2004-08-15 12:17:51 +02:00
+++ edited/scripts/Makefile.lib	2004-10-17 11:54:42 +02:00
@@ -232,3 +232,34 @@
 # Usage:
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.build obj
+
+######
+# cc support functions to be used (only) in arch/$(ARCH)/Makefile
+# See documentation in Documentation/kbuild/makefiles.txt
+
+# cc-option
+# Usage: cflags-y += $(call gcc-option, -march=winchip-c6, -march=i586)
+
+cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
+             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
+
+# For backward compatibility
+check_gcc = $(warning check_gcc is deprecated - use cc-option) \
+            $(call cc-option, $(1),$(2))
+
+# cc-option-yn
+# Usage: flag := $(call gcc-option-yn, -march=winchip-c6)
+cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
+                > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
+
+# cc-option-align
+# Prefix align with either -falign or -malign
+cc-option-align = $(subst -functions=0,,\
+	$(call cc-option,-falign-functions=0,-malign-functions=0))
+
+# cc-version
+# Usage gcc-ver := $(call cc-version $(CC))
+cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
+              $(if $(1), $(1), $(CC)))
+
+
