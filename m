Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313946AbSDPXTB>; Tue, 16 Apr 2002 19:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313947AbSDPXTB>; Tue, 16 Apr 2002 19:19:01 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:49096 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S313946AbSDPXSz>; Tue, 16 Apr 2002 19:18:55 -0400
Message-ID: <3CBCB0DC.1020705@didntduck.org>
Date: Tue, 16 Apr 2002 19:16:44 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Removing SYMBOL_NAME part 1
Content-Type: multipart/mixed;
 boundary="------------010300060102040505040206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010300060102040505040206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The SYMBOL_NAME macro (and variations) have been obsolete since 2.1.0, 
when the option to compile the kernel in a.out format was removed.  This 
patch starts the process of removing these macros, starting with x86.

-- 

						Brian Gerst

--------------010300060102040505040206
Content-Type: text/plain;
 name="symbol_name-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="symbol_name-1"

diff -urN linux-2.5.8/arch/i386/boot/compressed/head.S linux/arch/i386/boot/compressed/head.S
--- linux-2.5.8/arch/i386/boot/compressed/head.S	Thu Mar  7 21:18:27 2002
+++ linux/arch/i386/boot/compressed/head.S	Tue Apr 16 18:47:34 2002
@@ -37,7 +37,7 @@
 	movl %eax,%fs
 	movl %eax,%gs
 
-	lss SYMBOL_NAME(stack_start),%esp
+	lss stack_start,%esp
 	xorl %eax,%eax
 1:	incl %eax		# check that A20 really IS enabled
 	movl %eax,0x000000	# loop forever if it isn't
@@ -55,8 +55,8 @@
  * Clear BSS
  */
 	xorl %eax,%eax
-	movl $ SYMBOL_NAME(_edata),%edi
-	movl $ SYMBOL_NAME(_end),%ecx
+	movl $_edata,%edi
+	movl $_end,%ecx
 	subl %edi,%ecx
 	cld
 	rep
@@ -68,7 +68,7 @@
 	movl %esp,%eax
 	pushl %esi	# real mode pointer as second arg
 	pushl %eax	# address of structure as first arg
-	call SYMBOL_NAME(decompress_kernel)
+	call decompress_kernel
 	orl  %eax,%eax 
 	jnz  3f
 	popl %esi	# discard address
diff -urN linux-2.5.8/arch/i386/kernel/acpi_wakeup.S linux/arch/i386/kernel/acpi_wakeup.S
--- linux-2.5.8/arch/i386/kernel/acpi_wakeup.S	Sun Apr 14 23:48:18 2002
+++ linux/arch/i386/kernel/acpi_wakeup.S	Tue Apr 16 18:47:34 2002
@@ -36,7 +36,7 @@
 	orl     $0x80000001, %eax
 	movl	%eax, %cr0
 
-	ljmpl	$__KERNEL_CS,$SYMBOL_NAME(wakeup_pmode_return)
+	ljmpl	$__KERNEL_CS,$wakeup_pmode_return
 
 	.code32
 	ALIGN
diff -urN linux-2.5.8/arch/i386/kernel/apm.c linux/arch/i386/kernel/apm.c
--- linux-2.5.8/arch/i386/kernel/apm.c	Wed Apr 10 19:59:37 2002
+++ linux/arch/i386/kernel/apm.c	Tue Apr 16 18:47:34 2002
@@ -578,7 +578,7 @@
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
-		"lcall *%%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
+		"lcall *%%cs:apm_bios_entry\n\t"
 		"setc %%al\n\t"
 		"popl %%ebp\n\t"
 		"popl %%edi\n\t"
@@ -625,7 +625,7 @@
 		__asm__ __volatile__(APM_DO_ZERO_SEGS
 			"pushl %%edi\n\t"
 			"pushl %%ebp\n\t"
-			"lcall *%%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
+			"lcall *%%cs:apm_bios_entry\n\t"
 			"setc %%bl\n\t"
 			"popl %%ebp\n\t"
 			"popl %%edi\n\t"
diff -urN linux-2.5.8/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.8/arch/i386/kernel/entry.S	Sun Apr 14 23:48:18 2002
+++ linux/arch/i386/kernel/entry.S	Tue Apr 16 18:47:34 2002
@@ -197,7 +197,7 @@
 
 ENTRY(ret_from_fork)
 #if CONFIG_SMP || CONFIG_PREEMPT
-	call SYMBOL_NAME(schedule_tail)
+	call schedule_tail
 #endif
 	GET_THREAD_INFO(%ebx)
 	jmp syscall_exit
@@ -236,12 +236,12 @@
 	movl TI_FLAGS(%ebx), %ecx
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
-	movl SYMBOL_NAME(irq_stat)+local_bh_count CPU_IDX, %ecx
-	addl SYMBOL_NAME(irq_stat)+local_irq_count CPU_IDX, %ecx
+	movl irq_stat+local_bh_count CPU_IDX, %ecx
+	addl irq_stat+local_irq_count CPU_IDX, %ecx
 	jnz restore_all
 	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebx)
 	sti
-	call SYMBOL_NAME(schedule)
+	call schedule
 	movl $0,TI_PRE_COUNT(%ebx) 
 	jmp restore_all
 #endif
@@ -258,7 +258,7 @@
 	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebx)
 	jnz syscall_trace_entry
 syscall_call:
