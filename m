Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbUKCJNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbUKCJNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUKCJLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:11:55 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61397 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261499AbUKCJKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:10:38 -0500
Date: Wed, 3 Nov 2004 14:50:14 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       wli@holomorphy.com
Subject: Re: [PATCH 4/6] Add default io wait bit field in task struct
Message-ID: <20041103092014.GD5737@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20041103091036.GA4041@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103091036.GA4041@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:40:36PM +0530, Suparna Bhattacharya wrote:
> 
> The series of patches that follow integrate AIO with 
> William Lee Irwin's wait bit changes, to support asynchronous
> page waits.
> 
> [1] modify-wait-bit-action-args.patch
> 	Add a wait queue arg to the wait_bit action() routine
> 
> [2] lock_page_slow.patch
> 	Rename __lock_page to lock_page_slow
> 
> [3] init-wait-bit-key.patch
> 	Interfaces to init and to test wait bit key
> 
> [4] tsk-default-io-wait.patch
> 	Add default io wait bit field in task struct
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

--------------------------------------------------------


Allocates space for the default io wait queue entry (actually a wait
bit entry) in the task struct. Doing so simplifies the patches 
for AIO wait page allowing for cleaner and more efficient 
implementation, at the cost of 28 additional bytes in task struct
vs allocation on demand on-stack.

Thanks to Vatsa for helping debug and fix a problem with wait bit
initializtion.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

diff -puN include/linux/sched.h~tsk-default-io-wait include/linux/sched.h


 linux-2.6.10-rc1-suparna/include/linux/sched.h |   11 +++++++----
 linux-2.6.10-rc1-suparna/kernel/fork.c         |    3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff -puN include/linux/sched.h~tsk-default-io-wait include/linux/sched.h
--- linux-2.6.10-rc1/include/linux/sched.h~tsk-default-io-wait	2004-11-03 14:35:13.000000000 +0530
+++ linux-2.6.10-rc1-suparna/include/linux/sched.h	2004-11-03 14:35:13.000000000 +0530
@@ -652,11 +652,14 @@ struct task_struct {
 
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
--- linux-2.6.10-rc1/kernel/fork.c~tsk-default-io-wait	2004-11-03 14:35:13.000000000 +0530
+++ linux-2.6.10-rc1-suparna/kernel/fork.c	2004-11-03 14:35:13.000000000 +0530
@@ -870,7 +870,8 @@ static task_t *copy_process(unsigned lon
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
