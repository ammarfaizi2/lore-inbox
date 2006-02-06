Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWBFRjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWBFRjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWBFRjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:39:33 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:50063 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932253AbWBFRjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:39:32 -0500
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Brian King <brking@us.ibm.com>, "David S. Miller" <davem@davemloft.net>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602061621450.3560@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>
	 <43E66FB6.6070303@us.ibm.com>
	 <Pine.LNX.4.61.0602060909180.6827@goblin.wat.veritas.com>
	 <20060206.014608.22328385.davem@davemloft.net>
	 <43E7613B.5060706@us.ibm.com>
	 <Pine.LNX.4.61.0602061621450.3560@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 11:38:35 -0600
Message-Id: <1139247516.3022.6.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 16:45 +0000, Hugh Dickins wrote:
> But I'd also want James or someone to clarify the paragraph
> "Please note that the sg cannot be mapped again if it has been mapped once.
>  The mapping process is allowed to destroy information in the sg."
> which I took as explicitly allowing what x86_64 does in gart_map_sg.
> I thought James had a scenario in mind which demands this wholesale
> destruction, but it seems not; and I now read that first sentence as
> saying the sg must be unmapped before it can be mapped a second time,
> not that it can only be mapped once.
> 
> And add a paragraph explaining that really the one array of scatterlist
> entries should be regarded as two arrays of possibly different lengths,
> the page,offset,length array and the dma_address,dma_length array:
> because entries of the latter may be coalesced, so that in the end
> the dma_address in a scatterlength entry may bear no relation to the
> page pointer in that same entry, but to the page pointer in a later entry.
> Though it gets hard to explain given that not all architectures coalesce,
> so may not even have a separate dma_length field; or use different naming.
> If you can express this better than I, please do!

Yes, I added that piece after the x86_64 problem.  The original x86_64
bug was that you couldn't do dma_map_sg() then dma_unmap_sg() then
dma_map_sg() on the same scatterlist (the map was destroying information
which wasn't restored on the unmap, so the second map produced an
incorrect scatterlist), which was causing a bug in all SCSI drivers
(because that's the way SCSI requeueing works).

James


