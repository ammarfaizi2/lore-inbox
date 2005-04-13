Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVDMCQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVDMCQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbVDMCOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:14:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:58024 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262158AbVDMCJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:09:27 -0400
Subject: [PATCH] ppc64: add PT_NOTE section to vDSO
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@frob.com>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 12:07:44 +1000
Message-Id: <1113358065.5388.164.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch from Roland adds a PT_NOTE section to both 32 and 64 bits
vDSOs to expose the kernel version to glibc, thus avoiding a uname
syscall on every launch. This is equivalent to the patches Roland posted
already for x86 and x86-64.

Note: the 64 bits .note is actually using the 32 bits format. This is
normal. The ELF spec specifies a different format for 64 bits .note, but
for some reason, this was never properly implemented, the core dumps for
example are all using 32 bits format .note, and binutils cannot even
read a 64 bits format .note. Talking to our toolchain folks, they think
we'd rather stick to 32 bits format .note everywhere and get the spec
fixed some day ...

Signed-off-by: Roland McGrath <roland@redhat.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/arch/ppc64/kernel/vdso32/Makefile
===================================================================
--- linux-work.orig/arch/ppc64/kernel/vdso32/Makefile	2005-04-13 11:15:21.000000000 +1000
+++ linux-work/arch/ppc64/kernel/vdso32/Makefile	2005-04-13 11:19:53.000000000 +1000
@@ -1,7 +1,7 @@
 
 # List of files in the vdso, has to be asm only for now
 
-obj-vdso32 = sigtramp.o gettimeofday.o datapage.o cacheflush.o
+obj-vdso32 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o
 
 # Build rules
 
Index: linux-work/arch/ppc64/kernel/vdso32/vdso32.lds.S
===================================================================
--- linux-work.orig/arch/ppc64/kernel/vdso32/vdso32.lds.S	2005-04-13 11:15:21.000000000 +1000
+++ linux-work/arch/ppc64/kernel/vdso32/vdso32.lds.S	2005-04-13 11:19:53.000000000 +1000
@@ -20,6 +20,8 @@
   .gnu.version_d  : { *(.gnu.version_d) }
   .gnu.version_r  : { *(.gnu.version_r) }
 
+  .note		  : { *(.note.*) } 			:text	:note
+
   . = ALIGN (16);
   .text :
   {
@@ -87,6 +89,7 @@
 PHDRS
 {
   text PT_LOAD FILEHDR PHDRS FLAGS(5); /* PF_R|PF_X */
+  note PT_NOTE FLAGS(4); /* PF_R */
   dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
   eh_frame_hdr 0x6474e550; /* PT_GNU_EH_FRAME, but ld doesn't match the name */
 }
Index: linux-work/arch/ppc64/kernel/vdso64/Makefile
===================================================================
--- linux-work.orig/arch/ppc64/kernel/vdso64/Makefile	2005-04-13 11:15:21.000000000 +1000
+++ linux-work/arch/ppc64/kernel/vdso64/Makefile	2005-04-13 11:20:35.000000000 +1000
@@ -1,6 +1,6 @@
 # List of files in the vdso, has to be asm only for now
 
-obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o
+obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o
 
 # Build rules
 
Index: linux-work/arch/ppc64/kernel/vdso64/vdso64.lds.S
===================================================================
--- linux-work.orig/arch/ppc64/kernel/vdso64/vdso64.lds.S	2005-04-13 11:15:21.000000000 +1000
+++ linux-work/arch/ppc64/kernel/vdso64/vdso64.lds.S	2005-04-13 11:19:53.000000000 +1000
@@ -18,12 +18,14 @@
   .gnu.version_d  : { *(.gnu.version_d) }
   .gnu.version_r  : { *(.gnu.version_r) }
 
+  .note		  : { *(.note.*) }		:text	:note
+
   . = ALIGN (16);
   .text           :
   {
     *(.text .stub .text.* .gnu.linkonce.t.*)
     *(.sfpr .glink)
-  }
+  }						:text
   PROVIDE (__etext = .);
   PROVIDE (_etext = .);
   PROVIDE (etext = .);
@@ -88,6 +90,7 @@
 PHDRS
 {
   text PT_LOAD FILEHDR PHDRS FLAGS(5); /* PF_R|PF_X */
+  note PT_NOTE FLAGS(4); /* PF_R */
   dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
   eh_frame_hdr 0x6474e550; /* PT_GNU_EH_FRAME, but ld doesn't match the name */
 }
Index: linux-work/arch/ppc64/kernel/vdso32/note.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/kernel/vdso32/note.S	2005-04-13 11:19:53.000000000 +1000
@@ -0,0 +1,25 @@
+/*
+ * This supplies .note.* sections to go into the PT_NOTE inside the vDSO text.
+ * Here we can supply some information useful to userland.
+ */
+
+#include <linux/uts.h>
+#include <linux/version.h>
+
+#define ASM_ELF_NOTE_BEGIN(name, flags, vendor, type)			      \
+	.section name, flags;						      \
+	.balign 4;							      \
+	.long 1f - 0f;		/* name length */			      \
+	.long 3f - 2f;		/* data length */			      \
+	.long type;		/* note type */				      \
+0:	.asciz vendor;		/* vendor name */			      \
+1:	.balign 4;							      \
+2:
+
+#define ASM_ELF_NOTE_END						      \
+3:	.balign 4;		/* pad out section */			      \
+	.previous
+
+	ASM_ELF_NOTE_BEGIN(".note.kernel-version", "a", UTS_SYSNAME, 0)
+	.long LINUX_VERSION_CODE
+	ASM_ELF_NOTE_END
Index: linux-work/arch/ppc64/kernel/vdso64/note.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/kernel/vdso64/note.S	2005-04-13 11:23:10.000000000 +1000
@@ -0,0 +1 @@
+#include "../vdso32/note.S"


