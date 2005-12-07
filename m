Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVLGX11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVLGX11 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbVLGX11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:27:27 -0500
Received: from ihug-mail.icp-qv1-irony5.iinet.net.au ([203.59.1.199]:1078 "EHLO
	mail-ihug.icp-qv1-irony5.iinet.net.au") by vger.kernel.org with ESMTP
	id S1751122AbVLGX10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:27:26 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <43976FD4.8060404@cyberone.com.au>
Date: Thu, 08 Dec 2005 10:27:16 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] swap migration: Fix lru drain
References: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> isolate_page() currently uses an IPI to notify other processors that the lru
> caches need to be drained if the page cannot be found on the LRU. The IPI
> interrupt may interrupt a processor that is just processing lru requests
> and cause a race condition.
> 
> This patch introduces a new function run_on_each_cpu() that uses the keventd()
> to run the LRU draining on each processor. Processors disable preemption
> when dealing the LRU caches (these are per processor) and thus executing
> LRU draining from another process is safe.
> 

Couple of comments:

> ===================================================================
> --- linux-2.6.15-rc5-mm1.orig/kernel/workqueue.c	2005-12-05 11:15:24.000000000 -0800
> +++ linux-2.6.15-rc5-mm1/kernel/workqueue.c	2005-12-06 17:50:44.000000000 -0800
> @@ -424,6 +424,19 @@ int schedule_delayed_work_on(int cpu,
>  	return ret;
>  }
>  
> +void schedule_on_each_cpu(void (*func) (void *info), void *info)
> +{
> +	int cpu;
> +	struct work_struct * work = kmalloc(NR_CPUS * sizeof(struct work_struct), GFP_KERNEL);
> +

Do we need a lock_cpu_hotplug() around here?

> +	for_each_online_cpu(cpu) {
> +		INIT_WORK(work + cpu, func, info);
> +		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu), work + cpu);
> +	}
> +	flush_workqueue(keventd_wq);
> +	kfree(work);
> +}
> +

Can't this deadlock if 2 CPUs each send work to the other?

-- 
SUSE Labs, Novell Inc.
