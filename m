Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWA0Xci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWA0Xci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWA0Xci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:32:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422685AbWA0Xci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:32:38 -0500
Date: Fri, 27 Jan 2006 15:34:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joe Perches <joe@perches.com>
Cc: rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: arch/i386/kernel/nmi.c: fix compiler warning
Message-Id: <20060127153405.62ceceab.akpm@osdl.org>
In-Reply-To: <1138309701.27471.12.camel@localhost>
References: <1138307625.30814.13.camel@mindpipe>
	<1138309701.27471.12.camel@localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> wrote:
>
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -90,12 +90,25 @@ void smp_prepare_boot_cpu(void);
>  #else /* !SMP */
>  
>  /*
> - *	These macros fold the SMP functionality into a single CPU system
> + *	These macros and inlines fold the SMP functionality
> + *	for single CPU systems
>   */
>  #define raw_smp_processor_id()			0
>  #define hard_smp_processor_id()			0
> -#define smp_call_function(func,info,retry,wait)	({ 0; })
> -#define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
> +
> +static inline int smp_call_function(void (*func) (void *info), void *info,
> +			      int retry, int wait)
> +{
> +	return 0;
> +}

I think we tried this before and it broke things.  Because there are
callback functions which are inside CONFIG_SMP.  With the macro, they don't
get referred to at all.  Wth the inline, the compiler needs to see their
definition and errors out.