-	call *SYMBOL_NAME(sys_call_table)(,%eax,4)
+	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
 	cli				# make sure we don't miss an interrupt
@@ -276,7 +276,7 @@
 	testb $_TIF_NEED_RESCHED, %cl
 	jz work_notifysig
 work_resched:
-	call SYMBOL_NAME(schedule)
+	call schedule
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
@@ -294,17 +294,17 @@
 	jne work_notifysig_v86		# returning to kernel-space or
 					# vm86-space
 	xorl %edx, %edx
-	call SYMBOL_NAME(do_notify_resume)
+	call do_notify_resume
 	jmp restore_all
 
 	ALIGN
 work_notifysig_v86:
 	pushl %ecx
-	call SYMBOL_NAME(save_v86_state)
+	call save_v86_state
 	popl %ecx
 	movl %eax, %esp
 	xorl %edx, %edx
-	call SYMBOL_NAME(do_notify_resume)
+	call do_notify_resume
 	jmp restore_all
 
 	# perform syscall exit tracing
@@ -313,7 +313,7 @@
 	movl $-ENOSYS,EAX(%esp)
 	movl %esp, %eax
 	xorl %edx,%edx
-	call SYMBOL_NAME(do_syscall_trace)
+	call do_syscall_trace
 	movl ORIG_EAX(%esp), %eax
 	cmpl $(NR_syscalls), %eax
 	jnae syscall_call
@@ -328,7 +328,7 @@
 					# schedule() instead
 	movl %esp, %eax
 	movl $1, %edx
-	call SYMBOL_NAME(do_syscall_trace)
+	call do_syscall_trace
 	jmp resume_userspace
 
 	ALIGN
@@ -361,7 +361,7 @@
 	SAVE_ALL
 	GET_THREAD_INFO(%ebx)
 	INC_PRE_COUNT(%ebx)
-	call SYMBOL_NAME(do_IRQ)
+	call do_IRQ
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
@@ -370,7 +370,7 @@
 	SAVE_ALL			\
 	GET_THREAD_INFO(%ebx);		\
 	INC_PRE_COUNT(%ebx)		\
-	call SYMBOL_NAME(smp_/**/name);	\
+	call smp_/**/name;	\
 	jmp ret_from_intr;
 
 /*
@@ -399,7 +399,7 @@
 
 ENTRY(divide_error)
 	pushl $0			# no error code
-	pushl $ SYMBOL_NAME(do_divide_error)
+	pushl $do_divide_error
 	ALIGN
 error_code:
 	pushl %ds
@@ -432,12 +432,12 @@
 
 ENTRY(coprocessor_error)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_coprocessor_error)
+	pushl $do_coprocessor_error
 	jmp error_code
 
 ENTRY(simd_coprocessor_error)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_simd_coprocessor_error)
+	pushl $do_simd_coprocessor_error
 	jmp error_code
 
 ENTRY(device_not_available)
@@ -448,18 +448,18 @@
 	testl $0x4, %eax		# EM (math emulation bit)
 	jne device_not_available_emulate
 	preempt_stop
-	call SYMBOL_NAME(math_state_restore)
+	call math_state_restore
 	jmp ret_from_exception
 device_not_available_emulate:
 	pushl $0			# temporary storage for ORIG_EIP
-	call  SYMBOL_NAME(math_emulate)
+	call math_emulate
 	addl $4, %esp
 	preempt_stop
 	jmp ret_from_exception
 
 ENTRY(debug)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_debug)
+	pushl $do_debug
 	jmp error_code
 
 ENTRY(nmi)
@@ -468,320 +468,319 @@
 	movl %esp, %edx
 	pushl $0
 	pushl %edx
-	call SYMBOL_NAME(do_nmi)
+	call do_nmi
 	addl $8, %esp
 	RESTORE_ALL
 
 ENTRY(int3)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_int3)
+	pushl $do_int3
 	jmp error_code
 
 ENTRY(overflow)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_overflow)
+	pushl $do_overflow
 	jmp error_code
 
 ENTRY(bounds)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_bounds)
+	pushl $do_bounds
 	jmp error_code
 
 ENTRY(invalid_op)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_invalid_op)
+	pushl $do_invalid_op
 	jmp error_code
 
 ENTRY(coprocessor_segment_overrun)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_coprocessor_segment_overrun)
+	pushl $do_coprocessor_segment_overrun
 	jmp error_code
 
 ENTRY(double_fault)
-	pushl $ SYMBOL_NAME(do_double_fault)
+	pushl $do_double_fault
 	jmp error_code
 
 ENTRY(invalid_TSS)
-	pushl $ SYMBOL_NAME(do_invalid_TSS)
+	pushl $do_invalid_TSS
 	jmp error_code
 
 ENTRY(segment_not_present)
-	pushl $ SYMBOL_NAME(do_segment_not_present)
+	pushl $do_segment_not_present
 	jmp error_code
 
 ENTRY(stack_segment)
-	pushl $ SYMBOL_NAME(do_stack_segment)
+	pushl $do_stack_segment
 	jmp error_code
 
 ENTRY(general_protection)
-	pushl $ SYMBOL_NAME(do_general_protection)
+	pushl $do_general_protection
 	jmp error_code
 
 ENTRY(alignment_check)
-	pushl $ SYMBOL_NAME(do_alignment_check)
+	pushl $do_alignment_check
 	jmp error_code
 
 ENTRY(page_fault)
-	pushl $ SYMBOL_NAME(do_page_fault)
+	pushl $do_page_fault
 	jmp error_code
 
 ENTRY(machine_check)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_machine_check)
+	pushl $do_machine_check
 	jmp error_code
 
 ENTRY(spurious_interrupt_bug)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_spurious_interrupt_bug)
+	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
 .data
 ENTRY(sys_call_table)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* 0  -  old "setup()" system call*/
