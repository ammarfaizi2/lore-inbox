Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754318AbWKHFo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbWKHFo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319AbWKHFo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:44:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:41622 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1754317AbWKHFo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:44:57 -0500
Subject: Re: DMA APIs gumble grumble
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       paulus@samba.org, anton@samba.org, greg@kroah.com
In-Reply-To: <20061107.212937.70218368.davem@davemloft.net>
References: <1162950877.28571.623.camel@localhost.localdomain>
	 <20061107.204653.44098205.davem@davemloft.net>
	 <1162963420.28571.700.camel@localhost.localdomain>
	 <20061107.212937.70218368.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 16:44:42 +1100
Message-Id: <1162964682.28571.715.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Then, maybe 6 month, maybe 1 year later, we can change archs that use
> > the "alternate" semantic like sparc64 to no longer fail
> > pci_set_dma_mask(64bits).
> > 
> > In fact, the only breakage here would be for those archs to have some
> > drivers start going slowly, though we could expect drivers to have been
> > fixed by then.... (And we can delay that second part of the change as
> > long as deemed necessary).
> 
> The arch implementations of pci_map_*() et al. might start
> failing since they were written assuming that DAC never got
> enabled.

True. However, as I said, we don't have to deprecate the old technique
right away, we have time to get the drivers fixed, provided we agree
that this is the way to go.

> > Yup, but you didn't fix sparc32 :-) I suppose I can try to do it and ask
> > Anton for help if things go wrong, though I can't be bothered building a
> > cross toolchain or getting a box on ebay so I'll rely on your for
> > testing :-)
> 
> I only do sparc32 build testing, which you can do on a sparc64
> box and Al Viro has great recipies for cross tool building and
> usage.

Yup, I might have a look. (Or maybe can you give accounts on a box I can
use ? That would be even easier)

> > Thus, that is 3 pointers gone for archs who don't use these, and the ability
> > to put things like your dma ops in every struct device.
> 
> How exactly does your device struct extension work?  I ask because
> struct device is embedded into other structs, such as pci_dev,
> so it has to be fixed in size unless you have some clever trick. :)

Nah, my extension is fixed, it's just that it's defined by the arch. So
archs who don't care don't get the bloat.

Right now, my implementation just hijacks firmare_data, so it's a
pointer (and thus potentially could be variable size) but I want to have
it "flat" in for performances.

My current device_ext on powerpc is:

struct device_ext {
        /* Optional pointer to an OF device node */
        struct device_node      *of_node;

        /* DMA operations on that device */
        struct dma_mapping_ops  *dma_ops;
        void                    *dma_data;

        /* NUMA node if applicable */
        int                     numa_node;
};

If we remove plaform_data and firmware_data from struct device, then the
size difference is one pointer and one int, which isn't -that- much (for
powerpc, I consider that acceptable).

The idea is just to have asm/device.h do

struct device_ext {
};

That is, define an empty struct, for all archs that don't care about it,
though I want to move the dma_cohrerent_map thingy into the extension
for the 3 archs that seem to use it (x86, frv and m32.

Cheers,
Ben


