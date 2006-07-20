Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWGTRDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWGTRDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWGTRDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:03:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:14293 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750703AbWGTRDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:03:14 -0400
Date: Thu, 20 Jul 2006 12:00:54 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, hugh@veritas.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-ID: <20060720170054.GB27601@sergelap.austin.ibm.com>
References: <20060627054612.GA15657@sergelap.austin.ibm.com> <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com> <20060711194932.GA27176@sergelap.austin.ibm.com> <20060711171752.4993903a.akpm@osdl.org> <20060712032647.GA24595@sergelap.austin.ibm.com> <20060711204637.bba6e966.akpm@osdl.org> <20060712230228.GA19656@sergelap.austin.ibm.com> <20060713023829.c19881be.akpm@osdl.org> <20060713133602.GH14665@sergelap.austin.ibm.com> <20060713075749.982b3478.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713075749.982b3478.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> On Thu, 13 Jul 2006 08:36:02 -0500
> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> > Quoting Andrew Morton (akpm@osdl.org):
> > 
> > > Again: why is this so hard?  It shouldn't be.  Perhaps because loop is
> > > using completions in bizarre ways where it should be using
> > > wake_up_process(), wait_event(), etc.
> > 
> > Ah.
> > 
> > wait_event() actually seems like the way to go - I'll try to follow the
> > example in fs/ocfs2/journal.c.
> 
> I suspect quite a lot of changes to loop.c would fall out.  For a start, in
> a sufficiently-simplified implementation lo_pending would perhaps go away -
> just test the NULLness of the top of the list of BIOs.

True - here is an attempt at that:

Subject: [PATCH] kthread: convert loop.c to kthread
From: Serge E. Hallyn <hallyn@sergelap.(none)>
Date: 1153345222 -0500

Convert loop.c from the deprecated kernel_thread to kthread.
This patch simplifies the code quite a bit and passes similar
testing to the previous submission on both emulated x86 and
s390.

Changes since last submission:
	switched to using a rather simple loop based on
	wait_event_interruptible.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 drivers/block/loop.c |   69 +++++++++++++++++---------------------------------
 include/linux/loop.h |    5 +---
 2 files changed, 26 insertions(+), 48 deletions(-)

c5f5e9d7016d6fb2b43aa4b13aea302ac367a28c
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7b3b94d..0468785 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -72,6 +72,7 @@
 #include <linux/completion.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
+#include <linux/kthread.h>
 
 #include <asm/uaccess.h>
 
