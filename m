Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318735AbSH1GdA>; Wed, 28 Aug 2002 02:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318736AbSH1Gc7>; Wed, 28 Aug 2002 02:32:59 -0400
Received: from dp.samba.org ([66.70.73.150]:7343 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318735AbSH1Gc5>;
	Wed, 28 Aug 2002 02:32:57 -0400
Date: Wed, 28 Aug 2002 16:32:42 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] "fully HT-aware scheduler" support, 2.5.31-BK-curr
Message-Id: <20020828163242.2c84747f.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0208270226190.12947-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208270226190.12947-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002 03:44:23 +0200 (CEST)
Ingo Molnar <mingo@elte.hu> wrote:

> The following properties have to be provided by a scheduler that wants to
> be 'fully HT-aware':

Thanks Mingo, I can take this off my TODO list (your implementation even looks
the same 8).

>  - HT-aware affinity.
> 
>    Tasks should attempt to 'stick' to physical CPUs, not logical CPUs.

Linus disagreed with this before when I discussed it with him, and with the
current (stupid, non-portable, broken) set_affinity syscall he's right.

You don't know if someone said "schedule me on cpu 0" because they really
want to be scheduled on CPU 0, or because they really *don't* want to be
scheduled on CPU 1 (where something else is running).  You can't just assume
they are equivalent if they are the same physical CPU.

My modified set_affinity syscall (which takes a "include/exclude" flag)
allows the arch to make this decision (eventually) since you know what the
user wants (it also means that you know what to do if they give you a
short bitmap, or a new cpu comes online/goes offline).

(Requires previous patches, so doesn't apply as is, but you get the idea).

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

Name: Modified set_affinity/get_affinity syscalls
Author: Rusty Russell
Status: Experimental
Depends: Hotcpu/cpumask.patch.gz

D: This allows userspace to have cpu affinity control without needing
D: to know the size of kernel datastructures and allows them to
D: control what happens when new CPUs are brought online.  It also
D: means that in the future we can sanely interpret affinity in
D: HyperThreading.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29333-linux-2.5.31/include/linux/affinity.h .29333-linux-2.5.31.updated/include/linux/affinity.h
--- .29333-linux-2.5.31/include/linux/affinity.h	1970-01-01 10:00:00.000000000 +1000
+++ .29333-linux-2.5.31.updated/include/linux/affinity.h	2002-08-13 16:04:44.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29333-linux-2.5.31/kernel/sched.c .29333-linux-2.5.31.updated/kernel/sched.c
--- .29333-linux-2.5.31/kernel/sched.c	2002-08-13 16:04:25.000000000 +1000
+++ .29333-linux-2.5.31.updated/kernel/sched.c	2002-08-13 16:18:50.000000000 +1000
@@ -25,6 +25,7 @@
 #include <asm/mmu_context.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
+#include <linux/affinity.h>
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
 #include <linux/notifier.h>
@@ -1540,21 +1541,44 @@ out_unlock:
  * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to the new cpu mask
  */
-asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
-				      unsigned long *user_mask_ptr)
+asmlinkage int sys_sched_setaffinity(pid_t pid,
+				     int include,
+				     unsigned int len,
+				     unsigned long *user_mask_ptr)
 {
 	DECLARE_BITMAP(new_mask, NR_CPUS);
+	unsigned char c;
 	int retval;
 	task_t *p;
 
-	if (len < sizeof(new_mask))
-		return -EINVAL;
-
-	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
+	memset(&new_mask, 0, sizeof(new_mask));
+	if (copy_from_user(&new_mask, user_mask_ptr,
+			   min((size_t)len, sizeof(new_mask))))
 		return -EFAULT;
 
-	if (any_online_cpu(new_mask) == NR_CPUS)
+	/* longer is OK, as long as they don't actually set any of the bits. */
+	for (i = sizeof(new_mask); i < len; i++) {
+		if (get_user(c, user_mask_ptr+i))
+			return -EFAULT;
+		if (c != 0)
+			return -ENOENT;
+	}
+
+	/* Invert the mask in the exclude case. */
+	switch (include) {
+	case LINUX_AFFINITY_EXCLUDE:
+		for (i = 0; i < BITS_TO_LONG(NR_CPUS); i++)
+			new_mask[i] ^= ~0UL;
+		break;
+	case LINUX_AFFINITY_INCLUDE:
+		break;
+	default:
 		return -EINVAL;
+	}
+
+	/* Must mention at least one online CPU */
+	if (any_online_cpu(new_mask) == NR_CPUS)
+		return -EWOULDBLOCK; /* This is kinda true */
 
 	read_lock(&tasklist_lock);
 
@@ -1590,37 +1614,26 @@ out_unlock:
  * @pid: pid of the process
  * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to hold the current cpu mask
+ * Returns the size required to hold the complete cpu mask.
  */
 asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
-				      unsigned long *user_mask_ptr)
+				     void *user_mask_ptr)
 {
-	unsigned int real_len, i;
 	DECLARE_BITMAP(mask, NR_CPUS);
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
-	for (i = 0; i < ARRAY_SIZE(mask); i++)
-		mask[i] = (p->cpus_allowed[i] & cpu_online_map[i]);
-
-out_unlock:
+	if (!p) {
+		read_unlock(&tasklist_lock);
+		return -ESRCH;
+	}
+	memcpy(mask, p->cpus_allowed, sizeof(mask));
 	read_unlock(&tasklist_lock);
-	if (retval)
-		return retval;
-	if (copy_to_user(user_mask_ptr, &mask, real_len))
+
+	if (copy_to_user(user_mask_ptr, &mask, len))
 		return -EFAULT;
-	return real_len;
+	return sizeof(mask);
 }
 
 /**
