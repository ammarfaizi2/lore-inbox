Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVCOANa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVCOANa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVCOAMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:12:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43725 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262144AbVCOAIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:08:49 -0500
Date: Mon, 14 Mar 2005 16:07:31 -0800 (PST)
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
Message-ID: <Pine.LNX.4.58.0503141602460.15032@schroedinger.engr.sgi.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Mar 2005, john stultz wrote:

> +/* get_lowres_timestamp():
> + *	Returns a low res timestamp.
> + *	(ie: the value of system_time as  calculated at
> + *	the last invocation of timeofday_periodic_hook() )
> + */
> +nsec_t get_lowres_timestamp(void)
> +{
> +	nsec_t ret;
> +	unsigned long seq;
> +	do {
> +		seq = read_seqbegin(&system_time_lock);
> +
> +		/* quickly grab system_time*/
> +		ret = system_time;
> +
> +	} while (read_seqretry(&system_time_lock, seq));
> +
> +	return ret;
> +}

On 64 bit platforms this could simply be a macro accessing "system time".

> +/* do_gettimeofday():
> + *	Returns the time of day
> + */
> +void do_gettimeofday(struct timeval *tv)
> +{
> +	nsec_t wall, sys;
> +	unsigned long seq;
> +
> +	/* atomically read wall and sys time */
> +	do {
> +		seq = read_seqbegin(&system_time_lock);
> +
> +		wall = wall_time_offset;
> +		sys = __monotonic_clock();
> +
> +	} while (read_seqretry(&system_time_lock, seq));
> +
> +	/* add them and convert to timeval */
> +	*tv = ns2timeval(wall+sys);
> +}
> +EXPORT_SYMBOL(do_gettimeofday);

Good.

