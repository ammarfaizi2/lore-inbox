Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUHBRJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUHBRJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUHBRJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:09:53 -0400
Received: from holomorphy.com ([207.189.100.168]:58541 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266643AbUHBRI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:08:57 -0400
Date: Mon, 2 Aug 2004 10:08:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: sfr@ozlabs.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH] [ppc64] watch IOMMU virtual merging
Message-ID: <20040802170843.GI2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, sfr@ozlabs.org,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
	benh@kernel.crashing.org
References: <20040802164448.GN30253@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802164448.GN30253@krispykreme>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 02:44:48AM +1000, Anton Blanchard wrote:
> Heres a quick patch to watch IOMMU virtual merging on ppc64. The column
> on the left is the SG list before virtual merging and the one on the
> right is after virtual merging.
> Also attached is a sample of a dd from a disk. One interesting thing to
> note is that the merging is worse than on earlier 2.6 kernels. The dd
> test would show only 1 segment SG lists on the way out, now we have a
> range of 1-8 segment SG lists.

Okay, this is not encouraging.


On Tue, Aug 03, 2004 at 02:44:48AM +1000, Anton Blanchard wrote:
> I think the change in the page allocator to attempt to allocate memory
> in increasing addresses (which improves physical merging a lot) is
> causing this. In doing so we end up with some really large SG entries
> (greater than 15 pages) and the largealloc path in the ppc64 IOMMU code
> kicks in and allocates it in another region of TCE space. This makes it
> impossible to merge with a smaller allocation either before or after it.
> The other problem with large SG list entries is that IOMMU space
> exhaustion could prevent it from being mapped, while it would fit if no
> physical merging had taken place. One option is to disable physical
> merging for ppc64 but there are trade offs (eg physical merging allows
> us to allocate smaller SG lists).
> We have discussed these issues before, but its interesting to have some
> data to analyse.

This is a rather painful state of affairs. I'm not convinced external
fragmentation in the IOMMU address space is insurmountable as the
physically contiguous segments can (in principle; the mechanics of
ramming this through the IO subsystem are another matter entirely) be
IO-mapped in a bus-discontiguous fashion.

I'm not familiar with the TCE space regions; could you describe or
point to documentation for the semantics there?

My first thought is to artificially limit the amount of physical
merging (hopefully to some nonzero amount instead of disabling it
entirely) allowed to take place in order to allow for better virtual
merging.


-- wli
