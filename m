Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTGATFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTGATFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:05:23 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:37128 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S263407AbTGATFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:05:18 -0400
Date: Tue, 1 Jul 2003 13:19:41 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jens Axboe <axboe@suse.de>, ak@suse.de, davem@redhat.com,
       suparna@in.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alex Williamson <alex_williamson@hp.com>,
       Bjorn Helgaas <bjorn_helgaas@hp.com>
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
Message-ID: <20030701191941.GF14683@dsl2.external.hp.com>
References: <1057077975.2135.54.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057077975.2135.54.camel@mulgrave>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 11:46:12AM -0500, James Bottomley wrote:
...
> However, a fair number come with
> the caveat that actually using the IOMMU is expensive.

Clarification:
IOMMU mapping is slightly more expensive than direct physical on HP boxes.
(yes davem, you've told me how wonderful sparc IOMMU is ;^)
But obviously alot less expensive than bounce buffers.

> The Problem:
> 
> At the moment, the block layer assumes segments may be virtually
> mergeable (i.e. two phsically discondiguous pages may be treated as a
> single SG entity for DMA because the IOMMU will patch up the
> discontinuity) if an IOMMU is present in the system.

The symptom is drivers which have limits on DMA entries will return
errors (or crash) when the IOMMU code doesn't actually merge as much
as the BIO code expected.

Specifically, sym53c8xx_2 only takes 96 DMA entries per IO and davidm
hit that pretty easily on ia64.
MPT/Fusion (LSI u32) doesn't seem to have a limit.
IDE limit is PAGE_SIZE/8 (or 16k/8=2k for ia64).
I haven't checked other drivers.

...
> +/* Is the queue dma_mask eligible to be bypassed */
> +#define __BIO_CAN_BYPASS(q) \
> +	((BIO_VMERGE_BYPASS_MASK) && ((q)->dma_mask & (BIO_VMERGE_BYPASS_MASK)) == (BIO_VMERGE_BYPASS_MASK))

Like Andi, I had suggested a callback into IOMMU code here.
But I'm pretty sure james proposal will work for ia64 and parisc.

Ideally, I don't like to see two seperate chunks of code performing
the "let's see what I can merge now" loops. Instead, BIO could merge
"intra-page" segments and call the IOMMU code to "merge" remaining
"inter-page" segments. IOMMU code needs to know how many physical entries
are allowed (when to stop processing) and could return the number of
sg list entries it was able to merge.

thanks james!
grant
