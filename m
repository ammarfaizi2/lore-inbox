Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbUKHW4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUKHW4c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUKHW4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:56:32 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:44281 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261285AbUKHW43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:56:29 -0500
Message-ID: <418FF992.8040604@mvista.com>
Date: Mon, 08 Nov 2004 15:56:18 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH][PPC32] Add setup_indirect_pci_nomap() routine
Content-Type: multipart/mixed;
 boundary="------------000308090204000708050402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------000308090204000708050402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds a routine that sets up indirect pci config space access 
but doesn't ioremap the config space addr/data registers.

Signed-off-by: Mark Greer <mgreer@mvista.com>

--------------000308090204000708050402
Content-Type: text/plain;
 name="indirect_pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="indirect_pci.patch"

===== arch/ppc/syslib/indirect_pci.c 1.12 vs edited =====
--- 1.12/arch/ppc/syslib/indirect_pci.c	2004-03-17 05:02:23 -07:00
+++ edited/arch/ppc/syslib/indirect_pci.c	2004-10-12 14:24:23 -07:00
@@ -112,15 +112,24 @@
 };
 
 void __init
+setup_indirect_pci_nomap(struct pci_controller* hose, u32 cfg_addr,
+	u32 cfg_data)
+{
+	hose->cfg_addr = (unsigned int *)cfg_addr;
+	hose->cfg_data = (unsigned char *)cfg_data;
+	hose->ops = &indirect_pci_ops;
+}
+
+void __init
 setup_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
 {
 	unsigned long base = cfg_addr & PAGE_MASK;
 	char *mbase;
 
 	mbase = ioremap(base, PAGE_SIZE);
-	hose->cfg_addr = (unsigned int *)(mbase + (cfg_addr & ~PAGE_MASK));
+	cfg_addr = (u32)(mbase + (cfg_addr & ~PAGE_MASK));
 	if ((cfg_data & PAGE_MASK) != base)
 		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
-	hose->cfg_data = (unsigned char *)(mbase + (cfg_data & ~PAGE_MASK));
-	hose->ops = &indirect_pci_ops;
+	cfg_data = (u32)(mbase + (cfg_data & ~PAGE_MASK));
+	setup_indirect_pci_nomap(hose, cfg_addr, cfg_data);
 }
===== include/asm-ppc/pci-bridge.h 1.12 vs edited =====
--- 1.12/include/asm-ppc/pci-bridge.h	2003-09-12 09:26:56 -07:00
+++ edited/include/asm-ppc/pci-bridge.h	2004-10-12 14:23:36 -07:00
@@ -94,6 +94,8 @@
 int early_write_config_dword(struct pci_controller *hose, int bus, int dev_fn,
 			     int where, u32 val);
 
+extern void setup_indirect_pci_nomap(struct pci_controller* hose,
+			       u32 cfg_addr, u32 cfg_data);
 extern void setup_indirect_pci(struct pci_controller* hose,
 			       u32 cfg_addr, u32 cfg_data);
 extern void setup_grackle(struct pci_controller *hose);

--------------000308090204000708050402--