-	.long SYMBOL_NAME(sys_exit)
-	.long SYMBOL_NAME(sys_fork)
-	.long SYMBOL_NAME(sys_read)
-	.long SYMBOL_NAME(sys_write)
-	.long SYMBOL_NAME(sys_open)		/* 5 */
-	.long SYMBOL_NAME(sys_close)
-	.long SYMBOL_NAME(sys_waitpid)
-	.long SYMBOL_NAME(sys_creat)
-	.long SYMBOL_NAME(sys_link)
-	.long SYMBOL_NAME(sys_unlink)		/* 10 */
-	.long SYMBOL_NAME(sys_execve)
-	.long SYMBOL_NAME(sys_chdir)
-	.long SYMBOL_NAME(sys_time)
-	.long SYMBOL_NAME(sys_mknod)
-	.long SYMBOL_NAME(sys_chmod)		/* 15 */
-	.long SYMBOL_NAME(sys_lchown16)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old break syscall holder */
-	.long SYMBOL_NAME(sys_stat)
-	.long SYMBOL_NAME(sys_lseek)
-	.long SYMBOL_NAME(sys_getpid)		/* 20 */
-	.long SYMBOL_NAME(sys_mount)
-	.long SYMBOL_NAME(sys_oldumount)
-	.long SYMBOL_NAME(sys_setuid16)
-	.long SYMBOL_NAME(sys_getuid16)
-	.long SYMBOL_NAME(sys_stime)		/* 25 */
-	.long SYMBOL_NAME(sys_ptrace)
-	.long SYMBOL_NAME(sys_alarm)
-	.long SYMBOL_NAME(sys_fstat)
-	.long SYMBOL_NAME(sys_pause)
-	.long SYMBOL_NAME(sys_utime)		/* 30 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old stty syscall holder */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old gtty syscall holder */
-	.long SYMBOL_NAME(sys_access)
-	.long SYMBOL_NAME(sys_nice)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* 35 */
-						/* old ftime syscall holder */
-	.long SYMBOL_NAME(sys_sync)
-	.long SYMBOL_NAME(sys_kill)
-	.long SYMBOL_NAME(sys_rename)
-	.long SYMBOL_NAME(sys_mkdir)
-	.long SYMBOL_NAME(sys_rmdir)		/* 40 */
-	.long SYMBOL_NAME(sys_dup)
-	.long SYMBOL_NAME(sys_pipe)
-	.long SYMBOL_NAME(sys_times)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old prof syscall holder */
-	.long SYMBOL_NAME(sys_brk)		/* 45 */
-	.long SYMBOL_NAME(sys_setgid16)
-	.long SYMBOL_NAME(sys_getgid16)
-	.long SYMBOL_NAME(sys_signal)
-	.long SYMBOL_NAME(sys_geteuid16)
-	.long SYMBOL_NAME(sys_getegid16)	/* 50 */
-	.long SYMBOL_NAME(sys_acct)
-	.long SYMBOL_NAME(sys_umount)		/* recycled never used phys() */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old lock syscall holder */
-	.long SYMBOL_NAME(sys_ioctl)
-	.long SYMBOL_NAME(sys_fcntl)		/* 55 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old mpx syscall holder */
-	.long SYMBOL_NAME(sys_setpgid)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old ulimit syscall holder */
-	.long SYMBOL_NAME(sys_olduname)
-	.long SYMBOL_NAME(sys_umask)		/* 60 */
-	.long SYMBOL_NAME(sys_chroot)
-	.long SYMBOL_NAME(sys_ustat)
-	.long SYMBOL_NAME(sys_dup2)
-	.long SYMBOL_NAME(sys_getppid)
-	.long SYMBOL_NAME(sys_getpgrp)		/* 65 */
-	.long SYMBOL_NAME(sys_setsid)
-	.long SYMBOL_NAME(sys_sigaction)
-	.long SYMBOL_NAME(sys_sgetmask)
-	.long SYMBOL_NAME(sys_ssetmask)
-	.long SYMBOL_NAME(sys_setreuid16)	/* 70 */
-	.long SYMBOL_NAME(sys_setregid16)
-	.long SYMBOL_NAME(sys_sigsuspend)
-	.long SYMBOL_NAME(sys_sigpending)
-	.long SYMBOL_NAME(sys_sethostname)
-	.long SYMBOL_NAME(sys_setrlimit)	/* 75 */
-	.long SYMBOL_NAME(sys_old_getrlimit)
-	.long SYMBOL_NAME(sys_getrusage)
-	.long SYMBOL_NAME(sys_gettimeofday)
-	.long SYMBOL_NAME(sys_settimeofday)
-	.long SYMBOL_NAME(sys_getgroups16)	/* 80 */
-	.long SYMBOL_NAME(sys_setgroups16)
-	.long SYMBOL_NAME(old_select)
-	.long SYMBOL_NAME(sys_symlink)
-	.long SYMBOL_NAME(sys_lstat)
-	.long SYMBOL_NAME(sys_readlink)		/* 85 */
-	.long SYMBOL_NAME(sys_uselib)
-	.long SYMBOL_NAME(sys_swapon)
-	.long SYMBOL_NAME(sys_reboot)
-	.long SYMBOL_NAME(old_readdir)
-	.long SYMBOL_NAME(old_mmap)		/* 90 */
-	.long SYMBOL_NAME(sys_munmap)
-	.long SYMBOL_NAME(sys_truncate)
-	.long SYMBOL_NAME(sys_ftruncate)
-	.long SYMBOL_NAME(sys_fchmod)
-	.long SYMBOL_NAME(sys_fchown16)		/* 95 */
-	.long SYMBOL_NAME(sys_getpriority)
-	.long SYMBOL_NAME(sys_setpriority)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old profil syscall holder */
-	.long SYMBOL_NAME(sys_statfs)
-	.long SYMBOL_NAME(sys_fstatfs)		/* 100 */
-	.long SYMBOL_NAME(sys_ioperm)
-	.long SYMBOL_NAME(sys_socketcall)
-	.long SYMBOL_NAME(sys_syslog)
-	.long SYMBOL_NAME(sys_setitimer)
-	.long SYMBOL_NAME(sys_getitimer)	/* 105 */
-	.long SYMBOL_NAME(sys_newstat)
-	.long SYMBOL_NAME(sys_newlstat)
-	.long SYMBOL_NAME(sys_newfstat)
-	.long SYMBOL_NAME(sys_uname)
-	.long SYMBOL_NAME(sys_iopl)		/* 110 */
-	.long SYMBOL_NAME(sys_vhangup)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old "idle" system call */
-	.long SYMBOL_NAME(sys_vm86old)
-	.long SYMBOL_NAME(sys_wait4)
-	.long SYMBOL_NAME(sys_swapoff)		/* 115 */
-	.long SYMBOL_NAME(sys_sysinfo)
-	.long SYMBOL_NAME(sys_ipc)
-	.long SYMBOL_NAME(sys_fsync)
-	.long SYMBOL_NAME(sys_sigreturn)
-	.long SYMBOL_NAME(sys_clone)		/* 120 */
-	.long SYMBOL_NAME(sys_setdomainname)
-	.long SYMBOL_NAME(sys_newuname)
-	.long SYMBOL_NAME(sys_modify_ldt)
-	.long SYMBOL_NAME(sys_adjtimex)
-	.long SYMBOL_NAME(sys_mprotect)		/* 125 */
-	.long SYMBOL_NAME(sys_sigprocmask)
-	.long SYMBOL_NAME(sys_create_module)
-	.long SYMBOL_NAME(sys_init_module)
-	.long SYMBOL_NAME(sys_delete_module)
-	.long SYMBOL_NAME(sys_get_kernel_syms)	/* 130 */
-	.long SYMBOL_NAME(sys_quotactl)
-	.long SYMBOL_NAME(sys_getpgid)
-	.long SYMBOL_NAME(sys_fchdir)
-	.long SYMBOL_NAME(sys_bdflush)
-	.long SYMBOL_NAME(sys_sysfs)		/* 135 */
-	.long SYMBOL_NAME(sys_personality)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* for afs_syscall */
-	.long SYMBOL_NAME(sys_setfsuid16)
-	.long SYMBOL_NAME(sys_setfsgid16)
-	.long SYMBOL_NAME(sys_llseek)		/* 140 */
-	.long SYMBOL_NAME(sys_getdents)
-	.long SYMBOL_NAME(sys_select)
-	.long SYMBOL_NAME(sys_flock)
-	.long SYMBOL_NAME(sys_msync)
-	.long SYMBOL_NAME(sys_readv)		/* 145 */
-	.long SYMBOL_NAME(sys_writev)
-	.long SYMBOL_NAME(sys_getsid)
-	.long SYMBOL_NAME(sys_fdatasync)
-	.long SYMBOL_NAME(sys_sysctl)
-	.long SYMBOL_NAME(sys_mlock)		/* 150 */
-	.long SYMBOL_NAME(sys_munlock)
-	.long SYMBOL_NAME(sys_mlockall)
-	.long SYMBOL_NAME(sys_munlockall)
-	.long SYMBOL_NAME(sys_sched_setparam)
-	.long SYMBOL_NAME(sys_sched_getparam)   /* 155 */
-	.long SYMBOL_NAME(sys_sched_setscheduler)
-	.long SYMBOL_NAME(sys_sched_getscheduler)
-	.long SYMBOL_NAME(sys_sched_yield)
-	.long SYMBOL_NAME(sys_sched_get_priority_max)
-	.long SYMBOL_NAME(sys_sched_get_priority_min)  /* 160 */
-	.long SYMBOL_NAME(sys_sched_rr_get_interval)
-	.long SYMBOL_NAME(sys_nanosleep)
-	.long SYMBOL_NAME(sys_mremap)
-	.long SYMBOL_NAME(sys_setresuid16)
-	.long SYMBOL_NAME(sys_getresuid16)	/* 165 */
-	.long SYMBOL_NAME(sys_vm86)
-	.long SYMBOL_NAME(sys_query_module)
-	.long SYMBOL_NAME(sys_poll)
-	.long SYMBOL_NAME(sys_nfsservctl)
-	.long SYMBOL_NAME(sys_setresgid16)	/* 170 */
-	.long SYMBOL_NAME(sys_getresgid16)
-	.long SYMBOL_NAME(sys_prctl)
-	.long SYMBOL_NAME(sys_rt_sigreturn)
-	.long SYMBOL_NAME(sys_rt_sigaction)
-	.long SYMBOL_NAME(sys_rt_sigprocmask)	/* 175 */
-	.long SYMBOL_NAME(sys_rt_sigpending)
-	.long SYMBOL_NAME(sys_rt_sigtimedwait)
-	.long SYMBOL_NAME(sys_rt_sigqueueinfo)
-	.long SYMBOL_NAME(sys_rt_sigsuspend)
-	.long SYMBOL_NAME(sys_pread)		/* 180 */
-	.long SYMBOL_NAME(sys_pwrite)
-	.long SYMBOL_NAME(sys_chown16)
-	.long SYMBOL_NAME(sys_getcwd)
-	.long SYMBOL_NAME(sys_capget)
-	.long SYMBOL_NAME(sys_capset)           /* 185 */
-	.long SYMBOL_NAME(sys_sigaltstack)
-	.long SYMBOL_NAME(sys_sendfile)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* streams1 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* streams2 */
-	.long SYMBOL_NAME(sys_vfork)            /* 190 */
-	.long SYMBOL_NAME(sys_getrlimit)
-	.long SYMBOL_NAME(sys_mmap2)
-	.long SYMBOL_NAME(sys_truncate64)
-	.long SYMBOL_NAME(sys_ftruncate64)
-	.long SYMBOL_NAME(sys_stat64)		/* 195 */
-	.long SYMBOL_NAME(sys_lstat64)
-	.long SYMBOL_NAME(sys_fstat64)
-	.long SYMBOL_NAME(sys_lchown)
-	.long SYMBOL_NAME(sys_getuid)
-	.long SYMBOL_NAME(sys_getgid)		/* 200 */
-	.long SYMBOL_NAME(sys_geteuid)
-	.long SYMBOL_NAME(sys_getegid)
-	.long SYMBOL_NAME(sys_setreuid)
-	.long SYMBOL_NAME(sys_setregid)
-	.long SYMBOL_NAME(sys_getgroups)	/* 205 */
-	.long SYMBOL_NAME(sys_setgroups)
-	.long SYMBOL_NAME(sys_fchown)
-	.long SYMBOL_NAME(sys_setresuid)
-	.long SYMBOL_NAME(sys_getresuid)
-	.long SYMBOL_NAME(sys_setresgid)	/* 210 */
-	.long SYMBOL_NAME(sys_getresgid)
-	.long SYMBOL_NAME(sys_chown)
-	.long SYMBOL_NAME(sys_setuid)
-	.long SYMBOL_NAME(sys_setgid)
-	.long SYMBOL_NAME(sys_setfsuid)		/* 215 */
-	.long SYMBOL_NAME(sys_setfsgid)
-	.long SYMBOL_NAME(sys_pivot_root)
-	.long SYMBOL_NAME(sys_mincore)
-	.long SYMBOL_NAME(sys_madvise)
-	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
-	.long SYMBOL_NAME(sys_fcntl64)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for TUX */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
-	.long SYMBOL_NAME(sys_gettid)
-	.long SYMBOL_NAME(sys_readahead)	/* 225 */
-	.long SYMBOL_NAME(sys_setxattr)
-	.long SYMBOL_NAME(sys_lsetxattr)
-	.long SYMBOL_NAME(sys_fsetxattr)
-	.long SYMBOL_NAME(sys_getxattr)
-	.long SYMBOL_NAME(sys_lgetxattr)	/* 230 */
-	.long SYMBOL_NAME(sys_fgetxattr)
-	.long SYMBOL_NAME(sys_listxattr)
-	.long SYMBOL_NAME(sys_llistxattr)
-	.long SYMBOL_NAME(sys_flistxattr)
-	.long SYMBOL_NAME(sys_removexattr)	/* 235 */
-	.long SYMBOL_NAME(sys_lremovexattr)
-	.long SYMBOL_NAME(sys_fremovexattr)
-	.long SYMBOL_NAME(sys_tkill)
-	.long SYMBOL_NAME(sys_sendfile64)
-	.long SYMBOL_NAME(sys_futex)		/* 240 */
-	.long SYMBOL_NAME(sys_sched_setaffinity)
-	.long SYMBOL_NAME(sys_sched_getaffinity)
+	.long sys_ni_syscall	/* 0 - old "setup()" system call*/
+	.long sys_exit
+	.long sys_fork
+	.long sys_read
+	.long sys_write
+	.long sys_open		/* 5 */
+	.long sys_close
+	.long sys_waitpid
+	.long sys_creat
+	.long sys_link
+	.long sys_unlink	/* 10 */
+	.long sys_execve
+	.long sys_chdir
+	.long sys_time
+	.long sys_mknod
+	.long sys_chmod		/* 15 */
+	.long sys_lchown16
+	.long sys_ni_syscall	/* old break syscall holder */
+	.long sys_stat
+	.long sys_lseek
+	.long sys_getpid	/* 20 */
+	.long sys_mount
+	.long sys_oldumount
+	.long sys_setuid16
+	.long sys_getuid16
+	.long sys_stime		/* 25 */
+	.long sys_ptrace
+	.long sys_alarm
+	.long sys_fstat
+	.long sys_pause
+	.long sys_utime		/* 30 */
+	.long sys_ni_syscall	/* old stty syscall holder */
+	.long sys_ni_syscall	/* old gtty syscall holder */
+	.long sys_access
+	.long sys_nice
+	.long sys_ni_syscall	/* 35 - old ftime syscall holder */
+	.long sys_sync
+	.long sys_kill
+	.long sys_rename
+	.long sys_mkdir
+	.long sys_rmdir		/* 40 */
+	.long sys_dup
+	.long sys_pipe
+	.long sys_times
+	.long sys_ni_syscall	/* old prof syscall holder */
+	.long sys_brk		/* 45 */
+	.long sys_setgid16
+	.long sys_getgid16
+	.long sys_signal
+	.long sys_geteuid16
+	.long sys_getegid16	/* 50 */
+	.long sys_acct
+	.long sys_umount	/* recycled never used phys() */
+	.long sys_ni_syscall	/* old lock syscall holder */
+	.long sys_ioctl
+	.long sys_fcntl		/* 55 */
+	.long sys_ni_syscall	/* old mpx syscall holder */
+	.long sys_setpgid
+	.long sys_ni_syscall	/* old ulimit syscall holder */
+	.long sys_olduname
+	.long sys_umask		/* 60 */
+	.long sys_chroot
+	.long sys_ustat
+	.long sys_dup2
+	.long sys_getppid
+	.long sys_getpgrp	/* 65 */
+	.long sys_setsid
+	.long sys_sigaction
+	.long sys_sgetmask
+	.long sys_ssetmask
+	.long sys_setreuid16	/* 70 */
+	.long sys_setregid16
+	.long sys_sigsuspend
+	.long sys_sigpending
+	.long sys_sethostname
+	.long sys_setrlimit	/* 75 */
+	.long sys_old_getrlimit
+	.long sys_getrusage
+	.long sys_gettimeofday
+	.long sys_settimeofday
+	.long sys_getgroups16	/* 80 */
+	.long sys_setgroups16
+	.long old_select
+	.long sys_symlink
+	.long sys_lstat
+	.long sys_readlink	/* 85 */
+	.long sys_uselib
+	.long sys_swapon
+	.long sys_reboot
+	.long old_readdir
+	.long old_mmap		/* 90 */
+	.long sys_munmap
+	.long sys_truncate
+	.long sys_ftruncate
+	.long sys_fchmod
+	.long sys_fchown16	/* 95 */
+	.long sys_getpriority
+	.long sys_setpriority
+	.long sys_ni_syscall	/* old profil syscall holder */
+	.long sys_statfs
+	.long sys_fstatfs	/* 100 */
+	.long sys_ioperm
+	.long sys_socketcall
+	.long sys_syslog
+	.long sys_setitimer
+	.long sys_getitimer	/* 105 */
+	.long sys_newstat
+	.long sys_newlstat
+	.long sys_newfstat
+	.long sys_uname
+	.long sys_iopl		/* 110 */
+	.long sys_vhangup
+	.long sys_ni_syscall	/* old "idle" system call */
+	.long sys_vm86old
+	.long sys_wait4
+	.long sys_swapoff	/* 115 */
+	.long sys_sysinfo
+	.long sys_ipc
+	.long sys_fsync
+	.long sys_sigreturn
+	.long sys_clone		/* 120 */
+	.long sys_setdomainname
+	.long sys_newuname
+	.long sys_modify_ldt
+	.long sys_adjtimex
+	.long sys_mprotect	/* 125 */
+	.long sys_sigprocmask
+	.long sys_create_module
+	.long sys_init_module
+	.long sys_delete_module
+	.long sys_get_kernel_syms	/* 130 */
+	.long sys_quotactl
+	.long sys_getpgid
+	.long sys_fchdir
+	.long sys_bdflush
+	.long sys_sysfs		/* 135 */
+	.long sys_personality
+	.long sys_ni_syscall	/* reserved for afs_syscall */
+	.long sys_setfsuid16
+	.long sys_setfsgid16
+	.long sys_llseek	/* 140 */
+	.long sys_getdents
+	.long sys_select
+	.long sys_flock
+	.long sys_msync
+	.long sys_readv		/* 145 */
+	.long sys_writev
+	.long sys_getsid
+	.long sys_fdatasync
+	.long sys_sysctl
+	.long sys_mlock		/* 150 */
+	.long sys_munlock
+	.long sys_mlockall
+	.long sys_munlockall
+	.long sys_sched_setparam
+	.long sys_sched_getparam   /* 155 */
+	.long sys_sched_setscheduler
+	.long sys_sched_getscheduler
+	.long sys_sched_yield
+	.long sys_sched_get_priority_max
+	.long sys_sched_get_priority_min  /* 160 */
+	.long sys_sched_rr_get_interval
+	.long sys_nanosleep
+	.long sys_mremap
+	.long sys_setresuid16
+	.long sys_getresuid16	/* 165 */
+	.long sys_vm86
+	.long sys_query_module
+	.long sys_poll
+	.long sys_nfsservctl
+	.long sys_setresgid16	/* 170 */
+	.long sys_getresgid16
+	.long sys_prctl
+	.long sys_rt_sigreturn
+	.long sys_rt_sigaction
+	.long sys_rt_sigprocmask	/* 175 */
+	.long sys_rt_sigpending
+	.long sys_rt_sigtimedwait
+	.long sys_rt_sigqueueinfo
+	.long sys_rt_sigsuspend
+	.long sys_pread		/* 180 */
+	.long sys_pwrite
+	.long sys_chown16
+	.long sys_getcwd
+	.long sys_capget
+	.long sys_capset	/* 185 */
+	.long sys_sigaltstack
+	.long sys_sendfile
+	.long sys_ni_syscall	/* reserved for streams1 */
+	.long sys_ni_syscall	/* reserved for streams2 */
+	.long sys_vfork		/* 190 */
+	.long sys_getrlimit
+	.long sys_mmap2
+	.long sys_truncate64
+	.long sys_ftruncate64
+	.long sys_stat64	/* 195 */
+	.long sys_lstat64
+	.long sys_fstat64
+	.long sys_lchown
+	.long sys_getuid
+	.long sys_getgid	/* 200 */
+	.long sys_geteuid
+	.long sys_getegid
+	.long sys_setreuid
+	.long sys_setregid
+	.long sys_getgroups	/* 205 */
+	.long sys_setgroups
+	.long sys_fchown
+	.long sys_setresuid
+	.long sys_getresuid
+	.long sys_setresgid	/* 210 */
+	.long sys_getresgid
+	.long sys_chown
+	.long sys_setuid
+	.long sys_setgid
+	.long sys_setfsuid	/* 215 */
+	.long sys_setfsgid
+	.long sys_pivot_root
+	.long sys_mincore
+	.long sys_madvise
+	.long sys_getdents64	/* 220 */
+	.long sys_fcntl64
+	.long sys_ni_syscall	/* reserved for TUX */
+	.long sys_ni_syscall	/* reserved for Security */
+	.long sys_gettid
+	.long sys_readahead	/* 225 */
+	.long sys_setxattr
+	.long sys_lsetxattr
+	.long sys_fsetxattr
+	.long sys_getxattr
+	.long sys_lgetxattr	/* 230 */
+	.long sys_fgetxattr
+	.long sys_listxattr
+	.long sys_llistxattr
+	.long sys_flistxattr
+	.long sys_removexattr	/* 235 */
+	.long sys_lremovexattr
+	.long sys_fremovexattr
+	.long sys_tkill
+	.long sys_sendfile64
+	.long sys_futex		/* 240 */
+	.long sys_sched_setaffinity
+	.long sys_sched_getaffinity
 
 	.rept NR_syscalls-(.-sys_call_table)/4
