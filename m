Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVGFGte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVGFGte (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 02:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVGFGra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 02:47:30 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48848 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262093AbVGFFPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 01:15:52 -0400
Message-ID: <42CB69BD.1090607@jp.fujitsu.com>
Date: Wed, 06 Jul 2005 14:18:53 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>
CC: Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH 2.6.13-rc1 08/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com>
In-Reply-To: <42CB63B2.6000505@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is 8 of 10 patches, "iochk-08-mcadrv.patch"]

- Touching poisoned data become a MCA, so now it assumed as
   a fatal error, directly will be a system down. But since
   the MCA tells us a physical address - "where it happens",
   we can do some action to survive.

   If the address is present in resource of "check-in" device,
   it is guaranteed that its driver will call iochk_read in
   the very near future, and that now the driver have a
   ability and responsibility of recovery from the error.

   So if it was "check-in" address, what OS should do is mark
   "check-in" devices and just restart usual works. Soon
   the driver will notice the error and operate it properly.

   Note:
     We can identify a affected device, but because of SAL
     behavior (mentioned at 6 of 10), we need to mark all
     "check-in" devices. Fix in future, if possible.

Changes from previous one for 2.6.11.11:
   - (non)

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  arch/ia64/kernel/mca_drv.c  |   84 ++++++++++++++++++++++++++++++++++++++++++++
  arch/ia64/lib/iomap_check.c |    1
  2 files changed, 85 insertions(+)

Index: linux-2.6.13-rc1/arch/ia64/lib/iomap_check.c
===================================================================
--- linux-2.6.13-rc1.orig/arch/ia64/lib/iomap_check.c
+++ linux-2.6.13-rc1/arch/ia64/lib/iomap_check.c
@@ -147,3 +147,4 @@ void clear_bridge_error(struct pci_dev *

  EXPORT_SYMBOL(iochk_read);
  EXPORT_SYMBOL(iochk_clear);
+EXPORT_SYMBOL(iochk_devices);	/* for MCA driver */
Index: linux-2.6.13-rc1/arch/ia64/kernel/mca_drv.c
===================================================================
--- linux-2.6.13-rc1.orig/arch/ia64/kernel/mca_drv.c
+++ linux-2.6.13-rc1/arch/ia64/kernel/mca_drv.c
@@ -35,6 +35,12 @@

  #include "mca_drv.h"

+#ifdef CONFIG_IOMAP_CHECK
+#include <linux/pci.h>
+#include <asm/io.h>
+extern struct list_head iochk_devices;
+#endif
+
  /* max size of SAL error record (default) */
  static int sal_rec_max = 10000;

@@ -377,6 +383,79 @@ is_mca_global(peidx_table_t *peidx, pal_
  	return MCA_IS_GLOBAL;
  }

+#ifdef CONFIG_IOMAP_CHECK
+
+/**
+ * get_target_identifier - get address of target_identifier
+ * @peidx:	pointer of index of processor error section
+ *
+ * Return value:
+ *	addr if valid / 0 if not valid
+ */
+static u64 get_target_identifier(peidx_table_t *peidx)
+{
+	sal_log_mod_error_info_t *smei;
+
+	smei = peidx_bus_check(peidx, 0);
+	if (smei->valid.target_identifier)
+		return (smei->target_identifier);
+	return 0;
+}
+
+/**
+ * offending_addr_in_check - Check if the addr is in checking resource.
+ * @addr:	address offending this MCA
+ *
+ * Return value:
+ *	1 if in / 0 if out
+ */
+static int offending_addr_in_check(u64 addr)
+{
+	int i;
+	struct pci_dev *tdev;
+	iocookie *cookie;
+
+	if (list_empty(&iochk_devices))
+		return 0;
+
+	list_for_each_entry(cookie, &iochk_devices, list) {
+		tdev = cookie->dev;
+		for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+		  if (tdev->resource[i].start <= addr
+		      && addr <= tdev->resource[i].end)
+			return 1;
+		  if ((tdev->resource[i].flags
+		      & (PCI_BASE_ADDRESS_SPACE|PCI_BASE_ADDRESS_MEM_TYPE_MASK))
+		      == (PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64))
+			i++;
+		}
+	}
+	return 0;
+}
+
+/**
+ * pci_error_recovery - Check if MCA occur on transaction in iochk.
+ * @peidx:	pointer of index of processor error section
+ *
+ * Return value:
+ *	1 if error could be cought in driver / 0 if not
+ */
+static int pci_error_recovery(peidx_table_t *peidx)
+{
+	u64 addr;
+
+	addr = get_target_identifier(peidx);
+	if (!addr)
+		return 0;
+
+	if (offending_addr_in_check(addr))
+		return 1;
+
+	return 0;
+}
+
+#endif /* CONFIG_IOMAP_CHECK */
+
  /**
   * recover_from_read_error - Try to recover the errors which type are "read"s.
   * @slidx:	pointer of index of SAL error record
@@ -399,6 +478,11 @@ recover_from_read_error(slidx_table_t *s
  	if (!pbci->tv)
  		return 0;

+#ifdef CONFIG_IOMAP_CHECK
+	if (pci_error_recovery(peidx))
+		return 1;
+#endif
+
  	/*
  	 * cpu read or memory-mapped io read
  	 *


