Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbULCDIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbULCDIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 22:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbULCDIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 22:08:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:44172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261907AbULCDIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 22:08:51 -0500
Date: Thu, 2 Dec 2004 19:08:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: do_posix_clock_monotonic_gettime() returns negative nsec
Message-Id: <20041202190823.4f287617.akpm@osdl.org>
In-Reply-To: <20041203020357.GA28468@mail.13thfloor.at>
References: <20041203020357.GA28468@mail.13thfloor.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
>
> 
> Hi Folks!
> 
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

Doesn't this imply that do_posix_clock_monotonic_gettime_parts() is
returning a negative tv_nsec?

If so, that would point back at getnstimeofday().  What is your setting of
CONFIG_TIME_INTERPOLATION?
