Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTFFMqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 08:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTFFMqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 08:46:18 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:978 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S261328AbTFFMqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 08:46:11 -0400
Subject: [RFC][PATCH 2.5.70] Dynamically tunable maxusers, maxuprc and
	max_pt_cnt
From: Arvind Kandhare <arvind.kan@wipro.com>
To: linux-kernel@vger.kernel.org
Cc: indou.takao@jp.fujitsu.com, akpm@zip.com.au, ahaas@airmail.net,
       dalecki@evision-ventures.com, ezolt@perf.zko.dec.com,
       rob.naccarato@sheridanc.on.ca, Dave@imladris.demon.co.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 06 Jun 2003 18:28:17 +0530
Message-Id: <1054904298.18303.26.camel@m2-arvind>
Mime-Version: 1.0
X-OriginalArrivalTime: 06 Jun 2003 12:58:59.0884 (UTC) FILETIME=[65C08EC0:01C32C2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is the patch(RFC) for dynamically tuning the:

1.  maximum number of user using the system at any point of time
(maxusers)

2. maximum number of processes a user is running at any point of time
(maxuprc) 

3. maximum number of pseudo terminals that can be open at any point of
time (max_pt_cnt).

Please give your comments/suggestion.

cheers,
Arvind 

P.S. Please get back if the patch is not readable. I'm using evolution
to send this mail and made sure that it is configured to work properly. 

diff -Naur linux-2.5.70/drivers/char/pty.c linux-2.5.70.n/drivers/char/pty.c
--- linux-2.5.70/drivers/char/pty.c	Tue May 27 06:30:28 2003
+++ linux-2.5.70.n/drivers/char/pty.c	Thu Jun  5 19:45:29 2003
@@ -50,6 +50,10 @@
 static struct termios *ttyp_termios_locked[NR_PTYS];
 static struct pty_struct pty_state[NR_PTYS];
 
+static spinlock_t pt_count_lock=SPIN_LOCK_UNLOCKED;
+static int pt_count=0;
+
+
 #ifdef CONFIG_UNIX98_PTYS
 /* These are global because they are accessed in tty_io.c */
 struct tty_driver ptm_driver;
@@ -62,6 +66,10 @@
 static struct termios *pts_termios[UNIX98_NR_MAJORS*NR_PTYS];
 static struct termios *pts_termios_locked[UNIX98_NR_MAJORS*NR_PTYS];
 static struct pty_struct ptm_state[UNIX98_NR_MAJORS*NR_PTYS];
+int max_pt_cnt = 2304;
+#else
+int max_pt_cnt = 256;
+
 #endif
 
 static void pty_close(struct tty_struct * tty, struct file * filp)
@@ -71,6 +79,12 @@
 	if (tty->driver->subtype == PTY_TYPE_MASTER) {
 		if (tty->count > 1)
 			printk("master pty_close: count = %d!!\n", tty->count);
+		if(test_bit(TTY_THROTTLED,&tty->flags)) {
+			spin_lock(&pt_count_lock);
+			pt_count--;
+			spin_unlock(&pt_count_lock);
+		}
+
 	} else {
 		if (tty->count > 2)
 			return;
@@ -318,7 +332,16 @@
 		goto out;
 	if (tty->link->count != 1)
 		goto out;
-
+	spin_lock(&pt_count_lock);
+	if(!test_bit(TTY_THROTTLED,&tty->flags) &&
+	tty->driver->subtype == PTY_TYPE_MASTER) {
+		if(pt_count >=max_pt_cnt) {
+			spin_unlock(&pt_count_lock);
+			goto out;
+		}
+		pt_count++;
+		spin_unlock(&pt_count_lock);
+	}
 	clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
 	wake_up_interruptible(&pty->open_wait);
 	set_bit(TTY_THROTTLED, &tty->flags);
diff -Naur linux-2.5.70/include/linux/sched.h linux-2.5.70.n/include/linux/sched.h
--- linux-2.5.70/include/linux/sched.h	Tue May 27 06:30:23 2003
+++ linux-2.5.70.n/include/linux/sched.h	Fri Jun  6 08:50:32 2003
@@ -528,7 +528,7 @@
 /* per-UID process charging. */
 extern struct user_struct * alloc_uid(uid_t);
 extern void free_uid(struct user_struct *);
-extern void switch_uid(struct user_struct *);
+extern int switch_uid(struct user_struct *);
 
 #include <asm/current.h>

diff -Naur linux-2.5.70/include/linux/sysctl.h linux-2.5.70.n/include/linux/sysctl.h
--- linux-2.5.70/include/linux/sysctl.h	Tue May 27 06:30:40 2003
+++ linux-2.5.70.n/include/linux/sysctl.h	Thu Jun  5 18:52:54 2003
@@ -130,6 +130,10 @@
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
+	KERN_MAXUSERS=58,       /* int: limit on maximum number of users using the system currently*/
+	KERN_MAXUPRC=59,        /* int: limit on maximum number of user processes per user */
+	KERN_MAX_PT_CNT=60,     /* int: limit on maximum number of pseudo terminal currently open*/
+
 };
 

diff -Naur linux-2.5.70/kernel/exit.c linux-2.5.70.n/kernel/exit.c
--- linux-2.5.70/kernel/exit.c	Tue May 27 06:30:56 2003
+++ linux-2.5.70.n/kernel/exit.c	Thu Jun  5 18:52:54 2003
@@ -30,6 +30,8 @@
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
 
+extern spinlock_t maxuprc_lock;
+
 int getrusage(struct task_struct *, int, struct rusage *);
 
 static void __unhash_process(struct task_struct *p)
@@ -53,8 +55,11 @@
 	struct dentry *proc_dentry;
  
 	BUG_ON(p->state < TASK_ZOMBIE);
- 
-	atomic_dec(&p->user->processes);
+
+        spin_lock(&maxuprc_lock);
+        atomic_dec(&p->user->processes);
+	spin_unlock(&maxuprc_lock);
+
 	spin_lock(&p->proc_lock);
 	proc_dentry = proc_pid_unhash(p);
 	write_lock_irq(&tasklist_lock);
diff -Naur linux-2.5.70/kernel/fork.c linux-2.5.70.n/kernel/fork.c
--- linux-2.5.70/kernel/fork.c	Tue May 27 06:30:23 2003
+++ linux-2.5.70.n/kernel/fork.c	Thu Jun  5 19:16:43 2003
@@ -48,6 +48,9 @@
  */
 int nr_threads;
 
+spinlock_t maxuprc_lock=SPIN_LOCK_UNLOCKED;
+int maxuprc=0x7fffffff;
+
 int max_threads;
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 
@@ -784,7 +787,8 @@
 		goto fork_out;
 
 	retval = -EAGAIN;
-	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur) {
+	spin_lock(&maxuprc_lock);
+	if (atomic_read(&p->user->processes) >= maxuprc || atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur) {
 		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
 			goto bad_fork_free;
 	}
@@ -1010,6 +1014,7 @@
 	retval = 0;
 
 fork_out:
+	spin_unlock(maxuprc_lock);
 	if (retval)
 		return ERR_PTR(retval);
 	return p;
diff -Naur linux-2.5.70/kernel/sys.c linux-2.5.70.n/kernel/sys.c
--- linux-2.5.70/kernel/sys.c	Tue May 27 06:30:23 2003
+++ linux-2.5.70.n/kernel/sys.c	Fri Jun  6 09:21:25 2003
@@ -595,7 +595,7 @@
 	new_user = alloc_uid(new_ruid);
 	if (!new_user)
 		return -EAGAIN;
-	switch_uid(new_user);
+	if(switch_uid(new_user)<0) return -EAGAIN;
 
 	if(dumpclear)
 	{
diff -Naur linux-2.5.70/kernel/sysctl.c linux-2.5.70.n/kernel/sysctl.c
--- linux-2.5.70/kernel/sysctl.c	Tue May 27 06:30:23 2003
+++ linux-2.5.70.n/kernel/sysctl.c	Thu Jun  5 19:16:26 2003
@@ -58,6 +58,10 @@
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
 
+extern int maxusers;
+extern int maxuprc;
+extern int max_pt_cnt;
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -146,6 +150,17 @@
 static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
 #endif
 
+/* Constants for minimum and maximum testing 
+ *    We use these as one-element integer vectors. */
+static int zero = 0;
+static int one = 1;
+static int one_hundred = 100;
+static int maxint=0x7fffffff;
+static int lim_pt_cnt=2304;
+
+
+
+
 /* The default sysctl tables: */
 
 static ctl_table root_table[] = {
@@ -265,15 +280,15 @@
 	 0600, NULL, &proc_dointvec},
 	{KERN_PANIC_ON_OOPS,"panic_on_oops",
 	 &panic_on_oops,sizeof(int),0644,NULL,&proc_dointvec},
+	{KERN_MAXUSERS,"maxusers",
+	&maxusers,sizeof(int),0644,NULL,&proc_dointvec_minmax,NULL,NULL,&zero,NULL},
+	{KERN_MAXUPRC,"maxuprc",
+	&maxuprc,sizeof(int),0644,NULL,&proc_dointvec_minmax,NULL,NULL,&zero,NULL},
+	{KERN_MAX_PT_CNT,"max_pt_cnt",
+	&max_pt_cnt,sizeof(int),0644,NULL,&proc_dointvec_minmax,NULL,NULL,&zero,&lim_pt_cnt},
 	{0}
 };
 
-/* Constants for minimum and maximum testing in vm_table.
-   We use these as one-element integer vectors. */
-static int zero = 0;
-static int one = 1;
-static int one_hundred = 100;
-
 
 static ctl_table vm_table[] = {
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
@@ -368,6 +383,7 @@
 
 void __init sysctl_init(void)
 {
+	lim_pt_cnt = max_pt_cnt;
 #ifdef CONFIG_PROC_FS
 	register_proc_table(root_table, proc_sys_root);
 	init_irq_proc();
diff -Naur linux-2.5.70/kernel/user.c linux-2.5.70.n/kernel/user.c
--- linux-2.5.70/kernel/user.c	Tue May 27 06:30:37 2003
+++ linux-2.5.70.n/kernel/user.c	Fri Jun  6 09:44:52 2003
@@ -27,6 +27,11 @@
 static struct list_head uidhash_table[UIDHASH_SZ];
 static spinlock_t uidhash_lock = SPIN_LOCK_UNLOCKED;
 
+static unsigned int users_count=0;
+int maxusers =0x7fffffff;/*MAXINT*/
+extern spinlock_t user_processes_lock;
+extern int maxuprc;
+
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
@@ -73,6 +78,7 @@
 {
 	if (up && atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
 		uid_hash_remove(up);
+		users_count--;
 		kmem_cache_free(uid_cachep, up);
 		spin_unlock(&uidhash_lock);
 	}
@@ -107,7 +113,13 @@
 		if (up) {
 			kmem_cache_free(uid_cachep, new);
 		} else {
+			if(users_count>=maxusers){
+				spin_unlock(&uidhash_lock);
+				return NULL;
+			}
+
 			uid_hash_insert(new, hashent);
+			users_count++;
 			up = new;
 		}
 		spin_unlock(&uidhash_lock);
@@ -116,7 +128,7 @@
 	return up;
 }
 
-void switch_uid(struct user_struct *new_user)
+int  switch_uid(struct user_struct *new_user)
 {
 	struct user_struct *old_user;
 
@@ -126,11 +138,18 @@
 	 * we should be checking for it.  -DaveM
 	 */
 	old_user = current->user;
+	spin_lock(&user_processes_lock);
+	if (new_user != INIT_USER && (atomic_read(&new_user->processes) >= maxuprc || atomic_read(&new_user->processes) >= current->rlim[RLIMIT_NPROC].rlim_cur)) {
+		spin_unlock(&user_processes_lock);
+		return -1;
+	}
 	atomic_inc(&new_user->__count);
 	atomic_inc(&new_user->processes);
 	atomic_dec(&old_user->processes);
+	spin_unlock(&user_processes_lock);
 	current->user = new_user;
 	free_uid(old_user);
+	return 1;
 }



