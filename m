Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbTAQPUO>; Fri, 17 Jan 2003 10:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbTAQPUO>; Fri, 17 Jan 2003 10:20:14 -0500
Received: from diogenis.ceid.upatras.gr ([150.140.141.181]:24198 "HELO
	diogenis.ceid.upatras.gr") by vger.kernel.org with SMTP
	id <S267520AbTAQPUJ>; Fri, 17 Jan 2003 10:20:09 -0500
Date: Fri, 17 Jan 2003 17:27:35 +0200 (EET)
From: Xanthakis Stelios <sxanth@ceid.upatras.gr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] log(n) PID pool
Message-ID: <Pine.GSO.4.21.0301171722500.2585-100000@zenon.ceid.upatras.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch changes the existing PID hash table to a tree of integers
and the actions <find, remove, add> are log(n).

[The integer tree is a very simple data structure, described below]

-- The size of task_struct remains the **same**.

-- At the moment (in 2.4.20 at least) the kernel functions are:
     hash_pid()           : O(1) instant
     unhash_pid()         : O(1) instant
     find_task_by_pid()   : O(N/1024)
     +plus the 4kB hash table

 Whether this patch should be included depends on how important
 we consider find_task_by_pid().

   hash_pid:         called by do_fork()
   unhash_pid:       called by sys_wait4()
   find_task_by_pid: called by LOTS of functions including scheduler!

-- Generally, the existing functions should behave faster in the
average case because N/1024 for most users will be just one step.
On the other hand, this solution seems more *elegant*.

-- I kept the interface functions the same so the only changes are
in <linux/sched.h>.  The function is still called hash_pid although
no hashing is done in reallity.

-- Because the existing schema is good and fast for the average
user, the patch adds the log(n) code with conditional compilation.
If LOG_N_PID is not defined somewhere, the good old hash table will
be compiled.

Finally, I'm following the rule that sais:
  Do not compose a message for a PATCH, if not running in a
  kernel PATCHED by the code you're about to post.
In other words, I should've oopsed by now if it was broken.


SHORT DESCRIPTION OF INT-TREE
-----------------------------

Each node's position in the tree is determined by an integer
value (the PID in our case).  The bits of the integer specify
the node's position, where '0' is 'left' and '1' right.

For example, the integer 00101, will go r,l,r,l,l until an empty slot if found.
The LSB therefore is used for comparison with the root of the tree.

Each integer carries it's tree path along.
The depth of the tree will never exceed 32 (in the case of 32-bit and as
long as duplicate PIDs are not allowed).

In order to remove a node, any node can can replace the node
to be removed, as long as:
  - It it below it
  - It is a terminal node
Because they have the same path and no other node's position
in the tree is changed.


If you like it, apply.

CC me to reply.


I hope I didn't miss something obvious,

Stelios



patch follows

WARNING: You must define LOG_N_PID somewhere. In other case compilation
will fail with an #error directive (no patch to insert the definition
of LOG_N_PID in config and to make sure you run it).

################################################
## ## ## ## ## Patch : sched.h ## ## ## ## ## ##
################################################

--- linux-2.4.20/include/linux/sched.h	2003-01-17 14:58:48.000000000 -0800
+++ Hacked/linux-2.4.20/include/linux/sched.h	2003-01-17 16:24:42.000000000 -0800
@@ -356,7 +356,11 @@
 
 	/* PID hash table linkage. */
 	struct task_struct *pidhash_next;
+#ifdef LOG_N_PID
+	struct task_struct *pidhash_prev;
+#else
 	struct task_struct **pidhash_pprev;
+#endif
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
@@ -527,7 +531,110 @@
 extern struct   mm_struct init_mm;
 extern struct task_struct *init_tasks[NR_CPUS];
 
