Return-Path: <linux-kernel-owner+w=401wt.eu-S1751783AbXAPQu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbXAPQu6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbXAPQuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:50:35 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:60412 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751725AbXAPQuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:50:08 -0500
Date: Tue, 16 Jan 2007 11:50:07 -0500
To: takada <takada@mbf.nifty.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fix typo in geode_configre()@cyrix.c
Message-ID: <20070116165007.GZ17267@csclub.uwaterloo.ca>
References: <20070109.184156.260789378.takada@mbf.nifty.com> <20070109173348.GF17269@csclub.uwaterloo.ca> <20070117.013835.51856830.takada@mbf.nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117.013835.51856830.takada@mbf.nifty.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 01:38:35AM +0900, takada wrote:
> You are right. I agree to your comment. These variables are needless.
> I made a patch again.

Of course there are also lots of "magic numbers" around, but I must
admit I don't personally really feel like going through the data sheet
and naming all of them.

> diff -Narup linux-2.6.19.orig/arch/i386/kernel/cpu/cyrix.c linux-2.6.19/arch/i386/kernel/cpu/cyrix.c
> --- linux-2.6.19.orig/arch/i386/kernel/cpu/cyrix.c	2006-11-30 06:57:37.000000000 +0900
> +++ linux-2.6.19/arch/i386/kernel/cpu/cyrix.c	2007-01-16 19:55:05.000000000 +0900
> @@ -161,19 +161,15 @@ static void __cpuinit set_cx86_inc(void)
>  static void __cpuinit geode_configure(void)
>  {
>  	unsigned long flags;
> -	u8 ccr3, ccr4;
>  	local_irq_save(flags);
>  
>  	/* Suspend on halt power saving and enable #SUSP pin */
>  	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
>  
> -	ccr3 = getCx86(CX86_CCR3);
> -	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* Enable */
> +	setCx86(CX86_CCR3, (getCx86(CX86_CCR3) & 0x0f) | 0x10);	/* Enable */
>  	
> -	ccr4 = getCx86(CX86_CCR4);
> -	ccr4 |= 0x38;		/* FPU fast, DTE cache, Mem bypass */
> -	
> -	setCx86(CX86_CCR3, ccr3);
> +	/* FPU fast, DTE cache, Mem bypass */
> +	setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x30);
	
Why did that change from 0x38 to 0x30?

>  	set_cx86_memwb();
>  	set_cx86_reorder();	
> @@ -415,15 +411,14 @@ static void __cpuinit cyrix_identify(str
>  		
>     	        if (dir0 == 5 || dir0 == 3)
>     	        {
> -			unsigned char ccr3, ccr4;
> +			unsigned char ccr3;
>  			unsigned long flags;
>  			printk(KERN_INFO "Enabling CPUID on Cyrix processor.\n");
>  			local_irq_save(flags);
>  			ccr3 = getCx86(CX86_CCR3);
> -			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
> -			ccr4 = getCx86(CX86_CCR4);
> -			setCx86(CX86_CCR4, ccr4 | 0x80);          /* enable cpuid  */
> -			setCx86(CX86_CCR3, ccr3);                 /* disable MAPEN */
> +			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);      /* enable MAPEN  */
> +			setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x80); /* enable cpuid  */
> +			setCx86(CX86_CCR3, ccr3);                      /* disable MAPEN */
>  			local_irq_restore(flags);
>  		}
>  	}

--
Len Sorensen
