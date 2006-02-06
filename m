Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWBFQpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWBFQpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWBFQpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:45:17 -0500
Received: from gold.veritas.com ([143.127.12.110]:27810 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932209AbWBFQpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:45:15 -0500
Date: Mon, 6 Feb 2006 16:45:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Brian King <brking@us.ibm.com>
cc: "David S. Miller" <davem@davemloft.net>, James.Bottomley@SteelEye.com,
       Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
In-Reply-To: <43E7613B.5060706@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0602061621450.3560@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>
 <43E66FB6.6070303@us.ibm.com> <Pine.LNX.4.61.0602060909180.6827@goblin.wat.veritas.com>
 <20060206.014608.22328385.davem@davemloft.net> <43E7613B.5060706@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Feb 2006 16:45:14.0824 (UTC) FILETIME=[B4380480:01C62B3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Brian King wrote:
> David S. Miller wrote:
> > From: Hugh Dickins <hugh@veritas.com>
> > Date: Mon, 6 Feb 2006 09:32:54 +0000 (GMT)
> > 
> >> From looking at the source, the architectures I found to be doing
> >> scatterlist coalescing in some cases were alpha, ia64, parisc (some
> >> code under drivers), powerpc, sparc64 and x86_64.
> >>
> >> I agree with you that it would be possible for them to do the coalescing
> >> by just adjusting dma_address and dma_length (though it's architecture-
> >> dependent whether there are such fields at all), not interfering with
> >> the input page and length; and maybe some of them do proceed that way.
> >> I didn't find the coalescing code in any of them very easy to follow.
> >>
> >> So please examine arch/x86_64/kernel/pci_gart.c gart_map_sg (and
> >> dma_map_cont which it calls): x86_64 was the architecture on which
> >> the problem was really found with drivers/scsi/st.c, and avoided
> >> by that boot option iommu=nomerge.
> >>
> >> Lines like "*sout = *s;" and "*sout = sg[start];" are structure-
> >> copying whole scallerlist entries from one position in the list
> >> to another, without explicit mention of the page and length fields.
> > 
> > That's a bug, frankly.  Sparc64 doesn't need to do anything like
> > that.  Spamming the page pointers is really really bogus and I'm
> > surprised this doesn't make more stuff explode.
> > 
> > It was never the intention to allow the DMA mapping support code
> > to modify the page, offset, and length members of the scatterlist.
> > Only the DMA components.
> > 
> > I'd really prefer that those assignments get fixed and an explicit
> > note added to Documentation/DMA-mapping.txt about this.
> 
> How about this for a documentation fix?

Now that David and (to my surprise) James have come out clearly in
favour of your interpretation, yes, this would certainly be an
improvement.

But I'd also want James or someone to clarify the paragraph
"Please note that the sg cannot be mapped again if it has been mapped once.
 The mapping process is allowed to destroy information in the sg."
which I took as explicitly allowing what x86_64 does in gart_map_sg.
I thought James had a scenario in mind which demands this wholesale
destruction, but it seems not; and I now read that first sentence as
saying the sg must be unmapped before it can be mapped a second time,
not that it can only be mapped once.

And add a paragraph explaining that really the one array of scatterlist
entries should be regarded as two arrays of possibly different lengths,
the page,offset,length array and the dma_address,dma_length array:
because entries of the latter may be coalesced, so that in the end
the dma_address in a scatterlength entry may bear no relation to the
page pointer in that same entry, but to the page pointer in a later entry.
Though it gets hard to explain given that not all architectures coalesce,
so may not even have a separate dma_length field; or use different naming.
If you can express this better than I, please do!

But all this presupposes that someone is suddenly going to change the
x86_64 gart_map_sg (and subfunctions), or else force its iommu=nomerge:
that won't be me.

Hugh

> The current pci_map_sg API is a bit unclear what it is allowed
> to modify in the passed scatterlist when coalescing entries.
> Clarify the pci_map_sg API to prevent it from modifying
> the page, offset, and length fields in the scatterlist.
> 
> Signed-off-by: Brian King <brking@us.ibm.com>
> ---
> 
>  linux-2.6-bjking1/Documentation/DMA-mapping.txt |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff -puN Documentation/DMA-mapping.txt~dma_mapping_clarification Documentation/DMA-mapping.txt
> --- linux-2.6/Documentation/DMA-mapping.txt~dma_mapping_clarification	2006-02-06 08:23:10.000000000 -0600
> +++ linux-2.6-bjking1/Documentation/DMA-mapping.txt	2006-02-06 08:38:43.000000000 -0600
> @@ -513,7 +513,10 @@ consecutive sglist entries can be merged
>  ends and the second one starts on a page boundary - in fact this is a huge
>  advantage for cards which either cannot do scatter-gather or have very
>  limited number of scatter-gather entries) and returns the actual number
> -of sg entries it mapped them to. On failure 0 is returned.
> +of sg entries it mapped them to. The implementation is free to do this
> +by modifying the scatterlist fields specified for DMA. The scatterlist
> +fields used as an input to this function (i.e. page, offset, and length)
> +will NOT be modified. On failure 0 is returned.
>  
>  Then you should loop count times (note: this can be less than nents times)
>  and use sg_dma_address() and sg_dma_len() macros where you previously
