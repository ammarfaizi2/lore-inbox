Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265122AbTFRJ3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 05:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbTFRJ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 05:29:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51441 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265122AbTFRJ3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 05:29:07 -0400
Message-ID: <3EF02D07.6000108@mvista.com>
Date: Wed, 18 Jun 2003 02:12:39 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "B. D. Elliott" <bde@nwlink.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: Sparc64-2.5.72: A Serious Time Problem
References: <20030618073556.94E966A4FC@smtp4.pacifier.net>
In-Reply-To: <20030618073556.94E966A4FC@smtp4.pacifier.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

B. D. Elliott wrote:
> There is a serious bug in setting time on 64-bit sparcs (and probably other
> 64-bit systems).  The symptom is that ntpdate or date set the time back to
> 1969 or 1970.  The underlying problems are that stime is broken, and any
> settimeofday call fails with a bad fractional value.  Ntpdate falls back to
> stime when settimeofday fails.
> 
> The settimeofday problem is that the timeval and timespec structures are not
> the same size.  In particular, the fractional part is an int in timeval, and
> a long in timespec.  The stime problem is that the argument is not an int,
> but a time_t, which is long on at least some 64-bit systems.
> 
> The following patch appears to fix this on my sparc64.

Looks reasonable.  The stime problem must have been there for some 
time but I just introduced the timespec/ timeval thing.  Someday soon 
I will get this 64-bit long/int thing down.  I promise :)

-g
> 
> ===================================================================
> --- ./kernel/time.c.orig	2003-06-16 22:36:04.000000000 -0700
> +++ ./kernel/time.c	2003-06-18 00:00:43.000000000 -0700
> @@ -66,7 +66,7 @@
>   * architectures that need it).
>   */
>   
> -asmlinkage long sys_stime(int * tptr)
> +asmlinkage long sys_stime(time_t * tptr)
>  {
>  	struct timespec tv;
>  
> @@ -162,13 +162,15 @@
>  
>  asmlinkage long sys_settimeofday(struct timeval __user *tv, struct timezone __user *tz)
>  {
> +	struct timeval user_tv;
>  	struct timespec	new_tv;
>  	struct timezone new_tz;
>  
>  	if (tv) {
> -		if (copy_from_user(&new_tv, tv, sizeof(*tv)))
> +		if (copy_from_user(&user_tv, tv, sizeof(*tv)))
>  			return -EFAULT;
> -		new_tv.tv_nsec *= NSEC_PER_USEC;
> +		new_tv.tv_sec = user_tv.tv_sec;
> +		new_tv.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
>  	}
>  	if (tz) {
>  		if (copy_from_user(&new_tz, tz, sizeof(*tz)))
> ===================================================================
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

