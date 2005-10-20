Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751782AbVJTHUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbVJTHUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 03:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbVJTHUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 03:20:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:27368 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751778AbVJTHUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 03:20:39 -0400
Subject: Re: [patch 2.6.14-rc4] b44: alternate allocation option for DMA
	descriptors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       pp@ee.oulu.fi
In-Reply-To: <10182005213059.12243@bilbo.tuxdriver.com>
References: <10182005213059.12243@bilbo.tuxdriver.com>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 17:17:05 +1000
Message-Id: <1129792626.7620.248.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 21:30 -0400, John W. Linville wrote:
> This is a (final?) hack to support the odd DMA allocation requirements
> of the b44 hardware.  The b44 hardware has a 30-bit DMA mask.  On x86,
> anything less than a 32-bit DMA mask forces allocations into the 16MB
> GFP_DMA range.  The memory there is somewhat limited, often resulting
> in an inability to initialize the b44 driver.
> 
> This hack uses streaming DMA allocation APIs in order to provide an
> alternative in case the GFP_DMA allocation fails.  It is somewhat ugly,
> but not much worse than the similar existing hacks to support SKB
> allocations in the same driver.  FWIW, I have received positive
> feedback on this from several Fedora users.

I'm not sure what you are trying to do here ... If pci_alloc_* failed,
you do kmalloc(...,GFP_KERNEL) which can give you memory above your DMA
mask. Then, you use dma_map_* but that won't help much more neither.
Unless you have an iommu (or swiotlb) _and_ that implements arbitrary
DMA masks support (which it typically doesn't it's often 32 bits vs. 64
bits) it won't help, you'll get into your error case.

So basically, what you are doing is: if allocation fails, you try to get
memory using GFP_KERNEL. If it happens to be in the low 2Gb of memory,
use it, if not, drop it.

Did I get that right ?

Note that the Broadcom wireless (which is currently being reverse
engineered) seem to suffer from the same stupid DMA engine...

Ben.

