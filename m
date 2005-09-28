Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVI1MoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVI1MoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 08:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVI1MoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 08:44:10 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:33371 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751265AbVI1MoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 08:44:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=jp7tGXr3XKD9dKWn1cmpdR02/POv2Gdo24Y/Iwea4YLDshRQM9CxaGR54uGQZbErYLX4q4KbUnh7gEC1mdFlAlzHg1H3KDu6JDgMWG65/cot7hBsAI+outUjEYZipRovbEmQlIvuYB2tPCs+m+My3YqUKYM2ZG6EJUFK8bUpm/o=
From: Tejun Heo <htejun@gmail.com>
To: ak@suse.de, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050928124148.EBEDFAFE@htj.dyndns.org>
In-Reply-To: <20050928124148.EBEDFAFE@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6 01/03] i386_and_x86_64: implement dma_broken_dac() test for i386 and x86_64
Message-ID: <20050928124148.A477CC67@htj.dyndns.org>
Date: Wed, 28 Sep 2005 21:44:11 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_i386_and_x86_64_implement-dma_broken_dac.patch

	CK804 PCI bridge fails to forward DAC commands from the
	secondary bus to the primary, which is required by PCI
	specification from ver1.1.  This patch implements
	dma_broken_dac() which tests whether there is any such bridge
	among parents of a given device.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 quirks.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

Index: linux-work/arch/i386/kernel/quirks.c
===================================================================
--- linux-work.orig/arch/i386/kernel/quirks.c	2005-09-28 21:41:46.000000000 +0900
+++ linux-work/arch/i386/kernel/quirks.c	2005-09-28 21:41:46.000000000 +0900
@@ -5,6 +5,45 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 
+/*
+ * The following function is called from dma_supported and needed by
+ * both i386 and x86_64.
+ *
+ * Some bridges fail to forward DAC commands upwards even though it's
+ * required by PCI specification (from 1.1).
+ */
+static struct pci_device_id bridges_with_broken_dac[] = {
+	/* nVidia CK804 PCI Bridge */
+	{ PCI_VENDOR_ID_NVIDIA, 0x005c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ }
+};
+
+int __devinit dma_broken_dac(struct device *dev)
+{
+	struct device *bridge;
+
+	/*
+	 * Disable DAC if any parent bridge has broken DAC support on
+	 * the assumption that memory is located above host bridge.
+	 */
+	bridge = dev->parent;
+	while (bridge && bridge->bus == &pci_bus_type) {
+		const struct pci_device_id *id;
+		id = pci_match_id(bridges_with_broken_dac, to_pci_dev(bridge));
+		if (id) {
+			printk(KERN_WARNING "PCI %s: bridge %s has broken DAC support, 64bit DMA disabled\n",
+			       dev->bus_id, bridge->bus_id);
+			return 1;
+		}
+		bridge = bridge->parent;
+	}
+
+	return 0;
+}
+
+/*
+ * PCI fixups start here
+ */
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
 
 static void __devinit quirk_intel_irqbalance(struct pci_dev *dev)

