Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274961AbTHRQym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274964AbTHRQym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:54:42 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:41690 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S274961AbTHRQye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:54:34 -0400
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jes Sorensen <jes@wildopensource.com>
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Aug 2003 18:14:25 +0200
In-Reply-To: <20030818111522.A12835@devserv.devel.redhat.com>
Message-ID: <m33cfzuen2.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:

> Are you talking about doing tripple calls, e.g.
> 
>        pci_set_dma_mask(pdev, 0xFFFFFFFF);
>        foo = pci_alloc_consistent(pdev, size, &handle);
>        // Restore for upcoming streaming allocations
>        pci_set_dma_mask(pdev, 0xFFFFFFFFFFFFFFFF);
> 
> Possibly Jes considered that alternative and decided that it
> did not allow for sufficient performance.

Possibly. Is that true?

I could imagine even something like that:

init_module()
{
        using_dac = 1;
        if (!pci_dma_supported(dev, 0xFFFFFFFFFFFFFFFF)) {
                if (!pci_dma_supported(dev, 0xFFFFFFFF))
                      	error;
                using_dac = 0;
        }
}

...

        foo = pci_alloc_consistent(pdev, size, &handle, 0xFFFFFFFF);
        bar = pci_map_single(...,
                using_dac ? 0xFFFFFFFFFFFFFFFF : 0xFFFFFFFF);

I don't think it would be slower. If inlined, if would be even faster.

However, the main problem is not that it isn't beautiful but rather that
it's broken.

> Before you go for that, I'd rather see you implementing the
> double/tripple calls in drivers, check for effects, THEN
> go for removal of the mask.

The problem is that the official kernel does NOT contain any driver which
needs different masks.

> > This patch doesn't actually change any current kernel behaviour.
> 
> Sure it does. It blows all non-mmu ia64 out of the water.

No. The kernel (2.6.0-test3 at least) doesn't count on that under any
circumstances.

> The consistent mask looks a little distasteful to me, and I think
> it should not buy us performance because consistent allocations
> are not supposed to be fast. They are bad, but what you are doing
> is worse: you are trying to ruin the day of legitimate users.

Of course this isn't what I'm trying to do.
-- 
Krzysztof Halasa
Network Administrator
