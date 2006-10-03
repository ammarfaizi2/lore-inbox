Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030578AbWJCVzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbWJCVzD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030582AbWJCVzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:55:01 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:30906 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030578AbWJCVzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:55:00 -0400
Subject: Re: [RFC/PATCH 3/7] Powerpc MSI ops layer
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20060928215339.D911C67BFA@ozlabs.org>
References: <20060928215339.D911C67BFA@ozlabs.org>
Content-Type: text/plain
Organization: IBM
Date: Tue, 03 Oct 2006 16:54:52 -0500
Message-Id: <1159912492.4997.257.camel@goblue>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 07:53 +1000, Michael Ellerman wrote:
> Powerpc MSI ops layer.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
>  arch/powerpc/kernel/msi.c        |  347 +++++++++++++++++++++++++++++++++++++++
>  include/asm-powerpc/machdep.h    |    6 
>  include/asm-powerpc/msi.h        |  175 +++++++++++++++++++
>  include/asm-powerpc/pci-bridge.h |    4 
>  4 files changed, 532 insertions(+)
> 
> Index: to-merge/arch/powerpc/kernel/msi.c
> ===================================================================
> --- /dev/null
> +++ to-merge/arch/powerpc/kernel/msi.c
> @@ -0,0 +1,347 @@
> +/*
> + * Copyright 2006 (C), Michael Ellerman, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#undef DEBUG
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <asm/msi.h>
> +#include <asm/machdep.h>
> +
> +static struct ppc_msi_ops *get_msi_ops(struct pci_dev *pdev)
> +{
> +	if (ppc_md.get_msi_ops)
> +		return ppc_md.get_msi_ops(pdev);
> +	return NULL;
> +}
> +
> +/* Activated by pci=nomsi on the command line. */
> +static int no_msi;
> +
> +void pci_no_msi(void)
> +{
> +	no_msi = 1;
> +}
> +
> +
> +/* msi_info helpers */
> +
> +static struct pci_dn *get_pdn(struct pci_dev *pdev)
> +{
> +	struct device_node *dn;
> +	struct pci_dn *pdn;
> +
> +	dn = pci_device_to_OF_node(pdev);
> +	if (!dn) {
> +		pr_debug("get_pdn: no dn found for %s\n", pci_name(pdev));
> +		return NULL;
> +	}
> +
> +	pdn = PCI_DN(dn);
> +	if (!pdn) {
> +		pr_debug("get_pdn: no pci_dn found for %s\n", pci_name(pdev));
> +		return NULL;
> +	}
> +
> +	return pdn;
> +}
> +
> +static int alloc_msi_info(struct pci_dev *pdev, int num,
> +			struct msix_entry *entries, int type)
> +{
> +	struct msi_info *info;
> +	unsigned int entries_size;
> +	struct pci_dn *pdn;
> +
> +	entries_size = sizeof(struct msix_entry) * num;
> +
> +	info = kzalloc(sizeof(struct msi_info) + entries_size, GFP_KERNEL);

Shouldn't you do a second kzalloc for info->entries, and not just add on
the size to the end?

> +	if (!info) {
> +		pr_debug("alloc_msi_info: kzalloc failed for %s\n",
> +				pci_name(pdev));
> +		return -ENOMEM;
> +	}
> +
> +	info->type = type;
> +	info->num = num;
> +	memcpy(info->entries, entries, entries_size);
> +
> +	pdn = get_pdn(pdev);
> +	if (!pdn || pdn->msi_info)	/* don't leak info structs */
> +		BUG();
> +
> +	pdn->msi_info = info;
> +
> +	return 0;
> +}
> +

