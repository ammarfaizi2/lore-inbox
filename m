Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbSLHDMC>; Sat, 7 Dec 2002 22:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSLHDMC>; Sat, 7 Dec 2002 22:12:02 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265130AbSLHDLy>;
	Sat, 7 Dec 2002 22:11:54 -0500
Date: Sat, 7 Dec 2002 20:56:59 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>
Subject: Re: /proc/pci deprecation?
In-Reply-To: <Pine.LNX.4.44.0212071100190.2220-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0212072046260.8470-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One thing that /proc/pci gives you that 'lspci' historically didn't was
> the correct interrupt setup (because kernel irq routing has nothing to do
> with the PCI irq config byte on most "interesting" machines).
> 
> I don't know if lspci gets that right these days, and the information does
> exist in /sys, so there is certainly at least the _potential_ of dropping
> /proc/pci.

It appears to: 

[mochel@tina mochel]$ lspci -v | grep -B 2  IRQ | fgrep -v Subsystem 

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB (rev 07) (prog-if 10 [OHCI])
        Flags: bus master, medium devsel, latency 16, IRQ 19
--
00:09.0 Multimedia audio controller: Creative Labs: Unknown device 0004 (rev 03)
        Flags: bus master, medium devsel, latency 64, IRQ 17
--
00:09.2 FireWire (IEEE 1394): Creative Labs: Unknown device 4001 (prog-if 10 [OHCI])
        Flags: bus master, medium devsel, latency 64, IRQ 18
--

00:0b.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
        Flags: bus master, medium devsel, latency 64, IRQ 19
--

00:0c.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 01)
        Flags: bus master, medium devsel, latency 66, IRQ 16
--
01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5144 (prog-if 00 [VGA])
        Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, latency 66, IRQ 18

[mochel@tina mochel]$ fgrep -B 1 IRQ /proc/pci 
    USB Controller: Advanced Micro Devic AMD-766 [ViperPlus]  (rev 7).
      IRQ 19.
--
    Multimedia audio controller: Creative Labs SB Audigy (rev 3).
      IRQ 17.
--
    FireWire (IEEE 1394): Creative Labs SB Audigy FireWire P (rev 0).
      IRQ 18.
--
    Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boo (rev 0).
      IRQ 19.
--
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet  (rev 1).
      IRQ 16.
--
    VGA compatible controller: ATI Technologies Inc Radeon QD (rev 0).
      IRQ 18.


The appended patch both make /proc/pci a compile-time option and 
deprecates it and the PCI names database. Text has been added to the 
configuration options, and the top of the file. 

The /proc/pci functionality has been moved from drivers/pci/proc.c to 
drivers/pci/names.c, to make it closer to the PCI names interface. It 
ain't the prettiest, but it's simple to understand. 


	-pat

diffstat:

 Documentation/Changes |    4 +
 drivers/pci/Kconfig   |   38 ++++++++---
 drivers/pci/names.c   |  167 +++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/proc.c    |  113 ---------------------------------
 4 files changed, 199 insertions(+), 123 deletions(-)


===== Documentation/Changes 1.28 vs edited =====
--- 1.28/Documentation/Changes	Fri Nov  8 01:47:19 2002
+++ edited/Documentation/Changes	Sat Dec  7 20:53:59 2002
@@ -347,6 +347,10 @@
 ----------
 o  <http://powertweak.sourceforge.net/>
 
+pci-utils
+---------
+o  <ftp://ftp.kernel.org/pub/software/utils/pciutils/>
+
 Networking
 **********
 
===== drivers/pci/Kconfig 1.1 vs edited =====
--- 1.1/drivers/pci/Kconfig	Tue Oct 29 19:16:55 2002
+++ edited/drivers/pci/Kconfig	Sat Dec  7 20:37:24 2002
@@ -1,18 +1,38 @@
 #
 # PCI configuration
 #
