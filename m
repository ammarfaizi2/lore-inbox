Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWGQRZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWGQRZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 13:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWGQRZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 13:25:35 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:5816 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751076AbWGQRZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 13:25:34 -0400
Date: Mon, 17 Jul 2006 13:19:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: fix recursive fault in page-fault handler
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607171322_MC3-1-C53B-6253@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa reported recursive faults in do_page_fault()
causing a stream of partial oops messages on the console. Fix
by adding a fixup for that code.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

x86_64 looks like it has the same problem.

--- 2.6.18-rc1-32.orig/arch/i386/mm/fault.c
+++ 2.6.18-rc1-32/arch/i386/mm/fault.c
@@ -585,9 +585,20 @@ no_context:
 		printk(KERN_ALERT "*pte = %08lx\n", page);
 	}
 #endif
-	tsk->thread.cr2 = address;
-	tsk->thread.trap_no = 14;
-	tsk->thread.error_code = error_code;
+	asm (	"# set task data without causing another oops\n"
+		"1:\t"
+		"movl %3,%0\n\t"
+		"movl $14,%1\n\t"
+		"movl %4,%2\n"
+		"2:\n"
+		".section __ex_table,\"a\"\n\t"
+		".align 4\n\t"
+		".long 1b,2b\n"
+		".previous"
+		: "=m" (tsk->thread.cr2), "=m" (tsk->thread.trap_no),
+		  "=m" (tsk->thread.error_code)
+		: "r" (address), "r" (error_code)
+	);
 	die("Oops", regs, error_code);
 	bust_spinlocks(0);
 	do_exit(SIGKILL);
-- 
And did you exchange a walk-on part in the war for a lead role in a cage?
        --Roger Waters
