Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUBPWoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUBPWoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:44:12 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:9924 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265941AbUBPWn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:43:28 -0500
Date: Mon, 16 Feb 2004 17:43:08 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][2.6-mm] kernel/kmod.c kernel/kthread.c NR_CPUS fixes
Message-ID: <Pine.LNX.4.58.0402161701240.11793@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needed to compile with high NR_CPUS, Rusty try not to cringe too much =)

Index: linux-2.6.3-rc3-mm1-test/kernel/kmod.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.3-rc3-mm1/kernel/kmod.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 kmod.c
--- linux-2.6.3-rc3-mm1-test/kernel/kmod.c	16 Feb 2004 20:42:49 -0000	1.1.1.1
+++ linux-2.6.3-rc3-mm1-test/kernel/kmod.c	16 Feb 2004 21:40:49 -0000
@@ -148,6 +148,7 @@ struct subprocess_info {
  */
 static int ____call_usermodehelper(void *data)
 {
+	const cpumask_t mask = CPU_MASK_ALL;
 	struct subprocess_info *sub_info = data;
 	int retval;

@@ -160,7 +161,7 @@ static int ____call_usermodehelper(void
 	spin_unlock_irq(&current->sighand->siglock);

 	/* We can run anywhere, unlike our parent keventd(). */
-	set_cpus_allowed(current, CPU_MASK_ALL);
+	set_cpus_allowed(current, mask);
 	retval = -EPERM;
 	if (current->fs->root)
 		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
Index: linux-2.6.3-rc3-mm1-test/kernel/kthread.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.3-rc3-mm1/kernel/kthread.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 kthread.c
--- linux-2.6.3-rc3-mm1-test/kernel/kthread.c	16 Feb 2004 20:42:49 -0000	1.1.1.1
+++ linux-2.6.3-rc3-mm1-test/kernel/kthread.c	16 Feb 2004 21:43:40 -0000
@@ -29,6 +29,7 @@ struct kthread_create_info
 /* Returns so that WEXITSTATUS(ret) == errno. */
 static int kthread(void *_create)
 {
+	const cpumask_t mask = CPU_MASK_ALL;
 	struct kthread_create_info *create = _create;
 	int (*threadfn)(void *data);
 	void *data;
@@ -45,7 +46,7 @@ static int kthread(void *_create)
 	flush_signals(current);

 	/* By default we can run anywhere, unlike keventd. */
-	set_cpus_allowed(current, CPU_MASK_ALL);
+	set_cpus_allowed(current, mask);

 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);
