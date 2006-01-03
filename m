Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWACWje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWACWje (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWACWje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:39:34 -0500
Received: from palrel10.hp.com ([156.153.255.245]:27569 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932537AbWACWjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:39:20 -0500
Date: Tue, 3 Jan 2006 14:39:18 -0800
From: Grant Grundler <iod00d@hp.com>
To: Mark Maule <maule@sgi.com>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>, gregkh@suse.de
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20060103223918.GB13841@esmail.cup.hp.com>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222201657.2019.69251.48815@lnx-maule.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222201657.2019.69251.48815@lnx-maule.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 02:15:49PM -0600, Mark Maule wrote:
> Abstract portions of the MSI core for platforms that do not use standard
> APIC interrupt controllers.  This is implemented through a new arch-specific
> msi setup routine, and a set of msi ops which can be set on a per platform
> basis.

...
> +
> +		msi_ops->target(vector, dest_cpu, &address_hi, &address_lo);
> +
> +		pci_write_config_dword(entry->dev, msi_upper_address_reg(pos),
> +			address_hi);
>  		pci_write_config_dword(entry->dev, msi_lower_address_reg(pos),
> -			address.lo_address.value);
> +			address_lo);
>  		set_native_irq_info(irq, cpu_mask);
>  		break;
>  	}
...
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ msi/drivers/pci/msi-apic.c	2005-12-22 11:09:37.022232088 -0600
...
> +struct msi_ops msi_apic_ops = {
> +	.setup = msi_setup_apic,
> +	.teardown = msi_teardown_apic,
> +#ifdef CONFIG_SMP
> +	.target = msi_target_apic,
> +#endif

Mark,
msi_target_apic() initializes address_lo parameter.
Even on a UP machine, we need inialize this value.

If target is called unconditionally, wouldn't it be better
for msi_target_apic() always be called?

It would also be good for msi_target_apic to validate the 'dest_cpu' is online.
Maybe a BUG_ON or something like that.

grant

ps. not done looking through this...and still curious to see where
    other discussion about generic vector assignment leads.
