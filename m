Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWA3RVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWA3RVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWA3RVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:21:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56037 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964822AbWA3RVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:21:04 -0500
Date: Mon, 30 Jan 2006 18:21:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: boot-time slowdown for measure_migration_cost
Message-ID: <20060130172140.GB11793@elte.hu>
References: <200601271403.27065.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601271403.27065.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> The boot-time migration cost auto-tuning stuff seems to have been 
> merged to Linus' tree since 2.6.15.  On little one- or two-processor 
> systems, the time required to measure the migration costs isn't very 
> noticeable, but by the time we get to even a four-processor ia64 box, 
> it adds about 30 seconds to the boot time, which seems like a lot.
> 
> Is that expected?  Is the information we get really worth that much?  
> Could the measurement be done at run-time instead?  Is there a smaller 
> hammer we could use, e.g., flushing just the buffer rather than the 
> *entire* cache? Did we just implement sched_cacheflush() incorrectly 
> for ia64?
> 
> Only ia64, x86, and x86_64 currently have a non-empty 
> sched_cacheflush(), and the x86* ones contain only "wbinvd()". So I 
> suspect that only ia64 sees this slowdown.  But I would guess that 
> other arches will implement it in the future.

the main cost comes from accessing the test-buffer when the buffer size 
gets above the real cachesize. There are a coupe of ways to improve 
that:

- double-check that max_cache_size gets set up correctly on your 
  architecture - the code searches from ~64K to 2*max_cache_size.

- take the values that are auto-detected and use the migration_cost= 
  boot parameter - see Documentation/kernel-parameters.txt:

        migration_cost=
                        [KNL,SMP] debug: override scheduler migration costs
                        Format: <level-1-usecs>,<level-2-usecs>,...
                        This debugging option can be used to override the
                        default scheduler migration cost matrix. The numbers
                        are indexed by 'CPU domain distance'.
                        E.g. migration_cost=1000,2000,3000 on an SMT NUMA
                        box will set up an intra-core migration cost of
                        1 msec, an inter-core migration cost of 2 msecs,
                        and an inter-node migration cost of 3 msecs.

  (a distribution could do this automatically as well in the installer, 
  i've constructed the bootup printout to be in the format that is 
  needed for migration_cost. I have not tested this too extensively 
  though, so double-check the result via an additional 
  migration_debug=2 printout as well! Let me know if you find any bugs 
  here.)

  via this solution you will get zero overhead on subsequent bootups.

- in kernel/sched.c, decrease ITERATIONS from 2 to 1. This will make the 
  measurement more noisy though.

- in kernel/sched.c, change this line:

                size = size * 20 / 19;

  to:

                size = size * 10 / 9;

  this will probably halve the cost - against at the expense of 
  accuracy and statistical stability.

	Ingo
