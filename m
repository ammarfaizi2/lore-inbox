Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319211AbSIKQPJ>; Wed, 11 Sep 2002 12:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319173AbSIKQNz>; Wed, 11 Sep 2002 12:13:55 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:20150 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S319211AbSIKQHH> convert rfc822-to-8bit; Wed, 11 Sep 2002 12:07:07 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.34 s390 fixes (4/10): ptrace cleanup.
Date: Wed, 11 Sep 2002 18:08:15 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111801.36667.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
speaking of cleanups, I rewrote the ptrace code and moved all the psw related
defines to ptrace.h. Now its much more readable.

blue skies,
  Martin.

diff -urN linux-2.5.34/arch/s390/kernel/process.c linux-2.5.34-s390/arch/s390/kernel/process.c
--- linux-2.5.34/arch/s390/kernel/process.c	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/arch/s390/kernel/process.c	Tue Sep 10 20:02:27 2002
@@ -75,9 +75,10 @@
 
 	/* 
 	 * Wait for external, I/O or machine check interrupt and
-	 * switch of machine check bit after the wait has ended.
+	 * switch off machine check bit after the wait has ended.
 	 */
-	wait_psw.mask = _WAIT_PSW_MASK;
+	wait_psw.mask = PSW_KERNEL_BITS | PSW_MASK_MCHECK | PSW_MASK_WAIT |
+		PSW_MASK_IO | PSW_MASK_EXT;
 	asm volatile (
 		"    basr %0,0\n"
 		"0:  la   %0,1f-0b(%0)\n"
@@ -114,7 +115,7 @@
 
 	show_registers(regs);
 	/* Show stack backtrace if pt_regs is from kernel mode */
-	if (!(regs->psw.mask & PSW_PROBLEM_STATE))
+	if (!(regs->psw.mask & PSW_MASK_PSTATE))
 		show_trace((unsigned long *) regs->gprs[15]);
 }
 
@@ -135,8 +136,8 @@
 	struct pt_regs regs;
 
 	memset(&regs, 0, sizeof(regs));
-	regs.psw.mask = _SVC_PSW_MASK;
-	regs.psw.addr = (__u32) kernel_thread_starter | _ADDR_31;
+	regs.psw.mask = PSW_KERNEL_BITS;
+	regs.psw.addr = (__u32) kernel_thread_starter | PSW_ADDR_AMODE31;
 	regs.gprs[7] = STACK_FRAME_OVERHEAD;
 	regs.gprs[8] = __LC_KERNEL_STACK;
 	regs.gprs[9] = (unsigned long) fn;
diff -urN linux-2.5.34/arch/s390/kernel/ptrace.c linux-2.5.34-s390/arch/s390/kernel/ptrace.c
--- linux-2.5.34/arch/s390/kernel/ptrace.c	Mon Sep  9 19:35:08 2002
+++ linux-2.5.34-s390/arch/s390/kernel/ptrace.c	Tue Sep 10 20:02:27 2002
@@ -4,6 +4,7 @@
  *  S390 version
  *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
+ *               Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
  *  Based on PowerPC version 
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -21,7 +22,6 @@
  * this archive for more details.
  */
 
-#include <stddef.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -39,266 +39,216 @@
 #include <asm/uaccess.h>
 
 
-void FixPerRegisters(struct task_struct *task)
+static void FixPerRegisters(struct task_struct *task)
 {
-	struct pt_regs *regs = __KSTK_PTREGS(task);
-	per_struct *per_info=
-			(per_struct *)&task->thread.per_info;
+	struct pt_regs *regs;
+	per_struct *per_info;
 
-	per_info->control_regs.bits.em_instruction_fetch=
-	per_info->single_step|per_info->instruction_fetch;
+	regs = __KSTK_PTREGS(task);
+	per_info = (per_struct *) &task->thread.per_info;
+	per_info->control_regs.bits.em_instruction_fetch =
+		per_info->single_step | per_info->instruction_fetch;
 	
-	if(per_info->single_step)
-	{
-		per_info->control_regs.bits.starting_addr=0;
-		per_info->control_regs.bits.ending_addr=0x7fffffffUL;
-	}
-	else
-	{
-		per_info->control_regs.bits.starting_addr=
-		per_info->starting_addr;
-		per_info->control_regs.bits.ending_addr=
-		per_info->ending_addr;
-	}
-	/* if any of the control reg tracing bits are on 
-	   we switch on per in the psw */
-	if(per_info->control_regs.words.cr[0]&PER_EM_MASK)
-		regs->psw.mask |=PSW_PER_MASK;
+	if (per_info->single_step) {
+		per_info->control_regs.bits.starting_addr = 0;
+		per_info->control_regs.bits.ending_addr = 0x7fffffffUL;
+	} else {
+		per_info->control_regs.bits.starting_addr =
+			per_info->starting_addr;
+		per_info->control_regs.bits.ending_addr =
+			per_info->ending_addr;
+	}
+	/*
+	 * if any of the control reg tracing bits are on 
+	 * we switch on per in the psw
+	 */
+	if (per_info->control_regs.words.cr[0] & PER_EM_MASK)
+		regs->psw.mask |= PSW_MASK_PER;
 	else
-		regs->psw.mask &= ~PSW_PER_MASK;
+		regs->psw.mask &= ~PSW_MASK_PER;
+
 	if (per_info->control_regs.bits.em_storage_alteration)
-	{
-		per_info->control_regs.bits.storage_alt_space_ctl=1;
-		//((pgd_t *)__pa(task->mm->pgd))->pgd |= USER_STD_MASK;
-	}
+		per_info->control_regs.bits.storage_alt_space_ctl = 1;
 	else
-	{
-		per_info->control_regs.bits.storage_alt_space_ctl=0;
-		//((pgd_t *)__pa(task->mm->pgd))->pgd &= ~USER_STD_MASK;
-	}
+		per_info->control_regs.bits.storage_alt_space_ctl = 0;
 }
 
 void set_single_step(struct task_struct *task)
 {
-	per_struct *per_info=
-			(per_struct *)&task->thread.per_info;	
-	
-	per_info->single_step=1;  /* Single step */
+	task->thread.per_info.single_step = 1;
 	FixPerRegisters(task);
 }
 
 void clear_single_step(struct task_struct *task)
 {
-	per_struct *per_info=
-			(per_struct *)&task->thread.per_info;
-
-	per_info->single_step=0;
+	task->thread.per_info.single_step = 0;
 	FixPerRegisters(task);
 }
 
-int ptrace_usercopy(addr_t realuseraddr,addr_t copyaddr,int len,int tofromuser,int writeuser,u32 mask)
+/*
+ * Called by kernel/ptrace.c when detaching..
+ *
+ * Make sure single step bits etc are not set.
+ */
+void ptrace_disable(struct task_struct *child)
 {
-	u32  tempuser;
-	int  retval=0;
-	
-	if(writeuser&&realuseraddr==(addr_t)NULL)
-		return(0);
-	if(mask!=0xffffffff)
-	{
-		tempuser=*((u32 *)realuseraddr);
-		if(!writeuser)
-		{
-			tempuser&=mask;
-			realuseraddr=(addr_t)&tempuser;
-		}
-	}
-	if(tofromuser)
-	{
-		if(writeuser)
-		{
-			retval=copy_from_user((void *)realuseraddr,(void *)copyaddr,len) ? -EFAULT : 0;
-		}
-		else
-		{
-			if(realuseraddr==(addr_t)NULL)
-				retval=(clear_user((void *)copyaddr,len) ? -EIO:0);
-			else
-				retval=(copy_to_user((void *)copyaddr,(void *)realuseraddr,len) ? -EIO:0);
-		}      
-	}
-	else
-	{
-		if(writeuser)
-			memcpy((void *)realuseraddr,(void *)copyaddr,len);
-		else
-			memcpy((void *)copyaddr,(void *)realuseraddr,len);
-	}
-	if(mask!=0xffffffff&&writeuser)
-			(*((u32 *)realuseraddr))=(((*((u32 *)realuseraddr))&mask)|(tempuser&~mask));
-	return(retval);
+	/* make sure the single step bit is not set. */
+	clear_single_step(child);
 }
 
