Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUCHWfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbUCHWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:35:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:35974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261386AbUCHWfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:35:19 -0500
Date: Mon, 8 Mar 2004 14:36:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: mingo@redhat.com, rusty@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: more efficient current_is_keventd macro? [was Re: [lhcs-devel]
 Re: Kthread_create() never returns when called from worker_thread]
Message-Id: <20040308143658.25c1d378.akpm@osdl.org>
In-Reply-To: <20040308123030.GA7428@in.ibm.com>
References: <20040308123030.GA7428@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> 	current_is_keventd() macro checks "current" with the per-cpu
> thread of _all_ possible cpus attached to keventd_wq. Can't it just check 
> against the per-cpu thread of _current_ cpu alone (since the per-cpu workqueue
> threads are anyway bound only to their cpus)?  

Seems that way, yes.

> int current_is_keventd(void)
> {
>         struct cpu_workqueue_struct *cwq;
> -       int cpu;
> +       int cpu = smp_processor_id();
> 
>         BUG_ON(!keventd_wq);
> 
> -       for_each_cpu(cpu) {
> -               cwq = keventd_wq->cpu_wq + cpu;
> -               if (current == cwq->thread)
> -                       return 1;
> -       }
> 
> -       return 0;
> 
> +	cwq = keventd_wq->cpu_wq + cpu;
> +	if (current == cwq->thread)
> +		return 1;
> +	else
> +		return 0;
> }

Is racy in the presence of preemption.  Please replace smp_processor_id()
with get_cpu(), stick a put_cpu() at the end, avoid having two function
return points, test it and send me the diff?

