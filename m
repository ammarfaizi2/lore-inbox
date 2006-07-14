Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWGOTRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWGOTRd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 15:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWGOTRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 15:17:33 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:19370 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030229AbWGOTRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 15:17:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fKhUiAYzVzNqDDDpQkGfFJ0v5m1oY5BFp/QdzS6jafVZSMr4lkiN273ikqzOYPjLe8Q2DMWnirA8T/2bAjp2L9Hr3RDTtlzLjRC4tyQwmUtZ/VL8GfvT7ELm+5Q84rf3yO5VVVnPEeb5b/e0QfX8/XWmyB0yjNIkZg1cO/5AOIA=  ;
Message-ID: <44B79BFD.10005@yahoo.com.au>
Date: Fri, 14 Jul 2006 23:28:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove volatile from nmi.c
References: <1152882288.1883.30.camel@localhost.localdomain>
In-Reply-To: <1152882288.1883.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> OK, I'm using this as something of an exercise to completely understand
> memory barriers.  So if something is incorrect, please let me know.
> 
> This patch removes the volatile keyword from arch/i386/kernel/nmi.c.
> 
> The first removal is trivial, since the barrier in the while loop makes
> it unnecessary. (as proved in "[patch] spinlocks: remove 'volatile'"
> thread)
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115217423929806&w=2
> 
> 
> The second is what I think is correct.  So please review.

Please comment memory barriers if possible.

The second adds memory barriers that weren't there before... how come
they are needed? Basically, the comment should be a pointer to the
read side, or illustrate a typical readside where write reordering
would cause a problem.

> 
> Thanks,
> 
> -- Steve
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux-2.6.18-rc1/arch/i386/kernel/nmi.c
> ===================================================================
> --- linux-2.6.18-rc1.orig/arch/i386/kernel/nmi.c	2006-07-14 08:35:00.000000000 -0400
> +++ linux-2.6.18-rc1/arch/i386/kernel/nmi.c	2006-07-14 08:38:07.000000000 -0400
> @@ -106,7 +106,7 @@ int nmi_active;
>   */
>  static __init void nmi_cpu_busy(void *data)
>  {
> -	volatile int *endflag = data;
> +	int *endflag = data;
>  	local_irq_enable_in_hardirq();
>  	/* Intentionally don't use cpu_relax here. This is
>  	   to make sure that the performance counter really ticks,
> @@ -121,7 +121,7 @@ static __init void nmi_cpu_busy(void *da
>  
>  static int __init check_nmi_watchdog(void)
>  {
> -	volatile int endflag = 0;
> +	int endflag = 0;
>  	unsigned int *prev_nmi_count;
>  	int cpu;
>  
> @@ -150,7 +150,7 @@ static int __init check_nmi_watchdog(voi
>  			continue;
>  #endif
>  		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
> -			endflag = 1;
> +			set_wmb(endflag, 1);
>  			printk("CPU#%d: NMI appears to be stuck (%d->%d)!\n",
>  				cpu,
>  				prev_nmi_count[cpu],
> @@ -161,7 +161,7 @@ static int __init check_nmi_watchdog(voi
>  			return -1;
>  		}
>  	}
> -	endflag = 1;
> +	set_wmb(endflag, 1);
>  	printk("OK.\n");
>  
>  	/* now that we know it works we can reduce NMI frequency to


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
