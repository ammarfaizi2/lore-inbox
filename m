Return-Path: <linux-kernel-owner+w=401wt.eu-S1752433AbXACAtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbXACAtY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbXACAtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:49:24 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:56884 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbXACAtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:49:23 -0500
In-Reply-To: <000201c72bba$a44a1b60$d634030a@amr.corp.intel.com>
References: <000201c72bba$a44a1b60$d634030a@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0DF58573-AC11-4732-B48C-76401C1A222D@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] aio: add per task aio wait event condition
Date: Tue, 2 Jan 2007 16:49:21 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 29, 2006, at 6:31 PM, Chen, Kenneth W wrote:

> The AIO wake-up notification from aio_complete is really inefficient
> in current AIO implementation in the presence of process waiting in
> io_getevents().

Yeah, it's a real deficiency.  Thanks for taking a stab at it.

> This patch adds a wait condition to the wait queue and only wake-up
> process when that condition meets.  And this condition is added on a
> per task base for handling multi-threaded app that shares single  
> ioctx.

But only one of the waiting tasks is tested, the one at the head of  
the list.  It looks like this change could starve a io_getevents()  
with a low min_nr in the presence of another io_getevents() with a  
larger min_nr.

> Before:
>  0  0      0 3972608   7056  31312    0    0 14100     0 7885  
> 13747  0  2 98  0
> After:
>  0  0      0 3972608   7056  31312    0    0 13800     0 7885     
> 42  0  2 98  0

Nice.  What min_nr was used in this test?

> +struct aio_wait_queue {
> +	int		nr_wait;	/* wake-up condition */

It appears that this is never assigned a negative?  Can we make it  
that explicit in the type so that we reviewers don't have to worry  
about wrapping and signed comparisons?

> -	DECLARE_WAITQUEUE(wait, tsk);
> +	struct aio_wait_queue wait;

> +	aio_init_wait(&wait);

This just changed from using default_wake_function() to  
autoremove_wait_function().  Very sneaky!  wait_for_all_aios() should  
be adding the wait queue before going to sleep each time.  (better  
still to just use wait_event()).

Was this on purpose?  I'm all for it as a way to reduce wakeups from  
a stream of completions to a single waiter.

> +	nr_evt = ring->tail - ring->head;
> +	if (nr_evt < 0)
> +		nr_evt += info->nr;

  int = unsigned - unsigned;
  if (int < 0)

My head already hurts.  Can we clean this up so one doesn't have to  
live and breath type conversion rules to tell if this code is correct?

> +	if (waitqueue_active(&ctx->wait)) {
> +		struct aio_wait_queue *wait;
> +		wait = container_of(ctx->wait.task_list.next,
> +				    struct aio_wait_queue, wait.task_list);
> +		if (nr_evt >= wait->nr_wait)
> +			wake_up(&ctx->wait);
> +	}

First is the fear of starvation as mentioned previously.

issue 2 ops
first io_getevents sleeps with a min_nr of 2
second io_getevents sleeps with min_nr of 3
2 ops complete but only test the second sleeper's min_nr of 3
first sleeper twiddles thumbs

This makes me think this elegant task_list approach is doomed.  I  
think this is what stopped Ben and I from being interested in this  
last time we talked about it :).

Also, is that container_of() and dereference safe in the presence of  
racing wake-ups?  It looks like we could get deref a freed wait and  
get a bogus nr_wait and decide not to wake.

Andrew, I fear we should remove this from -mm until it's fixed up.

- z
