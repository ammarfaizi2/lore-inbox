Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264976AbUENChW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbUENChW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 22:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUENChW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 22:37:22 -0400
Received: from pxy5allmi.all.mi.charter.com ([24.247.15.44]:25991 "EHLO
	proxy5-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S264976AbUENCg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 22:36:58 -0400
Message-ID: <40A4318A.2050504@quark.didntduck.org>
Date: Thu, 13 May 2004 22:40:10 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove hardcoded offsets from i386 asm
Content-Type: multipart/mixed;
 boundary="------------070306010108080301040904"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070306010108080301040904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Generate offsets for thread_info, cpuinfo_x86, and a few others instead 
of hardcoding them.

--
				Brian Gerst

--------------070306010108080301040904
Content-Type: text/plain;
 name="i386-offsets-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-offsets-1"

diff -urN linux-2.6.6-bk/arch/i386/kernel/asm-offsets.c linux/arch/i386/kernel/asm-offsets.c
--- linux-2.6.6-bk/arch/i386/kernel/asm-offsets.c	2004-05-11 10:26:40.000000000 -0400
+++ linux/arch/i386/kernel/asm-offsets.c	2004-05-13 10:19:07.000000000 -0400
@@ -6,30 +6,60 @@
 
 #include <linux/sched.h>
 #include <linux/signal.h>
+#include <linux/personality.h>
 #include <asm/ucontext.h>
 #include "sigframe.h"
 #include <asm/fixmap.h>
+#include <asm/processor.h>
+#include <asm/thread_info.h>
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
 
 #define BLANK() asm volatile("\n->" : : )
 
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem));
+
 void foo(void)
 {
-	DEFINE(SIGCONTEXT_eax, offsetof (struct sigcontext, eax));
-	DEFINE(SIGCONTEXT_ebx, offsetof (struct sigcontext, ebx));
-	DEFINE(SIGCONTEXT_ecx, offsetof (struct sigcontext, ecx));
-	DEFINE(SIGCONTEXT_edx, offsetof (struct sigcontext, edx));
-	DEFINE(SIGCONTEXT_esi, offsetof (struct sigcontext, esi));
-	DEFINE(SIGCONTEXT_edi, offsetof (struct sigcontext, edi));
-	DEFINE(SIGCONTEXT_ebp, offsetof (struct sigcontext, ebp));
-	DEFINE(SIGCONTEXT_esp, offsetof (struct sigcontext, esp));
-	DEFINE(SIGCONTEXT_eip, offsetof (struct sigcontext, eip));
+	OFFSET(SIGCONTEXT_eax, sigcontext, eax);
+	OFFSET(SIGCONTEXT_ebx, sigcontext, ebx);
+	OFFSET(SIGCONTEXT_ecx, sigcontext, ecx);
+	OFFSET(SIGCONTEXT_edx, sigcontext, edx);
+	OFFSET(SIGCONTEXT_esi, sigcontext, esi);
+	OFFSET(SIGCONTEXT_edi, sigcontext, edi);
+	OFFSET(SIGCONTEXT_ebp, sigcontext, ebp);
+	OFFSET(SIGCONTEXT_esp, sigcontext, esp);
+	OFFSET(SIGCONTEXT_eip, sigcontext, eip);
+	BLANK();
+
+	OFFSET(CPUINFO_x86, cpuinfo_x86, x86);
+	OFFSET(CPUINFO_x86_vendor, cpuinfo_x86, x86_vendor);
+	OFFSET(CPUINFO_x86_model, cpuinfo_x86, x86_model);
+	OFFSET(CPUINFO_x86_mask, cpuinfo_x86, x86_mask);
+	OFFSET(CPUINFO_hard_math, cpuinfo_x86, hard_math);
+	OFFSET(CPUINFO_cpuid_level, cpuinfo_x86, cpuid_level);
+	OFFSET(CPUINFO_x86_capability, cpuinfo_x86, x86_capability);
+	OFFSET(CPUINFO_x86_vendor_id, cpuinfo_x86, x86_vendor_id);
 	BLANK();
 
-	DEFINE(RT_SIGFRAME_sigcontext,
-	       offsetof (struct rt_sigframe, uc.uc_mcontext));
+	OFFSET(TI_task, thread_info, task);
+	OFFSET(TI_exec_domain, thread_info, exec_domain);
+	OFFSET(TI_flags, thread_info, flags);
+	OFFSET(TI_status, thread_info, status);
+	OFFSET(TI_cpu, thread_info, cpu);
+	OFFSET(TI_preempt_count, thread_info, preempt_count);
+	OFFSET(TI_addr_limit, thread_info, addr_limit);
+	OFFSET(TI_restart_block, thread_info, restart_block);
+	BLANK();
+
+	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
+	OFFSET(RT_SIGFRAME_sigcontext, rt_sigframe, uc.uc_mcontext);
+
+	/* Offset from the sysenter stack to tss.esp0 */
+	DEFINE(TSS_sysenter_esp0, offsetof(struct tss_struct, esp0) -
+		 sizeof(struct tss_struct));
 
 	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
 }
