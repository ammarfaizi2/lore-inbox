Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293757AbSCKODn>; Mon, 11 Mar 2002 09:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293753AbSCKOD3>; Mon, 11 Mar 2002 09:03:29 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:2058 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293751AbSCKODJ>; Mon, 11 Mar 2002 09:03:09 -0500
Message-Id: <200203111400.g2BE0Vq05422@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>
Subject: [PATCH] KERN_INFO 2.4.19-pre2 PCI related messages 
Date: Mon, 11 Mar 2002 15:59:44 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

Diff for PCI related messages

diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/i386/kernel/pci-pc.c linux-new/arch/i386/kernel/pci-pc.c
--- linux-2.4.19-pre2/arch/i386/kernel/pci-pc.c	Tue Mar  5 12:41:24 2002
+++ linux-new/arch/i386/kernel/pci-pc.c	Mon Mar 11 12:32:08 2002
@@ -421,7 +421,7 @@
 		    pci_sanity_check(&pci_direct_conf1)) {
 			outl (tmp, 0xCF8);
 			__restore_flags(flags);
-			printk("PCI: Using configuration type 1\n");
+			printk(KERN_INFO "PCI: Using configuration type 1\n");
 			request_region(0xCF8, 8, "PCI conf1");
 			return &pci_direct_conf1;
 		}
@@ -438,7 +438,7 @@
 		if (inb (0xCF8) == 0x00 && inb (0xCFA) == 0x00 &&
 		    pci_sanity_check(&pci_direct_conf2)) {
 			__restore_flags(flags);
-			printk("PCI: Using configuration type 2\n");
+			printk(KERN_INFO "PCI: Using configuration type 2\n");
 			request_region(0xCF8, 4, "PCI conf2");
 			return &pci_direct_conf2;
 		}
@@ -546,10 +546,10 @@
 		case 0:
 			return address + entry;
 		case 0x80:	/* Not present */
-			printk("bios32_service(0x%lx): not present\n", service);
+			printk(KERN_WARNING "bios32_service(0x%lx): not present\n", service);
 			return 0;
 		default: /* Shouldn't happen */
-			printk("bios32_service(0x%lx): returned 0x%x -- BIOS bug!\n",
+			printk(KERN_WARNING "bios32_service(0x%lx): returned 0x%x -- BIOS bug!\n",
 				service, return_code);
 			return 0;
 	}
@@ -599,7 +599,7 @@
 				status, signature);
 			return 0;
 		}
-		printk("PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
+		printk(KERN_INFO "PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
 			major_ver, minor_ver, pcibios_entry, pcibios_last_bus);
 #ifdef CONFIG_PCI_DIRECT
 		if (!(hw_mech & PCIBIOS_HW_TYPE1))
@@ -901,7 +901,7 @@
 				}
 			}
 			if (ln == &pci_devices) {
-				printk("PCI: BIOS reporting unknown device %02x:%02x\n", bus, devfn);
+				printk(KERN_WARNING "PCI: BIOS reporting unknown device %02x:%02x\n", bus, devfn);
 				/*
 				 * We must not continue scanning as several buggy BIOSes
 				 * return garbage after the last device. Grr.
@@ -910,7 +910,7 @@
 			}
 		}
 		if (!found) {
-			printk("PCI: Device %02x:%02x not found by BIOS\n",
+			printk(KERN_WARNING "PCI: Device %02x:%02x not found by BIOS\n",
 				dev->bus->number, dev->devfn);
 			list_del(&dev->global_list);
 			list_add_tail(&dev->global_list, &sorted_devices);
@@ -970,7 +970,7 @@
 			rt->size = opt.size + sizeof(struct irq_routing_table);
 			rt->exclusive_irqs = map;
 			memcpy(rt->slots, (void *) page, opt.size);
-			printk("PCI: Using BIOS Interrupt Routing Table\n");
+			printk(KERN_INFO "PCI: Using BIOS Interrupt Routing Table\n");
 		}
 	}
 	free_page(page);
@@ -1035,7 +1035,7 @@
 	}
 	if (!seen_host_bridge)
 		return;
-	printk("PCI: Ignoring ghost devices on bus %02x\n", b->number);
+	printk(KERN_WARNING "PCI: Ignoring ghost devices on bus %02x\n", b->number);
 
 	ln = &b->devices;
 	while (ln->next != &b->devices) {
@@ -1073,7 +1073,7 @@
 			if (!pci_read_config_word(&dev, PCI_VENDOR_ID, &l) &&
 			    l != 0x0000 && l != 0xffff) {
 				DBG("Found device at %02x:%02x [%04x]\n", n, dev.devfn, l);
-				printk("PCI: Discovered peer bus %02x\n", n);
+				printk(KERN_INFO "PCI: Discovered peer bus %02x\n", n);
 				pci_scan_bus(n, pci_root_ops, NULL);
 				break;
 			}
@@ -1116,7 +1116,7 @@
 	 */
 	u8 busno;
 	pci_read_config_byte(d, 0x4a, &busno);
-	printk("PCI: i440KX/GX host bridge %s: secondary bus %02x\n", d->slot_name, busno);
+	printk(KERN_INFO "PCI: i440KX/GX host bridge %s: secondary bus %02x\n", d->slot_name, busno);
 	pci_scan_bus(busno, pci_root_ops, NULL);
 	pcibios_last_bus = -1;
 }
@@ -1129,7 +1129,7 @@
 	 */
 	int i;
 
-	printk("PCI: Fixing base address flags for device %s\n", d->slot_name);
+	printk(KERN_WARNING "PCI: Fixing base address flags for device %s\n", d->slot_name);
 	for(i=0; i<4; i++)
 		d->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
 }
@@ -1280,11 +1280,11 @@
 	if (!pci_root_ops)
 		pcibios_config_init();
 	if (!pci_root_ops) {
-		printk("PCI: System does not support PCI\n");
+		printk(KERN_WARNING "PCI: System does not support PCI\n");
 		return;
 	}
 
-	printk("PCI: Probing PCI hardware\n");
+	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 	pci_root_bus = pci_scan_bus(0, pci_root_ops, NULL);
 	if (clustered_apic_mode && (numnodes > 1)) {
 		for (quad = 1; quad < numnodes; ++quad) {