-		.long SYMBOL_NAME(sys_ni_syscall)
+		.long sys_ni_syscall
 	.endr
diff -urN linux-2.5.8/arch/i386/kernel/head.S linux/arch/i386/kernel/head.S
--- linux-2.5.8/arch/i386/kernel/head.S	Wed Apr 10 19:59:37 2002
+++ linux/arch/i386/kernel/head.S	Tue Apr 16 18:47:34 2002
@@ -26,7 +26,7 @@
  * References to members of the boot_cpu_data structure.
  */
 
-#define CPU_PARAMS	SYMBOL_NAME(boot_cpu_data)
+#define CPU_PARAMS	boot_cpu_data
 #define X86		CPU_PARAMS+0
 #define X86_VENDOR	CPU_PARAMS+1
 #define X86_MODEL	CPU_PARAMS+2
@@ -120,8 +120,8 @@
  * No need to cld as DF is already clear from cld above...
  */
 	xorl %eax,%eax
-	movl $ SYMBOL_NAME(__bss_start),%edi
-	movl $ SYMBOL_NAME(_end),%ecx
+	movl $__bss_start,%edi
+	movl $_end,%ecx
 	subl %edi,%ecx
 	rep
 	stosb
@@ -145,7 +145,7 @@
  *
  * Note: %esi still has the pointer to the real-mode data.
  */
