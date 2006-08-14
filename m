Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWHNT6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWHNT6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWHNT6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:58:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:32955 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751681AbWHNT6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:58:51 -0400
Subject: Re: [RFC][PATCH -mm 1/2] i386: Detect clock skew during suspend
From: john stultz <johnstul@us.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200608132306.02079.rjw@sisk.pl>
References: <200608132303.00012.rjw@sisk.pl>
	 <200608132306.02079.rjw@sisk.pl>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 12:58:47 -0700
Message-Id: <1155585527.5413.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-13 at 23:06 +0200, Rafael J. Wysocki wrote:
> Detect the situations in which the time after a resume from disk would
> be earlier than the time before the suspend and prevent them from
> happening on i386.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

One minor comment, but otherwise looks good.
 
> @@ -302,16 +305,25 @@ static int timer_resume(struct sys_devic
>  {
>  	unsigned long flags;
>  	unsigned long sec;
> -	unsigned long sleep_length;
> +	unsigned long ctime = get_cmos_time();
> +	long sleep_length = (ctime - sleep_start) * HZ;
>  	struct timespec ts;
> +
> +	if (sleep_length < 0) {
> +		printk(KERN_WARNING "Time skew detected in timer resume!\n");

Please make sure the warning describes the CMOS clock going backwards,
rather then just the vague "time skew detected" comment.

> +		/* The time after the resume must not be earlier than the time

s/time/CMOS clock/



Acked-by: John Stultz <johnstul@us.ibm.com>

thanks
-john

