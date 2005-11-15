Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVKOAlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVKOAlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVKOAlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:41:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932222AbVKOAlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:41:46 -0500
Date: Mon, 14 Nov 2005 16:41:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <20051114164118.7270c6ce.akpm@osdl.org>
In-Reply-To: <4378960F.8030800@varma-el.com>
References: <4378960F.8030800@varma-el.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Volkov <avolkov@varma-el.com> wrote:
>
> ...
> Added support of ST M41T85 RTC
> 
> ...
>
> +ulong
> +m41t85_get_rtc_time(void)

Does this need to have global scope?

It appears to have no callers.

It is preferred that `unsigned long' be used.

Please format it this way:

unsigned long m41t85_get_rtc_time(void)


> +static void
> +m41t85_set_tlet(ulong arg)
> +{
> +	struct rtc_time	tm;
> +	ulong	nowtime = *(ulong *)arg;
> +
> +	to_tm(nowtime, &tm);
> +	tm.tm_year = (tm.tm_year - 1900) % 100;
> +
> +	tm.tm_sec = BIN2BCD(tm.tm_sec);
> +	tm.tm_min = BIN2BCD(tm.tm_min);
> +	tm.tm_hour = BIN2BCD(tm.tm_hour);
> +	tm.tm_mon = BIN2BCD(tm.tm_mon);
> +	tm.tm_mday = BIN2BCD(tm.tm_mday);
> +	tm.tm_year = BIN2BCD(tm.tm_year);
> +
> +	down(&m41t85_mutex);

Cannot do down() in a tasklet handler!  Enable CONFIG_DEBUG_PREEMPT and
CONFIG_DEBUG_SPINLOCK_SLEEP, retest.

schedule_work() might be an appropriate fix.

> +int
> +m41t85_set_rtc_time(ulong nowtime)
> +{
> +	new_time = nowtime;
> +
> +	if (in_interrupt())
> +		tasklet_schedule(&m41t85_tasklet);
> +	else
> +		m41t85_set_tlet((ulong)&new_time);
> +
> +	return 0;
> +}

hm, this function isn't referenced from within this patch either.

> +	#if defined (CONFIG_SENSORS_M41T85_SQW_FRQ)

#if's normally start in column zero.

> +		ret = i2c_smbus_write_byte_data(client, RTC_SQW_ADDR, CONFIG_SENSORS_M41T85_SQW_FRQ);

My, what large xterms you have ;)


