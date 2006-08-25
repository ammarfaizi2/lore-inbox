Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422885AbWHYUET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422885AbWHYUET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422886AbWHYUET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:04:19 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:4044 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422885AbWHYUES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:04:18 -0400
Date: Fri, 25 Aug 2006 15:03:59 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com
Subject: Re: [PATCH 1/3] kthread: update s390 cmm driver to use kthread
Message-ID: <20060825200359.GC13805@sergelap.austin.ibm.com>
References: <20060824212241.GB30007@sergelap.austin.ibm.com> <20060825143842.GA27364@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825143842.GA27364@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christoph Hellwig (hch@infradead.org):
> On Thu, Aug 24, 2006 at 04:22:42PM -0500, Serge E. Hallyn wrote:
> > Update the s390 cooperative memory manager, which can be a module,
> > to use kthread rather than kernel_thread, whose EXPORT is deprecated.
> > 
> > This patch compiles and boots fine, but I don't know how to really
> > test the driver.
> 
> NACK.  Please do a real conversion to the kthread paradigm instead of
> doctoring around the trivial bits that could be changed with a script.
> 
> Please use kthread_should_stop() and remove the cmm_thread_wait
> waitqueue in favour of wake_up_process.  The timer useage could
> probably be replaced with smart usage of schedule_timeout().
> Also the code seems to miss a proper thread termination on module
> removal.

Ok, the patch in -mm does kthread_stop() on module_exit, but still uses
the timer and cmm_thread_wait.  

I'm not clear what the timer is actually trying to do, or why there is a
separate cmm_pages_target and cmm_timed_pages_target.  So I'm sure the
below patch on top of -mm2 is wrong (it compiles, but I just noticed
2.6.18-rc4-mm2 doesn't boot without this patch either) but hopefully
Heiko or Martin can tell me what would be the right way, or implement
it?

thanks,
-serge

Subject: [PATCH] s390: stop using cmm_thread_wait and cmm_timer in cmm

Update cmm to stop using cmm_thread_wait or cmm_timer.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 arch/s390/mm/cmm.c |   67 +++++++++-------------------------------------------
 1 files changed, 12 insertions(+), 55 deletions(-)

4182dbd937e5084db4cfd63193ff93267ea8042e
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 9b62157..ecd237a 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -48,11 +48,6 @@ static struct cmm_page_array *cmm_timed_
 static DEFINE_SPINLOCK(cmm_lock);
 
 static struct task_struct *cmm_thread_ptr;
-static wait_queue_head_t cmm_thread_wait;
-static struct timer_list cmm_timer;
-
-static void cmm_timer_fn(unsigned long);
-static void cmm_set_timer(void);
 
 static long
 cmm_strtoul(const char *cp, char **endp)
@@ -157,18 +152,10 @@ static struct notifier_block cmm_oom_nb 
 static int
 cmm_thread(void *dummy)
 {
-	int rc;
+	while (!kthread_should_stop()) {
 
-	while (1) {
-		rc = wait_event_interruptible(cmm_thread_wait,
-			(cmm_pages != cmm_pages_target ||
-			 cmm_timed_pages != cmm_timed_pages_target ||
-			 kthread_should_stop()));
-		if (kthread_should_stop() || rc == -ERESTARTSYS) {
-			cmm_pages_target = cmm_pages;
-			cmm_timed_pages_target = cmm_timed_pages;
+		if (kthread_should_stop())
 			break;
-		}
 		if (cmm_pages_target > cmm_pages) {
 			if (cmm_alloc_pages(1, &cmm_pages, &cmm_page_list))
 				cmm_pages_target = cmm_pages;
@@ -183,48 +170,19 @@ cmm_thread(void *dummy)
 			cmm_free_pages(1, &cmm_timed_pages,
 			       	       &cmm_timed_page_list);
 		}
-		if (cmm_timed_pages > 0 && !timer_pending(&cmm_timer))
-			cmm_set_timer();
+
+		__set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(cmm_timeout_seconds*HZ);
 	}
+
 	return 0;
 }
 
 static void
 cmm_kick_thread(void)
 {
-	wake_up(&cmm_thread_wait);
-}
-
-static void
-cmm_set_timer(void)
-{
-	if (cmm_timed_pages_target <= 0 || cmm_timeout_seconds <= 0) {
-		if (timer_pending(&cmm_timer))
-			del_timer(&cmm_timer);
-		return;
-	}
-	if (timer_pending(&cmm_timer)) {
-		if (mod_timer(&cmm_timer, jiffies + cmm_timeout_seconds*HZ))
-			return;
-	}
-	cmm_timer.function = cmm_timer_fn;
-	cmm_timer.data = 0;
-	cmm_timer.expires = jiffies + cmm_timeout_seconds*HZ;
-	add_timer(&cmm_timer);
-}
-
-static void
-cmm_timer_fn(unsigned long ignored)
-{
-	long nr;
-
-	nr = cmm_timed_pages_target - cmm_timeout_pages;
-	if (nr < 0)
-		cmm_timed_pages_target = 0;
-	else
-		cmm_timed_pages_target = nr;
-	cmm_kick_thread();
-	cmm_set_timer();
+	if (cmm_thread_ptr)
+		wake_up_process(cmm_thread_ptr);
 }
 
 void
@@ -258,7 +216,6 @@ cmm_set_timeout(long nr, long seconds)
 {
 	cmm_timeout_pages = nr;
 	cmm_timeout_seconds = seconds;
-	cmm_set_timer();
 }
 
 static inline int
@@ -450,12 +407,12 @@ cmm_init (void)
 	rc = register_oom_notifier(&cmm_oom_nb);
 	if (rc < 0)
 		goto out_oom_notify;
-	init_waitqueue_head(&cmm_thread_wait);
-	init_timer(&cmm_timer);
 	cmm_thread_ptr = kthread_run(cmm_thread, NULL, "cmmthread");
-	rc = IS_ERR(cmm_thread_ptr) ? PTR_ERR(cmm_thread_ptr) : 0;
-	if (!rc)
+	if (IS_ERR(cmm_thread_ptr)) {
+		rc = PTR_ERR(cmm_thread_ptr);
+		cmm_thread_ptr = NULL;
 		goto out;
+	}
 	/*
 	 * kthread_create failed. undo all the stuff from above again.
 	 */
-- 
1.1.6
