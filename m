Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWEIJq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWEIJq2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 05:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWEIJq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 05:46:28 -0400
Received: from www.osadl.org ([213.239.205.134]:18644 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751572AbWEIJq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 05:46:28 -0400
Subject: Re: [Patch 1/8] Setup
From: Thomas Gleixner <tglx@linutronix.de>
To: balbir@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060502061255.GL13962@in.ibm.com>
References: <20060502061255.GL13962@in.ibm.com>
Content-Type: text/plain
Date: Tue, 09 May 2006 11:46:46 +0000
Message-Id: <1147175206.7392.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 11:42 +0530, Balbir Singh wrote:
>  /*
> + * sub = end - start, in normalized form
> + */
> +static inline void timespec_sub(struct timespec *start, struct timespec *end,
> +				struct timespec *sub)
> +{
> +	set_normalized_timespec(sub, end->tv_sec - start->tv_sec,
> +				end->tv_nsec - start->tv_nsec);
> +}

Please use the existing ktime_t functions for that purpose. The ktime_t
format has nanosecond resolution and is optimized for 32/64bit machines.

> +static inline void delayacct_start(struct timespec *start)
> +{
> +	do_posix_clock_monotonic_gettime(start);
> +}

Please get rid of this wrapper and use the ktime based functions for
that.

> +/*
> + * Finish delay accounting for a statistic using
> + * its timestamps (@start, @end), accumalator (@total) and @count
> + */
> +
> +static inline void delayacct_end(struct timespec *start, struct timespec *end,
> +				u64 *total, u32 *count)

Please use ktime_t for total.
			
> +{
> +	struct timespec ts = {0, 0};
> +	s64 ns;
> +
> +	do_posix_clock_monotonic_gettime(end);
> +	timespec_sub(&ts, start, end);
> +	ns = timespec_to_ns(&ts);
> +	if (ns < 0)
> +		return;

monotonic time is monotonic increasing. So delta is always >= 0 !

	tglx


