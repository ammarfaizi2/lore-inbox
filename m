Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTHXNEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 09:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTHXNCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 09:02:54 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:36263 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263463AbTHXNCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 09:02:23 -0400
To: Jes Sorensen <jes@trained-monkey.org>
Cc: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl> <m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 24 Aug 2003 14:06:43 +0200
In-Reply-To: <m3isoo2taz.fsf@trained-monkey.org>
Message-ID: <m3n0dz5kfg.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@trained-monkey.org> writes:

> I don't like this approach as I mentioned before. IMHO it is adding
> unnecessary overhead to the runtime point. Why should one pass in the
> mask 5 times when it is enough to use pci_set_consistent_dma_mask
> etc.

I don't see this overhead. Most (all?) drivers use a fixed mask such
as 0x00ffffff or keep track of the mask in their internal structures
(using_dac etc). The code has to get the mask anyway, either from
pci_dev->(consistent_)dma_mask or from its arguments. Currently the
information is duplicated in both PCI and the driver. I think it may
be even faster to examine a function argument on the stack than to get
the mask from pci_dev (is it?)

If the mapping function is inlined (as with i386 case) the mask can be
optimized to NOP (however, i386 does not currently use dma_mask in
pci_map_*() at all, and it's unclear if it could do that inline).

> I still haven't seen a strong argument for the current API being
> insufficient. Alan mentioned one device causing the problem with
> multiple consistent masks, but are there many more device like that
> out there?

There might be in the future.

In general drivers may need many classes of DMA-able memory. We could,
of course, do that, but I think it's simpler to let the driver
specify mask in every call.


There is one big problem with current API: the DMA (struct driver) API
does not have consistent_dma_mask. If the PCI API is implemented on top
of DMA API, it can't be correct (and, obviously, DMA API on top of PCI
API can't be correct either). So, if we insist on keeping
consistent_dma_mask in pci_dev structure, we need to add it to DMA API
as well. There is no trivial change which can fix this problem.

DMA API is the basis for other things so adding consistent_dma_mask to
it brings other but similar problems here and there.


IMHO the actual implementation of DMA and PCI APIs is quite a mess.
I don't know if there is at least one platform which does it according
to the docs. This means many devices will not work on some platforms
without any good reason.
Moving the masks out of device + pci_dev etc. structs and thus
simplifying the API would help cleaning the code. While it's not
a trivial task, it seems to be easier to fix (and then maintain) than
adding consistent|coherent dma_mask to DMA API etc.

I'm not DMA/PCI API expert (though I know it currently much much better
than 2 weeks ago). I'd appreciate any corrections.
In fact in the beginning I thought it will be much easier.
-- 
Krzysztof Halasa
Network Administrator
