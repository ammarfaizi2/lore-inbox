Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbTE1Eey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 00:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbTE1Eey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 00:34:54 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:25729 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264501AbTE1Eeq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 00:34:46 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 27 May 2003 21:47:43 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       Martin Diehl <lists@mdiehl.de>
Subject: [patch] sis irq router fix for 2.4.20 ...
Message-ID: <Pine.LNX.4.55.0305272140350.1388@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes the problem reported in previous threads using a different
method. Instead of using the SB revision id, it parses the routing table
and try to select the proper router based on its content. It works fine in
my machine and it should also work fine in previous versions, by selecting
the older router behaviour. The "stdroute" pci= feature is still there.
It'd nice to have this tested on different SiS chipsets.




- Davide



diff -Nru linux-2.4.20.vanilla/arch/i386/kernel/pci-i386.h linux-2.4.20.sisfix/arch/i386/kernel/pci-i386.h
--- linux-2.4.20.vanilla/arch/i386/kernel/pci-i386.h	2002-11-28 15:53:09.000000000 -0800
+++ linux-2.4.20.sisfix/arch/i386/kernel/pci-i386.h	2003-05-27 17:33:10.001483336 -0700
@@ -21,6 +21,7 @@
 #define PCI_ASSIGN_ROMS		0x1000
 #define PCI_BIOS_IRQ_SCAN	0x2000
 #define PCI_ASSIGN_ALL_BUSSES	0x4000
+#define PCI_PASSTHRU_IRQROUTE	0x8000

 extern unsigned int pci_probe;

diff -Nru linux-2.4.20.vanilla/arch/i386/kernel/pci-irq.c linux-2.4.20.sisfix/arch/i386/kernel/pci-irq.c
--- linux-2.4.20.vanilla/arch/i386/kernel/pci-irq.c	2002-11-28 15:53:09.000000000 -0800
+++ linux-2.4.20.sisfix/arch/i386/kernel/pci-irq.c	2003-05-27 18:56:28.246634576 -0700
@@ -255,112 +255,252 @@
 }

 /*
- *	PIRQ routing for SiS 85C503 router used in several SiS chipsets
- *	According to the SiS 5595 datasheet (preliminary V1.0, 12/24/1997)
- *	the related registers work as follows:
- *
- *	general: one byte per re-routable IRQ,
+ *	PIRQ routing for SiS 85C503 router used in several SiS chipsets.
+ *	We have to deal with the following issues here:
+ *	- vendors have different ideas about the meaning of link values
+ *	- some onboard devices (integrated in the chipset) have special
+ *	  links and are thus routed differently (i.e. not via PCI INTA-INTD)
+ *	- different revision of the router have a different layout for
+ *	  the routing registers, particularly for the onchip devices
+ *
+ *	For all routing registers the common thing is we have one byte
+ *	per routeable link which is defined as:
  *		 bit 7      IRQ mapping enabled (0) or disabled (1)
- *		 bits [6:4] reserved
+ *		 bits [6:4] reserved (sometimes used for onchip devices)
  *		 bits [3:0] IRQ to map to
  *		     allowed: 3-7, 9-12, 14-15
  *		     reserved: 0, 1, 2, 8, 13
  *
- *	individual registers in device config space:
+ *	The config-space registers located at 0x41/0x42/0x43/0x44 are
+ *	always used to route the normal PCI INT A/B/C/D respectively.
+ *	Apparently there are systems implementing PCI routing table using
+ *	link values 0x01-0x04 and others using 0x41-0x44 for PCI INTA..D.
+ *	We try our best to handle both link mappings.
+ *
+ *	Currently (2003-05-21) it appears most SiS chipsets follow the
+ *	definition of routing registers from the SiS-5595 southbridge.
+ *	According to the SiS 5595 datasheets the revision id's of the
+ *	router (ISA-bridge) should be 0x01 or 0xb0.
  *
- *	0x41/0x42/0x43/0x44:	PCI INT A/B/C/D - bits as in general case
+ *	Furthermore we've also seen lspci dumps with revision 0x00 and 0xb1.
+ *	Looks like these are used in a number of SiS 5xx/6xx/7xx chipsets.
+ *	They seem to work with the current routing code. However there is
+ *	some concern because of the two USB-OHCI HCs (original SiS 5595
+ *	had only one). YMMV.
  *
- *	0x61:			IDEIRQ: bits as in general case - but:
- *				bits [6:5] must be written 01
- *				bit 4 channel-select primary (0), secondary (1)
+ *	Onchip routing for router rev-id 0x01/0xb0 and probably 0x00/0xb1:
  *
- *	0x62:			USBIRQ: bits as in general case - but:
- *				bit 4 OHCI function disabled (0), enabled (1)
+ *	0x61:	IDEIRQ:
+ *		bits [6:5] must be written 01
+ *		bit 4 channel-select primary (0), secondary (1)
+ *
+ *	0x62:	USBIRQ:
+ *		bit 6 OHCI function disabled (0), enabled (1)
  *
- *	0x6a:			ACPI/SCI IRQ - bits as in general case
+ *	0x6a:	ACPI/SCI IRQ: bits 4-6 reserved
+ *
+ *	0x7e:	Data Acq. Module IRQ - bits 4-6 reserved
  *
- *	0x7e:			Data Acq. Module IRQ - bits as in general case
+ *	We support USBIRQ (in addition to INTA-INTD) and keep the
+ *	IDE, ACPI and DAQ routing untouched as set by the BIOS.
  *
- *	Apparently there are systems implementing PCI routing table using both
- *	link values 0x01-0x04 and 0x41-0x44 for PCI INTA..D, but register offsets
- *	like 0x62 as link values for USBIRQ e.g. So there is no simple
- *	"register = offset + pirq" relation.
- *	Currently we support PCI INTA..D and USBIRQ and try our best to handle
- *	both link mappings.
- *	IDE/ACPI/DAQ mapping is currently unsupported (left untouched as set by BIOS).
+ *	Currently the only reported exception is the new SiS 65x chipset
+ *	which includes the SiS 69x southbridge. Here we have the 85C503
+ *	router revision 0x04 and there are changes in the register layout
+ *	mostly related to the different USB HCs with USB 2.0 support.
+ *
+ *	Onchip routing for router rev-id 0x04 (try-and-error observation)
+ *
+ *	0x60/0x61/0x62/0x63:	1xEHCI and 3xOHCI (companion) USB-HCs
+ *				bit 6-4 are probably unused, not like 5595
  */

