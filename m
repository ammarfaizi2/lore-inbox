Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293028AbSCJMzG>; Sun, 10 Mar 2002 07:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293030AbSCJMy5>; Sun, 10 Mar 2002 07:54:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:48994 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293028AbSCJMyr>;
	Sun, 10 Mar 2002 07:54:47 -0500
Date: Sun, 10 Mar 2002 13:54:39 +0100
From: Tobias Diedrich <ranma@gmx.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] ite8330g pirq router support
Message-ID: <20020310125439.GA4825@router.ranmachan.dyndns.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch adds support for the pirq router of the ITE8330G
chipset my notebook is using. The pirqmap is probably partly wrong though,
as the BIOS does a very bad job at setting up the irq routing table...

Against 2.4.19-pre2-ac4.

diff -urN linux-2.4.19-pre2-ac4/arch/i386/kernel/pci-irq.c linux-2.4.19-pre2-ac4-ite8330g/arch/i386/kernel/pci-irq.c
--- linux-2.4.19-pre2-ac4/arch/i386/kernel/pci-irq.c	Sun Mar 10 13:26:16 2002
+++ linux-2.4.19-pre2-ac4-ite8330g/arch/i386/kernel/pci-irq.c	Sun Mar 10 13:39:25 2002
@@ -208,6 +208,24 @@
 }
 
 /*
+ * ITE 8330G pirq rules are nibble-based
+ * FIXME: pirqmap may be { 1, 0, 3, 2 },
+ * 	  2+3 are both mapped to irq 9 on my system
+ */
+static int pirq_ite_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	static unsigned char pirqmap[4] = { 1, 0, 2, 3 };
+	return read_config_nybble(router,0x43, pirqmap[pirq-1]);
+}
+
+static int pirq_ite_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+{
+	static unsigned char pirqmap[4] = { 1, 0, 2, 3 };
+	write_config_nybble(router, 0x43, pirqmap[pirq-1], irq);
+	return 1;
+}
+
+/*
  * OPTI: high four bits are nibble pointer..
  * I wonder what the low bits do?
  */
@@ -448,6 +466,8 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, pirq_piix_get, pirq_piix_set },
 
 	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
+
+	{ "ITE", PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_IT8330G_0, pirq_ite_get, pirq_ite_set },
 
 	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, pirq_via_get, pirq_via_set },
 	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596, pirq_via_get, pirq_via_set },
diff -urN linux-2.4.19-pre2-ac4/include/linux/pci_ids.h linux-2.4.19-pre2-ac4-ite8330g/include/linux/pci_ids.h
--- linux-2.4.19-pre2-ac4/include/linux/pci_ids.h	Sun Mar 10 13:26:03 2002
+++ linux-2.4.19-pre2-ac4-ite8330g/include/linux/pci_ids.h	Sun Mar 10 13:38:48 2002
@@ -1291,7 +1291,7 @@
 #define PCI_DEVICE_ID_ITE_IT8172G	0x8172
 #define PCI_DEVICE_ID_ITE_IT8172G_AUDIO 0x0801
 #define PCI_DEVICE_ID_ITE_8872		0x8872
-
+#define PCI_DEVICE_ID_ITE_IT8330G_0	0xe886
 
 /* formerly Platform Tech */
 #define PCI_VENDOR_ID_ESS_OLD		0x1285

-- 
Tobias								PGP: 0x9AC7E0BC
