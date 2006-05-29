Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWE2VbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWE2VbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWE2V1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:27:16 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40427 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751369AbWE2V1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:27:07 -0400
Date: Mon, 29 May 2006 23:27:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 54/61] lock validator: special locking: mmap_sem
Message-ID: <20060529212727.GB3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/exit.c |    2 +-
 kernel/fork.c |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c
+++ linux/kernel/exit.c
@@ -582,7 +582,7 @@ static void exit_mm(struct task_struct *
 	/* more a memory barrier than a real lock */
 	task_lock(tsk);
 	tsk->mm = NULL;
-	up_read(&mm->mmap_sem);
+	up_read_non_nested(&mm->mmap_sem);
 	enter_lazy_tlb(mm, current);
 	task_unlock(tsk);
 	mmput(mm);
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -196,7 +196,10 @@ static inline int dup_mmap(struct mm_str
 
 	down_write(&oldmm->mmap_sem);
 	flush_cache_mm(oldmm);
-	down_write(&mm->mmap_sem);
+	/*
+	 * Not linked in yet - no deadlock potential:
+	 */
+	down_write_nested(&mm->mmap_sem, 1);
 
 	mm->locked_vm = 0;
 	mm->mmap = NULL;
