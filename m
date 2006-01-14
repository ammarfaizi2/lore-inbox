Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWANFBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWANFBE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 00:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWANFBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 00:01:04 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:32641 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751233AbWANFBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 00:01:01 -0500
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: rmk+lkml@arm.linux.org.uk, htejun@gmail.com, axboe@suse.de,
       bzolnier@gmail.com, james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060113.144301.09196399.davem@davemloft.net>
References: <11371658562541-git-send-email-htejun@gmail.com>
	 <20060113220215.GD31824@flint.arm.linux.org.uk>
	 <1137191930.3365.96.camel@mulgrave>
	 <20060113.144301.09196399.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 22:58:50 -0600
Message-Id: <1137214730.3365.106.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 14:43 -0800, David S. Miller wrote:
> Not true, VIPT caches participate in cache coherency transactions
> with the PCI host controller (and thus the PCI device), whereas
> VIVT caches do not.

Yes ... I understand that.  However for VIPT caches, we can only specify
one Virtual Index to be coherent (and the user mappings and the kernel
are at different virtual indexes) so we specify the kernel mapping in
the current implementation.  We rely on the page cache cache<->user
piece making the rest of the user mappings coherent.  So on parisc we
come out of the dma_unmap with the kernel coherent but not userspace.
The content of these patches was to put a flush_dcache_page() in the PIO
path, which makes both kernel and user mappings fully coherent.  If
there was a bug because that is necessary, then it should show up on the
VIPT machines like parisc because user space isn't currently coherent
after a dma_unmap.  But like I asked, is there a pointer to the original
bug ... I really think I need to look at that.

> It does make a big difference, it's very hard to share datastructures
> with a device concurrently accessing them (what we call PCI consistent
> DMA mappings) on a VIVT cache.

Yes ... I've always fancied a VIVT machine to play with ... but no-one's
ever sent me such a toy, sigh.

James


