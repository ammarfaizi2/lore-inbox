Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbULMOXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbULMOXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbULMOWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:22:54 -0500
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.70]:59985 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261214AbULMOWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:22:19 -0500
Date: Mon, 13 Dec 2004 09:22:17 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: IO Priorities
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: kernel@kolivas.org, axboe@suse.de, nickpiggin@yahoo.com.au
Message-id: <20041213142217.GA22853@optonline.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=oyUTqETQ0mS9luUI;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,
	About a week ago, I said I would try to implement IO priorities.
I tried. I got the whole thing done, but there is one major problem - it
doesn't work the way it is supposed to. For example, I wrote a little
shell script that calls:

time dd if=3D/dev/zero of=3Ddump bs=3D4096 count=3D200000

It calls it twice, once as the highest priority (0) and once as the
lowest priority (39). The only difference (besides the output file) is
the io priority. Nice values are _not_ connected with io prio (at least
not yet.) The only thing that the io_prio affects is the coefficient in
front of the cfq time slice length (see patch). The interesting thing
that happens is that sometimes the lower priority process finishes before
the higher priority one - even though the time slices are WAY way different
in size (1ms and 223ms). Con Kolivas told me that he experienced the same
odd behaviour when he implemented io priorities on top of deadline.

I know the priorities do change the duration of the time slice since I
see that at times certain processes get starved while others at high
priority happily run. This seems to contradict the mesurements with the
4 io tests (see bottom of this email), but it does happen. I am hoping
that I am overlooking something that I need to modify in CFQ, but it
doesn't look that way.

The patch itself requires Jens Axboe's CFQ#4. It is still work in
progress -- it needs a cleanup, and some other things, like adding the
security calls to the new syscalls, and the syscalls have to be added
to other architectures than i386 as well, but those are not critical.

Any ideas?

Jeff.

To call the syscalls I created a few utilities
http://shells.gnugeneration.com/~jeffpc/kernel/v2.6/ioprio_utils.tar.bz2
(b1beeb82155054e7acf5a92628c7efaa  ioprio_utils.tar.bz2)

These are the 4 io tests I used in total:

# reader
time cat dump > /dev/null

# writer
time dd if=3D/dev/zero of=3Ddump bs=3D4096 count=3D200000

# tar (dump.tar =3D=3D 2 built BK kernel trees ~900MB)
time tar xf dump.tar

# tiobench
tiobench --size 800 --numruns 4 --dir /tmp --block 65536 --random 1000
--threads 4


diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	2004-12-13 08:49:48 -05:00
+++ b/arch/i386/kernel/entry.S	2004-12-13 08:49:48 -05:00
@@ -864,5 +864,8 @@
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
+	.long sys_io_prio
+	.long sys_getiopriority		/* 290 */
+	.long sys_setiopriority
=20
 syscall_table_size=3D(.-sys_call_table)
diff -Nru a/drivers/block/cfq-iosched.c b/drivers/block/cfq-iosched.c
--- a/drivers/block/cfq-iosched.c	2004-12-13 08:49:48 -05:00
+++ b/drivers/block/cfq-iosched.c	2004-12-13 08:49:48 -05:00
@@ -33,10 +33,20 @@
 static int cfq_back_max =3D 16 * 1024;	/* maximum backwards seek, in KiB */
 static int cfq_back_penalty =3D 2;	/* penalty of a backwards seek */
=20
-static int cfq_slice_sync =3D HZ / 10;
-static int cfq_slice_async =3D HZ / 25;
+static int cfq_slice_sync =3D HZ / 1000;
+static int cfq_slice_async =3D HZ / 1000;
 static int cfq_slice_async_rq =3D 16;
-static int cfq_slice_idle =3D HZ / 249;
+static int cfq_slice_idle =3D HZ / 1000;
+
+/* the slice scaling factors */
+static int cfq_prio_scale[] =3D {223, 194, 169, 147, 128,		/* 0..4 */
+			       111,  97,  84,  73,  64,		/* 5..9 */
+			        56,  49,  42,  36,  32,		/* 10..14 */
+			        28,  24,  21,  18,  16,		/* 15..19 */
+			        14,  12,  11,   9,   8,		/* 20..24 */
+			         7,   6,   5,   5,   4,		/* 25..29 */
+			         3,   3,   2,   2,   2,		/* 30..34 */
+			         1,   1,   1,   1,   1};	/* 35..39 */
=20
 static int cfq_max_depth =3D 4;
