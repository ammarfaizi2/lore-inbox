Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVCYBsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVCYBsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVCYBre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:47:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44455 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261389AbVCYBod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:44:33 -0500
Date: Fri, 25 Mar 2005 02:44:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
Message-ID: <20050325014411.GA7698@elf.ucw.cz>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Changelog:
> - Drop clear_pages and the approach to zero pages of higher order
>   first
> - Zero a percentage of pages from all orders to avoid fragmentation
> 
> Adds management of ZEROED and NOT_ZEROED pages and a background daemon
> called scrubd. /proc/sys/vm/scrubd_load, /proc/sys/vm_scrubd_start and
> /proc/sys/vm_scrubd_stop control the scrub daemon. See Documentation/vm/
> scrubd.txt
> 
> In an SMP environment the scrub daemon is typically running on the most
> idle cpu. Thus a single threaded application running
> on one cpu may have the other cpu zeroing pages for it etc. The scrub
> daemon is hardly noticable and usually finishes zeroing quickly since
> most processors are optimized for linear memory filling.
> 
> Patch against 2.6.11.3-bk3

> +unsigned int sysctl_scrub_start = 100;	/* Min percentage of zeroed free pages per zone (~10% default) */
> +unsigned int sysctl_scrub_stop = 300;	/* Max percentage of zeroed free pages per zone (~30% default) */
> +unsigned int sysctl_scrub_load = 1;	/* Do not run scrubd if load > */


Perhaps that variable should be called sysctl_scrub*d*_load?

....
> +        while (avenrun[0] >= ((unsigned long)sysctl_scrub_load << FSHIFT))
> +		schedule_timeout(30*HZ);
> +
> +	for (i = 0; i < pgdat->nr_zones; i++)
> +		zero_zone(pgdat->node_zones +i);

tabs vs. spaces alert, but more importantly....
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.11/Documentation/vm/scrubd.txt	2005-03-17 12:57:41.000000000 -0800
> @@ -0,0 +1,59 @@
> +The SCRUB Daemon
> +----------------
> +
> +The scrub daemon zeroes memory so that later requests for zeroed memory can
> +be satisifed without having to zero memory in a hot code path. The operations
> +of scrubd may be controlled through 3 variables in /proc/sys/vm:
> +
> +/proc/sys/vm/scrubd_load	default value	1
> +
> +	Scrubd is woken up if the system load is lower than this setting and
> +	the numer of unzeroed free pages drops below scrub_start*10 percent.
> +	The default setting of 1 insures that there will be no performance
> +	degradation in single user mode. In an SMP system a cpu is frequently
> +	idle despite the load being high. A setting of 9 or 99 may
> +	be useful then.

I don't think 1 guarantees no performance degradation. After all, it
is average load and scrubd might run at just the wrong times. Perhaps
it should default to 0?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
