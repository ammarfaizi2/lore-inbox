Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265394AbVBDUET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbVBDUET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266653AbVBDUDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:03:12 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:23556 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S266791AbVBDUAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:00:39 -0500
Subject: [patch 4/8] uml: disallow stack access below $esp like i386 / x86_64 [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       bstroesser@fujitsu-siemens.com
From: blaisorblade@yahoo.it
Date: Fri, 04 Feb 2005 19:35:48 +0100
Message-Id: <20050204183548.B9723310BD@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

When a page fault occurs on an address below the stack-vma,
UML tries to expand the stack.
On i386 and x86_64, the failing address is compared to the
current userspace stack pointer. If the failing address is
below "esp-32" resp. "rsp-128", stack expansion is not
allowed, and a SIGSEGV is given to the user.
This patch makes UML behave like i386/x86_64.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/trap_kern.c        |    2 ++
 linux-2.6.11-paolo/include/asm-um/processor-i386.h   |    3 +++
 linux-2.6.11-paolo/include/asm-um/processor-x86_64.h |    3 +++
 3 files changed, 8 insertions(+)

diff -puN arch/um/kernel/trap_kern.c~uml-stack-expansion arch/um/kernel/trap_kern.c
--- linux-2.6.11/arch/um/kernel/trap_kern.c~uml-stack-expansion	2005-02-04 06:18:18.689557088 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/trap_kern.c	2005-02-04 06:18:18.739549488 +0100
@@ -48,6 +48,8 @@ int handle_page_fault(unsigned long addr
 		goto good_area;
 	else if(!(vma->vm_flags & VM_GROWSDOWN)) 
 		goto out;
+	else if(!ARCH_IS_STACKGROW(address))
+		goto out;
 	else if(expand_stack(vma, address)) 
 		goto out;
 
diff -puN include/asm-um/processor-i386.h~uml-stack-expansion include/asm-um/processor-i386.h
--- linux-2.6.11/include/asm-um/processor-i386.h~uml-stack-expansion	2005-02-04 06:18:18.726551464 +0100
+++ linux-2.6.11-paolo/include/asm-um/processor-i386.h	2005-02-04 06:18:18.739549488 +0100
@@ -27,6 +27,9 @@ struct arch_thread {
 #define current_text_addr() \
 	({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
 
+#define ARCH_IS_STACKGROW(address) \
+       (address + 32 >= UPT_SP(&current->thread.regs.regs))
+
 #include "asm/processor-generic.h"
 
 #endif
diff -puN include/asm-um/processor-x86_64.h~uml-stack-expansion include/asm-um/processor-x86_64.h
--- linux-2.6.11/include/asm-um/processor-x86_64.h~uml-stack-expansion	2005-02-04 06:18:18.736549944 +0100
+++ linux-2.6.11-paolo/include/asm-um/processor-x86_64.h	2005-02-04 06:18:18.740549336 +0100
@@ -17,6 +17,9 @@ struct arch_thread {
 #define current_text_addr() \
 	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
 
+#define ARCH_IS_STACKGROW(address) \
+        (address + 128 >= UPT_SP(&current->thread.regs.regs))
+
 #include "asm/processor-generic.h"
 
 #endif
_
