Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUIMI3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUIMI3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 04:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUIMI3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 04:29:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60310 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266425AbUIMI3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 04:29:50 -0400
Date: Mon, 13 Sep 2004 10:31:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kirill Korotaev <dev@sw.ru>
Cc: Roel van der Made <roel@telegraafnet.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, wli@holomorphy.com
Subject: Re: [PATCH]: Re: kernel 2.6.9-rc1-mm4 oops
Message-ID: <20040913083100.GA16921@elte.hu>
References: <20040912184804.GC19067@telegraafnet.nl> <4145550F.8030601@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4145550F.8030601@sw.ru>
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


* Kirill Korotaev <dev@sw.ru> wrote:

> This patch removes sighand checks from the next_thread(), since they
> are incorrect and has nothing to do with the next_thread() function.
> So they could trigger BUG() when there were no actually bug at all.

the problem is, generally it is not valid to have a thread on the thread
list that has no ->sighand structure. This is what happens when we exit
a task:

        write_lock_irq(&tasklist_lock);
	...
        __exit_sighand(p);
        __unhash_process(p);

the BUG() is useful for all the code that uses next_thread() - you can
only do a safe next_thread() iteration if you've locked ->sighand.

there's one exception: in the procfs code we can get a reference to
almost-dead tasks as well that are not even in the tasklist. (This is a
relatively new thing introduced by me that can happen due to the
preemptability of some of the exit path.)

so i believe your fix papers over the real bug which is the use of an
almost-dead task for thread iterations. Since we've already done
__unhash_process() not doing the BUG introduces a more subtle bug: the
use of the stale PID pointers! So i believe the right fix is the one
below, which (under the safety of read_lock(tasklock)) checks for the
availability of task->sighand - and skips the thread iterations if so.

	Ingo

--- linux/fs/proc/array.c.orig
+++ linux/fs/proc/array.c
@@ -356,7 +356,7 @@ static int do_task_stat(struct task_stru
 			stime = task->signal->stime;
 		}
 	}
-	if (whole) {
+	if (whole && task->sighand) {
 		t = task;
 		do {
 			min_flt += t->min_flt;
