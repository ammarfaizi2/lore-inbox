Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVIFVdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVIFVdz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVIFVdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:33:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54197 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750820AbVIFVdy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:33:54 -0400
Date: Tue, 6 Sep 2005 22:33:51 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] bogus symbol used in arch/um/os-Linux/elf_aux.c
Message-ID: <20050906213351.GC5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elf_aux is userland code; it uses symbol (ELF_CLASS) that doesn't exist in
userland headers; pulled into kernel-offsets.h, switched elf_aux to using it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git5-base/arch/um/include/common-offsets.h current/arch/um/include/common-offsets.h
--- RC13-git5-base/arch/um/include/common-offsets.h	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/um/include/common-offsets.h	2005-09-06 17:10:36.000000000 -0400
@@ -12,3 +12,4 @@
 DEFINE_STR(UM_KERN_NOTICE, KERN_NOTICE);
 DEFINE_STR(UM_KERN_INFO, KERN_INFO);
 DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
+DEFINE(HOST_ELF_CLASS, ELF_CLASS);
diff -urN RC13-git5-base/arch/um/os-Linux/Makefile current/arch/um/os-Linux/Makefile
--- RC13-git5-base/arch/um/os-Linux/Makefile	2005-09-05 07:05:14.000000000 -0400
+++ current/arch/um/os-Linux/Makefile	2005-09-06 17:18:00.000000000 -0400
@@ -9,6 +9,9 @@
 USER_OBJS := aio.o elf_aux.o file.o process.o signal.o start_up.o time.o tt.o \
 	tty.o
 
+elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
+CFLAGS_elf_aux.o += -I$(objtree)/arch/um
+
 CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
 
 HAVE_AIO_ABI := $(shell [ -r /usr/include/linux/aio_abi.h ] && \
diff -urN RC13-git5-base/arch/um/os-Linux/elf_aux.c current/arch/um/os-Linux/elf_aux.c
--- RC13-git5-base/arch/um/os-Linux/elf_aux.c	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/um/os-Linux/elf_aux.c	2005-09-06 17:14:24.000000000 -0400
@@ -12,8 +12,9 @@
 #include "init.h"
 #include "elf_user.h"
 #include "mem_user.h"
+#include <kernel-offsets.h>
 
-#if ELF_CLASS == ELFCLASS32
+#if HOST_ELF_CLASS == ELFCLASS32
 typedef Elf32_auxv_t elf_auxv_t;
 #else
 typedef Elf64_auxv_t elf_auxv_t;
diff -urN RC13-git5-base/arch/um/sys-i386/kernel-offsets.c current/arch/um/sys-i386/kernel-offsets.c
--- RC13-git5-base/arch/um/sys-i386/kernel-offsets.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/um/sys-i386/kernel-offsets.c	2005-09-06 17:11:20.000000000 -0400
@@ -2,6 +2,7 @@
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/elf.h>
 #include <asm/page.h>
 
 #define DEFINE(sym, val) \
diff -urN RC13-git5-base/arch/um/sys-x86_64/kernel-offsets.c current/arch/um/sys-x86_64/kernel-offsets.c
--- RC13-git5-base/arch/um/sys-x86_64/kernel-offsets.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/um/sys-x86_64/kernel-offsets.c	2005-09-06 17:11:50.000000000 -0400
@@ -2,6 +2,7 @@
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/elf.h>
 #include <asm/page.h>
 
 #define DEFINE(sym, val) \
