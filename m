Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271928AbTHRWAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275118AbTHRWAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:00:21 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:6364 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S271928AbTHRWAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:00:18 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030817233705.0bea9736.davem@redhat.com>
	<m3r83jyw2k.fsf@defiant.pm.waw.pl>
	<20030818054341.2ef07799.davem@redhat.com>
	<m365kvufjx.fsf@defiant.pm.waw.pl>
	<20030818094955.3aa5c1c2.davem@redhat.com>
	<m3d6f2kern.fsf@defiant.pm.waw.pl>
	<20030818115052.41e62a90.davem@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Aug 2003 23:58:47 +0200
In-Reply-To: <20030818115052.41e62a90.davem@redhat.com>
Message-ID: <m3n0e6mxuw.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> drivers/net/tg3.c

No... I know of tg3.c:

        /* Configure DMA attributes. */
        if (!pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
                pci_using_dac = 1;
                if (pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL)) {
                        printk(KERN_ERR PFX "Unable to obtain 64 bit DMA "
                               "for consistent allocations\n");
                        goto err_out_free_res;
                }
        } else {
                err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
                if (err) {
                        printk(KERN_ERR PFX "No usable DMA configuration, "
                               "aborting.\n");
                        goto err_out_free_res;
                }
                pci_using_dac = 0;
        }

As you can see it tg3 uses consistent_dma_mask = dma_mask so this one
doesn't need two masks.


Ok, I assume there is a real need for two masks. Still, having different
archs rely on different variables for the same task is a bug which needs
fixing.

Example:

$ grep DMA_MASK sound/oss/emu10k1/main.c
#define EMU10K1_DMA_MASK                0x1fffffff      /* DMA buffer mask for pci_alloc_consist */
        if (pci_set_dma_mask(pci_dev, EMU10K1_DMA_MASK)) {


Do you see a problem here? It will work if and only if pci_alloc_consistent
uses dma_mask rather than consistent_dma_mask.

Ok, I will make a patch which uses consistent_dma_mask for consistent allocs
on all archs. This will break drivers but they are already broken on
x86-64 and ia64, and it's easier to fix drivers than to write them when
the core is faulty.

Hope that it is ok?
-- 
Krzysztof Halasa
Network Administrator
