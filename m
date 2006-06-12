Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752292AbWFLU1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbWFLU1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbWFLU1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:27:53 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:28890 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S1752065AbWFLU1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:27:52 -0400
Message-ID: <448DCE3F.8090905@sw.ru>
Date: Tue, 13 Jun 2006 00:27:43 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipc namespace - compilation fix
Content-Type: multipart/mixed;
 boundary="------------080907000503030903070107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080907000503030903070107
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes IPC namespace compilation when `make allnoconfig` is 
used. Checked all 3 possible combinations of config options.

Thanks,
Kirill

--------------080907000503030903070107
Content-Type: text/plain;
 name="diff-ipc-ns-compilation"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ipc-ns-compilation"

diff -uprN linux-2.6.16/include/linux/init_task.h linux-2.6.16-rc6-mm1/include/linux/init_task.h
--- linux-2.6.16/include/linux/init_task.h	2006-06-13 00:20:52.000000000 +0400
+++ linux-2.6.16-rc6-mm1/include/linux/init_task.h	2006-06-13 00:02:41.000000000 +0400
@@ -5,6 +5,7 @@
 #include <linux/rcupdate.h>
 #include <linux/utsname.h>
 #include <linux/interrupt.h>
+#include <linux/ipc.h>
 
 #define INIT_FDTABLE \
 {							\
@@ -73,8 +74,8 @@ extern struct nsproxy init_nsproxy;
 	.count		= ATOMIC_INIT(1),				\
 	.nslock		= SPIN_LOCK_UNLOCKED,				\
 	.uts_ns		= &init_uts_ns,					\
-	.ipc_ns		= &init_ipc_ns,					\
 	.namespace	= NULL,						\
+	INIT_IPC_NS(ipc_ns)						\
 }
 
 #define INIT_SIGHAND(sighand) {						\
diff -uprN linux-2.6.16/include/linux/ipc.h linux-2.6.16-rc6-mm1/include/linux/ipc.h
--- linux-2.6.16/include/linux/ipc.h	2006-06-13 00:20:52.000000000 +0400
+++ linux-2.6.16-rc6-mm1/include/linux/ipc.h	2006-06-13 00:04:41.000000000 +0400
@@ -88,20 +88,38 @@ struct ipc_namespace {
 };
 
 extern struct ipc_namespace init_ipc_ns;
+
+#ifdef CONFIG_SYSVIPC
+#define INIT_IPC_NS(ns)		.ns		= &init_ipc_ns,
+#else
+#define INIT_IPC_NS(ns)	
+#endif
+
+#ifdef CONFIG_IPC_NS
 extern void free_ipc_ns(struct kref *kref);
 extern int copy_ipcs(unsigned long flags, struct task_struct *tsk);
 extern int unshare_ipcs(unsigned long flags, struct ipc_namespace **ns);
+#else
+static inline int copy_ipcs(unsigned long flags, struct task_struct *tsk)
+{
+	return 0;
+}
+#endif
 
 static inline struct ipc_namespace *get_ipc_ns(struct ipc_namespace *ns)
 {
+#ifdef CONFIG_IPC_NS
 	if (ns)
 		kref_get(&ns->kref);
+#endif
 	return ns;
 }
 
 static inline void put_ipc_ns(struct ipc_namespace *ns)
 {
+#ifdef CONFIG_IPC_NS
 	kref_put(&ns->kref, free_ipc_ns);
+#endif
 }
 
 #endif /* __KERNEL__ */
diff -uprN linux-2.6.16/ipc/util.c linux-2.6.16-rc6-mm1/ipc/util.c
--- linux-2.6.16/ipc/util.c	2006-06-13 00:21:04.000000000 +0400
+++ linux-2.6.16-rc6-mm1/ipc/util.c	2006-06-12 23:39:11.000000000 +0400
@@ -145,21 +145,6 @@ void free_ipc_ns(struct kref *kref)
 	shm_exit_ns(ns);
 	kfree(ns);
 }
-#else
-int unshare_ipcs(unsigned long flags, struct ipc_namespace **ns)
-{
-	return -EINVAL;
-}
-
-int copy_ipcs(unsigned long flags, struct task_struct *tsk)
-{
-	return 0;
-}
-
-void free_ipc_ns(struct kref *kref)
-{
-	BUG(); /* init_ipc_ns should never be put */
-}
 #endif
 
 /**
diff -uprN linux-2.6.16/kernel/fork.c linux-2.6.16-rc6-mm1/kernel/fork.c
--- linux-2.6.16/kernel/fork.c	2006-06-13 00:20:52.000000000 +0400
+++ linux-2.6.16-rc6-mm1/kernel/fork.c	2006-06-12 23:51:16.000000000 +0400
@@ -1573,6 +1573,16 @@ static int unshare_semundo(unsigned long
 	return 0;
 }
 
+#ifndef CONFIG_IPC_NS
+static inline int unshare_ipcs(unsigned long flags, struct ipc_namespace **ns)
+{
+	if (flags & CLONE_NEWIPC)
+		return -EINVAL;
+
+	return 0;
+}
+#endif
+
 /*
  * unshare allows a process to 'unshare' part of the process
  * context which was originally shared using clone.  copy_*

--------------080907000503030903070107--
