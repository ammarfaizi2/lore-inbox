Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUFQTMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUFQTMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUFQTMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:12:45 -0400
Received: from zero.aec.at ([193.170.194.10]:64517 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261875AbUFQTKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:10:51 -0400
To: Anton Blanchard <anton@samba.org>
cc: mark_salyzyn@adaptec.com, Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: PATCH: Further aacraid work
References: <286GI-5y3-11@gated-at.bofh.it> <286Qp-5EU-19@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 17 Jun 2004 21:10:43 +0200
In-Reply-To: <286Qp-5EU-19@gated-at.bofh.it> (Anton Blanchard's message of
 "Thu, 17 Jun 2004 17:20:09 +0200")
Message-ID: <m3smcut2z0.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> writes:

> Please divert some of your anger towards your manufacturer of dodgy
> hardware. Any sane hardware with an IOMMU handles this just fine.
> eg on ppc64 running a disk test:
>
> sg size    in        out
> 1           3      47569
> 2           0       2591
> 3           0       1123
> 4           0        447
> 5           0        429
> ...
> 62       5095          0
> 64      47061          0
>
> The IOMMU is taking 62-64 entry SG lists and producing 1-5 entry lists.

The AMD64 IOMMU could do it too (and the code to do it exists in
2.6). But the problem is that the current IO layer doesn't provide a
sufficient fallback path when this fails. You have to promise in
advance that you can merge and then later it's too late to change your
mind without signalling an IO error.

This is a real problem on AMD64, because IOMMU aperture is relatively
small and can fragment. 

I had a chat with James about this at last year's OLS. The Consensus
was iirc that it needs driver interface changes at least.

If there was a sane fallback path for this I would enable merging
always (and add some fragmentation avoidance algorithms to the 
bitmap allocator to make failure less likely)

It's also a balancing act in terms of performance. The IOMMU setup
is relatively slow (it has to do an PCI config space write and 
an uncached memory access), and it depends on the device if it's 
actually faster to go through the IOMMU. I did some benchmarks
and it seems to help on MPT Fusion controllers, but slows down
ethernet. Most probably we need an driver function call where
the driver can tell the IOMMU layer "I am slow at merging; 
give me merged sg lists and i can handle errors by falling back"

Also of course when the merging is used you will always get
addresses <32bit and can potentially use smaller descriptors.
But again you need fallback, because on AMD64 the IOMMus 
can be quite small and it's possible to overflow them 
in extreme traffic situations.

-Andi

