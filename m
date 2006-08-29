Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWH2BZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWH2BZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWH2BZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:25:53 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:23203 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1750868AbWH2BZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:25:52 -0400
Message-ID: <44F3974B.6060501@vc.cvut.cz>
Date: Tue, 29 Aug 2006 03:24:27 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: cs, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Matt Domsch <Matt_Domsch@dell.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com
Subject: Re: [PATCH] Fix the EDD code misparsing the command line
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de> <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com> <44F29BCD.3080408@zytor.com> <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com> <44F335C8.7020108@zytor.com> <20060828184637.GD13464@lists.us.dell.com> <44F386B8.8000209@zytor.com>
In-Reply-To: <44F386B8.8000209@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> 
> 
> ------------------------------------------------------------------------
> 
> The EDD code would scan the command line as a fixed array, without
> taking account of either whitespace, null-termination, the old
> command-line protocol, late overrides early, or the fact that the
> command line may not be reachable from INITSEG.
> 
> This should fix those problems, and enable us to use a longer command
> line.
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> 
> 
> diff --git a/arch/i386/boot/edd.S b/arch/i386/boot/edd.S
> index 4b84ea2..03712a0 100644
> --- a/arch/i386/boot/edd.S
> +++ b/arch/i386/boot/edd.S

> +	andl	%esi, %esi
> +	jz	old_cl			# Old boot protocol?
> +
> +# Convert to a real-mode pointer in fs:si
> +	movl	%esi, %eax
> +	shrl	$4, %eax
> +	movw	%ax, %fs
> +	andw	$0xf, %si
> +	jmp	have_cl_pointer
> +
> +# Old-style boot protocol?
> +old_cl:
> +	push	%ds			# aka INITSEG
> +	pop	%fs
> +
> +	cmpw	$0xa33f, (0x20)
> +	jne	done_cl			# No command line at all?
> +	movw	(0x22), %si		# Pointer relative to INITSEG

Perhaps you should convert ds:si to flat pointer and then this flat pointer to 
fs:si using method above, to avoid problems with dword access with si > 0xfffc 
or word access with si > 0xfffe ?

> +
> +# fs:si has the pointer to the command line now
> +have_cl_pointer:
> +	
>  # loop through kernel command line one byte at a time
> -cl_loop:
> -	cmpl	$EDD_CL_EQUALS, (%si)
> +cl_atspace:
> +	movl	%fs:(%si), %eax

This looks fine for new boot protocol, but what if old boot protocol puts 
command line so that its last byte is at INITSEG:0xffff ?  You get #GP here, 
then, although command line is correctly zero terminated and does not overflow 
segment.

> +	andb	%al, %al		# End of line?
> +	jz	done_cl
> +	cmpl	$EDD_CL_EQUALS, %eax
>  	jz	found_edd_equals
> -	incl	%esi
> -	loop	cl_loop
> -	jmp	done_cl
> +	cmpb	$0x20, %al		# <= space consider whitespace
> +	ja	cl_skipword
> +	incw	%si
> +	jnz	cl_atspace

You already died with #GP when si was 0xfffd or bigger above, so this ZF test is 
probably not quite needed.

> +	jmp	done_cl			# Wraparound...
> +
> +cl_skipword:
> +	movb	%fs:(%si), %al		# End of string?
> +	andb	%al, %al
> +	jz	done_cl
> +	cmpb	$0x20, %al
> +	jbe	cl_atspace
> +	incw	%si
> +	jnz	cl_skipword
> +	jmp	done_cl			# Wraparound...
> +	
>  found_edd_equals:
>  # only looking at first two characters after equals
> -    	addl	$4, %esi
> -	cmpw	$EDD_CL_OFF, (%si)	# edd=of
> -	jz	do_edd_off
> -	cmpw	$EDD_CL_SKIP, (%si)	# edd=sk
> -	jz	do_edd_skipmbr
> -	jmp	done_cl
> +# late overrides early on the command line, so keep going after finding something
> +	movw	%fs:4(%si), %ax

If si is 0xfffb here, bad things happen.  I know, things I've pointed out should 
not be problem in real world, and new code is definitely better than old one, 
but if you already have code to avoid endless loop if command line points to 
64KB array of 0xFF let's do that right, no?
						Thanks,
							Petr Vandrovec

