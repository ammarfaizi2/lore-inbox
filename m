Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbVDAWcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVDAWcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVDAWcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 17:32:54 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18208
	"EHLO g5.random") by vger.kernel.org with ESMTP id S262929AbVDAWcs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 17:32:48 -0500
Date: Sat, 2 Apr 2005 00:14:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dmitry Yusupov <dima@neterion.com>, Alasdair G Kergon <agk@redhat.com>,
       Mike Christie <michaelc@cs.wisc.edu>, Alex Aizman <alex@neterion.com>
Subject: oom-killer disable for iscsi/lvm2/multipath userland critical sections
Message-ID: <20050401221400.GQ29492@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

some private discussion (that was continuing some kernel-summit-discuss
thread) ended in the below patch. I also liked a textual "disable"
instead of value "-17" (internally to the kernel it could be represented
the same way, but the /proc parsing would be more complicated). If you
prefer textual "disable" we can change this of course.

Comments welcome.

From: Andrea Arcangeli <andrea@suse.de>
Subject: oom killer protection

iscsi/lvm2/multipath needs guaranteed protection from the oom-killer.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- 2.6.12-seccomp/fs/proc/base.c.~1~	2005-03-25 05:13:28.000000000 +0100
+++ 2.6.12-seccomp/fs/proc/base.c	2005-04-01 23:47:22.000000000 +0200
@@ -751,7 +751,7 @@ static ssize_t oom_adjust_write(struct f
 	if (copy_from_user(buffer, buf, count))
 		return -EFAULT;
 	oom_adjust = simple_strtol(buffer, &end, 0);
-	if (oom_adjust < -16 || oom_adjust > 15)
+	if ((oom_adjust < -16 || oom_adjust > 15) && oom_adjust != OOM_DISABLE)
 		return -EINVAL;
 	if (*end == '\n')
 		end++;
--- 2.6.12-seccomp/include/linux/mm.h.~1~	2005-03-25 05:13:28.000000000 +0100
+++ 2.6.12-seccomp/include/linux/mm.h	2005-04-01 23:53:11.000000000 +0200
@@ -856,5 +856,8 @@ int in_gate_area_no_task(unsigned long a
 #define in_gate_area(task, addr) ({(void)task; in_gate_area_no_task(addr);})
 #endif	/* __HAVE_ARCH_GATE_AREA */
 
+/* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
+#define OOM_DISABLE -17
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
--- 2.6.12-seccomp/mm/oom_kill.c.~1~	2005-03-08 01:02:30.000000000 +0100
+++ 2.6.12-seccomp/mm/oom_kill.c	2005-04-01 23:46:18.000000000 +0200
@@ -145,7 +145,7 @@ static struct task_struct * select_bad_p
 	do_posix_clock_monotonic_gettime(&uptime);
 	do_each_thread(g, p)
 		/* skip the init task with pid == 1 */
-		if (p->pid > 1) {
+		if (p->pid > 1 && p->oomkilladj != OOM_DISABLE) {
 			unsigned long points;
 
 			/*
