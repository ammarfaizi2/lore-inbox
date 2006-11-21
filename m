Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934391AbWKUQGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934391AbWKUQGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934392AbWKUQGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:06:33 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:31963 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S934391AbWKUQGc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:06:32 -0500
Date: Tue, 21 Nov 2006 11:06:30 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, ltt-dev@shafik.org,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>, mgreer@mvista.com,
       mlachwani@mvista.com
Subject: LTTng do_page_fault vs handle_mm_fault instrumentation
Message-ID: <20061121160629.GA6944@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:58:44 up 90 days, 13:06,  3 users,  load average: 0.40, 0.38, 0.53
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I would like to discuss your suggestion of moving the do_page_fault
instrumentation to handle_mm_fault. On one side, it helps removing architecture
dependant instrumentation, but on the other hand :

1- We cannot access the struct pt_regs in all cases (there may be an invalid
   current task struct).
2- We cannot distinguish between calls to handle_mm_fault from the page fault
   handler or from get_user_pages.
3- Some people complain about not having enough information about the cause of
   the page fault (see the forward below).

So instead of staying between my users who ask for those feature and kernel
developers who wish to reduce the intrusiveness of instrumentation (which is a
nice goal : moving the syscall entry/exit instrumentation do do_syscall_trace
has helped simplifying the instrumentation), I prefer to open the discussion
about it.

Ideas/comments are welcome.

Regards,

Mathieu


----- Forwarded message from Sergei Shtylyov <sshtylyov@ru.mvista.com> -----

Date: Tue, 21 Nov 2006 18:55:27 +0300
To: compudj@krystal.dyndns.org, ltt-dev@shafik.org
Cc: mgreer@mvista.com, mlachwani@mvista.com
Organization: MontaVista Software Inc.
User-Agent: KMail/1.5
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] PowerPC: rearrange/add trap markers in do_page_fault()

Rearrange existing trap markers in PowerPC do_page_fault() to avoid duplicate
trap reporting in a certain case, and add the markers to some code paths that
were missed...
 
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
MIPS needs something along these lines as well.  Removing the trap tracepoints
from do_page_fault() was a bad move in the first place...

 arch/powerpc/mm/fault.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6-lttng/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6-lttng.orig/arch/powerpc/mm/fault.c
+++ linux-2.6-lttng/arch/powerpc/mm/fault.c
@@ -199,12 +199,15 @@ int __kprobes do_page_fault(struct pt_re
 	if (in_atomic() || mm == NULL) {
 		if (!user_mode(regs))
 			return SIGSEGV;
+		MARK(kernel_trap_entry, "%ld struct pt_regs %p",
+		     regs->trap, regs);
 		/* in_atomic() in user mode is really bad,
 		   as is current->mm == NULL. */
 		printk(KERN_EMERG "Page fault in user mode with"
 		       "in_atomic() = %d mm = %p\n", in_atomic(), mm);
 		printk(KERN_EMERG "NIP = %lx  MSR = %lx\n",
 		       regs->nip, regs->msr);
+		MARK(kernel_trap_exit, MARK_NOARGS);
 		die("Weird page fault", regs, SIGSEGV);
 	}
 
@@ -311,6 +314,8 @@ good_area:
 			if (pte_present(*ptep)) {
 				struct page *page = pte_page(*ptep);
 
+				MARK(kernel_trap_entry, "%ld struct pt_regs %p",
+				     regs->trap, regs);
 				if (!test_bit(PG_arch_1, &page->flags)) {
 					flush_dcache_icache_page(page);
 					set_bit(PG_arch_1, &page->flags);
@@ -319,6 +324,7 @@ good_area:
 				_tlbie(address);
 				pte_unmap_unlock(ptep, ptl);
 				up_read(&mm->mmap_sem);
+				MARK(kernel_trap_exit, MARK_NOARGS);
 				return 0;
 			}
 			pte_unmap_unlock(ptep, ptl);
@@ -342,30 +348,26 @@ good_area:
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
+	MARK(kernel_trap_entry, "%ld struct pt_regs %p", regs->trap, regs);
  survive:
- 	MARK(kernel_trap_entry, "%ld struct pt_regs %p",
-		regs->trap, regs);
 	switch (handle_mm_fault(mm, vma, address, is_write)) {
 
 	case VM_FAULT_MINOR:
-		MARK(kernel_trap_exit, MARK_NOARGS);
 		current->min_flt++;
 		break;
 	case VM_FAULT_MAJOR:
-		MARK(kernel_trap_exit, MARK_NOARGS);
 		current->maj_flt++;
 		break;
 	case VM_FAULT_SIGBUS:
-		MARK(kernel_trap_exit, MARK_NOARGS);
 		goto do_sigbus;
 	case VM_FAULT_OOM:
-		MARK(kernel_trap_exit, MARK_NOARGS);
 		goto out_of_memory;
 	default:
 		BUG();
 	}
 
 	up_read(&mm->mmap_sem);
+	MARK(kernel_trap_exit, MARK_NOARGS);
 	return 0;
 
 bad_area:
@@ -398,6 +400,7 @@ out_of_memory:
 		goto survive;
 	}
 	printk("VM: killing process %s\n", current->comm);
+	MARK(kernel_trap_exit, MARK_NOARGS);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
 	return SIGKILL;
@@ -410,8 +413,10 @@ do_sigbus:
 		info.si_code = BUS_ADRERR;
 		info.si_addr = (void __user *)address;
 		force_sig_info(SIGBUS, &info, current);
+		MARK(kernel_trap_exit, MARK_NOARGS);
 		return 0;
 	}
+	MARK(kernel_trap_exit, MARK_NOARGS);
 	return SIGBUS;
 }
 


----- End forwarded message -----
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
