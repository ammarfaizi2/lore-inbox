Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317873AbSFSNop>; Wed, 19 Jun 2002 09:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317882AbSFSNoo>; Wed, 19 Jun 2002 09:44:44 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:3654 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317873AbSFSNom>; Wed, 19 Jun 2002 09:44:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-reply-to: Your message of "18 Jun 2002 13:55:38 MST."
             <1024433739.922.236.camel@sinai> 
Date: Wed, 19 Jun 2002 23:31:14 +1000
Message-Id: <E17KfZg-0000Fg-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1024433739.922.236.camel@sinai> you write:
> On Tue, 2002-06-18 at 13:31, Rusty Russell wrote:
> 
> > No, you have accepted a non-portable userspace interface and put it in
> > generic code.  THAT is idiotic.
> > 
> > So any program that doesn't use the following is broken:
> 
> On top of what Linus replied, there is the issue that if your task does
> not know how many CPUs can be in the system then setting its affinity is
> worthless in 90% of the cases.

No.  You can read the cpus out of /proc/cpuinfo, and say "I want to be
on <some cpu I found>" or "I want one copy for each processor", or
even "I want every processor but the one the other task just bound
to".  This is 99% of actual usage.

But I can see the man page now:

	The third arg to set/getaffinity is the size of a kernel data
	structure.  There is no way to know this size: it is dependent
	on architecture and kernel configuration.  You can pass a
	larger datastructure and the higher bits are ignored: try
	1024?

> I.e., everyone today can write code like
> 
> 	sched_setaffinity(0, sizeof(unsigned long), &mask)

NO THEY CAN'T.  How will ia64 deal with this in ia32 binaries?  How
will Sparc64 deal with this in 32-bit binaries?  How will PPC64 deal
with this in PPC32 binaries?  How will x86_64 deal with this in x86
binaries?

They'll have to either break compatibility, or guess and fill
accordingly.

And when new CPUS come online?  At the moment you effectively
zero-fill, because you can't tell what you're supposed to do here.  So
you can never truly reset your affinity once it's set.

> Summarily, setting CPU affinity is something that is naturally low-level
> enough it only makes sense when you know what you are setting and not
> setting.  While a mask of -1 may always make sense, random bitmaps
> (think RT stuff here) are explicit for the number of CPUs given.

You've designed an interface where the easiest thing to do is the
wrong thing (as per your example).  This is the hallmark of bad
design.

*If* there had been a way to tell the bitmask size which was
introduced at the same time, it might have been acceptable.  But there
isn't at the moment, so people are writing bugs right now.

Untested patch below, seems to compile (hard to tell since PPC is
v. broken right now)

Summary:
1) Easy to write portable "set this cpu" code.

2) Both system calls now handle NR_CPUS > sizeof(long)*8.

3) Things which have set affinity once can now get back on new cpus as
   they come up.

4) Trivial to extent for hyperthreading on a per-arch basis.

Linus, think and apply,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

--- linux-2.5.22/include/linux/affinity.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.22-linus/include/linux/affinity.h	Wed Jun 19 22:09:47 2002
@@ -0,0 +1,9 @@
+#ifndef _LINUX_AFFINITY_H
+#define _LINUX_AFFINITY_H
+enum {
+	/* Set affinity to these processors */
+	LINUX_AFFINITY_INCLUDE,
+	/* Set affinity to all *but* these processors */
+	LINUX_AFFINITY_EXCLUDE,
+};
+#endif
--- working-2.5.22-linus/kernel/sched.c.~1~	Tue Jun 18 23:48:03 2002
+++ working-2.5.22-linus/kernel/sched.c	Wed Jun 19 23:28:32 2002
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
+#include <linux/affinity.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -1309,25 +1310,57 @@
 /**
  * sys_sched_setaffinity - set the cpu affinity of a process
  * @pid: pid of the process
+ * @include: is this include or exclude?
  * @len: length in bytes of the bitmask pointed to by user_mask_ptr
- * @user_mask_ptr: user-space pointer to the new cpu mask
+ * @user_mask_ptr: user-space pointer to bitmask of cpus to include/exclude
  */
-asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
-				      unsigned long *user_mask_ptr)
+asmlinkage int sys_sched_setaffinity(pid_t pid,
+				     int include,
+				     unsigned int len,
+				     unsigned char *user_mask_ptr)
 {
-	unsigned long new_mask;
+	bitmap_member(new_mask, NR_CPUS);
 	task_t *p;
 	int retval;
+	unsigned int i;
 
-	if (len < sizeof(new_mask))
-		return -EINVAL;
-
-	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
+	memset(new_mask, 0x00, sizeof(new_mask));
+	if (copy_from_user(new_mask, user_mask_ptr,
+			   min((size_t)len, sizeof(new_mask))))
 		return -EFAULT;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	/* longer is OK, as long as they don't actually set any of the bits. */
+	if (len > sizeof(new_mask)) {
+		unsigned char c;
+		for (i = sizeof(new_mask); i < len; i++) {
+			if (get_user(c, user_mask_ptr+i))
+				return -EFAULT;
+			if (c != 0)
+				return -ENOENT;
+		}
+	}
+
+	/* Check for cpus that aren't online/don't exist */
+	for (i = 0; i < ARRAY_SIZE(new_mask) * i; i++) {
+		if (i >= NR_CPUS || !cpu_online(i)) {
+			if (test_bit(i, new_mask))
+				return -ENOENT;
+		}
+	}
+
+	/* Invert the mask in the exclude case. */
+ 	if (include == LINUX_AFFINITY_EXCLUDE) {
+		for (i = 0; i < ARRAY_SIZE(new_mask); i++)
+			new_mask[i] = ~new_mask[i];
+	} else if (include != LINUX_AFFINITY_INCLUDE) {
 		return -EINVAL;
+	}
+
+	/* The new mask must mention some online cpus */
+	for (i = 0; !cpu_online(i) || !test_bit(i, new_mask); i++)
+		if (i == NR_CPUS-1)
+			/* This is kinda true... */
+			return -EWOULDBLOCK;
 
 	read_lock(&tasklist_lock);
 
@@ -1351,7 +1384,8 @@
 		goto out_unlock;
 
 	retval = 0;
-	set_cpus_allowed(p, new_mask);
+	/* FIXME: set_cpus_allowed should take an array... */
+	set_cpus_allowed(p, new_mask[0]);
 
 out_unlock:
 	put_task_struct(p);
@@ -1363,37 +1397,27 @@
  * @pid: pid of the process
  * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to hold the current cpu mask
+ * Returns the size that required to hold the complete cpu mask.
  */
 asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
-				      unsigned long *user_mask_ptr)
+				     void *user_mask_ptr)
 {
-	unsigned long mask;
-	unsigned int real_len;
+	bitmap_member(mask, NR_CPUS) = { 0 };
 	task_t *p;
-	int retval;
-
-	real_len = sizeof(mask);
-
-	if (len < real_len)
-		return -EINVAL;
 
 	read_lock(&tasklist_lock);
-
-	retval = -ESRCH;
 	p = find_process_by_pid(pid);
-	if (!p)
-		goto out_unlock;
-
-	retval = 0;
-	mask = p->cpus_allowed & cpu_online_map;
-
-out_unlock:
+	if (!p) {
+		read_unlock(&tasklist_lock);
+		return -ESRCH;
+	}
+	memcpy(mask, &p->cpus_allowed, sizeof(p->cpus_allowed));
 	read_unlock(&tasklist_lock);
-	if (retval)
-		return retval;
-	if (copy_to_user(user_mask_ptr, &mask, real_len))
+
+	if (copy_to_user(user_mask_ptr, &mask,
+			 min((unsigned)sizeof(p->cpus_allowed), len)))
 		return -EFAULT;
-	return real_len;
+	return sizeof(p->cpus_allowed);
 }
 
 asmlinkage long sys_sched_yield(void)
@@ -1727,9 +1751,11 @@
 	migration_req_t req;
 	runqueue_t *rq;
 
+#if 0 /* This is checked for userspace, and kernel shouldn't do this */
 	new_mask &= cpu_online_map;
 	if (!new_mask)
 		BUG();
+#endif
 
 	preempt_disable();
 	rq = task_rq_lock(p, &flags);
