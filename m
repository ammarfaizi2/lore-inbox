Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUI0IFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUI0IFs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 04:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUI0IFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 04:05:48 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15513 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266233AbUI0IEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 04:04:43 -0400
Date: Mon, 27 Sep 2004 17:06:28 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] add hook for PCI resource deallocation
In-reply-to: <20040924212208.GD7619@kroah.com>
To: Greg KH <greg@kroah.com>, akpm@osdl.org
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Message-id: <4157CA04.5050604@jp.fujitsu.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="------------070604020202010205070700"
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <41498CF6.9000808@jp.fujitsu.com>
 <20040924130251.A26271@unix-os.sc.intel.com> <20040924212208.GD7619@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070604020202010205070700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg and Andrew,

I'm attaching updated patches for adding pcibiod_disable_device()
hook based on the feedback from Ashok (Thank you, Ashok!).

I made two patches, one of them is against 2.6.9-rc2-mm1 and the
another is against 2.6.9-rc2-mm4 to which the previous version of
the patch has already been applyed. Please use the one convenient
for you.

Thanks,
Kenji Kaneshige


Greg KH wrote:

> On Fri, Sep 24, 2004 at 01:02:52PM -0700, Ashok Raj wrote:
>> On Thu, Sep 16, 2004 at 05:54:14AM -0700, Kenji Kaneshige wrote:
>> > 
>> >    Hi,
>> > 
>> >    This patch adds a hook 'pcibios_disable_device()' into
>> >    pci_disable_device() to call architecture specific PCI resource
>> >    deallocation code. It's a opposite part of pcibios_enable_device().
>> >    We need this hook to deallocate architecture specific PCI resource
>> >    such as IRQ resource, etc.. This patch is just for adding the hook,
>> >    so pcibios_disable_device() is defined as a null function on all
>> >    architecture so far.
>> > 
>> >    I tested this patch on i386, x86_64 and ia64. But it has not been
>> >    tested on other architectures because I don't have these machines.
>> > 
>> >    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>> > 
>> 
>> Hi Kenji
>> 
>> I think instead of modifying all the arch specific code, you could use the __attribute__(weak)
>> and define a default dummy funcion in 	drivers/pci/pci.c
>> 
>> void __attribute__((weak)) pcibios_disable_device(struct pci_dev *dev)	{ }
>> 
>> 
>> each arch that really needs this can define the override function.
>> That way you dont need to put the dummy function in several places,
>> containing your changes to a very few set of files.
> 
> Ohhh, nice.  I like that option better.  Kenji, care to respin your
> patches based on this change?
> 
> thanks,
> 
> greg k-h
> 

--------------070604020202010205070700
Content-Type: text/plain;
 name="add_pcibios_disable_device_hook-mm1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_pcibios_disable_device_hook-mm1.patch"


Name:		add_pcibios_disable_device_hook.patch
Kernel Version:	2.6.9-rc2-mm1
Depends:	none
Change Log:

    - Chaged to use __attrubute__ ((weak)) instead of modifying all
      arch specific code.

Description:

This patch adds a hook 'pcibios_disable_device()' into
pci_disable_device() to call architecture specific PCI resource
deallocation code. It's a opposite part of pcibios_enable_device().
We need this hook to deallocate architecture specific PCI resource
such as IRQ resource, etc.. This patch is just for adding the hook, so
'pcibios_disable_device()' is defined as a null function on all
architecture so far.