=20
@@ -98,6 +108,9 @@
  */
 #define CFQ_KEY_SPARE		(~0UL)
=20
+#define CFQ_MIN_IO_PRIO		IOPRIO_MIN
+#define CFQ_MAX_IO_PRIO		IOPRIO_MAX
+
 static kmem_cache_t *crq_pool;
 static kmem_cache_t *cfq_pool;
 static kmem_cache_t *cfq_ioc_pool;
@@ -133,6 +146,7 @@
 	struct work_struct unplug_work;
 	struct cfq_queue *active_queue;
 	unsigned int dispatch_slice;
+	unsigned int cfq_prio_scale[(CFQ_MAX_IO_PRIO - CFQ_MIN_IO_PRIO) + 1];
=20
 	/*
 	 * tunables, see top of file
@@ -176,6 +190,7 @@
 	unsigned long last_fifo_expire;
=20
 	int key_type;
+	int io_prio;
=20
 	unsigned long slice_start;
 	unsigned long slice_end;
@@ -912,7 +927,7 @@
 	 * sync, use the sync time slice value
 	 */
 	if (!cfqq->slice_end)
-		cfqq->slice_end =3D cfqd->cfq_slice[!!sync] + jiffies;
+		cfqq->slice_end =3D cfqd->cfq_prio_scale[cfqq->io_prio]*cfqd->cfq_slice[=
!!sync] + jiffies;
=20
 	/*
 	 * expire an async queue immediately if it has used up its slice
@@ -946,7 +961,6 @@
 {
 	struct cfq_queue *cfqq =3D crq->cfq_queue;
 	struct cfq_data *cfqd =3D cfqq->cfqd;
-	unsigned long now, elapsed;
=20
 	if (unlikely(!blk_fs_request(crq->request)))
 		return;
@@ -972,13 +986,13 @@
 		WARN_ON(!cfqd->rq_in_driver);
 		cfqd->rq_in_driver--;
 	}
-
+ =20
 	/*
 	 * queue was preempted while this request was servicing
 	 */
 	if (cfqd->active_queue !=3D cfqq)
 		return;
-
+ =20
 	/*
 	 * this is still the active queue. if we have nothing to do and no
 	 * more pending requests in flight, wait for a new sync request if
@@ -1093,6 +1107,7 @@
 		*cfqq =3D __cfqq;
 	}
=20
+	__cfqq->io_prio =3D current->io_prio;
 	cic->cfqq =3D __cfqq;
 	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
 }
@@ -1744,6 +1759,7 @@
 	cfqd->cfq_slice_async_rq =3D cfq_slice_async_rq;
 	cfqd->cfq_slice_idle =3D cfq_slice_idle;
 	cfqd->cfq_max_depth =3D cfq_max_depth;
+	memcpy(cfqd->cfq_prio_scale, cfq_prio_scale, sizeof(cfq_prio_scale));
=20
 	return 0;
 out_spare:
diff -Nru a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
--- a/include/asm-i386/unistd.h	2004-12-13 08:49:48 -05:00
+++ b/include/asm-i386/unistd.h	2004-12-13 08:49:48 -05:00
@@ -294,8 +294,11 @@
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
+#define __NR_io_prio		289
+#define __NR_getiopriority	290
+#define __NR_setiopriority	291
=20
-#define NR_syscalls 289
+#define NR_syscalls 292
=20
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -Nru a/include/linux/resource.h b/include/linux/resource.h
--- a/include/linux/resource.h	2004-12-13 08:49:48 -05:00
+++ b/include/linux/resource.h	2004-12-13 08:49:48 -05:00
@@ -42,6 +42,10 @@
 	unsigned long	rlim_max;
 };
=20
+#define IOPRIO_MIN	0
+#define IOPRIO_MAX	39
+#define IOPRIO_DEFAULT	20
+
 #define	PRIO_MIN	(-20)
 #define	PRIO_MAX	20
=20
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2004-12-13 08:49:48 -05:00
+++ b/include/linux/sched.h	2004-12-13 08:49:48 -05:00
@@ -664,6 +664,9 @@
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
 #endif
+
+/* io priority */
+	short io_prio;
 };
