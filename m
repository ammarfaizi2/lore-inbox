Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVBAHqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVBAHqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVBAHo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:44:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:50076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261769AbVBAHlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:41:01 -0500
Date: Mon, 31 Jan 2005 23:27:46 -0800
From: Greg KH <greg@kroah.com>
To: Brian King <brking@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <ak@muc.de>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050201072746.GA21236@kroah.com>
References: <1105626399.4664.7.camel@localhost.localdomain> <20050113180347.GB17600@muc.de> <1105641991.4664.73.camel@localhost.localdomain> <20050113202354.GA67143@muc.de> <41ED27CD.7010207@us.ibm.com> <1106161249.3341.9.camel@localhost.localdomain> <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston> <1106841228.14787.23.camel@localhost.localdomain> <41FA4DC2.4010305@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA4DC2.4010305@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 08:35:46AM -0600, Brian King wrote:
> +#define PCI_USER_READ_CONFIG(size,type)	\
> +int pci_user_read_config_##size	\
> +	(struct pci_dev *dev, int pos, type *val)	\
> +{									\
> +	unsigned long flags;					\
> +	int ret = 0;						\
> +	u32 data = -1;						\
> +	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
> +	spin_lock_irqsave(&pci_lock, flags);		\
> +	if (likely(!dev->block_ucfg_access))				\
> +		ret = dev->bus->ops->read(dev->bus, dev->devfn, pos, sizeof(type), &data); \
> +	else if (pos < sizeof(dev->saved_config_space))		\
> +		data = dev->saved_config_space[pos/sizeof(dev->saved_config_space[0])]; \
> +	spin_unlock_irqrestore(&pci_lock, flags);		\
> +	*val = (type)data;					\
> +	return ret;							\
> +}
> +
> +#define PCI_USER_WRITE_CONFIG(size,type)	\
> +int pci_user_write_config_##size	\
> +	(struct pci_dev *dev, int pos, type val)		\
> +{									\
> +	unsigned long flags;					\
> +	int ret = 0;						\
> +	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
> +	spin_lock_irqsave(&pci_lock, flags);		\
> +	if (likely(!dev->block_ucfg_access))					\
> +		ret = dev->bus->ops->write(dev->bus, dev->devfn, pos, sizeof(type), val); \
> +	spin_unlock_irqrestore(&pci_lock, flags);		\
> +	return ret;							\
> +}
> +
> +PCI_USER_READ_CONFIG(byte, u8)
> +PCI_USER_READ_CONFIG(word, u16)
> +PCI_USER_READ_CONFIG(dword, u32)
> +PCI_USER_WRITE_CONFIG(byte, u8)
> +PCI_USER_WRITE_CONFIG(word, u16)
> +PCI_USER_WRITE_CONFIG(dword, u32)

Global but not exported?  If so, they are local to the pci core, right?
And if so, please put them in the drivers/pci/pci.h file and not the
include/linux/pci.h file.


> +/**
> + * pci_block_user_cfg_access - Block userspace PCI config reads/writes
> + * @dev:	pci device struct
> + *
> + * This function blocks any userspace PCI config accesses from occurring.
> + * When blocked, any writes will return -EBUSY and reads will return the
> + * data saved using pci_save_state for the first 64 bytes of config
> + * space and return -EBUSY for all other config reads.
> + *
> + * Return value:
> + * 	nothing

We know the return value is not needed by the way the function is
defined, these two lines are unneeded.

> +void pci_block_user_cfg_access(struct pci_dev *dev)
> +{
> +	unsigned long flags;
> +
> +	pci_save_state(dev);
> +	spin_lock_irqsave(&pci_lock, flags);
> +	dev->block_ucfg_access = 1;
> +	spin_unlock_irqrestore(&pci_lock, flags);
> +}
> +EXPORT_SYMBOL(pci_block_user_cfg_access);

EXPORT_SYMBOL_GPL() please?

> +/**
> + * pci_unblock_user_cfg_access - Unblock userspace PCI config reads/writes
> + * @dev:	pci device struct
> + *
> + * This function allows userspace PCI config accesses to resume.
> + *
> + * Return value:
> + * 	nothing

Same here as above.

> +void pci_unblock_user_cfg_access(struct pci_dev *dev)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pci_lock, flags);
> +	dev->block_ucfg_access = 0;
> +	spin_unlock_irqrestore(&pci_lock, flags);
> +}
> +EXPORT_SYMBOL(pci_unblock_user_cfg_access);

Same as above.

> @@ -896,6 +904,8 @@ extern void pci_disable_msix(struct pci_
>  extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
>  #endif
>  
> +extern void pci_block_user_cfg_access(struct pci_dev *dev);
> +extern void pci_unblock_user_cfg_access(struct pci_dev *dev);
>  #endif /* CONFIG_PCI */

Don't need empty functions for these if CONFIG_PCI is not enabled?  Who
would be calling these functions, drivers?  If so, please create the
empty functions.

Also, please CC the linux-pci mailing list for pci specific patches like
this.

thanks,

greg k-h