I tested this patch on i386, x86_64 and ia64. But it has not been
tested on other architectures because I don't have these machines.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.9-rc2-mm1-kanesige/drivers/pci/pci.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN drivers/pci/pci.c~add_pcibios_disable_device_hook drivers/pci/pci.c
--- linux-2.6.9-rc2-mm1/drivers/pci/pci.c~add_pcibios_disable_device_hook	2004-09-27 11:10:54.000000000 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/drivers/pci/pci.c	2004-09-27 16:24:43.944414436 +0900
@@ -392,6 +392,16 @@ pci_enable_device(struct pci_dev *dev)
 }
 
 /**
+ * pcibios_disable_device - disable arch specific PCI resources for device dev
+ * @dev: the PCI device to disable
+ *
+ * Disables architecture specific PCI resources for the device. This
+ * is the default implementation. Architecture implementations can
+ * override this.
+ */
+void __attribute__ ((weak)) pcibios_disable_device (struct pci_dev *dev) {}
+
+/**
  * pci_disable_device - Disable PCI device after use
  * @dev: PCI device to be disabled
  *
@@ -411,6 +421,8 @@ pci_disable_device(struct pci_dev *dev)
 		pci_command &= ~PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
+
+	pcibios_disable_device(dev);
 }
 
 /**

_

--------------070604020202010205070700
Content-Type: text/plain;
 name="add_pcibios_disable_device_hook-mm4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_pcibios_disable_device_hook-mm4.patch"


Kernel Version:	2.6.9-rc2-mm4
Depends:	none.
Change Log:

    - Chaged to use __attrubute__ ((weak)) instead of modifying all
      arch specific code.

Description:

This patch adds a hook 'pcibios_disable_device()' into
pci_disable_device() to call architecture specific PCI resource
deallocation code. It's a opposite part of pcibios_enable_device().
We need this hook to deallocate architecture specific PCI resource
such as IRQ resource, etc.. This patch is just for adding the hook, so
'pcibios_disable_device()' is defined as a null function on all
architecture so far.

I tested this patch on i386, x86_64 and ia64. But it has not been
tested on other architectures because I don't have these machines.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---

 linux-2.6.9-rc2-mm4-kanesige/arch/alpha/kernel/pci.c            |    5 -----
 linux-2.6.9-rc2-mm4-kanesige/arch/arm/kernel/bios32.c           |    4 ----
 linux-2.6.9-rc2-mm4-kanesige/arch/i386/pci/common.c             |    4 ----
 linux-2.6.9-rc2-mm4-kanesige/arch/ia64/pci/pci.c                |    5 -----
 linux-2.6.9-rc2-mm4-kanesige/arch/m68knommu/kernel/comempci.c   |    4 ----
 linux-2.6.9-rc2-mm4-kanesige/arch/mips/pci/pci.c                |    4 ----
 linux-2.6.9-rc2-mm4-kanesige/arch/mips/pmc-sierra/yosemite/ht.c |    5 -----
 linux-2.6.9-rc2-mm4-kanesige/arch/parisc/kernel/pci.c           |    6 ------
 linux-2.6.9-rc2-mm4-kanesige/arch/ppc/kernel/pci.c              |    5 -----
 linux-2.6.9-rc2-mm4-kanesige/arch/ppc64/kernel/pci.c            |    5 -----
 linux-2.6.9-rc2-mm4-kanesige/arch/sh/boards/overdrive/galileo.c |    4 ----
 linux-2.6.9-rc2-mm4-kanesige/arch/sh/drivers/pci/pci.c          |    4 ----
 linux-2.6.9-rc2-mm4-kanesige/arch/sh64/kernel/pcibios.c         |    5 -----
 linux-2.6.9-rc2-mm4-kanesige/arch/sparc/kernel/pcic.c           |    4 ----
 linux-2.6.9-rc2-mm4-kanesige/arch/sparc64/kernel/pci.c          |    4 ----
 linux-2.6.9-rc2-mm4-kanesige/arch/v850/kernel/rte_mb_a_pci.c    |    6 ------
 linux-2.6.9-rc2-mm4-kanesige/drivers/pci/pci.c                  |   10 ++++++++++
 linux-2.6.9-rc2-mm4-kanesige/include/linux/pci.h                |    1 -
 18 files changed, 10 insertions(+), 75 deletions(-)

diff -puN arch/alpha/kernel/pci.c~add_pcibios_disable_device_hook arch/alpha/kernel/pci.c
--- linux-2.6.9-rc2-mm4/arch/alpha/kernel/pci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/alpha/kernel/pci.c	2004-09-27 13:20:42.000000000 +0900
@@ -381,11 +381,6 @@ pcibios_enable_device(struct pci_dev *de
 	return 0;
 }
 
-void
-pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
 /*
  *  If we set up a device for bus mastering, we need to check the latency
  *  timer as certain firmware forgets to set it properly, as seen
diff -puN arch/arm/kernel/bios32.c~add_pcibios_disable_device_hook arch/arm/kernel/bios32.c
--- linux-2.6.9-rc2-mm4/arch/arm/kernel/bios32.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/arm/kernel/bios32.c	2004-09-27 13:20:42.000000000 +0900
@@ -672,10 +672,6 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
-void pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
diff -puN arch/i386/pci/common.c~add_pcibios_disable_device_hook arch/i386/pci/common.c
--- linux-2.6.9-rc2-mm4/arch/i386/pci/common.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/i386/pci/common.c	2004-09-27 13:20:42.000000000 +0900
@@ -249,7 +249,3 @@ int pcibios_enable_device(struct pci_dev
 
 	return pcibios_enable_irq(dev);
 }
-
-void pcibios_disable_device(struct pci_dev *dev)
-{
-}
diff -puN arch/ia64/pci/pci.c~add_pcibios_disable_device_hook arch/ia64/pci/pci.c
--- linux-2.6.9-rc2-mm4/arch/ia64/pci/pci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/ia64/pci/pci.c	2004-09-27 15:09:48.973960437 +0900
@@ -449,11 +449,6 @@ pcibios_enable_device (struct pci_dev *d
 }
 
 void
-pcibios_disable_device (struct pci_dev *dev)
-{
-}
-
-void
 pcibios_align_resource (void *data, struct resource *res,
 		        unsigned long size, unsigned long align)
 {
diff -puN arch/m68knommu/kernel/comempci.c~add_pcibios_disable_device_hook arch/m68knommu/kernel/comempci.c
--- linux-2.6.9-rc2-mm4/arch/m68knommu/kernel/comempci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/m68knommu/kernel/comempci.c	2004-09-27 13:20:42.000000000 +0900
@@ -373,10 +373,6 @@ int pcibios_enable_device(struct pci_dev
 	return(0);
 }
 
-void pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
 /*****************************************************************************/
 
 void pcibios_update_resource(struct pci_dev *dev, struct resource *root, struct resource *r, int resource)
