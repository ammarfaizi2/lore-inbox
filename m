Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUA0MLA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 07:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbUA0MLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 07:11:00 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:65515 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263472AbUA0MK5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 07:10:57 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: show_task() is not SMP safe
Date: Tue, 27 Jan 2004 13:06:37 +0100
User-Agent: KMail/1.5.4
Cc: Christian Borntraeger <cborntra@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401271306.37209.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger noticed that the kernel can crash after
<SysRq>-T. It appears that the show_task function gets called
for all tasks, which does not work if one of the tasks is
running in a system call on another CPU. In that case the
result of thread_saved_pc and show_stack is undefined and
likely to cause a crash.

For tasks running in user space on other CPUs, show_task()
is probably harmless, but I'm not sure if that's true on all
architectures.

The patch below is still racy for tasks that are about to
sleep, but it demonstrates the problem.

In the same function, there is another (harmless) bug that causes 
the "free stack" indicator to be wrong. It can take any value
between zero and the intended meaning unless __alloc_thread_info
is modified to clear newly allocated stack memory.

	Arnd <><

Index: kernel/sched.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/sched.c,v
retrieving revision 1.56
diff -u -r1.56 sched.c
--- kernel/sched.c	24 Nov 2003 09:44:34 -0000	1.56
+++ kernel/sched.c	27 Jan 2004 11:50:55 -0000
@@ -2457,13 +2457,13 @@
 	else
 		printk(" ");
 #if (BITS_PER_LONG == 32)
-	if (p == current)
-		printk(" current  ");
+	if (state == TASK_RUNNING)
+		printk(" running ");
 	else
 		printk(" %08lX ", thread_saved_pc(p));
 #else
-	if (p == current)
-		printk("   current task   ");
+	if (state == TASK_RUNNING)
+		printk("  running task   ");
 	else
 		printk(" %016lx ", thread_saved_pc(p));
 #endif
@@ -2491,7 +2491,8 @@
 	else
 		printk(" (NOTLB)\n");
 
-	show_stack(p, NULL);
+	if (state != TASK_RUNNING)
+		show_stack(p, NULL);
 }
 
 void show_state(void)

