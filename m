Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264248AbUEDGub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbUEDGub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 02:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264250AbUEDGub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 02:50:31 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52641 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264248AbUEDGu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 02:50:29 -0400
Date: Tue, 4 May 2004 12:21:39 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in __create_workqueue
Message-ID: <20040504065139.GB6911@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040430113751.GA18296@in.ibm.com> <20040430191901.510ae947.akpm@osdl.org> <20040503122412.GB7143@in.ibm.com> <20040503130829.5c43c6fe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503130829.5c43c6fe.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 01:08:29PM -0700, Andrew Morton wrote:
> yup, sorry, I misread the code.  Like this?

Yes, looks fine to me!

> 
> --- 25/kernel/workqueue.c~worker_thread-race-fix	Mon May  3 13:02:25 2004
> +++ 25-akpm/kernel/workqueue.c	Mon May  3 13:07:34 2004
> @@ -201,19 +201,20 @@ static int worker_thread(void *__cwq)
>  	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
>  	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
>  
> +	set_current_state(TASK_INTERRUPTIBLE);
>  	while (!kthread_should_stop()) {
> -		set_task_state(current, TASK_INTERRUPTIBLE);
> -
>  		add_wait_queue(&cwq->more_work, &wait);
>  		if (list_empty(&cwq->worklist))
>  			schedule();
>  		else
> -			set_task_state(current, TASK_RUNNING);
> +			__set_current_state(TASK_RUNNING);
>  		remove_wait_queue(&cwq->more_work, &wait);
>  
>  		if (!list_empty(&cwq->worklist))
>  			run_workqueue(cwq);
> +		set_current_state(TASK_INTERRUPTIBLE);
>  	}
> +	__set_current_state(TASK_RUNNING);
>  	return 0;
>  }

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
