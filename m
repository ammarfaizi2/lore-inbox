Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWGaJVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWGaJVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 05:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWGaJVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 05:21:16 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:47174 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750837AbWGaJVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 05:21:15 -0400
Date: Mon, 31 Jul 2006 11:17:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, marcel@holtman.org,
       fpavlic@de.ibm.com, paulus@au1.ibm.com, bcollins@debian.org,
       tony.luck@intel.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [KJ] (re) audit return code handling for kernel_thread [1/3]
Message-ID: <20060731091757.GB9551@osiris.boeblingen.de.ibm.com>
References: <20060729201139.GA8574@localhost.localdomain> <20060729201555.GB8574@localhost.localdomain> <20060729170333.a45efeaf.akpm@osdl.org> <20060730004850.GA9344@localhost.localdomain> <20060730213936.GA10632@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730213936.GA10632@osiris.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 11:39:36PM +0200, Heiko Carstens wrote:
> > > > --- a/arch/s390/mm/cmm.c
> > > > +++ b/arch/s390/mm/cmm.c
> > > > @@ -161,7 +161,11 @@ cmm_thread(void *dummy)
> > > >  static void
> > > >  cmm_start_thread(void)
> > > >  {
> > > > -	kernel_thread(cmm_thread, NULL, 0);
> > > > +	if (kernel_thread(cmm_thread, NULL, 0) < 0) {
> > > > +		printk(KERN_WARNING "Could not start kernel thread at %s:%d\n",
> > > > +			__FUNCTION__,__LINE__);
> > > > +		clear_bit(0,&cmm_thread_active);
> > > > +	}
> > > >  }
> > > 
> > > This is OK as far as it goes.  But really we should propagate any failure
> > > back up to cmm_init() and fail the whole thing, rather than leaving the
> > > driver hanging around in a loaded-but-useless state.

Updated patch. This time against -mm. And actually it also works unlike
my first patch...

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[patch] s390: fix cmm kernel thread handling.

Convert cmm's usage of kernel_thread to kthread_run. Also create the
cmmthread at module load time, so it is possible to check if creation of
the thread fails.
In addition the cmmthread now gets terminated when the module gets unloaded
instead of leaving a stale kernel thread.
Also check the return values of other registration functions at module load
and handle their return values appropriately.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Index: linux-2.6.18-rc2-mm1/arch/s390/mm/cmm.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/s390/mm/cmm.c	2006-07-31 10:27:31.000000000 +0200
+++ linux-2.6.18-rc2-mm1/arch/s390/mm/cmm.c	2006-07-31 11:09:19.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/sysctl.h>
 #include <linux/ctype.h>
 #include <linux/swap.h>
+#include <linux/kthread.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -46,8 +47,7 @@
 static struct cmm_page_array *cmm_timed_page_list;
 static DEFINE_SPINLOCK(cmm_lock);
 
-static unsigned long cmm_thread_active;
-static struct work_struct cmm_thread_starter;
+static struct task_struct *cmm_thread_ptr;
 static wait_queue_head_t cmm_thread_wait;
 static struct timer_list cmm_timer;
 
@@ -159,14 +159,12 @@
 {
 	int rc;
 
-	daemonize("cmmthread");
 	while (1) {
 		rc = wait_event_interruptible(cmm_thread_wait,
 			(cmm_pages != cmm_pages_target ||
-			 cmm_timed_pages != cmm_timed_pages_target));
-		if (rc == -ERESTARTSYS) {
-			/* Got kill signal. End thread. */
-			clear_bit(0, &cmm_thread_active);
+			 cmm_timed_pages != cmm_timed_pages_target ||
+			 kthread_should_stop()));
+		if (kthread_should_stop() || rc == -ERESTARTSYS) {
 			cmm_pages_target = cmm_pages;
 			cmm_timed_pages_target = cmm_timed_pages;
 			break;
@@ -192,16 +190,8 @@
 }
 
 static void
-cmm_start_thread(void)
-{
-	kernel_thread(cmm_thread, NULL, 0);
-}
-
-static void
 cmm_kick_thread(void)
 {
-	if (!test_and_set_bit(0, &cmm_thread_active))
-		schedule_work(&cmm_thread_starter);
 	wake_up(&cmm_thread_wait);
 }
 
@@ -445,22 +435,48 @@
 static int
 cmm_init (void)
 {
+	int rc = -ENOMEM;
+
 #ifdef CONFIG_CMM_PROC
 	cmm_sysctl_header = register_sysctl_table(cmm_dir_table, 1);
+	if (!cmm_sysctl_header)
+		goto out;
 #endif
 #ifdef CONFIG_CMM_IUCV
-	smsg_register_callback(SMSG_PREFIX, cmm_smsg_target);
+	rc = smsg_register_callback(SMSG_PREFIX, cmm_smsg_target);
+	if (rc < 0)
+		goto out_smsg;
 #endif
-	register_oom_notifier(&cmm_oom_nb);
-	INIT_WORK(&cmm_thread_starter, (void *) cmm_start_thread, NULL);
+	rc = register_oom_notifier(&cmm_oom_nb);
+	if (rc < 0)
+		goto out_oom_notify;
 	init_waitqueue_head(&cmm_thread_wait);
 	init_timer(&cmm_timer);
-	return 0;
+	cmm_thread_ptr = kthread_run(cmm_thread, NULL, "cmmthread");
+	rc = IS_ERR(cmm_thread_ptr) ? PTR_ERR(cmm_thread_ptr) : 0;
+	if (!rc)
+		goto out;
+	/*
+	 * kthread_create failed. undo all the stuff from above again.
+	 */
+	unregister_oom_notifier(&cmm_oom_nb);
+
+out_oom_notify:
+#ifdef CONFIG_CMM_IUCV
+	smsg_unregister_callback(SMSG_PREFIX, cmm_smsg_target);
+out_smsg:
+#endif
+#ifdef CONFIG_CMM_PROC
+	unregister_sysctl_table(cmm_sysctl_header);
+#endif
+out:
+	return rc;
 }
 
 static void
 cmm_exit(void)
 {
+	kthread_stop(cmm_thread_ptr);
 	unregister_oom_notifier(&cmm_oom_nb);
 	cmm_free_pages(cmm_pages, &cmm_pages, &cmm_page_list);
 	cmm_free_pages(cmm_timed_pages, &cmm_timed_pages, &cmm_timed_page_list);
