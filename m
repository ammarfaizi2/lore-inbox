Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTIVAjP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbTIVAjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:39:15 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:51977 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262680AbTIVAjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:39:12 -0400
Date: Mon, 22 Sep 2003 01:39:10 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] add -Wdeclaration-after-statement
Message-ID: <20030922003910.GA17030@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A1EjP-000FN0-7p*FNxCyeUQPOA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not that many people are going to be using GCC 3.4 currently, but it
might help a bit to prevent compilation bugs like that just witnessed
in procfs.

regards,
john

diff -Naurp -X dontdiff linux-cvs/arch/arm/Makefile linux-fixes/arch/arm/Makefile
--- linux-cvs/arch/arm/Makefile	2003-09-12 15:10:41.000000000 +0100
+++ linux-fixes/arch/arm/Makefile	2003-09-22 01:52:43.000000000 +0100
@@ -27,7 +27,6 @@ LD		+= -EB
 AFLAGS		+= -mbig-endian
 endif
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
 comma = ,
 
 # This selects which instruction set is used.
diff -Naurp -X dontdiff linux-cvs/arch/i386/Makefile linux-fixes/arch/i386/Makefile
--- linux-cvs/arch/i386/Makefile	2003-08-14 13:21:12.000000000 +0100
+++ linux-fixes/arch/i386/Makefile	2003-09-22 01:48:44.000000000 +0100
@@ -21,8 +21,6 @@ LDFLAGS_vmlinux :=
 
 CFLAGS += -pipe
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
-
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
 
diff -Naurp -X dontdiff linux-cvs/arch/mips/Makefile linux-fixes/arch/mips/Makefile
--- linux-cvs/arch/mips/Makefile	2003-08-04 19:40:30.000000000 +0100
+++ linux-fixes/arch/mips/Makefile	2003-09-22 01:53:23.000000000 +0100
@@ -58,7 +58,6 @@ MODFLAGS			+= -mlong-calls
 cflags-$(CONFIG_KGDB)		+= -g
 cflags-$(CONFIG_SB1XXX_CORELIS)	+= -mno-sched-prolog -fno-omit-frame-pointer
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
 check_warning = $(shell if $(CC) $(1) -c -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
 
 #
diff -Naurp -X dontdiff linux-cvs/arch/s390/Makefile linux-fixes/arch/s390/Makefile
--- linux-cvs/arch/s390/Makefile	2003-08-04 19:40:42.000000000 +0100
+++ linux-fixes/arch/s390/Makefile	2003-09-22 01:52:18.000000000 +0100
@@ -13,8 +13,6 @@
 # Copyright (C) 1994 by Linus Torvalds
 #
 
-check_gcc = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
-
 ifdef CONFIG_ARCH_S390_31
 LDFLAGS		:= -m elf_s390
 CFLAGS		+= -m31
diff -Naurp -X dontdiff linux-cvs/Makefile linux-fixes/Makefile
--- linux-cvs/Makefile	2003-09-12 15:10:36.000000000 +0100
+++ linux-fixes/Makefile	2003-09-22 01:55:31.000000000 +0100
@@ -183,7 +183,9 @@ ifneq ($(findstring s,$(MAKEFLAGS)),)
   quiet=silent_
 endif
 
-export quiet Q KBUILD_VERBOSE
+check_gcc = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
+
+export quiet Q KBUILD_VERBOSE check_gcc
 
 # Paths to obj / src tree
 
@@ -378,6 +380,9 @@ ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
 
+# warn about C99 declaration after statement
+CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)
+
 #
 # INSTALL_PATH specifies where to place the updated kernel and system map
 # images.  Uncomment if you want to place them anywhere other than root.
