Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265882AbUAPXQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 18:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUAPXQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 18:16:21 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:11271 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265871AbUAPXQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 18:16:06 -0500
Date: Sat, 17 Jan 2004 00:17:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Unmangle include options for gcc
Message-ID: <20040116231752.GB6997@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When utilising the make O=... option the include options for gcc were 
mangled even when absolute paths was used.
Also remove duplication of CPPFLAGS. They were assigned twice.
[It is still possible for architectures to modify CPPFLAGS].

This patch allows xconfig to be build with make O=... xconfig.It will also help development of external modules with absolute paths for their -I options.

Note: As a side effect a full recompile of the kernel takes place due to
changes in number of gcc options.

	Sam

===== Makefile 1.446 vs edited =====
--- 1.446/Makefile	Fri Jan  9 07:57:28 2004
+++ edited/Makefile	Tue Jan 13 22:13:00 2004
@@ -404,10 +404,6 @@
 
 include $(srctree)/arch/$(ARCH)/Makefile
 
-# Let architecture Makefiles change CPPFLAGS if needed
-CFLAGS := $(CPPFLAGS) $(CFLAGS)
-AFLAGS := $(CPPFLAGS) $(AFLAGS)
-
 core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
 
 SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
===== scripts/Makefile.lib 1.22 vs edited =====
--- 1.22/scripts/Makefile.lib	Sat Sep 20 21:03:00 2003
+++ edited/scripts/Makefile.lib	Fri Jan 16 23:46:27 2004
@@ -144,8 +144,7 @@
 
 
 # If building the kernel in a separate objtree expand all occurrences
-# of -Idir to -Idir -I$(srctree)/dir.
-# hereby allowing gcc to locate files in both trees. Local tree first.
+# of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
 
 ifeq ($(KBUILD_SRC),)
 __c_flags	= $(_c_flags)
@@ -154,15 +153,16 @@
 __hostcxx_flags	= $(_hostcxx_flags)
 else
 flags = $(foreach o,$($(1)),\
-	$(if $(filter -I%,$(o)),$(patsubst -I%,-I$(srctree)/%,$(o)),$(o)))
+		$(if $(filter -I%,$(filter-out -I/%,$(o))), \
+		$(patsubst -I%,-I$(srctree)/%,$(o)),$(o)))
 
-# -I$(obj) locate generated .h files
-# -I$(srctree)/$(src) locate .h files in srctree, from generated .c files
-# FIXME: Replace both with specific EXTRA_CFLAGS statements
+# -I$(obj) locates generated .h files
+# -I$(srctree)/$(src) locates .h files in srctree, from generated .c files
+# FIXME: Replace both with specific EXTRA_CFLAGS statements in the makefiles
 __c_flags	= -I$(obj) -I$(srctree)/$(src) $(call flags,_c_flags)
 __a_flags	=                              $(call flags,_a_flags)
 __hostc_flags	= -I$(obj)                     $(call flags,_hostc_flags)
-__hostcxx_flags	=                              $(call flags,_hostcxx_flags)
+__hostcxx_flags	= -I$(obj)                     $(call flags,_hostcxx_flags)
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
