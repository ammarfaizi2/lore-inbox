Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262501AbTDAMdc>; Tue, 1 Apr 2003 07:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbTDAMdc>; Tue, 1 Apr 2003 07:33:32 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:64746 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S262501AbTDAMd0>;
	Tue, 1 Apr 2003 07:33:26 -0500
Date: Tue, 1 Apr 2003 14:51:59 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: linux-kernel@vger.kernel.org
Subject: fairsched + O(1) process scheduler
Message-ID: <20030401125159.GA8005@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is a forward port of the fairsched-2.4.19 patch by Rik van Riel, which
ensures all competing users get an equal share of cpu time.

Since the earlier patch applied to the classic O(n) process scheduler,
and this one applies to the standard 2.5 O(1) one, the mapping isn't
one-to-one but rather more complex.

Original 2.4.19 version:       Rik van Riel, riel@surriel.com
Forward ported 2.5.66 version: Antonio Vargas, wind@cocodriloo.com


 include/linux/sched.h  |    4 ++++
 include/linux/sysctl.h |    1 +
 kernel/sched.c         |   11 +++++++++++
 kernel/sysctl.c        |    3 +++
 kernel/user.c          |   10 +++++++++-
 5 files changed, 28 insertions(+), 1 deletion(-)

diff -puN include/linux/sched.h~fairsched-A0 include/linux/sched.h
--- 25/include/linux/sched.h~fairsched-A0	Tue Apr  1 14:46:21 2003
+++ 25-wind/include/linux/sched.h	Tue Apr  1 14:46:21 2003
@@ -280,6 +280,10 @@ struct user_struct {
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
 	uid_t uid;
+
+	/* List maintenance information */
+	struct list_head uid_list;
+	unsigned long ticks;	/* How many ticks has received the user */
 };
 
 #define get_current_user() ({ 				\
diff -puN include/linux/sysctl.h~fairsched-A0 include/linux/sysctl.h
--- 25/include/linux/sysctl.h~fairsched-A0	Tue Apr  1 14:46:21 2003
+++ 25-wind/include/linux/sysctl.h	Tue Apr  1 14:46:21 2003
@@ -129,6 +129,7 @@ enum
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+  	KERN_FAIRSCHED=57,	/* int: turn per-user fair cpu scheduler on/off */
 };
 
 
diff -puN kernel/sched.c~fairsched-A0 kernel/sched.c
--- 25/kernel/sched.c~fairsched-A0	Tue Apr  1 14:46:21 2003
+++ 25-wind/kernel/sched.c	Tue Apr  1 14:46:21 2003
@@ -33,6 +33,13 @@
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
 
+/*
+ * turn per-user fair scheduler on/off
+ */
+
+int fairsched = 1;
+
+
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
 #else
@@ -316,6 +323,10 @@ static int effective_prio(task_t *p)
 
 	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+
+	if(fairsched){
+		/* special processing for per-user fair scheduler */
+	}
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
diff -puN kernel/sysctl.c~fairsched-A0 kernel/sysctl.c
--- 25/kernel/sysctl.c~fairsched-A0	Tue Apr  1 14:46:21 2003
+++ 25-wind/kernel/sysctl.c	Tue Apr  1 14:46:21 2003
@@ -57,6 +57,7 @@ extern char core_pattern[];
 extern int cad_pid;
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
+extern int fairsched;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -263,6 +264,8 @@ static ctl_table kern_table[] = {
 #endif
 	{KERN_PIDMAX, "pid_max", &pid_max, sizeof (int),
 	 0600, NULL, &proc_dointvec},
+	{KERN_FAIRSCHED,"fairsched",
+	 &fairsched,sizeof(int),0644,NULL,&proc_dointvec},
 	{0}
 };
 
diff -puN kernel/user.c~fairsched-A0 kernel/user.c
--- 25/kernel/user.c~fairsched-A0	Tue Apr  1 14:46:21 2003
+++ 25-wind/kernel/user.c	Tue Apr  1 14:47:09 2003
@@ -27,10 +27,13 @@ static kmem_cache_t *uid_cachep;
 static struct list_head uidhash_table[UIDHASH_SZ];
 static spinlock_t uidhash_lock = SPIN_LOCK_UNLOCKED;
 
+static struct list_head user_list;
+
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
-	.files		= ATOMIC_INIT(0)
+	.files		= ATOMIC_INIT(0),
+	.ticks		= NICE_TO_PRIO(0)
 };
 
 /*
@@ -39,10 +42,12 @@ struct user_struct root_user = {
 static inline void uid_hash_insert(struct user_struct *up, struct list_head *hashent)
 {
 	list_add(&up->uidhash_list, hashent);
+	list_add(&up->uid_list, &user_list);
 }
 
 static inline void uid_hash_remove(struct user_struct *up)
 {
+	list_del(&up->uid_list);
 	list_del(&up->uidhash_list);
 }
 
@@ -97,6 +102,7 @@ struct user_struct * alloc_uid(uid_t uid
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		atomic_set(&new->ticks, NICE_TO_PRIO(0));
 
 		/*
 		 * Before adding this, check whether we raced
@@ -146,6 +152,8 @@ static int __init uid_cache_init(void)
 
 	for(n = 0; n < UIDHASH_SZ; ++n)
 		INIT_LIST_HEAD(uidhash_table + n);
+
+	INIT_LIST_HEAD(&user_list);
 
 	/* Insert the root user immediately - init already runs with this */
 	uid_hash_insert(&root_user, uidhashentry(0));

_
