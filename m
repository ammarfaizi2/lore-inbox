Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWCPBQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWCPBQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWCPBQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:16:55 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47284 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751931AbWCPBQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:16:55 -0500
Date: Thu, 16 Mar 2006 02:16:51 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: + posix-timer-cleanup-common_timer_get.patch added to -mm tree
In-Reply-To: <1142422432.19916.714.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603160205520.16802@scrub.home>
References: <200603121139.k2CBdTAx001302@shell0.pdx.osdl.net>
 <1142422432.19916.714.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 15 Mar 2006, Thomas Gleixner wrote:

> -	if (timr->it.real.interval.tv64 == 0) {
> +	if (iv.tv64)

Just for the record: this wasn't my bug... :)

> +	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING ||
> +	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
> +		timr->it_overrun += hrtimer_forward(timer, now, iv);

The iv.tv64 test is only needed for the SIGEV_NONE case, so one could also 
move it to the end:

	if ((timr->it_requeue_pending & REQUEUE_PENDING) ||
	    ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE && iv.tv64))

OTOH since it_requeue_pending is unused for SIGEV_NONE, we could as well 
initialize it during timer_set:

	if (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)
		timr->it_requeue_pending == interval.tv64 ? REQUEUE_PENDING : 0;

and make the test even simpler.

> +	if (remaining.tv64 <= 0) {
> +		/*
> +		 * A single shot SIGEV_NONE timer must return 0, when
> +		 * it is expired !
> +		 */
> +		if ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)
> +			cur_setting->it_value.tv_nsec = 1;

It's maybe practically not relevant, but theoretically a (iv.tv64) would 
be more correct and then we could also move it up to the initial (iv.tv64) 
test and leave the (remaining.tv64 > 0) case here.

bye, Roman
