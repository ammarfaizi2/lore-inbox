Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263646AbUECMWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUECMWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbUECMWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:22:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:28131 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263646AbUECMWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:22:23 -0400
Date: Mon, 3 May 2004 17:53:16 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in __create_workqueue
Message-ID: <20040503122316.GA7143@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040430113751.GA18296@in.ibm.com> <20040430192712.2e085895.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430192712.2e085895.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 07:27:12PM -0700, Andrew Morton wrote:
> Can we not simply do:
> 
> 
> diff -puN kernel/workqueue.c~a kernel/workqueue.c
> --- 25/kernel/workqueue.c~a	2004-04-30 19:26:32.003303600 -0700
> +++ 25-akpm/kernel/workqueue.c	2004-04-30 19:26:44.492404968 -0700
> @@ -334,6 +334,7 @@ struct workqueue_struct *__create_workqu
>  				destroy = 1;
>  		}
>  	}
> +	unlock_cpu_hotplug();
>  
>  	/*
>  	 * Was there any error during startup? If yes then clean up:
> @@ -342,7 +343,6 @@ struct workqueue_struct *__create_workqu
>  		destroy_workqueue(wq);
>  		wq = NULL;
>  	}
> -	unlock_cpu_hotplug();
>  	return wq;
>  }

I didn't do this because I introduced a break at the first instance
when create_workqueue_thread failed. Breaking out of the loop
like that appeared to be more efficient rather than going back and
trying to create threads for rest of the online cpus, because most
likely thread creation will fail for other cpus also and anyway
the workqueue will be destroyed down the line.

If the break is introduced, I dont think we can rely on destroy_workqueue
because some of the per-cpu structures (spinlocks for one) will not be 
initialized for all online cpus.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
