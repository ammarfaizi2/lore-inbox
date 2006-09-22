Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWIVGWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWIVGWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWIVGWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:22:37 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:18635 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1750709AbWIVGWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:22:36 -0400
Date: Fri, 22 Sep 2006 15:22:23 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/3] [BFIN] Blackfin documents and MAINTAINER patch
Message-ID: <20060922062223.GA20269@localhost.Internal.Linux-SH.ORG>
References: <489ecd0c0609212205j6b2004acj9f89966b7c56d9a0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489ecd0c0609212205j6b2004acj9f89966b7c56d9a0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 01:05:09PM +0800, Luke Yang wrote:
> This is the documents patche for Blackfin arch, also includes the
> MAINTAINERS file change.
> 
> Signed-off-by: Luke Yang <luke.adi@gmail.com>
> Acked-by: Alan Cox <alan@redhat.com>
> 
> Documentation/blackfin/00-INDEX          |   11 ++
> Documentation/blackfin/Filesystems       |  169 
> +++++++++++++++++++++++++++++++

Your mailer does line-wrapping..

> +cache-lock.txt
> +	- HOWTO for blackfin cache locking.
> +

This is a generic enough of a feature that I suspect we should hash out
a common API for it rather than having people roll their own.

> +How to lock your code in cache in uClinux/blackfin
> +--------------------------------------------------
> +
> +There are only a few steps required to lock your code into the cache.
> +Currently you can lock the code by Way.
> +
> +Below are the interface provided for locking the cache.
> +
> +
> +1. cache_grab_lock(int Ways);
> +
> +This function grab the lock for locking your code into the cache specified
> +by Ways.
> +
> +
> +2. cache_lock(int Ways);
> +
> +This function should be called after your critical code has been executed.
> +Once the critical code exits, the code is now loaded into the cache. This
> +function locks the code into the cache.
> +
> +
> +So, the example sequence will be:
> +
> +	cache_grab_lock(WAY0_L);	/* Grab the lock */
> +
> +	critical_code();		/* Execute the code of interest */
> +
> +	cache_lock(WAY0_L);		/* Lock the cache */
> +
> +Where WAY0_L signifies WAY0 locking.

This seems rather problematic, obviously you're constrained by
sets-per-way in the critical code, which is not mentioned anywhere in
this documentation. Likewise, the user locking in the critical code
should not have any reason to _care_ which way gets selected, or whether
they need to span over to 2 ways or not. Furthermore, the code itself
allows for grabbing the cache 'lock' for multiple ways in one go, which
people will need to use for tracking the total number of sets necessary
to accomodate the critical code. You are also missing an equivalent
cache_unlock().

If you have MMIO access to the cachelines, you would be better off just
having a locked-in page where you would remap the critical bits.

This could also be taken a step further for platforms that support
powering down cache ways for power management (particularly where the
lock-in would inhibit power-down).
