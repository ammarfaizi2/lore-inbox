Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756360AbWKVSg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbWKVSg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756367AbWKVSg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:36:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51136 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1756360AbWKVSg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:36:27 -0500
Subject: Re: Incorrect order of last two arguments of ptrace for requests
	PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
From: David Woodhouse <dwmw2@infradead.org>
To: supriya kannery <supriyak@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <453F421A.6070507@in.ibm.com>
References: <453F421A.6070507@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-kaajnNrN3ClK/2QNwuM3"
Date: Wed, 22 Nov 2006 18:36:20 +0000
Message-Id: <1164220580.12365.8.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kaajnNrN3ClK/2QNwuM3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-10-25 at 16:23 +0530, supriya kannery wrote:
> In ptrace, when request is PPC_PTRACE_GETREGS, SETREGS, GETFPREGS and 
> SETFPREGS, order of the last two arguments is not correct.
> 
> General format of ptrace is ptrace (request, pid, addr, data).  For the 
> above mentioned request ids in ppc64, if we use ptrace like
> 
>  long reg[32];
>  ptrace (PPC_PTRACE_GETREGS, pid, 0, &reg[0]);
> 
> the return value is always -1.
> 
> If we exchange the last two arguments like,
> 
>  ptrace (PPC_PTRACE_GETREGS, pid, &reg[0], 0);
> 
> it works!
> 
> This is because PPC_PTRACE_GETREGS option for powerpc is implemented 
> such that general purpose
> registers of the child process get copied to the address variable 
> instead of data variable. Same is
> the case with other PPC request options PPC_PTRACE_SETREGS, GETFPREGS 
> and SETFPREGS.
> 
> Prepared a patch for this problem and tested with 2.6.18-rc6 kernel. 
> This patch can be applied directly to 2.6.19-rc3 kernel.

A more appropriate place to send this would be the linux-ppc development
list.

-- 
dwmw2

--=-kaajnNrN3ClK/2QNwuM3
Content-Disposition: attachment; filename=ppc_ptrace_params.patch
Content-Type: text/x-patch; name=ppc_ptrace_params.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
 

--=-kaajnNrN3ClK/2QNwuM3--

