Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVFIMsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVFIMsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVFIMsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:48:38 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59593 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261335AbVFIMrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:47:31 -0400
Message-ID: <42A83B0D.7040701@jp.fujitsu.com>
Date: Thu, 09 Jun 2005 21:50:21 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Cc: Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH 02/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com>
In-Reply-To: <42A8386F.2060100@jp.fujitsu.com>
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

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  arch/ia64/Kconfig           |   13 +++++++++++++
  arch/ia64/lib/Makefile      |    1 +
  arch/ia64/lib/iomap_check.c |   30 ++++++++++++++++++++++++++++++
  include/asm-ia64/io.h       |   11 +++++++++++
  4 files changed, 55 insertions(+)

Index: linux-2.6.11.11/arch/ia64/lib/Makefile
===================================================================
--- linux-2.6.11.11.orig/arch/ia64/lib/Makefile
+++ linux-2.6.11.11/arch/ia64/lib/Makefile
@@ -16,6 +16,7 @@ lib-$(CONFIG_MCKINLEY)	+= copy_page_mck.
  lib-$(CONFIG_PERFMON)	+= carta_random.o
  lib-$(CONFIG_MD_RAID5)	+= xor.o
  lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
+lib-$(CONFIG_IOMAP_CHECK) += iomap_check.o

  AFLAGS___divdi3.o	=
  AFLAGS___udivdi3.o	= -DUNSIGNED
Index: linux-2.6.11.11/arch/ia64/Kconfig
===================================================================
--- linux-2.6.11.11.orig/arch/ia64/Kconfig
+++ linux-2.6.11.11/arch/ia64/Kconfig
@@ -381,6 +381,19 @@ config PCI_DOMAINS
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
Index: linux-2.6.11.11/arch/ia64/lib/iomap_check.c
===================================================================
--- /dev/null
+++ linux-2.6.11.11/arch/ia64/lib/iomap_check.c
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
Index: linux-2.6.11.11/include/asm-ia64/io.h
===================================================================
--- linux-2.6.11.11.orig/include/asm-ia64/io.h
+++ linux-2.6.11.11/include/asm-ia64/io.h
@@ -70,6 +70,17 @@ extern unsigned int num_io_spaces;
  #include <asm/machvec.h>
  #include <asm/page.h>
  #include <asm/system.h>
+
+#ifdef CONFIG_IOMAP_CHECK
+
+/* definition of ia64 iocookie */
+typedef unsigned long iocookie;
+
+/* enable ia64 iochk - See arch/ia64/lib/iomap_check.c */
+#define HAVE_ARCH_IOMAP_CHECK
+
+#endif /* CONFIG_IOMAP_CHECK  */
+
  #include <asm-generic/iomap.h>

  /*

