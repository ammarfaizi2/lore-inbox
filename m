Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWJLOJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWJLOJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWJLOJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:09:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:5857 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751418AbWJLOJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:09:47 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-Id: <20061012120111.29671.83152.sendpatchset@linux.site>
In-Reply-To: <20061012120102.29671.31163.sendpatchset@linux.site>
References: <20061012120102.29671.31163.sendpatchset@linux.site>
Subject: [patch 1/5] oom: don't kill unkillable children or siblings
Date: Thu, 12 Oct 2006 16:09:43 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abort the kill if any of our threads have OOM_DISABLE set. Having this test
here also prevents any OOM_DISABLE child of the "selected" process from being
killed.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/oom_kill.c
===================================================================
--- linux-2.6.orig/mm/oom_kill.c
+++ linux-2.6/mm/oom_kill.c
@@ -312,15 +312,24 @@ static int oom_kill_task(struct task_str
 	if (mm == NULL)
 		return 1;
 
+	/*
+	 * Don't kill the process if any threads are set to OOM_DISABLE
+	 */
+	do_each_thread(g, q) {
+		if (q->mm == mm && p->oomkilladj == OOM_DISABLE)
+			return 1;
+	} while_each_thread(g, q);
+
 	__oom_kill_task(p, message);
+
 	/*
 	 * kill all processes that share the ->mm (i.e. all threads),
 	 * but are in a different thread group
 	 */
-	do_each_thread(g, q)
+	do_each_thread(g, q) {
 		if (q->mm == mm && q->tgid != p->tgid)
 			__oom_kill_task(q, message);
-	while_each_thread(g, q);
+	} while_each_thread(g, q);
 
 	return 0;
 }
