Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTKPUco (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 15:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTKPUco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 15:32:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7695 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263015AbTKPUcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 15:32:42 -0500
Date: Sun, 16 Nov 2003 21:32:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 - make xconfig fails for buildtree != srctree
Message-ID: <20031116203240.GA2212@mars.ravnborg.org>
Mail-Followup-To: Andrey Borzenkov <arvidjaar@mail.ru>,
	linux-kernel@vger.kernel.org
References: <200311162220.17245.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311162220.17245.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 16, 2003 at 10:20:17PM +0300, Andrey Borzenkov wrote:
> {pts/0}% ./makelinux V=1 xconfig
> make: Entering directory `/home/bor/src/linux-2.6.0-test9'
> make -C /home/bor/build/linux-2.6.0-test9               \
> KBUILD_SRC=/home/bor/src/linux-2.6.0-test9      KBUILD_VERBOSE=1        \
> KBUILD_CHECK= -f /home/bor/src/linux-2.6.0-test9/Makefile xconfig
> make -f /home/bor/src/linux-2.6.0-test9/scripts/Makefile.build obj=scripts 
> scripts/fixdep
> make[2]: `scripts/fixdep' is up to date.
> make -f /home/bor/src/linux-2.6.0-test9/scripts/Makefile.build 
> obj=scripts/kconfig xconfig
>   g++ -Wp,-MD,scripts/kconfig/.qconf.o.d  -O2  
> -I/home/bor/src/linux-2.6.0-test9//usr/lib/qt3//include -c -o 
> scripts/kconfig/qconf.o 
> /home/bor/src/linux-2.6.0-test9/scripts/kconfig/qconf.cc
> /home/bor/src/linux-2.6.0-test9/scripts/kconfig/qconf.cc:6:26: qapplication.h: 
> No such file or directory
> 
> apparently it prepends $(srctree) (or just $(src)) to Qt include path, but I 
> failed to see where.

Know bug, will be fixed in 2.6.1 or so.
Use the following patch until then, or use make menuconfig.

	Sam

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1296.61.1 -> 1.1296.61.2
#	scripts/Makefile.lib	1.22    -> 1.23   
#	            Makefile	1.435   -> 1.436  
#
# The following is the BitKeeper ChangeSet Log
# 03/10/12	sam@mars.ravnborg.org	1.1296.61.2
# kbuild: Fix make O=../build xconfig
# 
# Compilation of qconf required -I path to qt. kbuild invalidated the
# path to qt by prefixing it with $(srctree). No longer prefix absolute paths.
# Also do not duplicate CPPFLAGS. Previously it was appended twice to CFLAGS
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sat Oct 18 09:48:02 2003
+++ b/Makefile	Sat Oct 18 09:48:02 2003
@@ -404,10 +404,6 @@
 
 include $(srctree)/arch/$(ARCH)/Makefile
 
-# Let architecture Makefiles change CPPFLAGS if needed
-CFLAGS := $(CPPFLAGS) $(CFLAGS)
-AFLAGS := $(CPPFLAGS) $(AFLAGS)
-
 core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
 
 SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	Sat Oct 18 09:48:02 2003
+++ b/scripts/Makefile.lib	Sat Oct 18 09:48:02 2003
@@ -154,7 +154,8 @@
 __hostcxx_flags	= $(_hostcxx_flags)
 else
 flags = $(foreach o,$($(1)),\
-	$(if $(filter -I%,$(o)),$(patsubst -I%,-I$(srctree)/%,$(o)),$(o)))
+		$(if $(filter -I%,$(filter-out -I/%,$(o))), \
+		$(patsubst -I%,-I$(srctree)/%,$(o)),$(o)))
 
 # -I$(obj) locate generated .h files
 # -I$(srctree)/$(src) locate .h files in srctree, from generated .c files
@@ -162,7 +163,7 @@
 __c_flags	= -I$(obj) -I$(srctree)/$(src) $(call flags,_c_flags)
 __a_flags	=                              $(call flags,_a_flags)
 __hostc_flags	= -I$(obj)                     $(call flags,_hostc_flags)
-__hostcxx_flags	=                              $(call flags,_hostcxx_flags)
+__hostcxx_flags	= -I$(obj)                     $(call flags,_hostcxx_flags)
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
