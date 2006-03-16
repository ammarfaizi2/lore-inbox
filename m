Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWCPWwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWCPWwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWCPWwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:52:12 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:17989 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964892AbWCPWwK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:52:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LW1USlD5txLnYRJcEFGOXl3HUiMtxW12jCczV8Nt2DB868Cbo2Y8oy1FQKhbY4HX7bZSgBkOCZop10ie+qTA+GARRdxm6uKuXnDf1B3ZfOuGfH6FLvFacNrSv0snkv7YqHrHhA8tTGQtB10lSql2Hl7aGHtBTkz6r3Jr/A8ar0g=
Message-ID: <e7aeb7c60603161452t8630996kcab443bdaac4454e@mail.gmail.com>
Date: Fri, 17 Mar 2006 00:52:08 +0200
From: "Yitzchak Eidus" <ieidus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: puting task to TASK_INTERRUPTIBLE before adding it to an wait queue
In-Reply-To: <e7aeb7c60603161431m6d873520r2b6754e115e26f80@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e7aeb7c60603161431m6d873520r2b6754e115e26f80@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/06, Yitzchak Eidus <ieidus@gmail.com> wrote:
> the function worker_thread in kernel 2.6.15.6  first put the task to
> TASK_INTERRUPTIBLE and only then add itself to an wait queue:
>         set_current_state(TASK_INTERRUPTIBLE);
>         while (!kthread_should_stop()) {
>                 add_wait_queue(&cwq->more_work, &wait);
> ....
> my question is, what will happen if the timeslice for the
> worker_thread will finished just before it add itself to the wait
> queue?
> wont it call schedule() that will find the task is in
> TASK_INTERRUPTIBLE state and remove it from the runqueue? ( that what
> schedule() should do no? )
> and then how will the kernel be able to call to worker_thread ever if
> it isnt in any list???
> thanks for the comments!
>

more over the whole loop look like that:
set_current_state(TASK_INTERRUPTIBLE);
	while (!kthread_should_stop()) {
		add_wait_queue(&cwq->more_work, &wait);
		if (list_empty(&cwq->worklist))
			schedule();
		else
			__set_current_state(TASK_RUNNING);
		remove_wait_queue(&cwq->more_work, &wait);

		if (!list_empty(&cwq->worklist))
			run_workqueue(cwq);
		set_current_state(TASK_INTERRUPTIBLE);
	}

what was the logic of putting the
set_current_state(TASK_INTERRUPTIBLE); before the loop and in the last
statement of the loop?

why not use something like this:
while (!kthread_should_stop()) {
		add_wait_queue(&cwq->more_work, &wait);
		set_current_state(TASK_INTERRUPTIBLE);
		if (list_empty(&cwq->worklist))
			schedule();
		else
			__set_current_state(TASK_RUNNING);
		remove_wait_queue(&cwq->more_work, &wait);

		if (!list_empty(&cwq->worklist))
			run_workqueue(cwq);
	}
that do the same thing without putting the task before the loop and in
the loop...?
( unless i am missing something? )
