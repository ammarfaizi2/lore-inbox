Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVBAURo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVBAURo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 15:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVBAURe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 15:17:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:17098 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261532AbVBAUQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 15:16:52 -0500
Message-ID: <41FFE3AF.706@us.ibm.com>
Date: Tue, 01 Feb 2005 14:16:47 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arnd Bergmann <arnd@arndb.de>,
       Linux Arch list <linux-arch@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: pci: Arch hook to determine config space size
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <20050131192955.GJ31145@parcelfarce.linux.theplanet.co.uk> <41FEA4AA.1080407@us.ibm.com> <200501312256.44692.arnd@arndb.de> <41FEB492.2020002@us.ibm.com> <1107227727.5963.46.camel@gaston> <41FF0B0D.8020003@us.ibm.com> <20050201123249.GA10088@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050201123249.GA10088@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/mixed;
 boundary="------------090002040102030904070100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090002040102030904070100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Wilcox wrote:
> On Mon, Jan 31, 2005 at 10:52:29PM -0600, Brian King wrote:
> 
>>@@ -62,8 +72,11 @@ static int rtas_read_config(struct devic
>> 		return PCIBIOS_DEVICE_NOT_FOUND;
>> 	if (where & (size - 1))
>> 		return PCIBIOS_BAD_REGISTER_NUMBER;
> 
> 
> You should probably delete this redundant test at the same time ...

Done. The new patch below also adds some address checking to iSeries 
config accessor functions. Additionally, this patch should address 
Arnd's concern, as it now looks for the "ibm,pci-config-space-type" 
property on the device itself rather than on the bridge.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------090002040102030904070100
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

 linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/iSeries_pci.c |    6 +++
 linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/pSeries_pci.c |   20 ++++++++---
 linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/pci_dn.c      |    6 +++
 linux-2.6.11-rc2-bk9-bjking1/include/asm-ppc64/prom.h        |    1 
 4 files changed, 29 insertions(+), 4 deletions(-)

diff -puN arch/ppc64/kernel/pSeries_pci.c~ppc64_pcix_mode2_cfg arch/ppc64/kernel/pSeries_pci.c
--- linux-2.6.11-rc2-bk9/arch/ppc64/kernel/pSeries_pci.c~ppc64_pcix_mode2_cfg	2005-02-01 13:31:46.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/pSeries_pci.c	2005-02-01 13:39:32.000000000 -0600
@@ -52,6 +52,16 @@ static int s7a_workaround;
 
 extern struct mpic *pSeries_mpic;
 
+static int config_access_valid(struct device_node *dn, int where)
+{
+	if (where < 256)
+		return 1;
+	if (where < 4096 && dn->pci_ext_config_space)
+		return 1;
+
+	return 0;
+}
+
 static int rtas_read_config(struct device_node *dn, int where, int size, u32 *val)
 {
 	int returnval = -1;
@@ -60,10 +70,11 @@ static int rtas_read_config(struct devic
 
 	if (!dn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (where & (size - 1))
+	if (!config_access_valid(dn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
+	addr = ((where & 0xf00) << 20) | (dn->busno << 16) |
+		(dn->devfn << 8) | (where & 0xff);
 	buid = dn->phb->buid;
 	if (buid) {
 		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
@@ -108,10 +119,11 @@ static int rtas_write_config(struct devi
 
 	if (!dn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (where & (size - 1))
+	if (!config_access_valid(dn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
+	addr = ((where & 0xf00) << 20) | (dn->busno << 16) |
+		(dn->devfn << 8) | (where & 0xff);
 	buid = dn->phb->buid;
 	if (buid) {
 		ret = rtas_call(ibm_write_pci_config, 5, 1, NULL, addr, buid >> 32, buid & 0xffffffff, size, (ulong) val);
diff -puN include/asm-ppc64/prom.h~ppc64_pcix_mode2_cfg include/asm-ppc64/prom.h
--- linux-2.6.11-rc2-bk9/include/asm-ppc64/prom.h~ppc64_pcix_mode2_cfg	2005-02-01 13:31:46.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/include/asm-ppc64/prom.h	2005-02-01 13:31:46.000000000 -0600
@@ -137,6 +137,7 @@ struct device_node {
 	int	devfn;			/* for pci devices */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
+	int	pci_ext_config_space;	/* for pci devices */
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
 
diff -puN arch/ppc64/kernel/pci_dn.c~ppc64_pcix_mode2_cfg arch/ppc64/kernel/pci_dn.c
--- linux-2.6.11-rc2-bk9/arch/ppc64/kernel/pci_dn.c~ppc64_pcix_mode2_cfg	2005-02-01 13:31:46.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/pci_dn.c	2005-02-01 13:31:46.000000000 -0600
@@ -37,6 +37,7 @@
 static void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
 {
 	struct pci_controller *phb = data;
+	int *type = (int *)get_property(dn, "ibm,pci-config-space-type", NULL);
 	u32 *regs;
 
 	dn->phb = phb;
@@ -46,6 +47,11 @@ static void * __devinit update_dn_pci_in
 		dn->busno = (regs[0] >> 16) & 0xff;
 		dn->devfn = (regs[0] >> 8) & 0xff;
 	}
+
+	if (type && *type == 1)
+		dn->pci_ext_config_space = 1;
+	else
+		dn->pci_ext_config_space = 0;
 	return NULL;
 }
 
diff -puN arch/ppc64/kernel/iSeries_pci.c~ppc64_pcix_mode2_cfg arch/ppc64/kernel/iSeries_pci.c
--- linux-2.6.11-rc2-bk9/arch/ppc64/kernel/iSeries_pci.c~ppc64_pcix_mode2_cfg	2005-02-01 13:43:04.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/iSeries_pci.c	2005-02-01 13:44:49.000000000 -0600
@@ -610,6 +610,10 @@ static int iSeries_pci_read_config(struc
 
 	if (node == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (offset > 255) {
+		*val = ~0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
 
 	fn = hv_cfg_read_func[(size - 1) & 3];
 	HvCall3Ret16(fn, &ret, node->DsaAddr.DsaAddr, offset, 0);
@@ -636,6 +640,8 @@ static int iSeries_pci_write_config(stru
 
 	if (node == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (offset > 255)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	fn = hv_cfg_write_func[(size - 1) & 3];
 	ret = HvCall4(fn, node->DsaAddr.DsaAddr, offset, val, 0);
_

--------------090002040102030904070100--
