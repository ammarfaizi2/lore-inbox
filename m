Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVKHEh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVKHEh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965378AbVKHEh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:37:28 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:772 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965009AbVKHEh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:37:27 -0500
Date: Mon, 7 Nov 2005 20:37:25 -0800
Message-Id: <200511080437.jA84bPZt009939@zach-dev.vmware.com>
Subject: [PATCH 17/21] i386 Ldt cleanups 1
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:37:25.0828 (UTC) FILETIME=[1E4A8840:01C5E41E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Big cleanup of LDT code.  This code has very little type checking and is
not frequently used, so I audited the code, added type checking and size
optimizations to generate smaller assembly code.

First, just introduce some small definitions that will be used later.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/entry.S	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-zach-work/arch/i386/kernel/entry.S	2005-11-04 18:22:07.000000000 -0800
@@ -250,8 +250,8 @@ restore_all:
 	# See comments in process.c:copy_thread() for details.
 	movb OLDSS(%esp), %ah
 	movb CS(%esp), %al
-	andl $(VM_MASK | (4 << 8) | 3), %eax
-	cmpl $((4 << 8) | 3), %eax
+	andl $(VM_MASK | (LDT_SEGMENT << 8) | 3), %eax
+	cmpl $((LDT_SEGMENT << 8) | 3), %eax
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
 	RESTORE_REGS
Index: linux-2.6.14-zach-work/arch/i386/kernel/ptrace.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/ptrace.c	2005-11-04 18:30:27.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/ptrace.c	2005-11-05 00:28:04.000000000 -0800
@@ -146,8 +146,6 @@ static unsigned long getreg(struct task_
 	return retval;
 }
 
-#define LDT_SEGMENT 4
-
 static unsigned long convert_eip_to_linear(struct task_struct *child, struct pt_regs *regs)
 {
 	unsigned long addr, seg;
Index: linux-2.6.14-zach-work/include/asm-i386/segment.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/segment.h	2005-11-04 15:46:51.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/segment.h	2005-11-04 18:22:07.000000000 -0800
@@ -121,4 +121,9 @@
  */
 #define IDT_ENTRIES 256
 
+/*
+ * This bit is set to indicate segment selectors are in the LDT
+ */
+#define LDT_SEGMENT 4
+
 #endif
Index: linux-2.6.14-zach-work/include/asm-i386/ldt.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/ldt.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-zach-work/include/asm-i386/ldt.h	2005-11-04 18:22:07.000000000 -0800
@@ -10,6 +10,8 @@
 #define LDT_ENTRIES	8192
 /* The size of each LDT entry. */
 #define LDT_ENTRY_SIZE	8
+/* The number of LDT entries per page */
+#define LDT_ENTRIES_PER_PAGE (PAGE_SIZE / LDT_ENTRY_SIZE)
 
 #ifndef __ASSEMBLY__
 struct user_desc {
