Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262983AbVCXCIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbVCXCIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 21:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVCXCIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 21:08:55 -0500
Received: from mail.renesas.com ([202.234.163.13]:47839 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262983AbVCXCGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 21:06:44 -0500
Date: Thu, 24 Mar 2005 10:54:54 +0900 (JST)
Message-Id: <20050324.105454.844021327.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sugai@isl.melco.co.jp, takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc1] m32r: Update MMU-less support (1/3)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050324.104815.304093279.takata.hirokazu@renesas.com>
References: <20050324.104815.304093279.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for updating m32r's MMU-less support.

	* arch/m32r/kernel/entry.s:
	- Fix syscall table for !CONFIG_MMU

	* arch/m32r/kernel/traps.c:
	- Fix EIT vector setup routine for !CONFIG_MMU

Signed-off-by: Naoto Sugai <sugai@isl.melco.co.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/entry.S |   21 +++++++++++----------
 arch/m32r/kernel/traps.c |    2 ++
 2 files changed, 13 insertions(+), 10 deletions(-)


diff -ruNp a/arch/m32r/kernel/entry.S b/arch/m32r/kernel/entry.S
--- a/arch/m32r/kernel/entry.S	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/kernel/entry.S	2005-03-23 20:05:40.343327214 +0900
@@ -69,16 +69,17 @@
 #include <asm/mmu_context.h>
 
 #if !defined(CONFIG_MMU)
-#define sys_madvise             sys_ni_syscall
-#define sys_readahead           sys_ni_syscall
-#define sys_mprotect            sys_ni_syscall
-#define sys_msync               sys_ni_syscall
-#define sys_mlock               sys_ni_syscall
-#define sys_munlock             sys_ni_syscall
-#define sys_mlockall            sys_ni_syscall
-#define sys_munlockall          sys_ni_syscall
-#define sys_mremap              sys_ni_syscall
-#define sys_mincore             sys_ni_syscall
+#define sys_madvise		sys_ni_syscall
+#define sys_readahead		sys_ni_syscall
+#define sys_mprotect		sys_ni_syscall
+#define sys_msync		sys_ni_syscall
+#define sys_mlock		sys_ni_syscall
+#define sys_munlock		sys_ni_syscall
+#define sys_mlockall		sys_ni_syscall
+#define sys_munlockall		sys_ni_syscall
+#define sys_mremap		sys_ni_syscall
+#define sys_mincore		sys_ni_syscall
+#define sys_remap_file_pages	sys_ni_syscall
 #endif /* CONFIG_MMU */
 
 #define R4(reg)			@reg
diff -ruNp a/arch/m32r/kernel/traps.c b/arch/m32r/kernel/traps.c
--- a/arch/m32r/kernel/traps.c	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/kernel/traps.c	2005-03-23 20:05:40.372322745 +0900
@@ -95,8 +95,10 @@ void	set_eit_vector_entries(void)
 	eit_vector[31] = 0xff000000UL;
 	eit_vector[32] = BRA_INSN(ei_handler, 32);
 	eit_vector[64] = BRA_INSN(pie_handler, 64);
+#ifdef CONFIG_MMU
 	eit_vector[68] = BRA_INSN(ace_handler, 68);
 	eit_vector[72] = BRA_INSN(tme_handler, 72);
+#endif /* CONFIG_MMU */
 #ifdef CONFIG_SMP
 	eit_vector[184] = (unsigned long)smp_reschedule_interrupt;
 	eit_vector[185] = (unsigned long)smp_invalidate_interrupt;

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
