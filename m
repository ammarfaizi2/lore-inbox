Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWBKCGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWBKCGj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 21:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBKCGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 21:06:39 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:10246 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id S1750962AbWBKCGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 21:06:39 -0500
Date: Fri, 10 Feb 2006 21:06:23 -0500 (EST)
Message-Id: <200602110206.k1B26N8Q184606@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] document sysenter path
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This path isn't obvious. It looks as if the kernel will be taking
three args from the user stack, but it only takes one from there.

Signed-off-by: Albert Cahalan <acahalan@gmail.com>

diff -Naurd old/arch/i386/kernel/vsyscall-sysenter.S new/arch/i386/kernel/vsyscall-sysenter.S
--- old/arch/i386/kernel/vsyscall-sysenter.S	2006-02-10 19:55:27.000000000 -0500
+++ new/arch/i386/kernel/vsyscall-sysenter.S	2006-02-10 20:29:39.000000000 -0500
@@ -7,6 +7,21 @@
  *    for details.
  */
 
+/*
+ * The caller puts arg2 in %ecx, which gets pushed. The kernel will use
+ * %ecx itself for arg2. The pushing is because the sysexit instruction
+ * (found in entry.S) requires that we clobber %ecx with the desired %esp.
+ * User code might expect that %ecx is unclobbered though, as it would be
+ * for returning via the iret instruction, so we must push and pop.
+ *
+ * The caller puts arg3 in %edx, which the sysexit instruction requires
+ * for %eip. Thus, exactly as for arg2, we must push and pop.
+ *
+ * Arg6 is different. The caller puts arg6 in %ebp. Since the sysenter
+ * instruction clobbers %esp, the user's %esp won't even survive entry
+ * into the kernel. We store %esp in %ebp. Code in entry.S must fetch
+ * arg6 from the stack.
+ */
 	.text
 	.globl __kernel_vsyscall
 	.type __kernel_vsyscall,@function
