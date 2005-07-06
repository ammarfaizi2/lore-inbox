Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVGFG2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVGFG2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 02:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVGFG2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 02:28:39 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:14538 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262082AbVGFE44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 00:56:56 -0400
Message-ID: <42CB6566.8090804@jp.fujitsu.com>
Date: Wed, 06 Jul 2005 14:00:22 +0900
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
Subject: [PATCH 2.6.13-rc1 02/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com>
In-Reply-To: <42CB63B2.6000505@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is 2 of 10 patches, "iochk-02-ia64.patch"]

- Add "config IOMAP_CHECK" to change definitions from generic
   to specific.

- Defines ia64 version of:
     iochk_clear, iochk_read, iochk_init, and iocookie
   But they are no-ops yet. See next patch (3 of 10).

Changes from previous one for 2.6.11.11:
   - simplify define of iocookie structure.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  arch/ia64/Kconfig           |   13 +++++++++++++
  arch/ia64/lib/Makefile      |    1 +
  arch/ia64/lib/iomap_check.c |   30 ++++++++++++++++++++++++++++++
  include/asm-ia64/io.h       |   13 +++++++++++++
  4 files changed, 57 insertions(+)

Index: linux-2.6.13-rc1/arch/ia64/lib/Makefile
===================================================================
--- linux-2.6.13-rc1.orig/arch/ia64/lib/Makefile
+++ linux-2.6.13-rc1/arch/ia64/lib/Makefile
@@ -16,6 +16,7 @@ lib-$(CONFIG_MCKINLEY)	+= copy_page_mck.
  lib-$(CONFIG_PERFMON)	+= carta_random.o
  lib-$(CONFIG_MD_RAID5)	+= xor.o
  lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
+lib-$(CONFIG_IOMAP_CHECK) += iomap_check.o

  AFLAGS___divdi3.o	=
  AFLAGS___udivdi3.o	= -DUNSIGNED
Index: linux-2.6.13-rc1/arch/ia64/Kconfig
===================================================================
--- linux-2.6.13-rc1.orig/arch/ia64/Kconfig
+++ linux-2.6.13-rc1/arch/ia64/Kconfig
@@ -413,6 +413,19 @@ config PCI_DOMAINS
  	bool
  	default PCI

+config IOMAP_CHECK
+	bool "Support iochk interfaces for IO error detection."
+	depends on PCI && EXPERIMENTAL
+	---help---
+	  Saying Y provides iochk infrastructure for "RAS-aware" drivers
+	  to detect and recover some IO errors, which strongly required by
+	  some of very-high-reliable systems.
+	  The implementation of this infrastructure is highly depend on arch,
+	  bus system, chipset and so on.
+	  Currentry, very few drivers on few arch actually implements this.
+
+	  If you don't know what to do here, say N.
+
  source "drivers/pci/Kconfig"

  source "drivers/pci/hotplug/Kconfig"
Index: linux-2.6.13-rc1/arch/ia64/lib/iomap_check.c
===================================================================
--- /dev/null
+++ linux-2.6.13-rc1/arch/ia64/lib/iomap_check.c
@@ -0,0 +1,30 @@
+/*
+ * File:    iomap_check.c
+ * Purpose: Implement the IA64 specific iomap recovery interfaces
+ */
+
+#include <linux/pci.h>
+
+void iochk_init(void);
+void iochk_clear(iocookie *cookie, struct pci_dev *dev);
+int  iochk_read(iocookie *cookie);
+
+void iochk_init(void)
+{
+	/* setup */
+}
+
+void iochk_clear(iocookie *cookie, struct pci_dev *dev)
+{
+	/* register device etc. */
+}
+
+int iochk_read(iocookie *cookie)
+{
+	/* check error etc. */
+
+	return 0;
+}
+
+EXPORT_SYMBOL(iochk_read);
+EXPORT_SYMBOL(iochk_clear);
Index: linux-2.6.13-rc1/include/asm-ia64/io.h
===================================================================
--- linux-2.6.13-rc1.orig/include/asm-ia64/io.h
+++ linux-2.6.13-rc1/include/asm-ia64/io.h
@@ -70,6 +70,19 @@ extern unsigned int num_io_spaces;
  #include <asm/machvec.h>
  #include <asm/page.h>
  #include <asm/system.h>
+
+#ifdef CONFIG_IOMAP_CHECK
+
+/* ia64 iocookie */
+typedef struct {
+	int dummy;
+} iocookie;
+
+/* Enable ia64 iochk - See arch/ia64/lib/iomap_check.c */
+#define HAVE_ARCH_IOMAP_CHECK
+
+#endif /* CONFIG_IOMAP_CHECK  */
+
  #include <asm-generic/iomap.h>

  /*


