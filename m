Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWJLOKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWJLOKs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWJLOK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:10:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:10977 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751423AbWJLOKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:10:06 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-Id: <20061012120129.29671.3288.sendpatchset@linux.site>
In-Reply-To: <20061012120102.29671.31163.sendpatchset@linux.site>
References: <20061012120102.29671.31163.sendpatchset@linux.site>
Subject: [patch 3/5] oom: less memdie
Date: Thu, 12 Oct 2006 16:10:01 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't cause all threads in all other thread groups to gain TIF_MEMDIE
otherwise we'll get a thundering herd eating out memory reserve. This
may not be the optimal scheme, but it fits our policy of allowing just
one TIF_MEMDIE in the system at once.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/oom_kill.c
===================================================================
--- linux-2.6.orig/mm/oom_kill.c
+++ linux-2.6/mm/oom_kill.c
@@ -322,11 +322,12 @@ static int oom_kill_task(struct task_str
 
 	/*
 	 * kill all processes that share the ->mm (i.e. all threads),
-	 * but are in a different thread group.
+	 * but are in a different thread group. Don't let them have access
+	 * to memory reserves though, otherwise we might deplete all memory.
 	 */
 	do_each_thread(g, q) {
 		if (q->mm == mm && q->tgid != p->tgid)
-			__oom_kill_task(q, 1);
+			force_sig(SIGKILL, p);
 	} while_each_thread(g, q);
 
 	return 0;
