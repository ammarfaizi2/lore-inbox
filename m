Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWH3Qan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWH3Qan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWH3Qan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:30:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:18054 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751129AbWH3Qam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:30:42 -0400
From: Andi Kleen <ak@suse.de>
To: pageexec@freemail.hu
Subject: Re: [PATCH][RFC] exception processing in early boot
Date: Wed, 30 Aug 2006 18:30:40 +0200
User-Agent: KMail/1.9.3
Cc: Willy Tarreau <w@1wt.eu>, Riley@williams.name, davej@redhat.com,
       linux-kernel@vger.kernel.org
References: <20060830063932.GB289@1wt.eu> <200608301459.15008.ak@suse.de> <44F5D81A.9650.5BE48F99@pageexec.freemail.hu>
In-Reply-To: <44F5D81A.9650.5BE48F99@pageexec.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301830.40994.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 18:25, pageexec@freemail.hu wrote:
> On 30 Aug 2006 at 14:59, Andi Kleen wrote:
> > > I think that the good method would be to :
> > >   - announce the patch
> > >   - find a volunteer to port it
> > >   - apply it once the volunteer agrees to handle it
> > > This way, no code gets lost because there's always someone to track it.
> > 
> > I can put that one into my tree for .19
> 
> here's my quick attempt:


It would be better to separate exceptions from interrupts here.
A spurious interrupt is not necessarily fatal, just an exception is.

But I went with the simpler patch with some changes now 
(added PANIC to the message etc.) 

> 
> --- linux-2.6.18-rc5/arch/i386/kernel/head.S	2006-08-28 11:37:31.000000000 
> +0200
> +++ linux-2.6.18-rc5-fix/arch/i386/kernel/head.S	2006-08-30 
> 18:22:15.000000000 +0200
> @@ -382,34 +382,25 @@ rp_sidt:
>  /* This is the default interrupt "handler" :-) */
>  	ALIGN
>  ignore_int:
> -	cld
>  #ifdef CONFIG_PRINTK
> -	pushl %eax
> -	pushl %ecx
> -	pushl %edx
> -	pushl %es
> -	pushl %ds
> +	cld
>  	movl $(__KERNEL_DS),%eax
>  	movl %eax,%ds
>  	movl %eax,%es
> -	pushl 16(%esp)
> -	pushl 24(%esp)
> -	pushl 32(%esp)
> -	pushl 40(%esp)
> +	pushl 12(%esp)
> +	pushl 12(%esp)
> +	pushl 12(%esp)
> +	pushl 12(%esp)
>  	pushl $int_msg
>  #ifdef CONFIG_EARLY_PRINTK
>  	call early_printk
>  #else
>  	call printk
>  #endif
> -	addl $(5*4),%esp
> -	popl %ds
> -	popl %es
> -	popl %edx
> -	popl %ecx
> -	popl %eax
>  #endif
> -	iret
> +1:	hlt

This is wrong because i386 still supports some CPUs that don't support
HLT.

-Andi
