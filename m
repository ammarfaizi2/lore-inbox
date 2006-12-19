Return-Path: <linux-kernel-owner+w=401wt.eu-S932784AbWLSKv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWLSKv0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932783AbWLSKvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:51:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49700 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932782AbWLSKvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:51:21 -0500
Date: Tue, 19 Dec 2006 11:48:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
Subject: [patch] lockdep: add graph depth information to /proc/lockdep
Message-ID: <20061219104836.GA17480@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: add graph depth information to /proc/lockdep
From: Jason Baron <jbaron@redhat.com>

generate locking graph information into /proc/lockdep, for lock
hierarchy documentation and visualization purposes.

sample output:

 c089fd5c OPS:     138 FD:   14 BD:    1 --..: &tty->termios_mutex
  -> [c07a3430] tty_ldisc_lock
  -> [c07a37f0] &port_lock_key
  -> [c07afdc0] &rq->rq_lock_key#2

the lock classes listed are all the first-hop lock dependencies
that lockdep has seen so far.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/lockdep.h |    1 +
 kernel/lockdep.c        |   19 ++++++++++++-------
 kernel/lockdep_proc.c   |   41 +++++++++++++++++++++++++++++------------
 3 files changed, 42 insertions(+), 19 deletions(-)

Index: linux/include/linux/lockdep.h
===================================================================
--- linux.orig/include/linux/lockdep.h
+++ linux/include/linux/lockdep.h
@@ -132,6 +132,7 @@ struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
 	struct stack_trace		trace;
+	int				distance;
 };
 
 /*
Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -494,7 +494,7 @@ static void print_lock_dependencies(stru
  * Add a new dependency to the head of the list:
  */
 static int add_lock_to_list(struct lock_class *class, struct lock_class *this,
-			    struct list_head *head, unsigned long ip)
+			    struct list_head *head, unsigned long ip, int distance)
 {
 	struct lock_list *entry;
 	/*
@@ -506,6 +506,7 @@ static int add_lock_to_list(struct lock_
 		return 0;
 
 	entry->class = this;
+	entry->distance = distance;
 	if (!save_trace(&entry->trace))
 		return 0;
 
@@ -910,7 +911,7 @@ check_deadlock(struct task_struct *curr,
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next)
+	       struct held_lock *next, int distance)
 {
 	struct lock_list *entry;
 	int ret;
@@ -988,8 +989,11 @@ check_prev_add(struct task_struct *curr,
 	 *  L2 added to its dependency list, due to the first chain.)
 	 */
 	list_for_each_entry(entry, &prev->class->locks_after, entry) {
-		if (entry->class == next->class)
+		if (entry->class == next->class) {
+			if (distance == 1)
+				entry->distance = 1;
 			return 2;
+		}
 	}
 
 	/*
@@ -997,12 +1001,13 @@ check_prev_add(struct task_struct *curr,
 	 * to the previous lock's dependency list:
 	 */
 	ret = add_lock_to_list(prev->class, next->class,
-			       &prev->class->locks_after, next->acquire_ip);
+			       &prev->class->locks_after, next->acquire_ip, distance);
+
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(next->class, prev->class,
-			       &next->class->locks_before, next->acquire_ip);
+			       &next->class->locks_before, next->acquire_ip, distance);
 	if (!ret)
 		return 0;
 
@@ -1050,13 +1055,14 @@ check_prevs_add(struct task_struct *curr
 		goto out_bug;
 
 	for (;;) {
+		int distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth-1;
 		/*
 		 * Only non-recursive-read entries get new dependencies
 		 * added:
 		 */
 		if (hlock->read != 2) {
-			if (!check_prev_add(curr, hlock, next))
+			if (!check_prev_add(curr, hlock, next, distance))
 				return 0;
 			/*
 			 * Stop after the first non-trylock entry,
@@ -2849,4 +2855,3 @@ void debug_show_held_locks(struct task_s
 }
 
 EXPORT_SYMBOL_GPL(debug_show_held_locks);
-
Index: linux/kernel/lockdep_proc.c
===================================================================
--- linux.orig/kernel/lockdep_proc.c
+++ linux/kernel/lockdep_proc.c
@@ -77,12 +77,29 @@ static unsigned long count_backward_deps
 	return ret;
 }
 
+static void print_name(struct seq_file *m, struct lock_class *class)
+{
+	char str[128];
+	const char *name = class->name;
+
+	if (!name) {
+		name = __get_key_name(class->key, str);
+		seq_printf(m, "%s", name);
+	} else{
+		seq_printf(m, "%s", name);
+		if (class->name_version > 1)
+			seq_printf(m, "#%d", class->name_version);
+		if (class->subclass)
+			seq_printf(m, "/%d", class->subclass);
+	}
+}
+
 static int l_show(struct seq_file *m, void *v)
 {
 	unsigned long nr_forward_deps, nr_backward_deps;
 	struct lock_class *class = m->private;
-	char str[128], c1, c2, c3, c4;
-	const char *name;
+	struct lock_list *entry;
+	char c1, c2, c3, c4;
 
 	seq_printf(m, "%p", class->key);
 #ifdef CONFIG_DEBUG_LOCKDEP
@@ -97,16 +114,16 @@ static int l_show(struct seq_file *m, vo
 	get_usage_chars(class, &c1, &c2, &c3, &c4);
 	seq_printf(m, " %c%c%c%c", c1, c2, c3, c4);
 
-	name = class->name;
-	if (!name) {
-		name = __get_key_name(class->key, str);
-		seq_printf(m, ": %s", name);
-	} else{
-		seq_printf(m, ": %s", name);
-		if (class->name_version > 1)
-			seq_printf(m, "#%d", class->name_version);
-		if (class->subclass)
-			seq_printf(m, "/%d", class->subclass);
+	seq_printf(m, ": ");
+	print_name(m, class);
+	seq_puts(m, "\n");
+
+	list_for_each_entry(entry, &class->locks_after, entry) {
+		if (entry->distance == 1) {
+			seq_printf(m, " -> [%p] ", entry->class);
+			print_name(m, entry->class);
+			seq_puts(m, "\n");
+		}
 	}
 	seq_puts(m, "\n");
 