diff -puN arch/mips/pci/pci.c~add_pcibios_disable_device_hook arch/mips/pci/pci.c
--- linux-2.6.9-rc2-mm4/arch/mips/pci/pci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/mips/pci/pci.c	2004-09-27 13:20:42.000000000 +0900
@@ -226,10 +226,6 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
-void pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
 static void __init pcibios_fixup_device_resources(struct pci_dev *dev,
 	struct pci_bus *bus)
 {
diff -puN arch/mips/pmc-sierra/yosemite/ht.c~add_pcibios_disable_device_hook arch/mips/pmc-sierra/yosemite/ht.c
--- linux-2.6.9-rc2-mm4/arch/mips/pmc-sierra/yosemite/ht.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/mips/pmc-sierra/yosemite/ht.c	2004-09-27 13:20:42.000000000 +0900
@@ -348,11 +348,6 @@ int pcibios_enable_device(struct pci_dev
 }
 
 
-void pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
-
 
 void pcibios_update_resource(struct pci_dev *dev, struct resource *root,
                              struct resource *res, int resource)
diff -puN arch/parisc/kernel/pci.c~add_pcibios_disable_device_hook arch/parisc/kernel/pci.c
--- linux-2.6.9-rc2-mm4/arch/parisc/kernel/pci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/parisc/kernel/pci.c	2004-09-27 13:20:42.000000000 +0900
@@ -331,12 +331,6 @@ int pcibios_enable_device(struct pci_dev
 }
 
 
-void
-pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
-
 /* PA-RISC specific */
 void pcibios_register_hba(struct pci_hba_data *hba)
 {
diff -puN arch/ppc64/kernel/pci.c~add_pcibios_disable_device_hook arch/ppc64/kernel/pci.c
--- linux-2.6.9-rc2-mm4/arch/ppc64/kernel/pci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/ppc64/kernel/pci.c	2004-09-27 13:20:42.000000000 +0900
@@ -346,11 +346,6 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
-void
-pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
 /*
  * Return the domain number for this bus.
  */
diff -puN arch/ppc/kernel/pci.c~add_pcibios_disable_device_hook arch/ppc/kernel/pci.c
--- linux-2.6.9-rc2-mm4/arch/ppc/kernel/pci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/ppc/kernel/pci.c	2004-09-27 13:20:42.000000000 +0900
@@ -1421,11 +1421,6 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
-void
-pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
 struct pci_controller*
 pci_bus_to_hose(int bus)
 {
diff -puN arch/sh64/kernel/pcibios.c~add_pcibios_disable_device_hook arch/sh64/kernel/pcibios.c
--- linux-2.6.9-rc2-mm4/arch/sh64/kernel/pcibios.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/sh64/kernel/pcibios.c	2004-09-27 13:20:42.000000000 +0900
@@ -142,11 +142,6 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
-void
-pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
 /*
  *  If we set up a device for bus mastering, we need to check and set
  *  the latency timer as it may not be properly set.
diff -puN arch/sh/boards/overdrive/galileo.c~add_pcibios_disable_device_hook arch/sh/boards/overdrive/galileo.c
--- linux-2.6.9-rc2-mm4/arch/sh/boards/overdrive/galileo.c~add_pcibios_disable_device_hook	2004-09-27 13:20:41.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/sh/boards/overdrive/galileo.c	2004-09-27 13:20:42.000000000 +0900
@@ -529,10 +529,6 @@ int pcibios_enable_device(struct pci_dev
 
 }
 
-void pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
 /* We should do some optimisation work here I think. Ok for now though */
 void __init pcibios_fixup_bus(struct pci_bus *bus)
 {
diff -puN arch/sh/drivers/pci/pci.c~add_pcibios_disable_device_hook arch/sh/drivers/pci/pci.c
--- linux-2.6.9-rc2-mm4/arch/sh/drivers/pci/pci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:42.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/sh/drivers/pci/pci.c	2004-09-27 13:20:42.000000000 +0900
@@ -127,10 +127,6 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
-void pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
 /*
  *  If we set up a device for bus mastering, we need to check and set
  *  the latency timer as it may not be properly set.
diff -puN arch/sparc64/kernel/pci.c~add_pcibios_disable_device_hook arch/sparc64/kernel/pci.c
--- linux-2.6.9-rc2-mm4/arch/sparc64/kernel/pci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:42.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/sparc64/kernel/pci.c	2004-09-27 13:20:42.000000000 +0900
@@ -502,10 +502,6 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
-void pcibios_disable_device(struct pci_dev *pdev)
-{
-}
-
 void pcibios_resource_to_bus(struct pci_dev *pdev, struct pci_bus_region *region,
 			     struct resource *res)
 {
diff -puN arch/sparc/kernel/pcic.c~add_pcibios_disable_device_hook arch/sparc/kernel/pcic.c
--- linux-2.6.9-rc2-mm4/arch/sparc/kernel/pcic.c~add_pcibios_disable_device_hook	2004-09-27 13:20:42.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/sparc/kernel/pcic.c	2004-09-27 13:20:42.000000000 +0900
@@ -872,10 +872,6 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
-void pcibios_disable_device(struct pci_dev *pdev)
-{
-}
-
 /*
  * NMI
  */
diff -puN arch/v850/kernel/rte_mb_a_pci.c~add_pcibios_disable_device_hook arch/v850/kernel/rte_mb_a_pci.c
--- linux-2.6.9-rc2-mm4/arch/v850/kernel/rte_mb_a_pci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:42.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/arch/v850/kernel/rte_mb_a_pci.c	2004-09-27 13:20:42.000000000 +0900
@@ -247,12 +247,6 @@ int __nomods_init pcibios_enable_device 
 	return 0;
 }
 
-
-void
-pcibios_disable_device(struct pci_dev *dev)
-{
-}
-
 
 /* Resource allocation.  */
 static void __devinit pcibios_assign_resources (void)
diff -puN drivers/pci/pci.c~add_pcibios_disable_device_hook drivers/pci/pci.c
--- linux-2.6.9-rc2-mm4/drivers/pci/pci.c~add_pcibios_disable_device_hook	2004-09-27 13:20:42.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/drivers/pci/pci.c	2004-09-27 13:20:42.000000000 +0900
@@ -392,6 +392,16 @@ pci_enable_device(struct pci_dev *dev)
 }
 
 /**
+ * pcibios_disable_device - disable arch specific PCI resources for device dev
+ * @dev: the PCI device to disable
+ *
+ * Disables architecture specific PCI resources for the device. This
+ * is the default implementation. Architecture implementations can
+ * override this.
+ */
+void __attribute__ ((weak)) pcibios_disable_device (struct pci_dev *dev) {}
+
+/**
  * pci_disable_device - Disable PCI device after use
  * @dev: PCI device to be disabled
  *
diff -puN include/linux/pci.h~add_pcibios_disable_device_hook include/linux/pci.h
--- linux-2.6.9-rc2-mm4/include/linux/pci.h~add_pcibios_disable_device_hook	2004-09-27 13:20:42.000000000 +0900
+++ linux-2.6.9-rc2-mm4-kanesige/include/linux/pci.h	2004-09-27 13:20:42.000000000 +0900
@@ -689,7 +689,6 @@ extern struct list_head pci_devices;	/* 
 
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);
-void pcibios_disable_device(struct pci_dev *);
 char *pcibios_setup (char *str);
 
 /* Used only when drivers/pci/setup.c is used */

_

--------------070604020202010205070700--

