Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbUC3FFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUC3FFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:05:51 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:64158 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262741AbUC3FFs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:05:48 -0500
Date: Tue, 30 Mar 2004 10:36:14 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Robert Olsson <Robert.Olsson@data.slu.se>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Dave Miller <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@osdl.org>,
       rusty@au1.ibm.com
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040330050614.GA4669@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040329184550.GA4540@in.ibm.com> <20040329222926.GF3808@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329222926.GF3808@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 01:07:12AM +0000, Andrea Arcangeli wrote:
> btw, the set_current_state(TASK_INTERRUPTIBLE) before
> kthread_should_stop seems overkill w.r.t. smp locking, plus the code is
> written in the wrong way around, all set_current_state are in the wrong
> place. It's harmless but I cleaned up that bit as well.

I think set_current_state(TASK_INTERRUPTIBLE) before kthread_should_stop()
_is_ required, otherwise kthread_stop can fail to destroy a kthread.


kthread_stop does:

	1. kthread_stop_info.k = k;
        2. wake_up_process(k);

and if ksoftirqd were to do :

	a. while (!kthread_should_stop()) {
        b.         __set_current_state(TASK_INTERRUPTIBLE);
        c.         schedule();
           }


There is a (narrow) possibility here that a) happens _after_ 1) as well as 
b) _after_ 2).

In such a case kthread_stop would have failed to wake up the kthread!


The same race is avoided if ksoftirqd does:

        a. __set_current_state(TASK_INTERRUPTIBLE);
	b. while (!kthread_should_stop()) {
        c.         schedule();
        d.         __set_current_state(TASK_INTERRUPTIBLE);
           }

        e. __set_current_state(TASK_RUNNING);

In this case, even if b) happens _after_ 1) and c) _after_ 2), schedule
simply returns immediately because task's state would have been set to 
TASK_RUNNING by 2). It goes back to the kthread_should_stop() check and 
exits!








-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
