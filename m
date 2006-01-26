Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWAZDzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWAZDzu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWAZDzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:55:13 -0500
Received: from [202.53.187.9] ([202.53.187.9]:23275 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932247AbWAZDte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:34 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 17/23] [Suspend2] Helper to prod processes that should have frozen but haven't.
Date: Thu, 26 Jan 2006 13:46:01 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034600.3178.40289.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a helper which prods processes of the type we are currently
trying to freeze, seeking to get them to run their todo lists.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 2857c8b..b2a9147 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -275,6 +275,29 @@ static void signal_threads(int do_all_th
 	read_unlock(&tasklist_lock);
 }
 
+/*
+ * Prod processes that haven't entered the refrigerator yet.
+ */
+static void prod_processes(int do_all_threads)
+{
+	struct task_struct *g, *p;
+	unsigned long flags;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (!freezeable(p, do_all_threads))
+			continue;
+			
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		if (!(p->flags & PF_FROZEN)) {
+			recalc_sigpending();
+			signal_wake_up(p, 0);
+		}
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+}
+
 static inline void freeze(struct task_struct *p)
 {
 	unsigned long flags;

--
Nigel Cunningham		nigel at suspend2 dot net
