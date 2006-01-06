Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWAFQQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWAFQQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWAFQQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:16:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39179 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751578AbWAFQQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:16:14 -0500
Date: Fri, 6 Jan 2006 17:16:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix arm26 THREAD_SIZE
Message-ID: <20060106161608.GG12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arm26 currently has a 256 kB THREAD_SIZE (sic).

Looking at the comment in the code, this seems to be based on a 
misunderstanding.

The comment says:
this needs attention (see kernel/fork.c which gets a nice div by zero if 
this is lower than 8*32768

kernel/fork.c does:
  max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE)

Therefore, a division by 0 is impossible for all reasonable cases with
THREAD_SIZE >= PAGE_SIZE.

Since the minimum PAGE_SIZE Linux uses on the arm26 architecture is 16k, 
PAGE_SIZE should be sufficient for THREAD_SIZE.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm1-full/include/asm-arm26/thread_info.h.old	2006-01-06 16:45:40.000000000 +0100
+++ linux-2.6.15-mm1-full/include/asm-arm26/thread_info.h	2006-01-06 16:46:07.000000000 +0100
@@ -80,8 +80,7 @@
 	return (struct thread_info *)(sp & ~0x1fff);
 }
 
-/* FIXME - PAGE_SIZE < 32K */
-#define THREAD_SIZE		(8*32768) // FIXME - this needs attention (see kernel/fork.c which gets a nice div by zero if this is lower than 8*32768
+#define THREAD_SIZE	PAGE_SIZE
 #define task_pt_regs(task) ((struct pt_regs *)(task_stack_page(task) + THREAD_SIZE - 8) - 1)
 
 extern struct thread_info *alloc_thread_info(struct task_struct *task);

