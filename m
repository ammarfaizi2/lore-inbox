Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVJDNS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVJDNS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVJDNS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:18:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37313 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932444AbVJDNS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:18:26 -0400
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] AMD Geode GX/LX support
References: <20051003180200.GH29264@cosmic.amd.com>
From: Andi Kleen <ak@suse.de>
Date: 04 Oct 2005 15:18:23 +0200
In-Reply-To: <20051003180200.GH29264@cosmic.amd.com>
Message-ID: <p737jct1kv4.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jordan Crouse" <jordan.crouse@amd.com> writes:

> This patch adds support for the hardware RNG device on the Geode LX
> processor.  As a side note, the LX processor also includes a hardware

Interesting. Wish the mainstream AMD K8 CPUs had one too :)

> AES encryption engine, support for which is not included here because
> I'm not one to increase the kernel source size if it doesn't need to be.

If it's faster than the i386 assembly version I think you
should add it.

> +#ifdef CONFIG_MGEODE_LX
> +static int __init geode_init(struct pci_dev *dev);
> +static void geode_cleanup(void);
> +static unsigned int geode_data_present (void);
> +static u32 geode_data_read (void);
> +#endif

Declarations don't need ifdefs.

> +static u32 geode_data_read(void) {
> +	u32 val;
> +
> +	val = *((u32 *) (geode_rng_base + GEODE_RNG_DATA_REG));

This should use readl

> +	return val;
> +}
> +
> +static unsigned int geode_data_present(void) {

The bracket should be on an own line. Further occurrences.


> +}
> +
> +static int geode_init(struct pci_dev *dev) {
> +	u32 rng_base = pci_resource_start(dev, 0);

This should be unsigned long

> +	if (!rng_base) return 1;
> +
> +	geode_rng_base = ioremap(rng_base, 0x58);

This should be ioremap_nocache() 

> +
> +	if (geode_rng_base == NULL) {
> +		printk(KERN_ERR PFX "Cannot ioremap RNG memory\n");
> +		return -EBUSY;
> +	}
> +
> +	printk(KERN_INFO PFX "Geode RNG registers at %p\n", geode_rng_base);

I would advise to not print virtual addresses into the kernel log.
They are usually completely useless to the user. Either physical
or nothing.


-Andi
