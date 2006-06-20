Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965310AbWFTDO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965310AbWFTDO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 23:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965313AbWFTDO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 23:14:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965311AbWFTDO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 23:14:57 -0400
Date: Mon, 19 Jun 2006 20:14:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
Message-Id: <20060619201450.3434f72f.akpm@osdl.org>
In-Reply-To: <20060615144331.GB16046@sergelap.austin.ibm.com>
References: <20060615144331.GB16046@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006 09:43:31 -0500
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Update stop_machine.c to spawn stop_machine as kthreads rather
> than the deprecated kernel_threads.
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> 
> ---
> 
>  kernel/stop_machine.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> ce04ccc88ac3e2e6c3942fe2c8c4b2d5492d8397
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index dcfb5d7..2dd5a48 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -4,6 +4,7 @@ #include <linux/sched.h>
>  #include <linux/cpu.h>
>  #include <linux/err.h>
>  #include <linux/syscalls.h>
> +#include <linux/kthread.h>
>  #include <asm/atomic.h>
>  #include <asm/semaphore.h>
>  #include <asm/uaccess.h>
> @@ -96,11 +97,14 @@ static int stop_machine(void)
>  	stopmachine_state = STOPMACHINE_WAIT;
>  
>  	for_each_online_cpu(i) {
> +		struct task_struct *tsk;
>  		if (i == raw_smp_processor_id())
>  			continue;
> -		ret = kernel_thread(stopmachine, (void *)(long)i,CLONE_KERNEL);
> -		if (ret < 0)
> +		tsk = kthread_run(stopmachine, (void *)(long)i, "stopmachine");
> +		if (IS_ERR(tsk)) {
> +			ret = PTR_ERR(tsk);
>  			break;
> +		}
>  		stopmachine_num_threads++;
>  	}
>  

OK.  But if we're going to convert to the kthread API then stopmachine()
really whould be switched to the more efficient kthread_bind().

