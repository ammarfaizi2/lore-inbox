Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWAZD5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWAZD5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWAZD45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:56:57 -0500
Received: from [202.53.187.9] ([202.53.187.9]:22763 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932255AbWAZDtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:32 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 16/23] [Suspend2] Helper to signal all threads of a type.
Date: Thu, 26 Jan 2006 13:45:59 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034558.3178.41947.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a helper to do the actual signalling of processes, telling them to
enter the refrigerator.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 9cfafa7..2857c8b 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -250,6 +250,31 @@ static int num_uninterruptible(int do_al
 	return count;
 }
 
+/*
+ * Tell threads of the type to enter the freezer.
+ */
+static void signal_threads(int do_all_threads)
+{
+	struct task_struct *g, *p;
+	struct notifier_block *n;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (!freezeable(p, do_all_threads))
+			continue;
+
+		n = kmalloc(sizeof(struct notifier_block),
+					GFP_ATOMIC);
+
+		if (n) {
+			n->notifier_call = freeze_process;
+			n->priority = 0;
+			notifier_chain_register(&p->todo, n);
+ 		}
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+}
+
 static inline void freeze(struct task_struct *p)
 {
 	unsigned long flags;

--
Nigel Cunningham		nigel at suspend2 dot net
