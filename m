Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVAaWoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVAaWoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVAaWoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:44:09 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:57501 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261416AbVAaWnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:43:35 -0500
Message-ID: <41FEB492.2020002@us.ibm.com>
Date: Mon, 31 Jan 2005 16:43:30 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-arch@vger.kernel.org, paulus@samba.org
Subject: Re: pci: Arch hook to determine config space size
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <20050131192955.GJ31145@parcelfarce.linux.theplanet.co.uk> <41FEA4AA.1080407@us.ibm.com> <200501312256.44692.arnd@arndb.de>
In-Reply-To: <200501312256.44692.arnd@arndb.de>
Content-Type: multipart/mixed;
 boundary="------------060901080504060202030400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060901080504060202030400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Arnd Bergmann wrote:
> On Maandag 31 Januar 2005 22:35, Brian King wrote:
> 
>>Matthew Wilcox wrote:
>>
>>>Basically, ppc64's config ops are broken and need to check the offset
>>>being read.  Here's i386:
>>>
>>>static int pci_conf1_write (int seg, int bus, int devfn, int reg, int len, u32 v
>>>alue)
>>>{
>>>        unsigned long flags;
>>>
>>>        if ((bus > 255) || (devfn > 255) || (reg > 255)) 
>>>                return -EINVAL;
>>
>>Here is a pure ppc64 implementation that does this.
> 
> 
> Actually, it doesn't:
> 
> 
>>+static int config_access_valid(struct device_node *dn, int where)
>>+{
>>+       struct device_node *hose_dn = dn->phb->arch_data;
>>+
>>+       if (where < 256 || hose_dn->pci_ext_config_space)
>>+               return 1;
> 
> 
> This needs a check for (where < 4096) in case of PCIe or PCI-X.

Done.

>>@@ -62,6 +72,8 @@ static int rtas_read_config(struct devic
>>                return PCIBIOS_DEVICE_NOT_FOUND;
>>        if (where & (size - 1))
>>                return PCIBIOS_BAD_REGISTER_NUMBER;
>>+       if (!config_access_valid(dn, where))
>>+               return PCIBIOS_BAD_REGISTER_NUMBER;
>> 
>>        addr = (dn->busno << 16) | (dn->devfn << 8) | where;
> 
> 
> addr is still wrong, see my previous mail.

Fixed.


>>@@ -285,6 +309,7 @@ static int __devinit setup_phb(struct de
>>        phb->arch_data = dev;
>>        phb->ops = &rtas_pci_ops;
>>        phb->buid = get_phb_buid(dev);
>>+       get_phb_config_space_type(dev);
>> 
>>        return 0;
>> }
> 
> 
> Isn't the config space size a property of the PCI device instead of the
> host bridge? For a PCI device behind a PCIe host bridge, this could
> still lead to an incorrect config space accesses.

It is a property of both. Accessing config space beyond the first 256 
bytes will only work if both the PCI device and the host bridge support 
it. The problem I ran into was generic pci code issuing a config read to 
offset 256 after checking that the device supports it when the host 
bridge did not support it.

> PS: I got a permanent fatal error from <linux-pci@vger.kernel.org>, does
> that list actually exist?

Sorry about that... Should be fixed on this thread now. I checked the 
archives and saw a thread related to adding another L: line to the 
MAINTAINERS file for the linux-pci list. Greg - was some flavor of that 
patch going in?

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------060901080504060202030400
Content-Type: text/plain;
 name="ppc64_pcix_mode2_cfg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64_pcix_mode2_cfg.patch"



When working with a PCI-X Mode 2 adapter on a PCI-X Mode 1 PPC64
system, the current code used to determine the config space size
of a device results in a PCI Master abort and an EEH error, resulting
in the device being taken offline. This patch checks OF to see if
the PCI bridge supports PCI-X Mode 2 and fails config accesses beyond
256 bytes if it does not.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/pSeries_pci.c |   33 ++++++++++-
 linux-2.6.11-rc2-bk9-bjking1/include/asm-ppc64/prom.h        |    1 
 2 files changed, 32 insertions(+), 2 deletions(-)

diff -puN arch/ppc64/kernel/pSeries_pci.c~ppc64_pcix_mode2_cfg arch/ppc64/kernel/pSeries_pci.c
--- linux-2.6.11-rc2-bk9/arch/ppc64/kernel/pSeries_pci.c~ppc64_pcix_mode2_cfg	2005-01-31 14:32:01.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/pSeries_pci.c	2005-01-31 16:17:08.000000000 -0600
@@ -52,6 +52,18 @@ static int s7a_workaround;
 
 extern struct mpic *pSeries_mpic;
 
+static int config_access_valid(struct device_node *dn, int where)
+{
+	struct device_node *hose_dn = dn->phb->arch_data;
+
+	if (where < 256)
+		return 1;
+	if (where < 4096 && hose_dn->pci_ext_config_space)
+		return 1;
+
+	return 0;
+}
+
 static int rtas_read_config(struct device_node *dn, int where, int size, u32 *val)
 {
 	int returnval = -1;
@@ -62,8 +74,11 @@ static int rtas_read_config(struct devic
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	if (where & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
+	if (!config_access_valid(dn, where))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
+	addr = ((where & 0xf00) << 20) | (dn->busno << 16) |
+		(dn->devfn << 8) | (where & 0xff);
 	buid = dn->phb->buid;
 	if (buid) {
 		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
@@ -110,8 +125,11 @@ static int rtas_write_config(struct devi
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	if (where & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
+	if (!config_access_valid(dn, where))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
+	addr = ((where & 0xf00) << 20) | (dn->busno << 16) |
+		(dn->devfn << 8) | (where & 0xff);
 	buid = dn->phb->buid;
 	if (buid) {
 		ret = rtas_call(ibm_write_pci_config, 5, 1, NULL, addr, buid >> 32, buid & 0xffffffff, size, (ulong) val);
@@ -270,6 +288,16 @@ static int phb_set_bus_ranges(struct dev
 	return 0;
 }
 
+static void __devinit get_phb_config_space_type(struct device_node *dn)
+{
+	int *type = (int *)get_property(dn, "ibm,pci-config-space-type", NULL);
+
+	if (type && *type == 1)
+		dn->pci_ext_config_space = 1;
+	else
+		dn->pci_ext_config_space = 0;
+}
+
 static int __devinit setup_phb(struct device_node *dev,
 			       struct pci_controller *phb,
 			       unsigned int addr_size_words)
@@ -285,6 +313,7 @@ static int __devinit setup_phb(struct de
 	phb->arch_data = dev;
 	phb->ops = &rtas_pci_ops;
 	phb->buid = get_phb_buid(dev);
+	get_phb_config_space_type(dev);
 
 	return 0;
 }
diff -puN include/asm-ppc64/prom.h~ppc64_pcix_mode2_cfg include/asm-ppc64/prom.h
--- linux-2.6.11-rc2-bk9/include/asm-ppc64/prom.h~ppc64_pcix_mode2_cfg	2005-01-31 14:32:01.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/include/asm-ppc64/prom.h	2005-01-31 14:32:01.000000000 -0600
@@ -137,6 +137,7 @@ struct device_node {
 	int	devfn;			/* for pci devices */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
+	int	pci_ext_config_space;	/* for phb's or bridges */
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
 
_

--------------060901080504060202030400--