-	movl $ SYMBOL_NAME(empty_zero_page),%edi
+	movl $empty_zero_page,%edi
 	movl $512,%ecx
 	cld
 	rep
@@ -154,7 +154,7 @@
 	movl $512,%ecx
 	rep
 	stosl
-	movl SYMBOL_NAME(empty_zero_page)+NEW_CL_POINTER,%esi
+	movl empty_zero_page+NEW_CL_POINTER,%esi
 	andl %esi,%esi
 	jnz 2f			# New command line protocol
 	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR
@@ -162,7 +162,7 @@
 	movzwl OLD_CL_OFFSET,%esi
 	addl $(OLD_CL_BASE_ADDR),%esi
 2:
-	movl $ SYMBOL_NAME(empty_zero_page)+2048,%edi
+	movl $empty_zero_page+2048,%edi
 	movl $512,%ecx
 	rep
 	movsl
@@ -263,11 +263,11 @@
 	cmpb $1,%cl
 	je 1f			# the first CPU calls start_kernel
 				# all other CPUs call initialize_secondary
-	call SYMBOL_NAME(initialize_secondary)
+	call initialize_secondary
 	jmp L6
 1:
 #endif
-	call SYMBOL_NAME(start_kernel)
+	call start_kernel
 L6:
 	jmp L6			# main should never return here, but
 				# just in case, we know what happens.
