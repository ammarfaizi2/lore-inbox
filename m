Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVBARfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVBARfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVBARfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:35:20 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:38049 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262077AbVBARfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:35:08 -0500
Message-ID: <41FFBDC9.2010206@us.ibm.com>
Date: Tue, 01 Feb 2005 11:35:05 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
References: <1105641991.4664.73.camel@localhost.localdomain> <20050113202354.GA67143@muc.de> <41ED27CD.7010207@us.ibm.com> <1106161249.3341.9.camel@localhost.localdomain> <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston> <1106841228.14787.23.camel@localhost.localdomain> <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com> <41FF9C78.2040100@us.ibm.com> <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
  >>+++ linux-2.6.11-rc2-bk9-bjking1/drivers/pci/access.c	2005-02-01 
08:39:57.000000000 -0600
>>@@ -60,3 +60,78 @@ EXPORT_SYMBOL(pci_bus_read_config_dword)
>> EXPORT_SYMBOL(pci_bus_write_config_byte);
>> EXPORT_SYMBOL(pci_bus_write_config_word);
>> EXPORT_SYMBOL(pci_bus_write_config_dword);
>>+
>>+#define PCI_USER_READ_CONFIG(size,type)	\
>>+int pci_user_read_config_##size	\
>>+	(struct pci_dev *dev, int pos, type *val)	\
> 
> {									\
> 	unsigned long flags;					\
> 
> Could you line up the \ so they're uniform like the above PCI_OP_READ?

Ok.

>>+	int ret = 0;						\
>>+	u32 data = -1;						\
>>+	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
>>+	spin_lock_irqsave(&pci_lock, flags);		\
>>+	if (likely(!dev->block_ucfg_access))				\
>>+		ret = dev->bus->ops->read(dev->bus, dev->devfn, pos, sizeof(type), &data); \
>>+	else if (pos < sizeof(dev->saved_config_space))		\
>>+		data = dev->saved_config_space[pos/sizeof(dev->saved_config_space[0])]; \
>>+	spin_unlock_irqrestore(&pci_lock, flags);		\
>>+	*val = (type)data;					\
> 
> 
> Does this actually work?  Surely if you're reading byte 14, you get the
> byte that was at address 12 or 15 in the config space, depending whether
> you're on a big or little endian machine?

It actually only works for 4 byte accesses. I am fixing this and will be 
posting a patch later.

>>+void pci_unblock_user_cfg_access(struct pci_dev *dev)
>>+{
>>+	unsigned long flags;
>>+
>>+	spin_lock_irqsave(&pci_lock, flags);
>>+	dev->block_ucfg_access = 0;
>>+	spin_unlock_irqrestore(&pci_lock, flags);
>>+}
> 
> 
> If we've done a write to config space while the adapter was blocked,
> shouldn't we replay those accesses at this point?

I did not think that was necessary. It will certainly make the patch 
more complicated. To implement it would really require we make the 
userspace writers wait, which gets ugly since the wait is based on a 
flag that can be updated at interrupt level so you end up with some fun 
spinlocking. Not a big deal, it just starts getting ugly. Keep in mind, 
one of the potential uses of this is for power management on PPC where a 
given device could have its config space blocked for a long time.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
