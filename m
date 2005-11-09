Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVKIPtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVKIPtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVKIPtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:49:51 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:55154 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751356AbVKIPtu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:49:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pSDMKqI1ZFr/m9wLX5BqVUY+5qcX5LW06UYIV/Qe62NwJUlv4HhDWvUxau9iJI+D73yqDk4qms3GTl0Gj1K07kycwtoxmAFjuskmUjxjKemSmlItxMwh4a0L7bczP4Fe+TNqJ69sMriKD0U7bc67l/ZqjPwJAAv5iGuQaWtKegM=
Message-ID: <7d40d7190511090749j3de0e473x@mail.gmail.com>
Date: Wed, 9 Nov 2005 16:49:49 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Stopping Kernel Threads at module unload time
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I've got some questions about kernel threads.I am writing a module
which spawns some kernel threads, which would be removed when the
module unloads. For that purpose i call kthread_stop() at module
unload time. When issuing rmmod on the module, it deadlocks at that
point (in the call to kthread_stop), and never returns.

In the thread main function the code was something like this (it's of
course simplified).

thread_main()
{
     while( ! kthread_should_stop())
     {
           .............
           wait_event_interruptible(stop_wq, kthread_should_stop() );
     }

     return 0;
}

So if kthread_stop() first sets the thread "closing flag", and then
calls wake_up_process(), the thread should wake up, see he should
stop, and
end the loop. That doesnt actually never happen.

I have also tried what it is done in kernel/sched.c to finish:

	/* wait for kthread_stop */
	set_current_state(TASK_INTERRUPTIBLE);
	while (!kthread_should_stop()) {	
		schedule();
		set_current_state(TASK_INTERRUPTIBLE);
	}
	__set_current_state(TASK_RUNNING);
                return 0;

I have ensured it actually arrives to that point by using printks, but
when the thread goes to sleep, it does never wake up again, so the
call to kthread_stop() lasts forever.

I dont know why this happens. Is the module cleanup code in the
context of a user process just like system calls? Can that code sleep?
If it can't sleep then the answer would be quite easy: kthread_stop()
wakes up the processes and then waits for the threads to finish (on
call wait_for_completion), but doesnt actually let them execute,
because it cannot sleep, so it deadlocks.

So I would be grateful if anyone can help me in this matter.
Regards

Aritz
