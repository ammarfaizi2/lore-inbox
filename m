Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTGAQzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTGAQzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:55:55 -0400
Received: from ns.suse.de ([213.95.15.193]:36882 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262763AbTGAQzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:55:53 -0400
Date: Tue, 1 Jul 2003 19:09:38 +0200
From: Andi Kleen <ak@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: axboe@suse.de, grundler@parisc-linux.org, davem@redhat.com,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
Message-Id: <20030701190938.2332f0a8.ak@suse.de>
In-Reply-To: <1057077975.2135.54.camel@mulgrave>
References: <1057077975.2135.54.camel@mulgrave>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Jul 2003 11:46:12 -0500
James Bottomley <James.Bottomley@steeleye.com> wrote:

> 
> Some IOMMUs come with a "bypass" mode, where the IOMMU won't try to
> translate the physical address coming from the device but will instead
> place it directly on the memory bus. For some machines (ia-64, and
> possibly x86_64) any address not programmed into the IOMMU for

That's the case on x86_64 yes.


> The Problem:
> 
> At the moment, the block layer assumes segments may be virtually
> mergeable (i.e. two phsically discondiguous pages may be treated as a
> single SG entity for DMA because the IOMMU will patch up the
> discontinuity) if an IOMMU is present in the system.  This effectively
> stymies using bypass mode, because segments may not be virtually merged
> in a bypass operation.

I assume on 2.5 has this problem, not 2.4, right?

> 
> The Solution:
> 
> Is to teach the block layer not to virtually merge segments if either
> segment may be bypassed.  To that end, the block layer has to know what
> the physical dma mask is (not the bounce limit, which is different) and
> it must also know the address bits that must be asserted in bypass
> mode.  To that end, I've introduced a new #define for asm/io.h
> 
> BIO_VMERGE_BYPASS_MASK

But a mask is not good for AMD64 because there is no guarantee 
that the bypass/iommu address is checkable using a mask
(K8 uses an memory hole for IOMMU purposes and for various
reasons the hole can be anywhere in the address space)

This means x86_64 needs an function. Also the name is quite weird and 
the issue is not really BIO  specific. How about just calling it
iommu_address() ?


-Andi