+
+config PCI_OLD_PROC
+	bool "/proc/pci Interface"
+	depends on PCI && PROC_FS
+	---help---
+	  This option is deprecated.
+
+	  This option provides the traditional /proc/pci interface, which lists
+	  every PCI device and some information extracted from their configuration
+	  space. 
+
+	  This option has been deprecated as of kernel version 2.5.51. The option
+	  and the /proc/pci interface will be removed at a futre date. The 
+	  preferred alternative is to use the lspci(8) utility. Please refer to
+	  Documentation/Changes for information on where to get the latest version.
+
+	  If unsure, say N and use lspci(8) instead. 
+
 config PCI_NAMES
 	bool "PCI device name database"
 	depends on PCI
 	---help---
-	  By default, the kernel contains a database of all known PCI device
-	  names to make the information in /proc/pci, /proc/ioports and
-	  similar files comprehensible to the user. This database increases
-	  size of the kernel image by about 80KB, but it gets freed after the
-	  system boots up, so it doesn't take up kernel memory. Anyway, if you
-	  are building an installation floppy or kernel for an embedded system
-	  where kernel image size really matters, you can disable this feature
-	  and you'll get device ID numbers instead of names.
+	  This option is deprecated. 
+
+	  This option adds a database of PCI device names to make the names of 
+	  PCI devices in /proc/pci and /proc/ioports more sensible. The /proc/pci
+	  interface has been deprecated, and when it is removed, the PCI names 
+	  database will also probably be removed.
+
+	  This option increases the size of the kernel by about 55KB. If 
+	  CONFIG_HOTPLUG is not set, then this memory is freed after the system
+	  boots up. 
 
-	  When in doubt, say Y.
+	  When in doubt, say N.
 
===== drivers/pci/names.c 1.5 vs edited =====
--- 1.5/drivers/pci/names.c	Sat Nov 16 16:54:29 2002
+++ edited/drivers/pci/names.c	Sat Dec  7 20:45:23 2002
@@ -1,8 +1,16 @@
 /*
- *	PCI Class and Device Name Tables
+ *	PCI Class and Device Name Tables and /proc/pci interface.
  *
  *	Copyright 1993--1999 Drew Eckhardt, Frederic Potter,
  *	David Mosberger-Tang, Martin Mares
+ *
+ *	These features have been depcrecated as of v2.5.51. 
+ *	The PCI names interface was useful only for presenting meaningful names
+ *	in /proc/pci and /proc/ioports.
+ *	The /proc/pci interface is deprecated, as lspci(8) is a much more useful
+ *	tool that provides all the info in /proc/pci and more, while existing
+ *	completely in userspace. That is now the preferred method of extracting
+ *	PCI device data. 
  */
 
 #include <linux/config.h>
