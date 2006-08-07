Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWHGQ57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWHGQ57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWHGQ57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:57:59 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15055 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932161AbWHGQ55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:57:57 -0400
Date: Mon, 7 Aug 2006 11:57:36 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
       linux-laptop@vger.kernel.org, ben-s3c2410@fluff.org
Subject: [PATCH 2/3] kthread: switch arch/arm/kernel/apm.c
Message-ID: <20060807165736.GB11208@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch arch/arm/kernel/apm.c from using kernel_thread - whose export
is deprecated - to kthread.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 arch/arm/kernel/apm.c |   33 +++++++++++++--------------------
 1 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/apm.c b/arch/arm/kernel/apm.c
index 33c5568..ecf4f94 100644
--- a/arch/arm/kernel/apm.c
+++ b/arch/arm/kernel/apm.c
@@ -25,6 +25,7 @@ #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/completion.h>
+#include <linux/kthread.h>
 
 #include <asm/apm.h> /* apm_power_info */
 #include <asm/system.h>
@@ -80,7 +81,7 @@ #define SUSPEND_DONE	4		/* suspend compl
  */
 static int suspends_pending;
 static int apm_disabled;
-static int arm_apm_active;
+static struct task_struct *kapmd_tsk;
 
 static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
@@ -97,7 +98,6 @@ static LIST_HEAD(apm_user_list);
  * to be suspending the system.
  */
 static DECLARE_WAIT_QUEUE_HEAD(kapmd_wait);
-static DECLARE_COMPLETION(kapmd_exit);
 static DEFINE_SPINLOCK(kapmd_queue_lock);
 static struct apm_queue kapmd_queue;
 
@@ -468,16 +468,13 @@ #endif
 
 static int kapmd(void *arg)
 {
-	daemonize("kapmd");
-	current->flags |= PF_NOFREEZE;
-
 	do {
 		apm_event_t event;
 
 		wait_event_interruptible(kapmd_wait,
-				!queue_empty(&kapmd_queue) || !arm_apm_active);
+				!queue_empty(&kapmd_queue) || kthread_should_stop());
 
-		if (!arm_apm_active)
+		if (kthread_should_stop())
 			break;
 
 		spin_lock_irq(&kapmd_queue_lock);
@@ -508,7 +505,7 @@ static int kapmd(void *arg)
 		}
 	} while (1);
 
-	complete_and_exit(&kapmd_exit, 0);
+	return 0;
 }
 
 static int __init apm_init(void)
@@ -520,13 +517,14 @@ static int __init apm_init(void)
 		return -ENODEV;
 	}
 
-	arm_apm_active = 1;
-
-	ret = kernel_thread(kapmd, NULL, CLONE_KERNEL);
-	if (ret < 0) {
-		arm_apm_active = 0;
+	kapmd_tsk = kthread_create(kapmd, NULL, "kapmd");
+	if (IS_ERR(kapmd_tsk)) {
+		ret = PTR_ERR(kapmd_tsk);
+		kapmd_tsk = NULL;
 		return ret;
 	}
+	kapmd_tsk->flags |= PF_NOFREEZE;
+	wake_up_process(kapmd_tsk);
 
 #ifdef CONFIG_PROC_FS
 	create_proc_info_entry("apm", 0, NULL, apm_get_info);
@@ -535,10 +533,7 @@ #endif
 	ret = misc_register(&apm_device);
 	if (ret != 0) {
 		remove_proc_entry("apm", NULL);
-
-		arm_apm_active = 0;
-		wake_up(&kapmd_wait);
-		wait_for_completion(&kapmd_exit);
+		kthread_stop(kapmd_tsk);
 	}
 
 	return ret;
@@ -549,9 +544,7 @@ static void __exit apm_exit(void)
 	misc_deregister(&apm_device);
 	remove_proc_entry("apm", NULL);
 
-	arm_apm_active = 0;
-	wake_up(&kapmd_wait);
-	wait_for_completion(&kapmd_exit);
+	kthread_stop(kapmd_tsk);
 }
 
 module_init(apm_init);
-- 
1.4.1.1

