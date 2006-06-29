Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbWF2Vg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWF2Vg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWF2Vg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:36:57 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:28896 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932762AbWF2Vgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:36:45 -0400
Message-Id: <200606292136.k5TLacIh010827@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 8/9] UML - Fix biarch gcc build on x86_64
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jun 2006 17:36:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run an x86_64 kernel with i386 userspace (Ubuntu Dapper) and decided
to try out UML today. I found that UML wasn't quite aware of biarch
compilers (which Ubuntu i386 ships). A fix similar to what was done for
x86_64 should probably be committed (see
http://marc.theaimsgroup.com/?l=linux-kernel&m=113425940204010&w=2).
Without the FLAGS changes, the build will fail at a number of places and
without the LINK change, the final link will fail.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Index: linux-2.6.17/arch/um/Makefile-x86_64
===================================================================
--- linux-2.6.17.orig/arch/um/Makefile-x86_64	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/Makefile-x86_64	2006-06-29 10:36:18.000000000 -0400
@@ -6,9 +6,11 @@ START := 0x60000000
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ -fno-builtin
-USER_CFLAGS += -fno-builtin
+CFLAGS += -U__$(SUBARCH)__ -fno-builtin -m64
+USER_CFLAGS += -fno-builtin -m64
 CHECKFLAGS  += -m64
+AFLAGS += -m64
+LDFLAGS += -m elf_x86_64
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
@@ -16,3 +18,4 @@ ELF_FORMAT := elf64-x86-64
 # Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
 
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
+LINK-y += -m64
Index: linux-2.6.17/arch/um/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/vmlinux.lds.S	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/vmlinux.lds.S	2006-06-29 10:36:18.000000000 -0400
@@ -1,4 +1,6 @@
 #include <linux/config.h>
+/* in case the preprocessor is a 32bit one */
+#undef i386
 #ifdef CONFIG_LD_SCRIPT_STATIC
 #include "uml.lds.S"
 #else