-/* PID hashing. (shouldnt this be dynamic?) */
+#ifdef LOG_N_PID
+/* PID pool. log(N) insert, find, remove */
+
+extern struct task_struct *pid_tree;
+
+static inline void hash_pid (struct task_struct *p)
+{
+	pid_t pid = p->pid;
+	struct task_struct *n;
+	int cbit;
+
+	p->pidhash_next = p->pidhash_prev = NULL;
+
+	if (!(n = pid_tree)) {
+		pid_tree = p;
+		return;
+	}
+
+	for (cbit = 1; ; cbit <<= 1)
+		if ((pid & cbit))
+			if (n->pidhash_next) n = n->pidhash_next;
+			else {
+				n->pidhash_next = p;
+				break;
+			}
+		else
+			if (n->pidhash_prev) n = n->pidhash_prev;
+			else {
+				n->pidhash_prev = p;
+				break;
+			}
+}
+
+static inline void unhash_pid (struct task_struct *p)
+{
+	/* Any node can replace the node to be removed
+	 * As long as: it is below it and it is a terminal node
+	 * because they have the same path and no other node's
+	 * position in the tree is changed
+	 */
+	pid_t pid = p->pid;
+	struct task_struct *n = pid_tree, **np, *tp;
+	int cbit, prand = (int) pid;
+
+	/* We assume that *pid_tree stores
+	 * the pid 1 of init which will always be present
+	 */
+
+	/* Find parent of p */
+	for (cbit = 1; n; cbit <<= 1)
+		if (pid & cbit)
+			if (n->pidhash_next != p) n = n->pidhash_next;
+			else break;
+		else
+			if (n->pidhash_prev != p) n = n->pidhash_prev;
+			else break;
+
+	if (!n) return;
+	np = (pid & cbit) ? &n->pidhash_next : &n->pidhash_prev;
+
+	/* p is a terminal node */
+	if (!p->pidhash_next && !p->pidhash_prev) {
+		*np = NULL;
+		return;
+	}
+
+	/* Find terminal node below p */
+	tp = n = p;
+	while (n->pidhash_next || n->pidhash_prev) {
+		tp = n;
+		if (!n->pidhash_next) n = n->pidhash_prev;
+		else if (!n->pidhash_prev) n = n->pidhash_next;
+		else {
+			/* we want random choice here. better? */
+			prand *= (prand & 7) + 3;
+			n = (prand & 2) ? n->pidhash_next : n->pidhash_prev;
+		}
+	}
+
+	/* parent of terminal node now points to NULL */
+	if (tp->pidhash_next == n) tp->pidhash_next = NULL;
+	else tp->pidhash_prev = NULL;
+	/* parent of p now points to the terminal node */
+	*np = n;
+	/* terminal node gets the child nodes of p */
+	n->pidhash_next = p->pidhash_next;
+	n->pidhash_prev = p->pidhash_prev;
+}
+
+static inline struct task_struct *find_task_by_pid(int pid)
+{
+	struct task_struct *n = pid_tree;
+	int cbit;
+
+	for (cbit = 1; n; cbit <<= 1) {
+		if (n->pid == pid) return n;
+		n = (pid & cbit) ? n->pidhash_next : n->pidhash_prev;
+	}
+
+	return NULL;
+}
+
+#else
+#error "NOt COMPILED"
 #define PIDHASH_SZ (4096 >> 2)
 extern struct task_struct *pidhash[PIDHASH_SZ];
 
@@ -560,6 +667,8 @@
 	return p;
 }
 
+#endif
+
 #define task_has_cpu(tsk) ((tsk)->cpus_runnable != ~0UL)
 
 static inline void task_set_cpu(struct task_struct *tsk, unsigned int cpu)

###################################################
## ## ## ## ## ## patch fork.c ## ## ## ## ## ## ##
###################################################

--- linux-2.4.20/kernel/fork.c	2002-11-28 15:53:15.000000000 -0800
+++ Hacked/linux-2.4.20/kernel/fork.c	2003-01-17 14:17:31.000000000 -0800
@@ -36,7 +36,11 @@
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 int last_pid;
 
+#ifdef LOG_N_PID
+struct task_struct *pid_tree;
+#else
 struct task_struct *pidhash[PIDHASH_SZ];
+#endif
 
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {


####################################################
## ## ## ## ## ## patch sched.c ## ## ## ## ## ## ##
####################################################

--- linux-2.4.20/kernel/sched.c	2002-11-28 15:53:15.000000000 -0800
+++ Hacked/linux-2.4.20/kernel/sched.c	2003-01-17 14:30:28.000000000 -0800
@@ -1342,8 +1342,12 @@
 
 	init_task.processor = cpu;
 
+#ifdef LOG_N_PID
+	pid_tree = NULL;
+#else
 	for(nr = 0; nr < PIDHASH_SZ; nr++)
 		pidhash[nr] = NULL;
+#endif
 
 	init_timervecs();
 
####################################################
## ## ## ## ## ## patch ksyms.c ## ## ## ## ## ## ##
####################################################

--- linux-2.4.20/kernel/ksyms.c	2002-11-28 15:53:15.000000000 -0800
+++ Hacked/linux-2.4.20/kernel/ksyms.c	2003-01-17 14:32:55.000000000 -0800
@@ -575,7 +575,11 @@
 EXPORT_SYMBOL(init_task_union);
 
 EXPORT_SYMBOL(tasklist_lock);
+#ifdef LOG_N_PID
+EXPORT_SYMBOL(pid_tree);
+#else
 EXPORT_SYMBOL(pidhash);
+#endif
 
 /* debug */
 EXPORT_SYMBOL(dump_stack);

