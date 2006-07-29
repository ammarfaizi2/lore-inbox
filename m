Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752077AbWG2TnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbWG2TnG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWG2Tm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:42:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62172 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752078AbWG2Tmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:42:53 -0400
Date: Sat, 29 Jul 2006 21:42:46 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, betak@mpdtxmail.amd.com
Subject: [PATCH for 2.6.18] [5/8] x86_64: Revert k8-bus.c northbridge
 access change
Message-ID: <44cbba36.ZnN1E1JhDUaqcCgm%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As Travis Betak points out it accesses the wrong northbridge subfunction
now. Switch back to the old code.

Cc: "Travis Betak" <betak@mpdtxmail.amd.com>

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/pci/k8-bus.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc2-git7/arch/x86_64/pci/k8-bus.c
===================================================================
--- linux-2.6.18-rc2-git7.orig/arch/x86_64/pci/k8-bus.c
+++ linux-2.6.18-rc2-git7/arch/x86_64/pci/k8-bus.c
@@ -2,7 +2,6 @@
 #include <linux/pci.h>
 #include <asm/mpspec.h>
 #include <linux/cpumask.h>
-#include <asm/k8.h>
 
 /*
  * This discovers the pcibus <-> node mapping on AMD K8.
@@ -19,6 +18,7 @@
 #define NR_LDT_BUS_NUMBER_REGISTERS 3
 #define SECONDARY_LDT_BUS_NUMBER(dword) ((dword >> 8) & 0xFF)
 #define SUBORDINATE_LDT_BUS_NUMBER(dword) ((dword >> 16) & 0xFF)
+#define PCI_DEVICE_ID_K8HTCONFIG 0x1100
 
 /**
  * fill_mp_bus_to_cpumask()
@@ -28,7 +28,8 @@
 __init static int
 fill_mp_bus_to_cpumask(void)
 {
-	int i, j, k;
+	struct pci_dev *nb_dev = NULL;
+	int i, j;
 	u32 ldtbus, nid;
 	static int lbnr[3] = {
 		LDT_BUS_NUMBER_REGISTER_0,
@@ -36,9 +37,8 @@ fill_mp_bus_to_cpumask(void)
 		LDT_BUS_NUMBER_REGISTER_2
 	};
 
-	cache_k8_northbridges();
-	for (k = 0; k < num_k8_northbridges; k++) {
-		struct pci_dev *nb_dev = k8_northbridges[k];
+	while ((nb_dev = pci_get_device(PCI_VENDOR_ID_AMD,
+			PCI_DEVICE_ID_K8HTCONFIG, nb_dev))) {
 		pci_read_config_dword(nb_dev, NODE_ID_REGISTER, &nid);
 
 		for (i = 0; i < NR_LDT_BUS_NUMBER_REGISTERS; i++) {
