Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVAQXxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVAQXxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbVAQXtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 18:49:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:59879 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262750AbVAQXtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 18:49:14 -0500
Date: Mon, 17 Jan 2005 15:49:08 -0800
From: Greg KH <greg@kroah.com>
To: tlnguyen@snoqualmie.dp.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: add PCI Express Port Bus Driver subsystem
Message-ID: <20050117234908.GA30356@kroah.com>
References: <20050117220107.GA28985@kroah.com> <1105999312295@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105999312295@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 02:01:52PM -0800, Greg KH wrote:
> +int pcie_port_device_register(struct pci_dev *dev)
> +{
> +	struct pcie_device *parent;
> +	int status, type, capabilities, irq_mode, i;
> +	int vectors[PCIE_PORT_DEVICE_MAXSERVICES];
> +	u16 reg16;
> +
> +	/* Get port type */
> +	pci_read_config_word(dev, 
> +		pci_find_capability(dev, PCI_CAP_ID_EXP) + 
> +		PCIE_CAPABILITIES_REG, &reg16);
> +	type = (reg16 >> 4) & PORT_TYPE_MASK;
> +
> +	/* Now get port services */
> +	capabilities = get_port_device_capability(dev);
> +	irq_mode = assign_interrupt_mode(dev, vectors, capabilities);
> +
> +	/* Allocate parent */
> +	parent = alloc_pcie_device(NULL, dev, type, 0, dev->irq, irq_mode);
> +	if (!parent) 
> +		return -ENOMEM;
> +	
> +	status = device_register(&parent->device);
> +	if (status) {
> +		kfree(parent);
> +		return status;
> +	}


This puts all of the pcie "port" structures in /sys/devices/  Shouldn't
you make the parent of the device you create point to the pci_dev
structure that's passed into this function?  That would make the sysfs
tree a lot saner I think.

thanks,

greg k-h
