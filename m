Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVKNUaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVKNUaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbVKNUaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:30:06 -0500
Received: from [212.76.84.242] ([212.76.84.242]:26637 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932098AbVKNUaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:30:04 -0500
From: Al Boldi <a1426z@gawab.com>
To: torvalds@osdl.org
Subject: [PATCH 1/1] threads_max: Simple lockout prevention patch
Date: Mon, 14 Nov 2005 23:27:18 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200511142327.18510.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Simple attempt to provide a backdoor in a process lockout situation.

echo $$ > /proc/sys/kernel/su-pid allows pid to exceed the threads_max limit.

Signed-off-by: Al Boldi <a1426z@gawab.com>

---
(patch against 2.6.14)

--- kernel/fork.c.orig  2005-11-14 20:55:33.000000000 +0300
+++ kernel/fork.c       2005-11-14 20:58:25.000000000 +0300
@@ -57,6 +57,7 @@
 int nr_threads;                /* The idle threads do not count.. */
 
 int max_threads;               /* tunable limit on nr_threads */
+int su_pid;                    /* BackDoor pid to exceed limit on nr_threads 
*/
 
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
@@ -926,6 +927,7 @@
         * to stop root fork bombs.
         */
        if (nr_threads >= max_threads)
+       if (p->pid != su_pid)
                goto bad_fork_cleanup_count;
 
        if (!try_module_get(p->thread_info->exec_domain->module))


--- kernel/sysctl.c.orig        2005-11-14 20:58:45.000000000 +0300
+++ kernel/sysctl.c     2005-11-14 21:01:20.000000000 +0300
@@ -57,6 +57,7 @@
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
 extern int max_threads;
+extern int su_pid;
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int suid_dumpable;
@@ -509,6 +510,14 @@
                .proc_handler   = &proc_dointvec,
        },
        {
+               .ctl_name       = KERN_SU_PID,
+               .procname       = "su-pid",
+               .data           = &su_pid,
+               .maxlen         = sizeof(int),
+               .mode           = 0644,
+               .proc_handler   = &proc_dointvec,
+       },
+       {
                .ctl_name       = KERN_RANDOM,
                .procname       = "random",
                .mode           = 0555,


--- include/linux/sysctl.h.orig 2005-11-14 20:54:55.000000000 +0300
+++ include/linux/sysctl.h      2005-11-14 20:55:15.000000000 +0300
@@ -146,6 +146,7 @@
        KERN_RANDOMIZE=68, /* int: randomize virtual address space */
        KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core 
*/
        KERN_SPIN_RETRY=70,     /* int: number of spinlock retries */
+       KERN_SU_PID=71, /* int: BackDoor pid to exceed Maximum nr of threads 
in the system */
 };


