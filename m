Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVDHDyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVDHDyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVDHDyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:54:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19897 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262678AbVDHDx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:53:58 -0400
Date: Thu, 7 Apr 2005 20:53:52 -0700
Message-Id: <200504080353.j383rqf8029792@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386 vDSO: add PT_NOTE segment
X-Zippy-Says: Of course, you UNDERSTAND about the PLAIDS in the SPIN CYCLE --
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an ELF note to the vDSO giving the LINUX_VERSION_CODE
value.  Having this in the vDSO lets the dynamic linker avoid the `uname'
syscall it now always does at startup to ascertain the kernel ABI available.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/i386/kernel/Makefile
+++ linux-2.6/arch/i386/kernel/Makefile
@@ -56,7 +56,8 @@ SYSCFLAGS_vsyscall-sysenter.so	= $(vsysc
 SYSCFLAGS_vsyscall-int80.so	= $(vsyscall-flags)
 
 $(obj)/vsyscall-int80.so $(obj)/vsyscall-sysenter.so: \
-$(obj)/vsyscall-%.so: $(src)/vsyscall.lds $(obj)/vsyscall-%.o FORCE
+$(obj)/vsyscall-%.so: $(src)/vsyscall.lds \
+		      $(obj)/vsyscall-%.o $(obj)/vsyscall-note.o FORCE
 	$(call if_changed,syscall)
 
 # We also create a special relocatable object that should mirror the symbol
@@ -67,5 +68,6 @@ $(obj)/built-in.o: $(obj)/vsyscall-syms.
 $(obj)/built-in.o: ld_flags += -R $(obj)/vsyscall-syms.o
 
 SYSCFLAGS_vsyscall-syms.o = -r
-$(obj)/vsyscall-syms.o: $(src)/vsyscall.lds $(obj)/vsyscall-sysenter.o FORCE
+$(obj)/vsyscall-syms.o: $(src)/vsyscall.lds \
+			$(obj)/vsyscall-sysenter.o $(obj)/vsyscall-note.o FORCE
 	$(call if_changed,syscall)
--- linux-2.6/arch/i386/kernel/vsyscall.lds.S
+++ linux-2.6/arch/i386/kernel/vsyscall.lds.S
@@ -23,7 +23,7 @@ SECTIONS
   . = VSYSCALL_BASE + 0x400;
 
   .text           : { *(.text) }		:text =0x90909090
-
+  .note		  : { *(.note.*) }		:text :note
   .eh_frame_hdr   : { *(.eh_frame_hdr) }	:text :eh_frame_hdr
   .eh_frame       : { KEEP (*(.eh_frame)) }	:text
   .dynamic        : { *(.dynamic) }		:text :dynamic
@@ -43,6 +43,7 @@ PHDRS
 {
   text PT_LOAD FILEHDR PHDRS FLAGS(5); /* PF_R|PF_X */
   dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
+  note PT_NOTE FLAGS(4); /* PF_R */
   eh_frame_hdr 0x6474e550; /* PT_GNU_EH_FRAME, but ld doesn't match the name */
 }
 
--- linux-2.6/arch/i386/kernel/vsyscall-note.S
+++ linux-2.6/arch/i386/kernel/vsyscall-note.S
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
