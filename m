Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130389AbQJLJAU>; Thu, 12 Oct 2000 05:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S130317AbQJLJAL>; Thu, 12 Oct 2000 05:00:11 -0400
Received: from astrid2.nic.fr ([192.134.4.2]:46353 "EHLO astrid2.nic.fr") by vger.kernel.org with ESMTP id <S129131AbQJLI77>; Thu, 12 Oct 2000 04:59:59 -0400
Date: Thu, 12 Oct 2000 10:52:00 +0000
From: Francois romieu <romieu@ensta.fr>
To: linux-kernel@vger.kernel.org
Cc: aprasad@in.ibm.com
Subject: Re: ioremap of pci base addresses
Message-ID: <20001012105200.A28642@nic.fr>
Reply-To: Francois romieu <romieu@ensta.fr>
References: <CA256976.001F00B2.00@d73mta05.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <CA256976.001F00B2.00@d73mta05.au.ibm.com>
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Thu, Oct 12, 2000 at 11:02:50AM +0530, aprasad@in.ibm.com wrote :
> once i have got the pci_dev structure( by calling pci_find*), do i
> explicitly need to call ioremap for remapping mmio.
> i think pci_enable_device does this. correct me if i am wrong..

ioremap does not only remap mmio but returns a token that should be
used if you want to further access the mmapped area (readl(token) and
writel(some_data, token) for example).

Part of 'foo' code could look like this :

static struct pci_driver foo_driver = {
        name:           "foo",
        id_table:       foo_pci_tbl,
        probe:          foo_init_one,
        remove:         foo_remove_one,
};

static int __init foo_init_one (struct pci_dev *pdev, 
				struct pci_device_id *ent)
{
	u32 token;

	if (pci_enable_device(pdev))
		goto err_out;

	/* 
	 * Some area (non pci-configuration registers or other) one wants to 
	 * mmap. Ask 'foo' manual for the description of the Base Address 
	 * Register in foo's pci configuration space.
	 */
	if (!request_mem_region(pci_resource_start(pdev, 0), 
				pci_resource_len(pdev, 0), "mmaped registers")) {
		printk(KERN_ERR "foo: can't reserve MMIO region\n");
		goto err_out;
	}
	token =  = (unsigned long)ioremap(pci_resource_start(pdev, 0),
					  pci_resource_len(pdev, 0));

	/* 
	 * The following will happen if one forgets to balance ioremap
	 * and iounmap at insmod/rmmod time for example.
	 */
	if (!token) {
		printk(KERN_ERR "foo: cannot remap MMIO region %lx @ %lx\n",
		       pci_resource_len(pdev, 0), pci_resource_start(pdev, 0));
		goto err_out_free_mmio_region;
	}

	[more stuff that may fail and should go at least to label err_out_iounmap]

	return 0;

err_out_iounmap: 
	iounmap ((void *)token);
err_out_free_mmio_region:
	release_mem_region(pci_resource_start(pdev, 0), 
			   pci_resource_len(pdev, 0));
err_out:
	return -ENODEV;
}

static void foo_remove_one (struct pci_dev *pdev)
{
	[some stuff]

	iounmap((void *)some_safe_structure->token);

	[kfree may appear...]

	release_mem_region(pci_resource_start(pdev, 0),
			   pci_resource_len(pdev, 0));
}

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
