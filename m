Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbUKVWIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbUKVWIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUKVWGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:06:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30852 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262407AbUKVWDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:03:20 -0500
Date: Mon, 22 Nov 2004 15:26:06 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [sezeroz@ttnet.net.tr: [PATCH] [RESEND] OPTI Viper-M/N+ chipset support (by Michael Mueller)]
Message-ID: <20041122172606.GB30554@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, 

Sounds like similar quirk should go into v2.6 too.

----- Forwarded message from "O.Sezer" <sezeroz@ttnet.net.tr> -----

From: "O.Sezer" <sezeroz@ttnet.net.tr>
Date: Thu, 18 Nov 2004 20:04:54 +0200
To: marcelo.tosatti@cyclades.com
Subject: [PATCH] [RESEND] OPTI Viper-M/N+ chipset support (by Michael Mueller)
X-MIMETrack: Itemize by SMTP Server on USMail/Cyclades(Release 6.5.1|January 21, 2004) at
 11/18/2004 10:06:27

OPTI Viper-M/N+ chipset support (by Michael Mueller)

(could not reach Michael for an 2.6 port of this, don't
have the hardware anymore to re-test on 2.6).


--- 23/arch/i386/kernel/pci-irq.c~
+++ 23/arch/i386/kernel/pci-irq.c
@@ -241,18 +241,56 @@
 }
 
 static int pirq_opti_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
 	write_config_nybble(router, 0xb8, pirq >> 4, irq);
 	return 1;
 }
 
 /*
+ * OPTI Viper-M/N+: Bit field with 3 bits per entry.
+ * Due to the lack of a specification the information about this chipset
+ * was taken from the NetBSD source code.
+ */
+static int pirq_viper_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	static const int viper_irq_decode[] = { 0, 5, 9, 10, 11, 12, 14, 15 };
+	u32 irq;
+
+	pci_read_config_dword(router, 0x40, &irq);
+	irq >>= (pirq-1)*3;
+	irq &= 7;
+
+	return viper_irq_decode[irq];
+}
+
+static int pirq_viper_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+{
+	static const int viper_irq_map[] = { -1, -1, -1, -1, -1, 1, -1, -1, -1, 2, 3, 4, 5, -1, 6, 7 };
+	int newval = viper_irq_map[irq];
+	u32 val;
+	u32 mask = 7 << (3*(pirq-1));
+#if 0
+	mask |= 0x10000UL << (pirq-1);	/* edge triggered */
+#endif
+
+	if ( newval == -1 )
+		return 0;
+	
+	pci_read_config_dword(router, 0x40, &val);
+	val &= ~mask;
+	val |= newval << (3*(pirq-1));
+	pci_write_config_dword(router, 0x40, val);
+
+	return 1;
+}
+
+/*
  * Cyrix: nibble offset 0x5C
  */
 static int pirq_cyrix_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
 	return read_config_nybble(router, 0x5C, (pirq-1)^1);
 }
 
 static int pirq_cyrix_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
@@ -707,21 +745,28 @@
 
 static __init int opti_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
 	switch(device)
 	{
 		case PCI_DEVICE_ID_OPTI_82C700:
 			r->name = "OPTI";
 			r->get = pirq_opti_get;
 			r->set = pirq_opti_set;
-			return 1;
+			break;
+		case PCI_DEVICE_ID_OPTI_82C558:
+			r->name = "OPTI VIPER";
+			r->get = pirq_viper_get;
+			r->set = pirq_viper_set;
+			break;
+		default:
+			return 0;
 	}
-	return 0;
+	return 1;
 }
 
 static __init int ite_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
 	switch(device)
 	{
 		case PCI_DEVICE_ID_ITE_IT8330G_0:
 			r->name = "ITE";
 			r->get = pirq_ite_get;


----- End forwarded message -----
