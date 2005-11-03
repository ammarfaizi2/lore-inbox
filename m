Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVKCDwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVKCDwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbVKCDwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:52:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50831 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030331AbVKCDwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:52:30 -0500
Date: Thu, 3 Nov 2005 13:52:10 +1100
From: Andrew Morton <akpm@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       NooneImportant <nxhxzi702@sneakemail.com>
Subject: Re: [PATCH 18/37] dvb: let other frontends support
 FE_DISHNETWORK_SEND_LEGACY_CMD
Message-Id: <20051103135210.21cdcf77.akpm@osdl.org>
In-Reply-To: <436723DB.2000300@m1k.net>
References: <436723DB.2000300@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> +s32 timeval_usec_diff(struct timeval lasttime, struct timeval curtime)
>  +{
>  +	return ((curtime.tv_usec < lasttime.tv_usec) ?
>  +		1000000 - lasttime.tv_usec + curtime.tv_usec :
>  +		curtime.tv_usec - lasttime.tv_usec);
>  +}
>  +EXPORT_SYMBOL(timeval_usec_diff);
>  +
>  +static inline void timeval_usec_add(struct timeval *curtime, u32 add_usec)
>  +{
>  +	curtime->tv_usec += add_usec;
>  +	if (curtime->tv_usec >= 1000000) {
>  +		curtime->tv_usec -= 1000000;
>  +		curtime->tv_sec++;
>  +	}
>  +}

timeval arithmetic like this really shouldn't be hidden in a dvb driver -
it's generic code.

>  +/*
>  + * Sleep until gettimeofday() > waketime + add_usec
>  + * This needs to be as precise as possible, but as the delay is
>  + * usually between 2ms and 32ms, it is done using a scheduled msleep
>  + * followed by usleep (normally a busy-wait loop) for the remainder
>  + */
>  +void dvb_frontend_sleep_until(struct timeval *waketime, u32 add_usec)
>  +{
>  +	struct timeval lasttime;
>  +	s32 delta, newdelta;
>  +
>  +	timeval_usec_add(waketime, add_usec);
>  +
>  +	do_gettimeofday(&lasttime);
>  +	delta = timeval_usec_diff(lasttime, *waketime);
>  +	if (delta > 2500) {
>  +		msleep((delta - 1500) / 1000);
>  +		do_gettimeofday(&lasttime);
>  +		newdelta = timeval_usec_diff(lasttime, *waketime);
>  +		delta = (newdelta > delta) ? 0 : newdelta;
>  +	}
>  +	if (delta > 0)
>  +		udelay(delta);
>  +}
>  +EXPORT_SYMBOL(dvb_frontend_sleep_until);

However I don't believe that the driver should be using timevals and
do_gettimeofday() at all.  Why not use jiffies-based timing like so
many other parts of the kernel?
