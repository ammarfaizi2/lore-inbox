Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWBXV2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWBXV2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWBXV2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:28:54 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:11525 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP id S932531AbWBXV2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:28:53 -0500
From: Paul Collins <paul@briny.ondioline.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kjournald keeps reference to namespace
References: <20060218013547.GA32706@MAIL.13thfloor.at>
	<20060217175428.7ce7b26f.akpm@osdl.org>
	<20060218033031.GB32706@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Fri, 24 Feb 2006 21:28:19 +0000
In-Reply-To: <20060218033031.GB32706@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Sat, 18 Feb 2006 04:30:31 +0100")
Message-ID: <873bi88n0s.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Fri, Feb 17, 2006 at 05:54:28PM -0800, Andrew Morton wrote:
>> I think it'd be better to convert ext3 to use the kthread API which
>> appears to accidentally not have this problem, because such threads
>> are parented by keventd, which were parented by init.
>
> sounds like a plan!

Here's my attempt at such a conversion.  Since jbd doesn't seem to
want to collect an exit status, I didn't bother with kthread_stop().

I got overexcited and also embedded the journal device in the process
name, but that's probably useless churn.  Looks nice in pstree though:

     |-kthread-+-kblockd/0
     |         |-khubd
     |         |-2*[pdflush]
     |         |-aio/0
     |         |-v9fs/0
     |         |-cqueue/0
     |         |-kfand
     |         |-kcryptd/0
     |         |-kjournald/3:3
     |         |-kjournald/3:8
     |         |-kjournald/3:4
     |         |-kjournald/3:5
     |         `-kjournald/254:1


Signed-off-by: Paul Collins <paul@ondioline.org>

diff --git a/fs/jbd/journal.c b/fs/jbd/journal.c
index e4b516a..e33d993 100644
--- a/fs/jbd/journal.c
+++ b/fs/jbd/journal.c
@@ -33,6 +33,8 @@
 #include <linux/mm.h>
 #include <linux/suspend.h>
 #include <linux/pagemap.h>
+#include <linux/kthread.h>
+#include <linux/kdev_t.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <linux/proc_fs.h>
@@ -115,8 +117,6 @@ static int kjournald(void *arg)
 	transaction_t *transaction;
 	struct timer_list timer;
 
-	daemonize("kjournald");
-
 	/* Set up an interval timer which can be used to trigger a
            commit wakeup after the commit interval expires */
 	init_timer(&timer);
@@ -207,12 +207,14 @@ end_loop:
 	journal->j_task = NULL;
 	wake_up(&journal->j_wait_done_commit);
 	jbd_debug(1, "Journal thread exiting.\n");
-	return 0;
+	do_exit(0);
 }
 
 static void journal_start_thread(journal_t *journal)
 {
-	kernel_thread(kjournald, journal, CLONE_VM|CLONE_FS|CLONE_FILES);
+	dev_t jdev = journal->j_dev->bd_dev;
+	kthread_run(kjournald, journal, "kjournald/%d:%d",
+		    MAJOR(jdev), MINOR(jdev), NULL);
 	wait_event(journal->j_wait_done_commit, journal->j_task != 0);
 }
 


-- 
Dag vijandelijk luchtschip de huismeester is dood
