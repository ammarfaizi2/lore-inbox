Return-Path: <linux-kernel-owner+w=401wt.eu-S964796AbXADMC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbXADMC0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 07:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbXADMC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 07:02:26 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48774 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964796AbXADMCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 07:02:25 -0500
Date: Thu, 4 Jan 2007 17:32:16 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070104120216.GA19228@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061217223416.GA6872@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061217223416.GA6872@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 01:34:16AM +0300, Oleg Nesterov wrote:
>  void fastcall flush_workqueue(struct workqueue_struct *wq)
>  {
> -	might_sleep();
> -
> +	mutex_lock(&workqueue_mutex);
>  	if (is_single_threaded(wq)) {
>  		/* Always use first cpu's area. */
> -		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu),
> -					-1);
> +		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
>  	} else {
>  		int cpu;
> 
> -		mutex_lock(&workqueue_mutex);
>  		for_each_online_cpu(cpu)


Can compiler optimizations lead to cpu_online_map being cached in a register 
while running this loop? AFAICS cpu_online_map is not declared to be
volatile. If it can be cached, then we have the danger of invoking 
flush_cpu_workqueue() on a dead cpu (because flush_cpu_workqueue drops
workqueue_mutex, cpu hp events can change cpu_online_map while we are in
flush_cpu_workqueue).

> -			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu), cpu);
> -		mutex_unlock(&workqueue_mutex);
> +			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));


-- 
Regards,
vatsa