@@ -309,7 +309,7 @@
 	movw %dx,%ax		/* selector = 0x0010 = cs */
 	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
 
-	lea SYMBOL_NAME(idt_table),%edi
+	lea idt_table,%edi
 	mov $256,%ecx
 rp_sidt:
 	movl %eax,(%edi)
@@ -320,7 +320,7 @@
 	ret
 
 ENTRY(stack_start)
-	.long SYMBOL_NAME(init_thread_union)+8192
+	.long init_thread_union+8192
 	.long __KERNEL_DS
 
 /* This is the default interrupt "handler" :-) */
@@ -338,7 +338,7 @@
 	movl %eax,%ds
 	movl %eax,%es
 	pushl $int_msg
-	call SYMBOL_NAME(printk)
+	call printk
 	popl %eax
 	popl %ds
 	popl %es
@@ -356,21 +356,21 @@
 #define GDT_ENTRIES	(__TSS(NR_CPUS))
 
 
-.globl SYMBOL_NAME(idt)
-.globl SYMBOL_NAME(gdt)
+.globl idt
+.globl gdt
 
 	ALIGN
 	.word 0
 idt_descr:
 	.word IDT_ENTRIES*8-1		# idt contains 256 entries
-SYMBOL_NAME(idt):
-	.long SYMBOL_NAME(idt_table)
+idt:
+	.long idt_table
 
 	.word 0
 gdt_descr:
 	.word GDT_ENTRIES*8-1
