Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161273AbWHDQBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161273AbWHDQBt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWHDQBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:01:49 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:40430 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1161273AbWHDQBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:01:48 -0400
Date: Sat, 05 Aug 2006 01:03:20 +0900 (JST)
Message-Id: <20060805.010320.108306918.anemo@mba.ocn.ne.jp>
To: ab@mycable.de
Cc: mgreer@mvista.com, linux-kernel@vger.kernel.org, a.zummo@towertech.it,
       khali@linux-fr.org, akpm@osdl.org
Subject: Re: RTC: add RTC class interface to m41t00 driver
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200608041601.03218.ab@mycable.de>
References: <20060804.004259.48803564.anemo@mba.ocn.ne.jp>
	<20060804002112.GB9109@mag.az.mvista.com>
	<200608041601.03218.ab@mycable.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 16:01:02 +0200, Alexander Bigga <ab@mycable.de> wrote:
> like you, I started recently with Mark's m41t00.c driver to add support for 
> the new rtc-subsystem. Mark reviewed it and I added his changes.

Thank you.  Though my patch for m41t00.c intended to keep original
code as is as possible, I like your approach.  I'll work with your new
driver.

> There is still the question, if the code for the interrupt context 
> (workqueues) should stay or not. You bracketed all this with CONFIG_GEN_RTC. 
> I can't say, if this is a good idea. Maybe somebody else has some good 
> comments.

I think read_time and set_time routine of rtc_class never called from
the interrupt context.  It looks true on current RTC class framework
and some RTC class drivers depend on it already.

> +#include <asm/time.h>
> +#include <asm/rtc.h>

The asm/time.h is not exist on some archs.  And while all asm/time.h
are included by asm/rtc.h, this can be removed safely.

> +int m41txx_set_datetime(struct i2c_client *client, struct rtc_time *tm)

static.

> +ulong m41t00_get_rtc_time(void)
> +{
> +	struct rtc_time tm;
> +
> +	m41txx_get_datetime(save_client, &tm);
> +
> +	return mktime(tm.tm_year, tm.tm_mon,
> +		      tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
> +}
> +EXPORT_SYMBOL_GPL(m41t00_get_rtc_time);

Please drop this old interface from new driver.  There are other way
to glue new driver to existing platform, as hctosys.c does.

Then we can remove save_client too.

> +static struct workqueue_struct *m41txx_wq;

As I wrote above, I think this is not needed.  If this is really
needed, it should be done in RTC framework instead of lowlevel driver.

> +st_err:
> +	dev_err(&client->dev, "%s: Can't clear ST bit\n", __FUNCTION__);
> +	goto exit_detach;
> +ht_err:
> +	dev_err(&client->dev, "%s: Can't clear HT bit\n", __FUNCTION__);
> +	goto exit_detach;
> +sqw_err:
> +	dev_err(&client->dev, "%s: Can't set SQW Frequency\n",
> +		__FUNCTION__);
> +
> +exit_detach:
> +	i2c_detach_client(client);

rtc_device_unregister() must be called somewhere in error path.

---
Atsushi Nemoto
