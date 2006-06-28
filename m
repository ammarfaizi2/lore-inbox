Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWF1Tl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWF1Tl1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWF1Tl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:41:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56045 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751106AbWF1Tl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:41:26 -0400
Date: Wed, 28 Jun 2006 21:04:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Dave Jones <davej@redhat.com>
Subject: Re: [patch] i386: cpu_relax() in crash.c and doublefault.c
Message-ID: <20060628190431.GA9426@elf.ucw.cz>
References: <200606230343_MC3-1-C33B-67CA@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606230343_MC3-1-C33B-67CA@compuserve.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add cpu_relax() to infinite loops in crash.c and
> doublefault.c.  This is the safest change.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Have you actually tested this? Well, probably not, it is hard to test
this. I assume you want cpu not to overheat during panics...

> --- 2.6.17-32.orig/arch/i386/kernel/crash.c
> +++ 2.6.17-32/arch/i386/kernel/crash.c
> @@ -114,7 +114,8 @@ static int crash_nmi_callback(struct pt_
>  	atomic_dec(&waiting_for_crash_ipi);
>  	/* Assume hlt works */
>  	halt();
> -	for(;;);
> +	for (;;)
> +		cpu_relax();
>  
>  	return 1;
>  }

This is useless... cpu_relax is rep nop, that only helps on
hyperthreading-enabled CPUS. Anything new enough to support
hyperthreading already has good thermal protection.

> --- 2.6.17-32.orig/arch/i386/kernel/doublefault.c
> +++ 2.6.17-32/arch/i386/kernel/doublefault.c
> @@ -44,7 +44,8 @@ static void doublefault_fn(void)
>  		}
>  	}
>  
> -	for (;;) /* nothing */;
> +	for (;;)
> +		cpu_relax();
>  }
>  
>  struct tss_struct doublefault_tss __cacheline_aligned = {

Same here. halt() would make sense here.

But this probably needs documentation, and centralizing into
kill_current_cpu() function, or something.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
