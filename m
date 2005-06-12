Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVFLL0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVFLL0J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVFLLYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:24:51 -0400
Received: from aun.it.uu.se ([130.238.12.36]:53733 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262229AbVFLLWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:22:05 -0400
Date: Sun, 12 Jun 2005 13:21:59 +0200 (MEST)
Message-Id: <200506121121.j5CBLxv9019759@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31 8/9] gcc4: silence pointer signedness warnings
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc4 generates tons of compile-time warnings like:

printk.c: In function 'tty_write_message':
printk.c:700: warning: pointer targets in passing argument 3 of 'tty->driver.write' differ in signedness

This is because of sloppy code which mixes pointers to integer types
of different signedness.

The easy fix (backport from 2.6) is to pass -Wno-pointer-sign to gcc4.
This requires a check_gcc definition in the top-level Makefile.
Some but not all arch Makefiles already had check_gcc: they are now
removed since the top-level Makefile defines it for all archs.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 Makefile             |    5 +++++
 arch/i386/Makefile   |    2 --
 arch/mips/Makefile   |    2 --
 arch/mips64/Makefile |    1 -
 arch/x86_64/Makefile |    2 --
 5 files changed, 5 insertions(+), 7 deletions(-)

diff -rupN linux-2.4.31/Makefile linux-2.4.31.gcc4-pointer-signedness-warnings/Makefile
--- linux-2.4.31/Makefile	2005-06-01 18:02:21.000000000 +0200
+++ linux-2.4.31.gcc4-pointer-signedness-warnings/Makefile	2005-06-12 11:51:36.000000000 +0200
@@ -98,6 +98,11 @@ CFLAGS += -fomit-frame-pointer
 endif
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
+check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
+# disable pointer signedness warnings in gcc 4.0
+CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
+
 #
 # ROOT_DEV specifies the default root-device when making the image.
 # This can be either FLOPPY, CURRENT, /dev/xxxx or empty, in which case
diff -rupN linux-2.4.31/arch/i386/Makefile linux-2.4.31.gcc4-pointer-signedness-warnings/arch/i386/Makefile
--- linux-2.4.31/arch/i386/Makefile	2004-11-17 18:36:41.000000000 +0100
+++ linux-2.4.31.gcc4-pointer-signedness-warnings/arch/i386/Makefile	2005-06-12 11:51:36.000000000 +0200
@@ -23,8 +23,6 @@ LINKFLAGS =-T $(TOPDIR)/arch/i386/vmlinu
 
 CFLAGS += -pipe
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
-
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
 
diff -rupN linux-2.4.31/arch/mips/Makefile linux-2.4.31.gcc4-pointer-signedness-warnings/arch/mips/Makefile
--- linux-2.4.31/arch/mips/Makefile	2005-01-19 18:00:52.000000000 +0100
+++ linux-2.4.31.gcc4-pointer-signedness-warnings/arch/mips/Makefile	2005-06-12 11:51:36.000000000 +0200
@@ -30,8 +30,6 @@ endif
 
 MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
-
 #
 #
 # GCC uses -G 0 -mabicalls -fpic as default.  We don't want PIC in the kernel
diff -rupN linux-2.4.31/arch/mips64/Makefile linux-2.4.31.gcc4-pointer-signedness-warnings/arch/mips64/Makefile
--- linux-2.4.31/arch/mips64/Makefile	2005-01-19 18:00:52.000000000 +0100
+++ linux-2.4.31.gcc4-pointer-signedness-warnings/arch/mips64/Makefile	2005-06-12 11:51:36.000000000 +0200
@@ -26,7 +26,6 @@ ifdef CONFIG_CROSSCOMPILE
 CROSS_COMPILE	= $(tool-prefix)
 endif
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
 check_gas = $(shell if $(CC) $(1) -Wa,-Z -c -o /dev/null -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
 
 #
diff -rupN linux-2.4.31/arch/x86_64/Makefile linux-2.4.31.gcc4-pointer-signedness-warnings/arch/x86_64/Makefile
--- linux-2.4.31/arch/x86_64/Makefile	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.31.gcc4-pointer-signedness-warnings/arch/x86_64/Makefile	2005-06-12 11:51:36.000000000 +0200
@@ -38,8 +38,6 @@ OBJCOPY=$(CROSS_COMPILE)objcopy -O binar
 LDFLAGS=-e stext
 LINKFLAGS =-T $(TOPDIR)/arch/x86_64/vmlinux.lds $(LDFLAGS)
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1 ; then echo "$(1)"; else echo "$(2)"; fi)
-
 CFLAGS += -mno-red-zone
 CFLAGS += -mcmodel=kernel
 CFLAGS += -pipe
