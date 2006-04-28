Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWD1TQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWD1TQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 15:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWD1TQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 15:16:23 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:5817 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751444AbWD1TQX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 15:16:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OB/e4BJ1p0lUCQqCpBS9jzkDKOdM2OWRf3EcMHw+kKReoPISuk+fOxL2BJ9571wwy2J3bt2LSo3sprFtvegfQzOK8ID8IRBAu9EbqTt89LoyFMHZi/hZv9o1LQlWR4MQiwa/qGUZR4TztjV3NNKPIhsmFGhQq/yzBPWhOtlsh6U=
Message-ID: <3f250c710604281216k79ebe2c8ie63fb337cec8481a@mail.gmail.com>
Date: Fri, 28 Apr 2006 15:16:22 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: nagar@watson.ibm.com, balbir@in.ibm.com
Subject: schedstats: sched_info_switch() invocation without checking (prev != next) before
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am using the schedstats idea for tracking some schedule info and
after checking the code I have a question about sched_info_switch()
function.

According to the comments as follows:

/*
 * Called when tasks are switched involuntarily due, typically, to expiring
 * their time slice.  (This may also be called when switching to or from
 * the idle task.)  We are only called when prev != next.
 */
static inline void sched_info_switch(task_t *prev, task_t *next)
{
...
}

So after reading the comments, sched_info_switch() should be called
when the current task and next task are different (prev != next), but
this function is called in the schedule() function before checking if
the current task and next task are the same or not. See below a
snippet of schedule() code:

=========================
switch_tasks:
...
sched_info_switch(prev, next);
	if (likely(prev != next)) {
		next->timestamp = now;
		rq->nr_switches++;
		rq->curr = next;
		++*switch_count;

		prepare_task_switch(rq, next);
		prev = context_switch(rq, prev, next);
		barrier();
		/*
		 * this_rq must be evaluated again because prev may have moved
		 * CPUs since it called schedule(), thus the 'rq' on its stack
		 * frame will be invalid.
		 */
		finish_task_switch(this_rq(), prev);
	} else
		spin_unlock_irq(&rq->lock);

=========================

Look that sched_info_switch() is being invoked before verifying if the
prev and next tasks are different or not. IMHO the more logical place
to put sched_info_switch() function is inside the if (likely(prev !=
next) { } block according to the comments mentioned previously.

Any comments?

BR,

Mauricio Lin.
