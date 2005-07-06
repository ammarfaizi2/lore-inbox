Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVGFOWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVGFOWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVGFOW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:22:29 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:17306 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262290AbVGFKMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:12:36 -0400
Message-ID: <42CBAF26.3070002@jp.fujitsu.com>
Date: Wed, 06 Jul 2005 19:15:02 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: yoshfuji@linux-ipv6.org
CC: seto.hidetoshi@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, tony.luck@intel.com, linas@austin.ibm.com,
       benh@kernel.crashing.org, tlnguyen@snoqualmie.dp.intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6.13-rc1 01/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com> <20050706.152627.68274440.yoshfuji@linux-ipv6.org>
In-Reply-To: <20050706.152627.68274440.yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YOSHIFUJI Hideaki wrote:
>>Index: linux-2.6.13-rc1/lib/iomap.c
>>===================================================================
>>--- linux-2.6.13-rc1.orig/lib/iomap.c
>>+++ linux-2.6.13-rc1/lib/iomap.c
>>@@ -230,3 +230,9 @@ void pci_iounmap(struct pci_dev *dev, vo
>>  }
>>  EXPORT_SYMBOL(pci_iomap);
>>  EXPORT_SYMBOL(pci_iounmap);
>>+
>>+#ifndef HAVE_ARCH_IOMAP_CHECK
>>+/* Since generic funcs are inlined and defined in header, just export */
>>+EXPORT_SYMBOL(iochk_clear);
>>+EXPORT_SYMBOL(iochk_read);
>>+#endif
:
> It looks strange to me.
> You cannot export "static inline" functions.
> You can export iochk_{init,clear,read} only
> if HAVE_ARCH_IOMAP_CHECK is defined.

Oh yes, I had such strange feel too.
I'm not sure there was a compile error or not (it seems good),
but if you right(suppose so) I should remove them.

Fortunately dropping these export doesn't affect any of other
following patches in this series.
Please replace only 01 patch to following new one, and reuse
rest 02 to 10 patches if this is actually strange.

Thanks,
H.Seto

---

  drivers/pci/pci.c           |    2 ++
  include/asm-generic/iomap.h |   32 ++++++++++++++++++++++++++++++++
  2 files changed, 34 insertions(+)

Index: linux-2.6.13-rc1/include/asm-generic/iomap.h
===================================================================
--- linux-2.6.13-rc1.orig/include/asm-generic/iomap.h
+++ linux-2.6.13-rc1/include/asm-generic/iomap.h
@@ -65,4 +65,36 @@ struct pci_dev;
  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
  extern void pci_iounmap(struct pci_dev *dev, void __iomem *);

+/*
+ * IOMAP_CHECK provides additional interfaces for drivers to detect
+ * some IO errors, supports drivers having ability to recover errors.
+ *
+ * All works around iomap-check depends on the design of "iocookie"
+ * structure. Every architecture owning its iomap-check is free to
+ * define the actual design of iocookie to fit its special style.
+ */
+#ifndef HAVE_ARCH_IOMAP_CHECK
+/* Dummy definition of default iocookie */
+typedef int iocookie;
+#endif
+
+/*
+ * Clear/Read iocookie to check IO error while using iomap.
+ *
+ * Note that default iochk_clear-read pair interfaces don't have
+ * any effective error check, but some high-reliable platforms
+ * would provide useful information to you.
+ * And note that some action may be limited (ex. irq-unsafe)
+ * between the pair depend on the facility of the platform.
+ */
+#ifdef HAVE_ARCH_IOMAP_CHECK
+extern void iochk_init(void);
+extern void iochk_clear(iocookie *cookie, struct pci_dev *dev);
+extern int iochk_read(iocookie *cookie);
+#else
+static inline void iochk_init(void) {}
+static inline void iochk_clear(iocookie *cookie, struct pci_dev *dev) {}
+static inline int iochk_read(iocookie *cookie) { return 0; }
+#endif
+
  #endif
Index: linux-2.6.13-rc1/drivers/pci/pci.c
===================================================================
--- linux-2.6.13-rc1.orig/drivers/pci/pci.c
+++ linux-2.6.13-rc1/drivers/pci/pci.c
@@ -767,6 +767,8 @@ static int __devinit pci_init(void)
  	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
  		pci_fixup_device(pci_fixup_final, dev);
  	}
+
+	iochk_init();
  	return 0;
  }



