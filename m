Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262672AbTCIXtU>; Sun, 9 Mar 2003 18:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262673AbTCIXtU>; Sun, 9 Mar 2003 18:49:20 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:10250
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262672AbTCIXtR>; Sun, 9 Mar 2003 18:49:17 -0500
Subject: Re: [PATCH] small fixes in brlock.h
From: Robert Love <rml@tech9.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.50.0303091843250.1464-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303091843250.1464-100000@montezuma.mastecende.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047254400.680.10.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 09 Mar 2003 19:00:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 18:44, Zwane Mwaikambo wrote:

> --- linux-2.5.64-unwashed/include/linux/brlock.h	5 Mar 2003 05:07:54 -0000	1.1.1.1
> +++ linux-2.5.64-unwashed/include/linux/brlock.h	9 Mar 2003 23:42:26 -0000
> @@ -85,8 +85,7 @@
>  	if (idx >= __BR_END)
>  		__br_lock_usage_bug();
>  
> -	preempt_disable();
> -	_raw_read_lock(&__brlock_array[smp_processor_id()][idx]);
> +	read_lock(&__brlock_array[smp_processor_id()][idx]);
>  }

This is wrong.

We have to disable preemption prior to reading smp_processor_id(). 
Otherwise we may lock/unlock the wrong processor's brlock.  The above as
you changed it is equivalent to:

	cpu = smp_processor_id();
	/* do not want to preempt here, but we can! */
	preempt_disable();
	_raw_read_lock(&__brlock_array[cpu][idx]);

And what we had, and what we need, is:

	preempt_disable();
	cpu = smp_processor_id();
	_raw_read_lock(&__brlock_array[cpu][idx]);

In other words, we need to ensure preemption is disabled prior to
calling smp_processor_id().

We also do something similar with the write patch in lib/brlock.c, but
for different reason: to disable preemption once and not NR_CPUS times.

The rest of the patch looks fine. :)

	Robert Love

