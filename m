Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUHMTxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUHMTxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUHMTuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:50:18 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:59216 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267354AbUHMTpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:45:13 -0400
Date: Fri, 13 Aug 2004 21:47:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [5/12] kbuild: Use LINUXINCLUDE to specify include/ directory
Message-ID: <20040813194736.GE10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/08 21:54:01+02:00 sam@mars.ravnborg.org 
#   kbuild: Use LINUXINCLUDE to specify include/ directory
#   
#   Peter Chubb <peterc@gelato.unsw.edu.au> reported that building i386
#   on a non-i386 platform failed, because gcc could not locate boot.h.
#   Root cause was the extra include2 directory used when using O=
#   to specify the output directory.
#   Added LINUXINCLUDE as a portable way to specify the include/
#   directory, and changed the two users.
#   This avoids hardcoding 'include2' in non-kbuild core files.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# arch/ppc64/boot/Makefile
#   2004/08/08 21:53:44+02:00 sam@mars.ravnborg.org +1 -1
#   Introduce usage of LINUXINCLUDE
# 
# arch/i386/boot/Makefile
#   2004/08/08 21:53:44+02:00 sam@mars.ravnborg.org +1 -1
#   Use LINUXINCLUDE to enable cross compilation.
#   This alos makes build locate the same boot.h when built with and wihtout O=
# 
# Makefile
#   2004/08/08 21:53:44+02:00 sam@mars.ravnborg.org +7 -3
#   Introduced LINUXINCLUDE - to allow portable reference to the include/
#   directory when assing to HOSTCFLAGS
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-13 21:08:49 +02:00
+++ b/Makefile	2004-08-13 21:08:49 +02:00
@@ -294,8 +294,12 @@
 
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
 
-CPPFLAGS        := -D__KERNEL__ -Iinclude \
-		   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
+# Use LINUXINCLUDE when you must reference the include/ directory.
+# Needed to be compatible with the O= option
+LINUXINCLUDE    := -Iinclude \
+                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
+
+CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common
@@ -306,7 +310,7 @@
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
 	HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB LDFLAGS_MODULE CHECK
 
-export CPPFLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
+export CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
 export AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 
diff -Nru a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
--- a/arch/i386/boot/Makefile	2004-08-13 21:08:49 +02:00
+++ b/arch/i386/boot/Makefile	2004-08-13 21:08:49 +02:00
@@ -31,7 +31,7 @@
 
 host-progs	:= tools/build
 
-HOSTCFLAGS_build.o := -Iinclude
+HOSTCFLAGS_build.o := $(LINUXINCLUDE)
 
 # ---------------------------------------------------------------------------
 
diff -Nru a/arch/ppc64/boot/Makefile b/arch/ppc64/boot/Makefile
--- a/arch/ppc64/boot/Makefile	2004-08-13 21:08:49 +02:00
+++ b/arch/ppc64/boot/Makefile	2004-08-13 21:08:49 +02:00
@@ -25,7 +25,7 @@
 
 BOOTCC		:= $(CROSS32_COMPILE)gcc
 HOSTCC		:= gcc
-BOOTCFLAGS	:= $(HOSTCFLAGS) -Iinclude -fno-builtin 
+BOOTCFLAGS	:= $(HOSTCFLAGS) $(LINUXINCLUDE) -fno-builtin 
 BOOTAS		:= $(CROSS32_COMPILE)as
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional
 BOOTLD		:= $(CROSS32_COMPILE)ld
