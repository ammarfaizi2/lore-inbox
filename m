Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268030AbUHQABP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268030AbUHQABP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHQABP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:01:15 -0400
Received: from [139.30.44.16] ([139.30.44.16]:53419 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S268030AbUHQABG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:01:06 -0400
Date: Tue, 17 Aug 2004 01:56:09 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, albert@users.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi, george@mvista.com,
       johnstul@us.ibm.com, david+powerix@blue-labs.org
Subject: Re: boot time, process start time, and NOW time
In-Reply-To: <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.53.0408170147150.14197@gockel.physik3.uni-rostock.de>
References: <1087948634.9831.1154.camel@cube> <87smcf5zx7.fsf@devron.myhome.or.jp>
 <20040816124136.27646d14.akpm@osdl.org> <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Where did this all end up?  Complaints about wandering start times are
> > persistent, and it'd be nice to get some fix in place...
[...]

> Simple fix: revert the patch below.
> Complicated fix: correct process start times in fork.c (no patch provided, 
> too complicated for me to do).

Well, if we actually revert the patch, we'd also need to revert the 
changes made to jiffies_to_clock_t() & Co. in response to the patch.
Otherwise we again end up inconsistent.

I could make a patch for that tomorrow, if there's interest. At least to 
show that my analysis actually is correct.

Alternatively we might formulate uptime in terms of jiffies_to_clock_t()). 


Tim



> diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
> --- a/fs/proc/proc_misc.c	2004-08-16 15:48:44 -07:00
> +++ b/fs/proc/proc_misc.c	2004-08-16 15:48:44 -07:00
> @@ -137,36 +137,19 @@
>  static int uptime_read_proc(char *page, char **start, off_t off,
>  				 int count, int *eof, void *data)
>  {
> -	u64 uptime;
> -	unsigned long uptime_remainder;
> +	struct timespec uptime;
> +	struct timespec idle;
>  	int len;
> +	u64 idle_jiffies = init_task.utime + init_task.stime;
>  
> -	uptime = get_jiffies_64() - INITIAL_JIFFIES;
> -	uptime_remainder = (unsigned long) do_div(uptime, HZ);
> +	do_posix_clock_monotonic_gettime(&uptime);
> +	jiffies_to_timespec(idle_jiffies, &idle);
> +	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> +			(unsigned long) uptime.tv_sec,
> +			(uptime.tv_nsec / (NSEC_PER_SEC / 100)),
> +			(unsigned long) idle.tv_sec,
> +			(idle.tv_nsec / (NSEC_PER_SEC / 100)));
>  
> -#if HZ!=100
> -	{
> -		u64 idle = init_task.utime + init_task.stime;
> -		unsigned long idle_remainder;
> -
> -		idle_remainder = (unsigned long) do_div(idle, HZ);
> -		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> -			(unsigned long) uptime,
> -			(uptime_remainder * 100) / HZ,
> -			(unsigned long) idle,
> -			(idle_remainder * 100) / HZ);
> -	}
> -#else
> -	{
> -		unsigned long idle = init_task.utime + init_task.stime;
> -
> -		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> -			(unsigned long) uptime,
> -			uptime_remainder,
> -			idle / HZ,
> -			idle % HZ);
> -	}
> -#endif
>  	return proc_calc_metrics(page, start, off, count, eof, len);
>  }
> 
> 

