Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUBLWMK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUBLWMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:12:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:41465 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266505AbUBLWKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:10:40 -0500
In-Reply-To: <qdj1xp06k6z.fsf@pom.rchland.ibm.com>
References: <qdj1xp06k6z.fsf@pom.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <37529C28-5DA8-11D8-9AB8-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc64-dev@lists.linuxppc.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [ppc64] support for dma-mapping
Date: Thu, 12 Feb 2004 16:10:07 -0600
To: Dave Boutcher <sleddog@us.ibm.com>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2004, at 3:51 PM, Dave Boutcher wrote:
[snip]
> include/asm-ppc64/dma-mapping.h
>
> +static inline int
> +dma_supported(struct device *dev, u64 mask)
> +{
> +	if (dev->bus == &pci_bus_type) return 
> pci_dma_supported(to_pci_dev(dev), mask);
> +	if (dev->bus == &vio_bus_type) return 
> vio_dma_supported(to_vio_dev(dev), mask);
> +	BUG();
> +}

The thing is that there is such an obvious cleanup here:

+static inline int
+dma_supported(struct device *dev, u64 mask)
+{
+	if (dev->bus)
+		return dev->bus->dma_supported(dev, mask);
+	BUG();
+}

This would require modifying include/linux/device.h for struct bus_type 
(impacting PCI and USB at least). In fact I'm sure the original author 
of include/asm-generic/dma-mapping.h knew that even when they wrote it:

static inline int
dma_supported(struct device *dev, u64 mask)
{
     BUG_ON(dev->bus != &pci_bus_type);
     return pci_dma_supported(to_pci_dev(dev), mask);
}

It's just begging to be generalized.

-- 
Hollis Blanchard
IBM Linux Technology Center

