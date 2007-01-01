Return-Path: <linux-kernel-owner+w=401wt.eu-S1754739AbXAAXRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbXAAXRy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbXAAXRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:17:54 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4033 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbXAAXRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:17:53 -0500
Date: Mon, 1 Jan 2007 23:17:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: James.Bottomley@SteelEye.com, arjan@infradead.org, torvalds@osdl.org,
       miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20070101231733.GD30535@flint.arm.linux.org.uk>
Mail-Followup-To: David Miller <davem@davemloft.net>,
	James.Bottomley@SteelEye.com, arjan@infradead.org,
	torvalds@osdl.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, akpm@osdl.org
References: <1167557242.20929.647.camel@laptopd505.fenrus.org> <20061231.014756.112264804.davem@davemloft.net> <1167669252.5302.57.camel@mulgrave.il.steeleye.com> <20070101.150152.15266001.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070101.150152.15266001.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 03:01:52PM -0800, David Miller wrote:
> From: James Bottomley <James.Bottomley@SteelEye.com>
> Date: Mon, 01 Jan 2007 10:34:12 -0600
> 
> > Erm, well the whole reason for the flush_anon_pages() was that you told
> > me not to do it in flush_dcache_page() ...
> > 
> > Although this is perhaps part of the confusion over what
> > flush_dcache_page() is actually supposed to do.
> 
> I completely agree, it's confusing.  I've tried to make it
> "just a hook" where architectures do whatever is necessary
> at that point to synchronize things.  It's a poor definition
> and gives the implementor not much more than a rope with which
> to hang themselves :-)
> 
> That's why I'm thinking strongly about perhaps encouraging
> people to go the kmap() route.  It would avoid all the flushing
> in exchange for some specialized TLB accesses.  If the flushes
> are really expensive, and the TLB operations to setup/teardown
> the kmap()'s can be relatively cheap, it might be the thing to
> do on PARISC.

This all sounds wonderful, and also means that if/when ARM starts
implementing highmem, kmap becomes useful.  (When I looked at that
a while back, adding the necessary flushes where required would mean
that we ended up doing a lot of flushing all over the place.)

> More and more I like Ralf's kmap() approach because you only
> do things exactly where the kernel actually touches the page.
> And if it would really help in some way, we can even tag the
> kmap() calls with "KMAP_READ" or "KMAP_WRITE" type attributes
> as appropriate.  Because let's say you don't want to do the
> TLB mapping thing, and still want to actually cache flush,
> then this hint about the access could guide what kind of flush
> you do.

You'd still want to do the flushing on ARM because it's mostly VIVT.
Remapping pages with VIVT would just makes things much worse.

So yes, this sounds like a great idea.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
