Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbULCDBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbULCDBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 22:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbULCDBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 22:01:08 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:2295 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261907AbULCDAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 22:00:43 -0500
Subject: Re: do_posix_clock_monotonic_gettime() returns negative nsec
From: john stultz <johnstul@us.ibm.com>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       george anzinger <george@mvista.com>
In-Reply-To: <20041203020357.GA28468@mail.13thfloor.at>
References: <20041203020357.GA28468@mail.13thfloor.at>
Content-Type: text/plain
Message-Id: <1102042850.13294.43.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Dec 2004 19:00:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 18:03, Herbert Poetzl wrote:
> recent kernels (tested 2.6.10-rc2 and 2.6.10-rc2-bk15)
> produce funny output in /proc/uptime like this:
> 
> 	# cat /proc/uptime
> 	  12.4294967218 9.05
> 	# cat /proc/uptime
> 	  13.4294967251 10.33
> 	# cat /proc/uptime
> 	  14.4294967295 11.73
> 
> a short investigation of the issue, ended at
> do_posix_clock_monotonic_gettime() which can (and 
> often does) return negative nsec values (within
> one second), so while the actual 'time' returned
> is correct, some parts of the kernel assume that
> those part is within the range (0 - NSEC_PER_SEC)
> 
>         len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
>                         (unsigned long) uptime.tv_sec,
>                         (uptime.tv_nsec / (NSEC_PER_SEC / 100)),
> 
> as the function itself corrects overflows, it would
> make sense to me to correct underflows too, for 
> example with the following patch:
> 
> --- ./kernel/posix-timers.c.orig	2004-11-19 21:11:05.000000000 +0100
> +++ ./kernel/posix-timers.c	2004-12-03 02:23:56.000000000 +0100
> @@ -1208,7 +1208,10 @@ int do_posix_clock_monotonic_gettime(str
>  	tp->tv_sec += wall_to_mono.tv_sec;
>  	tp->tv_nsec += wall_to_mono.tv_nsec;
>  
> -	if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
> +	if (tp->tv_nsec < 0) {
> +		tp->tv_nsec += NSEC_PER_SEC;
> +		tp->tv_sec--;
> +	} else if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
>  		tp->tv_nsec -= NSEC_PER_SEC;
>  		tp->tv_sec++;
>  	}

Sounds like its a good fix to me. 

George: You have any comment?

thanks
-john


