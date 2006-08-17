Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWHQPsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWHQPsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWHQPsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:48:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55058 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932516AbWHQPsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:48:20 -0400
Date: Thu, 17 Aug 2006 15:48:06 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       william.morrow@amd.com
Subject: Re: [RFC/PATCH] ACPI:  Correctly recover from a failed S3 attempt
Message-ID: <20060817154805.GA6450@ucw.cz>
References: <20060808200434.GJ14539@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808200434.GJ14539@cosmic.amd.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We have a poorly behaving BIOS that simply returns from its suspend
> procedure, rather then jumping to the restart routine indicated by
> the FACS.  This appears to Linux as a failed S3 attempt.
> 
> This would normally succeed, but the sysenter msrs are not
> restored and the restart fails.  It is not clear if this is the only
> omission, but if the sysenter msrs are manually entered in the debugger, 
> the OS resumes.
> 
> The attached patch would invoke the register restore function on failure.
> This has absolutely no effect on correct systems, and, "does the right thing"
> for failed or stupid BIOSes, at least as far as I am concerned.

Can we get fixed bios, too?

What machines are affected?

> --- a/arch/i386/kernel/acpi/wakeup.S
> +++ b/arch/i386/kernel/acpi/wakeup.S
> @@ -292,7 +292,10 @@ ENTRY(do_suspend_lowlevel)
>  	pushl	$3
>  	call	acpi_enter_sleep_state
>  	addl	$4, %esp
> -	ret
> +
> +#	In case of S3 failure, we'll emerge here.  Jump
> +# 	to ret_point to recover
> +	jmp	ret_point
>  	.p2align 4,,7

%esp manipulation is now unneccessary?

Can we somehow propagate the error condition?

Why jmp when ret_point is next instruction?

>  ret_point:
>  	call	restore_registers


-- 
Thanks for all the (sleeping) penguins.
