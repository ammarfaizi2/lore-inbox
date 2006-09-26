Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWIZJ2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWIZJ2G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 05:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWIZJ2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 05:28:06 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:29539 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750906AbWIZJ2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 05:28:03 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH] arch/i386/pci/mmconfig.c tlb flush fix
From: OGAWA Hirofumi <hogawa@miraclelinux.com>
Date: Tue, 26 Sep 2006 18:28:01 +0900
Message-ID: <lry7s7t1su.fsf@dhcp-0242.miraclelinux.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We use the fixmap for accessing pci config space in pci_mmcfg_read/write().
The problem is in pci_exp_set_dev_base(). It is caching a last
accessed address to avoid calling set_fixmap_nocache() whenever
pci_mmcfg_read/write() is used.

static inline void pci_exp_set_dev_base(int bus, int devfn)
{
	u32 dev_base = base | (bus << 20) | (devfn << 12);
	if (dev_base != mmcfg_last_accessed_device) {
		mmcfg_last_accessed_device = dev_base;
		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
	}
}

            cpu0                                        cpu1
  ---------------------------------------------------------------------------
    pci_mmcfg_read("device-A")
        pci_exp_set_dev_base()
            set_fixmap_nocache()
                                              pci_mmcfg_read("device-B")
                                                  pci_exp_set_dev_base()
                                                      set_fixmap_nocache()
    pci_mmcfg_read("device-B")
        pci_exp_set_dev_base()
            /* doesn't flush tlb */

But if cpus accessed the above order, the second pci_mmcfg_read() on
cpu0 doesn't flush the TLB, because "mmcfg_last_accessed_device" is
device-B.  So, second pci_mmcfg_read() on cpu0 accesses a device-A via
a previous TLB cache.

This patches fixes this situation by adds "mmcfg_last_accessed_cpu" check.

Please apply.


Signed-off-by: OGAWA Hirofumi <hogawa@miraclelinux.com>
---

 arch/i386/pci/mmconfig.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff -puN arch/i386/pci/mmconfig.c~mmconfig-tlb-race-fix arch/i386/pci/mmconfig.c
--- linux-2.6/arch/i386/pci/mmconfig.c~mmconfig-tlb-race-fix	2006-09-26 11:35:54.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/mmconfig.c	2006-09-26 11:36:54.000000000 +0900
@@ -26,6 +26,7 @@
 
 /* The base address of the last MMCONFIG device accessed */
 static u32 mmcfg_last_accessed_device;
+static int mmcfg_last_accessed_cpu;
 
 static DECLARE_BITMAP(fallback_slots, MAX_CHECK_BUS*32);
 
@@ -70,8 +71,11 @@ static u32 get_base_addr(unsigned int se
 static inline void pci_exp_set_dev_base(unsigned int base, int bus, int devfn)
 {
 	u32 dev_base = base | (bus << 20) | (devfn << 12);
-	if (dev_base != mmcfg_last_accessed_device) {
+	int cpu = smp_processor_id();
+	if (dev_base != mmcfg_last_accessed_device ||
+	    cpu != mmcfg_last_accessed_cpu) {
 		mmcfg_last_accessed_device = dev_base;
+		mmcfg_last_accessed_cpu = cpu;
 		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
 	}
 }
_

-- 
OGAWA Hirofumi <hogawa@miraclelinux.com>
