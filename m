Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278501AbRJPCOi>; Mon, 15 Oct 2001 22:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278500AbRJPCOT>; Mon, 15 Oct 2001 22:14:19 -0400
Received: from patan.Sun.COM ([192.18.98.43]:16017 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278498AbRJPCOH>;
	Mon, 15 Oct 2001 22:14:07 -0400
Message-ID: <3BCB9750.D9B10A16@sun.com>
Date: Mon, 15 Oct 2001 19:11:28 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mj@suse.cz, jgarzik@mandrakesoft.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] minor PCI tweaks
Content-Type: multipart/mixed;
 boundary="------------76CC1165A59419D36908873F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------76CC1165A59419D36908873F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a small patch to tweak a couple items in the PCI subsystem. 
They've been in use here for some time.  Please apply, or let me know of
any issues.

1) set the PCI busspeed(s) from the kernel commandline (this is useful for
systems that have busses other than 33 or 66 MHz.  

2) clear the Received Master Abort bit on bridges after probing

Thanks!
Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------76CC1165A59419D36908873F
Content-Type: text/plain; charset=us-ascii;
 name="pci-misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-misc.diff"

diff -ruN dist-2.4.12+patches/drivers/pci/pci.c cvs-2.4.12+patches/drivers/pci/pci.c
--- dist-2.4.12+patches/drivers/pci/pci.c	Mon Oct 15 10:22:23 2001
+++ cvs-2.4.12+patches/drivers/pci/pci.c	Mon Oct 15 10:22:22 2001
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
+#include <linux/ctype.h>
 #include <linux/kmod.h>		/* for hotplug_path */
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -38,6 +39,8 @@
 LIST_HEAD(pci_root_buses);
 LIST_HEAD(pci_devices);
 
+static int get_bus_speed(struct pci_bus *bus);
+
 /**
  * pci_find_slot - locate PCI device from a given PCI slot
  * @bus: number of PCI bus on which desired PCI device resides
@@ -1069,6 +1072,7 @@
 	child->number = child->secondary = busnr;
 	child->primary = parent->secondary;
 	child->subordinate = 0xff;
+	child->bus_speed = get_bus_speed(child);
 
 	/* Set up default resource pointers.. */
 	for (i = 0; i < 4; i++)
@@ -1254,8 +1258,19 @@
 		return NULL;
 
 	/* some broken boards return 0 or ~0 if a slot is empty: */
-	if (l == 0xffffffff || l == 0x00000000 || l == 0x0000ffff || l == 0xffff0000)
+	if (l == 0xffffffff || l == 0x00000000 
+	 || l == 0x0000ffff || l == 0xffff0000) {
+		/*
+		 * host/pci and pci/pci bridges will set Received Master Abort
+		 * (bit 13) on failed configuration access (happens when
+		 * searching for devices).  To be safe, clear the status
+		 * register.
+		 */
+		unsigned short st;
+		pci_read_config_word(temp, PCI_STATUS, &st);
+		pci_write_config_word(temp, PCI_STATUS, st);
 		return NULL;
+	}
 
 	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -1383,6 +1398,7 @@
 	list_add_tail(&b->node, &pci_root_buses);
 
 	b->number = b->secondary = bus;
+	b->bus_speed = get_bus_speed(b);
 	b->resource[0] = &ioport_resource;
 	b->resource[1] = &iomem_resource;
 	return b;
@@ -1935,7 +1951,67 @@
 	return 1;
 }
 
+#define MAX_OVERRIDES 256
+static int pci_speed_overrides[MAX_OVERRIDES] __initdata;
+
+static int __init get_bus_speed(struct pci_bus *bus)
+{
+	if (!bus) {
+		return -1;
+	}
+
+	if (pci_speed_overrides[bus->number]) {
+		return pci_speed_overrides[bus->number];
+	} else {
+		/* printk("PCI: assuming 33 MHz for bus %d\n", bus->number); */
+		return 33;
+	}
+}
+
+/* handle pcispeed=0:33,1:66 parameter (speed=0 means unknown) */
+static int __init pci_speed_setup(char *str)
+{
+        while (str) {
+                char *k = strchr(str, ',');
+                if (k) {
+                        *k++ = '\0';
+		}
+
+                if (*str) {
+                        int bus;
+                        int speed;
+                        char *endp;
+
+			if (!isdigit(*str)) {
+				printk("PCI: bad bus number for "
+					"pcispeed parameter\n");
+				str = k;
+				continue;
+			}
+                        bus = simple_strtoul(str, &endp, 0);
+
+                        if (!*endp || !isdigit(*(++endp))) {
+				printk("PCI: bad speed for "
+					"pcispeed parameter\n");
+				str = k;
+				continue;
+			}
+			speed = simple_strtoul(endp, NULL, 0);
+			pci_speed_overrides[bus] = speed;
+			printk("PCI: setting bus %d speed to %d MHz\n",
+				bus, speed);
+
+			str = k;
+		} else {
+			break;
+		}
+	}
+	return 1;
+}
+
 __setup("pci=", pci_setup);
+__setup("pcispeed=", pci_speed_setup);
+
 
 EXPORT_SYMBOL(pci_read_config_byte);
 EXPORT_SYMBOL(pci_read_config_word);
diff -ruN dist-2.4.12+patches/include/linux/pci.h cvs-2.4.12+patches/include/linux/pci.h
--- dist-2.4.12+patches/include/linux/pci.h	Mon Oct 15 10:23:43 2001
+++ cvs-2.4.12+patches/include/linux/pci.h	Mon Oct 15 10:23:43 2001
@@ -420,6 +420,7 @@
 	unsigned char	primary;	/* number of primary bridge */
 	unsigned char	secondary;	/* number of secondary bridge */
 	unsigned char	subordinate;	/* max number of subordinate buses */
+	int		bus_speed;	/* the speed of this PCI segment */
 
 	char		name[48];
 	unsigned short	vendor;

--------------76CC1165A59419D36908873F--

