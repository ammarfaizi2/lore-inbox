Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWBVWOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWBVWOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWBVWOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:14:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751527AbWBVWOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:14:08 -0500
Date: Wed, 22 Feb 2006 14:15:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] RTC subsystem, class
Message-Id: <20060222141554.0f5e2aa3.akpm@osdl.org>
In-Reply-To: <20060219232211.628944000@towertech.it>
References: <20060219232211.368740000@towertech.it>
	<20060219232211.628944000@towertech.it>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Zummo <a.zummo@towertech.it> wrote:
>
> This patch adds the basic RTC subsytem infrastructure
> to the kernel.
> 
> rtc/class.c - registration facilities for RTC drivers
> rtc/interface.c - kernel/rtc interface functions 
> rtc/utils.c - misc rtc-related utility functions
> rtc/hctosys.c - snippet of code that copies hw clock to sw clock
> 		at bootup, if configured to do so.

Couple of questions.

a) Is all this code 100% compatible with existing kernel interfaces?  No
   userspace-visible breakage?  Right down the all the same -EFOO return
   codes for all the same errors?

b) Will the kernel compile and run at each stage of your patch series? 
   I hit a nasty no-compile half an hour through a git-bisect session
   yesterday and it's still smarting.

Code looks nice and clean.

> +	if (idr_pre_get(&rtc_idr, GFP_KERNEL) == 0) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +
> +	mutex_lock(&idr_lock);
> +	err = idr_get_new(&rtc_idr, NULL, &id);
> +	mutex_unlock(&idr_lock);

Oh the IDR API does suck.  Not your fault though.

> +	if ((rtc = kzalloc(sizeof(struct rtc_device), GFP_KERNEL)) == NULL) {

You do a lot of

	if ((lhs = rhs) == something)

But preferred kernel style is

	lhs = rhs;
	if (lhs == something)

Generally, kernel style is to keep things as utterly simple as they can be.

+config RTC_CLASS
> +	tristate "RTC class"
> +	depends on EXPERIMENTAL
> +	default y
> +	help
> +	  Generic RTC class support. If you say yes here, you will
> + 	  be allowed to plug one or more RTCs to your system. You will
> +	  probably want to enable one of more of the interfaces below.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-class.
> +
> +config RTC_HCTOSYS
> +	bool "Set system time from RTC on startup"
> +	depends on RTC_CLASS = y
> +	default y
> +	help
> +	  If you say yes here, the system time will be set using
> +	  the value read from the specified RTC device. This is useful
> +	  in order to avoid unnecessary fschk runs.
> +
> +config RTC_HCTOSYS_DEVICE
> +	string "The RTC to read the time from"
> +	depends on RTC_HCTOSYS = y
> +	default "rtc0"
> +	help
> +	  The RTC device that will be used as the source for
> +	  the system time, usually rtc0.

hm.  Doesn't the above disable RTC_HCTOSYS and RTC_HCTOSYS_DEVICE if
RTC_CLASS=m?

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-rtc/drivers/rtc/interface.c	2006-02-15 04:13:37.000000000 +0100
> @@ -0,0 +1,274 @@
> +/*
> + * RTC subsystem, interface functions
> + *
> + * Copyright (C) 2005 Tower Technologies
> + * Author: Alessandro Zummo <a.zummo@towertech.it>
> + *
> + * based on arch/arm/common/rtctime.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> +*/
> +
> +#include <linux/rtc.h>
> +
> +extern struct class *rtc_class;

Please always put extern declarations in a header file.

> +}
> +EXPORT_SYMBOL(rtc_set_alarm);
> +
> +void rtc_update_irq(struct class_device *class_dev,
> +		unsigned long num, unsigned long events)
> +{
> +	struct rtc_device *rtc = to_rtc_device(class_dev);
> +
> +	spin_lock(&rtc->irq_lock);
> +	rtc->irq_data = (rtc->irq_data + (num << 8)) | events;
> +	spin_unlock(&rtc->irq_lock);
> +
> +	spin_lock(&rtc->irq_task_lock);
> +	if (rtc->irq_task)
> +		rtc->irq_task->func(rtc->irq_task->private_data);
> +	spin_unlock(&rtc->irq_task_lock);
> +
> +	wake_up_interruptible(&rtc->irq_queue);
> +	kill_fasync(&rtc->async_queue, SIGIO, POLL_IN);
> +}
> +EXPORT_SYMBOL(rtc_update_irq);

I don't know what this does.

Please document all non-static functions.  Preferably with kernel-doc
format.  Feel free to document static functions too..

> +int rtc_irq_set_freq(struct class_device *class_dev, struct rtc_task *task, int freq)
> +{
> +	int err = 0, tmp = 0;
> +	unsigned long flags;
> +	struct rtc_device *rtc = to_rtc_device(class_dev);
> +
> +	/* allowed range is 2-8192 */
> +	if (freq < 2 || freq > 8192)
> +		return -EINVAL;
> +
> +/*	if ((freq > rtc_max_user_freq) && (!capable(CAP_SYS_RESOURCE)))
> +		return -EACCES;
> +*/

What happened to rtc_max_user_freq?

