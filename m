Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbTARQsA>; Sat, 18 Jan 2003 11:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbTARQsA>; Sat, 18 Jan 2003 11:48:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18180 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264936AbTARQr6>; Sat, 18 Jan 2003 11:47:58 -0500
To: LKML <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2.5.59: show_task() oops
Message-Id: <E18ZwHB-0007kw-00@flint.arm.linux.org.uk>
Date: Sat, 18 Jan 2003 16:56:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

show_task() attempts to calculate the amount of free space which hasn't
been written to on the kernel stack by reading from the base of the
kernel stack upwards.

However, it mistakenly uses the task_struct pointer as the base of the
stack, which it isn't, and this can cause an oops.

Here is a patch which uses the task thread pointer instead, which should
be located at the bottom of the kernel stack.  It appears this was missed
when the thread structure was introduced.

--- orig/kernel/sched.c	Fri Jan 17 10:39:25 2003
+++ linux/kernel/sched.c	Sat Jan 18 14:01:39 2003
@@ -2057,7 +2057,7 @@
 		printk(" %016lx ", thread_saved_pc(p));
 #endif
 	{
-		unsigned long * n = (unsigned long *) (p+1);
+		unsigned long * n = (unsigned long *) (p->thread_info+1);
 		while (!*n)
 			n++;
 		free = (unsigned long) n - (unsigned long)(p+1);

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

