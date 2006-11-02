Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752676AbWKBVuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbWKBVuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbWKBVts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:49:48 -0500
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:38665 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1752676AbWKBVto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:49:44 -0500
From: muli@il.ibm.com
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, muli@il.ibm.com,
       jdmason@kudzu.us
Subject: [PATCH 4/4] Calgary: allow compiling Calgary in but not using it by default
Reply-To: muli@il.ibm.com
Date: Thu, 02 Nov 2006 23:49:40 +0200
Message-Id: <11625041802906-git-send-email-muli@il.ibm.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11625041802404-git-send-email-muli@il.ibm.com>
References: <11625041803066-git-send-email-muli@il.ibm.com> <11625041802816-git-send-email-muli@il.ibm.com> <1162504180570-git-send-email-muli@il.ibm.com> <11625041802404-git-send-email-muli@il.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muli Ben-Yehuda <muli@il.ibm.com>

This patch makes it possible to compile Calgary in but not use it by
default. In this mode, use 'iommu=calgary' to activate it.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 Documentation/x86_64/boot-options.txt |    3 ++-
 arch/x86_64/Kconfig                   |   11 +++++++++++
 arch/x86_64/kernel/pci-calgary.c      |    9 +++++++++
 arch/x86_64/kernel/pci-dma.c          |    5 +++++
 include/asm-x86_64/calgary.h          |    2 ++
 5 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/Documentation/x86_64/boot-options.txt b/Documentation/x86_64/boot-options.txt
index f3c57f4..5c86ed6 100644
--- a/Documentation/x86_64/boot-options.txt
+++ b/Documentation/x86_64/boot-options.txt
@@ -183,7 +183,7 @@ PCI
 IOMMU
 
  iommu=[size][,noagp][,off][,force][,noforce][,leak][,memaper[=order]][,merge]
-         [,forcesac][,fullflush][,nomerge][,noaperture]
+         [,forcesac][,fullflush][,nomerge][,noaperture][,calgary]
    size  set size of iommu (in bytes)
    noagp don't initialize the AGP driver and use full aperture.
    off   don't use the IOMMU
@@ -204,6 +204,7 @@ IOMMU
 	    buffering.
    nodac    Forbid DMA >4GB
    panic    Always panic when IOMMU overflows
+   calgary  Use the Calgary IOMMU if it is available
 
   swiotlb=pages[,force]
 
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 010d226..5cb509d 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -455,6 +455,17 @@ config CALGARY_IOMMU
 	  Normally the kernel will make the right choice by itself.
 	  If unsure, say Y.
 
+config CALGARY_IOMMU_ENABLED_BY_DEFAULT
+	bool "Should Calgary be enabled by default?"
+	default y
+	depends on CALGARY_IOMMU
+	help
+	  Should Calgary be enabled by default? if you choose 'y', Calgary
+	  will be used (if it exists). If you choose 'n', Calgary will not be
+	  used even if it exists. If you choose 'n' and would like to use
+	  Calgary anyway, pass 'iommu=calgary' on the kernel command line.
+	  If unsure, say Y.
+
 # need this always selected by IOMMU for the VIA workaround
 config SWIOTLB
 	bool
diff --git a/arch/x86_64/kernel/pci-calgary.c b/arch/x86_64/kernel/pci-calgary.c
index eaa8d31..16889b7 100644
--- a/arch/x86_64/kernel/pci-calgary.c
+++ b/arch/x86_64/kernel/pci-calgary.c
@@ -43,6 +43,12 @@ #include <asm/system.h>
 #include <asm/dma.h>
 #include <asm/rio.h>
 
+#ifdef CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT
+int use_calgary __read_mostly = 1;
+#else
+int use_calgary __read_mostly = 0;
+#endif /* CONFIG_CALGARY_DEFAULT_ENABLED */
+
 #define PCI_DEVICE_ID_IBM_CALGARY 0x02a1
 #define PCI_VENDOR_DEVICE_ID_CALGARY \
 	(PCI_VENDOR_ID_IBM | PCI_DEVICE_ID_IBM_CALGARY << 16)
@@ -1061,6 +1067,9 @@ void __init detect_calgary(void)
 	if (swiotlb || no_iommu || iommu_detected)
 		return;
 
+	if (!use_calgary)
+		return;
+
 	if (!early_pci_allowed())
 		return;
 
diff --git a/arch/x86_64/kernel/pci-dma.c b/arch/x86_64/kernel/pci-dma.c
index f8d8574..683b7a5 100644
--- a/arch/x86_64/kernel/pci-dma.c
+++ b/arch/x86_64/kernel/pci-dma.c
@@ -296,6 +296,11 @@ #ifdef CONFIG_IOMMU
 		gart_parse_options(p);
 #endif
 
+#ifdef CONFIG_CALGARY_IOMMU
+		if (!strncmp(p, "calgary", 7))
+			use_calgary = 1;
+#endif /* CONFIG_CALGARY_IOMMU */
+
 		p += strcspn(p, ",");
 		if (*p == ',')
 			++p;
diff --git a/include/asm-x86_64/calgary.h b/include/asm-x86_64/calgary.h
index 6b93f5a..7ee9006 100644
--- a/include/asm-x86_64/calgary.h
+++ b/include/asm-x86_64/calgary.h
@@ -51,6 +51,8 @@ #define TCE_TABLE_SIZE_2M		5
 #define TCE_TABLE_SIZE_4M		6
 #define TCE_TABLE_SIZE_8M		7
 
+extern int use_calgary;
+
 #ifdef CONFIG_CALGARY_IOMMU
 extern int calgary_iommu_init(void);
 extern void detect_calgary(void);
-- 
1.4.1

