Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWA2HYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWA2HYz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWA2HYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:24:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17375 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750888AbWA2HYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:24:54 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: [PATCH 2/5] pid: Add macros for interating through tasks by type.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 00:24:20 -0700
In-Reply-To: <m1lkwza479.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Sun, 29 Jan 2006 00:22:34 -0700")
Message-ID: <m1hd7na44b.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently do_each_task_pid/while_each_task_pid make it
possible to iterate through each task of a group of
processes given the pid of the group.

do_each_task/while_each_task do the same thing but assume
you are atarting with the first task of a process group.
This is needed so we can start with a task_ref instead
of a pid.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 include/linux/pid.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

34e71e62a13a78350239c18e3e3c31e79593380f
diff --git a/include/linux/pid.h b/include/linux/pid.h
index e206149..7fa9b2e 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -54,4 +54,16 @@ extern void switch_exec_pids(struct task
 			hlist_unhashed(&(task)->pids[type].pid_chain));	\
 	}								\
 
+#define do_each_task(task, type)					\
+	if (task) {					\
+		prefetch((task)->pids[type].pid_list.next);	\
+		do {
+
+#define while_each_task(task, type)					\
+		} while (task = pid_task((task)->pids[type].pid_list.next, \
+						(type)),		\
+			prefetch((task)->pids[type].pid_list.next),	\
+			hlist_unhashed(&(task)->pids[type].pid_chain));	\
+	}
+
 #endif /* _LINUX_PID_H */
-- 
1.1.5.g3480

