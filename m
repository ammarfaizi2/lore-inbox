Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVDLTw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVDLTw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVDLTvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:51:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:49608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262168AbVDLKbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:52 -0400
Message-Id: <200504121031.j3CAVhiF005387@shell0.pdx.osdl.net>
Subject: [patch 065/198] i386 vDSO: add PT_NOTE segment
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@redhat.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland McGrath <roland@redhat.com>

This patch adds an ELF note to the vDSO giving the LINUX_VERSION_CODE
value.  Having this in the vDSO lets the dynamic linker avoid the `uname'
syscall it now always does at startup to ascertain the kernel ABI
available.

Signed-off-by: Roland McGrath <roland@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/Makefile        |    6 ++++--
 25-akpm/arch/i386/kernel/vsyscall-note.S |   25 +++++++++++++++++++++++++
 25-akpm/arch/i386/kernel/vsyscall.lds.S  |    3 ++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/Makefile~i386-vdso-add-pt_note-segment arch/i386/kernel/Makefile
--- 25/arch/i386/kernel/Makefile~i386-vdso-add-pt_note-segment	2005-04-12 03:21:18.982251160 -0700
+++ 25-akpm/arch/i386/kernel/Makefile	2005-04-12 03:21:18.986250552 -0700
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
diff -puN arch/i386/kernel/vsyscall.lds.S~i386-vdso-add-pt_note-segment arch/i386/kernel/vsyscall.lds.S
--- 25/arch/i386/kernel/vsyscall.lds.S~i386-vdso-add-pt_note-segment	2005-04-12 03:21:18.983251008 -0700
+++ 25-akpm/arch/i386/kernel/vsyscall.lds.S	2005-04-12 03:21:18.987250400 -0700
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
 
diff -puN /dev/null arch/i386/kernel/vsyscall-note.S
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ 25-akpm/arch/i386/kernel/vsyscall-note.S	2005-04-12 03:21:18.987250400 -0700
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
_
