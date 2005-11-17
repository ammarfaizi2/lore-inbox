Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbVKQBVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbVKQBVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030584AbVKQBU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:20:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:15330 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030583AbVKQBU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:20:59 -0500
Date: Wed, 16 Nov 2005 17:05:35 -0800
From: Greg KH <gregkh@suse.de>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: akpm@osdl.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: PCI: remove bogus resource collision error
Message-ID: <20051117010535.GA15440@suse.de>
References: <20051116170622.A10589@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116170622.A10589@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 05:06:22PM -0800, Rajesh Shah wrote:
> When attempting to hotadd a PCI card with a bridge on it, I saw
> the kernel reporting resource collision errors even when there were
> really no collisions. The problem is that the code doesn't skip
> over "invalid" resources with their resource type flag not set.
> Others have reported similar problems at boot time and for
> non-bridge PCI card hotplug too, where the code flags a
> resource collision for disabled ROMs. This patch fixes both
> problems. Please consider applying.
> 
> Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
> 
>  arch/i386/pci/i386.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.15-rc1/arch/i386/pci/i386.c
> ===================================================================
> --- linux-2.6.15-rc1.orig/arch/i386/pci/i386.c
> +++ linux-2.6.15-rc1/arch/i386/pci/i386.c
> @@ -212,6 +212,7 @@ int pcibios_enable_resources(struct pci_
>  	u16 cmd, old_cmd;
>  	int idx;
>  	struct resource *r;
> +	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
>  
>  	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>  	old_cmd = cmd;
> @@ -221,6 +222,11 @@ int pcibios_enable_resources(struct pci_
>  			continue;
>  
>  		r = &dev->resource[idx];
> +		if (!(r->flags & type_mask))
> +			continue;

Is the type_mask variable really needed here?  Can't we just test:
	if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
instead?

Other than that, looks good, thanks.

greg k-h
