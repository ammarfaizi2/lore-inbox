Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbUDRAEO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbUDRADe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:03:34 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17310 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264084AbUDRAAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:00:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE cleanups/fixups for 2.6.6-rc1 [3/3]
Date: Sun, 18 Apr 2004 01:59:54 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404180155.26159.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just introduced CONFIG_M68KNOMMU because I couldn't find
single define identifying this arch, did I miss something?

[PATCH] generic ide_init_hwif_ports()

Add generic ide_init_hwif_ports() to <linux/ide.h> and remove arch specific
versions except arm26, arm, h8300, i386-pc9800, m68k and m68knommu ones.

 linux-2.6.5-bk2-bzolnier/arch/m68knommu/Kconfig              |    4 +
 linux-2.6.5-bk2-bzolnier/include/asm-alpha/ide.h             |   20 -----
 linux-2.6.5-bk2-bzolnier/include/asm-i386/ide.h              |   11 --
 linux-2.6.5-bk2-bzolnier/include/asm-ia64/ide.h              |   20 -----
 linux-2.6.5-bk2-bzolnier/include/asm-mips/mach-generic/ide.h |   20 -----
 linux-2.6.5-bk2-bzolnier/include/asm-parisc/ide.h            |   20 -----
 linux-2.6.5-bk2-bzolnier/include/asm-ppc/ide.h               |   27 -------
 linux-2.6.5-bk2-bzolnier/include/asm-ppc64/ide.h             |   20 -----
 linux-2.6.5-bk2-bzolnier/include/asm-sh/ide.h                |   20 -----
 linux-2.6.5-bk2-bzolnier/include/asm-sparc/ide.h             |   23 ------
 linux-2.6.5-bk2-bzolnier/include/asm-sparc64/ide.h           |   19 -----
 linux-2.6.5-bk2-bzolnier/include/asm-x86_64/ide.h            |   20 -----
 linux-2.6.5-bk2-bzolnier/include/linux/ide.h                 |   41 +++++++++++
 13 files changed, 48 insertions(+), 217 deletions(-)

diff -puN arch/m68knommu/Kconfig~ide_init_hwif_ports arch/m68knommu/Kconfig
--- linux-2.6.5-bk2/arch/m68knommu/Kconfig~ide_init_hwif_ports	2004-04-18 01:16:06.473133848 +0200
+++ linux-2.6.5-bk2-bzolnier/arch/m68knommu/Kconfig	2004-04-18 01:16:06.529125336 +0200
@@ -5,6 +5,10 @@
 
 mainmenu "uClinux/68k (w/o MMU) Kernel Configuration"
 
+config M68KNOMMU
+	bool
+	default y
+
 config MMU
 	bool
 	default n
diff -puN include/asm-alpha/ide.h~ide_init_hwif_ports include/asm-alpha/ide.h
--- linux-2.6.5-bk2/include/asm-alpha/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.484132176 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-alpha/ide.h	2004-04-18 01:16:06.530125184 +0200
@@ -43,26 +43,6 @@ static inline unsigned long ide_default_
 	}
 }
 
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
 #ifdef CONFIG_PCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-i386/ide.h~ide_init_hwif_ports include/asm-i386/ide.h
--- linux-2.6.5-bk2/include/asm-i386/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.487131720 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-i386/ide.h	2004-04-18 01:16:06.532124880 +0200
@@ -59,29 +59,23 @@ static __inline__ unsigned long ide_defa
 	}
 }
 
+#ifdef CONFIG_X86_PC9800
 static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
 	 unsigned long ctrl_port, int *irq)
 {
 	unsigned long reg = data_port;
 	int i;
-#ifdef CONFIG_X86_PC9800
+
 	unsigned long increment = data_port == 0x640 ? 2 : 1;
-#endif
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 		hw->io_ports[i] = reg;
-#ifdef CONFIG_X86_PC9800
 		reg += increment;
-#else
-		reg += 1;
-#endif
 	}
 	if (ctrl_port) {
 		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-#ifdef CONFIG_X86_PC9800
 	} else if (data_port == 0x640) {
 		hw->io_ports[IDE_CONTROL_OFFSET] = 0x74c;
-#endif
 	} else {
 		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
 	}
@@ -89,6 +83,7 @@ static __inline__ void ide_init_hwif_por
 		*irq = 0;
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
+#endif
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
 #define ide_init_default_irq(base)	(0)
diff -puN include/asm-ia64/ide.h~ide_init_hwif_ports include/asm-ia64/ide.h
--- linux-2.6.5-bk2/include/asm-ia64/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.491131112 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-ia64/ide.h	2004-04-18 01:16:06.533124728 +0200
@@ -53,26 +53,6 @@ static inline unsigned long ide_default_
 	}
 }
 
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
 #ifdef CONFIG_PCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-mips/mach-generic/ide.h~ide_init_hwif_ports include/asm-mips/mach-generic/ide.h
--- linux-2.6.5-bk2/include/asm-mips/mach-generic/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.495130504 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-mips/mach-generic/ide.h	2004-04-18 01:16:06.533124728 +0200
@@ -48,26 +48,6 @@ static inline unsigned long ide_default_
 	}
 }
 
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-	 unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
 #ifdef CONFIG_BLK_DEV_IDEPCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-parisc/ide.h~ide_init_hwif_ports include/asm-parisc/ide.h
--- linux-2.6.5-bk2/include/asm-parisc/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.498130048 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-parisc/ide.h	2004-04-18 01:16:06.534124576 +0200
@@ -22,26 +22,6 @@
 #define ide_default_irq(base) (0)
 #define ide_default_io_base(index) (0)
 
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
 #define ide_init_default_irq(base)	(0)
 
 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