-static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+#define PIRQ_SIS_IRQ_MASK	0x0f
+#define PIRQ_SIS_IRQ_DISABLE	0x80
+#define PIRQ_SIS_USB_ENABLE	0x40
+
+/* return value:
+ * -1 on error
+ * 0 for PCI INTA-INTD
+ * 0 or enable bit mask to check or set for onchip functions
+ */
+static inline int pirq_sis5595_onchip(int pirq, int *reg)
 {
-	u8 x;
-	int reg = pirq;
+	int ret = -1;

+	*reg = pirq;
 	switch(pirq) {
-		case 0x01:
-		case 0x02:
-		case 0x03:
-		case 0x04:
-			reg += 0x40;
-		case 0x41:
-		case 0x42:
-		case 0x43:
-		case 0x44:
-		case 0x62:
-			pci_read_config_byte(router, reg, &x);
-			if (reg != 0x62)
-				break;
-			if (!(x & 0x40))
-				return 0;
-			break;
-		case 0x61:
-		case 0x6a:
-		case 0x7e:
-			printk(KERN_INFO "SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented\n");
-			return 0;
-		default:
-			printk(KERN_INFO "SiS router pirq escape (%d)\n", pirq);
-			return 0;
-	}
-	return (x & 0x80) ? 0 : (x & 0x0f);
+	case 0x01:
+	case 0x02:
+	case 0x03:
+	case 0x04:
+		*reg += 0x40;
+	case 0x41:
+	case 0x42:
+	case 0x43:
+	case 0x44:
+		ret = 0;
+		break;
+
+	case 0x62:
+		ret = PIRQ_SIS_USB_ENABLE;	/* documented for 5595 */
+		break;
+
+	case 0x61:
+	case 0x6a:
+	case 0x7e:
+		printk(KERN_INFO "SiS pirq: IDE/ACPI/DAQ mapping not implemented: (%u)\n",
+		       (unsigned) pirq);
+		/* fall thru */
+	default:
+		printk(KERN_INFO "SiS router unknown request: (%u)\n",
+		       (unsigned) pirq);
+		break;
+	}
+	if (ret < 0 && (pci_probe & PCI_PASSTHRU_IRQROUTE))
+		ret = 0;
+	return ret;
+}
+
+/* return value:
+ * -1 on error
+ * 0 for PCI INTA-INTD
+ * 0 or enable bit mask to check or set for onchip functions
+ */
+static inline int pirq_sis96x_onchip(int pirq, int *reg)
+{
+	int ret = -1;
+
+	*reg = pirq;
+	switch(pirq) {
+	case 0x01:
+	case 0x02:
+	case 0x03:
+	case 0x04:
+		*reg += 0x40;
+	case 0x41:
+	case 0x42:
+	case 0x43:
+	case 0x44:
+	case 0x60:
+	case 0x61:
+	case 0x62:
+	case 0x63:
+		ret = 0;
+		break;
+
+	default:
+		printk(KERN_INFO "SiS router unknown request: (%u)\n",
+		       (unsigned) pirq);
+		break;
+	}
+	if (ret < 0 && (pci_probe & PCI_PASSTHRU_IRQROUTE))
+		ret = 0;
+	return ret;
+}
+
+
+static int pirq_sis5595_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	u8 x;
+	int reg, check;
+
+	check = pirq_sis5595_onchip(pirq, &reg);
+	if (check < 0)
+		return 0;
+
+	pci_read_config_byte(router, reg, &x);
+	if (check != 0  &&  !(x & check))
+		return 0;
+
+	return (x & PIRQ_SIS_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS_IRQ_MASK);
 }