@@ -11,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 
+
 #ifdef CONFIG_PCI_NAMES
 
 struct pci_device_info {
@@ -136,3 +145,159 @@
 
 #endif /* CONFIG_PCI_NAMES */
 
+
+#ifdef CONFIG_PCI_OLD_PROC
+
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+/* iterator */
+static void *pci_seq_start(struct seq_file *m, loff_t *pos)
+{
+	struct list_head *p = &pci_devices;
+	loff_t n = *pos;
+
+	/* XXX: surely we need some locking for traversing the list? */
+	while (n--) {
+		p = p->next;
+		if (p == &pci_devices)
+			return NULL;
+	}
+	return p;
+}
+static void *pci_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct list_head *p = v;
+	(*pos)++;
+	return p->next != &pci_devices ? p->next : NULL;
+}
+static void pci_seq_stop(struct seq_file *m, void *v)
+{
+	/* release whatever locks we need */
+}
+
+
+/*
+ *  Backward compatible /proc/pci interface.
+ */
+
+/*
+ * Convert some of the configuration space registers of the device at
+ * address (bus,devfn) into a string (possibly several lines each).
+ * The configuration string is stored starting at buf[len].  If the
+ * string would exceed the size of the buffer (SIZE), 0 is returned.
+ */
+static int show_dev_config(struct seq_file *m, void *v)
+{
+	struct list_head *p = v;
+	struct pci_dev *dev;
+	struct pci_driver *drv;
+	u32 class_rev;
+	unsigned char latency, min_gnt, max_lat, *class;
+	int reg;
+
+	if (p == &pci_devices) {
+		seq_puts(m, "PCI devices found:\n");
+		return 0;
+	}
+
+	dev = pci_dev_g(p);
+	drv = pci_dev_driver(dev);
+
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	pci_read_config_byte (dev, PCI_LATENCY_TIMER, &latency);
+	pci_read_config_byte (dev, PCI_MIN_GNT, &min_gnt);
+	pci_read_config_byte (dev, PCI_MAX_LAT, &max_lat);
+	seq_printf(m, "  Bus %2d, device %3d, function %2d:\n",
+	       dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	class = pci_class_name(class_rev >> 16);
+	if (class)
+		seq_printf(m, "    %s", class);
+	else
+		seq_printf(m, "    Class %04x", class_rev >> 16);
+	seq_printf(m, ": %s (rev %d).\n", dev->dev.name, class_rev & 0xff);
+
+	if (dev->irq)
+		seq_printf(m, "      IRQ %d.\n", dev->irq);
+
+	if (latency || min_gnt || max_lat) {
+		seq_printf(m, "      Master Capable.  ");
+		if (latency)
+			seq_printf(m, "Latency=%d.  ", latency);
+		else
+			seq_puts(m, "No bursts.  ");
+		if (min_gnt)
+			seq_printf(m, "Min Gnt=%d.", min_gnt);
+		if (max_lat)
+			seq_printf(m, "Max Lat=%d.", max_lat);
+		seq_putc(m, '\n');
+	}
+
+	for (reg = 0; reg < 6; reg++) {
+		struct resource *res = dev->resource + reg;
+		unsigned long base, end, flags;
+
+		base = res->start;
+		end = res->end;
+		flags = res->flags;
+		if (!end)
+			continue;
+
+		if (flags & PCI_BASE_ADDRESS_SPACE_IO) {
+			seq_printf(m, "      I/O at 0x%lx [0x%lx].\n",
+				base, end);
+		} else {
+			const char *pref, *type = "unknown";
+
+			if (flags & PCI_BASE_ADDRESS_MEM_PREFETCH)
+				pref = "P";
+			else
+				pref = "Non-p";
+			switch (flags & PCI_BASE_ADDRESS_MEM_TYPE_MASK) {
+			      case PCI_BASE_ADDRESS_MEM_TYPE_32:
+				type = "32 bit"; break;
+			      case PCI_BASE_ADDRESS_MEM_TYPE_1M:
+				type = "20 bit"; break;
+			      case PCI_BASE_ADDRESS_MEM_TYPE_64:
+				type = "64 bit"; break;
+			}
+			seq_printf(m, "      %srefetchable %s memory at "
+				       "0x%lx [0x%lx].\n", pref, type,
+				       base,
+				       end);
+		}
+	}
+	return 0;
+}
+
+static struct seq_operations proc_pci_op = {
+	.start	= pci_seq_start,
+	.next	= pci_seq_next,
+	.stop	= pci_seq_stop,
+	.show	= show_dev_config
+};
+
+static int proc_pci_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &proc_pci_op);
+}
+static struct file_operations proc_pci_operations = {
+	.open		= proc_pci_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+
+static int __init pci_old_proc_init(void)
+{
+	struct proc_dir_entry * entry;
+	entry = create_proc_entry("pci", 0, NULL);
+	if (entry)
+		entry->proc_fops = &proc_pci_operations;
+	return 0;
+}
+
+module_init(pci_old_proc_init);
+
+#endif /* CONFIG_PCI_OLD_PROC */
===== drivers/pci/proc.c 1.21 vs edited =====
--- 1.21/drivers/pci/proc.c	Mon Nov 18 01:09:47 2002
+++ edited/drivers/pci/proc.c	Sat Dec  7 20:27:46 2002
@@ -473,106 +473,6 @@
 }
 
 
