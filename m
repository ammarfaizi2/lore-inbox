Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318771AbSHBJst>; Fri, 2 Aug 2002 05:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318772AbSHBJst>; Fri, 2 Aug 2002 05:48:49 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:51205 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S318771AbSHBJsr>; Fri, 2 Aug 2002 05:48:47 -0400
Subject: Re: SA_SIGINFO in Linux 2.4.x
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: Camm Maguire <camm@enhanced.com>
Cc: debian-alpha <debian-alpha@lists.debian.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E17aOg0-0002ub-00@intech19.enhanced.com>
References: <E17aOg0-0002ub-00@intech19.enhanced.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 02 Aug 2002 15:22:16 +0530
Message-Id: <1028281936.17352.42.camel@satan.xko.dec.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 04:14, Camm Maguire wrote:
> Greetings!  The 2.4.x kernels on alpha don't appear to be filling in
> the si_addr element of the siginfo_t structure when a signal handler
> is setup with SA_SIGINFO.  Is this right?  Any other way to get this
> address in the handler?
> 
> Take care,
> 
> -- 
> Camm Maguire			     			camm@enhanced.com


Hi, 

 Try the following patch  for arch/alpha/mm/fault.c 

 -aneesh 

--- fault.c	Tue Aug  2 12:33:44 2050
+++ fault.c.n	Tue Aug  2 12:34:51 2050
@@ -88,6 +88,7 @@
 	struct mm_struct *mm = current->mm;
 	unsigned int fixup;
 	int fault;
+	siginfo_t info;
 
 	/* As of EV6, a load into $31/$f31 is a prefetch, and never faults
 	   (or is suppressed by the PALcode).  Support that for older CPUs
@@ -108,6 +109,8 @@
 	if (!mm || in_interrupt())
 		goto no_context;
 
+	info.si_code = SEGV_MAPERR;
+
 #ifdef CONFIG_ALPHA_LARGE_VMALLOC
 	if (address >= TASK_SIZE)
 		goto vmalloc_fault;
@@ -128,6 +131,7 @@
  * we can handle it..
  */
 good_area:
+	info.si_code = SEGV_ACCERR;
 	if (cause < 0) {
 		if (!(vma->vm_flags & VM_EXEC))
 			goto bad_area;
@@ -164,7 +168,12 @@
 	up_read(&mm->mmap_sem);
 
 	if (user_mode(regs)) {
-		force_sig(SIGSEGV, current);
+			
+		info.si_signo = SIGSEGV;
+		info.si_errno = 0;
+		/* info.si_code has been set above */
+		info.si_addr = (void *)address;
+		force_sig_info(SIGSEGV,&info,current);
 		return;
 	}
 
@@ -212,7 +221,12 @@
 	 * Send a sigbus, regardless of whether we were in kernel
 	 * or user mode.
 	 */
-	force_sig(SIGBUS, current);
+	info.si_signo = SIGBUS;
+	info.si_errno = 0;
+	/* not sure si_code value here  */
+	info.si_code =  BUS_ADRERR;
+	info.si_addr = (void *)address;
+	force_sig_info(SIGBUS,&info,current);
 	if (!user_mode(regs))
 		goto no_context;
 	return;
@@ -220,7 +234,11 @@
 #ifdef CONFIG_ALPHA_LARGE_VMALLOC
 vmalloc_fault:
 	if (user_mode(regs)) {
-		force_sig(SIGSEGV, current);
+		info.si_signo = SIGSEGV;
+		info.si_errno = 0;
+		/* info.si_code has been set above */
+		info.si_addr = (void *)address;
+		force_sig_info(SIGSEGV,&info,current);
 		return;
 	} else {
 		/* Synchronize this task's top level page-table

