Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVFTQXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVFTQXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVFTQWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:22:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:60565 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261379AbVFTQUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:20:53 -0400
Date: Mon, 20 Jun 2005 22:00:11 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: Re: [PATCH 4/6] Add default io wait bit field in task struct
Message-ID: <20050620163011.GD5380@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620160126.GA5271@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 09:31:26PM +0530, Suparna Bhattacharya wrote:
> > (1) Updating AIO to use wait-bit based filtered wakeups (me/wli)
> > 	Status: Updated to 2.6.12-rc6, needs review
> 


Allocates space for the default io wait queue entry (actually a wait
bit entry) in the task struct. Doing so simplifies the patches 
for AIO wait page allowing for cleaner and more efficient 
implementation, at the cost of 28 additional bytes in task struct
vs allocation on demand on-stack.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

 include/linux/sched.h |   11 +++++++----
 kernel/fork.c         |    3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff -puN include/linux/sched.h~tsk-default-io-wait include/linux/sched.h
--- linux-2.6.9-rc1-mm4/include/linux/sched.h~tsk-default-io-wait	2004-09-20 14:05:09.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/include/linux/sched.h	2004-09-20 15:14:25.000000000 +0530
@@ -584,11 +584,14 @@ struct task_struct {
 
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
 #ifdef CONFIG_NUMA
diff -puN kernel/fork.c~tsk-default-io-wait kernel/fork.c
--- linux-2.6.9-rc1-mm4/kernel/fork.c~tsk-default-io-wait	2004-09-20 14:05:09.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/kernel/fork.c	2004-09-20 15:15:22.000000000 +0530
@@ -859,7 +859,8 @@ static task_t *copy_process(unsigned lon
 	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
 	p->io_context = NULL;
-	p->io_wait = NULL;
+	init_wait_bit_task(&p->__wait, p);
+	p->io_wait = &p->__wait.wait;
 	p->audit_context = NULL;
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);

_

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

