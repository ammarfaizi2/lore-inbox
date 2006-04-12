Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWDLUgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWDLUgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWDLUgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 16:36:15 -0400
Received: from ns.suse.de ([195.135.220.2]:41196 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932135AbWDLUgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 16:36:15 -0400
Date: Wed, 12 Apr 2006 13:35:28 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.5
Message-ID: <20060412203528.GB10641@kroah.com>
References: <20060412203358.GA10641@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060412203358.GA10641@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 29efaa1..cb17131 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .4
+EXTRAVERSION = .5
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
index 7c10e90..ab6e44d 100644
--- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -180,6 +180,10 @@ rff_trace:
  *
  * XXX	if we had a free scratch register we could save the RSP into the stack frame
  *      and report it properly in ps. Unfortunately we haven't.
+ *
+ * When user can change the frames always force IRET. That is because
+ * it deals with uncanonical addresses better. SYSRET has trouble
+ * with them due to bugs in both AMD and Intel CPUs.
  */ 			 		
 
 ENTRY(system_call)
@@ -254,7 +258,10 @@ sysret_signal:
 	xorl %esi,%esi # oldset -> arg2
 	call ptregscall_common
 1:	movl $_TIF_NEED_RESCHED,%edi
-	jmp sysret_check
+	/* Use IRET because user could have changed frame. This
+	   works because ptregscall_common has called FIXUP_TOP_OF_STACK. */
+	cli
+	jmp int_with_check
 	
 badsys:
 	movq $-ENOSYS,RAX-ARGOFFSET(%rsp)
@@ -280,7 +287,8 @@ tracesys:			 
 	call syscall_trace_leave
 	RESTORE_TOP_OF_STACK %rbx
 	RESTORE_REST
-	jmp ret_from_sys_call
+	/* Use IRET because user could have changed frame */
+	jmp int_ret_from_sys_call
 	CFI_ENDPROC
 		
 /* 
@@ -408,25 +416,9 @@ ENTRY(stub_execve)
 	CFI_ADJUST_CFA_OFFSET -8
 	CFI_REGISTER rip, r11
 	SAVE_REST
-	movq %r11, %r15
-	CFI_REGISTER rip, r15
 	FIXUP_TOP_OF_STACK %r11
 	call sys_execve
-	GET_THREAD_INFO(%rcx)
-	bt $TIF_IA32,threadinfo_flags(%rcx)
-	CFI_REMEMBER_STATE
-	jc exec_32bit
 	RESTORE_TOP_OF_STACK %r11
-	movq %r15, %r11
-	CFI_REGISTER rip, r11
-	RESTORE_REST
-	pushq %r11
-	CFI_ADJUST_CFA_OFFSET 8
-	CFI_REL_OFFSET rip, 0
-	ret
-
-exec_32bit:
-	CFI_RESTORE_STATE
 	movq %rax,RAX(%rsp)
 	RESTORE_REST
 	jmp int_ret_from_sys_call
