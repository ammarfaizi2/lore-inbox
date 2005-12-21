Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVLUTGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVLUTGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVLUTGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:06:00 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:1712 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751193AbVLUTF7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:05:59 -0500
Date: Wed, 21 Dec 2005 12:05:58 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Mark Maule <maule@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 2/4] msi vector targeting abstractions
Message-ID: <20051221190558.GD2361@parisc-linux.org>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com> <20051221184348.5003.7540.53186@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221184348.5003.7540.53186@attica.americas.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 12:42:41PM -0600, Mark Maule wrote:
>  {
>  	struct msi_desc *entry;
> -	struct msg_address address;
> +	uint32_t address_hi, address_lo;

Don't use uint32_t.  Use u32 instead.

> @@ -108,28 +125,38 @@
>     		if (!(pos = pci_find_capability(entry->dev, PCI_CAP_ID_MSI)))
>  			return;
>  
> +		pci_read_config_dword(entry->dev, msi_upper_address_reg(pos),
> +			&address_hi);
>  		pci_read_config_dword(entry->dev, msi_lower_address_reg(pos),
> -			&address.lo_address.value);
> -		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
> -		address.lo_address.value |= (cpu_physical_id(dest_cpu) <<
> -									MSI_TARGET_CPU_SHIFT);
> -		entry->msi_attrib.current_cpu = cpu_physical_id(dest_cpu);
> +			&address_lo);
> +
> +		msi_callouts.msi_target(vector, dest_cpu,
> +					&address_hi, &address_lo);
> +
> +		pci_write_config_dword(entry->dev, msi_upper_address_reg(pos),
> +			address_hi);
>  		pci_write_config_dword(entry->dev, msi_lower_address_reg(pos),
> -			address.lo_address.value);
> +			address_lo);

But actually, I don't understand why you don't just pass a msg_address
pointer to msi_target instead.

(last two points apply throughtout this patch)

>  
> +	(*msi_callouts.msi_teardown)(vector);
> +

Yuck.  There's a reason C allows you to call through function pointers as if
they were functions.

> +int
> +msi_register_callouts(struct msi_callouts *co)
> +{
> +	msi_callouts = *co;	/* structure copy */
> +	return 0;

Why do it this way instead of having a pointer to a struct?

> -struct msg_data {
> +union msg_data {
> +	struct {

How about leaving struct msg_data alone and adding

union good_name {
	struct msg_data;
	u32 value;
}

Or possibly struct msg_data should just be deleted and we should use
shift/mask to access the contents of it.  ISTR GCC handled that much
better.
