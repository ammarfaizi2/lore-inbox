Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUCNXDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 18:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUCNXDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 18:03:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:38277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262002AbUCNXDn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 18:03:43 -0500
Date: Sun, 14 Mar 2004 15:03:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: mru@kth.se (=?ISO-8859-1?B?TeVucyBSdWxsZ+VyZA==?=)
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: kernel threads holding /dev/console
Message-Id: <20040314150346.387b59a6.akpm@osdl.org>
In-Reply-To: <yw1x8yi3dpz8.fsf@ford.guide>
References: <yw1x8yi3dpz8.fsf@ford.guide>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) wrote:
>
> I'm trying to set up a pivot_root hack to do some things, switch root,
>  and then unmount the original root.  However, the unmount fails
>  because ksoftirqd/0, events/0, kblockd/0 and aio/0 have /dev/console
>  opened.  Why are they doing this?  Can it be prevented?  This happens
>  when using kernel 2.6.3 (2.6.4 is reportedly broken on Alpha).  It
>  works with a 2.4 kernel using the same script.  Does anyone have a
>  hint?

That's a bug.



keventd and friends are currently holding /dev/console open three times. 
It's all inherited from init.

Steal the relevant parts of daemonize() to fix that up.


---

 25-akpm/kernel/kthread.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+)

diff -puN kernel/kthread.c~kthread-keeps-files-open kernel/kthread.c
--- 25/kernel/kthread.c~kthread-keeps-files-open	2004-03-14 14:49:21.679226616 -0800
+++ 25-akpm/kernel/kthread.c	2004-03-14 14:57:18.425750128 -0800
@@ -10,6 +10,7 @@
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/unistd.h>
+#include <linux/file.h>
 #include <asm/semaphore.h>
 
 struct kthread_create_info
@@ -41,6 +42,21 @@ int kthread_should_stop(void)
 	return (kthread_stop_info.k == current);
 }
 
+
+static void kthread_exit_files(void)
+{
+	struct fs_struct *fs;
+	struct task_struct *tsk = current;
+
+	exit_fs(tsk);		/* current->fs->count--; */
+	fs = init_task.fs;
+	tsk->fs = fs;
+	atomic_inc(&fs->count);
+ 	exit_files(tsk);
+	current->files = init_task.files;
+	atomic_inc(&tsk->files->count);
+}
+
 static int kthread(void *_create)
 {
 	struct kthread_create_info *create = _create;
@@ -50,6 +66,8 @@ static int kthread(void *_create)
 	int ret = -EINTR;
 	cpumask_t mask = CPU_MASK_ALL;
 
+	kthread_exit_files();
+
 	/* Copy data: it's on keventd's stack */
 	threadfn = create->threadfn;
 	data = create->data;

_

