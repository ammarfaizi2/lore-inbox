Return-Path: <linux-kernel-owner+w=401wt.eu-S1750696AbXAEUe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbXAEUe4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbXAEUe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:34:56 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:10212 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbXAEUez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:34:55 -0500
X-AuditID: d80ac21c-a21c9bb00000021a-3a-459eb66ea6ff 
Date: Fri, 5 Jan 2007 20:35:13 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix OOM killing of swapoff
Message-ID: <Pine.LNX.4.64.0701052031260.3944@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 05 Jan 2007 20:34:54.0185 (UTC) FILETIME=[F4EA6590:01C73108]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These days, if you swapoff when there isn't enough memory, OOM killer
gives "BUG: scheduling while atomic" and the machine hangs: badness()
needs to do its PF_SWAPOFF return after the task_unlock (tasklist_lock
is also held here, so p isn't going to be freed: PF_SWAPOFF might get
turned off at any moment, but that doesn't really matter).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
Will be needed in 2.6.19-stable too.

 mm/oom_kill.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- 2.6.20-rc3/mm/oom_kill.c	2007-01-01 10:30:46.000000000 +0000
+++ linux/mm/oom_kill.c	2007-01-05 20:17:21.000000000 +0000
@@ -61,12 +61,6 @@ unsigned long badness(struct task_struct
 	}
 
 	/*
-	 * swapoff can easily use up all memory, so kill those first.
-	 */
-	if (p->flags & PF_SWAPOFF)
-		return ULONG_MAX;
-
-	/*
 	 * The memory size of the process is the basis for the badness.
 	 */
 	points = mm->total_vm;
@@ -77,6 +71,12 @@ unsigned long badness(struct task_struct
 	task_unlock(p);
 
 	/*
+	 * swapoff can easily use up all memory, so kill those first.
+	 */
+	if (p->flags & PF_SWAPOFF)
+		return ULONG_MAX;
+
+	/*
 	 * Processes which fork a lot of child processes are likely
 	 * a good choice. We add half the vmsize of the children if they
 	 * have an own mm. This prevents forking servers to flood the
