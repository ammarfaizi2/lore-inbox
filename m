Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbTEFUAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTEFUAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:00:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11774 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261260AbTEFUAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:00:04 -0400
Message-ID: <3EB81719.3050705@mvista.com>
Date: Tue, 06 May 2003 13:12:09 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Piel <Eric.Piel@Bull.Net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: DELAYTIMER_MAX is defined
References: <3EB7E3DA.C50258A9@Bull.Net>
In-Reply-To: <3EB7E3DA.C50258A9@Bull.Net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Piel wrote:
> Hello,
> 
> Playing around with the posix timers I've noticed that DELAYTIMER_MAX is
> not defined. This constant is specified in the POSIX specifications. It
> should contain the maximum possible value of overruns on a signal. It is
> also said that the overrun shouldn't overflow. cf
> http://www.opengroup.org/onlinepubs/007904975/functions/timer_getoverrun.html
> 
> So here is a patch to add this constant and a check that the overrun
> variable never overflow. It's for 2.5.67 but should apply flawlessly to
> 2.5.69 too.
> Actually one could wonder if the test on the overflow is really needed
> has an overrun reaching 2^31 seems very hard to happen. However the
> constant definition is not hurting anything and looks necessary for
> closer POSIX compliance.

I think this is needed in glibc.  I am not sure how that relates to 
kernel defines.

-g
> 
> Eric
> 
> 
> ------------------------------------------------------------------------
> 
> diff -ur linux-2.5.67-ia64-hrtcore/include/linux/limits.h linux-2.5.67-ia64-hrtimers/include/linux/limits.h
> --- linux-2.5.67-ia64-hrtcore/include/linux/limits.h	2003-04-22 11:10:44.000000000 +0200
> +++ linux-2.5.67-ia64-hrtimers/include/linux/limits.h	2003-05-06 13:45:48.000000000 +0200
> @@ -17,6 +17,8 @@
>  #define XATTR_SIZE_MAX 65536	/* size of an extended attribute value (64k) */
>  #define XATTR_LIST_MAX 65536	/* size of extended attribute namelist (64k) */
>  
> +#define DELAYTIMER_MAX INT_MAX	/* # timer expiration overruns a POSIX.1b timer may have */
> +
>  #define RTSIG_MAX	  32
>  
>  #endif
> diff -ur linux-2.5.67-ia64-hrtcore/include/linux/posix-timers.h linux-2.5.67-ia64-hrtimers/include/linux/posix-timers.h
> --- linux-2.5.67-ia64-hrtcore/include/linux/posix-timers.h	2003-04-22 11:10:44.000000000 +0200
> +++ linux-2.5.67-ia64-hrtimers/include/linux/posix-timers.h	2003-05-06 16:07:56.000000000 +0200
> @@ -25,6 +59,7 @@
>  
>  #define posix_bump_timer(timr) do { \
>                          (timr)->it_timer.expires += (timr)->it_incr; \
> -                        (timr)->it_overrun++;               \
> +                        if ((timr)->it_overrun < DELAYTIMER_MAX)\
> +                            (timr)->it_overrun++;               \
>                         }while (0)
>  #endif
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

