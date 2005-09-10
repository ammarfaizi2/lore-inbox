Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbVIJBkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbVIJBkS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 21:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbVIJBkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 21:40:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:55749 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030427AbVIJBkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 21:40:16 -0400
Date: Sat, 10 Sep 2005 03:39:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, ioe-lkml@rameria.de,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC][PATCH] NTP shiftR cleanup
In-Reply-To: <1126314217.3455.10.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0509100329270.3743@scrub.home>
References: <1126314217.3455.10.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 9 Sep 2005, john stultz wrote:

> +/* Required to safely shift negative values */
> +#define shiftR(x, s) ({ __typeof__(x) __x = x;\
> +		__typeof__(s) __s = s; \
> +		(__x < 0) ? (-((-__x) >> (__s))) : ((__x) >> (__s));})
> +

Some parenthesis are missing and some are redundant. Formatting it so it 
looks more like normal function makes it more readable:

#define shiftR(x, s) ({				\
	__typeof__(x) __x = (x);		\
	__typeof__(s) __s = (s);		\
	__x < 0 ? -(-__x >> __s) : __x >> __s;	\
})

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
> +		long ltemp = shiftR(time_phase, (SHIFT_SCALE - 10));
>  		time_phase -= ltemp << (SHIFT_SCALE - 10);
>  		delta_nsec += ltemp;
>  	}

It would be interesting to check, whether gcc produces the same code here.

bye, Roman
