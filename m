Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbSKDULY>; Mon, 4 Nov 2002 15:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262721AbSKDULY>; Mon, 4 Nov 2002 15:11:24 -0500
Received: from fmr05.intel.com ([134.134.136.6]:61913 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262722AbSKDULS>; Mon, 4 Nov 2002 15:11:18 -0500
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF75@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: RFC: bare pci configuration access functions ?
Date: Mon, 4 Nov 2002 12:17:45 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C2843F.3CA2BF20"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C2843F.3CA2BF20
Content-Type: text/plain;
	charset="iso-8859-1"

Hi Greg,

> What's wrong with the _existing_ pci_config_read() and
> pci_config_write() function pointers that ia64 and i386 have? 
>  Can't you
> just look into if the other archs can set them to the proper 
> function in
> their pci init functions too?

Other architectures' PCI config access methods vary and require their own
address mappings, etc.

There could be two ways to achieve bare pci config accesses for all
architectures.

#1. upper level functions of pci_ops functions.
	i.e., Just export APIs like pci_config_read_bare(s, b, d, f, l, s,
v) and have it call pci_ops's pci_bus_read_config_##size(). Since all
architecture supports pci_ops, this solution is architecture independent and
no changes are needed in existing arch pci codes.
Actually, this is how drivers/pci/syscall.c is implemented. Only diff is it
allows accesses to unpopulated pci config spaces w/ temporary pci_bus
structure inherited from root, as needed by acpi, php driver, etc.

#2. lower level functions of pci_ops functions/or separate functions from
pci_ops.
	This is how I386 and IA64's pci_config_{read|write} are implemented.
pci_ops functions call these. To achieve this, every architecture pci code
need changes and the changes are all architecture specific as they need addr
mapping, etc.

I prefer #1 since (1)it is small and does not require changes in arch pci
codes, (2)the concept has already been proved(temp pci_bus struct, in both
acpi and php driver), and (3)it is common to all architecture.

Patch below (also attached) is a reference implementation of #1, and
verified with cpqphp driver.
I put the code in drivers/hotplug/pci_hotplug_util.c for testing convenience
purpose.
Don't pay attention to function names, but the logic it is based on. I don't
like the names either :)

Any comment, ideas would be appreciated.
thanks,
J.I.

diff -urN hotplug/pci_hotplug_util.c hotplug_all_1030/pci_hotplug_util.c
--- hotplug/pci_hotplug_util.c	Wed Oct 30 16:43:07 2002
+++ hotplug_all_1030/pci_hotplug_util.c	Fri Nov  1 18:56:34 2002
@@ -153,6 +153,124 @@
 	return result;
 }
 
+#define	BARE_PCI_ACCESS
+#ifdef	BARE_PCI_ACCESS
+static struct pci_bus *root_pci_bus;
+static struct pci_bus *get_temporary_pci_bus(int busnum)
+{
+	static int first = 1;
+	struct pci_bus *pbus;
+	struct list_head *lh;
+
+	if (first) {
+		list_for_each (lh, &pci_root_buses) {
+			pbus = (struct pci_bus *) pci_bus_b(lh);
+			if (pbus)
+				if (pbus->number == 0) {
+					root_pci_bus = pbus;
+					first = 0;
+				}
+		}
+	}
+	if (!root_pci_bus)
+		return NULL;
+
+	pbus = kmalloc(sizeof(struct pci_bus), GFP_KERNEL);
+	if (pbus) {
+		memset(pbus, 0, sizeof(struct pci_bus));
+		pbus->number = busnum;
+		pbus->ops = root_pci_bus->ops;
+	}
+
+	return pbus;
+}
+
+static int get_pci_bus (
+	int segnum, int busnum, int devnum, int funcnum, struct pci_bus
**pbus)
+{
+	struct pci_dev *pdev = pci_find_slot(busnum, PCI_DEVFN(devnum,
funcnum));
+	int is_temp = 0;
+
+	if (pdev && pdev->bus)
+		*pbus = pdev->bus;
+	else {
+		*pbus = get_temporary_pci_bus(busnum);
+		is_temp++;
+	}
+	return is_temp;
+}
+
+int pci_config_bare_read (int segnum, int busnum, int devnum, int funcnum,
+	int loc, int size, u32 *value)
+{
+	struct pci_bus *pbus;
+	int retval, is_temp = get_pci_bus(segnum, busnum, devnum, funcnum,
&pbus);
+
+	if (!pbus)
+		return -ENODEV;
+
+	*value = 0x00;
+
+	switch (size) {
+	case 1:
+		retval = pci_bus_read_config_byte
+				(pbus, PCI_DEVFN(devnum, funcnum), loc, (u8
*)value);
+		break;
+	case 2:
+		retval = pci_bus_read_config_word
+				(pbus, PCI_DEVFN(devnum, funcnum), loc, (u16
*)value);
+		break;
+	case 4:
+		retval = pci_bus_read_config_dword
+				(pbus, PCI_DEVFN(devnum, funcnum), loc,
value);
+		break;
+	default:
+		retval = -ENODEV;
+		break;
+	}
+
+	if (is_temp)
+		kfree(pbus);
+
+	return retval;
+}
+
+int pci_config_bare_write (int segnum, int busnum, int devnum, int funcnum,
+	int loc, int size, u32 value)
+{
+	struct pci_bus *pbus;
+	int retval, is_temp = get_pci_bus(segnum, busnum, devnum, funcnum,
&pbus);
+
+	if (!pbus)
+		return -ENODEV;
+
+	switch (size) {
+	case 1:
+		retval = pci_bus_write_config_byte
+				(pbus, PCI_DEVFN(devnum, funcnum), loc,
(u8)value);
+		break;
+	case 2:
+		retval = pci_bus_write_config_word
+				(pbus, PCI_DEVFN(devnum, funcnum), loc,
(u16)value);
+		break;
+	case 4:
+		retval = pci_bus_write_config_dword
+				(pbus, PCI_DEVFN(devnum, funcnum), loc,
value);
+		break;
+	default:
+		retval = -ENODEV;
+		break;
+	}
+
+	if (is_temp)
+		kfree(pbus);
+
+	return retval;
+}
+
+EXPORT_SYMBOL(pci_config_bare_read);
+EXPORT_SYMBOL(pci_config_bare_write);
+#endif
 
 EXPORT_SYMBOL(pci_visit_dev);
 


