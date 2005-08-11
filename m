Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVHKSQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVHKSQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVHKSQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:16:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:29355 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932342AbVHKSQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:16:48 -0400
Date: Thu, 11 Aug 2005 23:42:35 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, rusty@au1.ibm.com, bmark@us.ibm.com
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050811181235.GE4546@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050810171145.GA1945@us.ibm.com> <20050811171451.GA5108@infradead.org> <20050811180044.GD4546@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811180044.GD4546@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 11:30:44PM +0530, Dipankar Sarma wrote:
> When I worked on this last (a year or so ago), it seemed that I would
> need to put a number of additional structures under RCU control.
> It would be better to gradually move it towards RCU rather than
> trying make all the readers lock-free.

Just for reference, this was my tasks-rcu patch. 2.6.0-test2, no less :)
I was interested in get_pid_list() at that time. IIRC, I tested it with
lots of top running along with other tests.

Thanks
Dipankar


Incremental patch to do lockfree traversal of the task list using
RCU. For now it just does one of the costlies ones in /proc.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 fs/exec.c             |    1 +
 fs/proc/base.c        |    5 +++--
 include/linux/sched.h |   21 ++++++++++++++++-----
 3 files changed, 20 insertions(+), 7 deletions(-)

diff -puN fs/exec.c~tasks-rcu fs/exec.c
--- linux-2.6.0-test2-ds/fs/exec.c~tasks-rcu	2003-08-04 21:48:38.000000000 +0530
+++ linux-2.6.0-test2-ds-dipankar/fs/exec.c	2003-08-04 21:49:26.000000000 +0530
@@ -676,6 +676,7 @@ static inline int de_thread(struct task_
 
 		list_del(&current->tasks);
 		list_add_tail(&current->tasks, &init_task.tasks);
+		list_add_tail_rcu(&current->tasks, &init_task.tasks);
 		current->exit_signal = SIGCHLD;
 		state = leader->state;
 
diff -puN fs/proc/base.c~tasks-rcu fs/proc/base.c
--- linux-2.6.0-test2-ds/fs/proc/base.c~tasks-rcu	2003-08-04 21:48:38.000000000 +0530
+++ linux-2.6.0-test2-ds-dipankar/fs/proc/base.c	2003-08-04 21:49:59.000000000 +0530
@@ -32,6 +32,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/rcupdate.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
@@ -1403,7 +1404,7 @@ static int get_pid_list(int index, unsig
 	int nr_pids = 0;
 
 	index--;
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	for_each_process(p) {
 		int pid = p->pid;
 		if (!pid_alive(p))
@@ -1415,7 +1416,7 @@ static int get_pid_list(int index, unsig
 		if (nr_pids >= PROC_MAXPIDS)
 			break;
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 	return nr_pids;
 }
 
diff -puN include/linux/sched.h~tasks-rcu include/linux/sched.h
--- linux-2.6.0-test2-ds/include/linux/sched.h~tasks-rcu	2003-08-04 21:48:38.000000000 +0530
+++ linux-2.6.0-test2-ds-dipankar/include/linux/sched.h	2003-08-04 21:54:58.000000000 +0530
@@ -28,6 +28,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/rcupdate.h>
 
 struct exec_domain;
 
@@ -456,13 +457,23 @@ struct task_struct {
 	struct io_context *io_context;
 
 	unsigned long ptrace_message;
+	struct rcu_head rcu;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
-#define put_task_struct(tsk) \
-do { if (atomic_dec_and_test(&(tsk)->usage)) __put_task_struct(tsk); } while(0)
+static void put_task_struct_rcu(struct rcu_head *rcu)
+{
+	struct task_struct *tsk = container_of(rcu, struct task_struct, rcu);
+	__put_task_struct(tsk);
+}
+static inline void put_task_struct(struct task_struct *tsk)
+{
+	if (atomic_dec_and_test(&tsk->usage))
+		call_rcu(&tsk->rcu, put_task_struct_rcu);
+}
+
 
 /*
  * Per process flags
@@ -675,13 +686,13 @@ extern void wait_task_inactive(task_t * 
 
 #define REMOVE_LINKS(p) do {					\
 	if (thread_group_leader(p))				\
-		list_del_init(&(p)->tasks);			\
+		list_del_rcu(&(p)->tasks);			\
 	remove_parent(p);					\
 	} while (0)
 
 #define SET_LINKS(p) do {					\
 	if (thread_group_leader(p))				\
-		list_add_tail(&(p)->tasks,&init_task.tasks);	\
+		list_add_tail_rcu(&(p)->tasks,&init_task.tasks);	\
 	add_parent(p, (p)->parent);				\
 	} while (0)
 
@@ -689,7 +700,7 @@ extern void wait_task_inactive(task_t * 
 #define prev_task(p)	list_entry((p)->tasks.prev, struct task_struct, tasks)
 
 #define for_each_process(p) \
-	for (p = &init_task ; (p = next_task(p)) != &init_task ; )
+	for (p = &init_task ; (p = next_task(p)),({ read_barrier_depends(); 0;}),p != &init_task ; )
 
 /*
  * Careful: do_each_thread/while_each_thread is a double loop so

_
