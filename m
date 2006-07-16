Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWGPMWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWGPMWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 08:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWGPMWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 08:22:39 -0400
Received: from ns1.suse.de ([195.135.220.2]:17134 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751235AbWGPMWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 08:22:39 -0400
Date: Sun, 16 Jul 2006 14:22:37 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: akpm@osdl.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.18-rc2] [2/8] i386/x86-64: Don't randomize stack
 top when no randomization personality is set
Message-ID: <44ba2f8d.0hsur33TTkK+bbJl%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Based on patch from Frank van Maarseveen <frankvm@frankvm.com>, but
extended.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/process.c   |    3 ++-
 arch/x86_64/kernel/process.c |    2 +-
 fs/binfmt_elf.c              |    3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -845,7 +845,7 @@ int dump_task_regs(struct task_struct *t
 
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (randomize_va_space)
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }
Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -37,6 +37,7 @@
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
 #include <linux/random.h>
+#include <linux/personality.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -905,7 +906,7 @@ asmlinkage int sys_get_thread_area(struc
 
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (randomize_va_space)
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }
Index: linux/fs/binfmt_elf.c
===================================================================
--- linux.orig/fs/binfmt_elf.c
+++ linux/fs/binfmt_elf.c
@@ -515,7 +515,8 @@ static unsigned long randomize_stack_top
 {
 	unsigned int random_variable = 0;
 
-	if (current->flags & PF_RANDOMIZE) {
+	if ((current->flags & PF_RANDOMIZE) &&
+		!(current->personality & ADDR_NO_RANDOMIZE)) {
 		random_variable = get_random_int() & STACK_RND_MASK;
 		random_variable <<= PAGE_SHIFT;
 	}
