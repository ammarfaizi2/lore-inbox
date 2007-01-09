Return-Path: <linux-kernel-owner+w=401wt.eu-S932375AbXAITAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbXAITAR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbXAITAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:00:16 -0500
Received: from mail.parknet.jp ([210.171.160.80]:4217 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932439AbXAITAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:00:13 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH 2/4] MMCONFIG: Reject a broken MCFG tables on Asus etc
References: <878xgc58nc.fsf@duaron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Jan 2007 04:00:08 +0900
In-Reply-To: <878xgc58nc.fsf@duaron.myhome.or.jp> (OGAWA Hirofumi's message of "Wed\, 10 Jan 2007 03\:59\:03 +0900")
Message-ID: <871wm458lj.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This rejects a broken MCFG tables on Asus etc.
Arjan and Andi suggest this.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/i386/pci/mmconfig-shared.c |   24 +++++++++++++++++++++++-
 arch/i386/pci/mmconfig.c        |    9 ---------
 arch/x86_64/pci/mmconfig.c      |    9 ---------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff -puN arch/i386/pci/mmconfig-shared.c~pci-mmconfig-reject-mcfg_broken arch/i386/pci/mmconfig-shared.c
--- linux-2.6/arch/i386/pci/mmconfig-shared.c~pci-mmconfig-reject-mcfg_broken	2007-01-06 00:43:43.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/mmconfig-shared.c	2007-01-06 00:43:43.000000000 +0900
@@ -184,6 +184,26 @@ static void __init pci_mmcfg_insert_reso
 	}
 }
 
+static void __init pci_mmcfg_reject_broken(void)
+{
+	struct acpi_table_mcfg_config *cfg = &pci_mmcfg_config[0];
+
+	/*
+	 * Handle more broken MCFG tables on Asus etc.
+	 * They only contain a single entry for bus 0-0.
+	 */
+	if (pci_mmcfg_config_num == 1 &&
+	    cfg->pci_segment_group_number == 0 &&
+	    (cfg->start_bus_number | cfg->end_bus_number) == 0) {
+		kfree(pci_mmcfg_config);
+		pci_mmcfg_config = NULL;
+		pci_mmcfg_config_num = 0;
+
+		printk(KERN_ERR "PCI: start and end of bus number is 0. "
+		       "Rejected as broken MCFG.");
+	}
+}
+
 void __init pci_mmcfg_init(int type)
 {
 	int known_bridge = 0;
@@ -194,8 +214,10 @@ void __init pci_mmcfg_init(int type)
 	if (type == 1 && pci_mmcfg_check_hostbridge())
 		known_bridge = 1;
 
-	if (!known_bridge)
+	if (!known_bridge) {
 		acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+		pci_mmcfg_reject_broken();
+	}
 
 	if ((pci_mmcfg_config_num == 0) ||
 	    (pci_mmcfg_config == NULL) ||
diff -puN arch/i386/pci/mmconfig.c~pci-mmconfig-reject-mcfg_broken arch/i386/pci/mmconfig.c
--- linux-2.6/arch/i386/pci/mmconfig.c~pci-mmconfig-reject-mcfg_broken	2007-01-06 00:43:43.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/mmconfig.c	2007-01-06 00:43:43.000000000 +0900
@@ -42,15 +42,6 @@ static u32 get_base_addr(unsigned int se
 			return cfg->base_address;
 	}
 
-	/* Handle more broken MCFG tables on Asus etc.
-	   They only contain a single entry for bus 0-0. Assume
- 	   this applies to all busses. */
-	cfg = &pci_mmcfg_config[0];
-	if (pci_mmcfg_config_num == 1 &&
-		cfg->pci_segment_group_number == 0 &&
-		(cfg->start_bus_number | cfg->end_bus_number) == 0)
-		return cfg->base_address;
-
 	/* Fall back to type 0 */
 	return 0;
 }
diff -puN arch/x86_64/pci/mmconfig.c~pci-mmconfig-reject-mcfg_broken arch/x86_64/pci/mmconfig.c
--- linux-2.6/arch/x86_64/pci/mmconfig.c~pci-mmconfig-reject-mcfg_broken	2007-01-06 00:43:43.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/pci/mmconfig.c	2007-01-06 00:43:43.000000000 +0900
@@ -33,15 +33,6 @@ static char __iomem *get_virt(unsigned i
 			return pci_mmcfg_virt[cfg_num].virt;
 	}
 
-	/* Handle more broken MCFG tables on Asus etc.
-	   They only contain a single entry for bus 0-0. Assume
- 	   this applies to all busses. */
-	cfg = &pci_mmcfg_config[0];
-	if (pci_mmcfg_config_num == 1 &&
-		cfg->pci_segment_group_number == 0 &&
-		(cfg->start_bus_number | cfg->end_bus_number) == 0)
-		return pci_mmcfg_virt[0].virt;
-
 	/* Fall back to type 0 */
 	return NULL;
 }
_
