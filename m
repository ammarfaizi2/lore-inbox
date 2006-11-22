Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966995AbWKVBT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966995AbWKVBT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966994AbWKVBTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:19:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966995AbWKVBTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:19:25 -0500
Date: Tue, 21 Nov 2006 17:19:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.19-rc6 6/6] rtc-omap driver
Message-Id: <20061121171906.5eec32d6.akpm@osdl.org>
In-Reply-To: <200611201028.48701.david-b@pacbell.net>
References: <200611201014.41980.david-b@pacbell.net>
	<200611201028.48701.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 10:28:48 -0800
David Brownell <david-b@pacbell.net> wrote:

> This creates a new RTC-framework driver for the RTC/calendar module found
> in various OMAP1 chips.  (OMAP2 and OMAP3 use external RTCs, like those in
> TI's multifunction PM companion chips.)  It's been in the Linux-OMAP tree
> for several months now, and other trees before that, so it's quite stable.
> The most notable issue is that the OMAP IRQ code doesn't yet support the
> RTC IRQ as a wakeup event.  Once that's fixed, a patch will be needed.
> 
> ...
>
> +static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> +	u8 reg;
> +
> +	/* Much userspace code uses RTC_ALM_SET, thus "don't care" for
> +	 * day/month/year specifies alarms up to 24 hours in the future.
> +	 * So we need to handle that ... but let's ignore the "don't care"
> +	 * values for hours/minutes/seconds.
> +	 */
> +	if (alm->time.tm_mday <= 0
> +			&& alm->time.tm_mon < 0
> +			&& alm->time.tm_year < 0) {
> +		struct rtc_time tm;
> +		unsigned long now, then;
> +
> +		omap_rtc_read_time(dev, &tm);
> +		rtc_tm_to_time(&tm, &now);
> +
> +		alm->time.tm_mday = tm.tm_mday;
> +		alm->time.tm_mon = tm.tm_mon;
> +		alm->time.tm_year = tm.tm_year;
> +		rtc_tm_to_time(&alm->time, &then);
> +
> +		/* sometimes the alarm wraps into tomorrow */
> +		if (then < now) {

This isn't wraparound-safe.  If you have then=0xffffffff and now=0x00000001.

Perhaps that can't happen.

> +MODULE_AUTHOR("George G. Davis (and others)");

Maybe some additional signoffs would be appropirate?
