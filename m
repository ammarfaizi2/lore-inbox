Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVEFWzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVEFWzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVEFWz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:55:27 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:43526 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261316AbVEFWyU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:54:20 -0400
Message-Id: <200505062249.j46MncJb010495@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 12/12] UML - x86_64 fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 May 2005 18:49:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some x86_64 bugs -
    maybe_map returns -1 on error instead of 0, which is interpretted as
physical address 0
    removed an include of ipc.h, which isn't needed
    fixed the calculation of signal frame location
    the signal delivery code is now immune to the stack expansion check
    added a missing include

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm/arch/um/kernel/skas/uaccess.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/skas/uaccess.c	2005-05-05 12:19:04.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/skas/uaccess.c	2005-05-05 12:43:02.000000000 -0400
@@ -29,9 +29,12 @@
 	if(IS_ERR(phys) || (is_write && !pte_write(pte))){
 		err = handle_page_fault(virt, 0, is_write, 1, &dummy_code);
 		if(err)
-			return(0);
+			return(-1UL);
 		phys = um_virt_to_phys(current, virt, NULL);
 	}
+        if(IS_ERR(phys))
+                phys = (void *) -1;
+
 	return((unsigned long) phys);
 }
 
@@ -42,7 +45,7 @@
 	int n;
 
 	addr = maybe_map(addr, is_write);
-	if(addr == -1)
+	if(addr == -1UL)
 		return(-1);
 
 	page = phys_to_page(addr);
Index: linux-2.6.12-rc3-mm/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/syscall_kern.c	2005-05-02 14:47:52.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/syscall_kern.c	2005-05-05 12:43:02.000000000 -0400
@@ -17,7 +17,6 @@
 #include "linux/utime.h"
 #include "asm/mman.h"
 #include "asm/uaccess.h"
-#include "asm/ipc.h"
 #include "kern_util.h"
 #include "user_util.h"
 #include "sysdep/syscalls.h"
Index: linux-2.6.12-rc3-mm/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/trap_kern.c	2005-05-05 12:19:04.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/trap_kern.c	2005-05-05 12:43:02.000000000 -0400
@@ -48,7 +48,7 @@
 		goto good_area;
 	else if(!(vma->vm_flags & VM_GROWSDOWN)) 
 		goto out;
-	else if(!ARCH_IS_STACKGROW(address))
+	else if(is_user && !ARCH_IS_STACKGROW(address))
 		goto out;
 	else if(expand_stack(vma, address)) 
 		goto out;
Index: linux-2.6.12-rc3-mm/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/sys-x86_64/signal.c	2005-05-05 12:19:04.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/sys-x86_64/signal.c	2005-05-05 12:43:02.000000000 -0400
@@ -168,7 +168,7 @@
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-	frame -= 128;
+	((unsigned char *) frame) -= 128;
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;
Index: linux-2.6.12-rc3-mm/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/sys-x86_64/syscalls.c	2005-05-05 12:19:04.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/sys-x86_64/syscalls.c	2005-05-05 12:43:02.000000000 -0400
@@ -44,6 +44,8 @@
 #ifdef CONFIG_MODE_SKAS
 extern int userspace_pid[];
 
+#include "skas_ptrace.h"
+
 long sys_modify_ldt_skas(int func, void *ptr, unsigned long bytecount)
 {
 	struct ptrace_ldt ldt;

