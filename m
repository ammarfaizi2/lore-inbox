Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVGESkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVGESkD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 14:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVGESkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 14:40:03 -0400
Received: from kanga.kvack.org ([66.96.29.28]:36774 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261954AbVGESjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 14:39:12 -0400
Date: Tue, 5 Jul 2005 14:40:26 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] uml-v2.6.12-bcrl-fix-tlb.diff
Message-ID: <20050705184026.GA21739@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This patch fixes a fairly serious tlb flushing bug that makes aio use under 
uml very unreliable -- SEGVs, Oops and panic()s occur as a result of stale 
tlb entires being used by uml when aio switches mms due to the fact that 
uml does not implement the activate_mm() hook.  This patch introduces a 
simple but correct approach (read: hammer) for implementing activate_mm() 
in uml by doing a force_flush_all() if the new mm is different from old.
With this patch in place, uml is able to succeed at the aio test case that 
was randomly faulting for me before.

		-ben

diff -purN 60_pipe_aio/include/asm-um/mmu_context.h test.diff/include/asm-um/mmu_context.h
--- 60_pipe_aio/include/asm-um/mmu_context.h	2004-12-24 16:34:57.000000000 -0500
+++ test.diff/include/asm-um/mmu_context.h	2005-07-05 14:38:34.569235552 -0400
@@ -14,8 +14,12 @@
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
+extern void force_flush_all(void);
+
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 {
+	if (old != new)
+		force_flush_all();
 }
 
 extern void switch_mm_skas(int mm_fd);
