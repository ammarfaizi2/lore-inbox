Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRFRSGZ>; Mon, 18 Jun 2001 14:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262421AbRFRSGQ>; Mon, 18 Jun 2001 14:06:16 -0400
Received: from puffin.external.hp.com ([192.25.206.4]:28690 "EHLO
	puffin.external.hp.com") by vger.kernel.org with ESMTP
	id <S262288AbRFRSGF>; Mon, 18 Jun 2001 14:06:05 -0400
Message-Id: <200106181805.MAA20948@puffin.external.hp.com>
To: ink@jurassic.park.msu.ru, jgarzik@mandrakesoft.com
Subject: [PATCH] 2.4.4 PCI FBB
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
Date: Mon, 18 Jun 2001 12:05:19 -0600
From: Grant Grundler <grundler@puffin.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan, Jeff,

Appended is the 2.4.4 patch for PCI Fast Back-Back (FBB) support.
Could you please review/comment on it?

Some caveats/notes:
o Since I'm on the road (visiting relatives in Germany mostly, currently
  in Zurich), I'm only able to verify it boots on my Omnibook 800.
  PA-RISC port is still based on 2.4.0 so I can't test there.
  My lxr8000 (in Cupertino) doesn't reboot remotely reliably.
  Consider this a first cut.

o I've added logic to pull the secondary PCI bus out of reset properly
  in case the PCI-PCI bridge not been initialized by BIOS.
  This was implicitly happening before in pci_setup_bridge().
  The OB800 has a *broken* VLSI PCI-PCI bridge onboard with respect
  to the BUS_RESET bit - see the "KLUGE ALERT".

o "lspci" segfaults on the OB800. I don't know why.
  I don't think it's related to any changes I've made. I'm running
  debian "unstable" and haven't been able to update in several weeks.
  If it persists after an update, then I'll chase it.

o Ivan proposed pcibios_set_bridge_ctl(); I used "pcibios_init_bus()".
  The calling location in pci_do_scan_bus() seemed like a per-bus
  initialization point rather than a narrow/specific task.
  I'd like to make use of pcibios_init_bus() in the parisc port.
  I've only modified arch/i386 to provide pcibios_init_bus().

o For each secondary bus, pci_setup_bridge() gets called before
  pcibios_init_bus().  The former handles generic PCI-PCI bridge and the
  later deals with arch specific (eg Host-PCI bridge) stuff. However
  the difference is on the primary bus - only pcibios_init_bus() is called.
  FWIW, PA-RISC host-PCI bridges support FBB and I would like to add support
  to enable FBB on the primary busses (yes - plural!).

o I intentionally put all FBB support in pci_setup_bridge() (arch common).
  FBB could also live in the arch specific location (pcibios_init_bus())
  but then that gets replicated for each arch. Not sure if that's a
  problem or not. The trade off is how arch code interacts with common
  code for FBB support on the primary bus(ses).

thanks!
grant



--- 2.4.4-orig/arch/i386/kernel/pci-i386.c	Mon Aug  7 14:31:40 2000
+++ 2.4.4/arch/i386/kernel/pci-i386.c	Sun Jun 17 02:30:29 2001
@@ -324,6 +324,11 @@ int pcibios_enable_resources(struct pci_
 	}
 	if (dev->resource[PCI_ROM_RESOURCE].start)
 		cmd |= PCI_COMMAND_MEMORY;
