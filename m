Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACVO2>; Wed, 3 Jan 2001 16:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbRACVOS>; Wed, 3 Jan 2001 16:14:18 -0500
Received: from box-154.rosh.inter.net.il ([213.8.204.154]:33544 "EHLO
	callisto.yi.org") by vger.kernel.org with ESMTP id <S129267AbRACVOB>;
	Wed, 3 Jan 2001 16:14:01 -0500
Date: Wed, 3 Jan 2001 23:13:31 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: mark@itsolve.co.uk
Subject: [RFC] prevention of syscalls from writable segments, breaking bug
 exploits
Message-ID: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is known that most remote exploits use the fact that stacks are
executable (in i386, at least).

On Linux, they use INT 80 system calls to execute functions in the kernel
as root, when the stack is smashed as a result of a buffer overflow bug in
various server software.

This preliminary, small patch prevents execution of system calls which
were executed from a writable segment. It was tested and seems to work,
without breaking anything. It also reports of such calls by using printk.


--- linux/arch/i386/kernel/entry.S	Tue Dec 12 20:04:08 2000
+++ linux/arch/i386/kernel/entry.S	Wed Jan  3 22:46:24 2001
@@ -78,8 +78,16 @@
 exec_domain	= 16
 need_resched	= 20
 tsk_ptrace	= 24
+tsk_mm		= 44
 processor	= 52
 
+/*
+ * these are offsets into vm_area_struct
+ */
+
+vmas_flags	= 20
+
+
 ENOSYS = 38
 
 
@@ -196,6 +204,26 @@
 	pushl %eax			# save orig_eax
 	SAVE_ALL
 	GET_CURRENT(%ebx)
+
+	/* only execute code from non-writable segments */
+	pushl %ebx
+	pushl %eax
+	movl tsk_mm(%ebx),%eax		# get current->mm
+	movl (EIP+8)(%esp),%ebx		# get caller EIP
+	pushl %ebx
+	pushl %eax
+	call find_vma
+	addl $8,%esp
+	testl %eax,%eax
+	je no_vm_area
+	movl vmas_flags(%eax), %ebx
+	andl $0x02, %ebx
+	cmpl $0x02, %ebx
+	je sys_from_wrong_mem
+no_vm_area:
+	popl %eax
+	popl %ebx
+	
 	cmpl $(NR_syscalls),%eax
 	jae badsys
 	testb $0x02,tsk_ptrace(%ebx)	# PT_TRACESYS
@@ -252,6 +280,15 @@
 tracesys_exit:
 	call SYMBOL_NAME(syscall_trace)
 	jmp ret_from_sys_call
+
+sys_from_wrong_mem:
+	GET_CURRENT(%ebx)
+	push %ebx
+	call print_bad_syscall
+	addl $4,%esp	
+	
+	popl %eax
+	popl %ebx
 badsys:
 	movl $-ENOSYS,EAX(%esp)
 	jmp ret_from_sys_call
--- linux/arch/i386/kernel/process.c	Wed Jan  3 22:57:42 2001
+++ linux/arch/i386/kernel/process.c	Wed Jan  3 22:57:55 2001
@@ -765,3 +765,8 @@
 }
 #undef last_sched
 #undef first_sched
+
+void print_bad_syscall(struct task_struct *task)
+{
+	printk("process %s (%d) tried to syscall from an executable segment!\n", task->comm, task->pid);
+}


-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
