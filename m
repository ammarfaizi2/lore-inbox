Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWCGF7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWCGF7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWCGF7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:59:16 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:58323 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751157AbWCGF7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:59:15 -0500
Message-ID: <440D20D8.2030506@jp.fujitsu.com>
Date: Tue, 07 Mar 2006 14:57:44 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2/4] PCI legacy I/O port free driver (take5) - Update Documentation/pci.txt
References: <440D1FEC.1070701@jp.fujitsu.com>
In-Reply-To: <440D1FEC.1070701@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the description about legacy I/O port free driver into
Documentation/pci.txt.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 Documentation/pci.txt |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+)

Index: linux-2.6.16-rc5-mm2/Documentation/pci.txt
===================================================================
--- linux-2.6.16-rc5-mm2.orig/Documentation/pci.txt	2006-03-07 14:06:50.000000000 +0900
+++ linux-2.6.16-rc5-mm2/Documentation/pci.txt	2006-03-07 14:07:21.000000000 +0900
@@ -269,3 +269,70 @@
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
+corresponding devices.
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

