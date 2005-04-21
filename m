Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVDULK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVDULK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVDULK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:10:26 -0400
Received: from mx1.suse.de ([195.135.220.2]:2284 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261283AbVDULKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:10:07 -0400
Date: Thu, 21 Apr 2005 13:10:05 +0200
From: Andi Kleen <ak@suse.de>
To: Alexander Nyberg <alexn@telia.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org,
       nicolas@boichat.ch
Subject: Re: x86_64: Bug in new out of line put_user()
Message-ID: <20050421111005.GL7715@wotan.suse.de>
References: <1114038609.500.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114038609.500.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 01:10:09AM +0200, Alexander Nyberg wrote:
> The new out of line put_user() assembly on x86_64 changes %rcx without
> telling GCC about it causing things like:
> 
> http://bugme.osdl.org/show_bug.cgi?id=4515 
> 
> See to it that %rcx is not changed (made it consistent with get_user()).

Damn. I actually fixed this before submission, but it looks like
the old patch staid in the queue :-( Sorry for you having to debug
it again.

Linus, can can you please apply the patch?

-Andi

> 
> 
> Signed-off-by: Alexander Nyberg <alexn@telia.com>
> 
> Index: test/arch/x86_64/lib/getuser.S
> ===================================================================
> --- test.orig/arch/x86_64/lib/getuser.S	2005-04-20 23:55:35.000000000 +0200
> +++ test/arch/x86_64/lib/getuser.S	2005-04-21 00:54:16.000000000 +0200
> @@ -78,9 +78,9 @@
>  __get_user_8:
>  	GET_THREAD_INFO(%r8)
>  	addq $7,%rcx
> -	jc bad_get_user
> +	jc 40f
>  	cmpq threadinfo_addr_limit(%r8),%rcx
> -	jae	bad_get_user
> +	jae	40f
>  	subq	$7,%rcx
>  4:	movq (%rcx),%rdx
>  	xorl %eax,%eax
> Index: test/arch/x86_64/lib/putuser.S
> ===================================================================
> --- test.orig/arch/x86_64/lib/putuser.S	2005-04-21 00:50:24.000000000 +0200
> +++ test/arch/x86_64/lib/putuser.S	2005-04-21 01:02:15.000000000 +0200
> @@ -46,36 +46,45 @@
>  __put_user_2:
>  	GET_THREAD_INFO(%r8)
>  	addq $1,%rcx
> -	jc bad_put_user
> +	jc 20f
>  	cmpq threadinfo_addr_limit(%r8),%rcx
> -	jae	 bad_put_user
> -2:	movw %dx,-1(%rcx)
> +	jae 20f
> +2:	decq %rcx
> +	movw %dx,(%rcx)
>  	xorl %eax,%eax
>  	ret
> +20:	decq %rcx
> +	jmp bad_put_user
>  
>  	.p2align 4
>  .globl __put_user_4
>  __put_user_4:
>  	GET_THREAD_INFO(%r8)
>  	addq $3,%rcx
> -	jc bad_put_user
> +	jc 30f
>  	cmpq threadinfo_addr_limit(%r8),%rcx
> -	jae bad_put_user
> -3:	movl %edx,-3(%rcx)
> +	jae 30f
> +3:	subq $3,%rcx
> +	movl %edx,(%rcx)
>  	xorl %eax,%eax
>  	ret
> +30:	subq $3,%rcx
> +	jmp bad_put_user
>  
>  	.p2align 4
>  .globl __put_user_8
>  __put_user_8:
>  	GET_THREAD_INFO(%r8)
>  	addq $7,%rcx
> -	jc bad_put_user
> +	jc 40f
>  	cmpq threadinfo_addr_limit(%r8),%rcx
> -	jae	bad_put_user
> -4:	movq %rdx,-7(%rcx)
> +	jae 40f
> +4:	subq $7,%rcx
> +	movq %rdx,(%rcx)
>  	xorl %eax,%eax
>  	ret
> +40:	subq $7,%rcx
> +	jmp bad_put_user
>  
>  bad_put_user:
>  	movq $(-EFAULT),%rax
> 
> 
