Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVBAPoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVBAPoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVBAPoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:44:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11708 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262049AbVBAPoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:44:07 -0500
Date: Tue, 1 Feb 2005 15:44:00 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Brian King <brking@us.ibm.com>
Cc: Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
References: <1105641991.4664.73.camel@localhost.localdomain> <20050113202354.GA67143@muc.de> <41ED27CD.7010207@us.ibm.com> <1106161249.3341.9.camel@localhost.localdomain> <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston> <1106841228.14787.23.camel@localhost.localdomain> <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com> <41FF9C78.2040100@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FF9C78.2040100@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 09:12:56AM -0600, Brian King wrote:
> Greg KH wrote:
> >On Fri, Jan 28, 2005 at 08:35:46AM -0600, Brian King wrote:
> >>+void pci_block_user_cfg_access(struct pci_dev *dev)
> >>+{
> >>+	unsigned long flags;
> >>+
> >>+	pci_save_state(dev);
> >>+	spin_lock_irqsave(&pci_lock, flags);
> >>+	dev->block_ucfg_access = 1;
> >>+	spin_unlock_irqrestore(&pci_lock, flags);
> >>+}
> >>+EXPORT_SYMBOL(pci_block_user_cfg_access);
> >
> >
> >EXPORT_SYMBOL_GPL() please?
> 
> Ok.

I'm not entirely convinced these should be GPL-only exports.  Basically,
this is saying that any driver for a device that has this problem must be
GPLd.  I think that's a firmer stance than Linus had in mind originally.

> +++ linux-2.6.11-rc2-bk9-bjking1/drivers/pci/access.c	2005-02-01 08:39:57.000000000 -0600
> @@ -60,3 +60,78 @@ EXPORT_SYMBOL(pci_bus_read_config_dword)
>  EXPORT_SYMBOL(pci_bus_write_config_byte);
>  EXPORT_SYMBOL(pci_bus_write_config_word);
>  EXPORT_SYMBOL(pci_bus_write_config_dword);
> +
> +#define PCI_USER_READ_CONFIG(size,type)	\
> +int pci_user_read_config_##size	\
> +	(struct pci_dev *dev, int pos, type *val)	\
{									\
	unsigned long flags;					\

Could you line up the \ so they're uniform like the above PCI_OP_READ?

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

Does this actually work?  Surely if you're reading byte 14, you get the
byte that was at address 12 or 15 in the config space, depending whether
you're on a big or little endian machine?

> +void pci_unblock_user_cfg_access(struct pci_dev *dev)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pci_lock, flags);
> +	dev->block_ucfg_access = 0;
> +	spin_unlock_irqrestore(&pci_lock, flags);
> +}

If we've done a write to config space while the adapter was blocked,
shouldn't we replay those accesses at this point?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
