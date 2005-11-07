Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVKGI5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVKGI5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 03:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVKGI5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 03:57:37 -0500
Received: from mtaout3.012.net.il ([84.95.2.7]:62592 "EHLO mtaout3.012.net.il")
	by vger.kernel.org with ESMTP id S932462AbVKGI5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 03:57:36 -0500
Date: Mon, 07 Nov 2005 10:57:17 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] x86-64: dma_ops for DMA mapping - K3
In-reply-to: <200511061818.45878.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@ScaleMP.com)" <shai@scalemp.com>, niv@us.ibm.com,
       Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
Message-id: <20051107085717.GA32330@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20051106131112.GE24739@granada.merseine.nu>
 <200511061745.54266.ak@suse.de> <20051106170649.GI3423@mea-ext.zmailer.org>
 <200511061818.45878.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 06:18:44PM +0100, Andi Kleen wrote:
> On Sunday 06 November 2005 18:06, Matti Aarnio wrote:
> 
> >
> > git7 blows up like git2, git9 plain was not tested at all.
> > I am applying the debug patch and compiling right now for a test.
> 
> Please just test plain git9 and post full boot log if it fails.

On git2 and git7 (and probably also git9) we die on Matti's machine
because we fall back to gart with no_iommu set when we find we don't
have an IOMMU in init_k8gatt(). That causes to a panic when we try to
DMA above 4GB due to the USB controller being only 32-bit-DMA
capable.

I think that the right thing to do at that point is fall back to
swiotlb[0]. Now, We could theoretically switch to swiotlb in
pci_iommu_init() when init_k8_gatt() fails, but at that point it's too
late to call swiotlb_init() (it causes a crash in the bootmem
allocator in my tests). That leaves the following options:

- realize earlier, when we can still call the standard swiotlb_init()
that we are going to need it (is this possible?)

- switch to having our own swiotlb_init() which relies on either
GPF_DMA32 or allocating the swiotlb scratch space statically in
vmlinux (thanks Arjan), and use it when init_k8_gatt() fails.

- call swiotb_init() unconditionally in mem_init(), and free it later
if we don't need it.

Thoughts?

As a side note, none of this is related to my dma_ops patch - we die
on Matti's machine the same way with and without it and we can fix it
roughly the same way with and without it. I do think the dma_ops patch
makes the potential fixes cleaner, though.

[0] Matti machine dies at the moment even with swiotlb=soft. I think
that's a seperate, orthogonal bug.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

