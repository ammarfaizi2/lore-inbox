Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbULPMoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbULPMoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 07:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbULPMoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 07:44:09 -0500
Received: from mail.renesas.com ([202.234.163.13]:35544 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262654AbULPMn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 07:43:56 -0500
Date: Thu, 16 Dec 2004 21:43:45 +0900 (JST)
Message-Id: <20041216.214345.1071461499.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gniibe@fsij.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Don't encode ACE_INSTRUCTION in
 address (2/3)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041216.214100.278750319.takata.hirokazu@renesas.com>
References: <20041216.214100.278750319.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.10-rc3-mm1] m32r: Don't encode ACE_INSTRUCTION in address (2/3)
- To be more comprehensive, keep ACE_INSTRUCTION (access exception 
  on instruction execution) information in thread_info->flags,
  instead of encoding it into address parameter.

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/mm/fault.c           |    7 ++++---
 include/asm-m32r/thread_info.h |   16 ++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)


diff -ruNp a/include/asm-m32r/thread_info.h b/include/asm-m32r/thread_info.h
--- a/include/asm-m32r/thread_info.h	2004-10-19 06:55:07.000000000 +0900
+++ b/include/asm-m32r/thread_info.h	2004-12-16 10:24:56.000000000 +0900
@@ -99,6 +99,21 @@ static inline struct thread_info *curren
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
+#define TI_FLAG_FAULT_CODE_SHIFT	28
+
+static inline void set_thread_fault_code(unsigned int val)
+{
+	struct thread_info *ti = current_thread_info();
+	ti->flags = (ti->flags & (~0 >> (32 - TI_FLAG_FAULT_CODE_SHIFT)))
+		| (val << TI_FLAG_FAULT_CODE_SHIFT);
+}
+
+static inline unsigned int get_thread_fault_code(void)
+{
+	struct thread_info *ti = current_thread_info();
+	return ti->flags >> TI_FLAG_FAULT_CODE_SHIFT;
+}
+
 #else /* !__ASSEMBLY__ */
 
 /* how to get the thread information struct from ASM */
@@ -123,6 +138,7 @@ static inline struct thread_info *curren
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+					/* 31..28 fault code */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
diff -ruNp a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
--- a/arch/m32r/mm/fault.c	2004-12-16 10:56:51.000000000 +0900
+++ b/arch/m32r/mm/fault.c	2004-12-16 11:16:58.000000000 +0900
@@ -222,7 +222,8 @@ survive:
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	addr = (address & PAGE_MASK) | (error_code & ACE_INSTRUCTION);
+	addr = (address & PAGE_MASK);
+	set_thread_fault_code(error_code);
 	switch (handle_mm_fault(mm, vma, addr, write)) {
 		case VM_FAULT_MINOR:
 			tsk->min_flt++;
@@ -237,7 +238,7 @@ survive:
 		default:
 			BUG();
 	}
-
+	set_thread_fault_code(0);
 	up_read(&mm->mmap_sem);
 	return;
 
@@ -381,7 +382,7 @@ void update_mmu_cache(struct vm_area_str
 	unsigned long *entry1, *entry2;
 	unsigned long pte_data, flags;
 	unsigned int *entry_dat;
-	int inst = vaddr & 8;
+	int inst = get_thread_fault_code() & ACE_INSTRUCTION;
 	int i;
 
 	/* Ptrace may call this routine. */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
