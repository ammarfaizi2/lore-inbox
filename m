Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTLPRoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTLPRoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:44:25 -0500
Received: from zero.aec.at ([193.170.194.10]:55310 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261957AbTLPRoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:44:24 -0500
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
From: Andi Kleen <ak@muc.de>
Date: Tue, 16 Dec 2003 18:44:14 +0100
In-Reply-To: <13kD2-1kF-11@gated-at.bofh.it> (Vladimir Kondratiev's message
 of "Tue, 16 Dec 2003 11:30:20 +0100")
Message-ID: <m37k0wves1.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <12KJ6-4F2-13@gated-at.bofh.it> <12Lvu-5X5-5@gated-at.bofh.it>
	<12XQ2-7Vs-9@gated-at.bofh.it> <12YsA-nt-1@gated-at.bofh.it>
	<130kQ-3A0-13@gated-at.bofh.it> <130Xy-4Ia-3@gated-at.bofh.it>
	<131Ac-5Qy-3@gated-at.bofh.it> <137cD-8eg-9@gated-at.bofh.it>
	<13kD2-1kF-11@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev <vladimir.kondratiev@intel.com> writes:


>  #define PCI_PROBE_CONF1		0x0002
>  #define PCI_PROBE_CONF2		0x0004
> +
> +#ifdef CONFIG_PCI_EXPRESS
> +#define PCI_PROBE_EXP		0x0008
> +#endif

Drop the #ifdef here.

> +#ifdef CONFIG_PCI_EXPRESS
> +#include <asm/fixmap.h>
> +#endif

Same here.


> +static inline void pci_exp_set_dev_base(int bus, int dev, int fn)
> +{
> +	u32 dev_base = (bus << 20) | (dev << 15) | (fn << 12);
> +	if (dev_base != pcie_last_accessed_device) {
> +		pcie_last_accessed_device = dev_base;
> +		set_fixmap_nocache(FIX_PCIE_CONFIG, rrbar_phys | dev_base);
> +	}

When you use one fix map per CPU you can avoid the lock. All that would
be needed would be a local_irq_disable()/enable() then. While normally
config space accesses should not be performance critical sometimes
they are done frequently to work around hardware bugs.

I still think it would be better to cache mappings and use a hash table
though ...

-Andi
