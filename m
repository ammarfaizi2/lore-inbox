Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVHEAxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVHEAxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 20:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVHEAxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 20:53:18 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:27474 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262789AbVHEAxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 20:53:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Gkox5TU+KLwR/2g32NxiXpI71KDY1ubZ0yu7/21c3r+STcWrvleHw593YWHWABQEULTtnVHgdz0oTZZQA8rGr3fccJxgEXsZuSL4haUlPsBjE/gpjYxIw+eoTtkEwt0dTZaqvoNBp+D4hFUWzFvIEolVGHUTW80VeiBpYIpT9Jw=  ;
Message-ID: <42F2B86D.8040701@yahoo.com.au>
Date: Fri, 05 Aug 2005 10:53:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       tony@atomide.com, tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] dyn-tick3 tweaks
References: <200508022225.31429.kernel@kolivas.org> <200508051002.17344.kernel@kolivas.org> <200508051005.27162.kernel@kolivas.org> <200508051023.38234.kernel@kolivas.org>
In-Reply-To: <200508051023.38234.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> Something like this on top is cleaner and quieter. I'll add this to pending 
> changes for another version.
> 
> 
> ------------------------------------------------------------------------
> 
> Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_tsc.c
> ===================================================================
> --- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/timers/timer_tsc.c	2005-08-03 11:29:29.000000000 +1000
> +++ linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_tsc.c	2005-08-05 10:22:25.000000000 +1000
> @@ -167,10 +167,20 @@ static void delay_tsc(unsigned long loop
>  	} while ((now-bclock) < loops);
>  }
>  
> +/* update the monotonic base value */
> +static inline void update_monotonic_base(unsigned long long last_offset)
> +{
> +	unsigned long long this_offset;
> +
> +	this_offset = ((unsigned long long)last_tsc_high << 32) | last_tsc_low;
> +	monotonic_base += cycles_2_ns(this_offset - last_offset);
> +	write_sequnlock(&monotonic_lock);
> +}
> +

All else being equal, it is much better if you unlock in the
same function that takes the lock. For readability.

It looks like you should be able to leave all the flow control
and locking the same, and use update_monotonic_base() to
do the actual update?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