-int copy_user(struct task_struct *task,saddr_t useraddr,addr_t copyaddr,int len,int tofromuser,int writingtouser)
+/*
+ * Read the word at offset addr from the user area of a process. The
+ * trouble here is that the information is littered over different
+ * locations. The process registers are found on the kernel stack,
+ * the floating point stuff and the trace settings are stored in
+ * the task structure. In addition the different structures in
+ * struct user contain pad bytes that should be read as zeroes.
+ * Lovely...
+ */
+static int peek_user(struct task_struct *child, addr_t addr, addr_t data)
 {
-	int copylen=0,copymax;
-	addr_t  realuseraddr;
-	saddr_t enduseraddr=useraddr+len;
-	
-	u32 mask;
+	struct user *dummy = NULL;
+	addr_t offset;
+	__u32 tmp;
+
+	if ((addr & 3) || addr > sizeof(struct user) - 3)
+		return -EIO;
+
+	if (addr <= (addr_t) &dummy->regs.orig_gpr2) {
+		/*
+		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 */
+		tmp = *(__u32 *)((addr_t) __KSTK_PTREGS(child) + addr);
+
+	} else if (addr >= (addr_t) &dummy->regs.fp_regs &&
+		   addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
+		/* 
+		 * floating point regs. are stored in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy->regs.fp_regs;
+		tmp = *(__u32 *)((addr_t) &child->thread.fp_regs + offset);
+
+	} else if (addr >= (addr_t) &dummy->regs.per_info &&
+		   addr < (addr_t) (&dummy->regs.per_info + 1)) {
+		/*
+		 * per_info is found in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy->regs.per_info;
+		tmp = *(__u32 *)((addr_t) &child->thread.per_info + offset);
 
-	if (useraddr < 0 || enduseraddr > sizeof(struct user)||
-	   (useraddr < PT_ENDREGS && (useraddr&3))||
-	   (enduseraddr < PT_ENDREGS && (enduseraddr&3)))
-		return (-EIO);
-	while(len>0)
-	{
-		mask=0xffffffff;
-		if(useraddr<PT_FPC)
-		{
-			realuseraddr=((addr_t) __KSTK_PTREGS(task)) + useraddr;
-			if(useraddr<PT_PSWMASK)
-			{
-				copymax=PT_PSWMASK;
-			}
-			else if(useraddr<(PT_PSWMASK+4))
-			{
-				copymax=(PT_PSWMASK+4);
-				if(writingtouser)
-					mask=PSW_MASK_DEBUGCHANGE;
-			}
-			else if(useraddr<(PT_PSWADDR+4))
-			{
-				copymax=PT_PSWADDR+4;
-				mask=PSW_ADDR_DEBUGCHANGE;
-			}
-			else
-				copymax=PT_FPC;
-			
-		}
-		else if(useraddr<(PT_FPR15_LO+4))
-		{
-			copymax=(PT_FPR15_LO+4);
-			realuseraddr=(addr_t)&(((u8 *)&task->thread.fp_regs)[useraddr-PT_FPC]);
-		}
-		else if(useraddr<sizeof(struct user_regs_struct))
-		{
-			copymax=sizeof(struct user_regs_struct);
-			realuseraddr=(addr_t)&(((u8 *)&task->thread.per_info)[useraddr-PT_CR_9]);
-		}
-		else 
-		{
-			copymax=sizeof(struct user);
-			realuseraddr=(addr_t)NULL;
-		}
-		copylen=copymax-useraddr;
-		copylen=(copylen>len ? len:copylen);
-		if(ptrace_usercopy(realuseraddr,copyaddr,copylen,tofromuser,writingtouser,mask))
-			return (-EIO);
-		copyaddr+=copylen;
-		len-=copylen;
-		useraddr+=copylen;
-	}
-	FixPerRegisters(task);
-	return(0);
+	} else
+		tmp = 0;
+
+	return put_user(tmp, (__u32 *) data);
 }
 
 /*
- * Called by kernel/ptrace.c when detaching..
- *
- * Make sure single step bits etc are not set.
+ * Write a word to the user area of a process at location addr. This
+ * operation does have an additional problem compared to peek_user.
+ * Stores to the program status word and on the floating point
+ * control register needs to get checked for validity.
  */
-void ptrace_disable(struct task_struct *child)
+static int poke_user(struct task_struct *child, addr_t addr, addr_t data)
 {
-	/* make sure the single step bit is not set. */
-	clear_single_step(child);
+	struct user *dummy = NULL;
+	addr_t offset;
+
+	if ((addr & 3) || addr > sizeof(struct user) - 3)
+		return -EIO;
+
+	if (addr <= (addr_t) &dummy->regs.orig_gpr2) {
+		/*
+		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 */
+		if (addr == (addr_t) &dummy->regs.psw.mask &&
+		    (data & ~PSW_MASK_CC) != PSW_USER_BITS)
+			/* Invalid psw mask. */
+			return -EINVAL;
+		if (addr == (addr_t) &dummy->regs.psw.addr)
+			/* I'd like to reject addresses without the
+			   high order bit but older gdb's rely on it */
+			data |= PSW_ADDR_AMODE31;
+		*(__u32 *)((addr_t) __KSTK_PTREGS(child) + addr) = data;
+
+	} else if (addr >= (addr_t) &dummy->regs.fp_regs &&
+		   addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
+		/*
+		 * floating point regs. are stored in the thread structure
+		 */
+		if (addr == (addr_t) &dummy->regs.fp_regs.fpc &&
+		    (data & ~FPC_VALID_MASK) != 0)
+			return -EINVAL;
+		offset = addr - (addr_t) &dummy->regs.fp_regs;
+		*(__u32 *)((addr_t) &child->thread.fp_regs + offset) = data;
+
+	} else if (addr >= (addr_t) &dummy->regs.per_info &&
+		   addr < (addr_t) (&dummy->regs.per_info + 1)) {
+		/*
+		 * per_info is found in the thread structure 
+		 */
+		offset = addr - (addr_t) &dummy->regs.per_info;
+		*(__u32 *)((addr_t) &child->thread.per_info + offset) = data;
+
+	}
+
+	FixPerRegisters(child);
+	return 0;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+static int
+do_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
-	int ret = -EPERM;
 	unsigned long tmp;
-	int copied;
-	ptrace_area   parea; 
+	ptrace_area parea; 
+	int copied, ret;
 
-	lock_kernel();
-	if (request == PTRACE_TRACEME) 
-	{
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
-		goto out;
-	}
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (!child)
-		goto out;
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-	if (request == PTRACE_ATTACH) 
-	{
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-	ret = -ESRCH;
-	// printk("child=%lX child->flags=%lX",child,child->flags);
-	/* I added child!=current line so we can get the */
-	/* ieee_instruction_pointer from the user structure DJB */
-	if(child!=current)
-	{
-		if (!(child->ptrace & PT_PTRACED))
-			goto out_tsk;
-		if (child->state != TASK_STOPPED) 
-		{
-			if (request != PTRACE_KILL)
-				goto out_tsk;
-		}
-		if (child->parent != current)
-			goto out_tsk;
-	}
-	switch (request) 
-	{
-		/* If I and D space are separate, these will need to be fixed. */
-	case PTRACE_PEEKTEXT: /* read word at location addr. */ 
-	case PTRACE_PEEKDATA: 
-		copied = access_process_vm(child,ADDR_BITS_REMOVE(addr), &tmp, sizeof(tmp), 0);
-		ret = -EIO;
+	if (request == PTRACE_ATTACH)
+		return ptrace_attach(child);
+
+	/*
+	 * I added child != current line so we can get the
+	 * ieee_instruction_pointer from the user structure DJB
+	 */
+	if (child != current) {
+		ret = ptrace_check_attach(child, request == PTRACE_KILL);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Remove high order bit from address. */
+	addr &= PSW_ADDR_INSN;
+
+	switch (request) {
+	case PTRACE_PEEKTEXT:
+	case PTRACE_PEEKDATA:
+		/* read word at location addr. */
+		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
 		if (copied != sizeof(tmp))
-			break;
-		ret = put_user(tmp,(unsigned long *) data);
-		break;
+			return -EIO;
+		return put_user(tmp, (unsigned long *) data);
 
-		/* read the word at location addr in the USER area. */
 	case PTRACE_PEEKUSR:
-		ret=copy_user(child,addr,data,sizeof(unsigned long),1,0);
-		break;
+		/* read the word at location addr in the USER area. */
+		return peek_user(child, addr, data);
 
-		/* If I and D space are separate, this will have to be fixed. */
-	case PTRACE_POKETEXT: /* write the word at location addr. */
+	case PTRACE_POKETEXT:
 	case PTRACE_POKEDATA:
-		ret = 0;
-		if (access_process_vm(child,ADDR_BITS_REMOVE(addr), &data, sizeof(data), 1) == sizeof(data))
-			break;
-		ret = -EIO;
-		break;
-
-	case PTRACE_POKEUSR: /* write the word at location addr in the USER area */
-		ret=copy_user(child,addr,(addr_t)&data,sizeof(unsigned long),0,1);
-		break;
-
-	case PTRACE_SYSCALL: 	/* continue and stop at next (return from) syscall */
-	case PTRACE_CONT: 	 /* restart after signal. */
-		ret = -EIO;
+		/* write the word at location addr. */
+		copied = access_process_vm(child, addr, &data, sizeof(data),1);
+		if (copied != sizeof(data))
+			return -EIO;
+		return 0;
+
+	case PTRACE_POKEUSR:
+		/* write the word at location addr in the USER area */
+		return poke_user(child, addr, data);
+
+	case PTRACE_SYSCALL:
+		/* continue and stop at next (return from) syscall */
+	case PTRACE_CONT:
+		/* restart after signal. */
 		if ((unsigned long) data >= _NSIG)
-			break;
+			return -EIO;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		else
@@ -307,60 +257,104 @@
 		/* make sure the single step bit is not set. */
 		clear_single_step(child);
 		wake_up_process(child);
-		ret = 0;
-		break;
+		return 0;
 
-/*
- * make the child exit.  Best I can do is send it a sigkill. 
- * perhaps it should be put in the status that it wants to 
- * exit.
- */
 	case PTRACE_KILL:
-		ret = 0;
+		/*
+		 * make the child exit.  Best I can do is send it a sigkill. 
+		 * perhaps it should be put in the status that it wants to 
+		 * exit.
+		 */
 		if (child->state == TASK_ZOMBIE) /* already dead */
-			break;
+			return 0;
 		child->exit_code = SIGKILL;
+		/* make sure the single step bit is not set. */
 		clear_single_step(child);
 		wake_up_process(child);
-		/* make sure the single step bit is not set. */
-		break;
+		return 0;
 
-	case PTRACE_SINGLESTEP:  /* set the trap flag. */
-		ret = -EIO;
+	case PTRACE_SINGLESTEP:
+		/* set the trap flag. */
 		if ((unsigned long) data >= _NSIG)
-			break;
+			return -EIO;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
 		set_single_step(child);
 		/* give it a chance to run. */
 		wake_up_process(child);
-		ret = 0;
-		break;
+		return 0;
+
+	case PTRACE_DETACH:
+		/* detach a process that was attached. */
+		return ptrace_detach(child, data);
 
-	case PTRACE_DETACH:  /* detach a process that was attached. */
-		ret = ptrace_detach(child, data);
-		break;
 	case PTRACE_PEEKUSR_AREA:
 	case PTRACE_POKEUSR_AREA:
-		if((ret=copy_from_user(&parea,(void *)addr,sizeof(parea)))==0)  
-		   ret=copy_user(child,parea.kernel_addr,parea.process_addr,
-				 parea.len,1,(request==PTRACE_POKEUSR_AREA));
-		break;
-	case PTRACE_SETOPTIONS: {
+		if (!copy_from_user(&parea, (void *) addr, sizeof(parea)))
+			return -EFAULT;
+		addr = parea.kernel_addr;
+		data = parea.process_addr;
+		copied = 0;
+		while (copied < parea.len) {
+			if (request == PTRACE_PEEKUSR_AREA)
+				ret = peek_user(child, addr, data);
+			else
+				ret = poke_user(child, addr, data);
+			if (ret)
+				return ret;
+			addr += sizeof(unsigned long);
+			data += sizeof(unsigned long);
+			copied += sizeof(unsigned long);
+		}
+		return 0;
+
+	case PTRACE_SETOPTIONS:
 		if (data & PTRACE_O_TRACESYSGOOD)
 			child->ptrace |= PT_TRACESYSGOOD;
 		else
 			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
-		break;
+		return 0;
 	}
-	default:
-		ret = -EIO;
-		break;
+	return -EIO;
+}
+
+asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+{
+	struct task_struct *child;
+	int ret;
+
+	lock_kernel();
+
+	if (request == PTRACE_TRACEME) {
+		/* are we already being traced? */
+		ret = -EPERM;
+		if (current->ptrace & PT_PTRACED)
+			goto out;
+		ret = security_ops->ptrace(current->parent, current);
+		if (ret)
+			goto out;
+		/* set the ptrace bit in the process flags. */
+		current->ptrace |= PT_PTRACED;
+		goto out;
 	}
- out_tsk:
+
+	ret = -EPERM;
+	if (pid == 1)		/* you may not mess with init */
+		goto out;
+
+	ret = -ESRCH;
+	read_lock(&tasklist_lock);
+	child = find_task_by_pid(pid);
+	if (child)
+		get_task_struct(child);
+	read_unlock(&tasklist_lock);
+	if (!child)
+		goto out;
+
+	ret = do_ptrace(child, request, addr, data);
+
 	put_task_struct(child);
- out:
+out:
 	unlock_kernel();
 	return ret;
 }
@@ -371,8 +365,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
+	current->exit_code =
+		SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -urN linux-2.5.34/arch/s390/kernel/setup.c linux-2.5.34-s390/arch/s390/kernel/setup.c
--- linux-2.5.34/arch/s390/kernel/setup.c	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/arch/s390/kernel/setup.c	Tue Sep 10 20:02:27 2002
@@ -305,7 +305,7 @@
 	unsigned long start_pfn, end_pfn;
         static unsigned int smptrap=0;
         unsigned long delay = 0;
-	struct _lowcore *lowcore;
+	struct _lowcore *lc;
 	int i;
 
         if (smptrap)
@@ -452,27 +452,26 @@
         /*
          * Setup lowcore for boot cpu
          */
-	lowcore = (struct _lowcore *)
-		__alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0);
-	memset(lowcore, 0, PAGE_SIZE);
-	lowcore->restart_psw.mask = _RESTART_PSW_MASK;
-	lowcore->restart_psw.addr = _ADDR_31 + (addr_t) &restart_int_handler;
-	lowcore->external_new_psw.mask = _EXT_PSW_MASK;
-	lowcore->external_new_psw.addr = _ADDR_31 + (addr_t) &ext_int_handler;
-	lowcore->svc_new_psw.mask = _SVC_PSW_MASK;
-	lowcore->svc_new_psw.addr = _ADDR_31 + (addr_t) &system_call;
-	lowcore->program_new_psw.mask = _PGM_PSW_MASK;
-	lowcore->program_new_psw.addr = _ADDR_31 + (addr_t) &pgm_check_handler;
-        lowcore->mcck_new_psw.mask = _MCCK_PSW_MASK;
-	lowcore->mcck_new_psw.addr = _ADDR_31 + (addr_t) &mcck_int_handler;
-	lowcore->io_new_psw.mask = _IO_PSW_MASK;
-	lowcore->io_new_psw.addr = _ADDR_31 + (addr_t) &io_int_handler;
-	lowcore->ipl_device = S390_lowcore.ipl_device;
-	lowcore->kernel_stack = ((__u32) &init_thread_union) + 8192;
-	lowcore->async_stack = (__u32)
+	lc = (struct _lowcore *) __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0);
+	memset(lc, 0, PAGE_SIZE);
+	lc->restart_psw.mask = PSW_BASE_BITS;
+	lc->restart_psw.addr = PSW_ADDR_AMODE31 + (__u32) restart_int_handler;
+	lc->external_new_psw.mask = PSW_KERNEL_BITS;
+	lc->external_new_psw.addr = PSW_ADDR_AMODE31 + (__u32) ext_int_handler;
+	lc->svc_new_psw.mask = PSW_KERNEL_BITS;
+	lc->svc_new_psw.addr = PSW_ADDR_AMODE31 + (__u32) system_call;
+	lc->program_new_psw.mask = PSW_KERNEL_BITS;
+	lc->program_new_psw.addr = PSW_ADDR_AMODE31 + (__u32)pgm_check_handler;
+        lc->mcck_new_psw.mask = PSW_KERNEL_BITS;
+	lc->mcck_new_psw.addr = PSW_ADDR_AMODE31 + (__u32) mcck_int_handler;
+	lc->io_new_psw.mask = PSW_KERNEL_BITS;
+	lc->io_new_psw.addr = PSW_ADDR_AMODE31 + (__u32) io_int_handler;
+	lc->ipl_device = S390_lowcore.ipl_device;
+	lc->kernel_stack = ((__u32) &init_thread_union) + 8192;
+	lc->async_stack = (__u32)
 		__alloc_bootmem(2*PAGE_SIZE, 2*PAGE_SIZE, 0) + 8192;
-	lowcore->jiffy_timer = -1LL;
-	set_prefix((__u32) lowcore);
+	lc->jiffy_timer = -1LL;
+	set_prefix((__u32) lc);
         cpu_init();
         boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
         __cpu_logical_map[0] = boot_cpu_addr;
diff -urN linux-2.5.34/arch/s390/kernel/signal.c linux-2.5.34-s390/arch/s390/kernel/signal.c
--- linux-2.5.34/arch/s390/kernel/signal.c	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/arch/s390/kernel/signal.c	Tue Sep 10 20:02:27 2002
@@ -167,8 +167,8 @@
 	int err;
 
 	err = __copy_from_user(regs, &sregs->regs, sizeof(_s390_regs_common));
-	regs->psw.mask = _USER_PSW_MASK | (regs->psw.mask & PSW_MASK_DEBUGCHANGE);
-	regs->psw.addr |= _ADDR_31;
+	regs->psw.mask = PSW_USER_BITS | (regs->psw.mask & PSW_MASK_CC);
+	regs->psw.addr |= PSW_ADDR_AMODE31;
 	if (err)
 		return err;
 
@@ -298,9 +298,9 @@
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER) {
-                regs->gprs[14] = FIX_PSW(ka->sa.sa_restorer);
+                regs->gprs[14] = (__u32) ka->sa.sa_restorer | PSW_ADDR_AMODE31;
 	} else {
-                regs->gprs[14] = FIX_PSW(frame->retcode);
+                regs->gprs[14] = (__u32) frame->retcode | PSW_ADDR_AMODE31;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn, 
 	                       (u16 *)(frame->retcode)))
 			goto give_sigsegv;
@@ -311,12 +311,12 @@
 		goto give_sigsegv;
 
 	/* Set up registers for signal handler */
-	regs->gprs[15] = (addr_t)frame;
-	regs->psw.addr = FIX_PSW(ka->sa.sa_handler);
-	regs->psw.mask = _USER_PSW_MASK;
+	regs->gprs[15] = (__u32) frame;
+	regs->psw.addr = (__u32) ka->sa.sa_handler | PSW_ADDR_AMODE31;
+	regs->psw.mask = PSW_USER_BITS;
 
 	regs->gprs[2] = map_signal(sig);
-	regs->gprs[3] = (addr_t)&frame->sc;
+	regs->gprs[3] = (__u32) &frame->sc;
 
 	/* We forgot to include these in the sigcontext.
 	   To avoid breaking binary compatibility, they are passed as args. */
@@ -356,9 +356,9 @@
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER) {
-                regs->gprs[14] = FIX_PSW(ka->sa.sa_restorer);
+                regs->gprs[14] = (__u32) ka->sa.sa_restorer | PSW_ADDR_AMODE31;
 	} else {
-                regs->gprs[14] = FIX_PSW(frame->retcode);
+                regs->gprs[14] = (__u32) frame->retcode | PSW_ADDR_AMODE31;
 		err |= __put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn, 
 	                          (u16 *)(frame->retcode));
 	}
@@ -368,13 +368,13 @@
 		goto give_sigsegv;
 
 	/* Set up registers for signal handler */
-	regs->gprs[15] = (addr_t)frame;
-	regs->psw.addr = FIX_PSW(ka->sa.sa_handler);
-	regs->psw.mask = _USER_PSW_MASK;
+	regs->gprs[15] = (__u32) frame;
+	regs->psw.addr = (__u32) ka->sa.sa_handler | PSW_ADDR_AMODE31;
+	regs->psw.mask = PSW_USER_BITS;
 
 	regs->gprs[2] = map_signal(sig);
-	regs->gprs[3] = (addr_t)&frame->info;
-	regs->gprs[4] = (addr_t)&frame->uc;
+	regs->gprs[3] = (__u32) &frame->info;
+	regs->gprs[4] = (__u32) &frame->uc;
 	return;
 
 give_sigsegv:
diff -urN linux-2.5.34/arch/s390/kernel/traps.c linux-2.5.34-s390/arch/s390/kernel/traps.c
--- linux-2.5.34/arch/s390/kernel/traps.c	Mon Sep  9 19:35:08 2002
+++ linux-2.5.34-s390/arch/s390/kernel/traps.c	Tue Sep 10 20:02:27 2002
@@ -116,22 +116,22 @@
 		stack = (unsigned long*)&stack;
 
 	printk("Call Trace: ");
-	low_addr = ((unsigned long) stack) & PSW_ADDR_MASK;
+	low_addr = ((unsigned long) stack) & PSW_ADDR_INSN;
 	high_addr = (low_addr & (-THREAD_SIZE)) + THREAD_SIZE;
 	/* Skip the first frame (biased stack) */
-	backchain = *((unsigned long *) low_addr) & PSW_ADDR_MASK;
+	backchain = *((unsigned long *) low_addr) & PSW_ADDR_INSN;
 	/* Print up to 8 lines */
 	for (i = 0; i < 8; i++) {
 		if (backchain < low_addr || backchain >= high_addr)
 			break;
-		ret_addr = *((unsigned long *) (backchain+56)) & PSW_ADDR_MASK;
+		ret_addr = *((unsigned long *) (backchain+56)) & PSW_ADDR_INSN;
 		if (!kernel_text_address(ret_addr))
 			break;
 		if (i && ((i % 6) == 0))
 			printk("\n   ");
 		printk("[<%08lx>] ", ret_addr);
 		low_addr = backchain;
-		backchain = *((unsigned long *) backchain) & PSW_ADDR_MASK;
+		backchain = *((unsigned long *) backchain) & PSW_ADDR_INSN;
 	}
 	printk("\n");
 }
