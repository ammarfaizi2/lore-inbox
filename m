Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUBAICP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 03:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265231AbUBAICP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 03:02:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:33429 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265230AbUBAICM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 03:02:12 -0500
Date: Sun, 1 Feb 2004 00:03:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au, dipankar@in.ibm.com,
       vatsa@in.ibm.com, mingo@redhat.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core
Message-Id: <20040201000314.233e05a7.akpm@osdl.org>
In-Reply-To: <20040131141937.E58852C082@lists.samba.org>
References: <20040131141937.E58852C082@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>  The actual CPU patch.  It's big, but almost all under
>  CONFIG_HOTPLUG_CPU, or macros which have same effect.

Needs a fixup.



CPU_MASK_ALL and CPU_MASK_NONE may only be used for initialisers.  It
doesn't compile if NR_CPUS>4*BITS_PER_LONG.  Fixes to the cpumask
infrastructure for this remain welcome.



---

 25-akpm/kernel/kmod.c    |    5 +++--
 25-akpm/kernel/kthread.c |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff -puN kernel/kmod.c~set_cpus_allowed-fix kernel/kmod.c
--- 25/kernel/kmod.c~set_cpus_allowed-fix	Sun Feb  1 02:21:19 2004
+++ 25-akpm/kernel/kmod.c	Sun Feb  1 02:21:19 2004
@@ -159,6 +159,7 @@ struct subprocess_info {
 static int ____call_usermodehelper(void *data)
 {
 	struct subprocess_info *sub_info = data;
+	static cpumask_t all_cpus = CPU_MASK_ALL;
 	int retval;
 
 	/* Unblock all signals. */
@@ -170,12 +171,12 @@ static int ____call_usermodehelper(void 
 	spin_unlock_irq(&current->sighand->siglock);
 
 	/* We can run anywhere, unlike our parent keventd(). */
-	set_cpus_allowed(current, CPU_MASK_ALL);
+	set_cpus_allowed(current, all_cpus);
 	/* As a kernel thread which was bound to a specific cpu,
 	   migrate_all_tasks wouldn't touch us.  Avoid running child
 	   on dying CPU. */
 	if (cpu_is_offline(smp_processor_id()))
-		migrate_to_cpu(any_online_cpu(CPU_MASK_ALL));
+		migrate_to_cpu(any_online_cpu(all_cpus));
 
 	retval = -EPERM;
 	if (current->fs->root)
diff -puN kernel/kthread.c~set_cpus_allowed-fix kernel/kthread.c
--- 25/kernel/kthread.c~set_cpus_allowed-fix	Sun Feb  1 02:21:19 2004
+++ 25-akpm/kernel/kthread.c	Sun Feb  1 02:21:19 2004
@@ -35,6 +35,7 @@ static int kthread(void *_create)
 	void *data;
 	sigset_t blocked;
 	int ret = -EINTR;
+	static cpumask_t all_cpus = CPU_MASK_ALL;
 
 	/* Copy data: it's on keventd's stack */
 	threadfn = create->threadfn;
@@ -46,13 +47,13 @@ static int kthread(void *_create)
 	flush_signals(current);
 
 	/* By default we can run anywhere, unlike keventd. */
-	set_cpus_allowed(current, CPU_MASK_ALL);
+	set_cpus_allowed(current, all_cpus);
 
 	/* As a kernel thread which was bound to a specific cpu,
 	   migrate_all_tasks wouldn't touch us.  Avoid running on
 	   dying CPU. */
 	if (cpu_is_offline(smp_processor_id()))
-		migrate_to_cpu(any_online_cpu(CPU_MASK_ALL));
+		migrate_to_cpu(any_online_cpu(all_cpus));
 
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);

_

