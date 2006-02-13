Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWBMVLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWBMVLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWBMVLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:11:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64986 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964875AbWBMVLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:11:21 -0500
Date: Mon, 13 Feb 2006 13:11:13 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15:kernel/time.c: The Nanosecond and code duplication
In-Reply-To: <43F05143.29965.5D3E74@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.62.0602131308280.3026@schroedinger.engr.sgi.com>
References: <43F05143.29965.5D3E74@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Ulrich Windl wrote:

> There's a hacked-on getnstimeofday() which, what I discovered doesn't actually 
> pass along the nanosecond resolution of xtime. It does:

This is the fall back function for arches without nanosecond 
resolution....

> The proper solution most likely is to define POSIX compatible routines with 
> nanosecond resolution, and then define the microsecond-resolution from those, and 
> not the other way round.

Right.

> -#ifdef CONFIG_TIME_INTERPOLATION
> +/* get system time with nanosecond accuracy */
>  void getnstimeofday (struct timespec *tv)
>  {
> -	unsigned long seq,sec,nsec;
> -
> +	unsigned long seq, nsec, sec, offset;
>  	do {
>  		seq = read_seqbegin(&xtime_lock);
> +#ifdef CONFIG_TIME_INTERPOLATION
> +		offset = time_interpolator_get_offset();
> +#else
> +		offset = 0;
> +#endif
>  		sec = xtime.tv_sec;
> -		nsec = xtime.tv_nsec+time_interpolator_get_offset();
> +		nsec = xtime.tv_nsec + offset;
>  	} while (unlikely(read_seqretry(&xtime_lock, seq)));
>  
> +#ifdef CONFIG_TIME_INTERPOLATION
>  	while (unlikely(nsec >= NSEC_PER_SEC)) {
>  		nsec -= NSEC_PER_SEC;
>  		++sec;
>  	}
> +#endif
>  	tv->tv_sec = sec;
>  	tv->tv_nsec = nsec;
>  }
>  EXPORT_SYMBOL_GPL(getnstimeofday);

Looks okay.

> +#ifdef CONFIG_TIME_INTERPOLATION
> +/* this is a mess: there are also architecture-dependent ``do_gettimeofday()''
> + * and ``do_settimeofday()''
> + */

Yes, we would like to get rid of the arch specific 
do_get/settimeofday() in the future.

