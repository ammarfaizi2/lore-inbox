Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWF1Wpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWF1Wpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWF1Wpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:45:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751629AbWF1Wpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:45:52 -0400
Date: Wed, 28 Jun 2006 15:49:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ZVC: Increase threshold for larger processor configurationss
Message-Id: <20060628154911.6e035153.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606281038530.22262@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606281038530.22262@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> We detecteded a slight degree of contention with the new zoned VM counters 
> if over 128 processors simultaneously fault anonymous pages. Raising the 
> threshold to 64 fixed the contention issue.
> 
> So we need to increase the threshhold depending on the number of processors
> in the system. And it may be best to overcompensate a bit.
> 
> We keep the existing threshold of 32 for configurations with less than or
> equal to 64 processors. In the range of 64 to 128 processors we go to a
> threshold of 64. Beyond that we go to 125 (we have to be able to increment
> one beyond the threshold and then better avoid 127 just in case).
> 
> (There are a more scalability improvement possible by utilizing the 
> cacheline when it has been acquired to update all pending counters but I 
> want to first test with a few hundred processors to see if we need those 
> and then we need to figure out if there are bad effects for smaller 
> configurations.)
> 
> ...
>  
> +/*
> + * With higher processor counts we need higher threshold to avoid contention.
> + */
> +#if NR_CPUS <= 64
>  #define STAT_THRESHOLD 32
> +#elif NR_CPUS <= 128
> +#define STAT_THRESHOLD 64
> +#else
> +/*
> + * Use the maximum usable threshhold.
> + * We need to increment one beyond the threshold. To be safe
> + * also avoid 127.
> + */
> +#define STAT_THRESHOLD 125
> +#endif

As we become less and less dependent upon NR_CPUS, it becomes more and more
viable for people to ship kernels which are compiled with a very high
NR_CPUS value.  And code such as the above becomes less and less effective.

An alternative would be to calculate stat_threshold at runtime, based on
the cpu_possible count (I guess).  Or even:

static inline int stat_threshold(void)
{
#if NR_CPUS <= 32
	return 32;
#else
	return dynamically_calculated_stat_threshold;
#endif
}

Did you consider my earlier suggestion about these counters?  That, over the
short-term, they tend to count in only one direction?  So we can do

	if (x > STAT_THRESHOLD) {
		zone_page_state_add(x + STAT_THRESHOLD/2, zone, item);
		x = -STAT_THRESHOLD/2;
	} else if (x < -STAT_THRESHOLD) {
		zone_page_state_add(x - STAT_THRESHOLD/2, zone, item);
		x = STAT_THRESHOLD;
	}

that'll give an decrease in contention while not consuming any extra
storage and while (I think) increasing accuracy.

Whatever way we go, let's think harder about this one, please.  Anything
which uses NR_CPUS is a red flag.