@@ -176,7 +176,7 @@
 	char *mode;
 	int i;
 
-	mode = (regs->psw.mask & PSW_PROBLEM_STATE) ? "User" : "Krnl";
+	mode = (regs->psw.mask & PSW_MASK_PSTATE) ? "User" : "Krnl";
 	printk("%s PSW : %08lx %08lx\n",
 	       mode, (unsigned long) regs->psw.mask,
 	       (unsigned long) regs->psw.addr);
@@ -202,7 +202,7 @@
 	 * time of the fault.
 	 */
 	old_fs = get_fs();
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		set_fs(USER_DS);
 	else
 		set_fs(KERNEL_DS);
@@ -279,10 +279,10 @@
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
 	 */
-        if (regs->psw.mask & PSW_PROBLEM_STATE)
+        if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
-        if (regs->psw.mask & PSW_PROBLEM_STATE) {
+        if (regs->psw.mask & PSW_MASK_PSTATE) {
                 struct task_struct *tsk = current;
 
                 tsk->thread.trap_no = interruption_code & 0xffff;
@@ -314,12 +314,12 @@
 
 static inline void *get_check_address(struct pt_regs *regs)
 {
-	return (void *) ADDR_BITS_REMOVE(regs->psw.addr-S390_lowcore.pgm_ilc);
+	return (void *)((regs->psw.addr-S390_lowcore.pgm_ilc) & PSW_ADDR_INSN);
 }
 
 int do_debugger_trap(struct pt_regs *regs,int signal)
 {
-	if(regs->psw.mask&PSW_PROBLEM_STATE)
+	if(regs->psw.mask&PSW_MASK_PSTATE)
 	{
 		if(current->ptrace & PT_PTRACED)
 			force_sig(signal,current);
@@ -415,10 +415,10 @@
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
 	 */
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		get_user(*((__u16 *) opcode), location);
 	else
 		*((__u16 *)opcode)=*((__u16 *)location);
@@ -428,7 +428,7 @@
 			signal = SIGILL;
 	}
 #ifdef CONFIG_MATHEMU
-        else if (regs->psw.mask & PSW_PROBLEM_STATE)
+        else if (regs->psw.mask & PSW_MASK_PSTATE)
 	{
 		if (opcode[0] == 0xb3) {
 			get_user(*((__u16 *) (opcode+2)), location+1);
@@ -476,10 +476,10 @@
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
 	 */
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 		
-        if (regs->psw.mask & PSW_PROBLEM_STATE) {
+        if (regs->psw.mask & PSW_MASK_PSTATE) {
 		get_user(*((__u16 *) opcode), location);
 		switch (opcode[0]) {
 		case 0x28: /* LDR Rx,Ry   */
@@ -539,7 +539,7 @@
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
 	 */
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
 	if (MACHINE_HAS_IEEE)
@@ -547,7 +547,7 @@
 				  : "=m" (current->thread.fp_regs.fpc));
 
 #ifdef CONFIG_MATHEMU
-        else if (regs->psw.mask & PSW_PROBLEM_STATE) {
+        else if (regs->psw.mask & PSW_MASK_PSTATE) {
         	__u8 opcode[6];
 		get_user(*((__u16 *) opcode), location);
 		switch (opcode[0]) {
@@ -671,21 +671,19 @@
 
 void handle_per_exception(struct pt_regs *regs)
 {
-	if(regs->psw.mask&PSW_PROBLEM_STATE)
-	{
+	if (regs->psw.mask & PSW_MASK_PSTATE) {
 		per_struct *per_info=&current->thread.per_info;
 		per_info->lowcore.words.perc_atmid=S390_lowcore.per_perc_atmid;
 		per_info->lowcore.words.address=S390_lowcore.per_address;
 		per_info->lowcore.words.access_id=S390_lowcore.per_access_id;
 	}
-	if(do_debugger_trap(regs,SIGTRAP))
-	{
+	if (do_debugger_trap(regs,SIGTRAP)) {
 		/* I've seen this possibly a task structure being reused ? */
 		printk("Spurious per exception detected\n");
 		printk("switching off per tracing for this task.\n");
 		show_regs(regs);
 		/* Hopefully switching off per tracing will help us survive */
-		regs->psw.mask &= ~PSW_PER_MASK;
+		regs->psw.mask &= ~PSW_MASK_PER;
 	}
 }
 
diff -urN linux-2.5.34/arch/s390/mm/extable.c linux-2.5.34-s390/arch/s390/mm/extable.c
--- linux-2.5.34/arch/s390/mm/extable.c	Mon Sep  9 19:35:03 2002
+++ linux-2.5.34-s390/arch/s390/mm/extable.c	Tue Sep 10 20:02:27 2002
@@ -48,7 +48,7 @@
         addr &= 0x7fffffff;  /* remove amode bit from address */
 	/* There is only the kernel to search.  */
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
-	if (ret) ret = FIX_PSW(ret);
+	if (ret) ret = ret | PSW_ADDR_AMODE31;
 	return ret;
 #else
 	unsigned long flags;
@@ -63,7 +63,7 @@
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret) {
-			ret = FIX_PSW(ret);
+			ret = ret | PSW_ADDR_AMODE31;
 			break;
 		}
 	}
diff -urN linux-2.5.34/arch/s390/mm/fault.c linux-2.5.34-s390/arch/s390/mm/fault.c
--- linux-2.5.34/arch/s390/mm/fault.c	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/arch/s390/mm/fault.c	Tue Sep 10 20:02:27 2002
@@ -167,7 +167,7 @@
 
 		/* Low-address protection hit in kernel mode means 
 		   NULL pointer write access in kernel mode.  */
- 		if (!(regs->psw.mask & PSW_PROBLEM_STATE)) {
+ 		if (!(regs->psw.mask & PSW_MASK_PSTATE)) {
 			address = 0;
 			user_address = 0;
 			goto no_context;
@@ -259,7 +259,7 @@
         up_read(&mm->mmap_sem);
 
         /* User mode accesses just cause a SIGSEGV */
-        if (regs->psw.mask & PSW_PROBLEM_STATE) {
+        if (regs->psw.mask & PSW_MASK_PSTATE) {
                 tsk->thread.prot_addr = address;
                 tsk->thread.trap_no = error_code;
 		force_sigsegv(regs, error_code, si_code, address);
@@ -299,7 +299,7 @@
 		goto survive;
 	}
 	printk("VM: killing process %s\n", tsk->comm);
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		do_exit(SIGKILL);
 	goto no_context;
 
@@ -315,7 +315,7 @@
 	force_sig(SIGBUS, tsk);
 
 	/* Kernel mode? Handle exceptions or die */
-	if (!(regs->psw.mask & PSW_PROBLEM_STATE))
+	if (!(regs->psw.mask & PSW_MASK_PSTATE))
 		goto no_context;
 }
 
@@ -394,7 +394,7 @@
                 spin_unlock(&pseudo_wait_spinlock);
         } else {
                 /* Pseudo page faults in kernel mode is a bad idea */
-                if (!(regs->psw.mask & PSW_PROBLEM_STATE)) {
+                if (!(regs->psw.mask & PSW_MASK_PSTATE)) {
                         /*
 			 * VM presents pseudo page faults if the interrupted
 			 * state was not disabled for interrupts. So we can
@@ -529,7 +529,7 @@
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
 	 */
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
 	if (subcode & 0x0080) {
diff -urN linux-2.5.34/arch/s390x/kernel/linux32.h linux-2.5.34-s390/arch/s390x/kernel/linux32.h
--- linux-2.5.34/arch/s390x/kernel/linux32.h	Mon Sep  9 19:35:18 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/linux32.h	Tue Sep 10 20:02:27 2002
@@ -8,8 +8,6 @@
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/export.h>
 
-#ifdef CONFIG_S390_SUPPORT
-
 /* Macro that masks the high order bit of an 32 bit pointer and converts it*/
 /*       to a 64 bit pointer */
 #define A(__x) ((unsigned long)((__x) & 0x7FFFFFFFUL))
@@ -194,6 +192,32 @@
         __u32	addr;
 } _psw_t32 __attribute__ ((aligned(8)));
 
+#define PSW32_MASK_PER		0x40000000UL
+#define PSW32_MASK_DAT		0x04000000UL
+#define PSW32_MASK_IO		0x02000000UL
+#define PSW32_MASK_EXT		0x01000000UL
+#define PSW32_MASK_KEY		0x00F00000UL
+#define PSW32_MASK_MCHECK	0x00040000UL
+#define PSW32_MASK_WAIT		0x00020000UL
+#define PSW32_MASK_PSTATE	0x00010000UL
+#define PSW32_MASK_ASC		0x0000C000UL
+#define PSW32_MASK_CC		0x00003000UL
+#define PSW32_MASK_PM		0x00000f00UL
+
+#define PSW32_ADDR_AMODE31	0x80000000UL
+#define PSW32_ADDR_INSN		0x7FFFFFFFUL
+
+#define PSW32_BASE_BITS		0x00080000UL
+
+#define PSW32_ASC_PRIMARY	0x00000000UL
+#define PSW32_ASC_ACCREG	0x00004000UL
+#define PSW32_ASC_SECONDARY	0x00008000UL
+#define PSW32_ASC_HOME		0x0000C000UL
+
+#define PSW32_USER_BITS	(PSW32_BASE_BITS | PSW32_MASK_DAT | PSW32_ASC_HOME | \
+			 PSW32_MASK_IO | PSW32_MASK_EXT | PSW32_MASK_MCHECK | \
+			 PSW32_MASK_PSTATE)
+
 typedef struct
 {
 	_psw_t32	psw;
@@ -241,6 +265,4 @@
 	sigset_t32		uc_sigmask;	/* mask last for extensibility */
 };
 
-#endif /* !CONFIG_S390_SUPPORT */
- 
 #endif /* _ASM_S390X_S390_H */
diff -urN linux-2.5.34/arch/s390x/kernel/process.c linux-2.5.34-s390/arch/s390x/kernel/process.c
--- linux-2.5.34/arch/s390x/kernel/process.c	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/process.c	Tue Sep 10 20:02:27 2002
@@ -75,9 +75,10 @@
 
 	/* 
 	 * Wait for external, I/O or machine check interrupt and
-	 * switch of machine check bit after the wait has ended.
+	 * switch off machine check bit after the wait has ended.
 	 */
-	wait_psw.mask = _WAIT_PSW_MASK;
+	wait_psw.mask = PSW_KERNEL_BITS | PSW_MASK_MCHECK | PSW_MASK_WAIT |
+		PSW_MASK_IO | PSW_MASK_EXT;
 	asm volatile (
 		"    larl  %0,0f\n"
 		"    stg   %0,8(%1)\n"
@@ -111,7 +112,7 @@
 
 	show_registers(regs);
 	/* Show stack backtrace if pt_regs is from kernel mode */
-	if (!(regs->psw.mask & PSW_PROBLEM_STATE))
+	if (!(regs->psw.mask & PSW_MASK_PSTATE))
 		show_trace((unsigned long *) regs->gprs[15]);
 }
 
@@ -132,7 +133,7 @@
 	struct pt_regs regs;
 
 	memset(&regs, 0, sizeof(regs));
-	regs.psw.mask = _SVC_PSW_MASK;
+	regs.psw.mask = PSW_KERNEL_BITS;
 	regs.psw.addr = (__u64) kernel_thread_starter;
 	regs.gprs[7] = STACK_FRAME_OVERHEAD;
 	regs.gprs[8] = __LC_KERNEL_STACK;
diff -urN linux-2.5.34/arch/s390x/kernel/ptrace.c linux-2.5.34-s390/arch/s390x/kernel/ptrace.c
--- linux-2.5.34/arch/s390x/kernel/ptrace.c	Mon Sep  9 19:35:02 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/ptrace.c	Tue Sep 10 20:02:27 2002
@@ -4,6 +4,7 @@
  *  S390 version
  *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
+ *               Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
  *  Based on PowerPC version 
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -38,49 +39,48 @@
 #include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+
 #ifdef CONFIG_S390_SUPPORT
-#include "linux32.h"
-#else
-#define parent_31bit 0
+#include "ptrace32.h"
 #endif
 
-
-void FixPerRegisters(struct task_struct *task)
+static void FixPerRegisters(struct task_struct *task)
 {
-	struct pt_regs *regs = __KSTK_PTREGS(task);
-	per_struct *per_info=
-			(per_struct *)&task->thread.per_info;
+	struct pt_regs *regs;
+	per_struct *per_info;
 
+	regs = __KSTK_PTREGS(task);
+	per_info = (per_struct *) &task->thread.per_info;
 	per_info->control_regs.bits.em_instruction_fetch =
-	        per_info->single_step | per_info->instruction_fetch;
+		per_info->single_step | per_info->instruction_fetch;
 	
 	if (per_info->single_step) {
-		per_info->control_regs.bits.starting_addr=0;
+		per_info->control_regs.bits.starting_addr = 0;
 #ifdef CONFIG_S390_SUPPORT
-		if (current->thread.flags & S390_FLAG_31BIT) {
-			per_info->control_regs.bits.ending_addr=0x7fffffffUL;
-	        }
-		else 
-#endif      
-		{
-		per_info->control_regs.bits.ending_addr=-1L;
-		}
+		if (current->thread.flags & S390_FLAG_31BIT)
+			per_info->control_regs.bits.ending_addr = 0x7fffffffUL;
+		else
+#endif
+			per_info->control_regs.bits.ending_addr = -1;
 	} else {
-		per_info->control_regs.bits.starting_addr=
-		        per_info->starting_addr;
-		per_info->control_regs.bits.ending_addr=
-		        per_info->ending_addr;
+		per_info->control_regs.bits.starting_addr =
+			per_info->starting_addr;
+		per_info->control_regs.bits.ending_addr =
+			per_info->ending_addr;
 	}
-	/* if any of the control reg tracing bits are on 
-	   we switch on per in the psw */
+	/*
+	 * if any of the control reg tracing bits are on 
+	 * we switch on per in the psw
+	 */
 	if (per_info->control_regs.words.cr[0] & PER_EM_MASK)
-		regs->psw.mask |= PSW_PER_MASK;
+		regs->psw.mask |= PSW_MASK_PER;
 	else
-		regs->psw.mask &= ~PSW_PER_MASK;
-	if (per_info->control_regs.bits.storage_alt_space_ctl)
-		task->thread.user_seg |= USER_STD_MASK;
+		regs->psw.mask &= ~PSW_MASK_PER;
+
+	if (per_info->control_regs.bits.em_storage_alteration)
+		per_info->control_regs.bits.storage_alt_space_ctl = 1;
 	else
-		task->thread.user_seg &= ~USER_STD_MASK;
+		per_info->control_regs.bits.storage_alt_space_ctl = 0;
 }
 
 void set_single_step(struct task_struct *task)
@@ -99,424 +99,406 @@
 	FixPerRegisters (task);
 }
 
-int ptrace_usercopy(addr_t realuseraddr, addr_t copyaddr, int len,
-                    int tofromuser, int writeuser, unsigned long mask)
+/*
+ * Called by kernel/ptrace.c when detaching..
+ *
+ * Make sure single step bits etc are not set.
+ */
+void ptrace_disable(struct task_struct *child)
 {
-        unsigned long *realuserptr, *copyptr;
-	unsigned long tempuser;
-	int retval;
-
-        retval = 0;
-        realuserptr = (unsigned long *) realuseraddr;
-        copyptr = (unsigned long *) copyaddr;
+	/* make sure the single step bit is not set. */
+	clear_single_step(child);
+}
 
-	if (writeuser && realuserptr == NULL)
-		return 0;
+/*
+ * Read the word at offset addr from the user area of a process. The
+ * trouble here is that the information is littered over different
+ * locations. The process registers are found on the kernel stack,
+ * the floating point stuff and the trace settings are stored in
+ * the task structure. In addition the different structures in
+ * struct user contain pad bytes that should be read as zeroes.
+ * Lovely...
+ */
+static int peek_user(struct task_struct *child, addr_t addr, addr_t data)
+{
+	struct user *dummy = NULL;
+	addr_t offset;
+	__u64 tmp;
+
+	if ((addr & 7) || addr > sizeof(struct user) - 7)
+		return -EIO;
+
+	if (addr <= (addr_t) &dummy->regs.orig_gpr2) {
+		/*
+		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 */
+		tmp = *(__u64 *)((addr_t) __KSTK_PTREGS(child) + addr);
+
+	} else if (addr >= (addr_t) &dummy->regs.fp_regs &&
+		   addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
+		/*
+		 * floating point regs. are stored in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy->regs.fp_regs;
+		tmp = *(__u64 *)((addr_t) &child->thread.fp_regs + offset);
+
+	} else if (addr >= (addr_t) &dummy->regs.per_info &&
+		   addr < (addr_t) (&dummy->regs.per_info + 1)) {
+		/*
+		 * per_info is found in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy->regs.per_info;
+		tmp = *(__u64 *)((addr_t) &child->thread.per_info + offset);
 
-	if (mask != -1L) {
-		tempuser = *realuserptr;
-		if (!writeuser) {
-			tempuser &= mask;
-			realuserptr = &tempuser;
-		}
-	}
-	if (tofromuser) {
-		if (writeuser) {
-			retval = copy_from_user(realuserptr, copyptr, len);
-		} else {
-			if (realuserptr == NULL)
-				retval = clear_user(copyptr, len);
-			else
-				retval = copy_to_user(copyptr,realuserptr,len);
-                        retval = retval ? -EIO : 0;
-		}      
-	} else {
-		if (writeuser)
-			memcpy(realuserptr, copyptr, len);
-		else
-			memcpy(copyptr, realuserptr, len);
-	}
-	if (mask != -1L && writeuser)
-                *realuserptr = (*realuserptr & mask) | (tempuser & ~mask);
-	return retval;
-}
+	} else
+		tmp = 0;
 
-#ifdef CONFIG_S390_SUPPORT
+	return put_user(tmp, (__u64 *) data);
+}
 
-typedef struct
+/*
+ * Write a word to the user area of a process at location addr. This
+ * operation does have an additional problem compared to peek_user.
+ * Stores to the program status word and on the floating point
+ * control register needs to get checked for validity.
+ */
+static int poke_user(struct task_struct *child, addr_t addr, addr_t data)
 {
-	__u32 cr[3];
-} per_cr_words32  __attribute__((packed));
+	struct user *dummy = NULL;
+	addr_t offset;
 
-typedef struct
-{
-	__u16          perc_atmid;          /* 0x096 */
-	__u32          address;             /* 0x098 */
-	__u8           access_id;           /* 0x0a1 */
-} per_lowcore_words32  __attribute__((packed));
+	if ((addr & 7) || addr > sizeof(struct user) - 7)
+		return -EIO;
 
-typedef struct
-{
-	union {
-		per_cr_words32   words;
-	} control_regs  __attribute__((packed));
-	/*
-	 * Use these flags instead of setting em_instruction_fetch
-	 * directly they are used so that single stepping can be
-	 * switched on & off while not affecting other tracing
-	 */
-	unsigned  single_step       : 1;
-	unsigned  instruction_fetch : 1;
-	unsigned                    : 30;
-	/*
-	 * These addresses are copied into cr10 & cr11 if single
-	 * stepping is switched off
-	 */
-	__u32     starting_addr;
-	__u32     ending_addr;
-	union {
-		per_lowcore_words32 words;
-	} lowcore; 
-} per_struct32 __attribute__((packed));
-
-struct user_regs_struct32
-{
-	_psw_t32 psw;
-	u32 gprs[NUM_GPRS];
-	u32 acrs[NUM_ACRS];
-	u32 orig_gpr2;
-	s390_fp_regs fp_regs;
-	/*
-	 * These per registers are in here so that gdb can modify them
-	 * itself as there is no "official" ptrace interface for hardware
-	 * watchpoints. This is the way intel does it.
-	 */
-	per_struct32 per_info;
-	u32  ieee_instruction_pointer; 
-	/* Used to give failing instruction back to user for ieee exceptions */
-};
-
-struct user32 {
-                                  /* We start with the registers, to mimic the way that "memory" is returned
-                                   from the ptrace(3,...) function.  */
-  struct user_regs_struct32 regs; /* Where the registers are actually stored */
-                                  /* The rest of this junk is to help gdb figure out what goes where */
-  u32 u_tsize;	                  /* Text segment size (pages). */
-  u32 u_dsize;	                  /* Data segment size (pages). */
-  u32 u_ssize;	                  /* Stack segment size (pages). */
-  u32 start_code;                 /* Starting virtual address of text. */
-  u32 start_stack;	          /* Starting virtual address of stack area.
-				   This is actually the bottom of the stack,
-				   the top of the stack is always found in the
-				   esp register.  */
-  s32 signal;     		  /* Signal that caused the core dump. */
-  u32 u_ar0;                      /* Used by gdb to help find the values for */
-				  /* the registers. */
-  u32 magic;		          /* To uniquely identify a core file */
-  char u_comm[32];		  /* User command that was responsible */
-};
-
-
-#define PT32_PSWMASK  0x0
-#define PT32_PSWADDR  0x04
-#define PT32_GPR0     0x08
-#define PT32_GPR15    0x44
-#define PT32_ACR0     0x48
-#define PT32_ACR15    0x84
-#define PT32_ORIGGPR2 0x88
-#define PT32_FPC      0x90
-#define PT32_FPR0_HI  0x98
-#define PT32_FPR15_LO 0x114
-#define PT32_CR_9     0x118
-#define PT32_CR_11    0x120
-#define PT32_IEEE_IP  0x13C
-#define PT32_LASTOFF  PT32_IEEE_IP
-#define PT32_ENDREGS  0x140-1
-#define U32OFFSETOF(member) offsetof(struct user32,regs.member)
-#define U64OFFSETOF(member) offsetof(struct user,regs.member)
-#define U6432DIFF(member) (U64OFFSETOF(member) - U32OFFSETOF(member))
-#define PT_SINGLE_STEP   (PT_CR_11+8)
-#define PT32_SINGLE_STEP (PT32_CR_11+4)
-
-#endif /* CONFIG_S390_SUPPORT */
-
-int copy_user(struct task_struct *task,saddr_t useraddr, addr_t copyaddr,
-              int len, int tofromuser, int writingtouser)
-{
-	int copylen=0,copymax;
-	addr_t  realuseraddr;
-	saddr_t enduseraddr;
-	unsigned long mask;
-#ifdef CONFIG_S390_SUPPORT
-	int     parent_31bit=current->thread.flags & S390_FLAG_31BIT;
-	int     skip;
-#endif
-	enduseraddr=useraddr+len;
-	if ((useraddr<0||useraddr&3||enduseraddr&3)||
-#ifdef CONFIG_S390_SUPPORT
-	    (parent_31bit && enduseraddr > sizeof(struct user32)) ||
-#endif
-	    enduseraddr > sizeof(struct user))
-		return (-EIO);
+	if (addr <= (addr_t) &dummy->regs.orig_gpr2) {
+		/*
+		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 */
+		if (addr == (addr_t) &dummy->regs.psw.mask &&
+#ifdef CONFIG_S390_SUPPORT
+		    (data & ~PSW_MASK_CC) != PSW_USER32_BITS &&
+#endif
+		    (data & ~PSW_MASK_CC) != PSW_USER_BITS)
+			/* Invalid psw mask. */
+			return -EINVAL;
+		*(__u64 *)((addr_t) __KSTK_PTREGS(child) + addr) = data;
+
+	} else if (addr >= (addr_t) &dummy->regs.fp_regs &&
+		   addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
+		/*
+		 * floating point regs. are stored in the thread structure
+		 */
+		if (addr == (addr_t) &dummy->regs.fp_regs.fpc &&
+		    ((data >> 32) & ~FPC_VALID_MASK) != 0)
+			/* Invalid floating pointer control. */
+			return -EINVAL;
+		offset = addr - (addr_t) &dummy->regs.fp_regs;
+		*(__u64 *)((addr_t) &child->thread.fp_regs + offset) = data;
+
+	} else if (addr >= (addr_t) &dummy->regs.per_info &&
+		   addr < (addr_t) (&dummy->regs.per_info + 1)) {
+		/*
+		 * per_info is found in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy->regs.per_info;
+		*(__u64 *)((addr_t) &child->thread.per_info + offset) = data;
 
-#ifdef CONFIG_S390_SUPPORT
-	if(parent_31bit)
-	{
-		if(useraddr != PT32_PSWMASK)
-		{
-			if (useraddr == PT32_PSWADDR)
-				useraddr = PT_PSWADDR+4;
-			else if(useraddr <= PT32_GPR15)
-				useraddr = ((useraddr-PT32_GPR0)*2) + PT_GPR0+4;
-			else if(useraddr <= PT32_ACR15)
-				useraddr += PT_ACR0-PT32_ACR0;
-			else if(useraddr == PT32_ORIGGPR2)
-				useraddr = PT_ORIGGPR2+4;
-			else if(useraddr <= PT32_FPR15_LO)
-				useraddr += PT_FPR0-PT32_FPR0_HI;
-			else if(useraddr <= PT32_CR_11)
-				useraddr = ((useraddr-PT32_CR_9)*2) + PT_CR_9+4;
-			else if(useraddr ==  PT32_SINGLE_STEP)
-				useraddr = PT_SINGLE_STEP; 
-			else if(useraddr <= U32OFFSETOF(per_info.ending_addr))	
-				useraddr = (((useraddr-U32OFFSETOF(per_info.starting_addr)))*2) + 
-					U64OFFSETOF(per_info.starting_addr)+4;
-			else if( useraddr == U32OFFSETOF(per_info.lowcore.words.perc_atmid))
-				useraddr = U64OFFSETOF(per_info.lowcore.words.perc_atmid);
-			else if( useraddr == U32OFFSETOF(per_info.lowcore.words.address))
-				useraddr = U64OFFSETOF(per_info.lowcore.words.address)+4;
-			else if(useraddr == U32OFFSETOF(per_info.lowcore.words.access_id))
-				useraddr = U64OFFSETOF(per_info.lowcore.words.access_id);
-			else if(useraddr == PT32_IEEE_IP)
-				useraddr = PT_IEEE_IP+4;
-		}
 	}
-#endif /* CONFIG_S390_SUPPORT */
 
-	while(len>0)
-	{
-#ifdef CONFIG_S390_SUPPORT
-		skip=0;
-#endif
-		mask=PSW_ADDR_MASK;
-		if(useraddr<PT_FPC)
-		{
-			realuseraddr=((addr_t) __KSTK_PTREGS(task)) + useraddr;
-			if(useraddr<(PT_PSWMASK+8))
-			{
-				if(parent_31bit)
-				{
-					copymax=PT_PSWMASK+4;
-#ifdef CONFIG_S390_SUPPORT
-					skip=8;
-#endif
-				}
-				else
-				{
-					copymax=PT_PSWMASK+8;
-				}
-				if(writingtouser)
-					mask=PSW_MASK_DEBUGCHANGE;
-			}
-			else if(useraddr<(PT_PSWADDR+8))
-			{
-				copymax=PT_PSWADDR+8;
-				mask=PSW_ADDR_DEBUGCHANGE;
-#ifdef CONFIG_S390_SUPPORT
-				if(parent_31bit)
-					skip=4;
-#endif
+	FixPerRegisters(child);
+	return 0;
+}
 
-			}
-			else
-			{
-#ifdef CONFIG_S390_SUPPORT
-				if(parent_31bit && useraddr <= PT_GPR15+4)
-				{
-					copymax=useraddr+4;
-					if(useraddr<PT_GPR15+4)
-						skip=4;
-				}
-				else
-#endif
-					copymax=PT_FPC;
-			}
-		}
-		else if(useraddr<(PT_FPR15+sizeof(freg_t)))
-		{
-			copymax=(PT_FPR15+sizeof(freg_t));
-			realuseraddr=(addr_t)&(((u8 *)&task->thread.fp_regs)[useraddr-PT_FPC]);
-		}
-		else if(useraddr<sizeof(struct user_regs_struct))
-		{
-#ifdef CONFIG_S390_SUPPORT
-			if( parent_31bit && useraddr <= PT_IEEE_IP+4)
-			{
-				switch(useraddr)
-				{
-				case PT_CR_11+4:
-				case U64OFFSETOF(per_info.ending_addr)+4:
-				case U64OFFSETOF(per_info.lowcore.words.address)+4:
-					copymax=useraddr+4;
-					break;
-				case  PT_SINGLE_STEP:
-				case  U64OFFSETOF(per_info.lowcore.words.perc_atmid):
-					/* We copy 2 bytes in excess for the atmid member this also gets around */
-					/* alignment for this member in 32 bit */
-					skip=8;
-					copymax=useraddr+4;
-					break;
-				default: 
-					copymax=useraddr+4;
-					skip=4;
-				}
-			}
+static int
+do_ptrace_normal(struct task_struct *child, long request, long addr, long data)
+{
+	unsigned long tmp;
+	ptrace_area parea; 
+	int copied, ret;
+
+	switch (request) {
+	case PTRACE_PEEKTEXT:
+	case PTRACE_PEEKDATA:
+		/* read word at location addr. */
+		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
+		if (copied != sizeof(tmp))
+			return -EIO;
+		return put_user(tmp, (unsigned long *) data);
+
+	case PTRACE_PEEKUSR:
+		/* read the word at location addr in the USER area. */
+		return peek_user(child, addr, data);
+
+	case PTRACE_POKETEXT:
+	case PTRACE_POKEDATA:
+		/* write the word at location addr. */
+		copied = access_process_vm(child, addr, &data, sizeof(data),1);
+		if (copied != sizeof(data))
+			return -EIO;
+		return 0;
+
+	case PTRACE_POKEUSR:
+		/* write the word at location addr in the USER area */
+		return poke_user(child, addr, data);
+
+	case PTRACE_PEEKUSR_AREA:
+	case PTRACE_POKEUSR_AREA:
+		if (!copy_from_user(&parea, (void *) addr, sizeof(parea)))
+			return -EFAULT;
+		addr = parea.kernel_addr;
+		data = parea.process_addr;
+		copied = 0;
+		while (copied < parea.len) {
+			if (request == PTRACE_PEEKUSR_AREA)
+				ret = peek_user(child, addr, data);
 			else
-#endif
-			{
-				copymax=sizeof(struct user_regs_struct);
-			}
-			realuseraddr=(addr_t)&(((u8 *)&task->thread.per_info)[useraddr-PT_CR_9]);
-		}
-		else 
-		{
-			copymax=sizeof(struct user);
-			realuseraddr=(addr_t)NULL;
+				ret = poke_user(child, addr, data);
+			if (ret)
+				return ret;
+			addr += sizeof(unsigned long);
+			data += sizeof(unsigned long);
+			copied += sizeof(unsigned long);
 		}
-		copylen=copymax-useraddr;
-		copylen=(copylen>len ? len:copylen);
-		if(ptrace_usercopy(realuseraddr,copyaddr,copylen,tofromuser,writingtouser,mask))
-			return (-EIO);
-		copyaddr+=copylen;
-		len-=copylen;
-		useraddr+=copylen
-#if CONFIG_S390_SUPPORT
-			+skip
-#endif
-			;
+		return 0;
 	}
-	FixPerRegisters(task);
-	return(0);
+	return -EIO;
 }
 
+#ifdef CONFIG_S390_SUPPORT
 /*
- * Called by kernel/ptrace.c when detaching..
- *
- * Make sure single step bits etc are not set.
+ * Now the fun part starts... a 31 bit program running in the
+ * 31 bit emulation tracing another program. PTRACE_PEEKTEXT,
+ * PTRACE_PEEKDATA, PTRACE_POKETEXT and PTRACE_POKEDATA are easy
+ * to handle, the difference to the 64 bit versions of the requests
+ * is that the access is done in multiples of 4 byte instead of
+ * 8 bytes (sizeof(unsigned long) on 31/64 bit).
+ * The ugly part are PTRACE_PEEKUSR, PTRACE_PEEKUSR_AREA,
+ * PTRACE_POKEUSR and PTRACE_POKEUSR_AREA. If the traced program
+ * is a 31 bit program too, the content of struct user can be
+ * emulated. A 31 bit program peeking into the struct user of
+ * a 64 bit program is a no-no.
  */
-void ptrace_disable(struct task_struct *child)
+
+/*
+ * Same as peek_user but for a 31 bit program.
+ */
+static int peek_user_emu31(struct task_struct *child, addr_t addr, addr_t data)
 {
-	/* make sure the single step bit is not set. */
-	clear_single_step(child);
+	struct user32 *dummy32 = NULL;
+	per_struct32 *dummy_per32 = NULL;
+	addr_t offset;
+	__u32 tmp;
+
+	if (!(child->thread.flags & S390_FLAG_31BIT) ||
+	    (addr & 3) || addr > sizeof(struct user) - 3)
+		return -EIO;
+
+	if (addr <= (addr_t) &dummy32->regs.orig_gpr2) {
+		/*
+		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 */
+		if (addr == (addr_t) &dummy32->regs.psw.mask) {
+			/* Fake a 31 bit psw mask. */
+			tmp = (__u32)(__KSTK_PTREGS(child)->psw.mask >> 32);
+			tmp = (tmp & PSW32_MASK_CC) | PSW32_USER_BITS;
+		} else if (addr == (addr_t) &dummy32->regs.psw.addr) {
+			/* Fake a 31 bit psw address. */
+			tmp = (__u32) __KSTK_PTREGS(child)->psw.addr |
+				PSW32_ADDR_AMODE31;
+		} else
+			tmp = *(__u32 *)((addr_t) __KSTK_PTREGS(child) + 
+					 addr*2 + 4);
+	} else if (addr >= (addr_t) &dummy32->regs.fp_regs &&
+		   addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
+		/*
+		 * floating point regs. are stored in the thread structure 
+		 */
+	        offset = addr - (addr_t) &dummy32->regs.fp_regs;
+		tmp = *(__u32 *)((addr_t) &child->thread.fp_regs + offset);
+
+	} else if (addr >= (addr_t) &dummy32->regs.per_info &&
+		   addr < (addr_t) (&dummy32->regs.per_info + 1)) {
+		/*
+		 * per_info is found in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy32->regs.per_info;
+		/* This is magic. See per_struct and per_struct32. */
+		if ((offset >= (addr_t) &dummy_per32->control_regs &&
+		     offset < (addr_t) (&dummy_per32->control_regs + 1)) ||
+		    (offset >= (addr_t) &dummy_per32->starting_addr &&
+		     offset <= (addr_t) &dummy_per32->ending_addr) ||
+		    offset == (addr_t) &dummy_per32->lowcore.words.address)
+			offset = offset*2 + 4;
+		else
+			offset = offset*2;
+		tmp = *(__u32 *)((addr_t) &child->thread.per_info + offset);
+
+	} else
+		tmp = 0;
+
+	return put_user(tmp, (__u32 *) data);
 }
 
-typedef struct
+/*
+ * Same as poke_user but for a 31 bit program.
+ */
+static int poke_user_emu31(struct task_struct *child, addr_t addr, addr_t data)
 {
-__u32	len;
-__u32	kernel_addr;
-__u32	process_addr;
-} ptrace_area_emu31;
+	struct user32 *dummy32 = NULL;
+	per_struct32 *dummy_per32 = NULL;
+	addr_t offset;
+	__u32 tmp;
+	int ret;
+
+	if (!(child->thread.flags & S390_FLAG_31BIT) ||
+	    (addr & 3) || addr > sizeof(struct user32) - 3)
+		return -EIO;
+
+	tmp = (__u32) data;
+
+	if (addr <= (addr_t) &dummy32->regs.orig_gpr2) {
+		/*
+		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 */
+		if (addr == (addr_t) &dummy32->regs.psw.mask) {
+			/* Build a 64 bit psw mask from 31 bit mask. */
+			if ((tmp & ~PSW32_MASK_CC) != PSW32_USER_BITS)
+				/* Invalid psw mask. */
+				return -EINVAL;
+			__KSTK_PTREGS(child)->psw.mask = PSW_USER_BITS |
+				((tmp & PSW32_MASK_CC) << 32);
+		} else if (addr == (addr_t) &dummy32->regs.psw.addr) {
+			/* Build a 64 bit psw address from 31 bit address. */
+			__KSTK_PTREGS(child)->psw.addr = 
+				(__u64) tmp & PSW32_ADDR_INSN;
+		} else
+			*(__u32*)((addr_t) __KSTK_PTREGS(child) + addr*2 + 4) =
+				tmp;
+	} else if (addr >= (addr_t) &dummy32->regs.fp_regs &&
+		   addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
+		/*
+		 * floating point regs. are stored in the thread structure 
+		 */
+		if (addr == (addr_t) &dummy32->regs.fp_regs.fpc &&
+		    (tmp & ~FPC_VALID_MASK) != 0)
+			/* Invalid floating pointer control. */
+			return -EINVAL;
+	        offset = addr - (addr_t) &dummy32->regs.fp_regs;
+		*(__u32 *)((addr_t) &child->thread.fp_regs + offset) = tmp;
+
+	} else if (addr >= (addr_t) &dummy32->regs.per_info &&
+		   addr < (addr_t) (&dummy32->regs.per_info + 1)) {
+		/*
+		 * per_info is found in the thread structure.
+		 */
+		offset = addr - (addr_t) &dummy32->regs.per_info;
+		/*
+		 * This is magic. See per_struct and per_struct32.
+		 * By incident the offsets in per_struct are exactly
+		 * twice the offsets in per_struct32 for all fields.
+		 * The 8 byte fields need special handling though,
+		 * because the second half (bytes 4-7) is needed and
+		 * not the first half.
+		 */
+		if ((offset >= (addr_t) &dummy_per32->control_regs &&
+		     offset < (addr_t) (&dummy_per32->control_regs + 1)) ||
+		    (offset >= (addr_t) &dummy_per32->starting_addr &&
+		     offset <= (addr_t) &dummy_per32->ending_addr) ||
+		    offset == (addr_t) &dummy_per32->lowcore.words.address)
+			offset = offset*2 + 4;
+		else
+			offset = offset*2;
+		*(__u32 *)((addr_t) &child->thread.per_info + offset) = tmp;
 
+	}
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+	FixPerRegisters(child);
+	return 0;
+}
+
+static int
+do_ptrace_emu31(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
-	int ret = -EPERM;
-	int copied;
-#ifdef CONFIG_S390_SUPPORT
-	int           parent_31bit;
-	int           sizeof_parent_long;
-	u8            *dataptr;
-#else
-#define sizeof_parent_long 8
-#define dataptr (u8 *)&data
-#endif
-	lock_kernel();
-	if (request == PTRACE_TRACEME) 
-	{
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
-		goto out;
-	}
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (!child)
-		goto out;
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-	if (request == PTRACE_ATTACH) 
-	{
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-	ret = -ESRCH;
-	// printk("child=%lX child->flags=%lX",child,child->flags);
-	/* I added child!=current line so we can get the */
-	/* ieee_instruction_pointer from the user structure DJB */
-	if(child!=current)
-	{
-		if (!(child->ptrace & PT_PTRACED))
-			goto out_tsk;
-		if (child->state != TASK_STOPPED) 
-		{
-			if (request != PTRACE_KILL)
-				goto out_tsk;
+	unsigned int tmp;  /* 4 bytes !! */
+	ptrace_area_emu31 parea; 
+	int copied, ret;
+
+	switch (request) {
+	case PTRACE_PEEKTEXT:
+	case PTRACE_PEEKDATA:
+		/* read word at location addr. */
+		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
+		if (copied != sizeof(tmp))
+			return -EIO;
+		return put_user(tmp, (unsigned int *) data);
+
+	case PTRACE_PEEKUSR:
+		/* read the word at location addr in the USER area. */
+		return peek_user_emu31(child, addr, data);
+
+	case PTRACE_POKETEXT:
+	case PTRACE_POKEDATA:
+		/* write the word at location addr. */
+		tmp = data;
+		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 1);
+		if (copied != sizeof(tmp))
+			return -EIO;
+		return 0;
+
+	case PTRACE_POKEUSR:
+		/* write the word at location addr in the USER area */
+		return poke_user_emu31(child, addr, data);
+
+	case PTRACE_PEEKUSR_AREA:
+	case PTRACE_POKEUSR_AREA:
+		if (!copy_from_user(&parea, (void *) addr, sizeof(parea)))
+			return -EFAULT;
+		addr = parea.kernel_addr;
+		data = parea.process_addr;
+		copied = 0;
+		while (copied < parea.len) {
+			if (request == PTRACE_PEEKUSR_AREA)
+				ret = peek_user_emu31(child, addr, data);
+			else
+				ret = poke_user_emu31(child, addr, data);
+			if (ret)
+				return ret;
+			addr += sizeof(unsigned int);
+			data += sizeof(unsigned int);
+			copied += sizeof(unsigned int);
 		}
-		if (child->parent != current)
-			goto out_tsk;
+		return 0;
 	}
-#ifdef CONFIG_S390_SUPPORT
-	parent_31bit=(current->thread.flags & S390_FLAG_31BIT);
-	sizeof_parent_long=(parent_31bit ? 4:8);
-	dataptr=&(((u8 *)&data)[parent_31bit ? 4:0]);
+	return -EIO;
+}
 #endif
-	switch (request) 
-	{
-		/* If I and D space are separate, these will need to be fixed. */
-	case PTRACE_PEEKTEXT: /* read word at location addr. */ 
-	case PTRACE_PEEKDATA: 
-	{
-		u8 tmp[8];
-		copied = access_process_vm(child, addr, tmp, sizeof_parent_long, 0);
-		ret = -EIO;
-		if (copied != sizeof_parent_long)
-			break;
-		ret = copy_to_user((void *)data,tmp,sizeof_parent_long);
-		break;
-	
+
+static int
+do_ptrace(struct task_struct *child, long request, long addr, long data)
+{
+	int ret;
+
+	if (request == PTRACE_ATTACH)
+		return ptrace_attach(child);
+
+	/*
+	 * I added child != current line so we can get the
+	 * ieee_instruction_pointer from the user structure DJB
+	 */
+	if (child != current) {
+		ret = ptrace_check_attach(child, request == PTRACE_KILL);
+		if (ret < 0)
+			return ret;
 	}
-		/* read the word at location addr in the USER area. */
-	case PTRACE_PEEKUSR:
-		ret=copy_user(child,addr,data,sizeof_parent_long,1,0);
-		break;
 
-		/* If I and D space are separate, this will have to be fixed. */
-	case PTRACE_POKETEXT: /* write the word at location addr. */
-	case PTRACE_POKEDATA:
-		ret = 0;
-		if (access_process_vm(child, addr,dataptr, sizeof_parent_long, 1) == sizeof_parent_long)
-			break;
-		ret = -EIO;
-		break;
-
-	case PTRACE_POKEUSR: /* write the word at location addr in the USER area */
-		ret=copy_user(child,addr,(addr_t)dataptr,sizeof_parent_long,0,1);
-		break;
-
-	case PTRACE_SYSCALL: 	/* continue and stop at next (return from) syscall */
-	case PTRACE_CONT: 	 /* restart after signal. */
-		ret = -EIO;
+	switch (request) {
+	/* First the common request for 31/64 bit */
+	case PTRACE_SYSCALL:
+		/* continue and stop at next (return from) syscall */
+	case PTRACE_CONT:
+		/* restart after signal. */
 		if ((unsigned long) data >= _NSIG)
-			break;
+			return -EIO;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		else
@@ -525,86 +507,104 @@
 		/* make sure the single step bit is not set. */
 		clear_single_step(child);
 		wake_up_process(child);
-		ret = 0;
-		break;
+		return 0;
 
-/*
- * make the child exit.  Best I can do is send it a sigkill. 
- * perhaps it should be put in the status that it wants to 
- * exit.
- */
 	case PTRACE_KILL:
-		ret = 0;
+		/*
+		 * make the child exit.  Best I can do is send it a sigkill. 
+		 * perhaps it should be put in the status that it wants to 
+		 * exit.
+		 */
 		if (child->state == TASK_ZOMBIE) /* already dead */
-			break;
+			return 0;
 		child->exit_code = SIGKILL;
+		/* make sure the single step bit is not set. */
 		clear_single_step(child);
 		wake_up_process(child);
-		/* make sure the single step bit is not set. */
-		break;
+		return 0;
 
-	case PTRACE_SINGLESTEP:  /* set the trap flag. */
-		ret = -EIO;
+	case PTRACE_SINGLESTEP:
+		/* set the trap flag. */
 		if ((unsigned long) data >= _NSIG)
-			break;
+			return -EIO;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
 		set_single_step(child);
 		/* give it a chance to run. */
 		wake_up_process(child);
-		ret = 0;
-		break;
+		return 0;
 
-	case PTRACE_DETACH:  /* detach a process that was attached. */
-		ret = ptrace_detach(child, data);
-		break;
+	case PTRACE_DETACH:
+		/* detach a process that was attached. */
+		return ptrace_detach(child, data);
 
-	case PTRACE_PEEKUSR_AREA:
-	case PTRACE_POKEUSR_AREA:
-		if(parent_31bit)
-		{
-			ptrace_area_emu31   parea; 
-			if((ret=copy_from_user(&parea,(void *)addr,sizeof(parea)))==0)  
-				ret=copy_user(child,parea.kernel_addr,parea.process_addr,
-					      parea.len,1,(request==PTRACE_POKEUSR_AREA));
-		}
-		else
-		{
-			ptrace_area   parea; 
-			if((ret=copy_from_user(&parea,(void *)addr,sizeof(parea)))==0)  
-				ret=copy_user(child,parea.kernel_addr,parea.process_addr,
-					      parea.len,1,(request==PTRACE_POKEUSR_AREA));
-		}
-		break;
-	case PTRACE_SETOPTIONS: {
+	case PTRACE_SETOPTIONS:
 		if (data & PTRACE_O_TRACESYSGOOD)
 			child->ptrace |= PT_TRACESYSGOOD;
 		else
 			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
-		break;
-	}
+		return 0;
+	/* Do requests that differ for 31/64 bit */
 	default:
-		ret = -EIO;
-		break;
+#ifdef CONFIG_S390_SUPPORT
+		if (current->thread.flags & S390_FLAG_31BIT)
+			return do_ptrace_emu31(child, request, addr, data);
+#endif
+		return do_ptrace_normal(child, request, addr, data);
+		
 	}
- out_tsk:
+	return -EIO;
+}
+
+asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+{
+	struct task_struct *child;
+	int ret;
+
+	lock_kernel();
+
+	if (request == PTRACE_TRACEME) {
+		/* are we already being traced? */
+		ret = -EPERM;
+		if (current->ptrace & PT_PTRACED)
+			goto out;
+		ret = security_ops->ptrace(current->parent, current);
+		if (ret)
+			goto out;
+		/* set the ptrace bit in the process flags. */
+		current->ptrace |= PT_PTRACED;
+		goto out;
+	}
+
+	ret = -EPERM;
+	if (pid == 1)		/* you may not mess with init */
+		goto out;
+
+	ret = -ESRCH;
+	read_lock(&tasklist_lock);
+	child = find_task_by_pid(pid);
+	if (child)
+		get_task_struct(child);
+	read_unlock(&tasklist_lock);
+	if (!child)
+		goto out;
+
+	ret = do_ptrace(child, request, addr, data);
+
 	put_task_struct(child);
- out:
+out:
 	unlock_kernel();
 	return ret;
 }
 
-
-
 asmlinkage void syscall_trace(void)
 {
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
+	current->exit_code =
+		SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -urN linux-2.5.34/arch/s390x/kernel/ptrace32.h linux-2.5.34-s390/arch/s390x/kernel/ptrace32.h
--- linux-2.5.34/arch/s390x/kernel/ptrace32.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.34-s390/arch/s390x/kernel/ptrace32.h	Tue Sep 10 20:02:27 2002
@@ -0,0 +1,86 @@
+#ifndef _PTRACE32_H
+#define _PTRACE32_H
+
+#include "linux32.h"  /* needed for _psw_t32 */
+
+typedef struct
+{
+	__u32 cr[3];
+} per_cr_words32  __attribute__((packed));
+
+typedef struct
+{
+	__u16          perc_atmid;          /* 0x096 */
+	__u32          address;             /* 0x098 */
+	__u8           access_id;           /* 0x0a1 */
+} per_lowcore_words32  __attribute__((packed));
+
+typedef struct
+{
+	union {
+		per_cr_words32   words;
+	} control_regs  __attribute__((packed));
+	/*
+	 * Use these flags instead of setting em_instruction_fetch
+	 * directly they are used so that single stepping can be
+	 * switched on & off while not affecting other tracing
+	 */
+	unsigned  single_step       : 1;
+	unsigned  instruction_fetch : 1;
+	unsigned                    : 30;
+	/*
+	 * These addresses are copied into cr10 & cr11 if single
+	 * stepping is switched off
+	 */
+	__u32     starting_addr;
+	__u32     ending_addr;
+	union {
+		per_lowcore_words32 words;
+	} lowcore; 
+} per_struct32 __attribute__((packed));
+
+struct user_regs_struct32
+{
+	_psw_t32 psw;
+	u32 gprs[NUM_GPRS];
+	u32 acrs[NUM_ACRS];
+	u32 orig_gpr2;
+	s390_fp_regs fp_regs;
+	/*
+	 * These per registers are in here so that gdb can modify them
+	 * itself as there is no "official" ptrace interface for hardware
+	 * watchpoints. This is the way intel does it.
+	 */
+	per_struct32 per_info;
+	u32  ieee_instruction_pointer; 
+	/* Used to give failing instruction back to user for ieee exceptions */
+};
+
+struct user32 {
+	/* We start with the registers, to mimic the way that "memory"
+	   is returned from the ptrace(3,...) function.  */
+	struct user_regs_struct32 regs; /* Where the registers are actually stored */
+	/* The rest of this junk is to help gdb figure out what goes where */
+	u32 u_tsize;		/* Text segment size (pages). */
+	u32 u_dsize;	        /* Data segment size (pages). */
+	u32 u_ssize;	        /* Stack segment size (pages). */
+	u32 start_code;         /* Starting virtual address of text. */
+	u32 start_stack;	/* Starting virtual address of stack area.
+				   This is actually the bottom of the stack,
+				   the top of the stack is always found in the
+				   esp register.  */
+	s32 signal;     	 /* Signal that caused the core dump. */
+	u32 u_ar0;               /* Used by gdb to help find the values for */
+	                         /* the registers. */
+	u32 magic;		 /* To uniquely identify a core file */
+	char u_comm[32];	 /* User command that was responsible */
+};
+
+typedef struct
+{
+	__u32   len;
+	__u32   kernel_addr;
+	__u32   process_addr;
+} ptrace_area_emu31;
+
+#endif /* _PTRACE32_H */
diff -urN linux-2.5.34/arch/s390x/kernel/setup.c linux-2.5.34-s390/arch/s390x/kernel/setup.c
--- linux-2.5.34/arch/s390x/kernel/setup.c	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/setup.c	Tue Sep 10 20:02:27 2002
@@ -305,7 +305,7 @@
 	unsigned long start_pfn, end_pfn;
         static unsigned int smptrap=0;
         unsigned long delay = 0;
-	struct _lowcore *lowcore;
+	struct _lowcore *lc;
 	int i;
 
         if (smptrap)
@@ -442,27 +442,30 @@
         /*
          * Setup lowcore for boot cpu
          */
-	lowcore = (struct _lowcore *) 
-		__alloc_bootmem(2*PAGE_SIZE, 2*PAGE_SIZE, 0);
-	memset(lowcore, 0, 2*PAGE_SIZE);
-	lowcore->restart_psw.mask = _RESTART_PSW_MASK;
-	lowcore->restart_psw.addr = (addr_t) &restart_int_handler;
-	lowcore->external_new_psw.mask = _EXT_PSW_MASK;
-	lowcore->external_new_psw.addr = (addr_t) &ext_int_handler;
-	lowcore->svc_new_psw.mask = _SVC_PSW_MASK;
-	lowcore->svc_new_psw.addr = (addr_t) &system_call;
-	lowcore->program_new_psw.mask = _PGM_PSW_MASK;
-	lowcore->program_new_psw.addr = (addr_t) &pgm_check_handler;
-	lowcore->mcck_new_psw.mask = _MCCK_PSW_MASK;
-	lowcore->mcck_new_psw.addr = (addr_t) &mcck_int_handler;
-	lowcore->io_new_psw.mask = _IO_PSW_MASK;
-	lowcore->io_new_psw.addr = (addr_t) &io_int_handler;
-	lowcore->ipl_device = S390_lowcore.ipl_device;
-	lowcore->kernel_stack = ((__u64) &init_thread_union) + 16384;
-	lowcore->async_stack = (__u64)
+	lc = (struct _lowcore *) __alloc_bootmem(2*PAGE_SIZE, 2*PAGE_SIZE, 0);
+	memset(lc, 0, 2*PAGE_SIZE);
+	lc->restart_psw.mask = PSW_BASE_BITS;
+	lc->restart_psw.addr = (addr_t) &restart_int_handler;
+	lc->external_new_psw.mask = PSW_KERNEL_BITS;
+	lc->external_new_psw.addr = (addr_t) &ext_int_handler;
+	lc->svc_new_psw.mask = PSW_KERNEL_BITS;
+	lc->svc_new_psw.addr = (addr_t) &system_call;
+	lc->program_new_psw.mask = PSW_KERNEL_BITS;
+	lc->program_new_psw.addr = (addr_t) &pgm_check_handler;
+	lc->mcck_new_psw.mask = PSW_KERNEL_BITS;
+	lc->mcck_new_psw.addr = (addr_t) &mcck_int_handler;
+	lc->io_new_psw.mask = PSW_KERNEL_BITS;
+	lc->io_new_psw.addr = (addr_t) &io_int_handler;
+	lc->ipl_device = S390_lowcore.ipl_device;
+	lc->kernel_stack = ((__u64) &init_thread_union) + 16384;
+	lc->async_stack = (__u64)
 		__alloc_bootmem(4*PAGE_SIZE, 4*PAGE_SIZE, 0) + 16384;
-	lowcore->jiffy_timer = -1LL;
-	set_prefix((__u32)(__u64) lowcore);
+	lc->jiffy_timer = -1LL;
+	if (MACHINE_HAS_DIAG44)
+		lc->diag44_opcode = 0x83000044;
+	else
+		lc->diag44_opcode = 0x07000700;
+	set_prefix((__u32)(__u64) lc);
         cpu_init();
         boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
         __cpu_logical_map[0] = boot_cpu_addr;
diff -urN linux-2.5.34/arch/s390x/kernel/signal.c linux-2.5.34-s390/arch/s390x/kernel/signal.c
--- linux-2.5.34/arch/s390x/kernel/signal.c	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/signal.c	Tue Sep 10 20:02:27 2002
@@ -162,7 +162,7 @@
 	int err;
 
 	err = __copy_from_user(regs, &sregs->regs, sizeof(_s390_regs_common));
-	regs->psw.mask = _USER_PSW_MASK | (regs->psw.mask & PSW_MASK_DEBUGCHANGE);
+	regs->psw.mask = PSW_USER_BITS | (regs->psw.mask & PSW_MASK_CC);
 	if (err)
 		return err;
 
@@ -292,9 +292,9 @@
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER) {
-                regs->gprs[14] = FIX_PSW(ka->sa.sa_restorer);
+                regs->gprs[14] = (__u64) ka->sa.sa_restorer;
 	} else {
-                regs->gprs[14] = FIX_PSW(frame->retcode);
+                regs->gprs[14] = (__u64) frame->retcode;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn, 
 	                       (u16 *)(frame->retcode)))
 			goto give_sigsegv;
@@ -305,12 +305,12 @@
 		goto give_sigsegv;
 
 	/* Set up registers for signal handler */
-	regs->gprs[15] = (addr_t)frame;
-	regs->psw.addr = FIX_PSW(ka->sa.sa_handler);
-	regs->psw.mask = _USER_PSW_MASK;
+	regs->gprs[15] = (__u64) frame;
+	regs->psw.addr = (__u64) ka->sa.sa_handler;
+	regs->psw.mask = PSW_USER_BITS;
 
 	regs->gprs[2] = map_signal(sig);
-	regs->gprs[3] = (addr_t)&frame->sc;
+	regs->gprs[3] = (__u64) &frame->sc;
 
 	/* We forgot to include these in the sigcontext.
 	   To avoid breaking binary compatibility, they are passed as args. */
@@ -350,9 +350,9 @@
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER) {
-                regs->gprs[14] = FIX_PSW(ka->sa.sa_restorer);
+                regs->gprs[14] = (__u64) ka->sa.sa_restorer;
 	} else {
-                regs->gprs[14] = FIX_PSW(frame->retcode);
+                regs->gprs[14] = (__u64) frame->retcode;
 		err |= __put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn, 
 	                          (u16 *)(frame->retcode));
 	}
@@ -362,13 +362,13 @@
 		goto give_sigsegv;
 
 	/* Set up registers for signal handler */
-	regs->gprs[15] = (addr_t)frame;
-	regs->psw.addr = FIX_PSW(ka->sa.sa_handler);
-	regs->psw.mask = _USER_PSW_MASK;
+	regs->gprs[15] = (__u64) frame;
+	regs->psw.addr = (__u64) ka->sa.sa_handler;
+	regs->psw.mask = PSW_USER_BITS;
 
 	regs->gprs[2] = map_signal(sig);
-	regs->gprs[3] = (addr_t)&frame->info;
-	regs->gprs[4] = (addr_t)&frame->uc;
+	regs->gprs[3] = (__u64) &frame->info;
+	regs->gprs[4] = (__u64) &frame->uc;
 	return;
 
 give_sigsegv:
diff -urN linux-2.5.34/arch/s390x/kernel/signal32.c linux-2.5.34-s390/arch/s390x/kernel/signal32.c
--- linux-2.5.34/arch/s390x/kernel/signal32.c	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/signal32.c	Tue Sep 10 20:02:27 2002
@@ -29,15 +29,10 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include "linux32.h"
+#include "ptrace32.h"
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-#define _ADDR_31 0x80000000
-#define _USER_PSW_MASK_EMU32 0x070DC000
-#define _USER_PSW_MASK32 0x0705C00080000000
-#define PSW_MASK_DEBUGCHANGE32 0x00003000UL
-#define PSW_ADDR_DEBUGCHANGE32 0x7FFFFFFFUL
-
 typedef struct 
 {
 	__u8 callee_used_stack[__SIGNAL_FRAMESIZE32];
@@ -297,9 +292,9 @@
 	_s390_regs_common32 regs32;
 	int err, i;
 
-	regs32.psw.mask = _USER_PSW_MASK_EMU32 |
-		(__u32)((regs->psw.mask & PSW_MASK_DEBUGCHANGE) >> 32);
-	regs32.psw.addr = _ADDR_31 | (__u32) regs->psw.addr;
+	regs32.psw.mask = PSW32_USER_BITS |
+		((__u32)(regs->psw.mask >> 32) & PSW32_MASK_CC);
+	regs32.psw.addr = PSW32_ADDR_AMODE31 | (__u32) regs->psw.addr;
 	for (i = 0; i < NUM_GPRS; i++)
 		regs32.gprs[i] = (__u32) regs->gprs[i];
 	memcpy(regs32.acrs, regs->acrs, sizeof(regs32.acrs));
@@ -320,9 +315,9 @@
 	err = __copy_from_user(&regs32, &sregs->regs, sizeof(regs32));
 	if (err)
 		return err;
-	regs->psw.mask = _USER_PSW_MASK32 |
-		(__u64)(regs32.psw.mask & PSW_MASK_DEBUGCHANGE32) << 32;
-	regs->psw.addr = (__u64)(regs32.psw.addr & PSW_ADDR_DEBUGCHANGE32);
+	regs->psw.mask = PSW_USER32_BITS |
+		(__u64)(regs32.psw.mask & PSW32_MASK_CC) << 32;
+	regs->psw.addr = (__u64)(regs32.psw.addr & PSW32_ADDR_INSN);
 	for (i = 0; i < NUM_GPRS; i++)
 		regs->gprs[i] = (__u64) regs32.gprs[i];
 	memcpy(regs->acrs, regs32.acrs, sizeof(regs32.acrs));
@@ -467,9 +462,9 @@
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER) {
-		regs->gprs[14] = FIX_PSW(ka->sa.sa_restorer);
+		regs->gprs[14] = (__u64) ka->sa.sa_restorer;
 	} else {
-		regs->gprs[14] = FIX_PSW(frame->retcode);
+		regs->gprs[14] = (__u64) frame->retcode;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn,
 		               (u16 *)(frame->retcode)))
 			goto give_sigsegv;
@@ -480,12 +475,12 @@
 		goto give_sigsegv;
 
 	/* Set up registers for signal handler */
-	regs->gprs[15] = (addr_t)frame;
-	regs->psw.addr = FIX_PSW(ka->sa.sa_handler);
-	regs->psw.mask = _USER_PSW_MASK32;
+	regs->gprs[15] = (__u64) frame;
+	regs->psw.addr = (__u64) ka->sa.sa_handler;
+	regs->psw.mask = PSW_USER32_BITS;
 
 	regs->gprs[2] = map_signal(sig);
-	regs->gprs[3] = (addr_t)&frame->sc;
+	regs->gprs[3] = (__u64) &frame->sc;
 
 	/* We forgot to include these in the sigcontext.
 	   To avoid breaking binary compatibility, they are passed as args. */
@@ -525,9 +520,9 @@
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER) {
-		regs->gprs[14] = FIX_PSW(ka->sa.sa_restorer);
+		regs->gprs[14] = (__u64) ka->sa.sa_restorer;
 	} else {
-		regs->gprs[14] = FIX_PSW(frame->retcode);
+		regs->gprs[14] = (__u64) frame->retcode;
 		err |= __put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn,
 		                  (u16 *)(frame->retcode));
 	}
@@ -537,13 +532,13 @@
 		goto give_sigsegv;
 
 	/* Set up registers for signal handler */
-	regs->gprs[15] = (addr_t)frame;
-	regs->psw.addr = FIX_PSW(ka->sa.sa_handler);
-	regs->psw.mask = _USER_PSW_MASK32;
+	regs->gprs[15] = (__u64) frame;
+	regs->psw.addr = (__u64) ka->sa.sa_handler;
+	regs->psw.mask = PSW_USER32_BITS;
 
 	regs->gprs[2] = map_signal(sig);
-	regs->gprs[3] = (addr_t)&frame->info;
-	regs->gprs[4] = (addr_t)&frame->uc;
+	regs->gprs[3] = (__u64) &frame->info;
+	regs->gprs[4] = (__u64) &frame->uc;
 	return;
 
 give_sigsegv:
diff -urN linux-2.5.34/arch/s390x/kernel/traps.c linux-2.5.34-s390/arch/s390x/kernel/traps.c
--- linux-2.5.34/arch/s390x/kernel/traps.c	Mon Sep  9 19:35:14 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/traps.c	Tue Sep 10 20:02:27 2002
@@ -118,22 +118,22 @@
 		stack = (unsigned long*)&stack;
 
 	printk("Call Trace: ");
-	low_addr = ((unsigned long) stack) & PSW_ADDR_MASK;
+	low_addr = (unsigned long) stack;
 	high_addr = (low_addr & (-THREAD_SIZE)) + THREAD_SIZE;
 	/* Skip the first frame (biased stack) */
-	backchain = *((unsigned long *) low_addr) & PSW_ADDR_MASK;
+	backchain = *(unsigned long *) low_addr;
 	/* Print up to 8 lines */
 	for (i = 0; i < 8; i++) {
 		if (backchain < low_addr || backchain >= high_addr)
 			break;
-		ret_addr = *((unsigned long *) (backchain+112)) & PSW_ADDR_MASK;
+		ret_addr = *(unsigned long *) (backchain+112);
 		if (!kernel_text_address(ret_addr))
 			break;
 		if (i && ((i % 3) == 0))
 			printk("\n   ");
 		printk("[<%016lx>] ", ret_addr);
 		low_addr = backchain;
-		backchain = *((unsigned long *) backchain) & PSW_ADDR_MASK;
+		backchain = *(unsigned long *) backchain;
 	}
 	printk("\n");
 }
@@ -178,7 +178,7 @@
 	char *mode;
 	int i;
 
-	mode = (regs->psw.mask & PSW_PROBLEM_STATE) ? "User" : "Krnl";
+	mode = (regs->psw.mask & PSW_MASK_PSTATE) ? "User" : "Krnl";
 	printk("%s PSW : %016lx %016lx\n",
 	       mode, (unsigned long) regs->psw.mask,
 	       (unsigned long) regs->psw.addr);
@@ -204,7 +204,7 @@
 	 * time of the fault.
 	 */
 	old_fs = get_fs();
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		set_fs(USER_DS);
 	else
 		set_fs(KERNEL_DS);
@@ -281,10 +281,10 @@
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
 	 */
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
-        if (regs->psw.mask & PSW_PROBLEM_STATE) {
+        if (regs->psw.mask & PSW_MASK_PSTATE) {
                 struct task_struct *tsk = current;
                 tsk->thread.trap_no = interruption_code & 0xffff;
 		if (info)
@@ -315,12 +315,12 @@
 
 static inline void *get_check_address(struct pt_regs *regs)
 {
-	return (void *) ADDR_BITS_REMOVE(regs->psw.addr-S390_lowcore.pgm_ilc);
+	return (void *)(regs->psw.addr - S390_lowcore.pgm_ilc);
 }
 
 int do_debugger_trap(struct pt_regs *regs,int signal)
 {
-	if(regs->psw.mask&PSW_PROBLEM_STATE)
+	if(regs->psw.mask&PSW_MASK_PSTATE)
 	{
 		if(current->ptrace & PT_PTRACED)
 			force_sig(signal,current);
@@ -418,14 +418,14 @@
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
 	 */
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
 	/* WARNING don't change this check back to */
-	/* int problem_state=(regs->psw.mask & PSW_PROBLEM_STATE); */
+	/* int problem_state=(regs->psw.mask & PSW_MASK_PSTATE); */
 	/* & then doing if(problem_state) an int is too small for this */
 	/* check on 64 bit. */
-	if(regs->psw.mask & PSW_PROBLEM_STATE)
+	if(regs->psw.mask & PSW_MASK_PSTATE)
 		get_user(*((__u16 *) opcode), location);
 	else
 		*((__u16 *)opcode)=*((__u16 *)location);
@@ -451,7 +451,7 @@
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
 	 */
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
 	__asm__ volatile ("stfpc %0\n\t" 
@@ -519,21 +519,19 @@
 
 void handle_per_exception(struct pt_regs *regs)
 {
-	if(regs->psw.mask&PSW_PROBLEM_STATE)
-	{
+	if (regs->psw.mask&PSW_MASK_PSTATE) {
 		per_struct *per_info=&current->thread.per_info;
 		per_info->lowcore.words.perc_atmid=S390_lowcore.per_perc_atmid;
 		per_info->lowcore.words.address=S390_lowcore.per_address;
 		per_info->lowcore.words.access_id=S390_lowcore.per_access_id;
 	}
-	if(do_debugger_trap(regs,SIGTRAP))
-	{
+	if (do_debugger_trap(regs,SIGTRAP)) {
 		/* I've seen this possibly a task structure being reused ? */
 		printk("Spurious per exception detected\n");
 		printk("switching off per tracing for this task.\n");
 		show_regs(regs);
 		/* Hopefully switching off per tracing will help us survive */
-		regs->psw.mask &= ~PSW_PER_MASK;
+		regs->psw.mask &= ~PSW_MASK_PER;
 	}
 }
 
diff -urN linux-2.5.34/arch/s390x/mm/fault.c linux-2.5.34-s390/arch/s390x/mm/fault.c
--- linux-2.5.34/arch/s390x/mm/fault.c	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/arch/s390x/mm/fault.c	Tue Sep 10 20:02:27 2002
@@ -167,7 +167,7 @@
 
 		/* Low-address protection hit in kernel mode means 
 		   NULL pointer write access in kernel mode.  */
- 		if (!(regs->psw.mask & PSW_PROBLEM_STATE)) {
+ 		if (!(regs->psw.mask & PSW_MASK_PSTATE)) {
 			address = 0;
 			user_address = 0;
 			goto no_context;
@@ -259,7 +259,7 @@
         up_read(&mm->mmap_sem);
 
         /* User mode accesses just cause a SIGSEGV */
-        if (regs->psw.mask & PSW_PROBLEM_STATE) {
+        if (regs->psw.mask & PSW_MASK_PSTATE) {
                 tsk->thread.prot_addr = address;
                 tsk->thread.trap_no = error_code;
 		force_sigsegv(regs, error_code, si_code, address);
@@ -299,7 +299,7 @@
 		goto survive;
 	}
 	printk("VM: killing process %s\n", tsk->comm);
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		do_exit(SIGKILL);
 	goto no_context;
 
@@ -315,7 +315,7 @@
 	force_sig(SIGBUS, tsk);
 
 	/* Kernel mode? Handle exceptions or die */
-	if (!(regs->psw.mask & PSW_PROBLEM_STATE))
+	if (!(regs->psw.mask & PSW_MASK_PSTATE))
 		goto no_context;
 }
 
@@ -441,7 +441,7 @@
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
 	 */
-	if (regs->psw.mask & PSW_PROBLEM_STATE)
+	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
 	if (subcode & 0x0080) {
diff -urN linux-2.5.34/drivers/s390/cio/cio.c linux-2.5.34-s390/drivers/s390/cio/cio.c
--- linux-2.5.34/drivers/s390/cio/cio.c	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/drivers/s390/cio/cio.c	Tue Sep 10 20:02:27 2002
@@ -98,7 +98,6 @@
 s390_do_sync_wait(int irq, int do_tpi)
 {
 	unsigned long psw_mask;
-	int ccode;
 	uint64_t time_start;
 	uint64_t time_curr;
 	
@@ -116,31 +115,7 @@
 	 *  sync. interrupt arrived we reset the I/O old PSW to
 	 *  its original value.
 	 */
-	
-	ccode = iac ();
-	
-	switch (ccode) {
-	case 0:	/* primary-space */
-		psw_mask = _IO_PSW_MASK
-			| _PSW_PRIM_SPACE_MODE | _PSW_IO_WAIT;
-		break;
-	case 1:	/* secondary-space */
-		psw_mask = _IO_PSW_MASK
-			| _PSW_SEC_SPACE_MODE | _PSW_IO_WAIT;
-		break;
-	case 2:	/* access-register */
-		psw_mask = _IO_PSW_MASK
-			| _PSW_ACC_REG_MODE | _PSW_IO_WAIT;
-		break;
-	case 3:	/* home-space */
-		psw_mask = _IO_PSW_MASK
-			| _PSW_HOME_SPACE_MODE | _PSW_IO_WAIT;
-		break;
-	default:
-		panic ("start_IO() : unexpected "
-		       "address-space-control %d\n", ccode);
-		break;
-	}
+	psw_mask = PSW_KERNEL_BITS | PSW_MASK_IO | PSW_MASK_WAIT;
 	
 	/*
 	 * Martin didn't like modifying the new PSW, now we take
@@ -201,7 +176,6 @@
 	int io_sub;
 	__u32 io_parm;
 	unsigned long psw_mask;
-	int ccode;
 	
 	int ready = 0;
 	
@@ -212,32 +186,7 @@
 	 * FIXME: Are there case where we can't rely on an interrupt
 	 *        to occurr? Need to check...
 	 */
-
-	ccode = iac ();
-	
-	switch (ccode) {
-	case 0:	/* primary-space */
-		psw_mask = _IO_PSW_MASK
-			| _PSW_PRIM_SPACE_MODE | _PSW_IO_WAIT;
-		break;
-	case 1:	/* secondary-space */
-		psw_mask = _IO_PSW_MASK
-			| _PSW_SEC_SPACE_MODE | _PSW_IO_WAIT;
-		break;
-	case 2:	/* access-register */
-		psw_mask = _IO_PSW_MASK
-			| _PSW_ACC_REG_MODE | _PSW_IO_WAIT;
-		break;
-	case 3:	/* home-space */
-		psw_mask = _IO_PSW_MASK
-			| _PSW_HOME_SPACE_MODE | _PSW_IO_WAIT;
-		break;
-	default: /* FIXME: isn't ccode only 2 bits anyway? */
-		panic (halt?"halt":"clear"
-		       "_IO() : unexpected address-space-control %d\n", 
-		       ccode);
-		break;
-	}
+	psw_mask = PSW_KERNEL_BITS | PSW_MASK_IO | PSW_MASK_WAIT;
 	
 	/*
 	 * Martin didn't like modifying the new PSW, now we take
@@ -960,7 +909,7 @@
 	 *       entry condition to synchronous I/O.
 	 */
 	if (*(__u32 *) __LC_SYNC_IO_WORD) {
-		regs.psw.mask &= ~(_PSW_WAIT_MASK_BIT | _PSW_IO_MASK_BIT);
+		regs.psw.mask &= ~(PSW_MASK_WAIT | PSW_MASK_IO);
 		return;
 	}
 	/* endif */
diff -urN linux-2.5.34/include/asm-s390/lowcore.h linux-2.5.34-s390/include/asm-s390/lowcore.h
--- linux-2.5.34/include/asm-s390/lowcore.h	Mon Sep  9 19:35:11 2002
+++ linux-2.5.34-s390/include/asm-s390/lowcore.h	Tue Sep 10 20:02:27 2002
@@ -52,41 +52,12 @@
 
 #define __LC_PFAULT_INTPARM             0x080
 
-/* interrupt handler start with all io, external and mcck interrupt disabled */
-
-#define _RESTART_PSW_MASK    0x00080000
-#define _EXT_PSW_MASK        0x04080000
-#define _PGM_PSW_MASK        0x04080000
-#define _SVC_PSW_MASK        0x04080000
-#define _MCCK_PSW_MASK       0x04080000
-#define _IO_PSW_MASK         0x04080000
-#define _USER_PSW_MASK       0x070DC000/* DAT, IO, EXT, Home-space         */
-#define _WAIT_PSW_MASK       0x070E0000/* DAT, IO, EXT, Wait, Home-space   */
-#define _DW_PSW_MASK         0x000A0000/* disabled wait PSW mask           */
-
-#define _PRIMARY_MASK        0x0000    /* MASK for SACF                    */
-#define _SECONDARY_MASK      0x0100    /* MASK for SACF                    */
-#define _ACCESS_MASK         0x0200    /* MASK for SACF                    */
-#define _HOME_MASK           0x0300    /* MASK for SACF                    */
-
-#define _PSW_PRIM_SPACE_MODE 0x00000000
-#define _PSW_SEC_SPACE_MODE  0x00008000
-#define _PSW_ACC_REG_MODE    0x00004000
-#define _PSW_HOME_SPACE_MODE 0x0000C000
-
-#define _PSW_WAIT_MASK_BIT   0x00020000 /* Wait bit */
-#define _PSW_IO_MASK_BIT     0x02000000 /* IO bit */
-#define _PSW_IO_WAIT         0x02020000 /* IO & Wait bit */
-
-/* we run in 31 Bit mode */
-#define _ADDR_31             0x80000000
-
 #ifndef __ASSEMBLY__
 
 #include <linux/config.h>
-#include <asm/processor.h>
 #include <linux/types.h>
 #include <asm/atomic.h>
+#include <asm/processor.h>
 #include <asm/sigp.h>
 
 void restart_int_handler(void);
@@ -176,25 +147,16 @@
 	__u8         pad12[0x1000-0xe04];      /* 0xe04 */
 } __attribute__((packed)); /* End structure*/
 
+#define S390_lowcore (*((struct _lowcore *) 0))
+extern struct _lowcore *lowcore_ptr[];
+
 extern __inline__ void set_prefix(__u32 address)
 {
         __asm__ __volatile__ ("spx %0" : : "m" (address) : "memory" );
 }
 
-#define S390_lowcore (*((struct _lowcore *) 0))
-extern struct _lowcore *lowcore_ptr[];
-
-#ifndef CONFIG_SMP
-#define get_cpu_lowcore(cpu)      (&S390_lowcore)
-#define safe_get_cpu_lowcore(cpu) (&S390_lowcore)
-#else
-#define get_cpu_lowcore(cpu)      (lowcore_ptr[(cpu)])
-#define safe_get_cpu_lowcore(cpu) \
-        ((cpu) == smp_processor_id() ? &S390_lowcore : lowcore_ptr[(cpu)])
-#endif
-#endif /* __ASSEMBLY__ */
-
 #define __PANIC_MAGIC           0xDEADC0DE
 
 #endif
 
+#endif
diff -urN linux-2.5.34/include/asm-s390/processor.h linux-2.5.34-s390/include/asm-s390/processor.h
--- linux-2.5.34/include/asm-s390/processor.h	Mon Sep  9 19:35:11 2002
+++ linux-2.5.34-s390/include/asm-s390/processor.h	Tue Sep 10 20:02:27 2002
@@ -101,8 +101,8 @@
 
 /* need to define ... */
 #define start_thread(regs, new_psw, new_stackp) do {            \
-        regs->psw.mask  = _USER_PSW_MASK;                       \
-        regs->psw.addr  = new_psw | 0x80000000;                 \
+        regs->psw.mask  = PSW_USER_BITS;                        \
+        regs->psw.addr  = new_psw | PSW_ADDR_AMODE31;           \
         regs->gprs[15]  = new_stackp ;                          \
 } while (0)
 
@@ -137,19 +137,6 @@
 #define cpu_relax()	barrier()
 
 /*
- * Set of msr bits that gdb can change on behalf of a process.
- */
-/* Only let our hackers near the condition codes */
-#define PSW_MASK_DEBUGCHANGE    0x00003000UL
-/* Don't let em near the addressing mode either */    
-#define PSW_ADDR_DEBUGCHANGE    0x7FFFFFFFUL
-#define PSW_ADDR_MASK           0x7FFFFFFFUL
-/* Program event recording mask */    
-#define PSW_PER_MASK            0x40000000UL
-#define USER_STD_MASK           0x00000080UL
-#define PSW_PROBLEM_STATE       0x00010000UL
-
-/*
  * Set PSW mask to specified value, while leaving the
  * PSW addr pointing to the next instruction.
  */
@@ -178,7 +165,8 @@
 	unsigned long reg;
 	psw_t wait_psw;
 
-	wait_psw.mask = 0x070e0000;
+	wait_psw.mask = PSW_BASE_BITS | PSW_MASK_IO | PSW_MASK_EXT |
+		PSW_MASK_MCHECK | PSW_MASK_WAIT;
 	asm volatile (
 		"    basr %0,0\n"
 		"0:  la   %0,1f-0b(%0)\n"
@@ -200,7 +188,7 @@
         psw_t *dw_psw = (psw_t *)(((unsigned long) &psw_buffer+sizeof(psw_t)-1)
                                   & -sizeof(psw_t));
 
-        dw_psw->mask = 0x000a0000;
+        dw_psw->mask = PSW_BASE_BITS | PSW_MASK_WAIT;
         dw_psw->addr = code;
         /* 
          * Store status and then load disabled wait psw,
diff -urN linux-2.5.34/include/asm-s390/ptrace.h linux-2.5.34-s390/include/asm-s390/ptrace.h
--- linux-2.5.34/include/asm-s390/ptrace.h	Mon Sep  9 19:35:04 2002
+++ linux-2.5.34-s390/include/asm-s390/ptrace.h	Tue Sep 10 20:02:27 2002
@@ -114,7 +114,6 @@
 #include <linux/config.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
-
 #include <asm/setup.h>
 
 /* this typedef defines how a Program Status Word looks like */
@@ -124,10 +123,32 @@
         __u32   addr;
 } __attribute__ ((aligned(8))) psw_t;
 
-#ifdef __KERNEL__
-#define FIX_PSW(addr) ((unsigned long)(addr)|0x80000000UL)
-#define ADDR_BITS_REMOVE(addr) ((addr)&0x7fffffff)
-#endif
+#define PSW_MASK_PER		0x40000000UL
+#define PSW_MASK_DAT		0x04000000UL
+#define PSW_MASK_IO		0x02000000UL
+#define PSW_MASK_EXT		0x01000000UL
+#define PSW_MASK_KEY		0x00F00000UL
+#define PSW_MASK_MCHECK		0x00040000UL
+#define PSW_MASK_WAIT		0x00020000UL
+#define PSW_MASK_PSTATE		0x00010000UL
+#define PSW_MASK_ASC		0x0000C000UL
+#define PSW_MASK_CC		0x00003000UL
+#define PSW_MASK_PM		0x00000F00UL
+
+#define PSW_ADDR_AMODE31	0x80000000UL
+#define PSW_ADDR_INSN		0x7FFFFFFFUL
+
+#define PSW_BASE_BITS		0x00080000UL
+
+#define PSW_ASC_PRIMARY		0x00000000UL
+#define PSW_ASC_ACCREG		0x00004000UL
+#define PSW_ASC_SECONDARY	0x00008000UL
+#define PSW_ASC_HOME		0x0000C000UL
+
+#define PSW_KERNEL_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY)
+#define PSW_USER_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
+			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
+			 PSW_MASK_PSTATE)
 
 typedef union
 {
@@ -328,8 +349,8 @@
 };
 
 #ifdef __KERNEL__
-#define user_mode(regs) (((regs)->psw.mask & PSW_PROBLEM_STATE) != 0)
-#define instruction_pointer(regs) ((regs)->psw.addr)
+#define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
+#define instruction_pointer(regs) ((regs)->psw.addr & PSW_MASK_INSN)
 extern void show_regs(struct pt_regs * regs);
 #endif
 
diff -urN linux-2.5.34/include/asm-s390x/lowcore.h linux-2.5.34-s390/include/asm-s390x/lowcore.h
--- linux-2.5.34/include/asm-s390x/lowcore.h	Tue Sep 10 20:02:23 2002
+++ linux-2.5.34-s390/include/asm-s390x/lowcore.h	Tue Sep 10 20:02:27 2002
@@ -56,32 +56,6 @@
 
 #define __LC_PFAULT_INTPARM             0x11B8
 
-/* interrupt handler start with all io, external and mcck interrupt disabled */
-
-#define _RESTART_PSW_MASK    0x0000000180000000
-#define _EXT_PSW_MASK        0x0400000180000000
-#define _PGM_PSW_MASK        0x0400000180000000
-#define _SVC_PSW_MASK        0x0400000180000000
-#define _MCCK_PSW_MASK       0x0400000180000000
-#define _IO_PSW_MASK         0x0400000180000000
-#define _USER_PSW_MASK       0x0705C00180000000
-#define _WAIT_PSW_MASK       0x0706000180000000
-#define _DW_PSW_MASK         0x0002000180000000
-
-#define _PRIMARY_MASK        0x0000    /* MASK for SACF                    */
-#define _SECONDARY_MASK      0x0100    /* MASK for SACF                    */
-#define _ACCESS_MASK         0x0200    /* MASK for SACF                    */
-#define _HOME_MASK           0x0300    /* MASK for SACF                    */
-
-#define _PSW_PRIM_SPACE_MODE 0x0000000000000000
-#define _PSW_SEC_SPACE_MODE  0x0000800000000000
-#define _PSW_ACC_REG_MODE    0x0000400000000000
-#define _PSW_HOME_SPACE_MODE 0x0000C00000000000
-
-#define _PSW_WAIT_MASK_BIT   0x0002000000000000
-#define _PSW_IO_MASK_BIT     0x0200000000000000
-#define _PSW_IO_WAIT         0x0202000000000000
-
 #ifndef __ASSEMBLY__
 
 #include <linux/config.h>
@@ -194,25 +168,17 @@
 	__u8         pad17[0x2000-0x1400];      /* 0x1400 */
 } __attribute__((packed)); /* End structure*/
 
+#define S390_lowcore (*((struct _lowcore *) 0))
+extern struct _lowcore *lowcore_ptr[];
+
 extern __inline__ void set_prefix(__u32 address)
 {
         __asm__ __volatile__ ("spx %0" : : "m" (address) : "memory" );
 }
 
-#define S390_lowcore (*((struct _lowcore *) 0))
-extern struct _lowcore *lowcore_ptr[];
+#define __PANIC_MAGIC           0xDEADC0DE
 
-#ifndef CONFIG_SMP
-#define get_cpu_lowcore(cpu)      (&S390_lowcore)
-#define safe_get_cpu_lowcore(cpu) (&S390_lowcore)
-#else
-#define get_cpu_lowcore(cpu)      (lowcore_ptr[(cpu)])
-#define safe_get_cpu_lowcore(cpu) \
-        ((cpu) == smp_processor_id() ? &S390_lowcore : lowcore_ptr[(cpu)])
 #endif
-#endif /* __ASSEMBLY__ */
-
-#define __PANIC_MAGIC           0xDEADC0DE
 
 #endif
 
diff -urN linux-2.5.34/include/asm-s390x/processor.h linux-2.5.34-s390/include/asm-s390x/processor.h
--- linux-2.5.34/include/asm-s390x/processor.h	Mon Sep  9 19:35:06 2002
+++ linux-2.5.34-s390/include/asm-s390x/processor.h	Tue Sep 10 20:02:27 2002
@@ -111,13 +111,13 @@
 
 /* need to define ... */
 #define start_thread(regs, new_psw, new_stackp) do {            \
-        regs->psw.mask  = _USER_PSW_MASK;                       \
+        regs->psw.mask  = PSW_USER_BITS;                        \
         regs->psw.addr  = new_psw;                              \
         regs->gprs[15]  = new_stackp;                           \
 } while (0)
 
 #define start_thread31(regs, new_psw, new_stackp) do {          \
-	regs->psw.mask  = _USER_PSW_MASK & ~(1L << 32);		\
+	regs->psw.mask  = PSW_USER32_BITS;			\
         regs->psw.addr  = new_psw;                              \
         regs->gprs[15]  = new_stackp;                           \
 } while (0)
@@ -154,19 +154,6 @@
 #define cpu_relax()	barrier()
 
 /*
- * Set of msr bits that gdb can change on behalf of a process.
- */
-/* Only let our hackers near the condition codes */
-#define PSW_MASK_DEBUGCHANGE    0x0000300000000000UL
-/* Don't let em near the addressing mode either */    
-#define PSW_ADDR_DEBUGCHANGE    0xFFFFFFFFFFFFFFFFUL
-#define PSW_ADDR_MASK           0xFFFFFFFFFFFFFFFFUL
-/* Program event recording mask */    
-#define PSW_PER_MASK            0x4000000000000000UL
-#define USER_STD_MASK           0x0000000000000080UL
-#define PSW_PROBLEM_STATE       0x0001000000000000UL
-
-/*
  * Set PSW mask to specified value, while leaving the
  * PSW addr pointing to the next instruction.
  */
@@ -194,7 +181,8 @@
 	unsigned long reg;
 	psw_t wait_psw;
 
-	wait_psw.mask = 0x0706000180000000;
+	wait_psw.mask = PSW_BASE_BITS | PSW_MASK_IO | PSW_MASK_EXT |
+		PSW_MASK_MCHECK | PSW_MASK_WAIT;
 	asm volatile (
 		"    larl  %0,0f\n"
 		"    stg   %0,8(%1)\n"
@@ -214,7 +202,7 @@
         psw_t *dw_psw = (psw_t *)(((unsigned long) &psw_buffer+sizeof(psw_t)-1)
                                   & -sizeof(psw_t));
 
-        dw_psw->mask = 0x0002000180000000;
+        dw_psw->mask = PSW_BASE_BITS | PSW_MASK_WAIT;
         dw_psw->addr = code;
         /* 
          * Store status and then load disabled wait psw,
diff -urN linux-2.5.34/include/asm-s390x/ptrace.h linux-2.5.34-s390/include/asm-s390x/ptrace.h
--- linux-2.5.34/include/asm-s390x/ptrace.h	Mon Sep  9 19:35:05 2002
+++ linux-2.5.34-s390/include/asm-s390x/ptrace.h	Tue Sep 10 20:02:27 2002
@@ -104,10 +104,33 @@
         __u64   addr;
 } __attribute__ ((aligned(8))) psw_t;
 
-#ifdef __KERNEL__
-#define FIX_PSW(addr) ((unsigned long)(addr))
-#define ADDR_BITS_REMOVE(addr) ((addr))
-#endif
+#define PSW_MASK_PER		0x4000000000000000UL
+#define PSW_MASK_DAT		0x0400000000000000UL
+#define PSW_MASK_IO		0x0200000000000000UL
+#define PSW_MASK_EXT		0x0100000000000000UL
+#define PSW_MASK_KEY		0x00F0000000000000UL
+#define PSW_MASK_MCHECK		0x0004000000000000UL
+#define PSW_MASK_WAIT		0x0002000000000000UL
+#define PSW_MASK_PSTATE		0x0001000000000000UL
+#define PSW_MASK_ASC		0x0000C00000000000UL
+#define PSW_MASK_CC		0x0000300000000000UL
+#define PSW_MASK_PM		0x00000F0000000000UL
+
+#define PSW_BASE_BITS		0x0000000180000000UL
+#define PSW_BASE32_BITS		0x0000000080000000UL
+
+#define PSW_ASC_PRIMARY		0x0000000000000000UL
+#define PSW_ASC_ACCREG		0x0000400000000000UL
+#define PSW_ASC_SECONDARY	0x0000800000000000UL
+#define PSW_ASC_HOME		0x0000C00000000000UL
+
+#define PSW_KERNEL_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY)
+#define PSW_USER_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
+			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
+			 PSW_MASK_PSTATE)
+#define PSW_USER32_BITS (PSW_BASE32_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
+			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
+			 PSW_MASK_PSTATE)
 
 typedef union
 {
@@ -309,7 +332,7 @@
 };
 
 #ifdef __KERNEL__
-#define user_mode(regs) (((regs)->psw.mask & PSW_PROBLEM_STATE) != 0)
+#define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
 #define instruction_pointer(regs) ((regs)->psw.addr)
 extern void show_regs(struct pt_regs * regs);
 #endif

