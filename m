Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbULMGso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbULMGso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 01:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbULMGso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 01:48:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:60824 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262211AbULMGs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 01:48:28 -0500
Date: Mon, 13 Dec 2004 07:47:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Message-ID: <20041213064719.GA3681@elte.hu>
References: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com> <1102897004.31218.8.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102897004.31218.8.camel@cmn37.stanford.edu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Something that just happened to me: running 0.7.32-14
> (PREEMPT_DESKTOP) and trying to install 0.7.32-19 from a custom built
> rpm package completely hangs the machine (p4 laptop - I tried twice).
> No clues left behind. If I boot into 0.7.32-9 I can install 0.7.32-19
> with no problems. 

does 0.7.32-19 work better if you reverse (patch -R) the loop.h and
loop.c bits (see below)?

	Ingo

--- linux/drivers/block/loop.c.orig
+++ linux/drivers/block/loop.c
@@ -378,7 +378,7 @@ static void loop_add_bio(struct loop_dev
 		lo->lo_bio = lo->lo_biotail = bio;
 	spin_unlock_irqrestore(&lo->lo_lock, flags);
 
-	up(&lo->lo_bh_mutex);
+	complete(&lo->lo_bh_done);
 }
 
 /*
@@ -427,7 +427,7 @@ static int loop_make_request(request_que
 	return 0;
 err:
 	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
+		complete(&lo->lo_bh_done);
 out:
 	bio_io_error(old_bio, old_bio->bi_size);
 	return 0;
@@ -495,12 +495,12 @@ static int loop_thread(void *data)
 	/*
 	 * up sem, we are running
 	 */
-	up(&lo->lo_sem);
+	complete(&lo->lo_done);
 
 	for (;;) {
-		down_interruptible(&lo->lo_bh_mutex);
+		wait_for_completion_interruptible(&lo->lo_bh_done);
 		/*
-		 * could be upped because of tear-down, not because of
+		 * could be completed because of tear-down, not because of
 		 * pending work
 		 */
 		if (!atomic_read(&lo->lo_pending))
@@ -521,7 +521,7 @@ static int loop_thread(void *data)
 			break;
 	}
 
-	up(&lo->lo_sem);
+	complete(&lo->lo_done);
 	return 0;
 }
 
@@ -708,7 +708,7 @@ static int loop_set_fd(struct loop_devic
 	set_blocksize(bdev, lo_blocksize);
 
 	kernel_thread(loop_thread, lo, CLONE_KERNEL);
-	down(&lo->lo_sem);
+	wait_for_completion(&lo->lo_done);
 	return 0;
 
  out_putf:
@@ -773,10 +773,10 @@ static int loop_clr_fd(struct loop_devic
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
 	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
+		complete(&lo->lo_bh_done);
 	spin_unlock_irq(&lo->lo_lock);
 
-	down(&lo->lo_sem);
+	wait_for_completion(&lo->lo_done);
 
 	lo->lo_backing_file = NULL;
 
@@ -1153,8 +1153,8 @@ int __init loop_init(void)
 		if (!lo->lo_queue)
 			goto out_mem4;
 		init_MUTEX(&lo->lo_ctl_mutex);
-		init_MUTEX_LOCKED(&lo->lo_sem);
-		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
+		init_completion(&lo->lo_done);
+		init_completion(&lo->lo_bh_done);
 		lo->lo_number = i;
 		spin_lock_init(&lo->lo_lock);
 		disk->major = LOOP_MAJOR;
--- linux/include/linux/loop.h.orig
+++ linux/include/linux/loop.h
@@ -58,9 +58,9 @@ struct loop_device {
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
 	int			lo_state;
-	struct semaphore	lo_sem;
+	struct completion	lo_done;
+	struct completion	lo_bh_done;
 	struct semaphore	lo_ctl_mutex;
-	struct semaphore	lo_bh_mutex;
 	atomic_t		lo_pending;
 
 	request_queue_t		*lo_queue;
