Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316164AbSEJNSa>; Fri, 10 May 2002 09:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316165AbSEJNS3>; Fri, 10 May 2002 09:18:29 -0400
Received: from holomorphy.com ([66.224.33.161]:47755 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316164AbSEJNS0>;
	Fri, 10 May 2002 09:18:26 -0400
Date: Fri, 10 May 2002 06:17:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: [PATCH] convert pidhash to list_t
Message-ID: <20020510131707.GY32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <20020510044023.GX32767@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 09:40:23PM -0700, William Lee Irwin III wrote:
> This patch converts the pidhash to use list_t and (somewhat) dynamically
> sizes it (as suggested by the comment). Against latest Linux bk.
> Also available from
> 	bk://linux-wli.bkbits.net/linux-wli-2.5

d'oh!!!


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.530   -> 1.532  
#	      kernel/ksyms.c	1.83    -> 1.84   
#	       kernel/fork.c	1.43    -> 1.44   
#	include/linux/sched.h	1.55    -> 1.56   
#	      kernel/sched.c	1.73    -> 1.75   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/09	wli@holomorphy.com	1.531
# Cleanup of pidhash to use list_t for list linkage.
# --------------------------------------------
# 02/05/10	wli@holomorphy.com	1.532
# Actually bootmem alloc the pidhash table.
# --------------------------------------------
#
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri May 10 06:16:06 2002
+++ b/include/linux/sched.h	Fri May 10 06:16:06 2002
@@ -283,8 +283,7 @@
 	struct list_head thread_group;
 
 	/* PID hash table linkage. */
-	struct task_struct *pidhash_next;
-	struct task_struct **pidhash_pprev;
+	list_t pidhash_list;
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
@@ -420,37 +419,37 @@
 extern struct   mm_struct init_mm;
 extern struct task_struct *init_tasks[NR_CPUS];
 
-/* PID hashing. (shouldnt this be dynamic?) */
-#define PIDHASH_SZ (4096 >> 2)
-extern struct task_struct *pidhash[PIDHASH_SZ];
+/* PID hashing. */
+extern list_t *pidhash;
+extern unsigned long pidhash_size;
 
-#define pid_hashfn(x)	((((x) >> 8) ^ (x)) & (PIDHASH_SZ - 1))
+static inline unsigned pid_hashfn(pid_t pid)
+{
+	return ((pid >> 8) ^ pid) & (pidhash_size - 1);
+}
 
 static inline void hash_pid(struct task_struct *p)
 {
-	struct task_struct **htable = &pidhash[pid_hashfn(p->pid)];
-
-	if((p->pidhash_next = *htable) != NULL)
-		(*htable)->pidhash_pprev = &p->pidhash_next;
-	*htable = p;
-	p->pidhash_pprev = htable;
+	list_add(&p->pidhash_list, &pidhash[pid_hashfn(p->pid)]);
 }
 
 static inline void unhash_pid(struct task_struct *p)
 {
-	if(p->pidhash_next)
-		p->pidhash_next->pidhash_pprev = p->pidhash_pprev;
-	*p->pidhash_pprev = p->pidhash_next;
+	list_del(&p->pidhash_list);
 }
 
-static inline struct task_struct *find_task_by_pid(int pid)
+static inline task_t *find_task_by_pid(int pid)
 {
-	struct task_struct *p, **htable = &pidhash[pid_hashfn(pid)];
+	list_t *p, *pid_list = &pidhash[pid_hashfn(pid)];
+
+	list_for_each(p, pid_list) {
+		task_t *t = list_entry(p, task_t, pidhash_list);
 
-	for(p = *htable; p && p->pid != pid; p = p->pidhash_next)
-		;
+		if(t->pid == pid)
+			return t;
+	}
 
-	return p;
+	return NULL;
 }
 
 /* per-UID process charging. */
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri May 10 06:16:06 2002
+++ b/kernel/fork.c	Fri May 10 06:16:06 2002
@@ -44,7 +44,8 @@
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 int last_pid;
 
-struct task_struct *pidhash[PIDHASH_SZ];
+list_t *pidhash;
+unsigned long pidhash_size;
 
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Fri May 10 06:16:06 2002
+++ b/kernel/ksyms.c	Fri May 10 06:16:06 2002
@@ -588,3 +588,4 @@
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+EXPORT_SYMBOL(pidhash_size);
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri May 10 06:16:06 2002
+++ b/kernel/sched.c	Fri May 10 06:16:06 2002
@@ -1581,7 +1581,21 @@
 void __init sched_init(void)
 {
 	runqueue_t *rq;
-	int i, j, k;
+	int i, j, k, size = PAGE_SIZE*sizeof(list_t);
+
+	do {
+		pidhash = (list_t *)alloc_bootmem(size);
+		if (!pidhash)
+			size >>= 1;
+	} while (!pidhash && size >= sizeof(list_t));
+
+	if (!pidhash)
+		panic("Failed to allocated pid hash table!\n");
+
+	for (i = 0; i < pidhash_size; ++i)
+		INIT_LIST_HEAD(&pidhash[i]);
+
+	pidhash_size = size/sizeof(list_t);
 
 	for (i = 0; i < NR_CPUS; i++) {
 		runqueue_t *rq = cpu_rq(i);
