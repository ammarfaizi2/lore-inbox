Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbTAITsu>; Thu, 9 Jan 2003 14:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267733AbTAITsu>; Thu, 9 Jan 2003 14:48:50 -0500
Received: from ppp-217-133-219-176.dialup.tiscali.it ([217.133.219.176]:59520
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S267732AbTAITsp>; Thu, 9 Jan 2003 14:48:45 -0500
Date: Thu, 9 Jan 2003 20:49:35 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use %ebp rather than %ebx for thread_info pointer
Message-ID: <20030109194935.GA2098@ldb>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch changes assembly code that accesses thread_info to use %ebp
rather than %ebx.=20

This allows me to take advantage of the fact that %ebp is restored by
user mode in the sysenter register pop removal patch.


diff --exclude-from=3D/home/ldb/src/exclude -urNdp linux-2.5.54-preldb/arch=
/i386/kernel/entry.S linux-2.5.54-ldb/arch/i386/kernel/entry.S
--- linux-2.5.54-preldb/arch/i386/kernel/entry.S	2003-01-06 16:01:40.000000=
000 +0100
+++ linux-2.5.54-ldb/arch/i386/kernel/entry.S	2003-01-06 04:54:58.000000000=
 +0100
@@ -145,16 +145,16 @@ ENTRY(lcall7)
 				# gates, which has to be cleaned up later..
 	pushl %eax
 	SAVE_ALL
-	movl %esp, %ebx
-	pushl %ebx
+	movl %esp, %ebp
+	pushl %ebp
 	pushl $0x7
 do_lcall:
-	movl EIP(%ebx), %eax	# due to call gates, this is eflags, not eip..
-	movl CS(%ebx), %edx	# this is eip..
-	movl EFLAGS(%ebx), %ecx	# and this is cs..
-	movl %eax,EFLAGS(%ebx)	#
-	movl %edx,EIP(%ebx)	# Now we move them to their "normal" places
-	movl %ecx,CS(%ebx)	#
+	movl EIP(%ebp), %eax	# due to call gates, this is eflags, not eip..
+	movl CS(%ebp), %edx	# this is eip..
+	movl EFLAGS(%ebp), %ecx	# and this is cs..
+	movl %eax,EFLAGS(%ebp)	#
+	movl %edx,EIP(%ebp)	# Now we move them to their "normal" places
+	movl %ecx,CS(%ebp)	#
=20
 	#
 	# Call gates don't clear TF and NT in eflags like
@@ -166,8 +166,8 @@ do_lcall:
 	pushl %eax
 	popfl
=20
-	andl $-8192, %ebx	# GET_THREAD_INFO
-	movl TI_EXEC_DOMAIN(%ebx), %edx	# Get the execution domain
+	andl $-8192, %ebp	# GET_THREAD_INFO
+	movl TI_EXEC_DOMAIN(%ebp), %edx	# Get the execution domain
 	call *4(%edx)		# Call the lcall7 handler for the domain
 	addl $4, %esp
 	popl %eax
@@ -178,8 +178,8 @@ ENTRY(lcall27)
 				# gates, which has to be cleaned up later..
 	pushl %eax
 	SAVE_ALL
-	movl %esp, %ebx
-	pushl %ebx
+	movl %esp, %ebp
+	pushl %ebp
 	pushl $0x27
 	jmp do_lcall
=20
@@ -187,7 +187,7 @@ ENTRY(lcall27)
 ENTRY(ret_from_fork)
 	# NOTE: this function takes a parameter but it's unused on x86.
 	call schedule_tail
-	GET_THREAD_INFO(%ebx)
+	GET_THREAD_INFO(%ebp)
 	jmp syscall_exit
=20
 /*
@@ -202,7 +202,7 @@ ENTRY(ret_from_fork)
 ret_from_exception:
 	preempt_stop
 ret_from_intr:
-	GET_THREAD_INFO(%ebx)
+	GET_THREAD_INFO(%ebp)
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
 	testl $(VM_MASK | 3), %eax
@@ -211,7 +211,7 @@ ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
-	movl TI_FLAGS(%ebx), %ecx
+	movl TI_FLAGS(%ebp), %ecx
 	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done on
 					# int/exception return?
 	jne work_pending
@@ -219,18 +219,18 @@ ENTRY(resume_userspace)
=20
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	cmpl $0,TI_PRE_COUNT(%ebx)	# non-zero preempt_count ?
+	cmpl $0,TI_PRE_COUNT(%ebp)	# non-zero preempt_count ?
 	jnz restore_all
 need_resched:
-	movl TI_FLAGS(%ebx), %ecx	# need_resched set ?
+	movl TI_FLAGS(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
 	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (execption path) ?
 	jz restore_all
-	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebx)
+	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebp)
 	sti
 	call schedule
-	movl $0,TI_PRE_COUNT(%ebx)=20
+	movl $0,TI_PRE_COUNT(%ebp)
 	cli
 	jmp need_resched
 #endif
@@ -262,21 +262,21 @@ ENTRY(sysenter_entry)
=20
 	pushl %eax
 	SAVE_ALL
-	GET_THREAD_INFO(%ebx)
+	GET_THREAD_INFO(%ebp)
 	cmpl $(NR_syscalls), %eax
 	jae syscall_badsys
=20
-	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebx)
+	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebp)
 	jnz syscall_trace_entry
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
 	cli
-	movl TI_FLAGS(%ebx), %ecx
+	movl TI_FLAGS(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
	RESTORE_INT_REGS
@@ -286,11 +286,11 @@ ENTRY(sysenter_entry)
 ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL
-	GET_THREAD_INFO(%ebx)
+	GET_THREAD_INFO(%ebp)
 	cmpl $(NR_syscalls), %eax
 	jae syscall_badsys
 					# system call tracing in operation
-	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebx)
+	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebp)
 	jnz syscall_trace_entry
 syscall_call:
 	call *sys_call_table(,%eax,4)
@@ -299,7 +299,7 @@ syscall_exit:
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
-	movl TI_FLAGS(%ebx), %ecx
+	movl TI_FLAGS(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx	# current->work
 	jne syscall_exit_work
 restore_all:
@@ -315,7 +315,7 @@ work_resched:
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
-	movl TI_FLAGS(%ebx), %ecx
+	movl TI_FLAGS(%ebp), %ecx
 	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done other
 					# than syscall tracing?
 	jz restore_all
@@ -370,7 +370,7 @@ syscall_exit_work:
 syscall_fault:
 	pushl %eax			# save orig_eax
 	SAVE_ALL
-	GET_THREAD_INFO(%ebx)
+	GET_THREAD_INFO(%ebp)
 	movl $-EFAULT,EAX(%esp)
 	jmp resume_userspace
=20

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+HdJOdjkty3ft5+cRAv8vAJsEEOsXZ15lRTZMq7KFuQKfhdqK8QCgvWBH
dO+nnwIX3WkF36VZbG6O7+s=
=OE06
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