-static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+static int pirq_sis96x_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
 	u8 x;
-	int reg = pirq;
+	int reg, check;
+
+	check = pirq_sis96x_onchip(pirq, &reg);
+	if (check < 0)
+		return 0;
+
+	pci_read_config_byte(router, reg, &x);
+	if (check != 0  &&  !(x & check))
+		return 0;
+
+	return (x & PIRQ_SIS_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS_IRQ_MASK);
+}
+
+static int pirq_sis5595_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+{
+	u8 x;
+	int reg, set;
+
+	set = pirq_sis5595_onchip(pirq, &reg);
+	if (set < 0)
+		return 0;
+
+	x = (irq & PIRQ_SIS_IRQ_MASK);
+	if (x == 0)
+		x = PIRQ_SIS_IRQ_DISABLE;
+	else
+		x |= set;
+
+	pci_write_config_byte(router, reg, x);
+
+	return 1;
+}
+
+static int pirq_sis96x_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+{
+	u8 x;
+	int reg, set;
+
+	set = pirq_sis96x_onchip(pirq, &reg);
+	if (set < 0)
+		return 0;
+
+	x = (irq & PIRQ_SIS_IRQ_MASK);
+	if (x == 0)
+		x = PIRQ_SIS_IRQ_DISABLE;
+	else
+		x |= set;

-	switch(pirq) {
-		case 0x01:
-		case 0x02:
-		case 0x03:
-		case 0x04:
-			reg += 0x40;
-		case 0x41:
-		case 0x42:
-		case 0x43:
-		case 0x44:
-		case 0x62:
-			x = (irq&0x0f) ? (irq&0x0f) : 0x80;
-			if (reg != 0x62)
-				break;
-			/* always mark OHCI enabled, as nothing else knows about this */
-			x |= 0x40;
-			break;
-		case 0x61:
-		case 0x6a:
-		case 0x7e:
-			printk(KERN_INFO "advanced SiS pirq mapping not yet implemented\n");
-			return 0;
-		default:
-			printk(KERN_INFO "SiS router pirq escape (%d)\n", pirq);
-			return 0;
-	}
 	pci_write_config_byte(router, reg, x);

 	return 1;
 }

 /*
+ * Sample the routing table to look up pci configuration space registers
+ * used for routing. It then selects the proper routing functions according
+ * the the values found inside the table.
+ */
+static int pirq_decode_sis_router(struct irq_router *r, struct irq_routing_table *rt) {
+	int i, entries = (rt->size - sizeof(struct irq_routing_table)) / sizeof(struct irq_info);
+	struct irq_info *info;
+	char pirqmap[32];
+
+	memset(pirqmap, 0, sizeof(pirqmap));
+	for (info = rt->slots; entries--; info++)
+		for (i = 0; i < 4; i++)
+			__set_bit(info->irq[i].link, pirqmap);
+
+	/*
+	 * Values 0x60,..,0x63 are typical of SiS96x SB, so we set the proper
+	 * routing functions.
+	 */
+	if (constant_test_bit(0x60, pirqmap) && constant_test_bit(0x61, pirqmap) &&
+	    constant_test_bit(0x62, pirqmap) && constant_test_bit(0x63, pirqmap)) {
+		r->get = pirq_sis96x_get;
+		r->set = pirq_sis96x_set;
+	}
+
+	return 0;
+}
+
+/*
  * VLSI: nibble offset 0x74 - educated guess due to routing table and
  *       config space of VLSI 82C534 PCI-bridge/router (1004:0102)
  *       Tested on HP OmniBook 800 covering PIRQ 1, 2, 4, 8 for onboard
@@ -483,7 +623,7 @@
 	{ "OPTI", PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C700, pirq_opti_get, pirq_opti_set },

 	{ "NatSemi", PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, pirq_cyrix_get, pirq_cyrix_set },
-	{ "SIS", PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, pirq_sis_get, pirq_sis_set },
+	{ "SIS", PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, pirq_sis5595_get, pirq_sis5595_set },
 	{ "VLSI 82C534", PCI_VENDOR_ID_VLSI, PCI_DEVICE_ID_VLSI_82C534, pirq_vlsi_get, pirq_vlsi_set },
 	{ "ServerWorks", PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4,
 	  pirq_serverworks_get, pirq_serverworks_set },
@@ -538,6 +678,16 @@
 			pirq_router = r;
 		}
 	}
+	/*
+	 * In case of SiS south bridge, we need to decode the two kind of routing
+	 * tables we have seen so far (5595 and 96x). Since the maintain the same
+	 * device ID, we need to do some magic to use the proper router. The revision
+	 * ID cannot be used for this and the lack of documentation forces us to
+	 * parse the routing table to decode the router type.
+	 */
+	if (pirq_router->vendor == PCI_VENDOR_ID_SI && pirq_router->device == PCI_DEVICE_ID_SI_503)
+		pirq_decode_sis_router(pirq_router, rt);
+
 	printk(KERN_INFO "PCI: Using IRQ router %s [%04x/%04x] at %s\n",
 		pirq_router->name,
 		pirq_router_dev->vendor,
diff -Nru linux-2.4.20.vanilla/arch/i386/kernel/pci-pc.c linux-2.4.20.sisfix/arch/i386/kernel/pci-pc.c
--- linux-2.4.20.vanilla/arch/i386/kernel/pci-pc.c	2002-11-28 15:53:09.000000000 -0800
+++ linux-2.4.20.sisfix/arch/i386/kernel/pci-pc.c	2003-05-27 17:34:15.835475048 -0700
@@ -1461,6 +1461,9 @@
 	else if (!strcmp(str, "rom")) {
 		pci_probe |= PCI_ASSIGN_ROMS;
 		return NULL;
+	} else if (!strcmp(str, "stdroute")) {
+		pci_probe |= PCI_PASSTHRU_IRQROUTE;
+		return NULL;
 	} else if (!strcmp(str, "assign-busses")) {
 		pci_probe |= PCI_ASSIGN_ALL_BUSSES;
 		return NULL;
