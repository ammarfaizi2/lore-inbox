Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbTHSJQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbTHSJQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:16:48 -0400
Received: from trained-monkey.org ([209.217.122.11]:44553 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S267561AbTHSJQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:16:45 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfzuen2.fsf@defiant.pm.waw.pl>
From: Jes Sorensen <jes@wildopensource.com>
Date: 19 Aug 2003 05:16:47 -0400
In-Reply-To: <m33cfzuen2.fsf@defiant.pm.waw.pl>
Message-ID: <m3y8xqroqo.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Krzysztof" == Krzysztof Halasa <khc@pm.waw.pl> writes:

Krzysztof> Pete Zaitcev <zaitcev@redhat.com> writes:
>> Are you talking about doing tripple calls, e.g.
>> 
>> pci_set_dma_mask(pdev, 0xFFFFFFFF); foo =
>> pci_alloc_consistent(pdev, size, &handle); // Restore for upcoming
>> streaming allocations pci_set_dma_mask(pdev, 0xFFFFFFFFFFFFFFFF);
>> 
>> Possibly Jes considered that alternative and decided that it did
>> not allow for sufficient performance.

Krzysztof> Possibly. Is that true?

It's not primarily a performance issue it's more of a correctness
issue. You *need* to be able to distinguish the masks between
consistent and dynamic allocations.

Krzysztof> I could imagine even something like that:

Krzysztof> init_module() { using_dac = 1; if (!pci_dma_supported(dev,
Krzysztof> 0xFFFFFFFFFFFFFFFF)) { if (!pci_dma_supported(dev,
Krzysztof> 0xFFFFFFFF)) error; using_dac = 0; } }

Krzysztof>         foo = pci_alloc_consistent(pdev, size, &handle,
Krzysztof> 0xFFFFFFFF); bar = pci_map_single(..., using_dac ?
Krzysztof> 0xFFFFFFFFFFFFFFFF : 0xFFFFFFFF);

Krzysztof> I don't think it would be slower. If inlined, if would be
Krzysztof> even faster.

Sure you can add the mask to the allocation calls, but thats going to
cost you since you are not going to be able to make it inline. The
consistent allocations have to be programmed into the IOMMU at mapping
time. Having the consistent DMA mask as we do right now is a lot
cleaner and it means the driver doesn't have to do a ton of runtime
accounting.

>> Before you go for that, I'd rather see you implementing the
>> double/tripple calls in drivers, check for effects, THEN go for
>> removal of the mask.

Krzysztof> The problem is that the official kernel does NOT contain
Krzysztof> any driver which needs different masks.

Bzzzt, *wrong*! Take a look at drivers/scsi/aic7xxx/aic7xxx_osm_pci.c,
if you look at the code you will notice that the hardware does support
different masks for consistent vs dynamic allocations (32 bit for
consistent vs 39 or 64 bit for dynamic). However make a note that the
driver uses the current interface incorrectly and thinks that
pci_set_dma_mask() actually applies to pci_alloc_consistent, which is
something it never did.

>> > This patch doesn't actually change any current kernel behaviour.
>> 
>> Sure it does. It blows all non-mmu ia64 out of the water.

Krzysztof> No. The kernel (2.6.0-test3 at least) doesn't count on that
Krzysztof> under any circumstances.

But it will, as people have been telling you repeatedly, there *is* a
need for this stuff, it's just that not all the patches have been
fully integrated yet. I pushed for this change in 2.5.x so we didn't
have to make infrastructure changes to support this in the middle of
2.6.x.

>> The consistent mask looks a little distasteful to me, and I think
>> it should not buy us performance because consistent allocations are
>> not supposed to be fast. They are bad, but what you are doing is
>> worse: you are trying to ruin the day of legitimate users.

Krzysztof> Of course this isn't what I'm trying to do.

Well you are trying to remove something people need and which was put
in there after considerable discussion between the involved
parties. The reasonsing was even documented in
Documentation/DMA-mapping.txt.

Jes