-/*
- *  Backward compatible /proc/pci interface.
- */
-
-/*
- * Convert some of the configuration space registers of the device at
- * address (bus,devfn) into a string (possibly several lines each).
- * The configuration string is stored starting at buf[len].  If the
- * string would exceed the size of the buffer (SIZE), 0 is returned.
- */
-static int show_dev_config(struct seq_file *m, void *v)
-{
-	struct list_head *p = v;
-	struct pci_dev *dev;
-	struct pci_driver *drv;
-	u32 class_rev;
-	unsigned char latency, min_gnt, max_lat, *class;
-	int reg;
-
-	if (p == &pci_devices) {
-		seq_puts(m, "PCI devices found:\n");
-		return 0;
-	}
-
-	dev = pci_dev_g(p);
-	drv = pci_dev_driver(dev);
-
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	pci_read_config_byte (dev, PCI_LATENCY_TIMER, &latency);
-	pci_read_config_byte (dev, PCI_MIN_GNT, &min_gnt);
-	pci_read_config_byte (dev, PCI_MAX_LAT, &max_lat);
-	seq_printf(m, "  Bus %2d, device %3d, function %2d:\n",
-	       dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	class = pci_class_name(class_rev >> 16);
-	if (class)
-		seq_printf(m, "    %s", class);
-	else
-		seq_printf(m, "    Class %04x", class_rev >> 16);
-	seq_printf(m, ": %s (rev %d).\n", dev->dev.name, class_rev & 0xff);
-
-	if (dev->irq)
-		seq_printf(m, "      IRQ %d.\n", dev->irq);
-
-	if (latency || min_gnt || max_lat) {
-		seq_printf(m, "      Master Capable.  ");
-		if (latency)
-			seq_printf(m, "Latency=%d.  ", latency);
-		else
-			seq_puts(m, "No bursts.  ");
-		if (min_gnt)
-			seq_printf(m, "Min Gnt=%d.", min_gnt);
-		if (max_lat)
-			seq_printf(m, "Max Lat=%d.", max_lat);
-		seq_putc(m, '\n');
-	}
-
-	for (reg = 0; reg < 6; reg++) {
-		struct resource *res = dev->resource + reg;
-		unsigned long base, end, flags;
-
-		base = res->start;
-		end = res->end;
-		flags = res->flags;
-		if (!end)
-			continue;
-
-		if (flags & PCI_BASE_ADDRESS_SPACE_IO) {
-			seq_printf(m, "      I/O at 0x%lx [0x%lx].\n",
-				base, end);
-		} else {
-			const char *pref, *type = "unknown";
-
-			if (flags & PCI_BASE_ADDRESS_MEM_PREFETCH)
-				pref = "P";
-			else
-				pref = "Non-p";
-			switch (flags & PCI_BASE_ADDRESS_MEM_TYPE_MASK) {
-			      case PCI_BASE_ADDRESS_MEM_TYPE_32:
-				type = "32 bit"; break;
-			      case PCI_BASE_ADDRESS_MEM_TYPE_1M:
-				type = "20 bit"; break;
-			      case PCI_BASE_ADDRESS_MEM_TYPE_64:
-				type = "64 bit"; break;
-			}
-			seq_printf(m, "      %srefetchable %s memory at "
-				       "0x%lx [0x%lx].\n", pref, type,
-				       base,
-				       end);
-		}
-	}
-	return 0;
-}
-
-static struct seq_operations proc_pci_op = {
-	.start	= pci_seq_start,
-	.next	= pci_seq_next,
-	.stop	= pci_seq_stop,
-	.show	= show_dev_config
-};
-
 static int proc_bus_pci_dev_open(struct inode *inode, struct file *file)
 {
 	return seq_open(file, &proc_bus_pci_devices_op);
@@ -583,16 +483,6 @@
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
-static int proc_pci_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &proc_pci_op);
-}
-static struct file_operations proc_pci_operations = {
-	.open		= proc_pci_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
 
 static int __init pci_proc_init(void)
 {
@@ -607,9 +497,6 @@
 		pci_for_each_dev(dev) {
 			pci_proc_attach_device(dev);
 		}
-		entry = create_proc_entry("pci", 0, NULL);
-		if (entry)
-			entry->proc_fops = &proc_pci_operations;
 	}
 	return 0;
 }