=20
 static inline pid_t process_group(struct task_struct *tsk)
@@ -723,8 +726,10 @@
=20
 extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
+extern void set_user_ioprio(task_t *p, long ioprio);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
+extern int task_ioprio(const task_t *p);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern unsigned long task_will_schedule_at(const task_t *p);
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	2004-12-13 08:49:48 -05:00
+++ b/include/linux/security.h	2004-12-13 08:49:48 -05:00
@@ -1717,6 +1717,13 @@
 	return security_ops->task_setnice (p, nice);
 }
=20
+static inline int security_task_setioprio (struct task_struct *p, int prio)
+{
+	#warn "Fixme! Add security_ops->task_setprio"
+	return 1;
+	//return security_ops->task_setioprio (p, prio);
+}
+
 static inline int security_task_setrlimit (unsigned int resource,
 					   struct rlimit *new_rlim)
 {
@@ -2353,6 +2360,11 @@
 }
=20
 static inline int security_task_setnice (struct task_struct *p, int nice)
+{
+	return 0;
+}
+
+static inline int security_task_setioprio (struct task_struct *p, int prio)
 {
 	return 0;
 }
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	2004-12-13 08:49:48 -05:00
+++ b/init/main.c	2004-12-13 08:49:48 -05:00
@@ -443,6 +443,7 @@
 static void noinline rest_init(void)
 	__releases(kernel_lock)
 {
+	current->io_prio =3D IOPRIO_DEFAULT;
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
 	unlock_kernel();
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2004-12-13 08:49:48 -05:00
+++ b/kernel/sched.c	2004-12-13 08:49:48 -05:00
@@ -16,6 +16,7 @@
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
  *  2003-09-03	Interactivity tuning by Con Kolivas.
  *  2004-04-02	Scheduler domains code by Nick Piggin
+ *  2004-12-07	IO Priorities
  */
=20
 #include <linux/mm.h>
@@ -63,6 +64,8 @@
 #define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 20)
 #define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
=20
+#define TASK_IOPRIO(p)		((p)->io_prio)
+
 /*
  * 'User priority' is the nice value converted to something we
  * can work with better when scaling various scheduler parameters,
@@ -3024,6 +3027,17 @@
=20
 EXPORT_SYMBOL(set_user_nice);
=20
+void set_user_ioprio(task_t *p, long ioprio)
+{
+	if (TASK_IOPRIO(p) =3D=3D ioprio || ioprio < 0 || ioprio > 39)
+		return;
+=09
+	p->io_prio =3D ioprio;
+	printk(KERN_ERR "task %d now has io_prio =3D %d\n", p->pid, p->io_prio);
+}
+
+EXPORT_SYMBOL(set_user_ioprio);
+
 #ifdef __ARCH_WANT_SYS_NICE
=20
 /*
@@ -3068,6 +3082,35 @@
=20
 #endif
=20
+/*
+ * sys_ioprio - change the io priority of the current process.
+ * @increment: priority increment
+ */
+asmlinkage long sys_io_prio(int increment)
+{
+	long io_prio;
+
+	if (increment < 0) {
+		if (!capable(CAP_SYS_NICE))
+			return -EPERM;
+		if (increment < -40)
+			increment =3D -40;
+	}
+	if (increment > 40)
+		increment =3D 40;
+
+	io_prio =3D current->io_prio + increment;
+	if (io_prio < 0)
+		io_prio =3D 0;
+	if (io_prio > 39)
+		io_prio =3D 39;
+
+#warning "Fixme: add call to security_task_setioprio()"
+
+	set_user_ioprio(current, io_prio);
+	return 0;
+}
+
 /**
  * task_prio - return the priority value of a given task.
  * @p: the task in question.
@@ -3088,6 +3131,15 @@
 int task_nice(const task_t *p)
 {
 	return TASK_NICE(p);
+}
+
+/**
+ * task_ioprio - return the ioprio value of a given task.
+ * @p: the task in question.
+ */
+int task_ioprio(const task_t *p)
+{
+	return TASK_IOPRIO(p);
 }
=20
 /**
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	2004-12-13 08:49:48 -05:00
+++ b/kernel/sys.c	2004-12-13 08:49:48 -05:00
@@ -240,6 +240,23 @@
 	return error;
 }
=20
+static int set_one_ioprio(struct task_struct *p, int prioval, int error)
+{
+	if (p->uid !=3D current->euid &&
+		p->uid !=3D current->uid && !capable(CAP_SYS_NICE)) {
+		error =3D -EPERM;
+		goto out;
+	}
+	if (prioval < task_ioprio(p) && !capable(CAP_SYS_NICE)) {
+		error =3D -EACCES;
+		goto out;
+	}
+	#warning "FIXME: call security_task_setioprio(p, prioval);"
+	set_user_ioprio(p, prioval);
+out:
+	return error;
+}
+
 asmlinkage long sys_setpriority(int which, int who, int niceval)
 {
 	struct task_struct *g, *p;
@@ -357,6 +374,118 @@
 	return retval;
 }
=20
+asmlinkage long sys_setiopriority(int which, int who, int prioval)
+{
+	struct task_struct *g, *p;
+	struct user_struct *user;
+	int error =3D -EINVAL;
+
+	if (which > 2 || which < 0)
+		goto out;
+
+	/* normalize: avoid signed division (rounding problems) */
+	error =3D -ESRCH;
+	if (prioval < 0)
+		prioval =3D 0;
+	if (prioval > 39)
+		prioval =3D 39;
+
+	read_lock(&tasklist_lock);
+	switch (which) {
+		case PRIO_PROCESS:
+			if (!who)
+				who =3D current->pid;
+			p =3D find_task_by_pid(who);
+			if (p) {
+				error =3D set_one_ioprio(p, prioval, error);
+			}
+			break;
+		case PRIO_PGRP:
+			if (!who)
+				who =3D process_group(current);
+			do_each_task_pid(who, PIDTYPE_PGID, p) {
+				error =3D set_one_ioprio(p, prioval, error);
+			} while_each_task_pid(who, PIDTYPE_PGID, p);
+			break;
+		case PRIO_USER:
+			if (!who)
+				user =3D current->user;
+			else
+				user =3D find_user(who);
+
+			if (!user)
+				goto out_unlock;
+
+			do_each_thread(g, p)
+				if (p->uid =3D=3D who) {
+					error =3D set_one_ioprio(p, prioval, error);
+				}
+			while_each_thread(g, p);
+			if (who)
+				free_uid(user);		/* For find_user() */
+			break;
+	}
+out_unlock:
+	read_unlock(&tasklist_lock);
+out:
+	return error;
+}
+
+asmlinkage long sys_getiopriority(int which, int who)
+{
+	struct task_struct *g, *p;
+	struct user_struct *user;
+	long prioval, retval =3D -ESRCH;
+
+	if (which > 2 || which < 0)
+		return -EINVAL;
+
+	read_lock(&tasklist_lock);
+	switch (which) {
+		case PRIO_PROCESS:
+			if (!who)
+				who =3D current->pid;
+			p =3D find_task_by_pid(who);
+			if (p) {
+				prioval =3D task_ioprio(p);
+				if (prioval > retval)
+					retval =3D prioval;
+			}
+			break;
+		case PRIO_PGRP:
+			if (!who)
+				who =3D process_group(current);
+			do_each_task_pid(who, PIDTYPE_PGID, p) {
+				prioval =3D task_ioprio(p);
+				if (prioval > retval)
+					retval =3D prioval;
+			} while_each_task_pid(who, PIDTYPE_PGID, p);
+			break;
+		case PRIO_USER:
+			if (!who)
+				user =3D current->user;
+			else
+				user =3D find_user(who);
+
+			if (!user)
+				goto out_unlock;
+
+			do_each_thread(g, p)
+				if (p->uid =3D=3D who) {
+					prioval =3D task_ioprio(p);
+					if (prioval > retval)
+						retval =3D prioval;
+				}
+			while_each_thread(g, p);
+			if (who)
+				free_uid(user);		/* for find_user() */
+			break;
+	}
+out_unlock:
+	read_unlock(&tasklist_lock);
+
+	return retval;
+}
=20
 /*
  * Reboot system call: for obvious reasons only root may call it,

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBvaWZwFP0+seVj/4RAnrjAJwPwb73wYNzAM3neGehmGsshJNFpgCgr7Ai
zX9pia7Irr8MjGKm/JzKiT8=
=eobB
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