@@ -522,15 +523,12 @@ static int loop_make_request(request_que
 		goto out;
 	if (unlikely(rw == WRITE && (lo->lo_flags & LO_FLAGS_READ_ONLY)))
 		goto out;
-	lo->lo_pending++;
 	loop_add_bio(lo, old_bio);
+	wake_up(&lo->lo_event);
 	spin_unlock_irq(&lo->lo_lock);
-	complete(&lo->lo_bh_done);
 	return 0;
 
 out:
-	if (lo->lo_pending == 0)
-		complete(&lo->lo_bh_done);
 	spin_unlock_irq(&lo->lo_lock);
 	bio_io_error(old_bio, old_bio->bi_size);
 	return 0;
@@ -570,14 +568,18 @@ static inline void loop_handle_bio(struc
  * to avoid blocking in our make_request_fn. it also does loop decrypting
  * on reads for block backed loop, as that is too heavy to do from
  * b_end_io context where irqs may be disabled.
+ *
+ * Loop explanation:  loop_clr_fd() sets lo_state to Lo_rundown before
+ * calling kthread_stop().  Therefore once kthread_should_stop() is
+ * true, make_request will not place any more requests.  Therefore
+ * once kthread_should_stop() is true and lo_bio is NULL, we are
+ * done with the loop.
  */
 static int loop_thread(void *data)
 {
 	struct loop_device *lo = data;
 	struct bio *bio;
 
-	daemonize("loop%d", lo->lo_number);
-
 	/*
 	 * loop can be used in an encrypted device,
 	 * hence, it mustn't be stopped at all
@@ -587,47 +589,21 @@ static int loop_thread(void *data)
 
 	set_user_nice(current, -20);
 
-	lo->lo_state = Lo_bound;
-	lo->lo_pending = 1;
-
-	/*
-	 * complete it, we are running
-	 */
-	complete(&lo->lo_done);
+	while (!kthread_should_stop() || lo->lo_bio) {
 
-	for (;;) {
-		int pending;
+		wait_event_interruptible(lo->lo_event,
+				lo->lo_bio || kthread_should_stop());
 
-		if (wait_for_completion_interruptible(&lo->lo_bh_done))
+		if (!lo->lo_bio)
 			continue;
-
 		spin_lock_irq(&lo->lo_lock);
-
-		/*
-		 * could be completed because of tear-down, not pending work
-		 */
-		if (unlikely(!lo->lo_pending)) {
-			spin_unlock_irq(&lo->lo_lock);
-			break;
-		}
-
 		bio = loop_get_bio(lo);
-		lo->lo_pending--;
-		pending = lo->lo_pending;
 		spin_unlock_irq(&lo->lo_lock);
 
 		BUG_ON(!bio);
 		loop_handle_bio(lo, bio);
-
-		/*
-		 * upped both for pending work and tear-down, lo_pending
-		 * will hit zero then
-		 */
-		if (unlikely(!pending))
-			break;
 	}
 
-	complete(&lo->lo_done);
 	return 0;
 }
 
@@ -837,10 +813,15 @@ static int loop_set_fd(struct loop_devic
 
 	set_blocksize(bdev, lo_blocksize);
 
-	error = kernel_thread(loop_thread, lo, CLONE_KERNEL);
-	if (error < 0)
+	lo->lo_thread = kthread_create(loop_thread, lo, "loop%d",
+						lo->lo_number);
+	if (IS_ERR(lo->lo_thread)) {
+		error = PTR_ERR(lo->lo_thread);
+		lo->lo_thread = NULL;
 		goto out_putf;
-	wait_for_completion(&lo->lo_done);
+	}
+	lo->lo_state = Lo_bound;
+	wake_up_process(lo->lo_thread);
 	return 0;
 
  out_putf:
@@ -904,12 +885,9 @@ static int loop_clr_fd(struct loop_devic
 
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
-	lo->lo_pending--;
-	if (!lo->lo_pending)
-		complete(&lo->lo_bh_done);
 	spin_unlock_irq(&lo->lo_lock);
 
-	wait_for_completion(&lo->lo_done);
+	kthread_stop(lo->lo_thread);
 
 	lo->lo_backing_file = NULL;
 
@@ -922,6 +900,7 @@ static int loop_clr_fd(struct loop_devic
 	lo->lo_sizelimit = 0;
 	lo->lo_encrypt_key_size = 0;
 	lo->lo_flags = 0;
+	lo->lo_thread = NULL;
 	memset(lo->lo_encrypt_key, 0, LO_KEY_SIZE);
 	memset(lo->lo_crypt_name, 0, LO_NAME_SIZE);
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
@@ -1284,9 +1263,9 @@ static int __init loop_init(void)
 		if (!lo->lo_queue)
 			goto out_mem4;
 		mutex_init(&lo->lo_ctl_mutex);
-		init_completion(&lo->lo_done);
-		init_completion(&lo->lo_bh_done);
 		lo->lo_number = i;
+		lo->lo_thread = NULL;
+		init_waitqueue_head(&lo->lo_event);
 		spin_lock_init(&lo->lo_lock);
 		disk->major = LOOP_MAJOR;
 		disk->first_minor = i;
diff --git a/include/linux/loop.h b/include/linux/loop.h
index e76c761..191a595 100644
--- a/include/linux/loop.h
+++ b/include/linux/loop.h
@@ -59,10 +59,9 @@ struct loop_device {
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
 	int			lo_state;
-	struct completion	lo_done;
-	struct completion	lo_bh_done;
 	struct mutex		lo_ctl_mutex;
-	int			lo_pending;
+	struct task_struct	*lo_thread;
+	wait_queue_head_t	lo_event;
 
 	request_queue_t		*lo_queue;
 };
-- 
1.1.6
