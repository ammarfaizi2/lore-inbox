Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbWFOOng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbWFOOng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWFOOnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:43:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:20686 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030463AbWFOOne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:43:34 -0400
Date: Thu, 15 Jun 2006 09:43:31 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kthread: convert stop_machine into a kthread
Message-ID: <20060615144331.GB16046@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update stop_machine.c to spawn stop_machine as kthreads rather
than the deprecated kernel_threads.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 kernel/stop_machine.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

ce04ccc88ac3e2e6c3942fe2c8c4b2d5492d8397
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index dcfb5d7..2dd5a48 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -4,6 +4,7 @@ #include <linux/sched.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/syscalls.h>
+#include <linux/kthread.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -96,11 +97,14 @@ static int stop_machine(void)
 	stopmachine_state = STOPMACHINE_WAIT;
 
 	for_each_online_cpu(i) {
+		struct task_struct *tsk;
 		if (i == raw_smp_processor_id())
 			continue;
-		ret = kernel_thread(stopmachine, (void *)(long)i,CLONE_KERNEL);
-		if (ret < 0)
+		tsk = kthread_run(stopmachine, (void *)(long)i, "stopmachine");
+		if (IS_ERR(tsk)) {
+			ret = PTR_ERR(tsk);
 			break;
+		}
 		stopmachine_num_threads++;
 	}
 
-- 
1.3.3

