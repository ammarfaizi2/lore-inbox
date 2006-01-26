Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWAZD5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWAZD5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWAZD5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:57:43 -0500
Received: from [202.53.187.9] ([202.53.187.9]:22251 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932249AbWAZDta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:30 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 15/23] [Suspend2] Helper for counting uninterruptible threads of a type.
Date: Thu, 26 Jan 2006 13:45:57 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034556.3178.79337.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a helper which counts the number of patches of a type (all
or userspace only) which are in TASK_UNINTERRUPTIBLE state.
These tasks are signalled (just in case they leave that state at
a later point), but we do not consider freezing to have failed
if and when they do not enter the freezer.

Note that when they eventually leave TASK_UNINTERRUPTIBLE state,
they will enter the refrigerator, but will immediately exit if
we no longer want to freeze at that point.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index d5d052a..9cfafa7 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -227,6 +227,29 @@ static int num_freezeable(int do_all_thr
 	return todo_this_type;
 }
 
+/*
+ * num_uninterruptible
+ *
+ * Description:	Determine how many processes of our type are in state
+ * 		task uninterruptible.
+ * Parameters:	int	Which type we are trying to freeze.
+ */
+static int num_uninterruptible(int do_all_threads)
+{
+	struct task_struct *g, *p;
+	int count = 0;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (freezeable(p, do_all_threads) &&
+			p->state == TASK_UNINTERRUPTIBLE)
+			count++;
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
+	return count;
+}
+
 static inline void freeze(struct task_struct *p)
 {
 	unsigned long flags;

--
Nigel Cunningham		nigel at suspend2 dot net
