Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266093AbUAFIJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 03:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUAFIJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 03:09:45 -0500
Received: from dp.samba.org ([66.70.73.150]:35245 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266093AbUAFIJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 03:09:41 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org, Davide Libenzi <davidel@xmailserver.org>
Cc: mingo@redhat.com, jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Testing of Kthread
Date: Tue, 06 Jan 2004 19:07:27 +1100
Message-Id: <20040106080939.7C0DA2C015@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the test code, in case someone wants to play.

Name: Simplified Kthread Tests
Author: Rusty Russell
Status: Booted on 2.6.1-rc2
Depends: Hotcpu-New-Kthread/kthread-simple.patch.gz

D: Test code for kthread primitives.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1277-linux-2.6.1-rc2/kernel/kthread.c .1277-linux-2.6.1-rc2.updated/kernel/kthread.c
--- .1277-linux-2.6.1-rc2/kernel/kthread.c	2004-01-06 18:59:37.000000000 +1100
+++ .1277-linux-2.6.1-rc2.updated/kernel/kthread.c	2004-01-06 18:59:59.000000000 +1100
@@ -169,3 +169,90 @@ int kthread_stop(struct task_struct *k)
 	wait_for_completion(&stop.done);
 	return stop.result;
 }
+
+/* Test code */
+#include <linux/init.h>
+
+static int threadfn_count;
+
+static int threadfn(void *data)
+{
+	BUG_ON(strcmp(current->comm, "kthreadtest1") != 0);
+
+	if (data == do_exit)
+		do_exit(0);
+
+	while (!signal_pending(current)) {
+		threadfn_count++;
+		current->state = TASK_INTERRUPTIBLE;
+		schedule();
+	}
+
+	return PTR_ERR(data);
+}
+
+static int test_kthreads(void)
+{
+	struct task_struct *k;
+	int ret;
+
+	printk("kthread_create.\n");
+	threadfn_count = 0;
+	k = kthread_create(threadfn, NULL, "kthreadtest%i", 1);
+	BUG_ON(IS_ERR(k));
+	BUG_ON(threadfn_count);
+
+	printk("kthread_start.\n");
+	kthread_start(k);
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(1);
+	BUG_ON(threadfn_count != 1);
+
+	printk("kthread threadfn.\n");
+	wake_up_process(k);
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(1);
+	BUG_ON(threadfn_count != 2);
+
+	printk("kthread_stop.\n");
+	ret = kthread_stop(k);
+	BUG_ON(threadfn_count != 2);
+	BUG_ON(ret != 0);
+
+	printk("kthread: stopped before starting\n");
+	threadfn_count = 0;
+	k = kthread_create(threadfn, NULL, "kthreadtest%i", 1);
+	BUG_ON(IS_ERR(k));
+	BUG_ON(threadfn_count);
+	ret = kthread_stop(k);
+	printk("ret = %i\n", ret);
+	BUG_ON(ret != -EINTR);
+	BUG_ON(threadfn_count);
+
+	printk("kthread: threadfn returns error.\n");
+	threadfn_count = 0;
+	k = kthread_create(threadfn, ERR_PTR(-EINVAL), "kthreadtest%i", 1);
+	BUG_ON(IS_ERR(k));
+	kthread_start(k);
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(1);
+	BUG_ON(threadfn_count != 1);
+	ret = kthread_stop(k);
+	BUG_ON(threadfn_count != 1);
+	BUG_ON(ret != -EINVAL);
+
+	printk("kthread: threadfn which exits.\n");
+	k = kthread_create(threadfn, do_exit, "kthreadtest%i", 1);
+	BUG_ON(IS_ERR(k));
+	get_task_struct(k);
+	kthread_start(k);
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(1);
+	BUG_ON(!(k->state & (TASK_ZOMBIE|TASK_DEAD)));
+	put_task_struct(k);
+
+	printk("All kthread tests passed...\n");
+	return 0;
+}
+
+module_init(test_kthreads);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