+
+	/* If bridge/bus controller has FBB enabled, child must too. */
+	if (dev->bus->bridge_ctl & PCI_BRIDGE_CTL_FAST_BACK)
+		cmd |= PCI_COMMAND_FAST_BACK;
+
 	if (cmd != old_cmd) {
 		printk("PCI: Enabling device %s (%04x -> %04x)\n", dev->slot_name, old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
--- 2.4.4-orig/arch/i386/kernel/pci-pc.c	Thu Apr 19 22:57:06 2001
+++ 2.4.4/arch/i386/kernel/pci-pc.c	Sun Jun 17 02:46:26 2001
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/delay.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -1015,6 +1016,29 @@ struct pci_fixup pcibios_fixups[] = {
 };
 
 /*
+ * Called before each bus is probed. Allows us to tweak struct pci_bus *.
+ */
+void __init pcibios_init_bus(struct pci_bus *b)
+{
+	struct pci_dev *dev = b->self;
+
+	/* If host PCI bridge supports FBB, could add support here and
+	** in pcibios_fixup_bus(). For the moment, hope the BIOS is
+	** smart enough to take advantage of FBB.
+	*/
+
+	/* don't forward all "ISA" IO addresses */
+	if (dev && (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		&& ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI)
+		&& !(b->bridge_ctl | PCI_BRIDGE_CTL_NO_ISA) )
+	{
+		b->bridge_ctl |= PCI_BRIDGE_CTL_NO_ISA;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, b->bridge_ctl);
+	}
+}
+
+
+/*
  *  Called after each bus is probed, but before its children
  *  are examined.
  */
@@ -1023,6 +1047,11 @@ void __init pcibios_fixup_bus(struct pci
 {
 	pcibios_fixup_ghosts(b);
 	pci_read_bridge_bases(b);
+
+	/* if any i386 PCI host bus adapters support FBB, test FBB bit
+	** in b->bridge_ctl (dis-) enable FBB in the host bus adapter.
+	** Also look at comments in pcibios_init_bus().
+	*/
 }
 
 /*
--- 2.4.4-orig/drivers/pci/pci.c	Thu Apr 19 08:38:48 2001
+++ 2.4.4/drivers/pci/pci.c	Sun Jun 17 03:06:58 2001
@@ -36,6 +36,7 @@
 
 LIST_HEAD(pci_root_buses);
 LIST_HEAD(pci_devices);
+unsigned int pci_post_reset_delay = 50;	/* spec says 1sec but this works */
 
 /**
  * pci_find_slot - locate PCI device from a given PCI slot
@@ -978,9 +979,17 @@ static int __init pci_scan_bridge(struct
 		}
 	} else {
 		/*
-		 * We need to assign a number to this bus which we always
-		 * do in the second pass. We also keep all address decoders
-		 * on the bridge disabled during scanning.  FIXME: Why?
+		 * Assign a number to this bus.  Disable all address
+		 * decoders on the bridge during scanning since we don't
+		 * want unprogrammed or wrongly programmed I/O window
+		 * registers to forward *any* transactions. We can't
+		 * (re-) program the window registers until we know the
+		 * resources needed by devices below this bridge.
+		 *
+		 * NOTE: disabling window registers will prevent BIOS or
+		 * drivers from talking to console/boot devices behind
+		 * the bridge! (ie DBG output won't happen - may hang
+		 * machine depending on arch)
 		 */
 		if (!pass)
 			return max;
@@ -997,6 +1006,7 @@ static int __init pci_scan_bridge(struct
 		 * We need to blast all three values with a single write.
 		 */
 		pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
+
 		if (!is_cardbus) {
 			/* Now we can scan all subordinate buses... */
 			max = pci_do_scan_bus(child);
@@ -1046,6 +1056,7 @@ static void pci_read_irq(struct pci_dev 
 int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
+	unsigned short status;
 
 	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	sprintf(dev->name, "PCI device %04x:%04x", dev->vendor, dev->device);
@@ -1093,6 +1104,11 @@ int pci_setup_device(struct pci_dev * de
 		dev->class = PCI_CLASS_NOT_DEFINED;
 	}
 
+	/* FBB capability - if not, clear bit in parent bridge_ctl.  */
+	pci_read_config_word(dev, PCI_STATUS, &status);
+	if (0 == (status & PCI_STATUS_FAST_BACK))
+		dev->bus->bridge_ctl &= ~PCI_BRIDGE_CTL_FAST_BACK;
+
 	/* We found a fine healthy device, go go go... */
 	return 0;
 }
@@ -1174,6 +1190,8 @@ static unsigned int __init pci_do_scan_b
 	unsigned int devfn, max, pass;
 	struct list_head *ln;
 	struct pci_dev *dev, dev0;
+
+	pcibios_init_bus(bus);
 
 	DBG("Scanning bus %02x\n", bus->number);
 	max = bus->secondary;
--- 2.4.4-orig/drivers/pci/setup-bus.c	Mon Dec 11 13:46:26 2000
+++ 2.4.4/drivers/pci/setup-bus.c	Sun Jun 17 03:22:27 2001
@@ -127,9 +127,12 @@ pci_setup_bridge(struct pci_bus *bus)
 	struct pbus_set_ranges_data ranges;
 	struct pci_dev *bridge = bus->self;
 	u32 l;
+	unsigned short cap;
+	int need_post_reset_delay;
 
-	if (!bridge || (bridge->class >> 8) != PCI_CLASS_BRIDGE_PCI)
+	if (!bridge || (bridge->foclass >> 8) != PCI_CLASS_BRIDGE_PCI)
 		return;
+
 	ranges.io_start = bus->resource[0]->start;
 	ranges.io_end = bus->resource[0]->end;
 	ranges.mem_start = bus->resource[1]->start;
@@ -165,10 +168,49 @@ pci_setup_bridge(struct pci_bus *bus)
 	l |= bus->resource[2]->end & 0xfff00000;
 	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
 
-	/* Check if we have VGA behind the bridge.
-	   Enable ISA in either case. */
-	l = (bus->resource[0]->flags & IORESOURCE_BUS_HAS_VGA) ? 0x0c : 0x04;
-	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, l);
+	/* cache bridge_ctl from config register */
+	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bus->bridge_ctl);
+
+	/*
+	** x86 pcibios_init_bus() will set CTL_NO_ISA bit
+	*/
+
+	/* Forward VGA down this bridge? */
+	if (bus->resource[0]->flags & IORESOURCE_BUS_HAS_VGA)
+		bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
+
+	/*
+	** if Bridge supports FBB, set FBB bit in bridge_ctl.
+	** If any subordinate device doesn't support FBB, will get
+	** cleared during bus scan. If it's still set:
+	** o pci_setup_bridge() will enable FBB in bridge (for secondary bus).
+	** o pci_enable_device() will enable FBB for devices.
+	*/
+	pci_read_config_word(dev, PCI_SEC_STATUS, &cap);
+	if (cap & PCI_BRIDGE_CTL_FAST_BACK)
+		bus->bridge_ctl |= PCI_BRIDGE_CTL_FAST_BACK;
+
+	if (
+#ifdef __i386__
+		/*
+		** KLUGE ALERT!
+		** VLSI (1004:0102) makes a "PCI-PCI Bridge" that's not quite.
+		** OmniBook 800 wedges when BUS_RESET bit is cleared (I
+		** suspect the bit means something else) and then try scan
+		** the bus below.
+		*/
+		(dev->vendor == PCI_VENDOR_ID_DEC) &&
+#endif
+		(need_post_reset_delay = bus->bridge_ctl & PCI_BRIDGE_CTL_BUS_RESET))
+	{
+		/* Make sure bus is not reset. Need 1sec delay if it is. */
+		bus->bridge_ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+	}
+
+	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
+
+	if (need_post_reset_delay)
+		mdelay(pci_post_reset_delay);
 }
 
 static void __init
--- 2.4.4-orig/include/linux/pci.h	Sat May 12 07:40:42 2001
+++ 2.4.4/include/linux/pci.h	Sun Jun 17 03:21:55 2001
@@ -403,12 +403,15 @@ struct pci_bus {
 	unsigned char	productver;	/* product version */
 	unsigned char	checksum;	/* if zero - checksum passed */
 	unsigned char	pad1;
+	unsigned short	bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
+	unsigned short	pad2;
 };
 
 #define pci_bus_b(n) list_entry(n, struct pci_bus, node)
 
 extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 extern struct list_head pci_devices;	/* list of all devices */
+extern unsigned int pci_post_reset_delay;  /* delay after clearing RESET */
 
 /*
  * Error values that may be returned by PCI functions.
@@ -460,8 +463,10 @@ struct pci_driver {
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
-void pcibios_init(void);
-void pcibios_fixup_bus(struct pci_bus *);
+/* pcibios_*() == arch specific implementation */
+void pcibios_init(void);			/* global init */
+void pcibios_init_bus(struct pci_bus *);	/* before each bus scan */
+void pcibios_fixup_bus(struct pci_bus *);	/* after each bus scan */
 int pcibios_enable_device(struct pci_dev *);
 char *pcibios_setup (char *str);
 
