Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVCHKHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVCHKHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVCHKEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:04:04 -0500
Received: from ozlabs.org ([203.10.76.45]:11990 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261949AbVCHKAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:00:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16941.30689.21821.556458@cargo.ozlabs.ibm.com>
Date: Tue, 8 Mar 2005 21:01:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: ntl@pobox.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 fix eeh.h compile warnings
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nathan Lynch <ntl@pobox.com>.

Use static inlines instead of #defines for stub functions when
CONFIG_EEH=n, to eliminate "statement with no effect" warnings with
some toolchains.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

Index: linux-2.6.11/include/asm-ppc64/eeh.h
===================================================================
--- linux-2.6.11.orig/include/asm-ppc64/eeh.h	2005-03-02 07:38:38.000000000 +0000
+++ linux-2.6.11/include/asm-ppc64/eeh.h	2005-03-03 01:39:25.000000000 +0000
@@ -104,17 +104,30 @@ int eeh_unregister_notifier(struct notif
  */
 #define EEH_IO_ERROR_VALUE(size)	(~0U >> ((4 - (size)) * 8))
 
-#else
-#define eeh_init()
-#define eeh_check_failure(token, val) (val)
-#define eeh_dn_check_failure(dn, dev) (0)
-#define pci_addr_cache_build()
-#define eeh_add_device_early(dn)
-#define eeh_add_device_late(dev)
-#define eeh_remove_device(dev)
+#else /* !CONFIG_EEH */
+static inline void eeh_init(void) { }
+
+static inline unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
+{
+	return val;
+}
+
+static inline int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
+{
+	return 0;
+}
+
+static inline void pci_addr_cache_build(void) { }
+
+static inline void eeh_add_device_early(struct device_node *dn) { }
+
+static inline void eeh_add_device_late(struct pci_dev *dev) { }
+
+static inline void eeh_remove_device(struct pci_dev *dev) { }
+
 #define EEH_POSSIBLE_ERROR(val, type) (0)
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
-#endif
+#endif /* CONFIG_EEH */
 
 /* 
  * MMIO read/write operations with EEH support.
