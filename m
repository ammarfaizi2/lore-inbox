Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUAXODg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 09:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266942AbUAXODg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 09:03:36 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:30984 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S264925AbUAXODe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 09:03:34 -0500
Date: 24 Jan 2004 17:04:54 +0300
Message-Id: <87oestsard.fsf@mtu-net.ru>
From: Serge Belyshev <33554432@mtu-net.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] arch/i386/Makefile,scripts/gcc-version.sh,Makefile small fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This patch is against 2.6.2-rc1-mm2]

arch/i386/Makefile:
*  omitted $(KBUILD_SRC)/ in script call.

scripts/gcc-version.sh:
*  GNU tail no longer supports 'tail -1' syntax.

Makefile: 
*  There is no point in adding -funit-at-a-time option because it is
   enabled by default at levels -Os, -O2 and -O3.

*  Consider adding -fweb option:

   vanilla:
   $ size vmlinux
      text    data     bss     dec     hex filename
   3056270  526780  386056 3969106  3c9052 vmlinux

   with -fweb:
   $ size vmlinux
      text    data     bss     dec     hex filename
   3049523  526780  386056 3962359  3c75f7 vmlinux

   Also note 0.1 ... 1.0% speedup in various benchmarks.
   This option is not enabled by default at -O2 because it
   (like -fomit-frame-pointer) makes debugging impossible.

diff -urN vanilla-2.6.2-rc1-mm2/arch/i386/Makefile hack/arch/i386/Makefile
--- vanilla-2.6.2-rc1-mm2/arch/i386/Makefile	Sat Jan 24 15:49:56 2004
+++ hack/arch/i386/Makefile	Sat Jan 24 15:32:13 2004
@@ -70,7 +70,7 @@
 
 # -mregparm=3 works ok on gcc-3.0 and later
 #
-GCC_VERSION			:= $(shell $(CONFIG_SHELL) scripts/gcc-version.sh $(CC))
+GCC_VERSION			:= $(shell $(CONFIG_SHELL) $(KBUILD_SRC)/scripts/gcc-version.sh $(CC))
 cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
 
 CFLAGS += $(cflags-y)
diff -urN vanilla-2.6.2-rc1-mm2/scripts/gcc-version.sh hack/scripts/gcc-version.sh
--- vanilla-2.6.2-rc1-mm2/scripts/gcc-version.sh	Sat Jan 24 15:49:59 2004
+++ hack/scripts/gcc-version.sh	Sat Jan 24 15:28:02 2004
@@ -8,7 +8,7 @@
 
 compiler="$*"
 
-MAJOR=$(echo __GNUC__ | $compiler -E -xc - | tail -1)
-MINOR=$(echo __GNUC_MINOR__ | $compiler -E -xc - | tail -1)
+MAJOR=$(echo __GNUC__ | $compiler -E -xc - | tail -n 1)
+MINOR=$(echo __GNUC_MINOR__ | $compiler -E -xc - | tail -n 1)
 printf "%02d%02d\\n" $MAJOR $MINOR
 
diff -urN vanilla-2.6.2-rc1-mm2/Makefile hack/Makefile
--- vanilla-2.6.2-rc1-mm2/Makefile	Sat Jan 24 15:49:59 2004
+++ hack/Makefile	Sat Jan 24 15:51:30 2004
@@ -435,15 +435,12 @@
 
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
+CFLAGS		+= $(call check_gcc,-fweb,)
 endif
 
 ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
-
-# Enable unit-at-a-time mode when possible. It shrinks the
-# kernel considerably.
-CFLAGS += $(call check_gcc,-funit-at-a-time,)
 
 # warn about C99 declaration after statement
 CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)
