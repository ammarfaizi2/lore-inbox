Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVFASWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVFASWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVFASM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:12:29 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:24029 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261505AbVFASCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:02:41 -0400
Date: Wed, 1 Jun 2005 20:02:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/11] s390: ptrace peek and poke.
Message-ID: <20050601180241.GC6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/11] s390: ptrace peek and poke.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The special cases of peek and poke on acrs[15] and the fpc register
are not handled correctly. A poke on acrs[15] will clobber the 4
bytes after the access registers in the thread_info structure. That
happens to be the kernel stack pointer. A poke on the fpc with an
invalid value is not caught by the validity check. On the next
context switch the broken fpc value will cause a program check in
the kernel. Improving the checks in peek and poke fixes this.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/ptrace.c |   48 +++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 43 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-patched/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	2005-06-01 19:42:54.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/ptrace.c	2005-06-01 19:43:15.000000000 +0200
@@ -40,6 +40,7 @@
 #include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 #ifdef CONFIG_S390_SUPPORT
 #include "compat_ptrace.h"
@@ -130,13 +131,19 @@ static int
 peek_user(struct task_struct *child, addr_t addr, addr_t data)
 {
 	struct user *dummy = NULL;
-	addr_t offset, tmp;
+	addr_t offset, tmp, mask;
 
 	/*
 	 * Stupid gdb peeks/pokes the access registers in 64 bit with
 	 * an alignment of 4. Programmers from hell...
 	 */
-	if ((addr & 3) || addr > sizeof(struct user) - __ADDR_MASK)
+	mask = __ADDR_MASK;
+#ifdef CONFIG_ARCH_S390X
+	if (addr >= (addr_t) &dummy->regs.acrs &&
+	    addr < (addr_t) &dummy->regs.orig_gpr2)
+		mask = 3;
+#endif
+	if ((addr & mask) || addr > sizeof(struct user) - __ADDR_MASK)
 		return -EIO;
 
 	if (addr < (addr_t) &dummy->regs.acrs) {
@@ -153,6 +160,16 @@ peek_user(struct task_struct *child, add
 		 * access registers are stored in the thread structure
 		 */
 		offset = addr - (addr_t) &dummy->regs.acrs;
+#ifdef CONFIG_ARCH_S390X
+		/*
+		 * Very special case: old & broken 64 bit gdb reading
+		 * from acrs[15]. Result is a 64 bit value. Read the
+		 * 32 bit acrs[15] value and shift it by 32. Sick...
+		 */
+		if (addr == (addr_t) &dummy->regs.acrs[15])
+			tmp = ((unsigned long) child->thread.acrs[15]) << 32;
+		else
+#endif
 		tmp = *(addr_t *)((addr_t) &child->thread.acrs + offset);
 
 	} else if (addr == (addr_t) &dummy->regs.orig_gpr2) {
@@ -167,6 +184,9 @@ peek_user(struct task_struct *child, add
 		 */
 		offset = addr - (addr_t) &dummy->regs.fp_regs;
 		tmp = *(addr_t *)((addr_t) &child->thread.fp_regs + offset);
+		if (addr == (addr_t) &dummy->regs.fp_regs.fpc)
+			tmp &= (unsigned long) FPC_VALID_MASK
+				<< (BITS_PER_LONG - 32);
 
 	} else if (addr < (addr_t) (&dummy->regs.per_info + 1)) {
 		/*
@@ -191,13 +211,19 @@ static int
 poke_user(struct task_struct *child, addr_t addr, addr_t data)
 {
 	struct user *dummy = NULL;
-	addr_t offset;
+	addr_t offset, mask;
 
 	/*
 	 * Stupid gdb peeks/pokes the access registers in 64 bit with
 	 * an alignment of 4. Programmers from hell indeed...
 	 */
-	if ((addr & 3) || addr > sizeof(struct user) - __ADDR_MASK)
+	mask = __ADDR_MASK;
+#ifdef CONFIG_ARCH_S390X
+	if (addr >= (addr_t) &dummy->regs.acrs &&
+	    addr < (addr_t) &dummy->regs.orig_gpr2)
+		mask = 3;
+#endif
+	if ((addr & mask) || addr > sizeof(struct user) - __ADDR_MASK)
 		return -EIO;
 
 	if (addr < (addr_t) &dummy->regs.acrs) {
@@ -224,6 +250,17 @@ poke_user(struct task_struct *child, add
 		 * access registers are stored in the thread structure
 		 */
 		offset = addr - (addr_t) &dummy->regs.acrs;
+#ifdef CONFIG_ARCH_S390X
+		/*
+		 * Very special case: old & broken 64 bit gdb writing
+		 * to acrs[15] with a 64 bit value. Ignore the lower
+		 * half of the value and write the upper 32 bit to
+		 * acrs[15]. Sick...
+		 */
+		if (addr == (addr_t) &dummy->regs.acrs[15])
+			child->thread.acrs[15] = (unsigned int) (data >> 32);
+		else
+#endif
 		*(addr_t *)((addr_t) &child->thread.acrs + offset) = data;
 
 	} else if (addr == (addr_t) &dummy->regs.orig_gpr2) {
@@ -237,7 +274,8 @@ poke_user(struct task_struct *child, add
 		 * floating point regs. are stored in the thread structure
 		 */
 		if (addr == (addr_t) &dummy->regs.fp_regs.fpc &&
-		    (data & ~FPC_VALID_MASK) != 0)
+		    (data & ~((unsigned long) FPC_VALID_MASK
+			      << (BITS_PER_LONG - 32))) != 0)
 			return -EINVAL;
 		offset = addr - (addr_t) &dummy->regs.fp_regs;
 		*(addr_t *)((addr_t) &child->thread.fp_regs + offset) = data;
