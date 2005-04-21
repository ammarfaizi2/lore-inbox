Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVDUNHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVDUNHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 09:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVDUNHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 09:07:24 -0400
Received: from 26.mail-out.ovh.net ([213.186.42.179]:52888 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP id S261350AbVDUNHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 09:07:08 -0400
Subject: Re: x86_64: Bug in new out of line put_user()
From: Nicolas Boichat <nicolas@boichat.ch>
To: Alexander Nyberg <alexn@telia.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1114038609.500.2.camel@localhost.localdomain>
References: <1114038609.500.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 15:05:30 +0200
Message-Id: <1114088730.10903.3.camel@dudule>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-Ovh-Remote: 62.167.221.4 ()
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.0|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 2005-04-21 at 01:10 +0200, Alexander Nyberg wrote:
> The new out of line put_user() assembly on x86_64 changes %rcx without
> telling GCC about it causing things like:
> 
> http://bugme.osdl.org/show_bug.cgi?id=4515 

Thank you, this patch fixes the message queue problem.

Best regards,

Nicolas

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
> 

