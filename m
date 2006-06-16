Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWFPUki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWFPUki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 16:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWFPUki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 16:40:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26387 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751307AbWFPUki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 16:40:38 -0400
Date: Fri, 16 Jun 2006 20:40:24 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
Message-ID: <20060616204024.GA7097@ucw.cz>
References: <1150297122.31522.54.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150297122.31522.54.camel@lappy>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Some folks find 128KB of env+arg space too little. Solaris provides them with
> 1MB. Manually changing MAX_ARG_PAGES worked for them so far, however they
> would like to run the supported vendor kernel.
> 
> In the interrest of not penalizing everybody with the overhead of just
> setting it larger, provide a sysctl to change it.

I very muh like that idea.

> Compiles and boots on i386.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

...but does is also work if you keep changing that value in the tight
loop while trying to work with the system?

> Index: linux-2.6/fs/binfmt_elf.c
> ===================================================================
> --- linux-2.6.orig/fs/binfmt_elf.c	2006-06-14 15:56:40.000000000 +0200
> +++ linux-2.6/fs/binfmt_elf.c	2006-06-14 16:00:36.000000000 +0200
> @@ -255,8 +255,9 @@ create_elf_tables(struct linux_binprm *b
>  	while (argc-- > 0) {
>  		size_t len;
>  		__put_user((elf_addr_t)p, argv++);
> -		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
> -		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
> +		len = strnlen_user((void __user *)p,
> +				PAGE_SIZE*bprm->max_arg_pages);
> +		if (!len || len > PAGE_SIZE*bprm->max_arg_pages)
>  			return 0;
>  		p += len;
>  	}
> @@ -266,8 +267,9 @@ create_elf_tables(struct linux_binprm *b
>  	while (envc-- > 0) {
>  		size_t len;
>  		__put_user((elf_addr_t)p, envp++);
> -		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
> -		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
> +		len = strnlen_user((void __user *)p,
> +				PAGE_SIZE*bprm->max_arg_pages);
> +		if (!len || len > PAGE_SIZE*bprm->max_arg_pages)
>  			return 0;
>  		p += len;
>  	}
> Index: linux-2.6/fs/binfmt_elf_fdpic.c
> ===================================================================
> --- linux-2.6.orig/fs/binfmt_elf_fdpic.c	2006-06-14 15:56:40.000000000 +0200
> +++ linux-2.6/fs/binfmt_elf_fdpic.c	2006-06-14 16:00:36.000000000 +0200
> @@ -578,14 +578,15 @@ static int create_elf_fdpic_tables(struc
>  #ifdef CONFIG_MMU
>  	current->mm->arg_start = bprm->p;
>  #else
> -	current->mm->arg_start = current->mm->start_stack - (MAX_ARG_PAGES * PAGE_SIZE - bprm->p);
> +	current->mm->arg_start = current->mm->start_stack -
> +		(bprm->max_arg_pages * PAGE_SIZE - bprm->p);
>  #endif
>  
>  	p = (char *) current->mm->arg_start;
>  	for (loop = bprm->argc; loop > 0; loop--) {

What happens if someone changes that sysctl from other cpu at this
point?

>  		__put_user((elf_caddr_t) p, argv++);
> -		len = strnlen_user(p, PAGE_SIZE * MAX_ARG_PAGES);
> -		if (!len || len > PAGE_SIZE * MAX_ARG_PAGES)
> +		len = strnlen_user(p, PAGE_SIZE * bprm->max_arg_pages);
> +		if (!len || len > PAGE_SIZE * bprm->max_arg_pages)
>  			return -EINVAL;
>  		p += len;
>  	}

-- 
Thanks for all the (sleeping) penguins.
