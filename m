Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBHTmK>; Thu, 8 Feb 2001 14:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBHTmA>; Thu, 8 Feb 2001 14:42:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9737 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129026AbRBHTlr>; Thu, 8 Feb 2001 14:41:47 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Patch] ServerWorks peer bus fix for 2.4.x
Date: 8 Feb 2001 11:41:16 -0800
Organization: Transmeta Corporation
Message-ID: <95usos$6qd$1@penguin.transmeta.com>
In-Reply-To: <8C91B010B3B7994C88A266E1A72184D3116FCD@cceexc19.americas.cpqcorp.net> <20010208094042.B119@albireo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010208094042.B119@albireo.ucw.cz>,
Martin Mares  <mj@suse.cz> wrote:
>
>What leads you to your belief it's correct? The lspci dump Adam has sent
>to the list shows that there's something utterly wrong with our understanding
>of the ServerWorks config registers -- they seem to say that the primary
>bus numbers are 00 and 01, but in reality they are 00 and 02.

Is there any reason to not just change the default pcibios_last_bus to
255, and just always default to scanning all PCI bus numbers?

Alternatively, how about just changing the fixups to be saner. Right now
they are obviously bogus, and don't even match with their comments.
Somehting like this..

		Linus

----
--- old-linux/arch/i386/kernel/pci-pc.c	Thu Jun 22 07:17:16 2000
+++ linux/arch/i386/kernel/pci-pc.c	Thu Feb  8 11:36:58 2001
@@ -843,30 +843,40 @@
 	pcibios_last_bus = -1;
 }
 
+/*
+ * ServerWorks host bridges -- Find and scan all secondary buses.
+ * Register 0x44 contains first, 0x45 last bus number routed there.
+ */
 static void __init pci_fixup_serverworks(struct pci_dev *d)
 {
-	/*
-	 * ServerWorks host bridges -- Find and scan all secondary buses.
-	 * Register 0x44 contains first, 0x45 last bus number routed there.
-	 */
-	u8 busno;
-	pci_read_config_byte(d, 0x44, &busno);
-	printk("PCI: ServerWorks host bridge: secondary bus %02x\n", busno);
-	pci_scan_bus(busno, pci_root_ops, NULL);
-	pcibios_last_bus = -1;
+	u8 busno1, busno2;
+
+	pci_read_config_byte(d, 0x44, &busno1);
+	pci_read_config_byte(d, 0x45, &busno2);
+	if (busno2 < busno1)
+		busno2 = busno1;
+	if (busno2 > pcibios_last_bus) {
+		pcibios_last_bus = busno2;
+		printk("PCI: ServerWorks host bridge: last bus %02x\n", pcibios_last_bus);
+	}
 }
 
+/*	
+ * Compaq host bridges -- Find and scan all secondary buses.
+ * This time registers 0xc8 and 0xc9.
+ */
 static void __init pci_fixup_compaq(struct pci_dev *d)
 {
-	/*	
-	 * Compaq host bridges -- Find and scan all secondary buses.
-	 * This time registers 0xc8 and 0xc9.
-	 */
-	u8 busno;
-	pci_read_config_byte(d, 0xc8, &busno);
-	printk("PCI: Compaq host bridge: secondary bus %02x\n", busno);
-	pci_scan_bus(busno, pci_root_ops, NULL);
-	pcibios_last_bus = -1;
+	u8 busno1, busno2;
+
+	pci_read_config_byte(d, 0xc8, &busno1);
+	pci_read_config_byte(d, 0xc9, &busno2);
+	if (busno2 < busno1)
+		busno2 = busno1;
+	if (busno2 > pcibios_last_bus) {
+		pcibios_last_bus = busno2;
+		printk("PCI: Compaq host bridge: last bus %02x\n", busno2);
+	}
 }
 
 static void __init pci_fixup_umc_ide(struct pci_dev *d)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
