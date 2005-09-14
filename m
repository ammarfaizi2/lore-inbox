Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVINSOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVINSOA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbVINSOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:14:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32487 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932554AbVINSN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:13:59 -0400
Date: Wed, 14 Sep 2005 20:13:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, yoshfuji@linux-ipv6.org,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       George Anzinger <george@mvista.com>, joe-lkml@rameria.de
Subject: Re: [RFC][PATCH] NTP shift_right cleanup (v. A1)
In-Reply-To: <1126720091.3455.56.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0509142010030.3728@scrub.home>
References: <1126720091.3455.56.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 14 Sep 2005, john stultz wrote:

> +/* Required to safely shift negative values */
> +#define shift_right(x, s) ({	\
> +	__typeof__(x) __x = x;	\
> +	__typeof__(s) __s = s;	\
> +	(__x < 0) ? (-((-__x) >> (__s))) : ((__x) >> (__s));	\
> +})

Still too much/little parenthesis.

> @@ -792,13 +769,8 @@ static void update_wall_time_one_tick(vo
>  	 * advance the tick more.
>  	 */
>  	time_phase += time_adj;
> -	if (time_phase <= -FINENSEC) {
> -		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
> -		time_phase += ltemp << (SHIFT_SCALE - 10);
> -		delta_nsec -= ltemp;
> -	}
> -	else if (time_phase >= FINENSEC) {
> -		long ltemp = time_phase >> (SHIFT_SCALE - 10);
> +	if (abs(time_phase) >= FINENSEC) {
> +		long ltemp = shift_right(time_phase, (SHIFT_SCALE - 10));
>  		time_phase -= ltemp << (SHIFT_SCALE - 10);
>  		delta_nsec += ltemp;
>  	}

I checked and this actually generates worse code.

bye, Roman
