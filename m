Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVG1BAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVG1BAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVG1BAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:00:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7409 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261229AbVG1BAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:00:36 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1122473595.29823.60.camel@localhost.localdomain>
References: <1122473595.29823.60.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 18:00:20 -0700
Message-Id: <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't you break sched_find_first_bit() , seems it's dependent on a 
140-bit bitmap .

Daniel


On Wed, 2005-07-27 at 10:13 -0400, Steven Rostedt wrote:
> The following patch makes the MAX_RT_PRIO and MAX_USER_RT_PRIO
> configurable from the make *config.  This is more of a proposal since
> I'm not really sure where in Kconfig this would best fit. I don't see
> why these options shouldn't be user configurable without going into the
> kernel headers to change them.
> 
> Also, is there a way in the Kconfig to force the checking of
> MAX_USER_RT_PRIO <= MAX_RT_PRIO?
> 
> -- Steve
> 
> (Patched against 2.6.12.2)
> 
> Index: vanilla_kernel/include/linux/sched.h
> ===================================================================
> --- vanilla_kernel/include/linux/sched.h	(revision 263)
> +++ vanilla_kernel/include/linux/sched.h	(working copy)
> @@ -389,9 +389,13 @@
>   * MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
>   */
>  
> -#define MAX_USER_RT_PRIO	100
> -#define MAX_RT_PRIO		MAX_USER_RT_PRIO
> +#define MAX_USER_RT_PRIO	CONFIG_MAX_USER_RT_PRIO
> +#define MAX_RT_PRIO		CONFIG_MAX_RT_PRIO
>  
> +#if MAX_USER_RT_PRIO > MAX_RT_PRIO
> +#error MAX_USER_RT_PRIO must not be greater than MAX_RT_PRIO
> +#endif
> +
>  #define MAX_PRIO		(MAX_RT_PRIO + 40)
>  
>  #define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
> Index: vanilla_kernel/init/Kconfig
> ===================================================================
> --- vanilla_kernel/init/Kconfig	(revision 263)
> +++ vanilla_kernel/init/Kconfig	(working copy)
> @@ -162,6 +162,32 @@
>  	  building a kernel for install/rescue disks or your system is very
>  	  limited in memory.
>  
> +config MAX_RT_PRIO
> +	int "Maximum RT priority"
> +	default 100
> +	help
> +	  The real-time priority of threads that have the policy of SCHED_FIFO
> +	  or SCHED_RR have a priority higher than normal threads.  This range
> +	  can be set here, where the range starts from 0 to MAX_RT_PRIO-1.
> +	  If this range is higher than MAX_USER_RT_PRIO than kernel threads
> +	  may have a higher priority than any user thread.
> +
> +	  This may be the same as MAX_USER_RT_PRIO, but do not set this 
> +	  to be less than MAX_USER_RT_PRIO.
> +
> +config MAX_USER_RT_PRIO
> +	int "Maximum User RT priority"
> +	default 100
> +	help
> +	  The real-time priority of threads that have the policy of SCHED_FIFO
> +	  or SCHED_RR have a priority higher than normal threads.  This range
> +	  can be set here, where the range starts from 0 to MAX_USER_RT_PRIO-1.
> +	  If this range is lower than MAX_RT_PRIO, than kernel threads may have
> +	  a higher priority than any user thread.
> +
> +	  This may be the same as MAX_RT_PRIO, but do not set this to be
> +	  greater than MAX_RT_PRIO.
> +	  
>  config AUDIT
>  	bool "Auditing support"
>  	default y if SECURITY_SELINUX
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

