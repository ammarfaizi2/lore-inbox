Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVDVAbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVDVAbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVDVAav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:30:51 -0400
Received: from quark.didntduck.org ([69.55.226.66]:43999 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261790AbVDVA17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:27:59 -0400
Message-ID: <42684603.5050500@didntduck.org>
Date: Thu, 21 Apr 2005 20:32:03 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
CC: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org,
       nicolas@boichat.ch
Subject: Re: x86_64: Bug in new out of line put_user()
References: <1114038609.500.2.camel@localhost.localdomain>
In-Reply-To: <1114038609.500.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:
> The new out of line put_user() assembly on x86_64 changes %rcx without
> telling GCC about it causing things like:
> 
> http://bugme.osdl.org/show_bug.cgi?id=4515 
> 
> See to it that %rcx is not changed (made it consistent with get_user()).
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
> -

This patch has a serious bug.  The 2, 3 and 4 labels must be on the mov 
instructions in order to catch faults.

--
				Brian Gerst
