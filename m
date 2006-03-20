Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbWCTTRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWCTTRu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWCTTRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:17:49 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:22338 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S965175AbWCTTRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:17:48 -0500
In-Reply-To: <20060318171947.060818000@towertech.it>
References: <20060318171946.821316000@towertech.it> <20060318171947.060818000@towertech.it>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D9BAADC6-9B56-437B-B286-A87E0B86D06B@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/18] RTC Subsystem, library functions
Date: Mon, 20 Mar 2006 13:18:32 -0600
To: Alessandro Zummo <a.zummo@towertech.it>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 18, 2006, at 11:19 AM, Alessandro Zummo wrote:

> RTC and date/time related functions.
>
> Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
> ---
>  drivers/Kconfig       |    2
>  drivers/Makefile      |    1
>  drivers/rtc/Kconfig   |    6 ++
>  drivers/rtc/Makefile  |    5 ++
>  drivers/rtc/rtc-lib.c |  101 ++++++++++++++++++++++++++++++++++++++ 
> ++++++++++++
>  include/linux/rtc.h   |    5 ++
>  6 files changed, 120 insertions(+)
>
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-rtc/drivers/rtc/rtc-lib.c	2006-03-13 03:26:29.000000000  
> +0100
> @@ -0,0 +1,101 @@
> +/*
> + * rtc and date/time utility functions
> + *
> + * Copyright (C) 2005-06 Tower Technologies
> + * Author: Alessandro Zummo <a.zummo@towertech.it>
> + *
> + * based on arch/arm/common/rtctime.c and other bits
> + *
> + * This program is free software; you can redistribute it and/or  
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/rtc.h>
> +
> +static const unsigned char rtc_days_in_month[] = {
> +	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
> +};
> +
> +#define LEAPS_THRU_END_OF(y) ((y)/4 - (y)/100 + (y)/400)
> +#define LEAP_YEAR(year) ((!(year % 4) && (year % 100)) || !(year %  
> 400))
> +
> +int rtc_month_days(unsigned int month, unsigned int year)
> +{
> +	return rtc_days_in_month[month] + (LEAP_YEAR(year) && month == 1);
> +}
> +EXPORT_SYMBOL(rtc_month_days);
> +
> +/*
> + * Convert seconds since 01-01-1970 00:00:00 to Gregorian date.
> + */
> +void rtc_time_to_tm(unsigned long time, struct rtc_time *tm)
> +{
> +	register int days, month, year;
> +
> +	days = time / 86400;
> +	time -= days * 86400;
> +
> +	/* day of the week, 1970-01-01 was a Thursday */
> +	tm->tm_wday = (days + 4) % 7;
> +
> +	year = 1970 + days / 365;
> +	days -= (year - 1970) * 365
> +		+ LEAPS_THRU_END_OF(year - 1)
> +		- LEAPS_THRU_END_OF(1970 - 1);
> +	if (days < 0) {
> +		year -= 1;
> +		days += 365 + LEAP_YEAR(year);
> +	}
> +	tm->tm_year = year - 1900;
> +	tm->tm_yday = days + 1;
> +
> +	for (month = 0; month < 11; month++) {
> +		int newdays;
> +
> +		newdays = days - rtc_month_days(month, year);
> +		if (newdays < 0)
> +			break;
> +		days = newdays;
> +	}
> +	tm->tm_mon = month;
> +	tm->tm_mday = days + 1;
> +
> +	tm->tm_hour = time / 3600;
> +	time -= tm->tm_hour * 3600;
> +	tm->tm_min = time / 60;
> +	tm->tm_sec = time - tm->tm_min * 60;
> +}
> +EXPORT_SYMBOL(rtc_time_to_tm);
> +
> +/*
> + * Does the rtc_time represent a valid date/time?
> + */
> +int rtc_valid_tm(struct rtc_time *tm)
> +{
> +	if (tm->tm_year < 70
> +		|| tm->tm_mon >= 12
> +		|| tm->tm_mday < 1
> +		|| tm->tm_mday > rtc_month_days(tm->tm_mon, tm->tm_year + 1900)
> +		|| tm->tm_hour >= 24
> +		|| tm->tm_min >= 60
> +		|| tm->tm_sec >= 60)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(rtc_valid_tm);
> +
> +/*
> + * Convert Gregorian date to seconds since 01-01-1970 00:00:00.
> + */
> +int rtc_tm_to_time(struct rtc_time *tm, unsigned long *time)
> +{
> +	*time = mktime(tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);
> +	return 0;
> +}
> +EXPORT_SYMBOL(rtc_tm_to_time);
> +
> +MODULE_LICENSE("GPL")

you are missing a ';' for MODULE_LICENSE.

[snip]

- kumar
