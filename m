Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbULHSxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbULHSxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbULHSxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:53:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:52881 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261304AbULHSxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:53:15 -0500
Date: Wed, 8 Dec 2004 10:53:13 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] new timeofday core subsystem (v.A1)
In-Reply-To: <1102470997.1281.30.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0412081049570.27324@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
 <1102470997.1281.30.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004, john stultz wrote:

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
> +	ns_offset = cyc2ns(timesource, delta,0);
> +
> +	/* apply the NTP scaling */
> +	ns_offset = ntp_scale(ns_offset);

The call to ntp_scale will significantly impact clock retrieval
performance. ntp_scale needs to be removed. Could you simply let the clock
run with a scaling factor (just make sure the scaling factor is a bit
slower than ntp time and then skip a few nanoseconds of time forward
at the next correction?)
