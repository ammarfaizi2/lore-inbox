Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVAXX3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVAXX3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVAXX22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:28:28 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63194 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261739AbVAXX0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:26:08 -0500
Date: Mon, 24 Jan 2005 15:24:50 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
In-Reply-To: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0501241513470.17986@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, john stultz wrote:

> +/* __monotonic_clock():
> + *		private function, must hold system_time_lock lock when being
> + *		called. Returns the monotonically increasing number of
> + *		nanoseconds	since the system booted (adjusted by NTP scaling)
> + */
> +static nsec_t __monotonic_clock(void)
> +{
> +	nsec_t ret, ns_offset;
> +	cycle_t now, delta;
> +
> +	/* read timesource */
> +	now = read_timesource(timesource);
> +
> +	/* calculate the delta since the last clock_interrupt */
> +	delta = (now - offset_base) & timesource->mask;
> +
> +	/* convert to nanoseconds */
> +	ns_offset = cyc2ns(timesource, delta, NULL);
> +
> +	/* apply the NTP scaling */
> +	ns_offset = ntp_scale(ns_offset);

The monotonic clock is the time base for the gettime and gettimeofday
functions. This means ntp_scale() is called every time that the kernel or
an application access time.

As pointed out before this will dramatically worsen the performance
compared to the current code base.

ntp_scale() also will make it difficult to implement optimized arch
specific version of function for timer access.

The fastcalls would have to be disabled on ia64 to make this work. Its
likely extremely difficult to implement a fastcall if it involves
ntp_scale().