-SYMBOL_NAME(gdt):
-	.long SYMBOL_NAME(gdt_table)
+gdt:
+	.long gdt_table
 
 /*
  * This is initialized to create an identity-mapping at 0-8M (for bootup
diff -urN linux-2.5.8/arch/i386/kernel/trampoline.S linux/arch/i386/kernel/trampoline.S
--- linux-2.5.8/arch/i386/kernel/trampoline.S	Thu Mar  7 21:18:26 2002
+++ linux/arch/i386/kernel/trampoline.S	Tue Apr 16 18:47:34 2002
@@ -67,5 +67,5 @@
 	.word	0x0800			# gdt limit = 2048, 256 GDT entries
 	.long	gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
 
-.globl SYMBOL_NAME(trampoline_end)
-SYMBOL_NAME_LABEL(trampoline_end)
+.globl trampoline_end
+trampoline_end:
diff -urN linux-2.5.8/arch/i386/math-emu/fpu_asm.h linux/arch/i386/math-emu/fpu_asm.h
--- linux-2.5.8/arch/i386/math-emu/fpu_asm.h	Thu Mar  7 21:18:14 2002
+++ linux/arch/i386/math-emu/fpu_asm.h	Tue Apr 16 18:47:34 2002
@@ -12,7 +12,7 @@
 
 #include <linux/linkage.h>
 
-#define	EXCEPTION	SYMBOL_NAME(FPU_exception)
+#define	EXCEPTION	FPU_exception
 
 
 #define PARAM1	8(%ebp)
diff -urN linux-2.5.8/arch/i386/math-emu/reg_norm.S linux/arch/i386/math-emu/reg_norm.S
--- linux-2.5.8/arch/i386/math-emu/reg_norm.S	Thu Mar  7 21:18:27 2002
+++ linux/arch/i386/math-emu/reg_norm.S	Tue Apr 16 18:47:34 2002
@@ -83,7 +83,7 @@
 	/* Convert the exponent to 80x87 form. */
 	addw	EXTENDED_Ebias,EXP(%ebx)
 	push	%ebx
