Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264722AbUEXWWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbUEXWWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUEXWWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:22:25 -0400
Received: from zero.aec.at ([193.170.194.10]:37637 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264722AbUEXWWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:22:13 -0400
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       marcelo.tosatti@cyclades.com
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
References: <1ZuS0-1b4-15@gated-at.bofh.it> <1ZuS3-1b4-35@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 25 May 2004 00:21:59 +0200
In-Reply-To: <1ZuS3-1b4-35@gated-at.bofh.it> (Greg KH's message of "Mon, 24
 May 2004 23:10:15 +0200")
Message-ID: <m3brkdcvp4.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
>  obj-y			+= pci-pc.o pci-irq.o
> diff -Nru a/arch/x86_64/kernel/mmconfig.c b/arch/x86_64/kernel/mmconfig.c
> --- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/arch/x86_64/kernel/mmconfig.c	Mon May 24 13:52:10 2004


> +static inline void pci_exp_set_dev_base(int bus, int devfn)
> +{
> +	u32 dev_base = pci_mmcfg_base_addr | (bus << 20) | (devfn << 12);
> +	if (dev_base != mmcfg_last_accessed_device) {
> +		mmcfg_last_accessed_device = dev_base;
> +		set_fixmap(FIX_PCIE_MCFG, dev_base);
> +	}

Please no dynamic fixmap crap on x86-64. Do it like 2.6 does  - ioremap()
the complete mmconfig aperture once and just just reference it directly.

Then you can also get rid of the spinlocks in the actual access functions,
since everything will be stateless.

-Andi

