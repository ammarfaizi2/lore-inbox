Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTJVXyB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 19:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTJVXyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 19:54:01 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:65497 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261245AbTJVXx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 19:53:59 -0400
Subject: Re: [pm] fix time after suspend-to-*
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031022233306.GA6461@elf.ucw.cz>
References: <20031022233306.GA6461@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1066866741.1114.71.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Oct 2003 16:52:21 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-22 at 16:33, Pavel Machek wrote:
> Hi!
> 
> This adds suspend/resume methods for time, so that real time is
> refreshed from cmos when suspend is finished. Please apply,
> 

[snip]

>  
> +static long clock_cmos_diff;
> +static int got_clock_diff;
> +
> +static int pit_suspend(struct sys_device *dev, u32 state)
> +{
> +	/*
> +	 * Estimate time zone so that set_time can update the clock
> +	 */
> +	clock_cmos_diff = -get_cmos_time();
> +	clock_cmos_diff += get_seconds();
> +	got_clock_diff = 1;
> +	return 0;
> +}
> +
> +static int pit_resume(struct sys_device *dev)
> +{
> +	if (got_clock_diff) {	/* Must know time zone in order to set clock */
> +		xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
> +		xtime.tv_nsec = 0; 
> +	} 
> +	return 0;
> +}
> +
>  static struct sysdev_class pit_sysclass = {
>  	set_kset_name("pit"),
> +	.resume = pit_resume,
> +	.suspend = pit_suspend,
>  };

Forgive me, I'm not totally familiar w/ the sysfs/pm stuff, but normally
you need to have the xtime_lock to safely manipulate xtime. Also,
couldn't you just call settimeofday() instead?  The bit about manually
setting the timezone also confuses me, as we don't normally do this at
bootup in the kernel.  

thanks
-john


