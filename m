Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbTJHDxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 23:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTJHDxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 23:53:17 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:30169 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261263AbTJHDxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 23:53:15 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16259.35252.163910.512212@wombat.chubb.wattle.id.au>
Date: Wed, 8 Oct 2003 13:51:16 +1000
To: sam@mars.ravnborg.org
cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Cross compiling using separate output directory problems
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sam,
   Thanks for doing the work to make comnpilation work with a separate
output directory.

I found the following changes necessary to get it to work properly
when crosscompiling for IA64.  Otherwise include/asm-ia64 hasn't been
created when setting up offsets.h.

There's also a minor change to tell make where to find the
toolchain-flags and check-gas scripts.

===== Makefile 1.36 vs edited =====
--- 1.36/arch/ia64/Makefile	Wed Sep 10 14:17:40 2003
+++ edited/Makefile	Wed Oct  8 13:48:53 2003
@@ -25,9 +25,9 @@
 GCC_VERSION=$(shell $(CC) -v 2>&1 | fgrep 'gcc version' | cut -f3 -d' ' | cut -f1 -d'.')
 GCC_MINOR_VERSION=$(shell $(CC) -v 2>&1 | fgrep 'gcc version' | cut -f3 -d' ' | cut -f2 -d'.')
 
-GAS_STATUS=$(shell arch/ia64/scripts/check-gas $(CC) $(OBJDUMP))
+GAS_STATUS=$(shell $(src)/arch/ia64/scripts/check-gas $(CC) $(OBJDUMP))
 
-CPPFLAGS	+= $(shell arch/ia64/scripts/toolchain-flags $(CC) $(OBJDUMP))
+CPPFLAGS	+= $(shell $(src)/arch/ia64/scripts/toolchain-flags $(CC) $(OBJDUMP))
 
 ifeq ($(GAS_STATUS),buggy)
 $(error Sorry, you need a newer version of the assember, one that is built from	\
@@ -84,18 +84,21 @@
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-CLEAN_FILES += include/asm-ia64/.offsets.h.stamp include/asm-ia64/offsets.h vmlinux.gz bootloader
+CLEAN_FILES += include/asm-$(ARCH)/.offsets.h.stamp include/asm-$(ARCH)/offsets.h vmlinux.gz bootloader
 
-prepare: include/asm-ia64/offsets.h
+prepare: include/asm-$(ARCH)/offsets.h
+
+arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h
 
 include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
 	$(call filechk,gen-asm-offsets)
 
-arch/ia64/kernel/asm-offsets.s: include/asm-ia64/.offsets.h.stamp
+arch/ia64/kernel/asm-offsets.s: include/asm-$(ARCH)/.offsets.h.stamp
 
-include/asm-ia64/.offsets.h.stamp:
-	[ -s include/asm-ia64/offsets.h ] \
-	 || echo "#define IA64_TASK_SIZE 0" > include/asm-ia64/offsets.h
+include/asm-$(ARCH)/.offsets.h.stamp:
+	mkdir -p include/asm-$(ARCH)
+	[ -s include/asm-$(ARCH)/offsets.h ] \
+	 || echo "#define IA64_TASK_SIZE 0" > include/asm-$(ARCH)/offsets.h
 	touch $@
 
 boot:	lib/lib.a vmlinux
