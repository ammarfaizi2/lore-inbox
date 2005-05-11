Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVEKUqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVEKUqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVEKUqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:46:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3278 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262050AbVEKUnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:43:00 -0400
Date: Wed, 11 May 2005 13:42:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050511134235.5cecf85c.pj@sgi.com>
In-Reply-To: <20050511195156.GE3614@otto>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> I'm not too familiar with the cpusets code but I
> would like to stay away from nesting these semaphores if at all
> possible.

I share you preference for not nesting these semaphores.

The other choice I am aware of would be for the hotplug code to be less
cpuset-friendly.  In the move_task_off_dead_cpu() code, at the point it
says "No more Mr. Nice Guy", instead of looking for the nearest
enclosing cpuset that has something online, which is what the
cpuset_cpus_allowed() does, instead we could just take any damn cpu that
was online.

Something along the lines of the following fix:

--- pj/kernel.old/sched.c	2005-05-11 13:00:17.000000000 -0700
+++ pj/kernel.new/sched.c	2005-05-11 13:02:24.000000000 -0700
@@ -4229,7 +4229,7 @@ static void move_task_off_dead_cpu(int d
 
 	/* No more Mr. Nice Guy. */
 	if (dest_cpu == NR_CPUS) {
-		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
+		tsk->cpus_allowed = cpu_online_map;
 		dest_cpu = any_online_cpu(tsk->cpus_allowed);
 
 		/*


We've already decided here that we had to violate the cpuset container -
as apparently someone hot unplugged every cpu in the current tasks
cpuset.

Hmmm ... that's not quite right ... we've decided that we had to violate
the current tasks cpus_allowed, as apparently someone hot unplugged
every cpu allowed there.  This might be a proper subset of what cpus the
tasks cpuset allows, perhaps due to a sched_setaffinity() call to
restrict a task to just one or a few cpus that are allowed in its
cpuset.

So what we'd really like to do would be to first fallback to all the
cpus allowed in the specified tasks cpuset (no walking the cpuset
hierarchy), and see if any of those cpus are still online to receive
this orphan task.  Unless someone has botched the system configuration,
and taken offline all the cpus in a cpuset, this should yield up a cpu
that is still both allowed and online.  If that fails, then to heck with
honoring cpuset placement - just take the first online cpu we can find.

This is doable without holding cpuset_sem.  We can look at a current
tasks cpuset without cpuset_sem, just with the task lock.  And this
should almost always work (yield up an online cpu that the cpuset
allows). And when it doesn't work, we can reasonably blame the system
administrator for forcing us to blow out the cpuset confinement.

The following untested, uncompiled patch claims to do this:

--- 2.6.12-rc1-mm4/include/linux/cpuset.h	2005-04-02 15:43:28.000000000 -0800
+++ 2.6.12-rc1-mm4.new/include/linux/cpuset.h	2005-05-11 13:26:10.000000000 -0700
@@ -19,6 +19,7 @@ extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
 extern void cpuset_exit(struct task_struct *p);
 extern const cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
+extern const cpumask_t cpuset_task_cpus_allowed(const struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
 void cpuset_update_current_mems_allowed(void);
 void cpuset_restrict_to_mems_allowed(unsigned long *nodes);
@@ -38,6 +39,10 @@ static inline cpumask_t cpuset_cpus_allo
 {
 	return cpu_possible_map;
 }
+static inline cpumask_t cpuset_task_cpus_allowed(struct task_struct *p)
+{
+	return cpu_possible_map;
+}
 
 static inline void cpuset_init_current_mems_allowed(void) {}
 static inline void cpuset_update_current_mems_allowed(void) {}
--- 2.6.12-rc1-mm4/kernel/cpuset.c	2005-04-22 19:35:34.000000000 -0700
+++ 2.6.12-rc1-mm4.new/kernel/cpuset.c	2005-05-11 13:40:05.000000000 -0700
@@ -1570,6 +1570,27 @@ const cpumask_t cpuset_cpus_allowed(cons
 	return mask;
 }
 
+/**
+ * cpuset_task_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
+ *
+ * Description: Returns the cpumask_t cpus_allowed of the cpuset
+ * attached to the specified @tsk.  Unlike cpuset_cpus_allowed(),
+ * is not guaranteed to return a non-empty subset of cpu_online_map.
+ * Does not walk up the cpuset hierarchy, and does not attempt to
+ * acquire the cpuset_sem.  If called on a task about to exit,
+ * where tsk->cpuset is already NULL, return cpu_online_map.
+ *
+ * Call with task locked.
+ **/
+
+const cpumask_t cpuset_task_cpus_allowed(const struct task_struct *tsk)
+{
+	if (!tsk->cpuset)
+		return cpu_online_map;
+	return tsk->cpuset->cpus_allowed;
+}
+
 void cpuset_init_current_mems_allowed(void)
 {
 	current->mems_allowed = NODE_MASK_ALL;
--- 2.6.12-rc1-mm4/kernel/sched.c	2005-04-22 19:51:44.000000000 -0700
+++ 2.6.12-rc1-mm4.new/kernel/sched.c	2005-05-11 13:33:20.000000000 -0700
@@ -4303,7 +4303,7 @@ static void move_task_off_dead_cpu(int d
 
 	/* No more Mr. Nice Guy. */
 	if (dest_cpu == NR_CPUS) {
-		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
+		tsk->cpus_allowed = cpuset_task_cpus_allowed(tsk);
 		dest_cpu = any_online_cpu(tsk->cpus_allowed);
 
 		/*


I retract my Ack of Dinakar's patch, in favor of further consideration
of this last patch, above.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
