Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTKTOQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 09:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTKTOQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 09:16:45 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:60167 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261538AbTKTOQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 09:16:44 -0500
Date: Thu, 20 Nov 2003 17:16:24 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Simplification in pbus_size_mem
Message-ID: <20031120171624.A30024@jurassic.park.msu.ru>
References: <20031120122838.GA4575@malvern.uk.w2k.superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031120122838.GA4575@malvern.uk.w2k.superh.com>; from Richard.Curnow@superh.com on Thu, Nov 20, 2003 at 12:28:38PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 12:28:38PM +0000, Richard Curnow wrote:
> * 96Mb PCI memory aperture

Also there is a PCI-PCI bridge, I guess? ;-)

> * Kyro graphics card, requiring 64Mb + 768kb prefetchable

768Kb sounds strange. It must be power of 2. Perhaps it's 512Kb MMIO
and 256Kb ROM? But MMIO registers must be non-prefetchable. Weird.

> * USB card requiring 4x4k non-prefetchable
> 
> Without the change, 'min_align' is computed as 32Mb (the algorithm in the
> loop basically seems to make 'min_align' end up as 1/2 the largest

No. For example, if you have 64Mb + 2x16Mb then 'min_align' will be 16Mb.

> alignment requirement that was found?), hence in the pass where the
> prefetchable block is sized, 'size' ends up as 96Mb, which means there
> is no space left in which to place the non-prefetchable blocks for the
> USB card.

Yes, it's a trade-off - minimizing alignment vs. size requirements.
In most situations the former approach gives much better allocations.

> With the patch above, the alignment requirement for the prefetchable
> memory actually ends up as the alignment required for the framebuffer,
> and the size isn't rounded up unnecessarily.  The USB card gets
> allocated successfully as a result.

Well, it works only because your 96Mb PCI aperture is aligned at 64Mb
(or more). If it was aligned at 32Mb, you wouldn't be able to allocate
prefetchable memory at all with your patch.

As a workaround, you can mark those additional 768Kb regions as
non-prefetchable and be done with it.

Ivan.
