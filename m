Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268128AbUIWBWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268128AbUIWBWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUIWBTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:19:13 -0400
Received: from [12.177.129.25] ([12.177.129.25]:964 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267935AbUIWBQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:16:33 -0400
Message-Id: <200409230221.i8N2LoiF004270@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - Allow UML to load in the normal location
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:21:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes UML load at 0x8048000 rather than 0xa0000000 when 
CONFIG_MODE_SKAS is on and CONFIG_MODE_TT is off.  This will make it 
more valgrind-friendly, and also allow much greater physical memory 
sizes without needing to use highmem.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/arch/um/Makefile
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/Makefile	2004-09-22 20:00:24.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/Makefile	2004-09-22 20:17:45.000000000 -0400
@@ -109,8 +109,12 @@
 CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
 
+ifndef START
+  START = $$(($(TOP_ADDR) - $(SIZE)))
+endif
+
 CPPFLAGS_vmlinux.lds = $(shell echo -U$(SUBARCH) \
-	-DSTART=$$(($(TOP_ADDR) - $(SIZE))) -DELF_ARCH=$(ELF_ARCH) \
+	-DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
 	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE_TT) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE))
 
Index: linux-2.6.9-rc2-mm1-orig/arch/um/Makefile-i386
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/Makefile-i386	2004-09-22 20:00:24.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/Makefile-i386	2004-09-22 20:17:45.000000000 -0400
@@ -4,6 +4,12 @@
 TOP_ADDR = 0xc0000000
 endif
 
+ifeq ($(CONFIG_MODE_SKAS),y)
+  ifneq ($(CONFIG_MODE_TT),y)
+     START = 0x8048000
+  endif
+endif
+
 CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
 
 ifneq ($(CONFIG_GPROF),y)

