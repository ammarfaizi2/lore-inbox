Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTFJUMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTFJULQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:11:16 -0400
Received: from palrel12.hp.com ([156.153.255.237]:38091 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262312AbTFJUKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:10:30 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16102.15974.597441.186748@napali.hpl.hp.com>
Date: Tue, 10 Jun 2003 13:24:06 -0700
To: hch@infradead.org, James.Bottomley@SteelEye.com
Cc: davem@redhat.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
In-Reply-To: <16097.37454.827982.278024@napali.hpl.hp.com>
References: <16096.16492.286361.509747@napali.hpl.hp.com>
	<20030606.003230.15263591.davem@redhat.com>
	<200306062013.h56KDcLe026713@napali.hpl.hp.com>
	<20030606.234401.104035537.davem@redhat.com>
	<16097.37454.827982.278024@napali.hpl.hp.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

You wrote:

 > imo PCI_DMA_BUS_IS_PHYS should be a propert of each struct device
 > because a machine might have a iommu for one bus type but not
 > another, e.g.

 >	dma_is_phys(dev);

As pointed out by DaveM, this isn't sufficient for the block layer,
which needs to know the page size of the I/O MMU so it can make
merging decisions about physically discontiguous buffers.

I think we also need:

	/*
	 * Returns a mask of bits which need to be 0 in order for
	 * the DMA-mapping interface to be able to remap a buffer.
	 * DMA-mapping implementations for real (hardware) I/O MMUs
	 * will want to return (iommu_page_size - 1) here, if they
	 * support such remapping.  DMA-mapping implementations which
	 * do not support remapping must return a mask of all 1s.
	 */
	unsigned long dma_merge_mask(dev)

Then you can replace:

	BIO_VMERGE_BOUNDARY => (dma_merge_mask(dev) + 1)

Of course, this doesn't work literally, because we don't have a device
pointer handy in the bio code.  Instead, it would probably make the
most sense to add a "iommu_merge_mask" member to "struct
request_queue" and then do something along the lines of:

 #define BIO_VMERGE_BOUNDARY(q)	((q)->iommu_merge_mask + 1)

Note 1: the "+ 1" will get optimized away because the only way
BIO_VMERGE_BOUNDARY() is used is in BIOVEC_VIRT_MERGEABLE, which
really needs a mask anyhow; this could be cleaned up of course, but
that's a separate issue.

Note 2: dma_merge_mask() cannot be used to replace dma_is_phys() (as
much as I'd like that), because they issue of (virtual) remapping is
really quite distinct from whether a (hardware) I/O MMU is present
(not to mention the _other_ reason that a bus may not be "physical").

Note 3: I'm not comfortable hacking the bio code, so if someone would
like to prototype this, by all means go ahead... ;-)

Thanks,

	--david
