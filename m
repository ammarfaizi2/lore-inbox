Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319064AbSHSU2K>; Mon, 19 Aug 2002 16:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319065AbSHSU2K>; Mon, 19 Aug 2002 16:28:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36295 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319064AbSHSU2G>;
	Mon, 19 Aug 2002 16:28:06 -0400
Date: Mon, 19 Aug 2002 22:33:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <Pine.LNX.4.33.0208191305130.1758-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208192207130.1528-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Linus Torvalds wrote:

> I actually did the pid changes partly to flush out problems spots, on
> purpose making it 30 bits even though I actually eventually still think
> that we may want to use a few bits for things like node ID numbers etc.

lets hope those systems will be 64-bit? But i guess it's too late,
considering the Summit stuff.

> > if that is the case then can i rip all the non-IPC_64 parts out of ipc/*,
> > and let non-IPC_64 calls fail? Right now it's silent breakage that
> > happens.
> 
> Add a warning for now, the same way we did with stat() etc when moving
> to 64 bits.

Ulrich says that glibc 2.2 and upwards already warns about this and is
able to filter all invalid uses of PIDs, so the kernel does not have to
worry about this too much.

> > or, in my threading tree, i introduced a /proc/sys/kernel/pid_max tunable,
> > which has the safe conservative value of 32K PIDs, but which can be
> > changed by the admin to have higher PIDs.
> 
> Fair enough.

(tested) patch attached. It must be used 'with some care' - eg. setting
pid_max to 0 can result in expected behavior, but i dont think we should
overdo this too much.

the patch also increases the pidhash to 8K entries, from 1K entries.

the patch also includes a temporary debugging aid: after starting the
first 300 tasks the kernel jumps PID allocation to max_pid/2 - it does
this once after bootup. This way hopefully we catch more code (and catch
it quicker) than with the previous allocation method.

	Ingo

--- linux/include/linux/sched.h.orig2	Mon Aug 19 22:18:02 2002
+++ linux/include/linux/sched.h	Mon Aug 19 22:18:45 2002
@@ -449,7 +449,7 @@
 extern struct   mm_struct init_mm;
 
 /* PID hashing. (shouldnt this be dynamic?) */
-#define PIDHASH_SZ (4096 >> 2)
+#define PIDHASH_SZ 8192
 extern struct task_struct *pidhash[PIDHASH_SZ];
 
 #define pid_hashfn(x)	((((x) >> 8) ^ (x)) & (PIDHASH_SZ - 1))
--- linux/include/linux/sysctl.h.orig2	Mon Aug 19 22:22:42 2002
+++ linux/include/linux/sysctl.h	Mon Aug 19 22:23:14 2002
@@ -127,6 +127,7 @@
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
+	KERN_PIDMAX=55,		/* int: PID # limit */
 };
 
 
--- linux/kernel/sysctl.c.orig2	Mon Aug 19 22:23:22 2002
+++ linux/kernel/sysctl.c	Mon Aug 19 22:24:08 2002
@@ -51,6 +51,7 @@
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int cad_pid;
+extern int pid_max;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -255,6 +256,8 @@
 	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",
 	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},
 #endif
+	{KERN_PIDMAX, "pid_max", &pid_max, sizeof (int),
+	 0600, NULL, &proc_dointvec},
 	{0}
 };
 
--- linux/kernel/fork.c.orig2	Mon Aug 19 22:13:11 2002
+++ linux/kernel/fork.c	Mon Aug 19 22:30:58 2002
@@ -46,6 +46,14 @@
 
 int max_threads;
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
+
+/*
+ * Protects next_safe, last_pid and pid_max:
+ */
+spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
+
+static int next_safe = DEFAULT_PID_MAX;
+int pid_max = DEFAULT_PID_MAX;
 int last_pid;
 
 struct task_struct *pidhash[PIDHASH_SZ];
@@ -151,46 +159,57 @@
 	return tsk;
 }
 
-spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
-
 static int get_pid(unsigned long flags)
 {
-	static int next_safe = PID_MAX;
 	struct task_struct *p;
+	static int once = 1;
 	int pid;
 
 	if (flags & CLONE_IDLETASK)
 		return 0;
 
 	spin_lock(&lastpid_lock);
-	if((++last_pid) & ~PID_MASK) {
+	if (++last_pid > pid_max) {
 		last_pid = 300;		/* Skip daemons etc. */
 		goto inside;
 	}
-	if(last_pid >= next_safe) {
+	/*
+	 * Temporary debugging code: we increase the PID after
+	 * starting the first 300 tasks, to make sure all code
+	 * that breaks due to larger PIDs does indeed break,
+	 * well before kernel 2.6.
+	 */
+	if (unlikely(once)) {
+		if (last_pid > 300) {
+			once = 0;
+			last_pid = pid_max/2;
+		}
+	}
+
+	if (last_pid >= next_safe) {
 inside:
-		next_safe = PID_MAX;
+		next_safe = pid_max;
 		read_lock(&tasklist_lock);
 	repeat:
 		for_each_task(p) {
-			if(p->pid == last_pid	||
+			if (p->pid == last_pid	||
 			   p->pgrp == last_pid	||
 			   p->tgid == last_pid	||
 			   p->session == last_pid) {
-				if(++last_pid >= next_safe) {
-					if(last_pid & ~PID_MASK)
+				if (++last_pid >= next_safe) {
+					if (last_pid >= pid_max)
 						last_pid = 300;
-					next_safe = PID_MAX;
+					next_safe = pid_max;
 				}
 				goto repeat;
 			}
-			if(p->pid > last_pid && next_safe > p->pid)
+			if (p->pid > last_pid && next_safe > p->pid)
 				next_safe = p->pid;
-			if(p->pgrp > last_pid && next_safe > p->pgrp)
+			if (p->pgrp > last_pid && next_safe > p->pgrp)
 				next_safe = p->pgrp;
-			if(p->tgid > last_pid && next_safe > p->tgid)
+			if (p->tgid > last_pid && next_safe > p->tgid)
 				next_safe = p->tgid;
-			if(p->session > last_pid && next_safe > p->session)
+			if (p->session > last_pid && next_safe > p->session)
 				next_safe = p->session;
 		}
 		read_unlock(&tasklist_lock);
@@ -231,7 +250,7 @@
 		struct file *file;
 
 		retval = -ENOMEM;
-		if(mpnt->vm_flags & VM_DONTCOPY)
+		if (mpnt->vm_flags & VM_DONTCOPY)
 			continue;
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
@@ -944,12 +963,12 @@
 	vm_area_cachep = kmem_cache_create("vm_area_struct",
 			sizeof(struct vm_area_struct), 0,
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
-	if(!vm_area_cachep)
+	if (!vm_area_cachep)
 		panic("vma_init: Cannot alloc vm_area_struct SLAB cache");
 
 	mm_cachep = kmem_cache_create("mm_struct",
 			sizeof(struct mm_struct), 0,
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
-	if(!mm_cachep)
+	if (!mm_cachep)
 		panic("vma_init: Cannot alloc mm_struct SLAB cache");
 }

