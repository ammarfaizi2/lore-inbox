Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbRHWSGm>; Thu, 23 Aug 2001 14:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269517AbRHWSGe>; Thu, 23 Aug 2001 14:06:34 -0400
Received: from member.michigannet.com ([207.158.188.18]:60683 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S269436AbRHWSGS>; Thu, 23 Aug 2001 14:06:18 -0400
Date: Thu, 23 Aug 2001 14:05:45 -0400
From: Paul <set@pobox.com>
To: Andi Kleen <ak@suse.de>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, Wilfried.Weissmann@gmx.at
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
Message-ID: <20010823140545.A224@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, Andi Kleen <ak@suse.de>,
	Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk, Wilfried.Weissmann@gmx.at
In-Reply-To: <20010819004703.A226@squish.home.loc.suse.lists.linux.kernel> <3B831CDF.4CC930A7@didntduck.org.suse.lists.linux.kernel> <oupn14sny4f.fsf@pigdrop.muc.suse.de> <3B839E47.874F8F64@didntduck.org> <20010822141058.A18043@gruyere.muc.suse.de> <3B83A17C.CB8ABC53@didntduck.org> <20010822152203.A18873@gruyere.muc.suse.de> <20010822155226.A228@squish.home.loc> <20010823153419.A8743@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010823153419.A8743@gruyere.muc.suse.de>; from ak@suse.de on Thu, Aug 23, 2001 at 03:34:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de>, on Thu Aug 23, 2001 [03:34:19 PM] said:

> I found the problem in the previous patch. Here is an updated one.
> Please test again. Again against -ac7 (or later if Alan hasn't applied 
> the earlier patch) 
> 
> 
> -Andi
> 
> 
	Good! I have beaten on this a bit, and it is holding up
for me, and there are no problems using dosemu. My thanks to
everyone who responded to this bug.

Paul
set@pobox.com

> 
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
> +++ arch/i386/kernel/entry.S	Thu Aug 23 15:20:21 2001
> @@ -291,9 +291,11 @@
>  	movl $(__KERNEL_DS),%edx
>  	cmpl %edx,%ecx
>  	jz	1f
> -	movl %edx,%ds
>  	movl %edx,%es
> -1:	GET_CURRENT(%ebx)
> +1:	cmpl %edx,9*4(%esp)	# check ds on the stack
> +	jz   2f	
> +	movl %edx,%ds
> +2:	GET_CURRENT(%ebx)
>  	call *%edi
>  	addl $8,%esp
>  	jmp ret_from_exception
