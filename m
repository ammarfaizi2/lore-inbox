Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937090AbWLDQZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937090AbWLDQZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937088AbWLDQZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:25:10 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40568
	"EHLO emea1-mh.id2.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S937087AbWLDQZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:25:07 -0500
Message-Id: <45745A28.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 04 Dec 2006 16:26:00 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] move .eh_frame to RODATA
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The .eh_frame section contents is never written to, so it can as well
benefit from CONFIG_DEBUG_RODATA.

Diff-ed against firstfloor tree.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

Index: 2.6.19-ff-unwind-debug-msg/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- 2.6.19-ff-unwind-debug-msg.orig/arch/i386/kernel/vmlinux.lds.S	2006-12-04 15:39:46.000000000 +0100
+++ 2.6.19-ff-unwind-debug-msg/arch/i386/kernel/vmlinux.lds.S	2006-12-04 17:15:50.000000000 +0100
@@ -102,15 +102,6 @@ SECTIONS
 	_edata = .;		/* End of data section */
   }
 
-#ifdef CONFIG_STACK_UNWIND
-  . = ALIGN(4);
-  .eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {
-	__start_unwind = .;
-  	*(.eh_frame)
-	__end_unwind = .;
-  }
-#endif
-
   . = ALIGN(THREAD_SIZE);	/* init_task */
   .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
 	*(.data.init_task)
Index: 2.6.19-ff-unwind-debug-msg/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- 2.6.19-ff-unwind-debug-msg.orig/arch/x86_64/kernel/vmlinux.lds.S	2006-12-04 15:39:47.000000000 +0100
+++ 2.6.19-ff-unwind-debug-msg/arch/x86_64/kernel/vmlinux.lds.S	2006-12-04 17:15:50.000000000 +0100
@@ -51,15 +51,6 @@ SECTIONS
 
   RODATA
 
-#ifdef CONFIG_STACK_UNWIND
-  . = ALIGN(8);
-  .eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {
-	__start_unwind = .;
-  	*(.eh_frame)
-	__end_unwind = .;
-  }
-#endif
-
   . = ALIGN(PAGE_SIZE);        /* Align data segment to page size boundary */
 				/* Data */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {
Index: 2.6.19-ff-unwind-debug-msg/include/asm-generic/vmlinux.lds.h
===================================================================
--- 2.6.19-ff-unwind-debug-msg.orig/include/asm-generic/vmlinux.lds.h	2006-12-04 15:39:43.000000000 +0100
+++ 2.6.19-ff-unwind-debug-msg/include/asm-generic/vmlinux.lds.h	2006-12-04 17:15:50.000000000 +0100
@@ -119,8 +119,7 @@
 		*(__ksymtab_strings)					\
 	}								\
 									\
-	/* Unwind data binary search table */				\
-	EH_FRAME_HDR							\
+	EH_FRAME							\
 									\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
@@ -162,15 +161,23 @@
 		VMLINUX_SYMBOL(__kprobes_text_end) = .;
 
 #ifdef CONFIG_STACK_UNWIND
-		/* Unwind data binary search table */
-#define EH_FRAME_HDR							\
+#define EH_FRAME							\
+		/* Unwind data binary search table */			\
+		. = ALIGN(8);						\
         	.eh_frame_hdr : AT(ADDR(.eh_frame_hdr) - LOAD_OFFSET) {	\
 			VMLINUX_SYMBOL(__start_unwind_hdr) = .;		\
 			*(.eh_frame_hdr)				\
 			VMLINUX_SYMBOL(__end_unwind_hdr) = .;		\
+		}							\
+		/* Unwind data */					\
+		. = ALIGN(8);						\
+		.eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {		\
+			VMLINUX_SYMBOL(__start_unwind) = .;		\
+		  	*(.eh_frame)					\
+			VMLINUX_SYMBOL(__end_unwind) = .;		\
 		}
 #else
-#define EH_FRAME_HDR
+#define EH_FRAME
 #endif
 
 		/* DWARF debug sections.
Index: 2.6.19-ff-unwind-debug-msg/kernel/unwind.c
===================================================================
--- 2.6.19-ff-unwind-debug-msg.orig/kernel/unwind.c	2006-12-04 17:11:45.000000000 +0100
+++ 2.6.19-ff-unwind-debug-msg/kernel/unwind.c	2006-12-04 17:15:50.000000000 +0100
@@ -19,7 +19,7 @@
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
-extern char __start_unwind[], __end_unwind[];
+extern const char __start_unwind[], __end_unwind[];
 extern const u8 __start_unwind_hdr[], __end_unwind_hdr[];
 
 #define MAX_STACK_DEPTH 8


