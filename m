Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272097AbRHVT7R>; Wed, 22 Aug 2001 15:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272103AbRHVT7I>; Wed, 22 Aug 2001 15:59:08 -0400
Received: from member.michigannet.com ([207.158.188.18]:55826 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S272097AbRHVT6x>; Wed, 22 Aug 2001 15:58:53 -0400
Date: Wed, 22 Aug 2001 15:52:26 -0400
From: Paul <set@pobox.com>
To: Andi Kleen <ak@suse.de>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, Wilfried.Weissmann@gmx.at
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
Message-ID: <20010822155226.A228@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, Andi Kleen <ak@suse.de>,
	Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk, Wilfried.Weissmann@gmx.at
In-Reply-To: <20010819004703.A226@squish.home.loc.suse.lists.linux.kernel> <3B831CDF.4CC930A7@didntduck.org.suse.lists.linux.kernel> <oupn14sny4f.fsf@pigdrop.muc.suse.de> <3B839E47.874F8F64@didntduck.org> <20010822141058.A18043@gruyere.muc.suse.de> <3B83A17C.CB8ABC53@didntduck.org> <20010822152203.A18873@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010822152203.A18873@gruyere.muc.suse.de>; from ak@suse.de on Wed, Aug 22, 2001 at 03:22:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de>, on Wed Aug 22, 2001 [03:22:03 PM] said:
> 
> Here is a new patch with both checks.
> 

	Dear Andi;

	Well, with this patch, the kernel doesnt oops, but vm86
seems to be busted now. save_v86_state() pops out:
	'vm86: could not access userspace vm86_info'
and gives dosemu a segv.

Paul
set@pobox.com

> 
> --- include/asm-i386/hw_irq.h-SEG2	Mon Aug 20 02:54:53 2001
> +++ include/asm-i386/hw_irq.h	Wed Aug 22 13:02:16 2001
> @@ -114,8 +114,10 @@
>  	"cmpl %eax,7*4(%esp)\n\t"  \
>  	"je 1f\n\t"  \
>  	"movl %eax,%ds\n\t" \
> +	"1: cmpl %eax,8*4(%esp)\n\t" \
> +	"je 2f\n\t" \
>  	"movl %eax,%es\n\t" \
> -	"1:\n\t"
> +	"2:\n\t"
>  
>  #define IRQ_NAME2(nr) nr##_interrupt(void)
>  #define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)
> --- arch/i386/kernel/entry.S-SEG2	Sat Aug 18 08:41:53 2001
> +++ arch/i386/kernel/entry.S	Wed Aug 22 15:07:44 2001
> @@ -292,8 +292,11 @@
>  	cmpl %edx,%ecx
>  	jz	1f
>  	movl %edx,%ds
> +1:	movl %ds,%ecx
> +	cmpl $(__KERNEL_DS),%edx
> +	jz   2f	
>  	movl %edx,%es
> -1:	GET_CURRENT(%ebx)
> +2:	GET_CURRENT(%ebx)
>  	call *%edi
>  	addl $8,%esp
>  	jmp ret_from_exception
> 
> 
> -Andi
