Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268662AbUHaObP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268662AbUHaObP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 10:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUHaObP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 10:31:15 -0400
Received: from zero.aec.at ([193.170.194.10]:29700 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268662AbUHaObL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 10:31:11 -0400
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix argument checking in sched_setaffinity
From: Andi Kleen <ak@muc.de>
Date: Tue, 31 Aug 2004 16:30:50 +0200
Message-ID: <m3zn4bidlx.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the argument length checking in sched_setaffinity.

Previously it would error out when the length passed was
smaller than sizeof(cpumask_t). And any bits beyond cpumask_s
would be silently ignored.

First this assumes that the user application knows the size
of cpumask_t, which should be kernel internal. When you increase 
cpumask_t old applications break and there is no good way
for the application to find out the cpumask_t size the kernel
uses.

This patch changes it to do similar checking to the NUMA API calls: 

- Any length is ok as long as all online CPUs are covered
(this could still cause application breakage with more CPUs, 
but there is no good way around it) 

- When the user passes more than cpumask_t bytes the excess
bytes are checked to be zero.


diff -u linux-2.6.8-work/kernel/sched.c-AFFINITY linux-2.6.8-work/kernel/sched.c
--- linux-2.6.8-work/kernel/sched.c-AFFINITY	2004-08-05 04:31:11.000000000 +0200
+++ linux-2.6.8-work/kernel/sched.c	2004-08-31 15:36:38.000000000 +0200
@@ -2891,6 +2891,34 @@
 	return retval;
 }
 
+static int get_user_cpu_mask(unsigned long __user *user_mask_ptr, unsigned len,
+			     cpumask_t *new_mask)
+{
+	if (len < sizeof(cpumask_t)) {
+		/* Smaller is ok as long as all online CPUs are covered */
+		int i, max = 0;
+		for_each_online_cpu(i) 
+			max = i; 
+		if (len < (max + 7)/8)
+			return -EINVAL;
+		memset(new_mask, 0, sizeof(cpumask_t)); 
+	} else if (len > sizeof(cpumask_t)) { 
+		/* Longer is ok as long as all high bits are 0 */
+		int i;
+		if (len > PAGE_SIZE)
+			return -EINVAL;
+		for (i = sizeof(cpumask_t); i < len; i++) { 
+			unsigned char val;
+			if (get_user(val, (unsigned char *)user_mask_ptr + i))
+				return -EFAULT; 
+			if (val)
+				return -EINVAL;
+		} 
+		len = sizeof(cpumask_t);			
+	}
+	return copy_from_user(new_mask, user_mask_ptr, len) ? -EFAULT : 0;
+}
+
 /**
  * sys_sched_setaffinity - set the cpu affinity of a process
  * @pid: pid of the process
@@ -2903,12 +2931,10 @@
 	cpumask_t new_mask;
 	int retval;
 	task_t *p;
-
-	if (len < sizeof(new_mask))
-		return -EINVAL;
-
-	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
-		return -EFAULT;
+	
+	retval = get_user_cpu_mask(user_mask_ptr, len, &new_mask);
+	if (retval)
+		return retval;
 
 	lock_cpu_hotplug();
 	read_lock(&tasklist_lock);

