Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265509AbUGDLYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265509AbUGDLYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 07:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUGDLYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 07:24:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:28614 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265509AbUGDLYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 07:24:22 -0400
Date: Sun, 4 Jul 2004 13:24:20 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] biarch gcc support for ppc32
Message-ID: <20040704112420.GA13748@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a native powerpc64-linux gcc can not compile a ppc32 kernel properly.
This patch fixes it. It was copied from ppc64.
The change to vmlinux.lds.S fixes this error:

ld: warning: powerpc:common architecture of input file `init/built-in.o' is incompatible with powerpc:common64 output


diff -purNX /tmp/kernel_exclude.txt linux-2.6.7.orig/arch/ppc/Makefile linux-2.6.7/arch/ppc/Makefile
--- linux-2.6.7.orig/arch/ppc/Makefile	2004-07-04 08:42:32.000000000 +0000
+++ linux-2.6.7/arch/ppc/Makefile	2004-07-04 10:44:18.997644396 +0000
@@ -13,6 +13,13 @@
 # This must match PAGE_OFFSET in include/asm-ppc/page.h.
 KERNELLOAD	:= $(CONFIG_KERNEL_START)
 
+HAS_BIARCH	:= $(shell if $(CC) -m32 -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo y; else echo n; fi;)
+ifeq ($(HAS_BIARCH),y)
+AS		:= $(AS) -a32
+LD		:= $(LD) -m elf32ppc
+CC		:= $(CC) -m32
+endif
+
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
 AFLAGS		+= -Iarch/$(ARCH)
diff -purNX /tmp/kernel_exclude.txt linux-2.6.7.orig/arch/ppc/kernel/vmlinux.lds.S linux-2.6.7/arch/ppc/kernel/vmlinux.lds.S
--- linux-2.6.7.orig/arch/ppc/kernel/vmlinux.lds.S	2004-06-16 05:20:26.000000000 +0000
+++ linux-2.6.7/arch/ppc/kernel/vmlinux.lds.S	2004-07-04 10:39:32.000000000 +0000
@@ -1,6 +1,6 @@
 #include <asm-generic/vmlinux.lds.h>
 
-OUTPUT_ARCH(powerpc)
+OUTPUT_ARCH(powerpc:common)
 jiffies = jiffies_64 + 4;
 SECTIONS
 {
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