diff -urN linux-2.6.6-bk/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.6.6-bk/arch/i386/kernel/entry.S	2004-05-11 10:26:48.000000000 -0400
+++ linux/arch/i386/kernel/entry.S	2004-05-13 11:38:55.000000000 -0400
@@ -74,12 +74,6 @@
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
-/*
- * ESP0 is at offset 4. 0x200 is the size of the TSS, and
- * also thus the top-of-stack pointer offset of SYSENTER_ESP
- */
-TSS_ESP0_OFFSET = (4 - 0x200)
-
 #ifdef CONFIG_PREEMPT
 #define preempt_stop		cli
 #else
@@ -163,8 +157,8 @@
 	movl %edx,EIP(%ebp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%ebp)	#
 	GET_THREAD_INFO_WITH_ESP(%ebp)	# GET_THREAD_INFO
-	movl TI_EXEC_DOMAIN(%ebp), %edx	# Get the execution domain
-	call *4(%edx)		# Call the lcall7 handler for the domain
+	movl TI_exec_domain(%ebp), %edx	# Get the execution domain
+	call *EXEC_DOMAIN_handler(%edx)	# Call the handler for the domain
 	addl $4, %esp
 	popl %eax
 	jmp resume_userspace
@@ -208,7 +202,7 @@
  	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
-	movl TI_FLAGS(%ebp), %ecx
+	movl TI_flags(%ebp), %ecx
 	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done on
 					# int/exception return?
 	jne work_pending
@@ -216,18 +210,18 @@
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	cmpl $0,TI_PRE_COUNT(%ebp)	# non-zero preempt_count ?
+	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_all
 need_resched:
-	movl TI_FLAGS(%ebp), %ecx	# need_resched set ?
+	movl TI_flags(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
 	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
 	jz restore_all
-	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebp)
+	movl $PREEMPT_ACTIVE,TI_preempt_count(%ebp)
 	sti
 	call schedule
-	movl $0,TI_PRE_COUNT(%ebp)
+	movl $0,TI_preempt_count(%ebp)
 	cli
 	jmp need_resched
 #endif
@@ -237,7 +231,7 @@
 
 	# sysenter call handler stub
 ENTRY(sysenter_entry)
-	movl TSS_ESP0_OFFSET(%esp),%esp
+	movl TSS_sysenter_esp0(%esp),%esp
 sysenter_past_esp:
 	sti
 	pushl $(__USER_DS)
@@ -264,12 +258,12 @@
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_FLAGS(%ebp)
+	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
 	cli
-	movl TI_FLAGS(%ebp), %ecx
+	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
 /* if something modifies registers it must also disable sysexit */
@@ -287,7 +281,7 @@
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 					# system call tracing in operation
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_FLAGS(%ebp)
+	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
 syscall_call:
 	call *sys_call_table(,%eax,4)
@@ -296,7 +290,7 @@
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
-	movl TI_FLAGS(%ebp), %ecx
+	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx	# current->work
 	jne syscall_exit_work
 restore_all:
@@ -312,7 +306,7 @@
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
-	movl TI_FLAGS(%ebp), %ecx
+	movl TI_flags(%ebp), %ecx
 	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done other
 					# than syscall tracing?
 	jz restore_all
@@ -473,7 +467,7 @@
  * that sets up the real kernel stack. Check here, since we can't
  * allow the wrong stack to be used.
  *
- * "TSS_ESP0_OFFSET+12" is because the NMI/debug handler will have
+ * "TSS_sysenter_esp0+12" is because the NMI/debug handler will have
  * already pushed 3 words if it hits on the sysenter instruction:
  * eflags, cs and eip.
  *
@@ -485,7 +479,7 @@
 	cmpw $__KERNEL_CS,4(%esp);		\
 	jne ok;					\
 label:						\
