Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVBAEwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVBAEwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVBAEwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:52:47 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:18891 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261546AbVBAEwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:52:36 -0500
Message-ID: <41FF0B0D.8020003@us.ibm.com>
Date: Mon, 31 Jan 2005 22:52:29 -0600
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Arnd Bergmann <arnd@arndb.de>,
       Linux Arch list <linux-arch@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: pci: Arch hook to determine config space size
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com>	 <20050131192955.GJ31145@parcelfarce.linux.theplanet.co.uk>	 <41FEA4AA.1080407@us.ibm.com> <200501312256.44692.arnd@arndb.de>	 <41FEB492.2020002@us.ibm.com> <1107227727.5963.46.camel@gaston>
In-Reply-To: <1107227727.5963.46.camel@gaston>
Content-Type: multipart/mixed;
 boundary="------------060407010206060602020901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060407010206060602020901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Mon, 2005-01-31 at 16:43 -0600, Brian King wrote:
> 
> 
>>diff -puN include/asm-ppc64/prom.h~ppc64_pcix_mode2_cfg include/asm-ppc64/prom.h
>>--- linux-2.6.11-rc2-bk9/include/asm-ppc64/prom.h~ppc64_pcix_mode2_cfg	2005-01-31 14:32:01.000000000 -0600
>>+++ linux-2.6.11-rc2-bk9-bjking1/include/asm-ppc64/prom.h	2005-01-31 14:32:01.000000000 -0600
>>@@ -137,6 +137,7 @@ struct device_node {
>> 	int	devfn;			/* for pci devices */
>> 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
>> 	int	eeh_config_addr;
>>+	int	pci_ext_config_space;	/* for phb's or bridges */
>> 	struct  pci_controller *phb;	/* for pci devices */
>> 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
> 
> 
> Grrr... more crap added to the device-node, I don't like that ...
> 
> This is a PHB only field, can't it be in struct pci_controller instead ?

Assuming I am reading the spec correctly, this is only a property of the 
PHB, so I could move it into the pci_controller struct instead.

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------060407010206060602020901
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


---

 linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/pSeries_pci.c |   31 ++++++++++-
 linux-2.6.11-rc2-bk9-bjking1/include/asm-ppc64/pci-bridge.h  |    1 
 2 files changed, 30 insertions(+), 2 deletions(-)

diff -puN arch/ppc64/kernel/pSeries_pci.c~ppc64_pcix_mode2_cfg arch/ppc64/kernel/pSeries_pci.c
--- linux-2.6.11-rc2-bk9/arch/ppc64/kernel/pSeries_pci.c~ppc64_pcix_mode2_cfg	2005-01-31 22:27:49.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/pSeries_pci.c	2005-01-31 22:31:04.000000000 -0600
@@ -52,6 +52,16 @@ static int s7a_workaround;
 
 extern struct mpic *pSeries_mpic;
 
+static int config_access_valid(struct device_node *dn, int where)
+{
+	if (where < 256)
+		return 1;
+	if (where < 4096 && dn->phb->pci_ext_config_space)
+		return 1;
+
+	return 0;
+}
+
 static int rtas_read_config(struct device_node *dn, int where, int size, u32 *val)
 {
 	int returnval = -1;
@@ -62,8 +72,11 @@ static int rtas_read_config(struct devic
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
@@ -110,8 +123,11 @@ static int rtas_write_config(struct devi
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
@@ -270,6 +286,16 @@ static int phb_set_bus_ranges(struct dev
 	return 0;
 }
 
+static char __devinit get_phb_config_space_type(struct pci_controller *phb)
+{
+	int *type = (int *)get_property(phb->arch_data,
+					"ibm,pci-config-space-type", NULL);
+
+	if (type && *type == 1)
+		return 1;
+	return 0;
+}
+
 static int __devinit setup_phb(struct device_node *dev,
 			       struct pci_controller *phb,
 			       unsigned int addr_size_words)
@@ -285,6 +311,7 @@ static int __devinit setup_phb(struct de
 	phb->arch_data = dev;
 	phb->ops = &rtas_pci_ops;
 	phb->buid = get_phb_buid(dev);
+	phb->pci_ext_config_space = get_phb_config_space_type(phb);
 
 	return 0;
 }
diff -puN include/asm-ppc64/pci-bridge.h~ppc64_pcix_mode2_cfg include/asm-ppc64/pci-bridge.h
--- linux-2.6.11-rc2-bk9/include/asm-ppc64/pci-bridge.h~ppc64_pcix_mode2_cfg	2005-01-31 22:27:49.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/include/asm-ppc64/pci-bridge.h	2005-01-31 22:27:49.000000000 -0600
@@ -17,6 +17,7 @@
 struct pci_controller {
 	struct pci_bus *bus;
 	char is_dynamic;
+	char pci_ext_config_space;
 	void *arch_data;
 	struct list_head list_node;
 

_

--------------060407010206060602020901--

