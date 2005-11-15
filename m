Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVKOVYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVKOVYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVKOVYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:24:22 -0500
Received: from [195.144.244.147] ([195.144.244.147]:28133 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S1750790AbVKOVYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:24:22 -0500
Message-ID: <437A5202.2080807@varma-el.com>
Date: Wed, 16 Nov 2005 00:24:18 +0300
From: Andrey Volkov <avolkov@varma-el.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
References: <4378960F.8030800@varma-el.com> <20051114164118.7270c6ce.akpm@osdl.org>
In-Reply-To: <20051114164118.7270c6ce.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andrey Volkov <avolkov@varma-el.com> wrote:
> 
>>...
>>Added support of ST M41T85 RTC
>>
>>...
>>
>>+ulong
>>+m41t85_get_rtc_time(void)
> 
> 
> Does this need to have global scope?
> 
> It appears to have no callers.

I use this function(s) in platform driver (which still in dev stage) of
our board as platform get_rtc_time/set_rtc_time by same way as Mark in
the katana does.

May be better create special header in include/linux?
(And convert m41t80.c and arch/ppc/katana.c too)

>>+static void
>>+m41t85_set_tlet(ulong arg)
>>+{
>>+	struct rtc_time	tm;
>>+	ulong	nowtime = *(ulong *)arg;
>>+
>>+	to_tm(nowtime, &tm);
>>+	tm.tm_year = (tm.tm_year - 1900) % 100;
>>+
>>+	tm.tm_sec = BIN2BCD(tm.tm_sec);
>>+	tm.tm_min = BIN2BCD(tm.tm_min);
>>+	tm.tm_hour = BIN2BCD(tm.tm_hour);
>>+	tm.tm_mon = BIN2BCD(tm.tm_mon);
>>+	tm.tm_mday = BIN2BCD(tm.tm_mday);
>>+	tm.tm_year = BIN2BCD(tm.tm_year);
>>+
>>+	down(&m41t85_mutex);
> 
> 
> Cannot do down() in a tasklet handler!  Enable CONFIG_DEBUG_PREEMPT and
> CONFIG_DEBUG_SPINLOCK_SLEEP, retest.

Oops, you're right. It's copy-paste bug from m41t00.c
(which then buggy too).

> 
> schedule_work() might be an appropriate fix.
> 
> 
>>+int
>>+m41t85_set_rtc_time(ulong nowtime)
>>+{
>>+	new_time = nowtime;
>>+
>>+	if (in_interrupt())
>>+		tasklet_schedule(&m41t85_tasklet);
>>+	else
>>+		m41t85_set_tlet((ulong)&new_time);
>>+
>>+	return 0;
>>+}
> 
> 
> hm, this function isn't referenced from within this patch either.

Same as above.

> 
> 
>>+	#if defined (CONFIG_SENSORS_M41T85_SQW_FRQ)
> 
> 
> #if's normally start in column zero.
> 
> 
>>+		ret = i2c_smbus_write_byte_data(client, RTC_SQW_ADDR, CONFIG_SENSORS_M41T85_SQW_FRQ);
> 
> 
> My, what large xterms you have ;)

Tabs=4 and 1280 full screened :). Ok I fix it to 80 columns.

--
Regards
Andrey Volkov

