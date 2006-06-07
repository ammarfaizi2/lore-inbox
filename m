Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWFGDRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWFGDRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWFGDRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:17:23 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56035 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750779AbWFGDRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:17:23 -0400
Message-ID: <4486446E.6020407@jp.fujitsu.com>
Date: Wed, 07 Jun 2006 12:13:50 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, akpm@osdl.org,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2/4] Update Documentation/pci.txt
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com>
In-Reply-To: <448643B9.2080805@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the description about legacy I/O port free driver into
Documentation/pci.txt.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Grant Grundler <grundler@parisc-linux.org>

---
 Documentation/pci.txt |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+)

Index: linux-2.6.17-rc6/Documentation/pci.txt
===================================================================
--- linux-2.6.17-rc6.orig/Documentation/pci.txt	2006-06-06 21:39:11.000000000 +0900
+++ linux-2.6.17-rc6/Documentation/pci.txt	2006-06-06 21:56:32.000000000 +0900
@@ -279,3 +279,73 @@
 pci_find_device()		Superseded by pci_get_device()
 pci_find_subsys()		Superseded by pci_get_subsys()
 pci_find_slot()			Superseded by pci_get_slot()
+
+
+9. Legacy I/O port free driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Large servers may not be able to provide I/O port resources to all PCI
+devices. I/O Port space is only 64KB on Intel Architecture[1] and is
+likely also fragmented since the I/O base register of PCI-to-PCI
+bridge will usually be aligned to a 4KB boundary[2]. On such systems,
+pci_enable_device() and pci_request_regions() will fail when
+attempting to enable I/O Port regions that don't have I/O Port
+resources assigned.
+
+Fortunately, many PCI devices which request I/O Port resources also
+provide access to the same registers via MMIO BARs. These devices can
+be handled without using I/O port space and the drivers typically
+offer a CONFIG_ option to only use MMIO regions
+(e.g. CONFIG_TULIP_MMIO). PCI devices typically provide I/O port
+interface for legacy OSs and will work when I/O port resources are not
+assigned. The "PCI Local Bus Specification Revision 3.0" discusses
+this on p.44, "IMPLEMENTATION NOTE".
+
+If your PCI device driver doesn't need I/O port resources assigned to
+I/O Port BARs, you should use pci_enable_device_bars() instead of
+pci_enable_device() in order not to enable I/O port regions for the
+corresponding devices. In addition, you should use
+pci_request_selected_regions()/pci_release_selected_regions() instead
+of pci_request_regions()/pci_release_regions() in order not to
+request/release I/O port regions for the corresponding devices.
+
+[1] Some systems support 64KB I/O port space per PCI segment.
+[2] Some PCI-to-PCI bridges support optional 1KB aligned I/O base.
+
+
+10. MMIO Space and "Write Posting"
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Converting a driver from using I/O Port space to using MMIO space
+often requires some additional changes. Specifically, "write posting"
+needs to be handled. Most drivers (e.g. tg3, acenic, sym53c8xx_2)
+already do. I/O Port space guarantees write transactions reach the PCI
+device before the CPU can continue. Writes to MMIO space allow to CPU
+continue before the transaction reaches the PCI device. HW weenies
+call this "Write Posting" because the write completion is "posted" to
+the CPU before the transaction has reached it's destination.
+
+Thus, timing sensitive code should add readl() where the CPU is
+expected to wait before doing other work.  The classic "bit banging"
+sequence works fine for I/O Port space:
+
+	for (i=8; --i; val >>= 1) {
+		outb(val & 1, ioport_reg);	/* write bit */
+		udelay(10);
+	}
+
+The same sequence for MMIO space should be:
+
+	for (i=8; --i; val >>= 1) {
+		writeb(val & 1, mmio_reg);	/* write bit */
+		readb(safe_mmio_reg);		/* flush posted write */
+		udelay(10);
+	}
+
+It is important that "safe_mmio_reg" not have any side effects that
+interferes with the correct operation of the device.
+
+Another case to watch out for is when resetting a PCI device. Use PCI
+Configuration space reads to flush the writel(). This will gracefully
+handle the PCI master abort on all platforms if the PCI device is
+expected to not respond to a readl().  Most x86 platforms will allow
+MMIO reads to master abort (aka "Soft Fail") and return garbage
+(e.g. ~0). But many RISC platforms will crash (aka "Hard Fail").

