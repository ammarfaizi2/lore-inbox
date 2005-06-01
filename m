Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVFAWMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVFAWMy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVFAWKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:10:16 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40645 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261177AbVFAWF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:05:57 -0400
Date: Wed, 1 Jun 2005 15:05:55 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/3] RapidIO support: core
Message-ID: <20050601150555.A18513@cox.net>
References: <20050601110836.A16559@cox.net> <20050601133757.624059c4@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050601133757.624059c4@dxpl.pdx.osdl.net>; from shemminger@osdl.org on Wed, Jun 01, 2005 at 01:37:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 01:37:57PM -0700, Stephen Hemminger wrote:
> Quick review comments:
 
Thanks for taking the time to look at this.
 
> 1. Why hack up vmlinux.lds.h? wouldn't declaring rio_route_ops
> to be a constant do what you want?

There are more switch devices to be added. That is, each vendor has
their own way to set/get route table entries.  This approach makes it
easy to add a fooswitch.c without adding an entry to a separate constant
table as we support additional switches (at least 5 vendors so far). I
originally  looked at how PCI was using a section for quirks and figured
that was OK to copy. I can see how PCI might justify it a bit more since
it is allowing arch-specific quirks to be registered without modifying
a generic PCI table of quirks.  If it's a concern, I can make a constant
table but it's not as nice IMHO.

FWIW, I was going to expand usage of RIO-specific sections a bit more,
so I'd like to see what the consensus is on using sections to generate
tables at build time.  Specifically, support for MMIO regions requires
node specific operations (specific to each vendor device) as RIO
neglected to standardize something like BARs a la PCI. My intention
was to put some device-specific ops to get the size of active MMIO
regions etc. with the same approach as the switch ops.

> 2. Unnecessary initializers
> 
> +struct bus_type rio_bus_type = {
> +	.name = "rapidio",
> +	.match = rio_match_bus,
> +	.suspend = NULL,
> +	.resume = NULL,
> 
> 	NULL is unnecessary here.

I'll drop those.

> 3. Use existing macro's
> 
> +#define DEBUG
> +
> +#ifdef DEBUG
> +#define DBG(x...) printk(x)
> +#else
> +#define DBG(x...)
> +#endif
> +
> 
> 	Use pr_debug() and isn't this debugged yet?

That was to control debug info per-file, but can be changed.  It's
debugged to a certain level, but some network configuration are
going to expose corner cases that I haven't noticed while testing
with 2-3 boards on the 1st gen hardware. Same reason there are still
debug statements riddled throughout the PCI code...there's always
more bugs. :)

> 4. Lists should be static if possible
> 
> +
> +LIST_HEAD(rio_mports);
> 	static LIST_HEAD(rio_mports)

Ok, will do.
 
> 5. rio_nets defined but not used (if it is used later then
>    make it visible to only that code.)

That was supposed to be removed as I don't yet have a use for it.
I'll remove it.

> 6. rio_net_lock does it need to be global.
>    also maybe a name change to rio_global_list_lock

It is taken outside of rio-scan.c while searching lists so it can't
be static. The name does suck, though. I'll change it to something
like that.

-Matt
