Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVCOGL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVCOGL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVCOGL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:11:27 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:3764 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262275AbVCOGLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:11:01 -0500
Date: Mon, 14 Mar 2005 22:09:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
In-Reply-To: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0503142202510.16889@schroedinger.engr.sgi.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, john stultz wrote:

> +/* cyc2ns():
> + *		Uses the timesource and ntp ajdustment interval to
> + *		convert cycle_ts to nanoseconds.
> + *		If rem is not null, it stores the remainder of the
> + *		calculation there.
> + *
> + */

This function is called in critical paths and it would be very important
to optimize it further.

> +static inline nsec_t cyc2ns(struct timesource_t* ts, int ntp_adj, cycle_t cycles, cycle_t* rem)
> +{
> +	u64 ret;
> +	ret = (u64)cycles;
> +	ret *= (ts->mult + ntp_adj);

This only changes when nt_adj changes. Maybe maintain the sum separately?

> +	if (unlikely(rem)) {
> +		/* XXX clean this up later!
> +		 *		buf for now relax, we only calc
> +		 *		remainders at interrupt time
> +		 */
> +		u64 remainder = ret & ((1 << ts->shift) -1);
> +		do_div(remainder, ts->mult);
> +		*rem = remainder;

IA64 does not do remainder processing (maybe I just do not understand
this...) but this seems to be not necessay if one uses 64 bit values that
are properly shifted?

> +	}
> +	ret >>= ts->shift;
> +	return (nsec_t)ret;
> +}

The whole function could simply be:

#define cyc2ns(cycles, ts) (cycles*ts->current_factor) >> ts->shift
