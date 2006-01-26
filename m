Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWAZD44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWAZD44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWAZDtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:32 -0500
Received: from [202.53.187.9] ([202.53.187.9]:20203 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932247AbWAZDtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:23 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 11/23] [Suspend2] Modify freezeable for freezing kernel threads separately.
Date: Thu, 26 Jan 2006 13:45:50 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034549.3178.12423.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Modify freezeable so that it takes an extra argument indicating
whether we are interested in all threads, or just userspace ones,
and ignores threads that are already in the refrigerator.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 0e377ed..444a163 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -98,14 +98,24 @@ int freezer_make_fses_ro(void)
 	return 0;
 }
 
-static inline int freezeable(struct task_struct * p)
+/*
+ * freezeable
+ *
+ * Description:	Determine whether a process should be frozen yet.
+ * Parameters:	struct task_struct *	The process to consider.
+ * 		int			Boolean - 0 = userspace else all.
+ * Returns:	int			0 if don't freeze yet, otherwise do.
+ */
+static int freezeable(struct task_struct * p, int all_freezable)
 {
 	if ((p == current) || 
+	    (p->flags & PF_FROZEN) ||
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
 	    (p->exit_state == EXIT_DEAD) ||
 	    (p->state == TASK_STOPPED) ||
-	    (p->state == TASK_TRACED))
+	    (p->state == TASK_TRACED) ||
+	    (!p->mm && !all_freezable))
 		return 0;
 	return 1;
 }

--
Nigel Cunningham		nigel at suspend2 dot net
