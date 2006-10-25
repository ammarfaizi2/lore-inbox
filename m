Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423213AbWJYKkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423213AbWJYKkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423229AbWJYKkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:40:40 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:18668 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423213AbWJYKkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:40:40 -0400
Message-ID: <453F421A.6070507@in.ibm.com>
Date: Wed, 25 Oct 2006 16:23:14 +0530
From: supriya kannery <supriyak@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Incorrect order of last two arguments of ptrace for requests PPC_PTRACE_GETREGS,
 SETREGS, GETFPREGS, SETFPREGS
Content-Type: multipart/mixed;
 boundary="------------060104090109080407000501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060104090109080407000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In ptrace, when request is PPC_PTRACE_GETREGS, SETREGS, GETFPREGS and 
SETFPREGS, order of the last two arguments is not correct.

General format of ptrace is ptrace (request, pid, addr, data).  For the 
above mentioned request ids in ppc64, if we use ptrace like

 long reg[32];
 ptrace (PPC_PTRACE_GETREGS, pid, 0, &reg[0]);

the return value is always -1.

If we exchange the last two arguments like,

 ptrace (PPC_PTRACE_GETREGS, pid, &reg[0], 0);

it works!

This is because PPC_PTRACE_GETREGS option for powerpc is implemented 
such that general purpose
registers of the child process get copied to the address variable 
instead of data variable. Same is
the case with other PPC request options PPC_PTRACE_SETREGS, GETFPREGS 
and SETFPREGS.

Prepared a patch for this problem and tested with 2.6.18-rc6 kernel. 
This patch can be applied directly to
2.6.19-rc3 kernel.

--------------060104090109080407000501
Content-Type: text/plain;
 name="ppc_ptrace_params.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc_ptrace_params.patch"

diff -Naurp linux-2.6.18-rc6/arch/powerpc/kernel/ptrace.c linux-2.6.18-rc6-mod/arch/powerpc/kernel/ptrace.c
--- linux-2.6.18-rc6/arch/powerpc/kernel/ptrace.c	2006-10-19 18:09:01.000000000 +0530
+++ linux-2.6.18-rc6-mod/arch/powerpc/kernel/ptrace.c	2006-10-19 18:11:37.000000000 +0530
@@ -406,7 +406,7 @@ long arch_ptrace(struct task_struct *chi
 	case PPC_PTRACE_GETREGS: { /* Get GPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
+		unsigned long __user *tmp = (unsigned long __user *)data;
 
 		for (i = 0; i < 32; i++) {
 			ret = put_user(*reg, tmp);
@@ -421,7 +421,7 @@ long arch_ptrace(struct task_struct *chi
 	case PPC_PTRACE_SETREGS: { /* Set GPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
+		unsigned long __user *tmp = (unsigned long __user *)data;
 
 		for (i = 0; i < 32; i++) {
 			ret = get_user(*reg, tmp);
@@ -436,7 +436,7 @@ long arch_ptrace(struct task_struct *chi
 	case PPC_PTRACE_GETFPREGS: { /* Get FPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
+		unsigned long __user *tmp = (unsigned long __user *)data;
 
 		flush_fp_to_thread(child);
 
@@ -453,7 +453,7 @@ long arch_ptrace(struct task_struct *chi
 	case PPC_PTRACE_SETFPREGS: { /* Get FPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
+		unsigned long __user *tmp = (unsigned long __user *)data;
 
 		flush_fp_to_thread(child);
 
diff -Naurp linux-2.6.18-rc6/arch/powerpc/kernel/ptrace32.c linux-2.6.18-rc6-mod/arch/powerpc/kernel/ptrace32.c
--- linux-2.6.18-rc6/arch/powerpc/kernel/ptrace32.c	2006-10-19 18:09:01.000000000 +0530
+++ linux-2.6.18-rc6-mod/arch/powerpc/kernel/ptrace32.c	2006-10-19 18:11:41.000000000 +0530
@@ -345,7 +345,7 @@ long compat_sys_ptrace(int request, int 
 	case PPC_PTRACE_GETREGS: { /* Get GPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
+		unsigned int __user *tmp = (unsigned int __user *)data;
 
 		for (i = 0; i < 32; i++) {
 			ret = put_user(*reg, tmp);
@@ -360,7 +360,7 @@ long compat_sys_ptrace(int request, int 
 	case PPC_PTRACE_SETREGS: { /* Set GPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
+		unsigned int __user *tmp = (unsigned int __user *)data;
 
 		for (i = 0; i < 32; i++) {
 			ret = get_user(*reg, tmp);
@@ -375,7 +375,7 @@ long compat_sys_ptrace(int request, int 
 	case PPC_PTRACE_GETFPREGS: { /* Get FPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
+		unsigned int __user *tmp = (unsigned int __user *)data;
 
 		flush_fp_to_thread(child);
 
@@ -392,7 +392,7 @@ long compat_sys_ptrace(int request, int 
 	case PPC_PTRACE_SETFPREGS: { /* Get FPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
+		unsigned int __user *tmp = (unsigned int __user *)data;
 
 		flush_fp_to_thread(child);
 

--------------060104090109080407000501--
