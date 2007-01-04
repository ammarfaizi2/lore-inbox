Return-Path: <linux-kernel-owner+w=401wt.eu-S964879AbXADOiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbXADOiE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 09:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbXADOiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 09:38:04 -0500
Received: from mail.screens.ru ([213.234.233.54]:48576 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964879AbXADOiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 09:38:03 -0500
Date: Thu, 4 Jan 2007 17:38:56 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070104143856.GB179@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru> <20070104120216.GA19228@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104120216.GA19228@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04, Srivatsa Vaddagiri wrote:
>
> On Mon, Dec 18, 2006 at 01:34:16AM +0300, Oleg Nesterov wrote:
> >  void fastcall flush_workqueue(struct workqueue_struct *wq)
> >  {
> > -	might_sleep();
> > -
> > +	mutex_lock(&workqueue_mutex);
> >  	if (is_single_threaded(wq)) {
> >  		/* Always use first cpu's area. */
> > -		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu),
> > -					-1);
> > +		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
> >  	} else {
> >  		int cpu;
> > 
> > -		mutex_lock(&workqueue_mutex);
> >  		for_each_online_cpu(cpu)
> 
> 
> Can compiler optimizations lead to cpu_online_map being cached in a register 
> while running this loop? AFAICS cpu_online_map is not declared to be
> volatile.

But it is not const either,

>            If it can be cached,

I believe this would be a compiler's bug. Let's take a more simple example,

	while (!condition)
		schedule();

What if compiler will cache the value of global 'condition' ?

                                  then we have the danger of invoking 
> flush_cpu_workqueue() on a dead cpu (because flush_cpu_workqueue drops
> workqueue_mutex, cpu hp events can change cpu_online_map while we are in
> flush_cpu_workqueue).

Oleg.

