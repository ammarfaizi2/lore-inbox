Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWADI0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWADI0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 03:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWADI0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 03:26:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47324 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751208AbWADI0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 03:26:04 -0500
Subject: Re: + time-generic-timekeeping-infrastructure.patch added to -mm
	tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: johnstul@us.ibm.com
In-Reply-To: <200601040036.k040aOS1001312@shell0.pdx.osdl.net>
References: <200601040036.k040aOS1001312@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 09:25:55 +0100
Message-Id: <1136363161.2839.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 16:36 -0800, akpm@osdl.org wrote:

>  
> +static inline void normalize_timespec(struct timespec *ts)
> +{
> +	while (unlikely((unsigned long)ts->tv_nsec >= NSEC_PER_SEC)) {
> +		ts->tv_nsec -= NSEC_PER_SEC;
> +		ts->tv_sec++;
> +	}
> +}
> +
> +static inline void timespec_add_ns(struct timespec *a, nsec_t ns)
> +{
> +	while(unlikely(ns >= NSEC_PER_SEC)) {
> +		ns -= NSEC_PER_SEC;
> +		a->tv_sec++;
> +	}
> +	a->tv_nsec += ns;
> +	normalize_timespec(a);
> +}
> +
>  #endif /* __KERNEL__ */
>  

are you sure you want this one inlined? that's 2 while loops already....
(and afaics the ns argument isn't a constant really so the first one
doesn't optimize out)


> +/**
> + * __get_nsec_offset - Returns nanoseconds since last call to periodic_hook
> + *
> + * private function, must hold system_time_lock lock when being
> + * called. Returns the number of nanoseconds since the
> + * last call to timeofday_periodic_hook() (adjusted by NTP scaling)
> + */
> +static inline nsec_t __get_nsec_offset(void)
> +{
> +	cycle_t cycle_now, cycle_delta;
> +	nsec_t ns_offset;
> +
> +	/* read clocksource: */
> +	cycle_now = read_clocksource(clock);
> +
> +	/* calculate the delta since the last timeofday_periodic_hook: */
> +	cycle_delta = (cycle_now - cycle_last) & clock->mask;
> +
> +	/* convert to nanoseconds: */
> +	ns_offset = cyc2ns(clock, ntp_adj, cycle_delta);
> +
> +	/*
> +	 * special case for jiffies tick/offset based systems,
> +	 * add arch-specific offset:
> +	 */
> +	ns_offset += arch_getoffset();
> +
> +	return ns_offset;
> +}

likewise here.. 

