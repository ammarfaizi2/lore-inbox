Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVA0Kjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVA0Kjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVA0Khv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:37:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5062 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262548AbVA0KV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:21:29 -0500
Date: Thu, 27 Jan 2005 10:21:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
Message-ID: <20050127102123.GA25831@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127101322.GE9760@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -#ifdef CONFIG_X86_HT
> +#ifdef __HAVE_ARCH_ALIGN_STACK
>  		/*
>  		 * In some cases (e.g. Hyper-Threading), we want to avoid L1
>  		 * evictions by the processes running on the same package. One
>  		 * thing we can do is to shuffle the initial stack for them.
> -		 *
> -		 * The conditionals here are unneeded, but kept in to make the
> -		 * code behaviour the same as pre change unless we have
> -		 * hyperthreaded processors. This should be cleaned up
> -		 * before 2.6
>  		 */
>  	 
> -		if (smp_num_siblings > 1)
> -			STACK_ALLOC(p, ((current->pid % 64) << 7));
> +		p = arch_align_stack((unsigned long)p);
>  #endif
>  		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
>  		if (__copy_to_user(u_platform, k_platform, len))
> diff -purN linux-step-2/fs/exec.c linux-step-4/fs/exec.c
> --- linux-step-2/fs/exec.c	2005-01-26 21:15:33.860310848 +0100
> +++ linux-step-4/fs/exec.c	2005-01-26 21:25:22.678796832 +0100
> @@ -400,7 +400,12 @@ int setup_arg_pages(struct linux_binprm 
>  	while (i < MAX_ARG_PAGES)
>  		bprm->page[i++] = NULL;
>  #else
> -	stack_base = stack_top - MAX_ARG_PAGES * PAGE_SIZE;
> +#ifdef __HAVE_ARCH_ALIGN_STACK
> +	stack_base = arch_align_stack(STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE);
> +	stack_base = PAGE_ALIGN(stack_base);
> +#else
> +	stack_base = STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
> +#endif

Please kill the ifdefs and provide a dummy arch_align_stack() for
every architecture.

