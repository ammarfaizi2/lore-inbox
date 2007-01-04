Return-Path: <linux-kernel-owner+w=401wt.eu-S964778AbXADLdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbXADLdP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 06:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbXADLdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 06:33:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:54701 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964778AbXADLdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 06:33:14 -0500
Date: Thu, 4 Jan 2007 17:02:14 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070104113214.GA30377@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219004319.GA821@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 03:43:19AM +0300, Oleg Nesterov wrote:
> > Taking workqueue_mutex() unconditionally in flush_workqueue() means
> > that we'll deadlock if a single-threaded workqueue callback handler calls
> > flush_workqueue().
> 
> Well. But flush_workqueue() drops workqueue_mutex before going to sleep ?

... and acquires it again after woken from sleep. That can be a problem, which 
will lead to the problem described here:

	http://lkml.org/lkml/2006/12/7/374

In brief:

keventd thread					hotplug thread
--------------					--------------

  run_workqueue()
	|
     work_fn()
	 |
	flush_workqueue()
	     |	
	   flush_cpu_workqueue
		|				cpu_down()
	     mutex_unlock(wq_mutex);		     |
	(above opens window for hotplug)	   mutex_lock(wq_mutex);
    		|				   /* bring down cpu */	
	     wait_for_completition();		     notifier(CPU_DEAD, ..)
		| 				       workqueue_cpu_callback
		| 				        cleanup_workqueue_thread
		|					  kthread_stop()
		|
		|
	     mutex_lock(wq_mutex); <- Can deadlock


The kthread_stop() will wait for keventd() thread to exit, but keventd()
is blocked on mutex_lock(wq_mutex) leading to a deadlock.

> 
> 	flush_workqueue(single_threaded_wq);
> 		...
> 		mutex_lock(&workqueue_mutex);
> 		...
> 		mutex_unlock(&workqueue_mutex);
> 		wait_for_completition();
> 							handler runs,
> 							calls flush_workqueue(),
> 							workqueue_mutex is free

-- 
Regards,
vatsa
