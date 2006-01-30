Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWA3SxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWA3SxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWA3SxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:53:15 -0500
Received: from fmr22.intel.com ([143.183.121.14]:16545 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964867AbWA3SxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:53:14 -0500
Date: Mon, 30 Jan 2006 10:53:01 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@redhat.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: boot-time slowdown for measure_migration_cost
Message-ID: <20060130185301.GA4622@agluck-lia64.sc.intel.com>
References: <200601271403.27065.bjorn.helgaas@hp.com> <20060130172140.GB11793@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130172140.GB11793@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 06:21:40PM +0100, Ingo Molnar wrote:
> - double-check that max_cache_size gets set up correctly on your 
>   architecture - the code searches from ~64K to 2*max_cache_size.

Ia64 gets that from PAL in get_max_cacheline_size() in ia64/kernel/setup.c
A quick printk() in there confirms that we get the right answer (9MB for
me), and that it happens before we compute the migration cost.

> - take the values that are auto-detected and use the migration_cost= 
>   boot parameter - see Documentation/kernel-parameters.txt:
>   ...
>   via this solution you will get zero overhead on subsequent bootups.

But if you are going to go this route, you could drop all this code from
the kernel and have a hard-wired constant, with a user-mode test program
to compute the more accurate value.

> - in kernel/sched.c, decrease ITERATIONS from 2 to 1. This will make the 
>   measurement more noisy though.

Doing this drops the time to compute the value from 15.58s to 10.39s, while
the value of migration_cost changes from 10112 to 9909.

> - in kernel/sched.c, change this line:
>                 size = size * 20 / 19;
>   to:
>                 size = size * 10 / 9;

Doing this instead of changing ITERATIONS makes the computation take 7.79s
and the computed migration_cost is 9987.

Doing both gets the time down to 5.20s, and the migration_cost=9990.

So the variation in the computed value of migration_cost was at worst
2% with these modifications to the algorithm.  Do you really need to know
the value to this accuracy?  What 2nd order bad effects would occur from
using an off-by-2% value for scheduling decisions?

On the plus side Prarit's results show that this time isn't scaling with
NR_CPUS ... apparently just cache size and number of domains are significant
in the time to compute.

-Tony
