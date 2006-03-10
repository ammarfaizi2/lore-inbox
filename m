Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWCJAnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWCJAnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422645AbWCJAmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:42:53 -0500
Received: from mx.pathscale.com ([64.160.42.68]:64653 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752134AbWCJAfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:45 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 20] ipath - core device driver
X-Mercurial-Node: 19bdf20bc5443c64d29676375058e8f4b3b498d5
Message-Id: <19bdf20bc5443c64d296.1141950932@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:32 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver requires kernel PCI_MSI support in order to enable
interrupts.  Since the kernel's MSI infrastructure is currently highly
x86-specific, we have a temporary timer-based hack in place for
non-MSI kernels until other arches start supporting MSI.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 2a9e52d59741 -r 19bdf20bc544 drivers/infiniband/hw/ipath/ipath_driver.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Mar  9 16:15:16 2006 -0800
@@ -0,0 +1,2194 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/idr.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/swap.h>
+#include <linux/netdevice.h>
+#include <linux/vmalloc.h>
+
+/*
+ * InfiniPath only supports message-based interrupts.  It has no interrupt
+ * pins.   Therefore we require CONFIG_PCI_MSI be enabled.  We want a
+ * very visible failure if the support isn't present.
+ */
+#ifndef CONFIG_PCI_MSI
+#error "Without CONFIG_PCI_MSI, interrupts will not work"
+#endif
+
+#include "ipath_kernel.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+static void ipath_update_pio_bufs(struct ipath_devdata *);
+static int ipath_shutdown_link(struct ipath_devdata *);
+struct page *ipath_nopage(struct vm_area_struct *, unsigned long, int *);
+
+const char *ipath_get_unit_name(int unit)
+{
+	static char iname[16];
+	snprintf(iname, sizeof iname, "infinipath%u", unit);
+	return iname;
+}
+
+#define DRIVER_LOAD_MSG "PathScale " IPATH_DRV_NAME " loaded: "
+#define PFX IPATH_DRV_NAME ": "
+
+/*
+ * The size has to be longer than this string, so we can append
+ * board/chip information to it in the init code.
+ */
+const char ipath_core_version[] = IPATH_IDSTR "\n";
+
+static struct idr unit_table;
+static DEFINE_SPINLOCK(unit_table_lock);
+atomic_t ipath_max;
+
+unsigned ipath_debug = __IPATH_INFO;
+
+module_param_named(debug, ipath_debug, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(debug, "mask for debug prints");
+EXPORT_SYMBOL_GPL(ipath_debug);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("PathScale <support@pathscale.com>");
+MODULE_DESCRIPTION("Pathscale InfiniPath driver");
+
+const char *ipath_ibcstatus_str[] = {
+	"Disabled",
+	"LinkUp",
+	"PollActive",
+	"PollQuiet",
+	"SleepDelay",
+	"SleepQuiet",
+	"LState6",		/* unused */
+	"LState7",		/* unused */
+	"CfgDebounce",
+	"CfgRcvfCfg",
+	"CfgWaitRmt",
+	"CfgIdle",
+	"RecovRetrain",
+	"LState0xD",		/* unused */
+	"RecovWaitRmt",
+	"RecovIdle",
+};
+
+/*
+ * These variables are initialized in the chip-specific files
+ * but are defined here.
+ */
+u16 ipath_gpio_sda_num, ipath_gpio_scl_num;
+u64 ipath_gpio_sda, ipath_gpio_scl;
+u64 infinipath_i_bitsextant, infinipath_e_bitsextant,
+    infinipath_hwe_bitsextant;
+u32 infinipath_i_rcvavail_mask, infinipath_i_rcvurg_mask;
+
+static void __devexit ipath_remove_one(struct pci_dev *);
+static int ipath_init_one(struct pci_dev *, const struct pci_device_id *);
+
+/* Only needed for registration, nothing else needs this info */
+#define PCI_VENDOR_ID_PATHSCALE 0x1fc1
+#define PCI_DEVICE_ID_INFINIPATH_HT 0xd
+#define PCI_DEVICE_ID_INFINIPATH_PE800 0x10
+
+static const struct pci_device_id ipath_pci_tbl[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_PATHSCALE,
+		    PCI_DEVICE_ID_INFINIPATH_HT)},
+	{PCI_DEVICE(PCI_VENDOR_ID_PATHSCALE,
+		    PCI_DEVICE_ID_INFINIPATH_PE800)},
+};
+
+MODULE_DEVICE_TABLE(pci, ipath_pci_tbl);
+
+static struct pci_driver ipath_driver = {
+	.name = IPATH_DRV_NAME,
+	.probe = ipath_init_one,
+	.remove = __devexit_p(ipath_remove_one),
+	.id_table = ipath_pci_tbl,
+};
+
+/*
+ * This is where port 0's rcvhdrtail register is written back; we also
+ * want nothing else sharing the cache line, so make it a cache line
+ * in size.  Used for all units.
+ */
+u64 *ipath_port0_rcvhdrtail;
+dma_addr_t ipath_port0_rcvhdrtail_dma;
+static int port0_rcvhdrtail_refs;
+
+#if defined (pgprot_writecombine) && defined(_PAGE_MA_WC)
+int remap_area_pages(unsigned long address, unsigned long phys_addr,
+		     unsigned long size, unsigned long flags);
+#endif
+
+static inline void read_bars(struct pci_dev *dev, u32 *bar0, u32 *bar1)
+{
+	int ret;
+
+	ret = pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, bar0);
+	if (ret)
+		dev_err(&dev->dev, "failed to read bar0 before enable: "
+			"error %d\n", -ret);
+
+	ret = pci_read_config_dword(dev, PCI_BASE_ADDRESS_1, bar1);
+	if (ret)
+		dev_err(&dev->dev, "failed to read bar1 before enable: "
+			"error %d\n", -ret);
+
+	ipath_dbg("Read bar0 %x bar1 %x\n", *bar0, *bar1);
+}
+
+static void ipath_free_devdata(struct pci_dev *pdev,
+			       struct ipath_devdata *dd)
+{
+	unsigned long flags;
+
+	if (dd->ipath_unit != -1) {
+		spin_lock_irqsave(&unit_table_lock, flags);
+		idr_remove(&unit_table, dd->ipath_unit);
+		spin_unlock_irqrestore(&unit_table_lock, flags);
+	}
+	pci_free_consistent(pdev, sizeof(*dd), dd, dd->ipath_dma_addr);
+}
+
+static struct ipath_devdata *ipath_alloc_devdata(struct pci_dev *pdev)
+{
+	unsigned long flags;
+	struct ipath_devdata *dd;
+	dma_addr_t dma_addr;
+	int ret;
+
+	if (!idr_pre_get(&unit_table, GFP_KERNEL)) {
+		dd = ERR_PTR(-ENOMEM);
+		goto bail;
+	}
+
+	dd = pci_alloc_consistent(pdev, sizeof(*dd), &dma_addr);
+
+	if (!dd) {
+		dd = ERR_PTR(-ENOMEM);
+		goto bail;
+	}
+
+	dd->ipath_dma_addr = dma_addr;
+	dd->ipath_unit = -1;
+
+	spin_lock_irqsave(&unit_table_lock, flags);
+
+	ret = idr_get_new(&unit_table, dd, &dd->ipath_unit);
+	if (ret < 0) {
+		printk(KERN_ERR IPATH_DRV_NAME
+		       ": Could not allocate unit ID: error %d\n", -ret);
+		ipath_free_devdata(pdev, dd);
+		dd = ERR_PTR(ret);
+		goto bail_unlock;
+	}
+
+	if (dd->ipath_unit >= atomic_read(&ipath_max))
+		atomic_set(&ipath_max, dd->ipath_unit + 1);
+
+bail_unlock:
+	spin_unlock_irqrestore(&unit_table_lock, flags);
+
+bail:
+	return dd;
+}
+
+static inline struct ipath_devdata *__ipath_lookup(int unit)
+{
+	return idr_find(&unit_table, unit);
+}
+
+struct ipath_devdata *ipath_lookup(int unit)
+{
+	struct ipath_devdata *dd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&unit_table_lock, flags);
+	dd = __ipath_lookup(unit);
+	spin_unlock_irqrestore(&unit_table_lock, flags);
+
+	return dd;
+}
+
+int ipath_count_units(int *npresentp, int *nupp, u32 *maxportsp)
+{
+	int nunits, npresent, nup;
+	unsigned long flags;
+	u32 maxports;
+	int i, max;
+
+	nunits = npresent = nup = maxports = 0;
+
+	spin_lock_irqsave(&unit_table_lock, flags);
+
+	max = atomic_read(&ipath_max);
+
+	for (i = 0; i < max; i++) {
+		struct ipath_devdata *dd = __ipath_lookup(i);
+		if (!dd)
+			continue;
+
+		if (dd->ipath_flags & IPATH_INITTED)
+			nunits++;
+		if ((dd->ipath_flags & IPATH_PRESENT) && dd->ipath_kregbase)
+			npresent++;
+		if (dd->ipath_lid &&
+		    !(dd->ipath_flags & (IPATH_LINKDOWN | IPATH_LINKUNK)))
+			nup++;
+		if (dd->ipath_cfgports > maxports)
+			maxports = dd->ipath_cfgports;
+	}
+
+	spin_unlock_irqrestore(&unit_table_lock, flags);
+
+	if (npresentp)
+		*npresentp = npresent;
+	if (nupp)
+		*nupp = nup;
+	if (maxportsp)
+		*maxportsp = maxports;
+
+	return nunits;
+}
+
+static int init_port0_rcvhdrtail(struct pci_dev *pdev)
+{
+	int ret;
+
+	mutex_lock(&ipath_mutex);
+
+	if (!ipath_port0_rcvhdrtail) {
+		ipath_port0_rcvhdrtail =
+			pci_alloc_consistent(pdev,
+					     IPATH_PORT0_RCVHDRTAIL_SIZE,
+					     &ipath_port0_rcvhdrtail_dma);
+
+		if (!ipath_port0_rcvhdrtail) {
+			ret = -ENOMEM;
+			goto bail;
+		}
+	}
+	port0_rcvhdrtail_refs++;
+	ret = 0;
+
+bail:
+	mutex_unlock(&ipath_mutex);
+
+	return ret;
+}
+
+static void cleanup_port0_rcvhdrtail(struct pci_dev *pdev)
+{
+	mutex_lock(&ipath_mutex);
+
+	if (!--port0_rcvhdrtail_refs) {
+		pci_free_consistent(pdev, IPATH_PORT0_RCVHDRTAIL_SIZE,
+				    ipath_port0_rcvhdrtail,
+				    ipath_port0_rcvhdrtail_dma);
+		ipath_port0_rcvhdrtail = NULL;
+	}
+
+	mutex_unlock(&ipath_mutex);
+}
+
+/*
+ * These next two routines are placeholders in case we don't have per-arch
+ * code for controlling write combining.  If explicit control of write
+ * combining is not available, performance will probably be awful.
+ */
+
+int __attribute__((weak)) ipath_enable_wc(struct ipath_devdata *dd)
+{
+	return -EOPNOTSUPP;
+}
+
+void __attribute__((weak)) ipath_disable_wc(struct ipath_devdata *dd)
+{
+}
+
+static int ipath_init_one(struct pci_dev *pdev,
+			  const struct pci_device_id *ent)
+{
+	int ret, len, j;
+	struct ipath_devdata *dd;
+	unsigned long long addr;
+	u32 bar0 = 0, bar1 = 0;
+	u8 rev;
+
+	ret = init_port0_rcvhdrtail(pdev);
+	if (ret < 0) {
+		printk(KERN_ERR IPATH_DRV_NAME
+		       ": Could not allocate port0_rcvhdrtail: error %d\n",
+		       -ret);
+		goto fail;
+	}
+
+	dd = ipath_alloc_devdata(pdev);
+	if (IS_ERR(dd)) {
+		ret = PTR_ERR(dd);
+		printk(KERN_ERR IPATH_DRV_NAME
+		       ": Could not allocate devdata: error %d\n", -ret);
+		goto fail;
+	}
+
+	ipath_cdbg(VERBOSE, "initializing unit #%u\n", dd->ipath_unit);
+
+	read_bars(pdev, &bar0, &bar1);
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		/* This can happen if we did a chip reset, and then failed
+		 * to reprogram the BAR, or the chip reset due to an
+		 * internal error.  Both of these cases cause the BAR to be
+		 * reset back to initial state. For the latter case, the AER
+		 * sticky error bit at offset 0x718 should be set, but the
+		 * Linux kernel doesn't yet know about that, it appears.  If
+		 * the original BAR was retained in the kernel data
+		 * structures, this may be OK
+		 */
+		ipath_dbg("pci_enable unit %u failed: error %d\n",
+			  dd->ipath_unit, -ret);
+	}
+	addr = pci_resource_start(pdev, 0);
+	len = pci_resource_len(pdev, 0);
+	ipath_cdbg(VERBOSE, "regbase (0) %llx len %d irq %x, vend %x/%x "
+		   "driver_data %lx\n", addr, len, pdev->irq, ent->vendor,
+		   ent->device, ent->driver_data);
+
+	read_bars(pdev, &bar0, &bar1);
+
+	if (!bar1 && !(bar0 & ~0xf)) {
+		if (addr) {
+			dev_info(&pdev->dev, "BAR is 0 (probable RESET), "
+				 "rewriting as %llx\n", addr);
+			ret = pci_write_config_dword(
+				pdev, PCI_BASE_ADDRESS_0, addr);
+			if (ret)
+				dev_err(&pdev->dev, "rewrite of BAR0 "
+					"failed: err %d\n", -ret);
+			ret = pci_write_config_dword(
+				pdev, PCI_BASE_ADDRESS_1, addr >> 32);
+			if (ret)
+				dev_err(&pdev->dev, "rewrite of BAR1 "
+					"failed: err %d\n", -ret);
+		}
+		else
+			dev_err(&pdev->dev, "BAR is 0 (probable RESET), "
+				"not usable until reboot\n");
+	}
+
+	ret = pci_request_regions(pdev, IPATH_DRV_NAME);
+	if (ret)
+		dev_info(&pdev->dev, "pci_request_regions unit %u fails: "
+			 "err %d\n", dd->ipath_unit, -ret);
+
+	ret = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
+	if (ret)
+		dev_info(&pdev->dev, "pci_set_dma_mask unit %u "
+			 "fails: %d\n", dd->ipath_unit, ret);
+
+	pci_set_master(pdev);	/* probably not be needed for HT */
+
+	/*
+	 * Save BARs to rewrite after device reset.  Save all 64 bits of
+	 * BAR, just in case.
+	 */
+	dd->ipath_pcibar0 = addr;
+	dd->ipath_pcibar1 = addr >> 32;
+	dd->ipath_deviceid = ent->device;	/* save for later use */
+	dd->ipath_vendorid = ent->vendor;
+
+	/* setup the chip-specific functions, as early as possible. */
+	switch (ent->device) {
+	case PCI_DEVICE_ID_INFINIPATH_HT:
+		ipath_init_ht400_funcs(dd);
+		break;
+	case PCI_DEVICE_ID_INFINIPATH_PE800:
+		ipath_init_pe800_funcs(dd);
+		break;
+	default:
+		ipath_dev_err(dd, "Found unknown PathScale deviceid 0x%x, "
+			      "failing\n", ent->device);
+		return -ENODEV;
+	}
+
+	for (j = 0; j < 6; j++) {
+		if (!pdev->resource[j].start)
+			continue;
+		ipath_cdbg(VERBOSE, "BAR %d start %lx, end %lx, len %lx\n",
+			   j, pdev->resource[j].start,
+			   pdev->resource[j].end,
+			   pci_resource_len(pdev, j));
+	}
+
+	pci_set_master(pdev);
+
+	if (!addr) {
+		ipath_dev_err(dd, "No valid address in BAR 0!\n");
+		return -ENODEV;
+	}
+
+	dd->ipath_deviceid = ent->device;	/* save for later use */
+	dd->ipath_vendorid = ent->vendor;
+
+	ret = pci_read_config_byte(pdev, PCI_REVISION_ID, &rev);
+	if (ret) {
+		ipath_dev_err(dd, "Failed to read PCI revision ID unit "
+			      "%u: err %d\n", dd->ipath_unit, -ret);
+		return ret;	/* shouldn't ever happen */
+	} else
+		dd->ipath_pcirev = rev;
+
+	dd->ipath_kregbase = ioremap_nocache(addr, len);
+#if defined (pgprot_writecombine) && defined(_PAGE_MA_WC)
+	ipath_cdbg(VERBOSE, "Remapping pages WC\n");
+	remap_area_pages((unsigned long)dd->ipath_kregbase +
+			 1024 * 1024, addr + 1024 * 1024, 1024 * 1024,
+			 _PAGE_MA_WC);
+	/* dd->ipath_kregbase = __ioremap(addr, len, _PAGE_MA_WC); */
+#endif
+
+	if (!dd->ipath_kregbase) {
+		ipath_dbg("Unable to map io addr %llx to kvirt, failing\n",
+			  addr);
+		ret = -ENOMEM;
+		goto fail;
+	}
+	dd->ipath_kregend = (u64 __iomem *)
+		((void __iomem *)dd->ipath_kregbase + len);
+	dd->ipath_physaddr = addr;	/* used for io_remap, etc. */
+	/* for user mmap */
+	dd->ipath_kregvirt = (u64 __iomem *) phys_to_virt(addr);
+	ipath_cdbg(VERBOSE, "mapped io addr %llx to kregbase %p "
+		   "kregvirt %p\n", addr, dd->ipath_kregbase,
+		   dd->ipath_kregvirt);
+
+	/* set these up before registering the interrupt handler */
+	dd->pcidev = pdev;
+	pci_set_drvdata(pdev, dd);
+
+	/*
+	 * clear ipath_flags here instead of in ipath_init_chip as it is set
+	 * by ipath_setup_htconfig.
+	 */
+	dd->ipath_flags = 0;
+
+	if (dd->ipath_f_bus(dd, pdev))
+		ipath_dev_err(dd, "Failed to setup config space; "
+			      "continuing anyway\n");
+
+	/*
+	 * set up our interrupt handler; SA_SHIRQ probably not needed,
+	 * but won't  hurt for now.
+	 * check 0 irq after we return from chip-specific bus setup, since
+	 * that can affect this due to setup
+	 */
+	if (!pdev->irq)
+		ipath_dev_err(dd, "irq is 0, BIOS error?  Interrupts won't "
+			      "work\n");
+	else {
+		ret = request_irq(pdev->irq, ipath_intr, SA_SHIRQ,
+				  IPATH_DRV_NAME, dd);
+		if (ret)
+			ipath_dev_err(dd, "Couldn't setup irq handler, "
+				      "irq=%u: %d\n", pdev->irq, ret);
+	}
+
+	ret = ipath_init_chip(dd, 0);	/* do the chip-specific init */
+
+	if (!ret) {
+		ret = ipath_enable_wc(dd);
+
+		if (ret) {
+			ipath_dev_err(dd, "Write combining not enabled "
+				      "(err %d): performance may be poor\n",
+				      -ret);
+			ret = 0;
+		}
+	}
+
+	if (dd->ipath_kregbase && (dd->ipath_flags & IPATH_PRESENT)) {
+		if (!dd->ipath_f_intrsetup(dd)) {
+			/* now we can enable interrupts from the chip */
+			/* enable all interrupts */
+			ipath_write_kreg(dd, dd->ipath_kregs->kr_intmask,
+					 -1LL);
+			/* force re-interrupt of any pending interrupts. */
+			ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear,
+					 0ULL);
+			/* chip is usable; mark it as initialized */
+			*dd->ipath_statusp |= IPATH_STATUS_INITTED;
+		} else
+			ipath_dev_err(dd, "No interrupts enabled, couldn't "
+				      "setup interrupt address\n");
+	}
+	else if (ret != -EPERM)
+		dev_info(&pdev->dev, "Not configuring unit %u "
+			 "interrupts, init failed\n", dd->ipath_unit);
+
+	ipath_device_create_group(&pdev->dev, dd);
+	ipath_user_add(dd);
+
+	/*
+	 * We used to cleanup here, with pci_release_regions, etc. but that
+	 * can cause other problems if we want to run diags, etc., so
+	 * instead defer that until driver unload.  As long as the driver is
+	 * unloaded, no memory leaks result.
+	 */
+
+fail:	/* after we've done at least some of the pci setup */
+	if (ret == -EPERM)
+		/*
+		 * disabled device, don't want module load error; just want
+		 * to carry status through to this point
+		 */
+		ret = 0;
+
+	return ret;
+}
+
+static void __devexit ipath_remove_one(struct pci_dev *pdev)
+{
+	struct ipath_devdata *dd;
+
+	ipath_cdbg(VERBOSE, "removing, pdev=%p\n", pdev);
+	if (!pdev)
+		return;
+
+	dd = pci_get_drvdata(pdev);
+	ipath_user_del(dd);
+	ipath_device_remove_group(&pdev->dev, dd);
+	pci_set_drvdata(pdev, NULL);
+	ipath_cdbg(VERBOSE, "Releasing pci memory regions, dd %p, "
+		   "unit %u\n", dd, (u32) dd->ipath_unit);
+	if (dd->ipath_kregbase) {
+		ipath_cdbg(VERBOSE, "Unmapping kregbase %p\n",
+			   dd->ipath_kregbase);
+		iounmap((volatile void __iomem *)dd->ipath_kregbase);
+		dd->ipath_kregbase = NULL;
+	}
+	pci_release_regions(pdev);
+	ipath_cdbg(VERBOSE, "calling pci_disable_device\n");
+	pci_disable_device(pdev);
+
+	ipath_free_devdata(pdev, dd);
+	cleanup_port0_rcvhdrtail(pdev);
+}
+
+/* general driver use */
+DEFINE_MUTEX(ipath_mutex);
+static DEFINE_SPINLOCK(ipath_pioavail_lock);
+
+/**
+ * ipath_disarm_piobufs - cancel a range of PIO buffers
+ * @dd: the infinipath device
+ * @first: the first PIO buffer to cancel
+ * @cnt: the number of PIO buffers to cancel
+ *
+ * cancel a range of PIO buffers, used when they might be armed, but
+ * not triggered.  Used at init to ensure buffer state, and also user
+ * process close, in case it died while writing to a PIO buffer
+ * Also after errors.
+ */
+void ipath_disarm_piobufs(struct ipath_devdata *dd, unsigned first,
+			  unsigned cnt)
+{
+	unsigned i, last = first + cnt;
+	u64 sendctrl, sendorig;
+
+	ipath_cdbg(PKT, "disarm %u PIObufs first=%u\n", cnt, first);
+	sendorig = dd->ipath_sendctrl | INFINIPATH_S_DISARM;
+	for (i = first; i < last; i++) {
+		sendctrl = sendorig |
+			(i << INFINIPATH_S_DISARMPIOBUF_SHIFT);
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
+				 sendctrl);
+	}
+	// write it again with current value, in case ipath_sendctrl changed
+	// while we were looping; no critical bits that would require
+	// locking
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
+			 dd->ipath_sendctrl);
+}
+
+/**
+ * ipath_wait_linkstate - wait for an IB link state change to occur
+ * @dd: the infinipath device
+ * @state: the state to wait for
+ * @msecs: the number of milliseconds to wait
+ *
+ * wait up to msecs milliseconds for IB link state change to occur for
+ * now, take the easy polling route.  Currently used only by
+ * ipath_layer_set_linkstate.  Returns 0 if state reached, otherwise
+ * -ETIMEDOUT state can have multiple states set, for any of several
+ * transitions.
+ */
+int ipath_wait_linkstate(struct ipath_devdata *dd, u32 state, int msecs)
+{
+	dd->ipath_sma_state_wanted = state;
+	wait_event_interruptible_timeout(ipath_sma_state_wait,
+					 (dd->ipath_flags & state),
+					 msecs_to_jiffies(msecs));
+	dd->ipath_sma_state_wanted = 0;
+
+	if (!(dd->ipath_flags & state)) {
+		u64 val;
+		ipath_cdbg(SMA, "Didn't reach linkstate %s within %u ms\n",
+			   /* test INIT ahead of DOWN, both can be set */
+			   (state & IPATH_LINKINIT) ? "INIT" :
+			   ((state & IPATH_LINKDOWN) ? "DOWN" :
+			    ((state & IPATH_LINKARMED) ? "ARM" : "ACTIVE")),
+			   msecs);
+		val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_ibcstatus);
+		ipath_cdbg(VERBOSE, "ibcc=%llx ibcstatus=%llx (%s)\n",
+			   (unsigned long long) ipath_read_kreg64(
+				   dd, dd->ipath_kregs->kr_ibcctrl),
+			   (unsigned long long) val,
+			   ipath_ibcstatus_str[val & 0xf]);
+	}
+	return (dd->ipath_flags & state) ? 0 : -ETIMEDOUT;
+}
+
+/**
+ * ipath_nopage - page fault handler
+ * @vma: the VM area
+ * @addr: the address that caused the fault
+ * @type: the output fault type
+ *
+ * For each page that is first faulted in from the
+ * mmap'ed shared address buffer, this routine is called.
+ * It's always for a single page.
+ * We use the low bits of the private_data field to tell us which case
+ * we are dealing with.
+ */
+
+struct page *ipath_nopage(struct vm_area_struct *vma, unsigned long addr,
+			  int *type)
+{
+	/* original [kv]malloc virtual address */
+	unsigned long avirt;
+	/* physical address */
+	unsigned long paddr;
+	/* calculated page offset */
+	unsigned long off;
+	u32 which, chunk;
+	void *vaddr = NULL;
+	struct ipath_portdata *pd;
+	struct page *vpage = NOPAGE_SIGBUS;
+
+	avirt = (unsigned long) vma->vm_private_data;
+
+	if (!avirt) {
+		ipath_dbg("NULL private_data, vm_pgoff %lx\n",
+			  vma->vm_pgoff);
+		which = 0;	/* quiet incorrect gcc warning */
+		goto done;
+	}
+	which = avirt & 3;
+	avirt &= ~3ULL;
+
+	if (addr > vma->vm_end) {
+		ipath_dbg("trying to fault in addr %lx past end\n", addr);
+		goto done;
+	}
+
+	/*
+	 * rcvhdr Q is physically contiguous.
+	 * pgoff is virtual.
+	 */
+	switch (which) {
+	case 1:		/* rcvhdrq_phys */
+		/* should always be 0 */
+		off = vma->vm_pgoff - (avirt >> PAGE_SHIFT);
+		paddr = addr - vma->vm_start + (off << PAGE_SHIFT) + avirt;
+		ipath_cdbg(MM, "hdrq %lx (u=%lx)\n", paddr, addr);
+		vpage = pfn_to_page(paddr >> PAGE_SHIFT);
+		break;
+	case 2:		/* PIO buffer avail regs */
+		/* should always be 0 */
+		off = vma->vm_pgoff - (avirt >> PAGE_SHIFT);
+		paddr = (addr - vma->vm_start + (off << PAGE_SHIFT) +
+			 avirt);
+		ipath_cdbg(MM, "pioav %lx\n", paddr);
+		vpage = pfn_to_page(paddr >> PAGE_SHIFT);
+		break;
+	case 3:
+		/*
+		 * rcvegrbufs; page_alloc()'ed like rcvhdrq, but we
+		 * have to pick out which page_alloc()'ed chunk it is.
+		 */
+		pd = (struct ipath_portdata *)avirt;
+		/* this should always be 0 */
+		off =
+			vma->vm_pgoff -
+			((unsigned long)pd->port_rcvegr_phys >> PAGE_SHIFT);
+		off = (addr - vma->vm_start + (off << PAGE_SHIFT));
+
+		chunk = off / pd->port_rcvegrbuf_size;
+		if (chunk > pd->port_rcvegrbuf_chunks)
+			ipath_dbg("Bad egrbuf chunk %u (max %u); "
+				  "off = %lx\n", chunk,
+				  pd->port_rcvegrbuf_chunks, off);
+		vaddr = pd->port_rcvegrbuf[chunk] +
+			off % pd->port_rcvegrbuf_size;
+		paddr = pd->port_rcvegrbuf_phys[chunk] +
+			off % pd->port_rcvegrbuf_size;
+		vpage = pfn_to_page(paddr >> PAGE_SHIFT);
+		ipath_cdbg(MM, "egrb %p,%lx\n", vaddr, paddr);
+		break;
+	default:
+		ipath_dbg("trying to fault in mmap addr %lx (avirt %lx) "
+			  "that isn't known (case %u)\n", addr, avirt,
+			  which);
+	}
+
+done:
+	if (vpage != NOPAGE_SIGBUS && vpage != NOPAGE_OOM) {
+		if (which == 2)
+			/*
+			 * media/video/video-buf.c doesn't do get_page()
+			 * for buffer from alloc_page().  Hmmm.
+			 *
+			 * keep it from being swapped, complaints if process
+			 * exits before we [kv]free it, etc, and keep shared
+			 * page counts correct, etc.
+			 */
+			get_page(vpage);
+		mark_page_accessed(vpage);
+		if (type)
+			*type = VM_FAULT_MINOR;
+	} else
+		ipath_dbg("faultin of addr %lx vaddr %p avirt %lx failed\n",
+			  addr, vaddr, avirt);
+
+	return vpage;
+}
+
+void ipath_decode_err(char *buf, size_t blen, ipath_err_t err)
+{
+	*buf = '\0';
+	if (err & INFINIPATH_E_RHDRLEN)
+		strlcat(buf, "rhdrlen ", blen);
+	if (err & INFINIPATH_E_RBADTID)
+		strlcat(buf, "rbadtid ", blen);
+	if (err & INFINIPATH_E_RBADVERSION)
+		strlcat(buf, "rbadversion ", blen);
+	if (err & INFINIPATH_E_RHDR)
+		strlcat(buf, "rhdr ", blen);
+	if (err & INFINIPATH_E_RLONGPKTLEN)
+		strlcat(buf, "rlongpktlen ", blen);
+	if (err & INFINIPATH_E_RSHORTPKTLEN)
+		strlcat(buf, "rshortpktlen ", blen);
+	if (err & INFINIPATH_E_RMAXPKTLEN)
+		strlcat(buf, "rmaxpktlen ", blen);
+	if (err & INFINIPATH_E_RMINPKTLEN)
+		strlcat(buf, "rminpktlen ", blen);
+	if (err & INFINIPATH_E_RFORMATERR)
+		strlcat(buf, "rformaterr ", blen);
+	if (err & INFINIPATH_E_RUNSUPVL)
+		strlcat(buf, "runsupvl ", blen);
+	if (err & INFINIPATH_E_RUNEXPCHAR)
+		strlcat(buf, "runexpchar ", blen);
+	if (err & INFINIPATH_E_RIBFLOW)
+		strlcat(buf, "ribflow ", blen);
+	if (err & INFINIPATH_E_REBP)
+		strlcat(buf, "EBP ", blen);
+	if (err & INFINIPATH_E_SUNDERRUN)
+		strlcat(buf, "sunderrun ", blen);
+	if (err & INFINIPATH_E_SPIOARMLAUNCH)
+		strlcat(buf, "spioarmlaunch ", blen);
+	if (err & INFINIPATH_E_SUNEXPERRPKTNUM)
+		strlcat(buf, "sunexperrpktnum ", blen);
+	if (err & INFINIPATH_E_SDROPPEDDATAPKT)
+		strlcat(buf, "sdroppeddatapkt ", blen);
+	if (err & INFINIPATH_E_SDROPPEDSMPPKT)
+		strlcat(buf, "sdroppedsmppkt ", blen);
+	if (err & INFINIPATH_E_SMAXPKTLEN)
+		strlcat(buf, "smaxpktlen ", blen);
+	if (err & INFINIPATH_E_SMINPKTLEN)
+		strlcat(buf, "sminpktlen ", blen);
+	if (err & INFINIPATH_E_SUNSUPVL)
+		strlcat(buf, "sunsupVL ", blen);
+	if (err & INFINIPATH_E_SPKTLEN)
+		strlcat(buf, "spktlen ", blen);
+	if (err & INFINIPATH_E_INVALIDADDR)
+		strlcat(buf, "invalidaddr ", blen);
+	if (err & INFINIPATH_E_RICRC)
+		strlcat(buf, "CRC ", blen);
+	if (err & INFINIPATH_E_RVCRC)
+		strlcat(buf, "VCRC ", blen);
+	if (err & INFINIPATH_E_RRCVEGRFULL)
+		strlcat(buf, "rcvegrfull ", blen);
+	if (err & INFINIPATH_E_RRCVHDRFULL)
+		strlcat(buf, "rcvhdrfull ", blen);
+	if (err & INFINIPATH_E_IBSTATUSCHANGED)
+		strlcat(buf, "ibcstatuschg ", blen);
+	if (err & INFINIPATH_E_RIBLOSTLINK)
+		strlcat(buf, "riblostlink ", blen);
+	if (err & INFINIPATH_E_HARDWARE)
+		strlcat(buf, "hardware ", blen);
+	if (err & INFINIPATH_E_RESET)
+		strlcat(buf, "reset ", blen);
+}
+
+/**
+ * get_rhf_errstring - decode RHF errors
+ * @err: the err number
+ * @msg: the output buffer
+ * @len: the length of the output buffer
+ *
+ * only used one place now, may want more later
+ */
+static void get_rhf_errstring(u32 err, char *msg, size_t len)
+{
+	/* if no errors, and so don't need to check what's first */
+	*msg = '\0';
+
+	if (err & INFINIPATH_RHF_H_ICRCERR)
+		strlcat(msg, "icrcerr ", len);
+	if (err & INFINIPATH_RHF_H_VCRCERR)
+		strlcat(msg, "vcrcerr ", len);
+	if (err & INFINIPATH_RHF_H_PARITYERR)
+		strlcat(msg, "parityerr ", len);
+	if (err & INFINIPATH_RHF_H_LENERR)
+		strlcat(msg, "lenerr ", len);
+	if (err & INFINIPATH_RHF_H_MTUERR)
+		strlcat(msg, "mtuerr ", len);
+	if (err & INFINIPATH_RHF_H_IHDRERR)
+		/* infinipath hdr checksum error */
+		strlcat(msg, "ipathhdrerr ", len);
+	if (err & INFINIPATH_RHF_H_TIDERR)
+		strlcat(msg, "tiderr ", len);
+	if (err & INFINIPATH_RHF_H_MKERR)
+		/* bad port, offset, etc. */
+		strlcat(msg, "invalid ipathhdr ", len);
+	if (err & INFINIPATH_RHF_H_IBERR)
+		strlcat(msg, "iberr ", len);
+	if (err & INFINIPATH_RHF_L_SWA)
+		strlcat(msg, "swA ", len);
+	if (err & INFINIPATH_RHF_L_SWB)
+		strlcat(msg, "swB ", len);
+}
+
+/**
+ * ipath_get_egrbuf - get an eager buffer
+ * @dd: the infinipath device
+ * @bufnum: the eager buffer to get
+ * @err: unused
+ *
+ * must only be called if ipath_pd[port] is known to be allocated
+ */
+static inline void *ipath_get_egrbuf(struct ipath_devdata *dd, u32 bufnum,
+				     int err)
+{
+	return dd->ipath_port0_skbs ?
+		(void *)dd->ipath_port0_skbs[bufnum]->data : NULL;
+
+#ifdef _USE_FOR_DEBUGGING_ONLY
+	/*
+	 * want routine to be inlined and fast this is here so if we do
+	 * ports other than 0, I don't have to rewrite the code, since it's
+	 * slightly complicated
+	 */
+	if (port != 1) {
+		void *chunkbase;
+		/*
+		 * This calculation takes about 50 cycles.  Could do what I
+		 * did for protocol code, and have an array of addresses,
+		 * getting it down to just a few cycles per lookup, at the
+		 * cost of 16KB of memory.
+		 */
+		if (!dd->ipath_pd[port]->port_rcvegrbuf_virt)
+			return NULL;
+		chunkbase = dd->ipath_pd[port]->port_rcvegrbuf_virt
+			[bufnum /
+			 dd->ipath_pd[port]->port_rcvegrbufs_perchunk];
+		return (void *)(chunkbase +
+				(bufnum %
+				 dd->ipath_pd[port]->
+				 port_rcvegrbufs_perchunk)
+				* dd->ipath_rcvegrbufsize);
+	}
+#endif
+}
+
+/*
+ * ipath_rcv_sma - receive an sma packet
+ * @dd: the infinipath device
+ * @tlen: the total packet len
+ * @rc: the packet header
+ * @ebuf: the packet data
+ *
+ * Separate for better overall optimization
+ */
+static void ipath_rcv_sma(struct ipath_devdata *dd, u32 tlen, u64 * rc,
+			  void *ebuf)
+{
+	int sindex, slen, elen;
+	void *smbuf;
+	u8 pad, *bthbytes;
+
+	/* another SMA packet received */
+	ipath_stats.sps_sma_rpkts++;
+
+	bthbytes = (u8 *) ((struct ips_message_header *)&rc[1])->bth;
+
+	pad = (bthbytes[1] >> 4) & 3;
+	elen = tlen - (IPATH_SMA_HDRSZ + pad + (u32) sizeof(u32));
+	if (elen > (IPATH_SMA_MAX_PKTSZ - IPATH_SMA_HDRSZ))
+		elen = IPATH_SMA_MAX_PKTSZ - IPATH_SMA_HDRSZ;
+
+	spin_lock_irq(&ipath_sma_lock);
+	sindex = ipath_sma_next;
+	smbuf = ipath_sma_data[sindex].buf;
+	ipath_sma_data[sindex].unit = dd->ipath_unit;
+	slen = ipath_sma_data[ipath_sma_next].len;
+	memcpy(smbuf, &rc[1], IPATH_SMA_HDRSZ);
+	memcpy(smbuf + IPATH_SMA_HDRSZ, ebuf, elen);
+	if (slen) {
+		/*
+		 * overwriting a yet unread old one (buffer wrap),
+		 * have to advance ipath_sma_first to next oldest
+		 */
+
+		/* count OK packets that we drop */
+		ipath_stats.sps_krdrops++;
+		if (++ipath_sma_first >= IPATH_NUM_SMA_PKTS)
+			ipath_sma_first = 0;
+	}
+	slen = ipath_sma_data[sindex].len = elen + IPATH_SMA_HDRSZ;
+	if (++ipath_sma_next >= IPATH_NUM_SMA_PKTS)
+		ipath_sma_next = 0;
+	spin_unlock_irq(&ipath_sma_lock);
+}
+
+/**
+ * ipath_alloc_skb - allocate an skb and buffer with possible constraints
+ * @dd: the infinipath device
+ * @gfp_mask: the sk_buff SFP mask
+ */
+struct sk_buff *ipath_alloc_skb(struct ipath_devdata *dd,
+				gfp_t gfp_mask)
+{
+	struct sk_buff *skb;
+	u32 len;
+
+	/*
+	 * Only fully supported way to handle this is to allocate lots
+	 * extra, align as needed, and then do skb_reserve().  That wastes
+	 * a lot of memory...  I'll have to hack this into infinipath_copy
+	 * also.
+	 */
+
+	/*
+	 * We need 4 extra bytes for unaligned transfer copying
+	 */
+	if (dd->ipath_flags & IPATH_4BYTE_TID) {
+		/* we need a 4KB multiple alignment, and there is no way
+		 * to do it except to allocate extra and then skb_reserve
+		 * enough to bring it up to the right alignment.
+		 */
+		len = dd->ipath_ibmaxlen + 4 + (1 << 11) - 1;
+	}
+	else
+		len = dd->ipath_ibmaxlen + 4;
+	skb = __dev_alloc_skb(len, gfp_mask);
+	if (!skb) {
+		dev_err(&dd->pcidev->dev, "Failed to allocate skbuff, "
+			"length %u\n", len);
+		return NULL;
+	}
+	if (dd->ipath_flags & IPATH_4BYTE_TID) {
+		u32 una = ((1 << 11) - 1) & (unsigned long)(skb->data + 4);
+		if (una)
+			skb_reserve(skb, 4 + (1 << 11) - una);
+		else
+			skb_reserve(skb, 4);
+	} else
+		skb_reserve(skb, 4);
+	return skb;
+}
+
+/**
+ * ipath_rcv_layer - receive a packet for the layered (ethernet) driver
+ * @dd: the infinipath device
+ * @etail: the sk_buff number
+ * @tlen: the total packet length
+ * @hdr: the ethernet header
+ *
+ * Separate routine for better overall optimization
+ */
+static void ipath_rcv_layer(struct ipath_devdata *dd, u32 etail,
+			    u32 tlen, struct ether_header *hdr)
+{
+	u32 elen;
+	u8 pad, *bthbytes;
+	struct sk_buff *skb, *nskb;
+
+	if (dd->ipath_port0_skbs && hdr->sub_opcode == OPCODE_ENCAP) {
+		/*
+		 * Allocate a new sk_buff to replace the one we give
+		 * to the network stack.
+		 */
+		nskb = ipath_alloc_skb(dd, GFP_ATOMIC);
+		if (!nskb) {
+			/* count OK packets that we drop */
+			ipath_stats.sps_krdrops++;
+			return;
+		}
+
+		bthbytes = (u8 *) hdr->bth;
+		pad = (bthbytes[1] >> 4) & 3;
+		/* +CRC32 */
+		elen = tlen - (sizeof(*hdr) + pad + sizeof(u32));
+
+		skb = dd->ipath_port0_skbs[etail];
+		dd->ipath_port0_skbs[etail] = nskb;
+		skb_put(skb, elen);
+
+		dd->ipath_f_put_tid(dd, etail + (u64 __iomem *)
+				    ((char __iomem *) dd->ipath_kregbase
+				     + dd->ipath_rcvegrbase), 0,
+				    virt_to_phys(nskb->data));
+
+		dd->ipath_layer.l_rcv(dd->ipath_unit, hdr, skb);
+
+		/* another ether packet received */
+		ipath_stats.sps_ether_rpkts++;
+	} else if (hdr->sub_opcode == OPCODE_LID_ARP) {
+		if (dd->ipath_layer.l_rcv_lid)
+			dd->ipath_layer.l_rcv_lid(dd->ipath_unit, hdr);
+	}
+}
+
+/*
+ * ipath_kreceive - receive a packet
+ * @dd: the infinipath device
+ *
+ * called from interrupt handler for errors or receive interrupt
+ */
+void ipath_kreceive(struct ipath_devdata *dd)
+{
+	u64 *rc;
+	void *ebuf;
+	const u32 rsize = dd->ipath_rcvhdrentsize;	/* words */
+	const u32 maxcnt = dd->ipath_rcvhdrcnt * rsize;	/* words */
+	u32 etail = -1, l, hdrqtail, sma_this_time = 0;
+	struct ips_message_header *hdr;
+	u32 eflags, i, etype, tlen, pkttot = 0;
+	static u64 totcalls;	/* stats, may eventually remove */
+	char emsg[128];
+
+	if (!dd->ipath_hdrqtailptr) {
+		ipath_dev_err(dd,
+			      "hdrqtailptr not set, can't do receives\n");
+		return;
+	}
+
+	if (test_and_set_bit(0, &dd->ipath_rcv_pending)) {
+		/* There is already a thread processing this queue. */
+		return;
+	}
+
+	if (dd->ipath_port0head ==
+	    (uint32_t)__le64_to_cpu(*dd->ipath_hdrqtailptr))
+		goto done;
+
+gotmore:
+	/*
+	 * read only once at start.  If in flood situation, this helps
+	 * performance slightly.  If more arrive while we are processing,
+	 * we'll come back here and do them
+	 */
+	hdrqtail = (uint32_t)__le64_to_cpu(*dd->ipath_hdrqtailptr);
+
+	for (i = 0, l = dd->ipath_port0head; l != hdrqtail; i++) {
+		u32 qp;
+		u8 *bthbytes;
+
+		rc = (u64 *) (dd->ipath_pd[0]->port_rcvhdrq + (l << 2));
+		hdr = (struct ips_message_header *)&rc[1];
+		/*
+		 * could make a network order version of IPATH_KD_QP, and
+		 * do the obvious shift before masking to speed this up.
+		 */
+		qp = ntohl(hdr->bth[1]) & 0xffffff;
+		bthbytes = (u8 *) hdr->bth;
+
+		eflags = ips_get_hdr_err_flags((u32 *) rc);
+		etype = ips_get_rcv_type((u32 *) rc);
+		/* total length */
+		tlen = ips_get_length_in_bytes((u32 *) rc);
+		ebuf = NULL;
+		if (etype != RCVHQ_RCV_TYPE_EXPECTED) {
+			/*
+			 * it turns out that the chips uses an eager buffer
+			 * for all non-expected packets, whether it "needs"
+			 * one or not.  So always get the index, but don't
+			 * set ebuf (so we try to copy data) unless the
+			 * length requires it.
+			 */
+			etail = ips_get_index((u32 *) rc);
+			if (tlen > sizeof(*hdr) ||
+			    etype == RCVHQ_RCV_TYPE_NON_KD)
+				ebuf = ipath_get_egrbuf(dd, etail, 0);
+		}
+
+		/*
+		 * both tiderr and ipathhdrerr are set for all plain IB
+		 * packets; only ipathhdrerr should be set.
+		 */
+
+		if (etype != RCVHQ_RCV_TYPE_NON_KD &&
+		    etype != RCVHQ_RCV_TYPE_ERROR &&
+		    ips_get_ipath_ver(hdr->iph.ver_port_tid_offset) !=
+		    IPS_PROTO_VERSION) {
+			ipath_cdbg(PKT, "Bad InfiniPath protocol version "
+				   "%x\n", etype);
+		}
+
+		if (eflags & ~(INFINIPATH_RHF_H_TIDERR |
+			       INFINIPATH_RHF_H_IHDRERR)) {
+			get_rhf_errstring(eflags, emsg, sizeof emsg);
+			ipath_cdbg(PKT, "RHFerrs %x hdrqtail=%x typ=%u "
+				   "tlen=%x opcode=%x egridx=%x: %s\n",
+				   eflags, l, etype, tlen, bthbytes[0],
+				   ips_get_index((u32 *) rc), emsg);
+		} else if (etype == RCVHQ_RCV_TYPE_NON_KD) {
+			/*
+			 * If there is a userland SMA and this is a MAD
+			 * packet, then pass it to the userland SMA.
+			 */
+			if (atomic_read(&ipath_sma_alive) && qp <= 1) {
+				/*
+				 * count OK packets that we drop because
+				 * SMA isn't yet running, or because we
+				 * are in an sma flood (no point in
+				 * constantly acquiring the spin lock, and
+				 * overwriting previous packets).
+				 * Eventually things will recover.
+				 * Similarly if the sma consumer is
+				 * so far behind that we would overwrite
+				 * (yes, it's outside the lock)
+				 */
+				if (!ipath_sma_data_spare ||
+				    ipath_sma_data[ipath_sma_next].len ||
+				    ++sma_this_time > IPATH_NUM_SMA_PKTS)
+					ipath_stats.sps_krdrops++;
+				else if (ebuf)
+					ipath_rcv_sma(dd, tlen, rc, ebuf);
+			}
+			else if (dd->verbs_layer.l_rcv)
+				dd->verbs_layer.l_rcv(dd->ipath_unit,
+						      rc + 1,
+						      ebuf, tlen);
+			else
+				ipath_cdbg(VERBOSE, "received IB packet, "
+					   "not SMA (QP=%x)\n", qp);
+		} else if (etype == RCVHQ_RCV_TYPE_EAGER) {
+			if (qp == IPATH_KD_QP && bthbytes[0] ==
+			    dd->ipath_layer.l_rcv_opcode && ebuf)
+				ipath_rcv_layer(dd, etail, tlen,
+						(struct ether_header *)hdr);
+			else
+				ipath_cdbg(PKT, "typ %x, opcode %x (eager, "
+					   "qp=%x), len %x; ignored\n",
+					   etype, bthbytes[0], qp, tlen);
+		}
+		else if (etype == RCVHQ_RCV_TYPE_EXPECTED)
+			ipath_dbg("Bug: Expected TID, opcode %x; ignored\n",
+				  hdr->bth[0] & 0xff);
+		else if (eflags & (INFINIPATH_RHF_H_TIDERR |
+				   INFINIPATH_RHF_H_IHDRERR)) {
+			/*
+			 * This is a type 3 packet, only the LRH is in the
+			 * rcvhdrq, the rest of the header is in the eager
+			 * buffer.
+			 */
+			u8 opcode;
+			if (ebuf) {
+				bthbytes = (u8 *) ebuf;
+				opcode = *bthbytes;
+			}
+			else
+				opcode = 0;
+			get_rhf_errstring(eflags, emsg, sizeof emsg);
+			ipath_dbg("Err %x (%s), opcode %x, egrbuf %x, "
+				  "len %x\n", eflags, emsg, opcode, etail,
+				  tlen);
+		} else {
+			/*
+			 * error packet, type of error	unknown.
+			 * Probably type 3, but we don't know, so don't
+			 * even try to print the opcode, etc.
+			 */
+			ipath_dbg("Error Pkt, but no eflags! egrbuf %x, "
+				  "len %x\nhdrq@%lx;hdrq+%x rhf: %llx; "
+				  "hdr %llx %llx %llx %llx %llx\n",
+				  etail, tlen, (unsigned long) rc, l,
+				  (unsigned long long) rc[0],
+				  (unsigned long long) rc[1],
+				  (unsigned long long) rc[2],
+				  (unsigned long long) rc[3],
+				  (unsigned long long) rc[4],
+				  (unsigned long long) rc[5]);
+		}
+		l += rsize;
+		if (l >= maxcnt)
+			l = 0;
+		/*
+		 * update for each packet, to help prevent overflows if we
+		 * have lots of packets.
+		 */
+		(void)ipath_write_ureg(dd, ur_rcvhdrhead,
+				       dd->ipath_rhdrhead_intr_off | l, 0);
+		if (etype != RCVHQ_RCV_TYPE_EXPECTED)
+			(void)ipath_write_ureg(dd, ur_rcvegrindexhead,
+					       etail, 0);
+	}
+
+	pkttot += i;
+
+	dd->ipath_port0head = l;
+
+	if (hdrqtail != (uint32_t)__le64_to_cpu(*dd->ipath_hdrqtailptr))
+		/* more arrived while we handled first batch */
+		goto gotmore;
+
+	if (pkttot > ipath_stats.sps_maxpkts_call)
+		ipath_stats.sps_maxpkts_call = pkttot;
+	ipath_stats.sps_port0pkts += pkttot;
+	ipath_stats.sps_avgpkts_call =
+		ipath_stats.sps_port0pkts / ++totcalls;
+
+	if (sma_this_time)	/* only once at end, not each time */
+		wake_up_interruptible(&ipath_sma_wait);
+
+done:
+	clear_bit(0, &dd->ipath_rcv_pending);
+	smp_mb__after_clear_bit();
+}
+
+/**
+ * ipath_update_pio_bufs - update shadow copy of the PIO availability map
+ * @dd: the infinipath device
+ *
+ * called whenever our local copy indicates we have run out of send buffers
+ * NOTE: This can be called from interrupt context by some code
+ * and from non-interrupt context by ipath_getpiobuf().
+ */
+
+static void ipath_update_pio_bufs(struct ipath_devdata *dd)
+{
+	unsigned long flags;
+	int i;
+	const unsigned piobregs = (unsigned)dd->ipath_pioavregs;
+
+	/* If the generation (check) bits have changed, then we update the
+	 * busy bit for the corresponding PIO buffer.  This algorithm will
+	 * modify positions to the value they already have in some cases
+	 * (i.e., no change), but it's faster than changing only the bits
+	 * that have changed.
+	 *
+	 * We would like to do this atomicly, to avoid spinlocks in the
+	 * critical send path, but that's not really possible, given the
+	 * type of changes, and that this routine could be called on
+	 * multiple cpu's simultaneously, so we lock in this routine only,
+	 * to avoid conflicting updates; all we change is the shadow, and
+	 * it's a single 64 bit memory location, so by definition the update
+	 * is atomic in terms of what other cpu's can see in testing the
+	 * bits.  The spin_lock overhead isn't too bad, since it only
+	 * happens when all buffers are in use, so only cpu overhead, not
+	 * latency or bandwidth is affected.
+	 */
+#define _IPATH_ALL_CHECKBITS 0x5555555555555555ULL
+	if (!dd->ipath_pioavailregs_dma) {
+		ipath_dbg("Update shadow pioavail, but regs_dma NULL!\n");
+		return;
+	}
+	if (ipath_debug & __IPATH_VERBDBG) {
+		/* only if packet debug and verbose */
+		volatile unsigned long long *dma =
+			(volatile unsigned long long *)
+			dd->ipath_pioavailregs_dma;
+		unsigned long *shadow = dd->ipath_pioavailshadow;
+
+		ipath_cdbg(PKT, "Refill avail, dma0=%llx shad0=%lx, "
+			   "d1=%llx s1=%lx, d2=%llx s2=%lx, d3=%llx "
+			   "s3=%lx\n",
+			   (unsigned long long) __le64_to_cpu(dma[0]),
+			   shadow[0],
+			   (unsigned long long) __le64_to_cpu(dma[1]),
+			   shadow[1],
+			   (unsigned long long) __le64_to_cpu(dma[2]),
+			   shadow[2],
+			   (unsigned long long) __le64_to_cpu(dma[3]),
+			   shadow[3]);
+		if (piobregs > 4)
+			ipath_cdbg(PKT, "2nd group, dma4=%llx shad4=%lx, "
+				   "d5=%llx s5=%lx, d6=%llx s6=%lx, "
+				   "d7=%llx s7=%lx\n",
+				   (unsigned long long) __le64_to_cpu(dma[4]),
+				   shadow[4],
+				   (unsigned long long) __le64_to_cpu(dma[5]),
+				   shadow[5],
+				   (unsigned long long) __le64_to_cpu(dma[6]),
+				   shadow[6],
+				   (unsigned long long) __le64_to_cpu(dma[7]),
+				   shadow[7]);
+	}
+	spin_lock_irqsave(&ipath_pioavail_lock, flags);
+	for (i = 0; i < piobregs; i++) {
+		u64 pchbusy, pchg, piov, pnew;
+		/*
+		 * Chip Errata: bug 6641; even and odd qwords>3 are swapped
+		 */
+		if (i > 3) {
+			if (i & 1)
+				piov = __le64_to_cpu(dd->ipath_pioavailregs_dma[i - 1]);
+			else
+				piov = __le64_to_cpu(dd->ipath_pioavailregs_dma[i + 1]);
+		} else
+			piov = __le64_to_cpu(dd->ipath_pioavailregs_dma[i]);
+		pchg = _IPATH_ALL_CHECKBITS &
+			~(dd->ipath_pioavailshadow[i] ^ piov);
+		pchbusy = pchg << INFINIPATH_SENDPIOAVAIL_BUSY_SHIFT;
+		if (pchg && (pchbusy & dd->ipath_pioavailshadow[i])) {
+			pnew = dd->ipath_pioavailshadow[i] & ~pchbusy;
+			pnew |= piov & pchbusy;
+			dd->ipath_pioavailshadow[i] = pnew;
+		}
+	}
+	spin_unlock_irqrestore(&ipath_pioavail_lock, flags);
+}
+
+/**
+ * ipath_setrcvhdrsize - set the receive header size
+ * @dd: the infinipath device
+ * @rhdrsize: the receive header size
+ *
+ * called from user init code, and also layered driver init
+ */
+int ipath_setrcvhdrsize(struct ipath_devdata *dd, unsigned rhdrsize)
+{
+	int ret = 0;
+
+	if (dd->ipath_flags & IPATH_RCVHDRSZ_SET) {
+		if (dd->ipath_rcvhdrsize != rhdrsize) {
+			dev_info(&dd->pcidev->dev,
+				 "Error: can't set protocol header "
+				 "size %u, already %u\n",
+				 rhdrsize, dd->ipath_rcvhdrsize);
+			ret = -EAGAIN;
+		} else
+			ipath_cdbg(VERBOSE, "Reuse same protocol header "
+				   "size %u\n", dd->ipath_rcvhdrsize);
+	} else if (rhdrsize > (dd->ipath_rcvhdrentsize -
+			       (sizeof(u64) / sizeof(u32)))) {
+		ipath_dbg("Error: can't set protocol header size %u "
+			  "(> max %u)\n", rhdrsize,
+			  dd->ipath_rcvhdrentsize -
+			  (u32) (sizeof(u64) / sizeof(u32)));
+		ret = -EOVERFLOW;
+	} else {
+		dd->ipath_flags |= IPATH_RCVHDRSZ_SET;
+		dd->ipath_rcvhdrsize = rhdrsize;
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvhdrsize,
+				 dd->ipath_rcvhdrsize);
+		ipath_cdbg(VERBOSE, "Set protocol header size to %u\n",
+			   dd->ipath_rcvhdrsize);
+	}
+	return ret;
+}
+
+/**
+ * ipath_getpiobuf - find an available pio buffer
+ * @dd: the infinipath device
+ * @pbufnum: the buffer number is placed here
+ *
+ * do appropriate marking as busy, etc.
+ * returns buffer number if one found (>=0), negative number is error.
+ * Used by ipath_sma_send_pkt and ipath_layer_send
+ */
+u32 __iomem *ipath_getpiobuf(struct ipath_devdata *dd, u32 * pbufnum)
+{
+	int i, j, starti, updated = 0;
+	unsigned piobcnt, iter;
+	unsigned long flags;
+	unsigned long *shadow = dd->ipath_pioavailshadow;
+	u32 __iomem *buf;
+
+	piobcnt = (unsigned)(dd->ipath_piobcnt2k
+			     + dd->ipath_piobcnt4k);
+	starti = dd->ipath_lastport_piobuf;
+	iter = piobcnt - starti;
+	if (dd->ipath_upd_pio_shadow) {
+		/*
+		 * Minor optimization.  If we had no buffers on last call,
+		 * start out by doing the update; continue and do scan even
+		 * if no buffers were updated, to be paranoid
+		 */
+		ipath_update_pio_bufs(dd);
+		/* we scanned here, don't do it at end of scan */
+		updated = 1;
+		i = starti;
+	} else
+		i = dd->ipath_lastpioindex;
+
+rescan:
+	/*
+	 * while test_and_set_bit() is atomic, we do that and then the
+	 * change_bit(), and the pair is not.  See if this is the cause
+	 * of the remaining armlaunch errors.
+	 */
+	spin_lock_irqsave(&ipath_pioavail_lock, flags);
+	for (j = 0; j < iter; j++, i++) {
+		if (i >= piobcnt)
+			i = starti;
+		/*
+		 * To avoid bus lock overhead, we first find a candidate
+		 * buffer, then do the test and set, and continue if that
+		 * fails.
+		 */
+		if (test_bit((2 * i) + 1, shadow) ||
+		    test_and_set_bit((2 * i) + 1, shadow))
+			continue;
+		/* flip generation bit */
+		change_bit(2 * i, shadow);
+		break;
+	}
+	spin_unlock_irqrestore(&ipath_pioavail_lock, flags);
+
+	if (j == iter) {
+		volatile unsigned long long *dma =
+			(volatile unsigned long long *)
+			dd->ipath_pioavailregs_dma;
+
+		/*
+		 * first time through; shadow exhausted, but may be real
+		 * buffers available, so go see; if any updated, rescan
+		 * (once)
+		 */
+		if (!updated) {
+			ipath_update_pio_bufs(dd);
+			updated = 1;
+			i = starti;
+			goto rescan;
+		}
+		dd->ipath_upd_pio_shadow = 1;
+		/*
+		 * not atomic, but if we lose one once in a while, that's OK
+		 */
+		ipath_stats.sps_nopiobufs++;
+		if (!(++dd->ipath_consec_nopiobuf % 100000)) {
+			ipath_dbg("%u pio sends with no bufavail; dmacopy: "
+				  "%llx %llx %llx %llx; shadow:  "
+				  "%lx %lx %lx %lx\n",
+				  dd->ipath_consec_nopiobuf,
+				  (unsigned long long) __le64_to_cpu(dma[0]),
+				  (unsigned long long) __le64_to_cpu(dma[1]),
+				  (unsigned long long) __le64_to_cpu(dma[2]),
+				  (unsigned long long) __le64_to_cpu(dma[3]),
+				  shadow[0], shadow[1], shadow[2],
+				  shadow[3]);
+			/*
+			 * 4 buffers per byte, 4 registers above, cover rest
+			 * below
+			 */
+			if ((dd->ipath_piobcnt2k + dd->ipath_piobcnt4k) >
+			    (sizeof(shadow[0]) * 4 * 4))
+				ipath_dbg("2nd group: dmacopy: %llx %llx "
+					  "%llx %llx; shadow: %lx %lx "
+					  "%lx %lx\n",
+					  (unsigned long long) __le64_to_cpu(dma[4]),
+					  (unsigned long long) __le64_to_cpu(dma[5]),
+					  (unsigned long long) __le64_to_cpu(dma[6]),
+					  (unsigned long long) __le64_to_cpu(dma[7]),
+					  shadow[4], shadow[5],
+					  shadow[6], shadow[7]);
+		}
+		return NULL;
+	}
+
+	if (updated && dd->ipath_layer.l_intr) {
+		/*
+		 * ran out of bufs, now some (at least this one we just
+		 * got) are now available, so tell the layered driver.
+		 */
+		dd->ipath_layer.l_intr(dd->ipath_unit,
+				       IPATH_LAYER_INT_SEND_CONTINUE);
+	}
+
+	/*
+	 * set next starting place.  Since it's just an optimization,
+	 * it doesn't matter who wins on this, so no locking
+	 */
+	dd->ipath_lastpioindex = i + 1;
+	if (dd->ipath_upd_pio_shadow)
+		dd->ipath_upd_pio_shadow = 0;
+	if (dd->ipath_consec_nopiobuf)
+		dd->ipath_consec_nopiobuf = 0;
+	if (i < dd->ipath_piobcnt2k)
+		buf = (u32 __iomem *)
+			(dd->ipath_pio2kbase + i * dd->ipath_palign);
+	else
+		buf = (u32 __iomem *)
+			(dd->ipath_pio4kbase + (i - dd->ipath_piobcnt2k) *
+			 dd->ipath_4kalign);
+	ipath_cdbg(VERBOSE, "Return piobuf%u %uk @ %p\n",
+		   i, (i < dd->ipath_piobcnt2k) ? 2 : 4, buf);
+	if (pbufnum)
+		*pbufnum = i;
+	return buf;
+}
+
+/**
+ * ipath_create_rcvhdrq - create a receive header queue
+ * @dd: the infinipath device
+ * @pd: the port data
+ *
+ * this *must* be physically contiguous memory, and for now,
+ * that limits it to what kmalloc can do.
+ */
+int ipath_create_rcvhdrq(struct ipath_devdata *dd,
+			 struct ipath_portdata *pd)
+{
+	int ret = 0, amt;
+
+	amt = ALIGN(dd->ipath_rcvhdrcnt * dd->ipath_rcvhdrentsize *
+		    sizeof(u32), PAGE_SIZE);
+	if (!pd->port_rcvhdrq) {
+		size_t i;
+
+		/*
+		 * not using REPEAT isn't viable; at 128KB, we can
+		 * easily fail this.  The problem with REPEAT is we
+		 * can block here "forever".  There isn't an
+		 * inbetween, unfortunately.  We could reduce the risk
+		 * by never freeing the rcvhdrq except at unload, but
+		 * even then, the first time a port is used, we could
+		 * delay for some time...
+		 */
+		pd->port_rcvhdrq =
+			dma_alloc_coherent(&dd->pcidev->dev, amt,
+					   &pd->port_rcvhdrq_phys,
+					   GFP_USER);
+		if (!pd->port_rcvhdrq) {
+			ipath_dev_err(dd,
+				      "attempt to allocate %d bytes for "
+				      "port %u rcvhdrq failed\n",
+				      amt, pd->port_port);
+			ret = -ENOMEM;
+			goto bail;
+		}
+
+		pd->port_rcvhdrq_size = amt;
+
+		ipath_cdbg(VERBOSE, "%d pages at %p (phys %lx) size=%lu "
+			   "for port %u rcvhdr Q\n",
+			   amt >> PAGE_SHIFT, pd->port_rcvhdrq,
+			   (unsigned long) pd->port_rcvhdrq_phys,
+			   (unsigned long) pd->port_rcvhdrq_size,
+			   pd->port_port);
+
+		/*
+		 * mark pages as reserved, to avoid problems when user
+		 * process with them mapped exits.
+		 */
+		for (i = 0; i < amt; i += PAGE_SIZE)
+			SetPageReserved(virt_to_page(pd->port_rcvhdrq + i));
+	} else {
+		/*
+		 * clear for security, sanity, and/or debugging, each
+		 * time we reuse
+		 */
+		memset(pd->port_rcvhdrq, 0, amt);
+	}
+
+	/*
+	 * tell chip each time we init it, even if we are re-using previous
+	 * memory (we zero it at process close)
+	 */
+	ipath_cdbg(VERBOSE, "writing port %d rcvhdraddr as %lx\n",
+		   pd->port_port, (unsigned long) pd->port_rcvhdrq_phys);
+	ipath_write_kreg_port(dd, dd->ipath_kregs->kr_rcvhdraddr,
+			      pd->port_port, pd->port_rcvhdrq_phys);
+
+	ret = 0;
+bail:
+	return ret;
+}
+
+int ipath_waitfor_complete(struct ipath_devdata *dd, ipath_kreg reg_id,
+			   u64 bits_to_wait_for, u64 * valp)
+{
+	u64 timeout, lastval, val;
+
+	lastval = ipath_read_kreg64(dd, reg_id);
+	/* wait a ridiculously long time */
+	timeout = get_cycles() + 0x10000000ULL;
+	do {
+		val = ipath_read_kreg64(dd, reg_id);
+		/* set so they have something, even on failures. */
+		*valp = val;
+		if ((val & bits_to_wait_for) == bits_to_wait_for)
+			return 0;
+		if (val != lastval)
+			ipath_cdbg(VERBOSE, "Changed from %llx to %llx, "
+				   "waiting for %llx bits\n",
+				   (unsigned long long) lastval,
+				   (unsigned long long) val,
+				   (unsigned long long) bits_to_wait_for);
+		yield();
+		if (get_cycles() > timeout) {
+			ipath_dbg("Didn't get bits %llx in register 0x%x, "
+				  "got %llx\n",
+				  (unsigned long long) bits_to_wait_for,
+				  reg_id, (unsigned long long) *valp);
+			return ENODEV;
+		}
+	} while (1);
+}
+
+/**
+ * ipath_waitfor_mdio_cmdready - wait for last command to complete
+ * @dd: the infinipath device
+ *
+ * Like ipath_waitfor_complete(), but we wait for the CMDVALID bit to go
+ * away indicating the last command has completed.  It doesn't return data
+ */
+int ipath_waitfor_mdio_cmdready(struct ipath_devdata *dd)
+{
+	u64 timeout;
+	u64 val;
+
+	/* wait a ridiculously long time */
+	timeout = get_cycles() + 0x10000000ULL;
+	do {
+		val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_mdio);
+		if (!(val & IPATH_MDIO_CMDVALID))
+			return 0;
+		yield();
+		if (get_cycles() > timeout) {
+			ipath_dbg("CMDVALID stuck in mdio reg? (%llx)\n",
+				  (unsigned long long) val);
+			return ENODEV;
+		}
+	} while (1);
+}
+
+void ipath_set_ib_lstate(struct ipath_devdata *dd, int which)
+{
+#if _IPATH_DEBUGGING
+	static char *what[4] = {
+		[0] = "DOWN",
+		[INFINIPATH_IBCC_LINKCMD_INIT] = "INIT",
+		[INFINIPATH_IBCC_LINKCMD_ARMED] = "ARMED",
+		[INFINIPATH_IBCC_LINKCMD_ACTIVE] = "ACTIVE"
+	};
+	ipath_cdbg(SMA, "Trying to move unit %u to %s, current ltstate "
+		   "is %s\n", dd->ipath_unit,
+		   what[(which >> INFINIPATH_IBCC_LINKCMD_SHIFT) &
+			INFINIPATH_IBCC_LINKCMD_MASK],
+		   ipath_ibcstatus_str[
+			   (ipath_read_kreg64
+			    (dd, dd->ipath_kregs->kr_ibcstatus) >>
+			    INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) &
+			   INFINIPATH_IBCS_LINKTRAININGSTATE_MASK]);
+#endif
+
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_ibcctrl,
+			 dd->ipath_ibcctrl | which);
+}
+
+/**
+ * ipath_read_kreg64_port - read a device's per-port 64-bit kernel register
+ * @dd: the infinipath device
+ * @regno: the register number to read
+ * @port: the port containing the register
+ *
+ * Registers that vary with the chip implementation constants (port)
+ * use this routine.
+ */
+u64 ipath_read_kreg64_port(const struct ipath_devdata *dd, ipath_kreg regno,
+			   unsigned port)
+{
+	u16 where;
+
+	if (port < dd->ipath_portcnt &&
+	    (regno == dd->ipath_kregs->kr_rcvhdraddr ||
+	     regno == dd->ipath_kregs->kr_rcvhdrtailaddr))
+		where = regno + port;
+	else
+		where = -1;
+
+	return ipath_read_kreg64(dd, where);
+}
+
+/**
+ * ipath_write_kreg_port - write a device's per-port 64-bit kernel register
+ * @dd: the infinipath device
+ * @regno: the register number to write
+ * @port: the port containing the register
+ * @value: the value to write
+ *
+ * Registers that vary with the chip implementation constants (port)
+ * use this routine.
+ */
+void ipath_write_kreg_port(const struct ipath_devdata *dd, ipath_kreg regno,
+			  unsigned port, u64 value)
+{
+	u16 where;
+
+	if (port < dd->ipath_portcnt &&
+	    (regno == dd->ipath_kregs->kr_rcvhdraddr ||
+	     regno == dd->ipath_kregs->kr_rcvhdrtailaddr))
+		where = regno + port;
+	else
+		where = -1;
+
+	ipath_write_kreg(dd, where, value);
+}
+
+/**
+ * ipath_shutdown_link - shut down a link
+ * @dd: the infinipath device
+ *
+ * do this when driver is being unloaded, or perhaps for diags, and
+ * maybe when we get an interrupt of a fatal link error that requires
+ * bringing the linkd down and back up
+ */
+static int ipath_shutdown_link(struct ipath_devdata *dd)
+{
+	int ret = 0;
+
+	ipath_dbg("Shutting down the link\n");
+	ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKINITCMD_DISABLE <<
+			    INFINIPATH_IBCC_LINKINITCMD_SHIFT);
+
+	/*
+	 * we are shutting down, so tell the layered driver.  We don't do
+	 * this on just a link state change, much like ethernet, a cable
+	 * unplug, etc. doesn't change driver state
+	 */
+	if (dd->ipath_layer.l_intr)
+		dd->ipath_layer.l_intr(dd->ipath_unit,
+				       IPATH_LAYER_INT_IF_DOWN);
+
+	/* disable IBC */
+	dd->ipath_control &= ~INFINIPATH_C_LINKENABLE;
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_control,
+			 dd->ipath_control);
+
+	dd->ipath_flags |= IPATH_LINKUNK;
+	dd->ipath_flags &= ~(IPATH_INITTED | IPATH_LINKDOWN |
+			     IPATH_LINKINIT | IPATH_LINKARMED |
+			     IPATH_LINKACTIVE);
+	*dd->ipath_statusp &= ~(IPATH_STATUS_IB_CONF |
+				IPATH_STATUS_IB_READY);
+
+	/*
+	 * clear SerdesEnable and turn the leds off; do this here because
+	 * we are unloading, so don't count on interrupts to move along
+	 * Turn the LEDs off explictly for the same reason.
+	 */
+	dd->ipath_f_quiet_serdes(dd);
+	dd->ipath_f_setextled(dd, 0, 0);
+
+	if (dd->ipath_stats_timer_active) {
+		del_timer_sync(&dd->ipath_stats_timer);
+		dd->ipath_stats_timer_active = 0;
+	}
+	if (*dd->ipath_statusp & IPATH_STATUS_CHIP_PRESENT) {
+		/* can't do anything more with chip; needs re-init */
+		*dd->ipath_statusp &= ~IPATH_STATUS_CHIP_PRESENT;
+		if (dd->ipath_kregbase) {
+			/*
+			 * if we haven't already cleaned up before these are
+			 * to ensure any register reads/writes "fail" until
+			 * re-init
+			 */
+			dd->ipath_kregbase = NULL;
+			dd->ipath_kregvirt = NULL;
+			dd->ipath_uregbase = 0;
+			dd->ipath_sregbase = 0;
+			dd->ipath_cregbase = 0;
+			dd->ipath_kregsize = 0;
+		}
+		ipath_disable_wc(dd);
+	}
+
+	return ret;
+}
+
+/**
+ * ipath_free_pddata - free a port's allocated data
+ * @dd: the infinipath device
+ * @port: the port
+ * @freehdrq: free the port data structure if true
+ *
+ * when closing, free up any allocated data for a port, if the
+ * reference count goes to zero
+ * Note: this also optionally frees the portdata itself!
+ * Any changes here have to be matched up with the reinit case
+ * of ipath_init_chip(), which calls this routine on reinit after reset.
+ */
+void ipath_free_pddata(struct ipath_devdata *dd, u32 port, int freehdrq)
+{
+	struct ipath_portdata *pd = dd->ipath_pd[port];
+
+	if (!pd)
+		return;
+	if (freehdrq)
+		/*
+		 * only clear and free portdata if we are going to also
+		 * release the hdrq, otherwise we leak the hdrq on each
+		 * open/close cycle
+		 */
+		dd->ipath_pd[port] = NULL;
+	if (freehdrq && pd->port_rcvhdrq) {
+		size_t i;
+		ipath_cdbg(VERBOSE, "free closed port %d rcvhdrq @ %p "
+			   "(size=%lu)\n", pd->port_port, pd->port_rcvhdrq,
+			   (unsigned long) pd->port_rcvhdrq_size);
+		for (i = 0; i < pd->port_rcvhdrq_size; i += PAGE_SIZE)
+			ClearPageReserved(
+				virt_to_page(pd->port_rcvhdrq + i));
+		dma_free_coherent(&dd->pcidev->dev, pd->port_rcvhdrq_size,
+				  pd->port_rcvhdrq, pd->port_rcvhdrq_phys);
+		pd->port_rcvhdrq = NULL;
+	}
+	if (port && pd->port_rcvegrbuf) {
+		/* always free this */
+		if (pd->port_rcvegrbuf) {
+			unsigned e;
+
+			for (e = 0; e < pd->port_rcvegrbuf_chunks; e++) {
+				void *buf = pd->port_rcvegrbuf[e];
+				size_t i;
+
+				for (i = 0; i < pd->port_rcvegrbuf_size;
+				     i += PAGE_SIZE)
+					ClearPageReserved(
+						virt_to_page(buf + i));
+
+				ipath_cdbg(VERBOSE, "egrbuf free(%p, %lu), "
+					   "chunk %u/%u\n", buf,
+					   (unsigned long)
+					   pd->port_rcvegrbuf_size,
+					   e, pd->port_rcvegrbuf_chunks);
+				dma_free_coherent(
+					&dd->pcidev->dev,
+					pd->port_rcvegrbuf_size, buf,
+					pd->port_rcvegrbuf_phys[e]);
+			}
+			vfree(pd->port_rcvegrbuf);
+			pd->port_rcvegrbuf = NULL;
+			vfree(pd->port_rcvegrbuf_phys);
+			pd->port_rcvegrbuf_phys = NULL;
+		}
+		pd->port_rcvegrbuf_chunks = 0;
+	} else if (port == 0 && dd->ipath_port0_skbs) {
+		unsigned e;
+		struct sk_buff **skbs = dd->ipath_port0_skbs;
+
+		dd->ipath_port0_skbs = NULL;
+		ipath_cdbg(VERBOSE, "free closed port %d ipath_port0_skbs "
+			   "@ %p\n", pd->port_port, skbs);
+		for (e = 0; e < dd->ipath_rcvegrcnt; e++)
+			if (skbs[e])
+				dev_kfree_skb(skbs[e]);
+		vfree(skbs);
+	}
+	if (freehdrq) {
+		kfree(pd->port_tid_pg_list);
+		kfree(pd);
+	}
+}
+
+int __init infinipath_init(void)
+{
+	int ret;
+
+	ipath_dbg(KERN_INFO DRIVER_LOAD_MSG "%s", ipath_core_version);
+
+	/*
+	 * These must all be called before the driver is registered
+	 * with the PCI subsystem.
+	 */
+	spin_lock_init(&ipath_pioavail_lock);
+	spin_lock_init(&ipath_sma_lock);
+
+	spin_lock_init(&unit_table_lock);
+	idr_init(&unit_table);
+	if (!idr_pre_get(&unit_table, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	ret = pci_register_driver(&ipath_driver);
+	if (ret < 0) {
+		printk(KERN_ERR IPATH_DRV_NAME
+		       ": Unable to register driver: error %d\n", -ret);
+		goto bail_unit;
+	}
+
+	ret = ipath_driver_create_group(&ipath_driver.driver);
+	if (ret < 0) {
+		printk(KERN_ERR IPATH_DRV_NAME ": Unable to create driver "
+		       "sysfs entries: error %d\n", -ret);
+		goto bail_pci;
+	}
+
+	goto bail;
+
+bail_pci:
+	pci_unregister_driver(&ipath_driver);
+
+bail_unit:
+	idr_destroy(&unit_table);
+
+bail:
+	return ret;
+}
+
+static void cleanup_device(struct ipath_devdata *dd)
+{
+	int port;
+	u64 val;
+
+	/* in case unload fails, be consistent */
+	dd->ipath_rcvctrl = 0;
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
+			 dd->ipath_rcvctrl);
+
+	/*
+	 * gracefully stop all sends allowing any in progress to
+	 * trickle out first.
+	 */
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl, 0ULL);
+	/* flush it */
+	val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_scratch);
+	/*
+	 * enough for anything that's going to trickle out to have
+	 * actually done so.
+	 */
+	udelay(5);
+
+	/*
+	 * abort any armed or launched PIO buffers that didn't go. (self
+	 * clearing).  Will cause any packet currently being transmitted to
+	 * go out with an EBP, and may also cause a short packet error on
+	 * the receiver.
+	 */
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
+			 INFINIPATH_S_ABORT);
+
+	/* mask interrupts, but not errors */
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_intmask, 0ULL);
+	ipath_shutdown_link(dd);
+
+	/*
+	 * clear all interrupts and errors.  Next time driver is loaded,
+	 * we know that whatever is set happened while we were unloaded
+	 */
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_hwerrclear, -1LL);
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_errorclear, -1LL);
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear, -1LL);
+	if (dd->__ipath_pioavailregs_base) {
+		pci_free_consistent(dd->pcidev,
+				    dd->ipath_pioavailregs_size,
+				    (void *)dd->__ipath_pioavailregs_base,
+				    dd->ipath_pioavailregs_phys);
+		dd->__ipath_pioavailregs_base = NULL;
+		dd->ipath_pioavailregs_dma = NULL;
+	}
+
+	if (dd->ipath_pageshadow) {
+		struct page **tmpp = dd->ipath_pageshadow;
+		int i, cnt = 0;
+
+		ipath_cdbg(VERBOSE, "Unlocking any expTID pages still "
+			   "locked\n");
+		for (port = 0; port < dd->ipath_cfgports; port++) {
+			int port_tidbase = port * dd->ipath_rcvtidcnt;
+			int maxtid = port_tidbase + dd->ipath_rcvtidcnt;
+			for (i = port_tidbase; i < maxtid; i++) {
+				if (tmpp[i]) {
+					ipath_release_user_pages(&tmpp[i], 1);
+					tmpp[i] = NULL;
+					cnt++;
+				}
+			}
+		}
+		if (cnt) {
+			ipath_stats.sps_pageunlocks += cnt;
+			ipath_cdbg(VERBOSE, "There were still %u expTID "
+				   "entries locked\n", cnt);
+		}
+		if (ipath_stats.sps_pagelocks ||
+		    ipath_stats.sps_pageunlocks)
+			ipath_cdbg(
+				VERBOSE, "%llu pages locked, %llu "
+				"unlocked via ipath_m{un}lock\n",
+				(unsigned long long)
+				ipath_stats.sps_pagelocks,
+				(unsigned long long)
+				ipath_stats.sps_pageunlocks);
+
+		ipath_cdbg(VERBOSE, "Free shadow page tid array at %p\n",
+			   dd->ipath_pageshadow);
+		vfree(dd->ipath_pageshadow);
+		dd->ipath_pageshadow = NULL;
+	}
+
+	/*
+	 * free any resources still in use (usually just kernel ports)
+	 * at unload
+	 */
+	for (port = 0; port < dd->ipath_cfgports; port++)
+		ipath_free_pddata(dd, port, 1);
+	kfree(dd->ipath_pd);
+	/*
+	 * debuggability, in case some cleanup path tries to use it
+	 * after this
+	 */
+	dd->ipath_pd = NULL;
+}
+
+static void __exit infinipath_cleanup(void)
+{
+	int m;
+
+	ipath_driver_remove_group(&ipath_driver.driver);
+
+	/*
+	 * turn off rcv, send, and interrupts for all ports, all drivers
+	 * should also hard reset the chip here?
+	 * free up port 0 (kernel) rcvhdr, egr bufs, and eventually tid bufs
+	 * for all versions of the driver, if they were allocated
+	 */
+	for (m = 0; m < atomic_read(&ipath_max); m++) {
+		struct ipath_devdata *dd = ipath_lookup(m);
+		if (!dd)
+			continue;
+
+		if (dd->ipath_kregbase)
+			cleanup_device(dd);
+
+		if (dd->pcidev) {
+			if (dd->pcidev->irq) {
+				ipath_cdbg(VERBOSE,
+					   "unit %u free_irq of irq %x\n",
+					   m, dd->pcidev->irq);
+				free_irq(dd->pcidev->irq, dd);
+			} else
+				ipath_dbg("irq is 0, not doing free_irq "
+					  "for unit %u\n", m);
+			dd->pcidev = NULL;
+		}
+
+		/*
+		 * we check for NULL here, because it's outside the kregbase
+		 * check, and we need to call it after the free_irq.  Thus
+		 * it's possible that the function pointers were never
+		 * initialized.
+		 */
+		if (dd->ipath_f_cleanup)
+			/* clean up chip-specific stuff */
+			dd->ipath_f_cleanup(dd);
+	}
+
+	ipath_cdbg(VERBOSE, "Unregistering pci driver unit %u\n", m);
+	pci_unregister_driver(&ipath_driver);
+
+	idr_destroy(&unit_table);
+}
+
+/**
+ * ipath_reset_device - reset the chip if possible
+ * @unit: the device to reset
+ *
+ * Whether or not reset is successful, we attempt to re-initialize the chip
+ * (that is, much like a driver unload/reload).  We clear the INITTED flag
+ * so that the various entry points will fail until we reinitialize.  For
+ * now, we only allow this if no user ports are open that use chip resources
+ */
+int ipath_reset_device(int unit)
+{
+	int ret, i;
+	struct ipath_devdata *dd = ipath_lookup(unit);
+
+	if (!dd)
+		return -ENODEV;
+
+	dev_info(&dd->pcidev->dev, "Reset on unit %u requested\n", unit);
+
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT)) {
+		dev_info(&dd->pcidev->dev, "Invalid unit number %u or "
+			 "not initialized or not present\n", unit);
+		return -ENXIO;
+	}
+
+	if (dd->ipath_pd)
+		for (i = 1; i < dd->ipath_portcnt; i++) {
+			if (dd->ipath_pd[i] && dd->ipath_pd[i]->port_cnt) {
+				ipath_dbg("unit %u port %d is in use "
+					  "(PID %u cmd %s), can't reset\n",
+					  unit, i,
+					  dd->ipath_pd[i]->port_pid,
+					  dd->ipath_pd[i]->port_comm);
+				return -EBUSY;
+			}
+		}
+
+	dd->ipath_flags &= ~IPATH_INITTED;
+	ret = dd->ipath_f_reset(dd);
+	if (ret != 1)
+		ipath_dbg("reset was not successful\n");
+	ipath_dbg("Trying to reinitialize unit %u after reset attempt\n",
+		  unit);
+	ret = ipath_init_chip(dd, 1);
+	if (ret)
+		dev_err(&dd->pcidev->dev, "Reinitialize unit %u after "
+			"reset failed with %d\n", unit, ret);
+	else
+		dev_info(&dd->pcidev->dev, "Reinitialized unit %u after "
+			 "resetting\n", unit);
+	return ret;
+}
+
+module_init(infinipath_init);
+module_exit(infinipath_cleanup);
