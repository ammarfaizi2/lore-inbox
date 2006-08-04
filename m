Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWHDFfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWHDFfs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWHDFfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:35:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:7634 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030263AbWHDFfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:35:47 -0400
Date: Fri, 4 Aug 2006 16:35:43 +0530
From: "S. P. Prasanna" <prasanna@in.ibm.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386: entry.s::error_code is not safe for kprobes
Message-ID: <20060804110543.GA10085@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <200608030623_MC3-1-C6F0-24AD@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608030623_MC3-1-C6F0-24AD@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck,

Thanks for fixing the problem. Patch looks good to me.
I will make those changes for x86_64.

Thanks
Prasanna

On Thu, Aug 03, 2006 at 06:20:19AM -0400, Chuck Ebbert wrote:
> Because code marked unsafe for kprobes jumps directly to
> entry.S::error_code, that must be marked unsafe as well.
> The easiest way to do that is to move the page fault entry
> point to just before error_code and let it inherit the same
> section.
> 
> Also moved all the ".previous" asm directives for kprobes
> sections to column 1 and removed ".text" from them.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> ---
> 
> x86_64 also has this problem but I wasn't sure whether to move
> error_entry into .kprobes.text or convert offendors to the
> "paranoid" infrastructure.
> 
>  arch/i386/kernel/entry.S |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)
> 
> --- 2.6.18-rc3-nb.orig/arch/i386/kernel/entry.S
> +++ 2.6.18-rc3-nb/arch/i386/kernel/entry.S
> @@ -587,11 +587,9 @@ ENTRY(name)				\
>  /* The include is where all of the SMP etc. interrupts come from */
>  #include "entry_arch.h"
>  
> -ENTRY(divide_error)
> -	RING0_INT_FRAME
> -	pushl $0			# no error code
> -	CFI_ADJUST_CFA_OFFSET 4
> -	pushl $do_divide_error
> +KPROBE_ENTRY(page_fault)
> +	RING0_EC_FRAME
> +	pushl $do_page_fault
>  	CFI_ADJUST_CFA_OFFSET 4
>  	ALIGN
>  error_code:
> @@ -641,6 +639,7 @@ error_code:
>  	call *%edi
>  	jmp ret_from_exception
>  	CFI_ENDPROC
> +.previous
>  
>  ENTRY(coprocessor_error)
>  	RING0_INT_FRAME
> @@ -716,7 +715,8 @@ debug_stack_correct:
>  	call do_debug
>  	jmp ret_from_exception
>  	CFI_ENDPROC
> -	.previous .text
> +.previous
> +
>  /*
>   * NMI is doubly nasty. It can happen _while_ we're handling
>   * a debug fault, and the debug fault hasn't yet been able to
> @@ -812,7 +812,7 @@ KPROBE_ENTRY(int3)
>  	call do_int3
>  	jmp ret_from_exception
>  	CFI_ENDPROC
> -	.previous .text
> +.previous
>  
>  ENTRY(overflow)
>  	RING0_INT_FRAME
> @@ -877,7 +877,7 @@ KPROBE_ENTRY(general_protection)
>  	CFI_ADJUST_CFA_OFFSET 4
>  	jmp error_code
>  	CFI_ENDPROC
> -	.previous .text
> +.previous
>  
>  ENTRY(alignment_check)
>  	RING0_EC_FRAME
> @@ -886,13 +886,14 @@ ENTRY(alignment_check)
>  	jmp error_code
>  	CFI_ENDPROC
>  
> -KPROBE_ENTRY(page_fault)
> -	RING0_EC_FRAME
> -	pushl $do_page_fault
> +ENTRY(divide_error)
> +	RING0_INT_FRAME
> +	pushl $0			# no error code
> +	CFI_ADJUST_CFA_OFFSET 4
> +	pushl $do_divide_error
>  	CFI_ADJUST_CFA_OFFSET 4
>  	jmp error_code
>  	CFI_ENDPROC
> -	.previous .text
>  
>  #ifdef CONFIG_X86_MCE
>  ENTRY(machine_check)
> -- 
> Chuck

-- 
S.P. Prasanna
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
