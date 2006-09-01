Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWIADqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWIADqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 23:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWIADqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 23:46:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18373 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750967AbWIADqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 23:46:49 -0400
Date: Thu, 31 Aug 2006 20:46:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Frank v Waveren <fvw@var.cx>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-Id: <20060831204612.73ed7f33.akpm@osdl.org>
In-Reply-To: <1156927468.29250.113.camel@localhost.localdomain>
References: <1156927468.29250.113.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 10:44:28 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Frank v. Waveren pointed out that on 64bit machines the timespec to
> ktime_t conversion might overflow. This is also true for timeval to
> ktime_t conversions. This breaks a "sleep inf" on 64bit machines.
> 
> While a timespec/timeval with tx.sec = MAX_LONG is valid by
> specification the internal representation of ktime_t is based on
> nanoseconds. The conversion of seconds to nanoseconds overflows for
> seconds values >= (MAX_LONG / NSEC_PER_SEC).
> 
> Check the seconds argument to the conversion and limit it to the maximum
> time which can be represented by ktime_t.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> diff --git a/include/linux/ktime.h b/include/linux/ktime.h
> index ed3396d..1beafb3 100644
> --- a/include/linux/ktime.h
> +++ b/include/linux/ktime.h
> @@ -57,6 +57,7 @@ typedef union {
>  } ktime_t;
>  
>  #define KTIME_MAX			(~((u64)1 << 63))
> +#define KTIME_SEC_MAX			(KTIME_MAX / NSEC_PER_SEC)
>  
>  /*
>   * ktime_t definitions when using the 64-bit scalar representation:
> @@ -73,6 +74,10 @@ typedef union {
>   */
>  static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
>  {
> +#if (BITS_PER_LONG == 64)
> +	if (unlikely(secs >= KTIME_SEC_MAX))
> +		return (ktime_t){ .tv64 = KTIME_MAX };
> +#endif
>  	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
>  }
>  

This makes my FC3 x86_64 testbox hang during udev startup.  sysrq-T trace at
http://www.zip.com.au/~akpm/linux/patches/stuff/log-x.

I had a quick look at the args to hrtimer_nanosleep and all seems to be in
order.
