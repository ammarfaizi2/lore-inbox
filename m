Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbVG2XgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbVG2XgM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 19:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVG2XeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:34:04 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:49602 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262929AbVG2XcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 19:32:00 -0400
Date: Fri, 29 Jul 2005 16:31:51 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: tony.luck@intel.com
cc: linux-kernel@vger.kernel.org, alex.williamson@hp.com
Subject: Re: long delays (possibly infinite) in time_interpolator_get_counter
In-Reply-To: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0507291625390.19428@schroedinger.engr.sgi.com>
References: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What you are dealing with is a machine that is using ITC as a time bases. 
That is a special case. The fix should not affect machines that have a 
proper time source. More below. You can circumvent the compensation for 
ITC inaccuracies by specifying "nojitter" on the kernel command if you are 
willing to take the risk of slightly inaccurate time.

On Fri, 29 Jul 2005 tony.luck@intel.com wrote:
> The patch below makes things less bad by not letting Y & Z do the cmpxchg if
> they are going to fail the read_seqretry() test anyway.  But it is very ugly
> to do this extra test on xtime_lock ... so I'm hoping that someone can come
> up with something better.

Well get a proper time source and do not use ITC for a time source in an 
SMP system. Got HPET hardware?

> -extern unsigned long time_interpolator_get_offset(void);
> +extern unsigned long time_interpolator_get_offset(long);

This is going to cause unnecessary overhead for non ITC users.

> -		nsec = xtime.tv_nsec+time_interpolator_get_offset();
> +		nsec = xtime.tv_nsec+time_interpolator_get_offset(seq);

Here it is.

> -		offset = time_interpolator_get_offset();
> +		offset = time_interpolator_get_offset(seq);

and here again.

> +			/*
> +			 * If our caller is going to ignore us and retry, then
> +			 * don't burn up the bus with the cmpxchg
> +			 */
> +			if (seq && unlikely(read_seqretry(&xtime_lock, seq)))
> +				return now;

Two read_seqretries() for one  read_seqbegin()? That its unusual to say 
the least.

