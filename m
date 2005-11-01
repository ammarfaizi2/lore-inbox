Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVKAAHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVKAAHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVKAAHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:07:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:48023 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964907AbVKAAHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:07:22 -0500
Subject: Re: [PATCH] tpm: support PPC64 hardware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, moilanen@austin.ibm.com
In-Reply-To: <1130769479.4882.35.camel@localhost.localdomain>
References: <1130769479.4882.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 11:05:08 +1100
Message-Id: <1130803508.29054.388.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 08:37 -0600, Kylene Jo Hall wrote:
> The TPM is discovered differently on PPC64 because the device must be
> discovered through the device tree in order to open the proper holes in
> the io_page_mask for reading and writing in the low memory space.  This
> does not happen automatically like most devices because the tpm is not a
> normal pci device and lives under the root node.
> 
> This patch contains the necessary changes to the tpm logic.
> 
> This depends on patches submitted by Jake Moilanen (10/28) to allow for
> the opening of holes in the io_page_mask for this device.

Please submit to the appropriate list (linuxppc64-dev@ozlabs.org). There
are some issues with that patch. One, I intend to get rid of the
io_page_mask, so that part at least is gone. I don't like the exporting
of io_base_phys neither, it's an ugly hack.

Other comments inline.

> +/* Verify this is a 1.1 Atmel TPM */
> +static int atmel_verify_tpm11(void)
> +{
> +	struct device_node * dn;
> +	char *compat;
> +	int compat_len;
> +
> +	dn = find_devices("tpm");

find_devices() is a deprecated interface. Use the of_find_node_* series
and do an of_node_put() once done.

> +	if (!dn)
> +		return 1;
> +
> +	compat = (char *) get_property(dn, "compatible", &compat_len);
> +	if (!compat)
> +		return 1;
> +
> +	if ( strcmp( compat,"AT97SC3201_r") == 0 )
> +		return 0;
> +

Testing the "compatible" property this way is bogus. Use
device_is_compatible(). Or better, use of_find_compatible_node() which
allows you to find by type & compatible in one step.


> +	dn = find_devices("tpm");

Same comment as above. In addition, why do you have to do it twice ? You
should rethink your changes. Only one "probe" should be needed that
retreives the base addresses.

> +	if (!dn)
> +		return 0;
> +
> +	reg = (unsigned int *) get_property(dn, "reg", &reglen);
> +	naddrc = prom_n_addr_cells(dn);
> +	nsizec = prom_n_size_cells(dn);
> +
> +	for (i = 0; i < reglen; i = i + naddrc + nsizec) {
> +
> +		if (naddrc == 2)
> +			address = ((unsigned long)reg[i] << 32) | reg[i+1];
> +		else
> +			address = reg[i];
> +
> +		address = address - pci_io_base_phys;

That is bogosity. Your address is an ISA IO address, It should be
relative to the parent LPC bus and thus useable as is. It looks like the
firmware folks crapped the device-tree. Please check that with them.

If they decide to stick with a broken device-tree, then you'll have to
consider the address as an MMIO address. That mean you'll have to change
the IO accesses of the TPM driver to use the iomap API thus making it
immune of IO cs. MMIO distinction.

> +		allow_isa_address(address, address+size-1);

That is going away.

Ben.


