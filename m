Return-Path: <linux-kernel-owner+w=401wt.eu-S932166AbXAIPz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbXAIPz5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbXAIPz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:55:57 -0500
Received: from mail.screens.ru ([213.234.233.54]:47357 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932166AbXAIPz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:55:56 -0500
Date: Tue, 9 Jan 2007 18:55:04 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] reimplement flush_workqueue()
Message-ID: <20070109155504.GA183@tv-sign.ru>
References: <20061229171827.GA158@tv-sign.ru> <20070109050104.GA29119@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109050104.GA29119@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09, Srivatsa Vaddagiri wrote:
>
> On Fri, Dec 29, 2006 at 08:18:27PM +0300, Oleg Nesterov wrote:
> > Remove ->remove_sequence, ->insert_sequence, and ->work_done from struct
> > cpu_workqueue_struct. To implement flush_workqueue() we can queue a barrier
> > work on each CPU and wait for its completition.
> 
> Oleg,
> 	Because of this change, was curious to know if this is possible:
> 
> 
> CPU0					CPU1
> (Thread0)
> 
> flush_workqueue()
> 					queue_work(W1)	
>   flush_cpu_workqueue(cpu1)
>     insert_barrier(B1)
>       wait_on_completion();
> 	
> 					run_workqueue()
> 					   W1.func();
> 					     flush_workqueue();
> 						B1.func(); <- wakes Thread0
> 
> The intention of barrier B1 was to wait untill W1 was -complete-. If
> W1.func()->....->something() were to call flush_workqueue on the same
> workqueue, then we would be returning from the barrier prematurely.

But there is nothing new?

insert_sequence = remove_sequence = 0.

queue_work(W1) sets insert_sequence = 1.

flush_cpu_workqueue(cpu1):  wait until remove_sequence >= 1

Now suppose antother thread adds a work to cpu1 before W1.func()
calls flush_cpu_workqueue(cpu1). insert_sequence == 2.

When W1.func() does flush_workqueue(), run_workqueue() fires
that work, increments remove_sequence to 1 and wakes up Thread0.

In other words: currently flush_cpu_workqueue() waits until N
works form the queue will be flushed. If some work also does
flush_workqueue()->run_workqueue(), it just needs to execute one
"extra" work to confuse the first flush_cpu_workqueue().

Oleg.

