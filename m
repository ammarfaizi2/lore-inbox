Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274977AbTHKXIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 19:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274978AbTHKXIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 19:08:31 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:33951 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S274977AbTHKXI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 19:08:29 -0400
To: <linux-kernel@vger.kernel.org>
Subject: consistent_dma_mask is a ghost?
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 12 Aug 2003 01:07:32 +0200
Message-ID: <m3lltzssi3.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Repost, not sure why it haven't reach the list]

Hi,

I've run grep over the linux-2.6.0-test3 tree and it seems the whole
"consistent_dma_mask" thing does not really exist.

The following files reference it, either as a variable struct pci_dev*
dev->consistent_dma_mask or function set_consistent_dma_mask():

drivers/net/tg3.c:      sets both consistent_dma_mask and dma_mask to 2^64-1,
                        and if that fails to 2^32-1.

drivers/atm/lanai.c:    sets both to 2^32-1 = the default

drivers/pci/pci.c:      the function pci_set_consistent_dma_mask() itself

drivers/pci/probe.c:    sets default 2^32-1 for a device;

arch/ia64/sn/io/machvec/pci_dma.c: sn_pci_alloc_consistent() actually uses
                        consistent_dma_mask

arch/x86_64/kernel/pci-gart.c: pci_alloc_consistent() actually uses
                        consistent_dma_mask


This means that only _two_ platforms, ia64 and x86_64, have means to use
that information, and other platforms use set_dma_mask() and dev->dma_mask
for consistent (coherent) allocations ignoring consistent_dma_mask at all
(and possibly allocating memory from invalid region, if the masks are
not equal).

No wonder even on those two platforms no code uses consistent_dma_mask
to do some real work - i.e. both tg3 and lanai drivers use the same value
for consistent and streaming mapping. The "DMA" API doesn't have anything
like this either.

Is the whole thing a work in progress, only partially merged, and will we
see this working as documented, or should we just remove all traces of
useless consistent_dma_mask and use a single dma_mask for both kinds of
mapping? Should I prepare the patch?



Another problem, common to DMA API and PCI API:

Unless I'm mistaken, both dma_map_* and pci_map_* claim to use dma_mask
to return dma_addr_t bus address for a device. At least on i386, there
is no such thing at all - the returned address is just a result of
virt_to_phys(), and is not limited by the mask. I understand doing that
in accordance to the docs would sometimes mean memcpy() (with devices
using smaller than 2^32-1 dma_mask). Should the code be corrected/added
or are the docs to be changed to reflect reality?
-- 
Krzysztof Halasa
Network Administrator
