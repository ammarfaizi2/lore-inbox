Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUGBPGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUGBPGD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 11:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbUGBPGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 11:06:03 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:41886
	"EHLO voidhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S264633AbUGBPF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 11:05:59 -0400
Date: Fri, 2 Jul 2004 16:05:41 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-Id: <200407021505.i62F5faM002217@voidhawk.shadowen.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix TRAP_BAD_SYSCALL_EXITS on i386
Cc: akpm@osdl.org, apw@shadowen.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that we are not using the right accessor for the preempt
count in entry.S on i386 for the TRAP_BAD_SYSCALL_EXITS checks.
Patch below should fix this.  Complied and booted on -mm5.

-apw

=== 8<===
We are not using the right offset name, nor the right address when checking
for a non-zero preempt count.  Move to TI_preempt_count(%ebp).

Revision: $Rev: 356 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---
 entry.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/kernel/entry.S current/arch/i386/kernel/entry.S
--- reference/arch/i386/kernel/entry.S	2004-07-02 14:00:51.000000000 +0100
+++ current/arch/i386/kernel/entry.S	2004-07-02 16:18:07.000000000 +0100
@@ -314,7 +314,7 @@ restore_all:
 	testl $(VM_MASK | 3), %eax
 	jz resume_kernelX		# returning to kernel or vm86-space
 
-	cmpl $0,TI_PRE_COUNT(%ebx)	# non-zero preempt_count ?
+	cmpl $0,TI_preempt_count(%ebp)  # non-zero preempt_count ?
 	jz resume_kernelX
 
         int $3
