Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbUDSDgt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 23:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUDSDgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 23:36:48 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:64985 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264273AbUDSDg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 23:36:29 -0400
Subject: [PATCH] Use workqueue for call_usermodehelper
From: Rusty Russell <rusty@rustcorp.com.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Content-Type: text/plain
Message-Id: <1082345766.30154.13.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 13:36:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Vatsa, this should solve your NUMA+HOTPLUG_CPU deadlock too, I think ]

This uses the create_singlethread_workqueue() function presented in the
last patch, although it could just as easily use create_workqueue().

Name: call_usermodehelper To Use Own Workqueue
Status: Tested on 2.6.6-rc1-bk3
Depends: Misc/workqueue-singlethread.patch.gz

call_usermodehelper uses keventd to create a thread, guaranteeing a
nice, clean kernel thread.  Unfortunately, there is a case where
call_usermodehelper is called with &bus->subsys.rwsem held (via
bus_add_driver()), but keventd could be running bus_add_device(),
which is blocked on the same lock.  The result is deadlock, and it
comes from using keventd for both.

In this case, it can be fixed by using a completely independent thread
for call_usermodehelper, or an independent workqueue.  Workqueues have
the infrastructure we need, so we use one.

Move EXPORT_SYMBOL while we're there, too.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23049-linux-2.6.6-rc1-bk2/kernel/kmod.c .23049-linux-2.6.6-rc1-bk2.updated/kernel/kmod.c
--- .23049-linux-2.6.6-rc1-bk2/kernel/kmod.c	2004-04-15 16:06:55.000000000 +1000
+++ .23049-linux-2.6.6-rc1-bk2.updated/kernel/kmod.c	2004-04-18 14:34:18.000000000 +1000
@@ -35,11 +35,13 @@
 #include <linux/security.h>
 #include <linux/mount.h>
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>
 
 extern int max_threads;
 
 #ifdef CONFIG_KMOD
+static struct workqueue_struct *khelper_wq;
 
 /*
 	modprobe_path is set via /proc/sys.
@@ -109,6 +111,7 @@ int request_module(const char *fmt, ...)
 	atomic_dec(&kmod_concurrent);
 	return ret;
 }
+EXPORT_SYMBOL(request_module);
 #endif /* CONFIG_KMOD */
 
 #ifdef CONFIG_HOTPLUG
@@ -197,9 +200,7 @@ static int wait_for_helper(void *data)
 	return 0;
 }
 
-/*
- * This is run by keventd.
- */
+/* This is run by khelper thread  */
 static void __call_usermodehelper(void *data)
 {
 	struct subprocess_info *sub_info = data;
@@ -249,26 +250,22 @@ int call_usermodehelper(char *path, char
 	};
 	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
 
-	if (system_state != SYSTEM_RUNNING)
+	if (!khelper_wq)
 		return -EBUSY;
 
 	if (path[0] == '\0')
-		goto out;
+		return 0;
 
-	if (current_is_keventd()) {
-		/* We can't wait on keventd! */
-		__call_usermodehelper(&sub_info);
-	} else {
-		schedule_work(&work);
-		wait_for_completion(&done);
-	}
-out:
+	queue_work(khelper_wq, &work);
+	wait_for_completion(&done);
 	return sub_info.retval;
 }
-
 EXPORT_SYMBOL(call_usermodehelper);
 
-#ifdef CONFIG_KMOD
-EXPORT_SYMBOL(request_module);
-#endif
-
+static __init int usermodehelper_init(void)
+{
+	khelper_wq = create_singlethread_workqueue("khelper");
+	BUG_ON(!khelper_wq);
+	return 0;
+}
+__initcall(usermodehelper_init);

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

