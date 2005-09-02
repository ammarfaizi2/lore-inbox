Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030624AbVIBBO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbVIBBO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbVIBBO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:14:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28923 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1030624AbVIBBO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:14:56 -0400
Message-ID: <4317A779.7090400@mvista.com>
Date: Thu, 01 Sep 2005 18:14:33 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Use proper casting with signed timespec.tv_nsec
 values
References: <1125608627.22448.4.camel@cog.beaverton.ibm.com>
In-Reply-To: <1125608627.22448.4.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> All,
> 	I recently ran into a bug with an older kernel where xtime's tv_nsec
> field had accumulated more then 2 seconds worth of time. The timespec's
> tv_nsec is a signed long, however gettimeofday() treats it as an
> unsigned long. Thus when the failure occured, very strange and difficult
> to debug time problems occurred.
> 
> The main cause of the problem I was seeing is already fixed in mainline,
> however just to be safe, I figured the following patch would be wise.
> 
> I only audited i386 and x86_64, however other arches probably could have
> similar signed problems as well.
> 
> Please let me know if you have any further comments or feedback.

John,

There is a problem in the way this code handles the conversion to usec. 
  There is a conversion here and also in the get_offset code.  If the 
nanoseconds are carrier until after the addition of the two about 25% of 
the time you will end up with an additional usec in time.  I strongly 
suggest changing to convert to usec after the addition of xtime and 
get_offset time to avoid this.  If the "correct" thing is done in 
clock_gettime() (i.e. get_offset is in nanoseconds) this actually turns 
up as a back step in time WRT gettimeofday and clock_gettime().

George
-- 
> 
> thanks
> -john
> 
> linux-2.6.13_signed-tv_nsec_A0.patch
> ====================================
> diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> --- a/arch/i386/kernel/time.c
> +++ b/arch/i386/kernel/time.c
> @@ -156,7 +156,7 @@ void do_gettimeofday(struct timeval *tv)
>  			usec += lost * (USEC_PER_SEC / HZ);
>  
>  		sec = xtime.tv_sec;
> -		usec += (xtime.tv_nsec / 1000);
> +		usec += (unsigned long)xtime.tv_nsec / 1000;
>  	} while (read_seqretry(&xtime_lock, seq));
>  
>  	while (usec >= 1000000) {
> diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> --- a/arch/x86_64/kernel/time.c
> +++ b/arch/x86_64/kernel/time.c
> @@ -128,7 +128,7 @@ void do_gettimeofday(struct timeval *tv)
>  		seq = read_seqbegin(&xtime_lock);
>  
>  		sec = xtime.tv_sec;
> -		usec = xtime.tv_nsec / 1000;
> +		usec = (unsigned long)xtime.tv_nsec / 1000;
>  
>  		/* i386 does some correction here to keep the clock 
>  		   monotonous even when ntpd is fixing drift.
> diff --git a/kernel/timer.c b/kernel/timer.c
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -824,7 +824,7 @@ static void update_wall_time(unsigned lo
>  	do {
>  		ticks--;
>  		update_wall_time_one_tick();
> -		if (xtime.tv_nsec >= 1000000000) {
> +		if ((unsigned long)xtime.tv_nsec >= 1000000000) {
>  			xtime.tv_nsec -= 1000000000;
>  			xtime.tv_sec++;
>  			second_overflow();
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
