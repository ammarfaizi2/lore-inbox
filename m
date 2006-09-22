Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWIVAeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWIVAeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWIVAeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:34:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6667 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932141AbWIVAeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:34:08 -0400
Date: Fri, 22 Sep 2006 02:34:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: torvalds@osdl.org, akpm@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, Kenneth Lee <kenlee@dg.gov.cn>
Subject: Re: [patch] Race condition in usermodehelper.
Message-ID: <20060922003401.GZ31906@stusta.de>
References: <20060915104654.GA31548@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915104654.GA31548@skybase>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to 2.6.16 (with a note that Kenneth Lee also sent the 
same patch independently).

cu
Adrian

On Fri, Sep 15, 2006 at 12:46:54PM +0200, Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> [patch] Race condition in usermodehelper.
> 
> There is a race between call_usermodehelper_keys, __call_usermodehelper
> and wait_for_helper. It should only happen if preemption is enabled or
> on a virtualized system.
> 
> If the cpu is preempted or put to sleep by the hypervisor in
> __call_usermodehelper between the creation of the wait_for_helper
> thread and the second check on sub_info->wait, the whole execution
> of wait_for_helper including the complete call and the continuation
> after the wait_for_completion in call_usermodehelper_keys can have
> happened before __call_usermodehelper checks sub_info->wait for the
> second time. Since sub_info can already have been clobbered,
> sub_info->wait could be zero and complete is called a second time
> with an invalid argument. This has happened on s390. It took me only
> three days to find out ..
> 
> Thanks to Arnd Bergmann for his help to spot this bug.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
>  kernel/kmod.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff -urpN linux-2.6/kernel/kmod.c linux-2.6-patched/kernel/kmod.c
> --- linux-2.6/kernel/kmod.c	2006-09-15 12:17:52.000000000 +0200
> +++ linux-2.6-patched/kernel/kmod.c	2006-09-15 12:18:00.000000000 +0200
> @@ -196,12 +196,13 @@ static int wait_for_helper(void *data)
>  static void __call_usermodehelper(void *data)
>  {
>  	struct subprocess_info *sub_info = data;
> +	int wait = sub_info->wait;
>  	pid_t pid;
>  
>  	/* CLONE_VFORK: wait until the usermode helper has execve'd
>  	 * successfully We need the data structures to stay around
>  	 * until that is done.  */
> -	if (sub_info->wait)
> +	if (wait)
>  		pid = kernel_thread(wait_for_helper, sub_info,
>  				    CLONE_FS | CLONE_FILES | SIGCHLD);
>  	else
> @@ -211,7 +212,7 @@ static void __call_usermodehelper(void *
>  	if (pid < 0) {
>  		sub_info->retval = pid;
>  		complete(sub_info->complete);
> -	} else if (!sub_info->wait)
> +	} else if (!wait)
>  		complete(sub_info->complete);
>  }
>  

