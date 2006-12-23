Return-Path: <linux-kernel-owner+w=401wt.eu-S1753348AbWLWBUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbWLWBUU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 20:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbWLWBUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 20:20:20 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:44183 "EHLO
	mail01.miraclelinux.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753348AbWLWBUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 20:20:17 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH] arch/i386/pci/mmconfig.c tlb flush fix
From: OGAWA Hirofumi <hogawa@miraclelinux.com>
Date: Sat, 23 Dec 2006 10:00:43 +0900
Message-ID: <lrk60jctok.fsf@dhcp-0242.miraclelinux.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
a previous TLB cache. This problem became the cause of several strange
behavior.

This patches fixes this situation by adds "mmcfg_last_accessed_cpu" check.

Signed-off-by: OGAWA Hirofumi <hogawa@miraclelinux.com>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/i386/pci/mmconfig.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff -puN arch/i386/pci/mmconfig.c~i386-mmconfig-flush arch/i386/pci/mmconfig.c
--- linux-2.6/arch/i386/pci/mmconfig.c~i386-mmconfig-flush	2006-10-06 08:38:33.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/mmconfig.c	2006-10-06 08:38:33.000000000 +0900
@@ -26,6 +26,7 @@
 
 /* The base address of the last MMCONFIG device accessed */
 static u32 mmcfg_last_accessed_device;
+static int mmcfg_last_accessed_cpu;
 
 static DECLARE_BITMAP(fallback_slots, MAX_CHECK_BUS*32);
 
@@ -73,8 +74,11 @@ static u32 get_base_addr(unsigned int se
 static void pci_exp_set_dev_base(unsigned int base, int bus, int devfn)
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
