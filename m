Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUJSCAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUJSCAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 22:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUJSCAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 22:00:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:18575 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268282AbUJSB7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:59:10 -0400
Subject: [PATCH] ppc64: Fix iSeries build (ouch !)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041018230529.GB31577@redhat.com>
References: <20041018230529.GB31577@redhat.com>
Content-Type: text/plain
Message-Id: <1098150871.11449.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 11:54:31 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The move of iomap out of eeh inadvertently broke iSeries ... This
patch fixes it. Please apply.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== include/asm-ppc64/eeh.h 1.20 vs edited =====
--- 1.20/include/asm-ppc64/eeh.h	2004-10-06 16:05:23 +10:00
+++ edited/include/asm-ppc64/eeh.h	2004-10-19 09:31:54 +10:00
@@ -256,10 +256,6 @@
 
 #undef EEH_CHECK_ALIGN
 
-#define MAX_ISA_PORT 0x10000
-extern unsigned long io_page_mask;
-#define _IO_IS_VALID(port) ((port) >= MAX_ISA_PORT || (1 << (port>>PAGE_SHIFT)) & io_page_mask)
-
 static inline u8 eeh_inb(unsigned long port) {
 	u8 val;
 	if (!_IO_IS_VALID(port))
===== include/asm-ppc64/io.h 1.22 vs edited =====
--- 1.22/include/asm-ppc64/io.h	2004-09-21 19:14:10 +10:00
+++ edited/include/asm-ppc64/io.h	2004-10-19 09:32:20 +10:00
@@ -33,6 +33,12 @@
 
 extern unsigned long isa_io_base;
 extern unsigned long pci_io_base;
+extern unsigned long io_page_mask;
+
+#define MAX_ISA_PORT 0x10000
+
+#define _IO_IS_VALID(port) ((port) >= MAX_ISA_PORT || (1 << (port>>PAGE_SHIFT)) \
+			    & io_page_mask)
 
 #ifdef CONFIG_PPC_ISERIES
 /* __raw_* accessors aren't supported on iSeries */
===== arch/ppc64/kernel/iSeries_pci.c 1.24 vs edited =====
--- 1.24/arch/ppc64/kernel/iSeries_pci.c	2004-09-11 15:50:12 +10:00
+++ edited/arch/ppc64/kernel/iSeries_pci.c	2004-10-19 11:02:20 +10:00
@@ -55,6 +55,7 @@
 extern unsigned long iSeries_Base_Io_Memory;    
 
 extern struct iommu_table *tceTables[256];
+extern unsigned long io_page_mask;
 
 extern void iSeries_MmIoTest(void);
 
@@ -196,6 +197,7 @@
 	PPCDBG(PPCDBG_BUSWALK, "iSeries_pcibios_init Entry.\n"); 
 	iSeries_IoMmTable_Initialize();
 	find_and_init_phbs();
+	io_page_mask = -1;
 	/* pci_assign_all_busses = 0;		SFRXXX*/
 	PPCDBG(PPCDBG_BUSWALK, "iSeries_pcibios_init Exit.\n"); 
 }


