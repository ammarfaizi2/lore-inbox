Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbUJ3Oqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUJ3Oqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUJ3OqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:46:24 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:28085 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261190AbUJ3Ohz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:37:55 -0400
Message-ID: <4183A72E.7000802@kolivas.org>
Date: Sun, 31 Oct 2004 00:37:34 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 6/28] Make nice syscalls public
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8709D961ECE8A68383CDF3BB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8709D961ECE8A68383CDF3BB
Content-Type: multipart/mixed;
 boundary="------------080705090803050705080206"

This is a multi-part message in MIME format.
--------------080705090803050705080206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make nice syscalls public


--------------080705090803050705080206
Content-Type: text/x-patch;
 name="publicise_nicestuff.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_nicestuff.diff"

Nice and affinity support can all be made public. Move it to scheduler.c

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:46:54.718650020 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:46:55.943458872 +1000
@@ -2966,50 +2966,6 @@ struct task_struct *kgdb_get_idle(int th
 }
 #endif
 
-#ifdef __ARCH_WANT_SYS_NICE
-
-/*
- * sys_nice - change the priority of the current process.
- * @increment: priority increment
- *
- * sys_setpriority is a more generic, but much slower function that
- * does similar things.
- */
-asmlinkage long sys_nice(int increment)
-{
-	int retval;
-	long nice;
-
-	/*
-	 * Setpriority might change our priority at the same moment.
-	 * We don't have to worry. Conceptually one call occurs first
-	 * and we have a single winner.
-	 */
-	if (increment < 0) {
-		if (!capable(CAP_SYS_NICE))
-			return -EPERM;
-		if (increment < -40)
-			increment = -40;
-	}
-	if (increment > 40)
-		increment = 40;
-
-	nice = PRIO_TO_NICE(current->static_prio) + increment;
-	if (nice < -20)
-		nice = -20;
-	if (nice > 19)
-		nice = 19;
-
-	retval = security_task_setnice(current, nice);
-	if (retval)
-		return retval;
-
-	set_user_nice(current, nice);
-	return 0;
-}
-
-#endif
-
 /**
  * task_prio - return the priority value of a given task.
  * @p: the task in question.
@@ -3161,228 +3117,6 @@ out_nounlock:
 }
 
 /**
- * sys_sched_setscheduler - set/change the scheduler policy and RT priority
- * @pid: the pid in question.
- * @policy: new policy
- * @param: structure containing the new RT priority.
- */
-asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
-				       struct sched_param __user *param)
-{
-	return setscheduler(pid, policy, param);
-}
-
-/**
- * sys_sched_setparam - set/change the RT priority of a thread
- * @pid: the pid in question.
- * @param: structure containing the new RT priority.
- */
-asmlinkage long sys_sched_setparam(pid_t pid, struct sched_param __user *param)
-{
-	return setscheduler(pid, -1, param);
-}
-
-/**
- * sys_sched_getscheduler - get the policy (scheduling class) of a thread
- * @pid: the pid in question.
- */
-asmlinkage long sys_sched_getscheduler(pid_t pid)
-{
-	int retval = -EINVAL;
-	task_t *p;
-
-	if (pid < 0)
-		goto out_nounlock;
-
-	retval = -ESRCH;
-	read_lock(&tasklist_lock);
-	p = find_process_by_pid(pid);
-	if (p) {
-		retval = security_task_getscheduler(p);
-		if (!retval)
-			retval = p->policy;
-	}
-	read_unlock(&tasklist_lock);
-
-out_nounlock:
-	return retval;
-}
-
-/**
- * sys_sched_getscheduler - get the RT priority of a thread
- * @pid: the pid in question.
- * @param: structure containing the RT priority.
- */
-asmlinkage long sys_sched_getparam(pid_t pid, struct sched_param __user *param)
-{
-	struct sched_param lp;
-	int retval = -EINVAL;
-	task_t *p;
-
-	if (!param || pid < 0)
-		goto out_nounlock;
-
-	read_lock(&tasklist_lock);
-	p = find_process_by_pid(pid);
-	retval = -ESRCH;
-	if (!p)
-		goto out_unlock;
-
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
-
-	lp.sched_priority = p->rt_priority;
-	read_unlock(&tasklist_lock);
-
-	/*
-	 * This one might sleep, we cannot do it with a spinlock held ...
-	 */
-	retval = copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
-
-out_nounlock:
-	return retval;
-
-out_unlock:
-	read_unlock(&tasklist_lock);
-	return retval;
-}
-
-long sched_setaffinity(pid_t pid, cpumask_t new_mask)
-{
-	task_t *p;
-	int retval;
-	cpumask_t cpus_allowed;
-
-	lock_cpu_hotplug();
-	read_lock(&tasklist_lock);
-
-	p = find_process_by_pid(pid);
-	if (!p) {
-		read_unlock(&tasklist_lock);
-		unlock_cpu_hotplug();
-		return -ESRCH;
-	}
-
-	/*
-	 * It is not safe to call set_cpus_allowed with the
-	 * tasklist_lock held.  We will bump the task_struct's
-	 * usage count and then drop tasklist_lock.
-	 */
-	get_task_struct(p);
-	read_unlock(&tasklist_lock);
-
-	retval = -EPERM;
-	if ((current->euid != p->euid) && (current->euid != p->uid) &&
-			!capable(CAP_SYS_NICE))
-		goto out_unlock;
-
-	cpus_allowed = cpuset_cpus_allowed(p);
-	cpus_and(new_mask, new_mask, cpus_allowed);
-	retval = set_cpus_allowed(p, new_mask);
-
-out_unlock:
-	put_task_struct(p);
-	unlock_cpu_hotplug();
-	return retval;
-}
-
-static int get_user_cpu_mask(unsigned long __user *user_mask_ptr, unsigned len,
-			     cpumask_t *new_mask)
-{
-	if (len < sizeof(cpumask_t)) {
-		memset(new_mask, 0, sizeof(cpumask_t));
-	} else if (len > sizeof(cpumask_t)) {
-		len = sizeof(cpumask_t);
-	}
-	return copy_from_user(new_mask, user_mask_ptr, len) ? -EFAULT : 0;
-}
-
-/**
- * sys_sched_setaffinity - set the cpu affinity of a process
- * @pid: pid of the process
- * @len: length in bytes of the bitmask pointed to by user_mask_ptr
- * @user_mask_ptr: user-space pointer to the new cpu mask
- */
-asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
-				      unsigned long __user *user_mask_ptr)
-{
-	cpumask_t new_mask;
-	int retval;
-
-	retval = get_user_cpu_mask(user_mask_ptr, len, &new_mask);
-	if (retval)
-		return retval;
-
-	return sched_setaffinity(pid, new_mask);
-}
-
-/*
- * Represents all cpu's present in the system
- * In systems capable of hotplug, this map could dynamically grow
- * as new cpu's are detected in the system via any platform specific
- * method, such as ACPI for e.g.
- */
-
-cpumask_t cpu_present_map;
-EXPORT_SYMBOL(cpu_present_map);
-
-#ifndef CONFIG_SMP
-cpumask_t cpu_online_map = CPU_MASK_ALL;
-cpumask_t cpu_possible_map = CPU_MASK_ALL;
-#endif
-
-long sched_getaffinity(pid_t pid, cpumask_t *mask)
-{
-	int retval;
-	task_t *p;
-
-	lock_cpu_hotplug();
-	read_lock(&tasklist_lock);
-
-	retval = -ESRCH;
-	p = find_process_by_pid(pid);
-	if (!p)
-		goto out_unlock;
-
-	retval = 0;
-	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
-
-out_unlock:
-	read_unlock(&tasklist_lock);
-	unlock_cpu_hotplug();
-	if (retval)
-		return retval;
-
-	return 0;
-}
-
-/**
- * sys_sched_getaffinity - get the cpu affinity of a process
- * @pid: pid of the process
- * @len: length in bytes of the bitmask pointed to by user_mask_ptr
- * @user_mask_ptr: user-space pointer to hold the current cpu mask
- */
-asmlinkage long sys_sched_getaffinity(pid_t pid, unsigned int len,
-				      unsigned long __user *user_mask_ptr)
-{
-	int ret;
-	cpumask_t mask;
-
-	if (len < sizeof(cpumask_t))
-		return -EINVAL;
-
-	ret = sched_getaffinity(pid, &mask);
-	if (ret < 0)
-		return ret;
-
-	if (copy_to_user(user_mask_ptr, &mask, sizeof(cpumask_t)))
-		return -EFAULT;
-
-	return sizeof(cpumask_t);
-}
-
-/**
  * sys_sched_yield - yield the current processor to other threads.
  *
  * this function yields the current CPU by moving the calling thread
@@ -3812,8 +3546,6 @@ out:
 	return ret;
 }
 
-EXPORT_SYMBOL_GPL(set_cpus_allowed);
-
 /*
  * Move (not current) task off this cpu, onto dest cpu.  We're doing
  * this because either it can't run here any more (set_cpus_allowed()
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:46:54.720649708 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:46:55.945458560 +1000
@@ -234,6 +234,284 @@ void __might_sleep(char *file, int line)
 EXPORT_SYMBOL(__might_sleep);
 #endif
 
+#ifdef __ARCH_WANT_SYS_NICE
+
+/*
+ * sys_nice - change the priority of the current process.
+ * @increment: priority increment
+ *
+ * sys_setpriority is a more generic, but much slower function that
+ * does similar things.
+ */
+asmlinkage long sys_nice(int increment)
+{
+	int retval;
+	long nice;
+
+	/*
+	 * Setpriority might change our priority at the same moment.
+	 * We don't have to worry. Conceptually one call occurs first
+	 * and we have a single winner.
+	 */
+	if (increment < 0) {
+		if (!capable(CAP_SYS_NICE))
+			return -EPERM;
+		if (increment < -40)
+			increment = -40;
+	}
+	if (increment > 40)
+		increment = 40;
+
+	nice = task_nice(current) + increment;
+	if (nice < -20)
+		nice = -20;
+	if (nice > 19)
+		nice = 19;
+
+	retval = security_task_setnice(current, nice);
+	if (retval)
+		return retval;
+
+	set_user_nice(current, nice);
+	return 0;
+}
+
+#endif
+
+/**
+ * find_process_by_pid - find a process with a matching PID value.
+ * @pid: the pid in question.
+ */
+task_t *find_process_by_pid(pid_t pid)
+{
+	return pid ? find_task_by_pid(pid) : current;
+}
+
+int setscheduler(pid_t pid, int policy, struct sched_param __user *param);
+
+/**
+ * sys_sched_setscheduler - set/change the scheduler policy and RT priority
+ * @pid: the pid in question.
+ * @policy: new policy
+ * @param: structure containing the new RT priority.
+ */
+asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
+				       struct sched_param __user *param)
+{
+	return setscheduler(pid, policy, param);
+}
+
+/**
+ * sys_sched_setparam - set/change the RT priority of a thread
+ * @pid: the pid in question.
+ * @param: structure containing the new RT priority.
+ */
+asmlinkage long sys_sched_setparam(pid_t pid, struct sched_param __user *param)
+{
+	return setscheduler(pid, -1, param);
+}
+
+/**
+ * sys_sched_getscheduler - get the policy (scheduling class) of a thread
+ * @pid: the pid in question.
+ */
+asmlinkage long sys_sched_getscheduler(pid_t pid)
+{
+	int retval = -EINVAL;
+	task_t *p;
+
+	if (pid < 0)
+		goto out_nounlock;
+
+	retval = -ESRCH;
+	read_lock(&tasklist_lock);
+	p = find_process_by_pid(pid);
+	if (p) {
+		retval = security_task_getscheduler(p);
+		if (!retval)
+			retval = p->policy;
+	}
+	read_unlock(&tasklist_lock);
+
+out_nounlock:
+	return retval;
+}
+
+/**
+ * sys_sched_getscheduler - get the RT priority of a thread
+ * @pid: the pid in question.
+ * @param: structure containing the RT priority.
+ */
+asmlinkage long sys_sched_getparam(pid_t pid, struct sched_param __user *param)
+{
+	struct sched_param lp;
+	int retval = -EINVAL;
+	task_t *p;
+
+	if (!param || pid < 0)
+		goto out_nounlock;
+
+	read_lock(&tasklist_lock);
+	p = find_process_by_pid(pid);
+	retval = -ESRCH;
+	if (!p)
+		goto out_unlock;
+
+	retval = security_task_getscheduler(p);
+	if (retval)
+		goto out_unlock;
+
+	lp.sched_priority = p->rt_priority;
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * This one might sleep, we cannot do it with a spinlock held ...
+	 */
+	retval = copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
+
+out_nounlock:
+	return retval;
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+	return retval;
+}
+
+long sched_setaffinity(pid_t pid, cpumask_t new_mask)
+{
+	task_t *p;
+	int retval;
+	cpumask_t cpus_allowed;
+
+	lock_cpu_hotplug();
+	read_lock(&tasklist_lock);
+
+	p = find_process_by_pid(pid);
+	if (!p) {
+		read_unlock(&tasklist_lock);
+		unlock_cpu_hotplug();
+		return -ESRCH;
+	}
+
+	/*
+	 * It is not safe to call set_cpus_allowed with the
+	 * tasklist_lock held.  We will bump the task_struct's
+	 * usage count and then drop tasklist_lock.
+	 */
+	get_task_struct(p);
+	read_unlock(&tasklist_lock);
+
+	retval = -EPERM;
+	if ((current->euid != p->euid) && (current->euid != p->uid) &&
+			!capable(CAP_SYS_NICE))
+		goto out_unlock;
+
+	cpus_allowed = cpuset_cpus_allowed(p);
+	cpus_and(new_mask, new_mask, cpus_allowed);
+	retval = set_cpus_allowed(p, new_mask);
+
+out_unlock:
+	put_task_struct(p);
+	unlock_cpu_hotplug();
+	return retval;
+}
+
+static int get_user_cpu_mask(unsigned long __user *user_mask_ptr, unsigned len,
+			     cpumask_t *new_mask)
+{
+	if (len < sizeof(cpumask_t)) {
+		memset(new_mask, 0, sizeof(cpumask_t));
+	} else if (len > sizeof(cpumask_t)) {
+		len = sizeof(cpumask_t);
+	}
+	return copy_from_user(new_mask, user_mask_ptr, len) ? -EFAULT : 0;
+}
+
+/**
+ * sys_sched_setaffinity - set the cpu affinity of a process
+ * @pid: pid of the process
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
+ * @user_mask_ptr: user-space pointer to the new cpu mask
+ */
+asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
+				      unsigned long __user *user_mask_ptr)
+{
+	cpumask_t new_mask;
+	int retval;
+
+	retval = get_user_cpu_mask(user_mask_ptr, len, &new_mask);
+	if (retval)
+		return retval;
+
+	return sched_setaffinity(pid, new_mask);
+}
+
+/*
+ * Represents all cpu's present in the system
+ * In systems capable of hotplug, this map could dynamically grow
+ * as new cpu's are detected in the system via any platform specific
+ * method, such as ACPI for e.g.
+ */
+
+cpumask_t cpu_present_map;
+EXPORT_SYMBOL(cpu_present_map);
+
+#ifndef CONFIG_SMP
+cpumask_t cpu_online_map = CPU_MASK_ALL;
+cpumask_t cpu_possible_map = CPU_MASK_ALL;
+#endif
+
+long sched_getaffinity(pid_t pid, cpumask_t *mask)
+{
+	int retval;
+	task_t *p;
+
+	lock_cpu_hotplug();
+	read_lock(&tasklist_lock);
+
+	retval = -ESRCH;
+	p = find_process_by_pid(pid);
+	if (!p)
+		goto out_unlock;
+
+	retval = 0;
+	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+	unlock_cpu_hotplug();
+	if (retval)
+		return retval;
+
+	return 0;
+}
+
+/**
+ * sys_sched_getaffinity - get the cpu affinity of a process
+ * @pid: pid of the process
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
+ * @user_mask_ptr: user-space pointer to hold the current cpu mask
+ */
+asmlinkage long sys_sched_getaffinity(pid_t pid, unsigned int len,
+				      unsigned long __user *user_mask_ptr)
+{
+	int ret;
+	cpumask_t mask;
+
+	if (len < sizeof(cpumask_t))
+		return -EINVAL;
+
+	ret = sched_getaffinity(pid, &mask);
+	if (ret < 0)
+		return ret;
+
+	if (copy_to_user(user_mask_ptr, &mask, sizeof(cpumask_t)))
+		return -EFAULT;
+
+	return sizeof(cpumask_t);
+}
+
+
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;
 


--------------080705090803050705080206--

--------------enig8709D961ECE8A68383CDF3BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6cuZUg7+tp6mRURAqXkAJ0bM6EkiGr4fd7kRhOaVVNwcF+mBQCfcYLf
7APUM1jYOREsg0+TtLdJN94=
=kRMs
-----END PGP SIGNATURE-----

--------------enig8709D961ECE8A68383CDF3BB--
