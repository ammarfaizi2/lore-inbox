Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289142AbSA1IKu>; Mon, 28 Jan 2002 03:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289140AbSA1IKe>; Mon, 28 Jan 2002 03:10:34 -0500
Received: from [195.66.192.167] ([195.66.192.167]:32781 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289142AbSA1IKV>; Mon, 28 Jan 2002 03:10:21 -0500
Message-Id: <200201280807.g0S87ZE21839@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] KERN_INFO for PCI related msgs
Date: Mon, 28 Jan 2002 10:07:37 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
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
--
vda

diff --recursive -u linux-2.4.13-orig/arch/i386/kernel/pci-pc.c linux-2.4.13-new/arch/i386/kernel/pci-pc.c
--- linux-2.4.13-orig/arch/i386/kernel/pci-pc.c	Tue Oct  9 21:17:38 2001
+++ linux-2.4.13-new/arch/i386/kernel/pci-pc.c	Thu Nov  8 23:42:11 2001
@@ -347,7 +347,7 @@
 		    pci_sanity_check(&pci_direct_conf1)) {
 			outl (tmp, 0xCF8);
 			__restore_flags(flags);
-			printk("PCI: Using configuration type 1\n");
+			printk(KERN_INFO "PCI: Using configuration type 1\n");
 			request_region(0xCF8, 8, "PCI conf1");
 			return &pci_direct_conf1;
 		}
@@ -364,7 +364,7 @@
 		if (inb (0xCF8) == 0x00 && inb (0xCFA) == 0x00 &&
 		    pci_sanity_check(&pci_direct_conf2)) {
 			__restore_flags(flags);
-			printk("PCI: Using configuration type 2\n");
+			printk(KERN_INFO "PCI: Using configuration type 2\n");
 			request_region(0xCF8, 4, "PCI conf2");
 			return &pci_direct_conf2;
 		}
@@ -472,10 +472,10 @@
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
@@ -525,7 +525,7 @@
 				status, signature);
 			return 0;
 		}
-		printk("PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
+		printk(KERN_INFO "PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
 			major_ver, minor_ver, pcibios_entry, pcibios_last_bus);
 #ifdef CONFIG_PCI_DIRECT
 		if (!(hw_mech & PCIBIOS_HW_TYPE1))
@@ -773,13 +773,13 @@
 		if (sum != 0)
 			continue;
 		if (check->fields.revision != 0) {
-			printk("PCI: unsupported BIOS32 revision %d at 0x%p, report to <mj@suse.cz>\n",
+			printk(KERN_WARNING "PCI: unsupported BIOS32 revision %d at 0x%p, report to <mj@suse.cz>\n",
 				check->fields.revision, check);
 			continue;
 		}
 		DBG("PCI: BIOS32 Service Directory structure at 0x%p\n", check);
 		if (check->fields.entry >= 0x100000) {
-			printk("PCI: BIOS32 entry (0x%p) in high memory, cannot use.\n", check);
+			printk(KERN_WARNING "PCI: BIOS32 entry (0x%p) in high memory, cannot use\n", check);
 			return NULL;
 		} else {
 			unsigned long bios32_entry = check->fields.entry;
@@ -827,7 +827,7 @@
 				}
 			}
 			if (ln == &pci_devices) {
-				printk("PCI: BIOS reporting unknown device %02x:%02x\n", bus, devfn);
+				printk(KERN_WARNING "PCI: BIOS reporting unknown device %02x:%02x\n", bus, devfn);
 				/*
 				 * We must not continue scanning as several buggy BIOSes
 				 * return garbage after the last device. Grr.
@@ -836,7 +836,7 @@
 			}
 		}
 		if (!found) {
-			printk("PCI: Device %02x:%02x not found by BIOS\n",
+			printk(KERN_WARNING "PCI: Device %02x:%02x not found by BIOS\n",
 				dev->bus->number, dev->devfn);
 			list_del(&dev->global_list);
 			list_add_tail(&dev->global_list, &sorted_devices);
@@ -896,7 +896,7 @@
 			rt->size = opt.size + sizeof(struct irq_routing_table);
 			rt->exclusive_irqs = map;
 			memcpy(rt->slots, (void *) page, opt.size);
-			printk("PCI: Using BIOS Interrupt Routing Table\n");
+			printk(KERN_INFO "PCI: Using BIOS Interrupt Routing Table\n");
 		}
 	}
 	free_page(page);
@@ -961,7 +961,7 @@
 	}
 	if (!seen_host_bridge)
 		return;
-	printk("PCI: Ignoring ghost devices on bus %02x\n", b->number);
+	printk(KERN_WARNING "PCI: Ignoring ghost devices on bus %02x\n", b->number);
 
 	ln = &b->devices;
 	while (ln->next != &b->devices) {
@@ -999,7 +999,7 @@
 			if (!pci_read_config_word(&dev, PCI_VENDOR_ID, &l) &&
 			    l != 0x0000 && l != 0xffff) {
 				DBG("Found device at %02x:%02x [%04x]\n", n, dev.devfn, l);
-				printk("PCI: Discovered peer bus %02x\n", n);
+				printk(KERN_INFO "PCI: Discovered peer bus %02x\n", n);
 				pci_scan_bus(n, pci_root_ops, NULL);
 				break;
 			}
@@ -1017,7 +1017,7 @@
 	 */
 	int pxb, reg;
 	u8 busno, suba, subb;
-	printk("PCI: Searching for i450NX host bridges on %s\n", d->slot_name);
+	printk(KERN_INFO "PCI: Searching for i450NX host bridges on %s\n", d->slot_name);
 	reg = 0xd0;
 	for(pxb=0; pxb<2; pxb++) {
 		pci_read_config_byte(d, reg++, &busno);
@@ -1040,7 +1040,7 @@
 	 */
 	u8 busno;
 	pci_read_config_byte(d, 0x4a, &busno);
-	printk("PCI: i440KX/GX host bridge %s: secondary bus %02x\n", d->slot_name, busno);
+	printk(KERN_INFO "PCI: i440KX/GX host bridge %s: secondary bus %02x\n", d->slot_name, busno);
 	pci_scan_bus(busno, pci_root_ops, NULL);
 	pcibios_last_bus = -1;
 }
@@ -1061,7 +1061,7 @@
 		busno2 = busno1;
 	if (busno2 > pcibios_last_bus) {
 		pcibios_last_bus = busno2;
-		printk("PCI: ServerWorks host bridge: last bus %02x\n", pcibios_last_bus);
+		printk(KERN_INFO "PCI: ServerWorks host bridge: last bus %02x\n", pcibios_last_bus);
 	}
 }
 #endif
@@ -1082,7 +1082,7 @@
 		busno2 = busno1;
 	if (busno2 > pcibios_last_bus) {
 		pcibios_last_bus = busno2;
-		printk("PCI: Compaq host bridge: last bus %02x\n", busno2);
+		printk(KERN_INFO "PCI: Compaq host bridge: last bus %02x\n", busno2);
 	}
 }
 #endif	
@@ -1095,7 +1095,7 @@
 	 */
 	int i;
 
-	printk("PCI: Fixing base address flags for device %s\n", d->slot_name);
+	printk(KERN_WARNING "PCI: Fixing base address flags for device %s\n", d->slot_name);
 	for(i=0; i<4; i++)
 		d->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
 }
@@ -1244,11 +1244,11 @@
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
 
 	pcibios_irq_init();
