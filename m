Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263076AbUKTDdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbUKTDdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbUKTDcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 22:32:32 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23682 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263092AbUKTDas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 22:30:48 -0500
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: brking@us.ibm.com
Cc: greg@kroah.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100917635.9398.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 20 Nov 2004 02:27:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-11-19 at 20:23, brking@us.ibm.com wrote:

> +#define PCI_READ_CONFIG(size,type)	\
> +int pci_read_config_##size	\
> +	(struct pci_dev *dev, int pos, type *val)	\
> +{									\
> +	unsigned long flags;					\
> +	int ret = 0;						\
> +	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
> +	spin_lock_irqsave(&access_lock, flags);		\
> +	if (!dev->block_cfg_access)				\
> +		ret = pci_bus_read_config_##size(dev->bus, dev->devfn, pos, val);	\
> +	else if (pos < sizeof(dev->saved_config_space))		\
> +		*val = (type)dev->saved_config_space[pos/sizeof(dev->saved_config_space[0])]; \
> +	else								\
> +		*val = -1;						\
> +	spin_unlock_irqrestore(&access_lock, flags);	\
> +	return ret;							\
> +}

Several vendors (for good or for bad) require configuration space is
touched from interrupts on fast paths. This change will _really_ hurt
random PC class machines so please make it more sensible in its
condition handling.

To start with you can do something like

	if(unlikely(dev->designed_badly)) {
		slow_spinlock_path
	}
	/* Designed less badly 8) */
	existing code path

Even better, put that code in your private debug tree. Replace the
locked cases with BUG() and fix the driver to get its internal locking
right in this situation.

It seems wrong to put expensive checks in core code paths when you could
just as easily provide

	my_device_is_stupid_pci_read_config_byte()

and equivalent lock taking functions that wrap the existing ones and are
locked against the reset path without hurting sane computing devices
(and PC's).

Alan

