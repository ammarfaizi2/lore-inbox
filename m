Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbTILI4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 04:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTILI4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 04:56:25 -0400
Received: from shark.pro-futura.com ([161.58.178.219]:45227 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261318AbTILI4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 04:56:16 -0400
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
Date: Fri, 12 Sep 2003 10:58:54 +0200
User-Agent: KMail/1.5.1
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>
In-Reply-To: <200309120219.h8C2JANc004514@penguin.co.intel.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OrYY/FSSkOAWe0t"
Message-Id: <200309121058.54691.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_OrYY/FSSkOAWe0t
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> * Added a very simple (in fact I'm sure too simple) mm/om_panic.c that
>   will panic on any oom condition
>
> The patch works (although by looking over oom_kill.c, I'm sure oom_panic.c
> will panic too soon), but it is really only a quick hack to see how people
> feel about such an approach.

I like it, but who am I to say... No so long ago I made a patch for 2.4.20 
(attached) which extended OOM Killer functionality in a following way: If a 
process of the same parent gets killed more than X times during Y seconds, 
parent gets killed. 

Maybe this kind of module for your patch would be interesting for someone?

Regards,
Tvrtko

--Boundary-00=_OrYY/FSSkOAWe0t
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="xoom-2.4.20.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xoom-2.4.20.patch"

diff -Naur linux-2.4.20/include/linux/sysctl.h linux-2.4.20-xoom/include/linux/sysctl.h
--- linux-2.4.20/include/linux/sysctl.h	2003-06-05 14:07:03.000000000 +0200
+++ linux-2.4.20-xoom/include/linux/sysctl.h	2003-06-09 09:53:25.000000000 +0200
@@ -143,6 +143,8 @@
 	VM_MAX_MAP_COUNT=11,	/* int: Maximum number of active map areas */
 	VM_MIN_READAHEAD=12,    /* Min file readahead */
 	VM_MAX_READAHEAD=13,    /* Max file readahead */
+	VM_OOM_PARENT_MAX=14, /* Max childs per parent oom-killed before we kill the parent */
+	VM_OOM_PARENT_EXPIRE=15 /* Min numbers of seconds before we forget about parents sins */
 };
 
 
diff -Naur linux-2.4.20/kernel/sysctl.c linux-2.4.20-xoom/kernel/sysctl.c
--- linux-2.4.20/kernel/sysctl.c	2002-08-06 09:10:56.000000000 +0200
+++ linux-2.4.20-xoom/kernel/sysctl.c	2003-06-09 09:50:02.000000000 +0200
@@ -50,6 +50,8 @@
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int cad_pid;
+extern unsigned int oom_parent_max;
+extern unsigned int oom_parent_expire;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -267,9 +269,9 @@
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
 	{VM_PAGERDAEMON, "kswapd",
 	 &pager_daemon, sizeof(pager_daemon_t), 0644, NULL, &proc_dointvec},
-	{VM_PGT_CACHE, "pagetable_cache", 
+	{VM_PGT_CACHE, "pagetable_cache",
 	 &pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
-	{VM_PAGE_CLUSTER, "page-cluster", 
+	{VM_PAGE_CLUSTER, "page-cluster",
 	 &page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_MIN_READAHEAD, "min-readahead",
 	&vm_min_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
@@ -277,6 +279,10 @@
 	&vm_max_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_MAX_MAP_COUNT, "max_map_count",
 	 &max_map_count, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_OOM_PARENT_MAX, "oom_parent_max",
+	 &oom_parent_max, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_OOM_PARENT_EXPIRE, "oom_parent_expire",
+	 &oom_parent_expire, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };
 
diff -Naur linux-2.4.20/mm/oom_kill.c linux-2.4.20-xoom/mm/oom_kill.c
--- linux-2.4.20/mm/oom_kill.c	2003-06-05 14:07:04.000000000 +0200
+++ linux-2.4.20-xoom/mm/oom_kill.c	2003-06-09 09:40:04.000000000 +0200
@@ -1,10 +1,13 @@
 /*
  *  linux/mm/oom_kill.c
- * 
+ *
  *  Copyright (C)  1998,2000  Rik van Riel
  *	Thanks go out to Claus Fischer for some serious inspiration and
  *	for goading me into coding this file...
  *
+ *  June 2003 Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
+ *	Extended with parent process statistics and appropriate actions
+ *
  *  The routines in this file are used to kill a process when
  *  we're seriously out of memory. This gets called from kswapd()
  *  in linux/mm/vmscan.c when we really run out of memory.
@@ -21,12 +24,132 @@
 #include <linux/swapctl.h>
 #include <linux/timex.h>
 
+#define OOM_HISTORY_SIZE	32
+
+#define OOM_DEFAULT_VALUE	(10)
+#define OOM_DEFAULT_EXPIRE	(5*60)
+
+struct parent_record
+{
+	pid_t				pid;
+	struct task_struct	*task;
+	unsigned long		first_kill;
+	unsigned long		last_kill;
+	unsigned long		value;
+};
+
+unsigned int	oom_parent_max = OOM_DEFAULT_VALUE;
+unsigned int	oom_parent_expire = OOM_DEFAULT_EXPIRE;
+
+static struct parent_record	kill_history[OOM_HISTORY_SIZE];
+
 /* #define DEBUG */
 
+void oom_kill_task(struct task_struct *p);
+
+static void	process_kill_history(void)
+{
+	struct parent_record	*p;
+	struct task_struct	*task;
+
+	unsigned int	i;
+
+	for ( i = 0; i < OOM_HISTORY_SIZE; i++ )
+	{
+		p = &kill_history[i];
+		if ( p->pid )
+		{
+			task = find_task_by_pid(p->pid);
+			if ( task != p->task )
+			{
+#ifdef DEBUG
+	printk(KERN_DEBUG "OOMkill: parent %d (%p) removed from list - does not exist\n",p->pid, p->task);
+#endif
+				p->pid = 0;
+			}
+			else if ( abs(jiffies - p->last_kill) >= (oom_parent_expire*HZ) )
+			{
+#ifdef DEBUG
+	printk(KERN_DEBUG "OOMkill: parent %d (%p) removed from list - expired\n",p->pid, p->task);
+#endif
+				p->pid = 0;
+			}
+			else if ( p->value >= oom_parent_max )
+			{
+				printk(KERN_ERR "Out of Memory: Will kill parent process %d (%s).\n",p->pid,p->task->comm);
+				p->pid = 0;
+				oom_kill_task(p->task);
+			}
+		}
+	}
+}
+
+static int	find_free_record(void)
+{
+	struct parent_record	*p;
+
+	unsigned int	i;
+
+	for ( i = 0; i < OOM_HISTORY_SIZE; i++ )
+	{
+		p = &kill_history[i];
+		if ( !p->pid )
+			return i;
+	}
+
+	return -1;
+}
+
+static struct parent_record	*find_in_kill_history(struct task_struct *task)
+{
+	struct parent_record	*p = NULL;
+	unsigned int i;
+
+	if ( !task )
+		return NULL;
+
+	for ( i = 0; i < OOM_HISTORY_SIZE; i++ )
+	{
+		p = &kill_history[i];
+		if ( p->pid )
+		{
+			if ( (task->pid == p->pid) && (task == p->task) )
+				return p;
+		}
+	}
+
+	return NULL;
+}
+
+static struct parent_record	*new_parent(struct task_struct *task)
+{
+	struct parent_record	*p;
+	int	i;
+
+	if ( !task )
+		return NULL;
+
+	i = find_free_record();
+
+	if ( i < 0 )
+		return NULL;
+
+	p = &kill_history[i];
+
+	p->pid= task->pid;
+	p->task = task;
+	p->first_kill = jiffies;
+	p->last_kill = jiffies;
+	p->value = 0;
+
+	return p;
+}
+
+
 /**
  * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
  * @x: integer of which to calculate the sqrt
- * 
+ *
  * A very rough approximation to the sqrt() function.
  */
 static unsigned int int_sqrt(unsigned int x)
@@ -35,7 +158,7 @@
 	while (x & ~(unsigned int)1) x >>=2, out >>=1;
 	if (x) out -= out >> 2;
 	return (out ? out : 1);
-}	
+}
 
 /**
  * oom_badness - calculate a numeric value for how bad this task has been
@@ -168,6 +291,7 @@
 static void oom_kill(void)
 {
 	struct task_struct *p, *q;
+	struct parent_record *parent;
 
 	read_lock(&tasklist_lock);
 	p = select_bad_process();
@@ -176,6 +300,19 @@
 	if (p == NULL)
 		panic("Out of memory and no killable processes...\n");
 
+	/* Add or update statistics for a parent processs */
+	if ( p->p_opptr->pid > 1 )
+	{
+		parent = find_in_kill_history(p->p_opptr);
+		if ( !parent )
+			parent = new_parent(p->p_opptr);
+		else
+		{
+			parent->value++;
+			parent->last_kill = jiffies;
+		}
+	}
+
 	/* kill all processes that share the ->mm (i.e. all threads) */
 	for_each_task(q) {
 		if (q->mm == p->mm)
@@ -201,6 +338,11 @@
 	unsigned long now, since;
 
 	/*
+	 * Process kill history...
+	 */
+	process_kill_history();
+
+	/*
 	 * Enough swap space left?  Not OOM.
 	 */
 	if (nr_swap_pages > 0)

--Boundary-00=_OrYY/FSSkOAWe0t--

