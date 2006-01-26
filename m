Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWAZDuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWAZDuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWAZDtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:47 -0500
Received: from [202.53.187.9] ([202.53.187.9]:21739 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932251AbWAZDt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:29 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 14/23] [Suspend2] Helper for counting freezeable threads of a type.
Date: Thu, 26 Jan 2006 13:45:55 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034554.3178.53848.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a helper, which returns the number of threads of the given type
(userspace only or all) that are still to be frozen.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index dffe645..d5d052a 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -204,6 +204,29 @@ void thaw_processes(int do_all_threads)
 	}
 }
 
+/*
+ * num_freezeable
+ *
+ * Description:	Determine how many processes of our type are still to be
+ * 		frozen. As a side effect, update the progress bar too.
+ * Parameters:	int	Which type we are trying to freeze.
+ * 		int	Whether we are displaying our progress.
+ */
+static int num_freezeable(int do_all_threads)
+{
+	struct task_struct *g, *p;
+	int todo_this_type = 0;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (freezeable(p, do_all_threads))
+			todo_this_type++;
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
+	return todo_this_type;
+}
+
 static inline void freeze(struct task_struct *p)
 {
 	unsigned long flags;

--
Nigel Cunningham		nigel at suspend2 dot net
