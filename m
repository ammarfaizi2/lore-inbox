Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTJUXWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 19:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTJUXVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 19:21:51 -0400
Received: from [65.172.181.6] ([65.172.181.6]:31616 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263109AbTJUXVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 19:21:04 -0400
Date: Tue, 21 Oct 2003 16:20:32 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Simon Derr <Simon.Derr@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: (3/4) [PATCH] cpuset - build without CPUSET configured
Message-Id: <20031021162032.723c247b.shemminger@osdl.org>
In-Reply-To: <Pine.A41.4.53.0310131503500.173334@isabelle.frec.bull.fr>
References: <Pine.A41.4.53.0310131503500.173334@isabelle.frec.bull.fr>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The existing patch would not build a kernel unless CPUSET was enabled.
The following is a simple way to make those system calls conditional.

diff -Nru a/include/linux/cpuset.h b/include/linux/cpuset.h
--- a/include/linux/cpuset.h	Tue Oct 21 16:09:32 2003
+++ b/include/linux/cpuset.h	Tue Oct 21 16:09:32 2003
@@ -24,6 +24,13 @@
 
 int cpuset_realtologic_cpuid(struct cpuset * cs, int cpuid);
 
+extern asmlinkage long sys_cpuset_create(cpuset_t *cpusetp, int flags);
+extern asmlinkage long sys_cpuset_destroy(cpuset_t cpuset);
+extern asmlinkage long sys_cpuset_attach(cpuset_t cpuset, pid_t pid);
+extern asmlinkage long sys_cpuset_alloc(cpuset_t cpuset, int len, 
+					unsigned long *user_mask_ptr);
+extern asmlinkage long sys_cpuset_getfreecpus(int flags, int len, 
+					      unsigned long *user_mask_ptr);
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_CPUSET_H */
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Tue Oct 21 16:09:32 2003
+++ b/kernel/sys.c	Tue Oct 21 16:09:32 2003
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/fs.h>
+#include <linux/cpuset.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/times.h>
@@ -253,6 +254,12 @@
 cond_syscall(sys_epoll_wait)
 cond_syscall(sys_pciconfig_read)
 cond_syscall(sys_pciconfig_write)
+cond_syscall(sys_cpuset_create);
+cond_syscall(sys_cpuset_destroy);
+cond_syscall(sys_cpuset_alloc);
+cond_syscall(sys_cpuset_attach);
+cond_syscall(sys_cpuset_getfreecpus);
+
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {

