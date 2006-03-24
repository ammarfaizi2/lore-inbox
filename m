Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWCXHuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWCXHuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWCXHuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:50:19 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:47511 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751587AbWCXHuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:50:16 -0500
Message-ID: <4423A434.5070701@jp.fujitsu.com>
Date: Fri, 24 Mar 2006 16:48:04 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2/6] PCIERR : interfaces for synchronous I/O error detection
 on driver (config)
References: <44210D1B.7010806@jp.fujitsu.com> <20060322210157.GH12335@kroah.com>
In-Reply-To: <20060322210157.GH12335@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is 1/4 of PCIERR implementation for IA64.

This part enable us to switch IA64-specific PCIERR by config.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

-----
  arch/ia64/Kconfig            |   10 ++++++++++
  arch/ia64/lib/Makefile       |    1 +
  arch/ia64/lib/pcierr_check.c |   23 +++++++++++++++++++++++
  include/asm-ia64/pci.h       |    8 ++++++++
  4 files changed, 42 insertions(+)

Index: linux-2.6.16_WORK/arch/ia64/Kconfig
===================================================================
--- linux-2.6.16_WORK.orig/arch/ia64/Kconfig
+++ linux-2.6.16_WORK/arch/ia64/Kconfig
@@ -410,6 +410,16 @@
  	bool
  	default PCI

+config PCIERR_CHECK
+	bool "Support pcierr interfaces for IO error detection."
+	depends on PCI
+	help
+	  Saying Y provides pcierr infrastructure for "RAS-aware" drivers
+	  to detect and recover some IO errors, which strongly required by
+	  some of very-high-reliable systems.
+
+	  If you don't know what to do here, say N.
+
  source "drivers/pci/Kconfig"

  source "drivers/pci/hotplug/Kconfig"
Index: linux-2.6.16_WORK/arch/ia64/lib/Makefile
===================================================================
--- linux-2.6.16_WORK.orig/arch/ia64/lib/Makefile
+++ linux-2.6.16_WORK/arch/ia64/lib/Makefile
@@ -15,6 +15,7 @@
  lib-$(CONFIG_MCKINLEY)	+= copy_page_mck.o memcpy_mck.o
  lib-$(CONFIG_PERFMON)	+= carta_random.o
  lib-$(CONFIG_MD_RAID5)	+= xor.o
+lib-$(CONFIG_PCIERR_CHECK) += pcierr_check.o

  AFLAGS___divdi3.o	=
  AFLAGS___udivdi3.o	= -DUNSIGNED
Index: linux-2.6.16_WORK/include/asm-ia64/pci.h
===================================================================
--- linux-2.6.16_WORK.orig/include/asm-ia64/pci.h
+++ linux-2.6.16_WORK/include/asm-ia64/pci.h
@@ -171,4 +171,12 @@

  #define pcibios_scan_all_fns(a, b)	0

+#ifdef CONFIG_PCIERR_CHECK
+/* Enable ia64 pcierr - See arch/ia64/lib/pcierr_check.c */
+#define HAVE_ARCH_PCIERR_CHECK
+typedef struct {
+	int dummy;
+} iocookie;
+#endif /* CONFIG_PCIERR_CHECK  */
+
  #endif /* _ASM_IA64_PCI_H */
Index: linux-2.6.16_WORK/arch/ia64/lib/pcierr_check.c
===================================================================
--- /dev/null
+++ linux-2.6.16_WORK/arch/ia64/lib/pcierr_check.c
@@ -0,0 +1,23 @@
+/*
+ * File:    pcierr_check.c
+ * Purpose: Implement the IA64 specific pcierr interfaces for RAS-drivers
+ */
+
+#include <linux/pci.h>
+
+void pcierr_clear(iocookie *cookie, struct pci_dev *dev);
+int  pcierr_read(iocookie *cookie);
+
+void pcierr_clear(iocookie *cookie, struct pci_dev *dev)
+{
+	/* register device etc. */
+}
+
+int pcierr_read(iocookie *cookie)
+{
+	/* check error etc. */
+	return 0;
+}
+
+EXPORT_SYMBOL(pcierr_read);
+EXPORT_SYMBOL(pcierr_clear);