------_=_NextPart_000_01C2843F.3CA2BF20
Content-Type: application/octet-stream;
	name="bare_pci.diff"
Content-Disposition: attachment;
	filename="bare_pci.diff"

diff -urN hotplug/pci_hotplug_util.c hotplug_all_1030/pci_hotplug_util.c
--- hotplug/pci_hotplug_util.c	Wed Oct 30 16:43:07 2002
+++ hotplug_all_1030/pci_hotplug_util.c	Fri Nov  1 18:56:34 2002
@@ -153,6 +153,124 @@
 	return result;
 }
 
+#define	BARE_PCI_ACCESS
+#ifdef	BARE_PCI_ACCESS
+static struct pci_bus *root_pci_bus;
+static struct pci_bus *get_temporary_pci_bus(int busnum)
+{
+	static int first = 1;
+	struct pci_bus *pbus;
+	struct list_head *lh;
+
+	if (first) {
+		list_for_each (lh, &pci_root_buses) {
+			pbus = (struct pci_bus *) pci_bus_b(lh);
+			if (pbus)
+				if (pbus->number == 0) {
+					root_pci_bus = pbus;
+					first = 0;
+				}
+		}
+	}
+	if (!root_pci_bus)
+		return NULL;
+
+	pbus = kmalloc(sizeof(struct pci_bus), GFP_KERNEL);
+	if (pbus) {
+		memset(pbus, 0, sizeof(struct pci_bus));
+		pbus->number = busnum;
+		pbus->ops = root_pci_bus->ops;
+	}
+
+	return pbus;
+}
+
+static int get_pci_bus (
+	int segnum, int busnum, int devnum, int funcnum, struct pci_bus **pbus)
+{
+	struct pci_dev *pdev = pci_find_slot(busnum, PCI_DEVFN(devnum, funcnum));
+	int is_temp = 0;
+
+	if (pdev && pdev->bus)
+		*pbus = pdev->bus;
+	else {
+		*pbus = get_temporary_pci_bus(busnum);
+		is_temp++;
+	}
+	return is_temp;
+}
+
+int pci_config_bare_read (int segnum, int busnum, int devnum, int funcnum,
+	int loc, int size, u32 *value)
+{
+	struct pci_bus *pbus;
+	int retval, is_temp = get_pci_bus(segnum, busnum, devnum, funcnum, &pbus);
+
+	if (!pbus)
+		return -ENODEV;
+
+	*value = 0x00;
+
+	switch (size) {
+	case 1:
+		retval = pci_bus_read_config_byte
+				(pbus, PCI_DEVFN(devnum, funcnum), loc, (u8 *)value);
+		break;
+	case 2:
+		retval = pci_bus_read_config_word
+				(pbus, PCI_DEVFN(devnum, funcnum), loc, (u16 *)value);
+		break;
+	case 4:
+		retval = pci_bus_read_config_dword
+				(pbus, PCI_DEVFN(devnum, funcnum), loc, value);
+		break;
+	default:
+		retval = -ENODEV;
+		break;
+	}
+
+	if (is_temp)
+		kfree(pbus);
+
+	return retval;
+}
+
+int pci_config_bare_write (int segnum, int busnum, int devnum, int funcnum,
+	int loc, int size, u32 value)
+{
+	struct pci_bus *pbus;
+	int retval, is_temp = get_pci_bus(segnum, busnum, devnum, funcnum, &pbus);
+
+	if (!pbus)
+		return -ENODEV;
+
+	switch (size) {
+	case 1:
+		retval = pci_bus_write_config_byte
+				(pbus, PCI_DEVFN(devnum, funcnum), loc, (u8)value);
+		break;
+	case 2:
+		retval = pci_bus_write_config_word
+				(pbus, PCI_DEVFN(devnum, funcnum), loc, (u16)value);
+		break;
+	case 4:
+		retval = pci_bus_write_config_dword
+				(pbus, PCI_DEVFN(devnum, funcnum), loc, value);
+		break;
+	default:
+		retval = -ENODEV;
+		break;
+	}
+
+	if (is_temp)
+		kfree(pbus);
+
+	return retval;
+}
+
+EXPORT_SYMBOL(pci_config_bare_read);
+EXPORT_SYMBOL(pci_config_bare_write);
+#endif
 
 EXPORT_SYMBOL(pci_visit_dev);
 

------_=_NextPart_000_01C2843F.3CA2BF20--
