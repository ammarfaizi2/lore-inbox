Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268582AbUILJRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268582AbUILJRv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268544AbUILJRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:17:50 -0400
Received: from [211.58.254.17] ([211.58.254.17]:21996 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S268581AbUILJQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:16:31 -0400
Date: Sun, 12 Sep 2004 18:16:28 +0900
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: [PATCH] Interrupt entry CONFIG_FRAME_POINTER fix
Message-ID: <20040912091628.GB13359@home-tj.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Tejun Heo <tj@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 On x86_64, rbp isn't saved on entering interrupt handler even when
CONFIG_FRAME_POINTER is turned on.  This breaks profile_pc()
(resulting in oops) which uses regs->rbp to track back to the original
stack.  Save full stack when CONFIG_FRAME_POINTER is specified.

-- 
tejun


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="x86_64_frame_pointer.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/12 16:38:06+09:00 tj@htj.dyndns.org 
#   On x86_64, rbp isn't saved on entering interrupt handler even when
#   CONFIG_FRAME_POINTER is turned on.  This breaks profile_pc() which
#   uses regs->rbp to track back to the original stack.  Save full stack
#   when CONFIG_FRAME_POINTER is specified.
# 
# arch/x86_64/kernel/entry.S
#   2004/09/12 16:37:55+09:00 tj@htj.dyndns.org +10 -4
#   On x86_64, rbp isn't saved on entering interrupt handler even when
#   CONFIG_FRAME_POINTER is turned on.  This breaks profile_pc() which
#   uses regs->rbp to track back to the original stack.  Save full stack
#   when CONFIG_FRAME_POINTER is specified.
# 
diff -Nru a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
--- a/arch/x86_64/kernel/entry.S	2004-09-12 18:05:16 +09:00
+++ b/arch/x86_64/kernel/entry.S	2004-09-12 18:05:16 +09:00
@@ -410,8 +410,8 @@
 	CFI_REL_OFFSET	rsp,(RSP-ORIG_RAX)
 	CFI_REL_OFFSET	rip,(RIP-ORIG_RAX)
 	cld
-#ifdef CONFIG_DEBUG_INFO
-	SAVE_ALL	
+#if defined(CONFIG_DEBUG_INFO)
+	SAVE_ALL
 	movq %rsp,%rdi
 	/*
 	 * Setup a stack frame pointer.  This allows gdb to trace
@@ -419,10 +419,16 @@
 	 */
 	movq %rsp,%rbp
 	CFI_DEF_CFA_REGISTER	rbp
-#else		
+#elif defined(CONFIG_FRAME_POINTER)
+	/* Save full stack frame such that interrupt handlers can trace
+	 * back to the original stack using regs->rbp.  Currently,
+	 * profile_pc() uses it when CONFIG_SMP is also turned on. */
+	SAVE_ALL
+	movq %rsp,%rdi
+#else
 	SAVE_ARGS
 	leaq -ARGOFFSET(%rsp),%rdi	# arg1 for handler
-#endif	
+#endif
 	testl $3,CS(%rdi)
 	je 1f
 	swapgs	

--xgyAXRrhYN0wYx8y--
