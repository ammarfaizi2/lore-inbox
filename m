Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVEZWgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVEZWgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVEZWf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:35:59 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:23313 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261836AbVEZWfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:35:41 -0400
Message-Id: <200505262230.j4QMUO9E014677@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/7] UML - Fix a couple of warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 May 2005 18:30:24 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate an unused variable warning in ptrace.c and a size mismatch warning
by adding a cast to __pa.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/ptrace.c	2005-05-08 11:43:01.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/ptrace.c	2005-05-11 10:44:30.000000000 -0400
@@ -322,11 +322,9 @@ void syscall_trace(union uml_pt_regs *re
 					    UPT_SYSCALL_ARG2(regs),
 					    UPT_SYSCALL_ARG3(regs),
 					    UPT_SYSCALL_ARG4(regs));
-		else {
-                        int res = UPT_SYSCALL_RET(regs);
-			audit_syscall_exit(current, AUDITSC_RESULT(res),
-                                           res);
-                }
+		else audit_syscall_exit(current, 
+                                        AUDITSC_RESULT(UPT_SYSCALL_RET(regs)),
+                                        UPT_SYSCALL_RET(regs));
 	}
 
 	/* Fake a debug trap */
@@ -356,14 +354,3 @@ void syscall_trace(union uml_pt_regs *re
 		current->exit_code = 0;
 	}
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.12-rc/include/asm-um/page.h
===================================================================
--- linux-2.6.12-rc.orig/include/asm-um/page.h	2005-05-11 10:18:52.000000000 -0400
+++ linux-2.6.12-rc/include/asm-um/page.h	2005-05-11 10:37:30.000000000 -0400
@@ -98,7 +98,13 @@ extern unsigned long uml_physmem;
 
 extern unsigned long to_phys(void *virt);
 extern void *to_virt(unsigned long phys);
-#define __pa(virt) to_phys((void *) virt)
+
+/* Cast to unsigned long before casting to void * to avoid a warning from
+ * mmap_kmem about cutting a long long down to a void *.  Not sure that 
+ * casting is the right thing, but 32-bit UML can't have 64-bit virtual 
+ * addresses 
+ */
+#define __pa(virt) to_phys((void *) (unsigned long) virt)
 #define __va(phys) to_virt((unsigned long) phys)
 
 #define page_to_pfn(page) ((page) - mem_map)

