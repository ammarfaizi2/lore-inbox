Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWIMPzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWIMPzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 11:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWIMPzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 11:55:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23271 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750970AbWIMPzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:55:08 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] FRV: Fix header exports
Date: Wed, 13 Sep 2006 16:54:57 +0100
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060913155457.2507.24080.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Fix FRV header file exports to userspace so that "make header_check" works.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-frv/Kbuild      |    2 ++
 include/asm-frv/page.h      |    2 +-
 include/asm-frv/ptrace.h    |    8 ++++++--
 include/asm-frv/registers.h |    6 ++++--
 include/asm-frv/termios.h   |    4 ++--
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/asm-frv/Kbuild b/include/asm-frv/Kbuild
index c68e168..9682e0a 100644
--- a/include/asm-frv/Kbuild
+++ b/include/asm-frv/Kbuild
@@ -1 +1,3 @@
 include include/asm-generic/Kbuild.asm
+
+unifdef-y += registers.h
diff --git a/include/asm-frv/page.h b/include/asm-frv/page.h
index 134cc0c..bd53767 100644
--- a/include/asm-frv/page.h
+++ b/include/asm-frv/page.h
@@ -76,7 +76,6 @@ #endif
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* __KERNEL__ */
 
 #ifdef CONFIG_CONTIGUOUS_PAGE_ALLOC
 #define WANT_PAGE_VIRTUAL	1
@@ -85,4 +84,5 @@ #endif
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#endif /* __KERNEL__ */
 #endif /* _ASM_PAGE_H */
diff --git a/include/asm-frv/ptrace.h b/include/asm-frv/ptrace.h
index 9a2241b..80dcd86 100644
--- a/include/asm-frv/ptrace.h
+++ b/include/asm-frv/ptrace.h
@@ -11,10 +11,10 @@
 #ifndef _ASM_PTRACE_H
 #define _ASM_PTRACE_H
 
+#ifdef __KERNEL__
 #include <asm/registers.h>
 #include <asm/irq_regs.h>
-
-#define in_syscall(regs) (((regs)->tbr & TBR_TT) == TBR_TT_TRAP0)
+#endif
 
 
 #define PT_PSR		0
@@ -60,6 +60,7 @@ #define PTRACE_GETFDPIC		31	/* get the E
 #define PTRACE_GETFDPIC_EXEC	0	/* [addr] request the executable loadmap */
 #define PTRACE_GETFDPIC_INTERP	1	/* [addr] request the interpreter loadmap */
 
+#ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
 /*
@@ -75,5 +76,8 @@ extern unsigned long user_stack(const st
 extern void show_regs(struct pt_regs *);
 #define profile_pc(regs) ((regs)->pc)
 
+#define in_syscall(regs) (((regs)->tbr & TBR_TT) == TBR_TT_TRAP0)
+
 #endif /* !__ASSEMBLY__ */
+#endif /* __KERNEL__ */
 #endif /* _ASM_PTRACE_H */
diff --git a/include/asm-frv/registers.h b/include/asm-frv/registers.h
index 9666119..82bf05b 100644
--- a/include/asm-frv/registers.h
+++ b/include/asm-frv/registers.h
@@ -140,7 +140,7 @@ #define REG_CURR_TASK	REG_GR(29)	/* curr
 /*
  * debugging registers
  */
-#ifndef __ASSEMBLY__
+#if !defined(__ASSEMBLY__) && defined(__KERNEL__)
 
 struct frv_debug_regs
 {
@@ -206,6 +206,7 @@ struct user_context
 	void *extension;
 } __attribute__((aligned(8)));
 
+#ifdef __KERNEL__
 struct frv_frame0 {
 	union {
 		struct pt_regs		regs;
@@ -215,9 +216,10 @@ struct frv_frame0 {
 	struct frv_debug_regs		debug;
 
 } __attribute__((aligned(32)));
-
 #endif
 
+#endif /* !__ASSEMBLY__ */
+
 #define __INT_GR(R)		__OFFSET(__INT_GR0,		(R))
 
 #define __FPMEDIA_FR(R)		__OFFSET(__FPMEDIA_FR0,		(R))
diff --git a/include/asm-frv/termios.h b/include/asm-frv/termios.h
index b4a664e..87c6cbc 100644
--- a/include/asm-frv/termios.h
+++ b/include/asm-frv/termios.h
@@ -29,6 +29,8 @@ #ifdef __KERNEL__
 	eol2=\0
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+
+#include <asm-generic/termios.h>
 #endif
 
 /* modem lines */
@@ -69,6 +71,4 @@ #define N_HDLC		13	/* synchronous HDLC *
 #define N_SYNC_PPP	14
 #define N_HCI		15  /* Bluetooth HCI UART */
 
-#include <asm-generic/termios.h>
-
 #endif /* _ASM_TERMIOS_H */