diff -puN include/asm-ppc64/ide.h~ide_init_hwif_ports include/asm-ppc64/ide.h
--- linux-2.6.5-bk2/include/asm-ppc64/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.503129288 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-ppc64/ide.h	2004-04-18 01:16:06.535124424 +0200
@@ -25,26 +25,6 @@
 static inline int ide_default_irq(unsigned long base) { return 0; }
 static inline unsigned long ide_default_io_base(int index) { return 0; }
 
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
 #define ide_init_default_irq(base)	(0)
 
 #endif /* __KERNEL__ */
diff -puN include/asm-ppc/ide.h~ide_init_hwif_ports include/asm-ppc/ide.h
--- linux-2.6.5-bk2/include/asm-ppc/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.506128832 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-ppc/ide.h	2004-04-18 01:16:06.535124424 +0200
@@ -57,33 +57,6 @@ static __inline__ unsigned long ide_defa
 	return 0;
 }
 
-/*
- * This is only used for PC-style IDE controllers (e.g. as on PReP)
- * or for PCI IDE devices, not for other types of IDE interface such
- * as the pmac IDE interfaces.
- */
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw,
-					   unsigned long data_port,
-					   unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
-		hw->io_ports[i] = reg++;
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] =
-			hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-	if (ppc_ide_md.ide_init_hwif != NULL)
-		ppc_ide_md.ide_init_hwif(hw, data_port, ctrl_port, irq);
-}
-
 #ifdef CONFIG_PCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-sh/ide.h~ide_init_hwif_ports include/asm-sh/ide.h
--- linux-2.6.5-bk2/include/asm-sh/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.510128224 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-sh/ide.h	2004-04-18 01:16:06.536124272 +0200
@@ -72,26 +72,6 @@ static inline unsigned long ide_default_
 	}
 }
 
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
 #ifdef CONFIG_PCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-sparc64/ide.h~ide_init_hwif_ports include/asm-sparc64/ide.h
--- linux-2.6.5-bk2/include/asm-sparc64/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.513127768 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-sparc64/ide.h	2004-04-18 01:16:06.537124120 +0200
@@ -34,25 +34,6 @@ static __inline__ unsigned long ide_defa
 	return 0;
 }
 
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port, unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
 #define ide_init_default_irq(base)	(0)
 
 #define __ide_insl(data_reg, buffer, wcount) \
diff -puN include/asm-sparc/ide.h~ide_init_hwif_ports include/asm-sparc/ide.h
--- linux-2.6.5-bk2/include/asm-sparc/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.517127160 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-sparc/ide.h	2004-04-18 01:16:06.537124120 +0200
@@ -29,29 +29,6 @@ static __inline__ unsigned long ide_defa
 	return 0;
 }
 
-/*
- * Doing any sort of ioremap() here does not work
- * because this function may be called with null aguments.
- */
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port, unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
 #define ide_init_default_irq(base)	(0)
 
 #define __ide_insl(data_reg, buffer, wcount) \
diff -puN include/asm-x86_64/ide.h~ide_init_hwif_ports include/asm-x86_64/ide.h
--- linux-2.6.5-bk2/include/asm-x86_64/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.520126704 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-x86_64/ide.h	2004-04-18 01:16:06.538123968 +0200
@@ -51,26 +51,6 @@ static __inline__ unsigned long ide_defa
 	}
 }
 
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-	 unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
 #ifdef CONFIG_BLK_DEV_IDEPCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/linux/ide.h~ide_init_hwif_ports include/linux/ide.h
--- linux-2.6.5-bk2/include/linux/ide.h~ide_init_hwif_ports	2004-04-18 01:16:06.525125944 +0200
+++ linux-2.6.5-bk2-bzolnier/include/linux/ide.h	2004-04-18 01:24:00.033141784 +0200
@@ -293,8 +293,49 @@ void ide_setup_ports(	hw_regs_t *hw,
 #endif
 			int irq);
 
+static inline void ide_std_init_ports(hw_regs_t *hw,
+				      unsigned long io_addr,
+				      unsigned long ctl_addr)
+{
+	unsigned int i;
+
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
+		hw->io_ports[i] = io_addr++;
+
+	hw->io_ports[IDE_CONTROL_OFFSET] = ctl_addr;
+}
+
 #include <asm/ide.h>
 
+/*
+ * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
+ *
+ * arm26, arm, h8300, m68k, m68knommu and i386-pc9800 still have own versions.
+ */
+#if !defined(CONFIG_ARM) && !defined(CONFIG_H8300) && !defined(CONFIG_M68K) && \
+    !defined(CONFIG_M68KNOMMU) && !defined(CONFIG_X86_PC9800)
+static inline void ide_init_hwif_ports(hw_regs_t *hw,
+				       unsigned long io_addr,
+				       unsigned long ctl_addr,
+				       int *irq)
+{
+	if (!ctl_addr)
+		ide_std_init_ports(hw, io_addr, io_addr + 0x206);
+	else
+		ide_std_init_ports(hw, io_addr, ctl_addr);
+
+	if (irq)
+		*irq = 0;
+
+	hw->io_ports[IDE_IRQ_OFFSET] = 0;
+
+#ifdef CONFIG_PPC32
+	if (ppc_ide_md.ide_init_hwif)
+		ppc_ide_md.ide_init_hwif(hw, io_addr, ctl_addr, irq);
+#endif
+}
+#endif /* !ARM && !H8300 && !M68K && !M68KNOMMU && !X86_PC9800 */
+
 /* Currently only m68k, apus and m8xx need it */
 #ifndef IDE_ARCH_ACK_INTR
 # define ide_ack_intr(hwif) (1)

_

