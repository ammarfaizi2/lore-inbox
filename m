Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSFTQ0R>; Thu, 20 Jun 2002 12:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSFTQ0R>; Thu, 20 Jun 2002 12:26:17 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:28206 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315167AbSFTQ0N>; Thu, 20 Jun 2002 12:26:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH] Fixed set_affinity/get_affinity syscalls
Date: Fri, 21 Jun 2002 02:30:22 +1000
Message-Id: <E17L4pD-0007ih-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a little more kernel code, but it allows userspace to do:

     unsigned int mask = (1 << cpu);
     sys_setaffinity(getpid(), LINUX_AFFINITY_INCLUDE, mask, sizeof(mask));

And it will always do the Right Thing.

Applies on top of last patch.
Comments?

Name: Modified set_affinity/get_affinity syscalls
Author: Rusty Russell
Status: Experimental
Depends: Hotcpu/cpumask.patch.gz

D: This allows userspace to have cpu affinity control without needing
D: to know the size of kernel datastructures and allows them to
D: control what happens when new CPUs are brought online.  It also
D: means that in the future we can sanely interpret affinity in
D: HyperThreading.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.23-sent-to-linus/include/linux/affinity.h working-2.5.23-sched/include/linux/affinity.h
--- working-2.5.23-sent-to-linus/include/linux/affinity.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.23-sched/include/linux/affinity.h	Fri Jun 21 02:09:06 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.23-sent-to-linus/kernel/sched.c working-2.5.23-sched/kernel/sched.c
--- working-2.5.23-sent-to-linus/kernel/sched.c	Fri Jun 21 01:49:47 2002
+++ working-2.5.23-sched/kernel/sched.c	Fri Jun 21 02:08:54 2002
@@ -25,6 +25,7 @@
 #include <asm/mmu_context.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
+#include <linux/affinity.h>
 #include <linux/kernel_stat.h>
 
 /*
@@ -1314,25 +1315,54 @@
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
-	cpu_mask_t online_mask, new_mask;
+	cpu_mask_t new_mask, tmp;
 	int retval;
 	task_t *p;
+	unsigned int i;
 
-	if (len < sizeof(new_mask))
-		return -EINVAL;
-
-	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
+	memset(&new_mask, 0, sizeof(new_mask));
+	if (copy_from_user(&new_mask, user_mask_ptr,
+			   min((size_t)len, sizeof(new_mask))))
 		return -EFAULT;
 
-	cpu_online_mask(&online_mask, new_mask);
-	if (find_first_bit((unsigned long *)online_mask, NR_CPUS) == NR_CPUS)
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
+	/* Check for mention of cpus that aren't online/don't exist */
+	cpu_online_mask(&tmp, new_mask);
+	if (memcmp(&tmp, &new_mask, sizeof(new_mask)) != 0)
+		return -ENOENT;
+
+	/* Invert the mask in the exclude case. */
+ 	if (include == LINUX_AFFINITY_EXCLUDE) {
+		for (i = 0; i < sizeof(new_mask)/sizeof(long); i++)
+			((unsigned long *)&new_mask)[i] ^= -1UL;
+	} else if (include != LINUX_AFFINITY_INCLUDE) {
 		return -EINVAL;
+	}
+
+	/* The new mask must mention some online cpus */
+	cpu_online_mask(&tmp, new_mask);
+	if (find_first_bit((unsigned long *)&tmp, NR_CPUS) == NR_CPUS)
+		/* This is kinda true... */
+		return -EWOULDBLOCK;
 
 	read_lock(&tasklist_lock);
 
@@ -1356,7 +1386,7 @@
 		goto out_unlock;
 
 	retval = 0;
-	set_cpus_allowed(p, online_mask);
+	set_cpus_allowed(p, new_mask);
 
 out_unlock:
 	put_task_struct(p);
@@ -1368,36 +1398,27 @@
  * @pid: pid of the process
  * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to hold the current cpu mask
+ * Returns the size required to hold the complete cpu mask.
  */
 asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
-				      unsigned long *user_mask_ptr)
+				     void *user_mask_ptr)
 {
-	unsigned int real_len;
 	cpu_mask_t mask;
-	int retval;
 	task_t *p;
 
-	real_len = sizeof(mask);
-	if (len < real_len)
-		return -EINVAL;
-
 	read_lock(&tasklist_lock);
-
-	retval = -ESRCH;
 	p = find_process_by_pid(pid);
-	if (!p)
-		goto out_unlock;
-
-	retval = 0;
-	cpu_online_mask(&mask, p->cpus_allowed);
-
-out_unlock:
+	if (!p) {
+		read_unlock(&tasklist_lock);
+		return -ESRCH;
+	}
+	mask = p->cpus_allowed;
 	read_unlock(&tasklist_lock);
-	if (retval)
-		return retval;
-	if (copy_to_user(user_mask_ptr, &mask, real_len))
+
+	if (copy_to_user(user_mask_ptr, &mask,
+			 min((unsigned int)sizeof(mask), len)))
 		return -EFAULT;
-	return real_len;
+	return sizeof(mask);
 }
 
 asmlinkage long sys_sched_yield(void)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
