Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314694AbSDTR4j>; Sat, 20 Apr 2002 13:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314696AbSDTR4i>; Sat, 20 Apr 2002 13:56:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31170 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314694AbSDTR4g>;
	Sat, 20 Apr 2002 13:56:36 -0400
Date: Sat, 20 Apr 2002 13:56:35 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] (1/5) sane procfs/dcache interaction
Message-ID: <Pine.GSO.4.21.0204201304150.25383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Contents:

1) takes unhash_process() into sched.c, moves zeroing ->pid into it (and
   under tasklist_lock

2) new helper in fs/proc/base.c - name_to_int(dentry) returns ~0U if name
   doesn't match 0|[1-9][0-9]* or is too large.  Otherwise it returns
   numeric value of name.  proc_pid_lookup() and proc_lookupfd() converted.

3) sane dentry retention.  Namely, we don't kill /proc/<pid> dentries at the
   first opportunity (as the current tree does).  Instead we do the following:
	* ->d_delete() kills it only if process is already dead.
	* all ->lookup() in proc/base.c end with checking if process is still
	  alive and unhash if it isn't.
	* proc_pid_lookup() (lookup for /proc/<pid>) caches reference to dentry
	  in task_struct.  It's _not_ counted in ->d_count.
	* ->d_iput() resets said reference to NULL.
	* release_task() (burying a zombie) checks if there is a cached
	  reference and if there is - shrinks the subtree.
	* tasklist_lock is used for exclusion.
   That way we are guaranteed that after release_task() all dentries in
   /proc/<pid> will go away as soon as possible; OTOH, before release_task()
   we have normal retention policy - they go away under memory pressure with
   the same rules as for dentries on any other fs.

4) preparation to sane policy for /proc/<pid>/fd/* - we don't store
   struct file * in these inodes anymore.

5) sane retention policy for /proc/<pid>/fd/* - ->d_revalidate() says
   "kill it" if descriptor is not opened anymore (in addition to checks
   for task being dead) and we allow dentries of /proc/<pid>/fd/<n> to
   stay around.

Patchset eliminates a _lot_ of allocation/freeing/guaranteed negative dcache
lookups for procfs.  It seems to be working here, but I would really appreciate
help with testing/review.

First chunk follows, the rest will go in separate mails.

diff -urN C8-0/include/linux/sched.h C8-unhash_process/include/linux/sched.h
--- C8-0/include/linux/sched.h	Sun Apr 14 17:53:12 2002
+++ C8-unhash_process/include/linux/sched.h	Fri Apr 19 01:16:35 2002
@@ -769,15 +769,7 @@
 
 #define thread_group_leader(p)	(p->pid == p->tgid)
 
-static inline void unhash_process(struct task_struct *p)
-{
-	write_lock_irq(&tasklist_lock);
-	nr_threads--;
-	unhash_pid(p);
-	REMOVE_LINKS(p);
-	list_del(&p->thread_group);
-	write_unlock_irq(&tasklist_lock);
-}
+extern void unhash_process(struct task_struct *p);
 
 /* Protects ->fs, ->files, ->mm, and synchronises with wait4().  Nests inside tasklist_lock */
 static inline void task_lock(struct task_struct *p)
diff -urN C8-0/kernel/exit.c C8-unhash_process/kernel/exit.c
--- C8-0/kernel/exit.c	Sun Apr 14 17:53:13 2002
+++ C8-unhash_process/kernel/exit.c	Fri Apr 19 01:16:35 2002
@@ -27,6 +27,17 @@
 
 int getrusage(struct task_struct *, int, struct rusage *);
 
+static inline void __unhash_process(struct task_struct *p)
+{
+	write_lock_irq(&tasklist_lock);
+	nr_threads--;
+	unhash_pid(p);
+	REMOVE_LINKS(p);
+	list_del(&p->thread_group);
+	p->pid = 0;
+	write_unlock_irq(&tasklist_lock);
+}
+
 static void release_task(struct task_struct * p)
 {
 	if (p == current)
@@ -43,8 +54,14 @@
 	current->cmaj_flt += p->maj_flt + p->cmaj_flt;
 	current->cnswap += p->nswap + p->cnswap;
 	sched_exit(p);
-	p->pid = 0;
 	put_task_struct(p);
+}
+
+/* we are using it only for SMP init */
+
+void unhash_process(struct task_struct *p)
+{
+	return __unhash_process(p);
 }
 
 /*