-	call	SYMBOL_NAME(arith_underflow)
+	call	arith_underflow
 	pop	%ebx
 	jmp	L_exit
 
@@ -91,7 +91,7 @@
 	/* Convert the exponent to 80x87 form. */
 	addw	EXTENDED_Ebias,EXP(%ebx)
 	push	%ebx
-	call	SYMBOL_NAME(arith_overflow)
+	call	arith_overflow
 	pop	%ebx
 	jmp	L_exit
 
diff -urN linux-2.5.8/arch/i386/math-emu/reg_round.S linux/arch/i386/math-emu/reg_round.S
--- linux-2.5.8/arch/i386/math-emu/reg_round.S	Thu Mar  7 21:18:56 2002
+++ linux/arch/i386/math-emu/reg_round.S	Tue Apr 16 18:47:34 2002
@@ -447,7 +447,7 @@
 L_precision_lost_up:
 	push	%edx
 	push	%eax
-	call	SYMBOL_NAME(set_precision_flag_up)
+	call	set_precision_flag_up
 	popl	%eax
 	popl	%edx
 	jmp	L_no_precision_loss
@@ -459,7 +459,7 @@
 L_precision_lost_down:
 	push	%edx
 	push	%eax
-	call	SYMBOL_NAME(set_precision_flag_down)
+	call	set_precision_flag_down
 	popl	%eax
 	popl	%edx
 	jmp	L_no_precision_loss
@@ -617,7 +617,7 @@
  */
 L_underflow_to_zero:
 	push	%eax
-	call	SYMBOL_NAME(set_precision_flag_down)
+	call	set_precision_flag_down
 	popl	%eax
 
 	push	%eax
@@ -636,7 +636,7 @@
 L_overflow:
 	addw	EXTENDED_Ebias,EXP(%edi)	/* Set for unmasked response. */
 	push	%edi
-	call	SYMBOL_NAME(arith_overflow)
+	call	arith_overflow
 	pop	%edi
 	jmp	fpu_reg_round_signed_special_exit
 

--------------010300060102040505040206--

