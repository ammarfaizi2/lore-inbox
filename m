Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWCQIAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWCQIAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbWCQIAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:00:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:43964 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751481AbWCQIAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:00:10 -0500
X-Authenticated: #14349625
Subject: Re: puting task to TASK_INTERRUPTIBLE before adding it to an wait
	queue
From: Mike Galbraith <efault@gmx.de>
To: Yitzchak Eidus <ieidus@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e7aeb7c60603161431m6d873520r2b6754e115e26f80@mail.gmail.com>
References: <e7aeb7c60603161431m6d873520r2b6754e115e26f80@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 09:01:43 +0100
Message-Id: <1142582503.7973.15.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 00:31 +0200, Yitzchak Eidus wrote:
> the function worker_thread in kernel 2.6.15.6  first put the task to
> TASK_INTERRUPTIBLE and only then add itself to an wait queue:
> 	set_current_state(TASK_INTERRUPTIBLE);
> 	while (!kthread_should_stop()) {
> 		add_wait_queue(&cwq->more_work, &wait);

See dusty old archives...

http://www.ussg.iu.edu/hypermail/linux/kernel/9712.2/0545.html

<quote>
Anyway, the basic race-free wait loop looks like this (there are
variations, but this is one of the basic versions that you find in
various places):


if (should_wait_condition) {
add_wait_queue(..);
repeat:
current->state = TASK_UNINTERRUPTIBLE;
if (should_wait_condition) {
schedule();
goto repeat;
}
remove_wait_queue(..);
current->state = TASK_RUNNING;
}


There are only two important rules:
- you have to add yourself to the wait queue _before_ testing for the
condition.
- you have to mark yourself asleep _before_ testing for the condition.

</quote>

