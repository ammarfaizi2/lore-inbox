Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVCDAxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVCDAxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVCDAuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:50:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:9946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262750AbVCDAp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:45:29 -0500
Date: Thu, 3 Mar 2005 16:45:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt
Message-Id: <20050303164520.0c0900df.akpm@osdl.org>
In-Reply-To: <1109869828.2908.18.camel@mindpipe>
References: <1109869828.2908.18.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> AFAICT this code is equivalent and cleans up the (efi_)set_rtc_mmss code
> referred to as "horrible... FIXME" in the comments.  Completely
> untested.
> 
> Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
> 
> --- linux-2.6.11-rc4/arch/i386/kernel/time.c.orig	2005-03-03 11:52:32.000000000 -0500
> +++ linux-2.6.11-rc4/arch/i386/kernel/time.c	2005-03-03 12:02:20.000000000 -0500
> @@ -254,16 +254,10 @@
>  			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
>  	    (xtime.tv_nsec / 1000)
>  			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
> -		/* horrible...FIXME */
> -		if (efi_enabled) {
> -	 		if (efi_set_rtc_mmss(xtime.tv_sec) == 0)
> -				last_rtc_update = xtime.tv_sec;
> -			else
> -				last_rtc_update = xtime.tv_sec - 600;
> -		} else if (set_rtc_mmss(xtime.tv_sec) == 0)
> -			last_rtc_update = xtime.tv_sec;
> -		else
> -			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
> +	        last_rtc_update = xtime.tv_sec;
> +		if (efi_enabled && efi_set_rtc_mmss(xtime.tv_sec) || 
> +			set_rtc_mmss(xtime.tv_sec))
> +			last_rtc_update -= 600;

It's not equivalent.

If efi_enabled is true and efi_set_rtc_mmss(xtime.tv_sec) returns zero, the
new code will run set_rtc_mmss(xtime.tv_sec) whereas the old code won't.

