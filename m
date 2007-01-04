Return-Path: <linux-kernel-owner+w=401wt.eu-S932212AbXADSIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbXADSIg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbXADSIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:08:36 -0500
Received: from mail.screens.ru ([213.234.233.54]:39857 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964794AbXADSIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:08:35 -0500
Date: Thu, 4 Jan 2007 21:09:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070104180901.GA344@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104091850.c1feee76.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04, Andrew Morton wrote:
>
> On Thu, 4 Jan 2007 17:29:36 +0300
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> 
> > > In brief:
> > > 
> > > keventd thread					hotplug thread
> > > --------------					--------------
> > > 
> > >   run_workqueue()
> > > 	|
> > >      work_fn()
> > > 	 |
> > > 	flush_workqueue()
> > > 	     |	
> > > 	   flush_cpu_workqueue
> > > 		|				cpu_down()
> > > 	     mutex_unlock(wq_mutex);		     |
> > > 	(above opens window for hotplug)	   mutex_lock(wq_mutex);
> > >     		|				   /* bring down cpu */	
> > > 	     wait_for_completition();		     notifier(CPU_DEAD, ..)
> > > 		| 				       workqueue_cpu_callback
> > > 		| 				        cleanup_workqueue_thread
> > > 		|					  kthread_stop()
> > > 		|
> > > 		|
> > > 	     mutex_lock(wq_mutex); <- Can deadlock
> > > 
> > > 
> > > The kthread_stop() will wait for keventd() thread to exit, but keventd()
> > > is blocked on mutex_lock(wq_mutex) leading to a deadlock.
> 
> This?
> 
> 
> --- a/kernel/workqueue.c~flush_workqueue-use-preempt_disable-to-hold-off-cpu-hotplug
> +++ a/kernel/workqueue.c
> @@ -419,18 +419,22 @@ static void flush_cpu_workqueue(struct c
>  		 * Probably keventd trying to flush its own queue. So simply run
>  		 * it by hand rather than deadlocking.
>  		 */
> -		mutex_unlock(&workqueue_mutex);
> +		preempt_enable();

Ah, (looking at _cpu_down()->stop_machine()), so preempt_disable() not only "pins"
the current CPU, it blocks cpu_down(), yes ???

I guess this should work then. I'll try to re-check this code on weekend.

Oleg.

