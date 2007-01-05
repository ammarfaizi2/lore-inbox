Return-Path: <linux-kernel-owner+w=401wt.eu-S1030365AbXAEI4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbXAEI4t (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 03:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbXAEI4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 03:56:48 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:48445 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030365AbXAEI4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 03:56:48 -0500
Date: Fri, 5 Jan 2007 14:26:34 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070105085634.GB18088@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104091850.c1feee76.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 09:18:50AM -0800, Andrew Morton wrote:
> This?

This can still lead to the problem spotted by Oleg here:

	http://lkml.org/lkml/2006/12/30/37

and you would need a similar patch he posted there.

>  void fastcall flush_workqueue(struct workqueue_struct *wq)
>  {
> -	mutex_lock(&workqueue_mutex);
> +	preempt_disable();		/* CPU hotplug */
>  	if (is_single_threaded(wq)) {
>  		/* Always use first cpu's area. */
>  		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
> @@ -459,7 +463,7 @@ void fastcall flush_workqueue(struct wor
>  		for_each_online_cpu(cpu)
>  			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
>  	}
> -	mutex_unlock(&workqueue_mutex);
> +	preempt_enable();
>  }
>  EXPORT_SYMBOL_GPL(flush_workqueue);

-- 
Regards,
vatsa
