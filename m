Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWAZDye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWAZDye (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAZDyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:54:16 -0500
Received: from [202.53.187.9] ([202.53.187.9]:23787 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932254AbWAZDtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:36 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 18/23] [Suspend2] Helper: Did we fail to freeze all threads of a type?
Date: Thu, 26 Jan 2006 13:46:03 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034602.3178.17565.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a helper which checks whether we failed to freeze all the processes
of a given type (ignoring uninterruptible threads). If such processes
are found, we notify the user.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index b2a9147..4322155 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -298,6 +298,46 @@ static void prod_processes(int do_all_th
 	read_unlock(&tasklist_lock);
 }
 
+/*
+ * Freezer failure.
+ *
+ * Check whether we failed to freeze all the processes that
+ * should be frozen. If we find a task that failed to freeze,
+ * we give useful information on what failed and how.
+ */
+static int freezer_failure(int do_all_threads)
+{
+	int result = 0;
+	struct task_struct *g, *p;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (!freezeable(p, do_all_threads) || 
+				p->state == TASK_UNINTERRUPTIBLE) 
+			continue;
+
+		if (!result) {
+			printk(KERN_ERR	"Stopping tasks failed.\n");
+			printk(KERN_ERR "Tasks that refused to be "
+			 "refrigerated and haven't since exited:\n");
+			set_freezer_state(ABORT_FREEZING);
+			result = 1;
+		}
+
+		if ((freezing(p))) {
+			printk(" - %s (#%d) signalled but "
+				"didn't enter refrigerator.\n",
+				p->comm, p->pid);
+		} else
+			printk(" - %s (#%d) signalled "
+				"and todo list empty.\n",
+				p->comm, p->pid);
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
+	return result;
+}
+
 static inline void freeze(struct task_struct *p)
 {
 	unsigned long flags;

--
Nigel Cunningham		nigel at suspend2 dot net
