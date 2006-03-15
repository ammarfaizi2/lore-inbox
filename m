Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752108AbWCOAtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbWCOAtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 19:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbWCOAtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 19:49:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33186 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751362AbWCOAts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 19:49:48 -0500
Message-ID: <44176502.9050109@ce.jp.nec.com>
Date: Tue, 14 Mar 2006 19:51:14 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, gregkh@suse.de,
       maule@sgi.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org>
In-Reply-To: <20060314134535.72eb7243.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080407020806080109070002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080407020806080109070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Andrew Morton wrote:
> One option might be to create inclued/linux/msi.h, put this declaration in
> there then include <asm/msi.h>.  Possibly some other declarations should be
> moved into linux/msi.h as well.

How about the attached one?
Build tested on ia64 with both CONFIG_PCI_MSI y and n.

This is a minimum set to fix compile warnings and errors.
Maybe better fleshed up by msi developers if necessary.


The patch also fixes other build error below on CONFIG_IA64_GENERIC.

   CC      arch/ia64/sn/pci/msi.o
/build/rc6/source/arch/ia64/sn/pci/msi.c: At top level:
/build/rc6/source/arch/ia64/sn/pci/msi.c:192: error: variable `sn_msi_ops' has initializer but incomplete type
/build/rc6/source/arch/ia64/sn/pci/msi.c:193: error: unknown field `setup' specified in initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:193: warning: excess elements in struct initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:193: warning: (near initialization for `sn_msi_ops')
/build/rc6/source/arch/ia64/sn/pci/msi.c:194: error: unknown field `teardown' specified in initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:194: warning: excess elements in struct initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:194: warning: (near initialization for `sn_msi_ops')
/build/rc6/source/arch/ia64/sn/pci/msi.c:196: error: unknown field `target' specified in initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:196: warning: excess elements in struct initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:196: warning: (near initialization for `sn_msi_ops')
/build/rc6/source/arch/ia64/sn/pci/msi.c:192: error: storage size of `sn_msi_ops' isn't known

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------080407020806080109070002
Content-Type: text/x-patch;
 name="drivers-pci-msi-add-linux-msi-h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers-pci-msi-add-linux-msi-h.patch"

--- linux-2.6.16-rc6-mm1.orig/include/linux/msi.h	2006-03-14 17:00:10.000000000 -0500
+++ linux-2.6.16-rc6-mm1/include/linux/msi.h	2006-03-14 19:04:47.000000000 -0500
@@ -0,0 +1,71 @@
+#ifndef __LINUX_MSI_H
+#define __LINUX_MSI_H
+
+#include <linux/config.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_PCI_MSI
+struct pci_dev;
+/*
+ * MSI operation vector.  Used by the msi core code (drivers/pci/msi.c)
+ * to abstract platform-specific tasks relating to MSI address generation
+ * and resource management.
+ */
+struct msi_ops {
+	/**
+	 * setup - generate an MSI bus address and data for a given vector
+	 * @pdev: PCI device context (in)
+	 * @vector: vector allocated by the msi core (in)
+	 * @addr_hi: upper 32 bits of PCI bus MSI address (out)
+	 * @addr_lo: lower 32 bits of PCI bus MSI address (out)
+	 * @data: MSI data payload (out)
+	 *
+	 * Description: The setup op is used to generate a PCI bus addres and
+	 * data which the msi core will program into the card MSI capability
+	 * registers.  The setup routine is responsible for picking an initial
+	 * cpu to target the MSI at.  The setup routine is responsible for
+	 * examining pdev to determine the MSI capabilities of the card and
+	 * generating a suitable address/data.  The setup routine is
+	 * responsible for allocating and tracking any system resources it
+	 * needs to route the MSI to the cpu it picks, and for associating
+	 * those resources with the passed in vector.
+	 *
+	 * Returns 0 if the MSI address/data was successfully setup.
+	 */
+	int	(*setup)    (struct pci_dev *pdev, unsigned int vector,
+			     u32 *addr_hi, u32 *addr_lo, u32 *data);
+
+	/**
+	 * teardown - release resources allocated by setup
+	 * @vector: vector context for resources (in)
+	 *
+	 * Description:  The teardown op is used to release any resources
+	 * that were allocated in the setup routine associated with the passed
+	 * in vector.
+	 */
+	void	(*teardown) (unsigned int vector);
+
+	/**
+	 * target - retarget an MSI at a different cpu
+	 * @vector: vector context for resources (in)
+	 * @cpu:  new cpu to direct vector at (in)
+	 * @addr_hi: new value of PCI bus upper 32 bits (in/out)
+	 * @addr_lo: new value of PCI bus lower 32 bits (in/out)
+	 *
+	 * Description:  The target op is used to redirect an MSI vector
+	 * at a different cpu.  addr_hi/addr_lo coming in are the existing
+	 * values that the MSI core has programmed into the card.  The
+	 * target code is responsible for freeing any resources (if any)
+	 * associated with the old address, and generating a new PCI bus
+	 * addr_hi/addr_lo that will redirect the vector at the indicated cpu.
+	 */
+	void	(*target)   (unsigned int vector, unsigned int cpu,
+			     u32 *addr_hi, u32 *addr_lo);
+};
+
+extern struct msi_ops msi_apic_ops;
+int msi_register(struct msi_ops *ops);
+#endif
+
+#include <asm/msi.h>
+#endif /* __LINUX_MSI_H */
--- linux-2.6.16-rc6-mm1.orig/drivers/pci/msi.h	2006-03-14 19:01:11.000000000 -0500
+++ linux-2.6.16-rc6-mm1/drivers/pci/msi.h	2006-03-14 18:28:50.000000000 -0500
@@ -6,7 +6,7 @@
 #ifndef MSI_H
 #define MSI_H
 
-#include <asm/msi.h>
+#include <linux/msi.h>
 
 /*
  * Assume the maximum number of hot plug slots supported by the system is about
@@ -82,62 +82,4 @@ struct msi_desc {
 	void __iomem *mask_base;
 	struct pci_dev *dev;
 };
-
-/*
- * MSI operation vector.  Used by the msi core code (drivers/pci/msi.c)
- * to abstract platform-specific tasks relating to MSI address generation
- * and resource management.
- */
-struct msi_ops {
-	/**
-	 * setup - generate an MSI bus address and data for a given vector
-	 * @pdev: PCI device context (in)
-	 * @vector: vector allocated by the msi core (in)
-	 * @addr_hi: upper 32 bits of PCI bus MSI address (out)
-	 * @addr_lo: lower 32 bits of PCI bus MSI address (out)
-	 * @data: MSI data payload (out)
-	 *
-	 * Description: The setup op is used to generate a PCI bus addres and
-	 * data which the msi core will program into the card MSI capability
-	 * registers.  The setup routine is responsible for picking an initial
-	 * cpu to target the MSI at.  The setup routine is responsible for
-	 * examining pdev to determine the MSI capabilities of the card and
-	 * generating a suitable address/data.  The setup routine is
-	 * responsible for allocating and tracking any system resources it
-	 * needs to route the MSI to the cpu it picks, and for associating
-	 * those resources with the passed in vector.
-	 *
-	 * Returns 0 if the MSI address/data was successfully setup.
-	 */
-	int	(*setup)    (struct pci_dev *pdev, unsigned int vector,
-			     u32 *addr_hi, u32 *addr_lo, u32 *data);
-
-	/**
-	 * teardown - release resources allocated by setup
-	 * @vector: vector context for resources (in)
-	 *
-	 * Description:  The teardown op is used to release any resources
-	 * that were allocated in the setup routine associated with the passed
-	 * in vector.
-	 */
-	void	(*teardown) (unsigned int vector);
-
-	/**
-	 * target - retarget an MSI at a different cpu
-	 * @vector: vector context for resources (in)
-	 * @cpu:  new cpu to direct vector at (in)
-	 * @addr_hi: new value of PCI bus upper 32 bits (in/out)
-	 * @addr_lo: new value of PCI bus lower 32 bits (in/out)
-	 *
-	 * Description:  The target op is used to redirect an MSI vector
-	 * at a different cpu.  addr_hi/addr_lo coming in are the existing
-	 * values that the MSI core has programmed into the card.  The
-	 * target code is responsible for freeing any resources (if any)
-	 * associated with the old address, and generating a new PCI bus
-	 * addr_hi/addr_lo that will redirect the vector at the indicated cpu.
-	 */
-	void	(*target)   (unsigned int vector, unsigned int cpu,
-			     u32 *addr_hi, u32 *addr_lo);
-};
-
 #endif /* MSI_H */
--- linux-2.6.16-rc6-mm1.orig/drivers/pci/pci.h	2006-03-14 17:01:54.000000000 -0500
+++ linux-2.6.16-rc6-mm1/drivers/pci/pci.h	2006-03-14 19:08:53.000000000 -0500
@@ -48,14 +48,11 @@ extern int pci_msi_quirk;
 #define pci_msi_quirk 0
 #endif
 
-struct msi_ops;
 #ifdef CONFIG_PCI_MSI
 void disable_msi_mode(struct pci_dev *dev, int pos, int type);
-int msi_register(struct msi_ops *ops);
 void pci_no_msi(void);
 #else
 static inline void disable_msi_mode(struct pci_dev *dev, int pos, int type) { }
-static inline int msi_register(struct msi_ops *ops) { return 0; }
 static inline void pci_no_msi(void) { }
 #endif
 
--- linux-2.6.16-rc6-mm1.orig/include/asm-ia64/msi.h	2006-03-14 13:54:11.000000000 -0500
+++ linux-2.6.16-rc6-mm1/include/asm-ia64/msi.h	2006-03-14 16:50:01.000000000 -0500
@@ -14,8 +14,6 @@ static inline void set_intr_gate (int nr
 #define ack_APIC_irq		ia64_eoi
 #define MSI_TARGET_CPU_SHIFT	4
 
-extern struct msi_ops msi_apic_ops;
-
 /* default ia64 msi init routine */
 static inline int ia64_msi_init(void)
 {
--- linux-2.6.16-rc6-mm1.orig/include/asm-i386/msi.h	2006-03-14 14:03:57.000000000 -0500
+++ linux-2.6.16-rc6-mm1/include/asm-i386/msi.h	2006-03-14 17:05:54.000000000 -0500
@@ -12,8 +12,6 @@
 #define LAST_DEVICE_VECTOR		232
 #define MSI_TARGET_CPU_SHIFT	12
 
-extern struct msi_ops msi_apic_ops;
-
 static inline int msi_arch_init(void)
 {
 	msi_register(&msi_apic_ops);
--- linux-2.6.16-rc6-mm1.orig/include/asm-x86_64/msi.h	2006-03-14 14:04:54.000000000 -0500
+++ linux-2.6.16-rc6-mm1/include/asm-x86_64/msi.h	2006-03-14 17:06:08.000000000 -0500
@@ -13,8 +13,6 @@
 #define LAST_DEVICE_VECTOR		232
 #define MSI_TARGET_CPU_SHIFT	12
 
-extern struct msi_ops msi_apic_ops;
-
 static inline int msi_arch_init(void)
 {
 	msi_register(&msi_apic_ops);
--- linux-2.6.16-rc6-mm1.orig/arch/ia64/sn/pci/msi.c	2006-03-14 18:13:18.000000000 -0500
+++ linux-2.6.16-rc6-mm1/arch/ia64/sn/pci/msi.c	2006-03-14 18:12:50.000000000 -0500
@@ -10,7 +10,7 @@
 #include <linux/pci.h>
 #include <linux/cpumask.h>
 
-#include <asm/msi.h>
+#include <linux/msi.h>
 
 #include <asm/sn/addrs.h>
 #include <asm/sn/intr.h>

--------------080407020806080109070002--
