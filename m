Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbUJ0Mnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbUJ0Mnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbUJ0Mnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:43:42 -0400
Received: from fep03fe.ttnet.net.tr ([212.156.4.134]:25085 "EHLO
	fep03.ttnet.net.tr") by vger.kernel.org with ESMTP id S262411AbUJ0Mm5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:42:57 -0400
Message-ID: <417F9731.5040101@ttnet.net.tr>
Date: Wed, 27 Oct 2004 15:40:17 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.28-rc1
References: <417E5904.9030107@ttnet.net.tr> <20041026203334.GB29688@logos.cnet>
In-Reply-To: <20041026203334.GB29688@logos.cnet>
Content-Type: multipart/mixed;
	boundary="------------080802050707060106090103"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080802050707060106090103
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> Hi,
> 
> If you have been suddenly CC'ed to this message please search
> your name below - there is something which concerns you.
> 
> Replying only to the list, myself and O.Sezer is appreciated.
> 
> On Tue, Oct 26, 2004 at 05:02:44PM +0300, O.Sezer wrote:
> 
>>There are many lost/forgotten patches posted here on lkml. Since 2.4.28
>>is near and 2.4 is going into "deep maintainance" mode soon, I gathered
>>a short list of some of them. 
> 
> 
> Oh it is hard to bookkeep all of this. I hope people check and resend, but
> they dont do that always.
> 
> 
>>There, sure, are many more of them,  but here it goes.
> 
> 
> Please send'em all. I really appreciate your efforts.
[...]
>>- Michael Mueller: opti-viper pci-chipset support
>>  (have an updated-for-2.4.23+ patch for this)
>>  http://marc.theaimsgroup.com/?t=106698970100002&r=1&w=2
>>  http://marc.theaimsgroup.com/?l=linux-kernel&m=106698965700864&w=2
> 
> 
> Should be applied - v2.6 also lacks it AFAICS.

Attached is a one that's supposed to apply cleanly to and work
with 2.4.23+ kernels.


--------------080802050707060106090103
Content-Type: text/plain;
	name="opti-viper-2.4.23-pci-chipset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="opti-viper-2.4.23-pci-chipset.patch"

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

--------------080802050707060106090103--
