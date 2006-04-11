Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWDKKy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWDKKy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWDKKy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:54:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:14245 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750738AbWDKKyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:54:49 -0400
Date: Tue, 11 Apr 2006 12:54:48 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [5/7] i386/x86-64: Remove checks for value == NULL in PCI config space access
Message-ID: <443B8AF8.mailFPJ11RPD6@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nobody should pass NULL here. Could in theory make it a BUG, 
but the NULL pointer oops will do as well.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/pci/direct.c     |    6 ++++--
 arch/i386/pci/mmconfig.c   |    2 +-
 arch/x86_64/pci/mmconfig.c |    2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

Index: linux/arch/i386/pci/direct.c
===================================================================
--- linux.orig/arch/i386/pci/direct.c
+++ linux/arch/i386/pci/direct.c
@@ -19,7 +19,7 @@ int pci_conf1_read(unsigned int seg, uns
 {
 	unsigned long flags;
 
-	if (!value || (bus > 255) || (devfn > 255) || (reg > 255)) {
+	if ((bus > 255) || (devfn > 255) || (reg > 255)) {
 		*value = -1;
 		return -EINVAL;
 	}
@@ -94,8 +94,10 @@ static int pci_conf2_read(unsigned int s
 	unsigned long flags;
 	int dev, fn;
 
-	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
+	if ((bus > 255) || (devfn > 255) || (reg > 255)) {
+		*value = -1;
 		return -EINVAL;
+	}
 
 	dev = PCI_SLOT(devfn);
 	fn = PCI_FUNC(devfn);
Index: linux/arch/i386/pci/mmconfig.c
===================================================================
--- linux.orig/arch/i386/pci/mmconfig.c
+++ linux/arch/i386/pci/mmconfig.c
@@ -80,7 +80,7 @@ static int pci_mmcfg_read(unsigned int s
 	unsigned long flags;
 	u32 base;
 
-	if (!value || (bus > 255) || (devfn > 255) || (reg > 4095)) {
+	if ((bus > 255) || (devfn > 255) || (reg > 4095)) {
 		*value = -1;
 		return -EINVAL;
 	}
Index: linux/arch/x86_64/pci/mmconfig.c
===================================================================
--- linux.orig/arch/x86_64/pci/mmconfig.c
+++ linux/arch/x86_64/pci/mmconfig.c
@@ -75,7 +75,7 @@ static int pci_mmcfg_read(unsigned int s
 	char __iomem *addr;
 
 	/* Why do we have this when nobody checks it. How about a BUG()!? -AK */
-	if (unlikely(!value || (bus > 255) || (devfn > 255) || (reg > 4095))) {
+	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095))) {
 		*value = -1;
 		return -EINVAL;
 	}