-	movl TSS_ESP0_OFFSET+offset(%esp),%esp;	\
+	movl TSS_sysenter_esp0+offset(%esp),%esp;	\
 	pushfl;					\
 	pushl $__KERNEL_CS;			\
 	pushl $sysenter_past_esp
diff -urN linux-2.6.6-bk/arch/i386/kernel/head.S linux/arch/i386/kernel/head.S
--- linux-2.6.6-bk/arch/i386/kernel/head.S	2004-05-11 10:26:48.000000000 -0400
+++ linux/arch/i386/kernel/head.S	2004-05-13 09:59:26.000000000 -0400
@@ -24,15 +24,14 @@
  * References to members of the new_cpu_data structure.
  */
 
-#define CPU_PARAMS	new_cpu_data
-#define X86		CPU_PARAMS+0
-#define X86_VENDOR	CPU_PARAMS+1
-#define X86_MODEL	CPU_PARAMS+2
-#define X86_MASK	CPU_PARAMS+3
-#define X86_HARD_MATH	CPU_PARAMS+6
-#define X86_CPUID	CPU_PARAMS+8
-#define X86_CAPABILITY	CPU_PARAMS+12
-#define X86_VENDOR_ID	CPU_PARAMS+36	/* offset dependent on NCAPINTS */
+#define X86		new_cpu_data+CPUINFO_x86
+#define X86_VENDOR	new_cpu_data+CPUINFO_x86_vendor
+#define X86_MODEL	new_cpu_data+CPUINFO_x86_model
+#define X86_MASK	new_cpu_data+CPUINFO_x86_mask
+#define X86_HARD_MATH	new_cpu_data+CPUINFO_hard_math
+#define X86_CPUID	new_cpu_data+CPUINFO_cpuid_level
+#define X86_CAPABILITY	new_cpu_data+CPUINFO_x86_capability
+#define X86_VENDOR_ID	new_cpu_data+CPUINFO_x86_vendor_id
 
 /*
  * This is how much memory *in addition to the memory covered up to
diff -urN linux-2.6.6-bk/arch/i386/lib/getuser.S linux/arch/i386/lib/getuser.S
--- linux-2.6.6-bk/arch/i386/lib/getuser.S	2003-12-17 21:57:59.000000000 -0500
+++ linux/arch/i386/lib/getuser.S	2004-05-13 09:59:26.000000000 -0400
@@ -28,7 +28,7 @@
 .globl __get_user_1
 __get_user_1:
 	GET_THREAD_INFO(%edx)
-	cmpl TI_ADDR_LIMIT(%edx),%eax
+	cmpl TI_addr_limit(%edx),%eax
 	jae bad_get_user
 1:	movzbl (%eax),%edx
 	xorl %eax,%eax
@@ -40,7 +40,7 @@
 	addl $1,%eax
 	jc bad_get_user
 	GET_THREAD_INFO(%edx)
-	cmpl TI_ADDR_LIMIT(%edx),%eax
+	cmpl TI_addr_limit(%edx),%eax
 	jae bad_get_user
 2:	movzwl -1(%eax),%edx
 	xorl %eax,%eax
@@ -52,7 +52,7 @@
 	addl $3,%eax
 	jc bad_get_user
 	GET_THREAD_INFO(%edx)
-	cmpl TI_ADDR_LIMIT(%edx),%eax
+	cmpl TI_addr_limit(%edx),%eax
 	jae bad_get_user
 3:	movl -3(%eax),%edx
 	xorl %eax,%eax
diff -urN linux-2.6.6-bk/include/asm-i386/thread_info.h linux/include/asm-i386/thread_info.h
--- linux-2.6.6-bk/include/asm-i386/thread_info.h	2004-05-11 10:26:57.000000000 -0400
+++ linux/include/asm-i386/thread_info.h	2004-05-13 09:59:26.000000000 -0400
@@ -47,15 +47,7 @@
 
 #else /* !__ASSEMBLY__ */
 
-/* offsets into the thread_info struct for assembly code access */
-#define TI_TASK		0x00000000
-#define TI_EXEC_DOMAIN	0x00000004
-#define TI_FLAGS	0x00000008
-#define TI_STATUS	0x0000000C
-#define TI_CPU		0x00000010
-#define TI_PRE_COUNT	0x00000014
-#define TI_ADDR_LIMIT	0x00000018
-#define TI_RESTART_BLOCK 0x000001C
+#include <asm/asm_offsets.h>
 
 #endif
 

--------------070306010108080301040904--
