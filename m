Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVEUBPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVEUBPE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 21:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVEUBPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 21:15:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43511 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261560AbVEUBOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 21:14:46 -0400
Message-ID: <428E8B68.6040909@mvista.com>
Date: Fri, 20 May 2005 18:14:16 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corey Minyard <minyard@acm.org>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixes for IPMI use of timers
References: <428D2181.2080106@acm.org>
In-Reply-To: <428D2181.2080106@acm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard wrote:
> 
> 
> ------------------------------------------------------------------------
> 
> Fix some problems with the high-res timer support.
> 
> Signed-off-by: Corey Minyard <minyard@acm.org>
> 
> Index: linux-2.6.12-rc4/drivers/char/ipmi/ipmi_si_intf.c
> ===================================================================
> --- linux-2.6.12-rc4.orig/drivers/char/ipmi/ipmi_si_intf.c
> +++ linux-2.6.12-rc4/drivers/char/ipmi/ipmi_si_intf.c
> @@ -769,10 +769,11 @@
>  
>  		/* We already have irqsave on, so no need for it
>                     here. */
> -		read_lock(&xtime_lock);
> +		read_lock_irqsave(&xtime_lock, flags);

I rather hope this fails to compile :)  xtime_lock is a sequence lock in the 2.6 
kernel.

>  		jiffies_now = jiffies;
>  		smi_info->si_timer.expires = jiffies_now;
>  		smi_info->si_timer.sub_expires = get_arch_cycles(jiffies_now);
> +		read_unlock_irqrestore(&xtime_lock, flags);
>  
>  		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
>  
> @@ -830,11 +831,11 @@
>  		smi_info->short_timeouts++;
>  		spin_unlock_irqrestore(&smi_info->count_lock, flags);
>  #if defined(CONFIG_HIGH_RES_TIMERS)
> -		read_lock(&xtime_lock);
> +		read_lock_irqsave(&xtime_lock, flags);
>                  smi_info->si_timer.expires = jiffies;
>                  smi_info->si_timer.sub_expires
>                          = get_arch_cycles(smi_info->si_timer.expires);
> -                read_unlock(&xtime_lock);
> +		read_unlock_irqrestore(&xtime_lock, flags);
>  		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
>  #else
>  		smi_info->si_timer.expires = jiffies + 1;

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
