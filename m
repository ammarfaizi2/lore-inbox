Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWG3VmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWG3VmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWG3VmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:42:06 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:10849 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S932312AbWG3VmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:42:05 -0400
Date: Sun, 30 Jul 2006 23:39:36 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, marcel@holtman.org,
       fpavlic@de.ibm.com, paulus@au1.ibm.com, bcollins@debian.org,
       tony.luck@intel.com
Subject: Re: [KJ] (re) audit return code handling for kernel_thread [1/3]
Message-ID: <20060730213936.GA10632@osiris.ibm.com>
References: <20060729201139.GA8574@localhost.localdomain> <20060729201555.GB8574@localhost.localdomain> <20060729170333.a45efeaf.akpm@osdl.org> <20060730004850.GA9344@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730004850.GA9344@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > --- a/arch/s390/mm/cmm.c
> > > +++ b/arch/s390/mm/cmm.c
> > > @@ -161,7 +161,11 @@ cmm_thread(void *dummy)
> > >  static void
> > >  cmm_start_thread(void)
> > >  {
> > > -	kernel_thread(cmm_thread, NULL, 0);
> > > +	if (kernel_thread(cmm_thread, NULL, 0) < 0) {
> > > +		printk(KERN_WARNING "Could not start kernel thread at %s:%d\n",
> > > +			__FUNCTION__,__LINE__);
> > > +		clear_bit(0,&cmm_thread_active);
> > > +	}
> > >  }
> > 
> > This is OK as far as it goes.  But really we should propagate any failure
> > back up to cmm_init() and fail the whole thing, rather than leaving the
> > driver hanging around in a loaded-but-useless state.
> 
> 
> Understood, new patch attached, that removes most of the additional failure to
> check return code cases.  I've left the cmm_start_thread case and the
> rfcomm_init cases as is, because the cmm_start_thread case is called
> asynchronously from a work queue, fired from a timer, meaning we cannot
> propogate the error to prevent the module from loading, and the rfcomm_init case
> does precisely what you ask, in that it detects a failure to start the kernel
> thread, and fails the module load if the thread creation fails.

The cmm stuff is a bit more broken than that it just doesn't take the return
value of kernel_thread into account. I think this patch would be better:

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[patch] s390: fix cmm kernel thread handling.

Convert cmm's usage of kernel_thread to kthread_create. Also create the
cmmthread at module load time, so it is possible to check if creation of
the thread fails.
In addition the cmmthread now gets terminated when the module gets unloaded
instead of leaving a stale kernel thread that would execute random data
if it ever would run again.
Also check the return values of other registration functions at module load
and handle their return values appropriately.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/mm/cmm.c |   45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index ceea51c..5428689 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/sysctl.h>
 #include <linux/ctype.h>
+#include <linux/kthread.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -44,8 +45,7 @@ static long cmm_timeout_seconds = 0;
 static struct cmm_page_array *cmm_page_list = NULL;
 static struct cmm_page_array *cmm_timed_page_list = NULL;
 
-static unsigned long cmm_thread_active = 0;
-static struct work_struct cmm_thread_starter;
+static struct task_struct *cmm_thread_ptr;
 static wait_queue_head_t cmm_thread_wait;
 static struct timer_list cmm_timer;
 
@@ -124,16 +124,11 @@ cmm_free_pages(long pages, long *counter
 static int
 cmm_thread(void *dummy)
 {
-	int rc;
-
-	daemonize("cmmthread");
 	while (1) {
-		rc = wait_event_interruptible(cmm_thread_wait,
-			(cmm_pages != cmm_pages_target ||
-			 cmm_timed_pages != cmm_timed_pages_target));
-		if (rc == -ERESTARTSYS) {
-			/* Got kill signal. End thread. */
-			clear_bit(0, &cmm_thread_active);
+		wait_event(cmm_thread_wait,
+			   (cmm_pages != cmm_pages_target ||
+			    cmm_timed_pages != cmm_timed_pages_target));
+		if (kthread_should_stop()) {
 			cmm_pages_target = cmm_pages;
 			cmm_timed_pages_target = cmm_timed_pages;
 			break;
@@ -159,16 +154,8 @@ cmm_thread(void *dummy)
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
 
@@ -412,21 +399,35 @@ struct ctl_table_header *cmm_sysctl_head
 static int
 cmm_init (void)
 {
+	int rc = 0;
+
+	cmm_thread_ptr = kthread_create(cmm_thread, NULL, "cmmthread");
+	if (IS_ERR(cmm_thread_ptr))
+		return PTR_ERR(cmm_thread_ptr);
 #ifdef CONFIG_CMM_PROC
 	cmm_sysctl_header = register_sysctl_table(cmm_dir_table, 1);
+	if (!cmm_sysctl_header) {
+		kthread_stop(cmm_thread_ptr);
+		return -ENOMEM;
+	}
 #endif
 #ifdef CONFIG_CMM_IUCV
-	smsg_register_callback(SMSG_PREFIX, cmm_smsg_target);
+	rc = smsg_register_callback(SMSG_PREFIX, cmm_smsg_target);
+	if (rc < 0) {
+		unregister_sysctl_table(cmm_sysctl_header);
+		kthread_stop(cmm_thread_ptr);
+		return rc;
+	}
 #endif
-	INIT_WORK(&cmm_thread_starter, (void *) cmm_start_thread, NULL);
 	init_waitqueue_head(&cmm_thread_wait);
 	init_timer(&cmm_timer);
-	return 0;
+	return rc;
 }
 
 static void
 cmm_exit(void)
 {
+	kthread_stop(cmm_thread_ptr);
 	cmm_free_pages(cmm_pages, &cmm_pages, &cmm_page_list);
 	cmm_free_pages(cmm_timed_pages, &cmm_timed_pages, &cmm_timed_page_list);
 #ifdef CONFIG_CMM_PROC
