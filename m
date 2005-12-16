Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVLPM3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVLPM3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVLPM3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:29:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:59300 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932229AbVLPM3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:29:07 -0500
Date: Fri, 16 Dec 2005 06:28:54 -0600
From: Robin Holt <holt@sgi.com>
To: hawkes@sgi.com
Cc: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Keith Owens <kaos@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH] ia64: disable preemption in udelay()
Message-ID: <20051216122854.GA10375@lnx-holt.americas.sgi.com>
References: <20051216024252.27639.63120.sendpatchset@tomahawk.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216024252.27639.63120.sendpatchset@tomahawk.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 06:42:52PM -0800, hawkes@sgi.com wrote:
> +
> +#define SMALLUSECS 100

John, I did not see your posts until this had already made it out.
I would think that the folks running realtime applications would expect
udelay to hold off for even shorter periods of time.  I would expect
something along the line of 20 or 25 uSec.

> +
> +void
> +udelay (unsigned long usecs)
> +{
> +	unsigned long start;
> +	unsigned long cycles;
> +	unsigned long smallusecs;
> +
> +	/*
> +	 * Execute the non-preemptible delay loop (because the ITC might
> +	 * not be synchronized between CPUS) in relatively short time
> +	 * chunks, allowing preemption between the chunks.
> +	 */
> +	while (usecs > 0) {
> +		smallusecs = (usecs > SMALLUSECS) ? SMALLUSECS : usecs;
> +		preempt_disable();
> +		cycles = smallusecs*local_cpu_data->cyc_per_usec;
> +		start = ia64_get_itc();
> +
> +		while (ia64_get_itc() - start < cycles)
> +			cpu_relax();
> +
> +		preempt_enable();
> +		usecs -= smallusecs;
> +	}
> +}

How much drift would you expect from this?  I have not tried this, but
what about something more along the lines of:

#define MAX_USECS_WHILE_NOT_PREMPTIBLE	20

void
udelay (unsigned long usecs)
{
	unsigned long next, timeout;
	long last_processor = -1;


	/*
	 * Execute the non-preemptible delay loop (because the ITC might
	 * not be synchronized between CPUS) in relatively short time
	 * chunks, allowing preemption between the chunks.
	 */
	while (usecs > 0) {
		next = min(usecs, MAX_USECS_WHILE_NOT_PREMPTIBLE);
		preempt_disable;
		if (last_processor != smp_processor_id()) {
			last_processor = smp_processor_id();
			timeout = ia64_get_itc();
		}
		timeout += next * local_cpu_data->cyc_per_usec;
		while (ia64_get_itc() < timeout)
			cpu_relax();

		preempt_enable;
		usecs -= next;
	}
}

