Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWBAKlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWBAKlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWBAKlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:41:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37568 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932408AbWBAKlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:41:06 -0500
Date: Wed, 1 Feb 2006 11:39:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch] simplify audit_free() locking
Message-ID: <20060201103942.GA5772@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch simplifies audit_free()'s locking: no need to lock a task 
that we are tearing down. [the extra locking also caused false positives 
in the lock validator]

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/kernel/auditsc.c
===================================================================
--- linux.orig/kernel/auditsc.c
+++ linux/kernel/auditsc.c
@@ -692,10 +692,14 @@ void audit_free(struct task_struct *tsk)
 {
 	struct audit_context *context;
 
-	task_lock(tsk);
+	/*
+	 * No need to lock the task - when we execute audit_free()
+	 * then the task has no external references anymore, and
+	 * we are tearing it down. (The locking also confuses
+	 * DEBUG_LOCKDEP - this freeing may occur in softirq
+	 * contexts as well, via RCU.)
+	 */
 	context = audit_get_context(tsk, 0, 0);
-	task_unlock(tsk);
-
 	if (likely(!context))
 		return;
 
