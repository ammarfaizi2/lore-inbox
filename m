Return-Path: <linux-kernel-owner+w=401wt.eu-S964977AbWLMN6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWLMN6p (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWLMN6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:58:45 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:39801 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964977AbWLMN6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:58:44 -0500
Date: Wed, 13 Dec 2006 14:47:52 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] HZ free ntp
In-Reply-To: <1165956021.20229.10.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612131338420.1867@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org> 
 <Pine.LNX.4.64.0612060348150.1868@scrub.home>  <20061205203013.7073cb38.akpm@osdl.org>
  <1165393929.24604.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0612061334230.1867@scrub.home>  <20061206131155.GA8558@elte.hu>
  <Pine.LNX.4.64.0612061422190.1867@scrub.home> <1165956021.20229.10.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, john stultz wrote:

> Basically INTERVAL_LENGTH_NSEC defines the NTP interval length that the
> time code will use to accumulate with. In this patch I've pushed it out
> to a full second, but it could be set via config (NSEC_PER_SEC/HZ for
> regular systems, something larger for systems using dynticks).

Why do you want to use such an interval? This makes everything only more 
complicated.
The largest possible interval is freq cycles (or 1 second without 
adjustments). That is the base interval and without redesigning NTP we 
can't change that. This base interval can be subdivided into smaller
intervals for incremental updates.
You cannot choose arbitrary intervals otherwise you get other problems, 
e.g. with your patch time_offset handling is broken.

> +	/* calculate the length of one NTP adjusted second */
> +	second_length = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ);
> +	second_length += (s64)CLOCK_TICK_ADJUST;
> +	adj_length = (s64)time_freq;
> +
> +	/* calculate tick length @ HZ*/
> +	tick_length = (second_length << TICK_LENGTH_SHIFT)
> +			+ (adj_length << (TICK_LENGTH_SHIFT - SHIFT_NSEC));
> +	do_div(tick_length, HZ);
> +	tick_nsec = tick_length >> TICK_LENGTH_SHIFT;
> +
> +
> +	/* calculate interval_length_base */
> +	/* XXX - this is broken up to avoid 64bit overlfows */
> +	interval_length_base = second_length * INTERVAL_LENGTH_NSEC;
> +	interval_length_base <<= 2;
> +	do_div(interval_length_base, NSEC_PER_SEC);
> +	interval_length_base <<= TICK_LENGTH_SHIFT-2;

You don't have to introduce anything new, it's tick_length that changes 
and HZ that becomes a variable in this function.

bye, Roman
