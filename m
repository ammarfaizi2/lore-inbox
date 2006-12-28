Return-Path: <linux-kernel-owner+w=401wt.eu-S964976AbWL1If2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWL1If2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWL1If2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:35:28 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:44871 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964976AbWL1If1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:35:27 -0500
Date: Thu, 28 Dec 2006 14:09:51 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [FSAIO][PATCH 4/8] Add a default io wait bit field in task struct
Message-ID: <20061228083951.GD6971@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Allocates space for the default io wait queue entry (actually a wait
bit entry) in the task struct. Doing so simplifies the patches 
for AIO wait page allowing for cleaner and more efficient 
implementation, at the cost of 28 additional bytes in task struct
vs allocation on demand on-stack.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 linux-2.6.20-rc1-root/include/linux/sched.h |   11 +++++++----
 linux-2.6.20-rc1-root/kernel/fork.c         |    3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff -puN include/linux/sched.h~tsk-default-io-wait include/linux/sched.h
--- linux-2.6.20-rc1/include/linux/sched.h~tsk-default-io-wait	2006-12-21 08:45:51.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/sched.h	2006-12-28 09:32:39.000000000 +0530
@@ -1006,11 +1006,14 @@ struct task_struct {
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+
+/* Space for default IO wait bit entry used for synchronous IO waits */
+	struct wait_bit_queue __wait;
 /*
- * current io wait handle: wait queue entry to use for io waits
- * If this thread is processing aio, this points at the waitqueue
- * inside the currently handled kiocb. It may be NULL (i.e. default
- * to a stack based synchronous wait) if its doing sync IO.
+ * Current IO wait handle: wait queue entry to use for IO waits
+ * If this thread is processing AIO, this points at the waitqueue
+ * inside the currently handled kiocb. Otherwise, points to the
+ * default IO wait field (i.e &__wait.wait above).
  */
 	wait_queue_t *io_wait;
 /* i/o counters(bytes read/written, #syscalls */
diff -puN kernel/fork.c~tsk-default-io-wait kernel/fork.c
--- linux-2.6.20-rc1/kernel/fork.c~tsk-default-io-wait	2006-12-21 08:45:51.000000000 +0530
+++ linux-2.6.20-rc1-root/kernel/fork.c	2006-12-21 08:45:51.000000000 +0530
@@ -1056,7 +1056,8 @@ static struct task_struct *copy_process(
 	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
 	p->io_context = NULL;
-	p->io_wait = NULL;
+	init_wait_bit_task(&p->__wait, p);
+	p->io_wait = &p->__wait.wait;
 	p->audit_context = NULL;
 	cpuset_fork(p);
 #ifdef CONFIG_NUMA
_
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

