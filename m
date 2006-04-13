Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWDMR7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWDMR7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWDMR7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:59:14 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:54928 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932359AbWDMR7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:59:14 -0400
Date: Fri, 14 Apr 2006 01:56:21 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pids: simplify do_each_task_pid/while_each_task_pid
Message-ID: <20060413215621.GA355@oleg>
References: <20060413163727.GA1365@oleg> <20060413133814.GA29914@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413133814.GA29914@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13, Christoph Hellwig wrote:
>
> This is prtty ugly.  Can't we just have a
> 
> #define for_each_task_pid(task, pid, type, pos) \
> 	hlist_for_each_entry_rcu((task), (pos),  \
> 		(&(pid))->tasks[type], pids[type].node) {
> 
> and move the find_pid to the caller?  That would make the code a whole lot
> more readable.

How about this? :)

Oleg.

--- MM/include/linux/pid.h~	2006-03-23 22:48:10.000000000 +0300
+++ MM/include/linux/pid.h	2006-04-14 01:49:08.000000000 +0400
@@ -98,22 +98,22 @@ extern void FASTCALL(free_pid(struct pid
 	hlist_entry(pid_next(task, type), struct task_struct,	\
 			pids[(type)].node)
 
+#define for_each_task_pid(who, type, t)		 							\
+	for ((t) = ({											\
+		struct pid *pid___ = find_pid(who);							\
+		pid___											\
+			? hlist_entry((&pid___->tasks[type])->first, typeof(*(t)), pids[type].node)	\
+			: hlist_entry(NULL, typeof(*(t)), pids[type].node);				\
+		});											\
+		rcu_dereference(t) != hlist_entry(NULL, typeof(*(t)), pids[type].node)			\
+			&& ({ prefetch((t)->pids[type].node.next); 1; });				\
+		(t) = hlist_entry((t)->pids[type].node.next, typeof(*(t)), pids[type].node))
 
-/* We could use hlist_for_each_entry_rcu here but it takes more arguments
- * than the do_each_task_pid/while_each_task_pid.  So we roll our own
- * to preserve the existing interface.
- */
-#define do_each_task_pid(who, type, task)				\
-	if ((task = find_task_by_pid_type(type, who))) {		\
-		prefetch(pid_next(task, type));				\
-		do {
+/* obsolete */
+#define do_each_task_pid(who, type, task)	\
+	do for_each_task_pid(who, type, task)
 
-#define while_each_task_pid(who, type, task)				\
-		} while (pid_next(task, type) &&  ({			\
-				task = pid_next_task(task, type);	\
-				rcu_dereference(task);			\
-				prefetch(pid_next(task, type));		\
-				1; }) );				\
-	}
+#define while_each_task_pid(who, type, task)	\
+	while (0)
 
 #endif /* _LINUX_PID_H */

