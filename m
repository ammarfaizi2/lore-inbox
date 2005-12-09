Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVLIVQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVLIVQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVLIVQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:16:27 -0500
Received: from main.gmane.org ([80.91.229.2]:8601 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932434AbVLIVQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:16:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Please help with kernel BUG at include/linux/gfp.h:80 with ndiswrapper
 on x86_64
Date: Fri, 09 Dec 2005 14:13:13 -0700
Message-ID: <dncs1c$8e5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

With kernel 2.6.15-rc5, gfp_zone has the following BUG_ON:

static inline int gfp_zone(gfp_t gfp)
{
        int zone = GFP_ZONEMASK & (__force int) gfp;
        BUG_ON(zone >= GFP_ZONETYPES);
        return zone;
}

This is being tripped by ndiswrapper on x86_64 when it calls:

dma_alloc_coherent(&pci_dev->dev,size,dma_handle, \
                           GFP_KERNEL | __GFP_REPEAT | GFP_DMA)

because dma_alloc_coherent does:

        dma_mask = dev->coherent_dma_mask;
        if (dma_mask == 0)
                dma_mask = 0xffffffff;

        /* Kludge to make it bug-to-bug compatible with i386. i386
           uses the normal dma_mask for alloc_coherent. */
        dma_mask &= *dev->dma_mask;

        /* Why <=? Even when the mask is smaller than 4GB it is often larger
           than 16MB and in this case we have a chance of finding
fitting memory
           in the next higher zone first. If not retry with true
GFP_DMA. -AK */
        if (dma_mask <= 0xffffffff)
                gfp |= GFP_DMA32;

again:
        memory = dma_alloc_pages(dev, gfp, get_order(size));


so it appears that gfp becomes GFP_DMA | GFP_DMA32 = 5 and triggers the BUG.

So, what should ndiswrapper be using in it's call to dma_alloc_coherent?
 GFP_DMA32?

Thanks!

  Orion Poplawski

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDmfNoORnzrtFC2/sRAsp2AKCiK/VAMoIGvxn3uvSuapcop7GUCwCgq9U+
HZShybTsF7LZyG1yXSJceFo=
=iInr
-----END PGP SIGNATURE-----

