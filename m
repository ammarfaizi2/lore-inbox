Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265771AbRGJGht>; Tue, 10 Jul 2001 02:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265766AbRGJGhk>; Tue, 10 Jul 2001 02:37:40 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:37298 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S265747AbRGJGha>;
	Tue, 10 Jul 2001 02:37:30 -0400
Message-ID: <3B4AA468.184A30CA@sun.com>
Date: Mon, 09 Jul 2001 23:44:56 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mj@ucw.cz
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: [PATCH]  PCI bus speed cmdline
Content-Type: multipart/mixed;
 boundary="------------EE07B8749AC5C200506C1446"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EE07B8749AC5C200506C1446
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Martin (et al),

We spoke a while back about a 'pcispeed=' command line param to set the PCI
busspeed values (for later querying, if needed).  Attached is my patch to
implement the feature we agreed upon.  It is against linux-2.4.6.

Please let me know if there is any problem that would make this not
suitable for general inclusion in the kernel.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------EE07B8749AC5C200506C1446
Content-Type: text/plain; charset=us-ascii;
 name="pci_bus_speed.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_bus_speed.diff"

diff -ruN dist-2.4.6/drivers/pci/pci.c cobalt-2.4.6/drivers/pci/pci.c
--- dist-2.4.6/drivers/pci/pci.c	Mon Jul  2 14:42:53 2001
+++ cobalt-2.4.6/drivers/pci/pci.c	Mon Jul  9 11:04:01 2001
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
+#include <linux/ctype.h>
 #include <linux/kmod.h>		/* for hotplug_path */
 #include <linux/bitops.h>
 
@@ -37,6 +38,8 @@
 LIST_HEAD(pci_root_buses);
 LIST_HEAD(pci_devices);
 
+static int get_bus_speed(struct pci_bus *bus);
+
 /**
  * pci_find_slot - locate PCI device from a given PCI slot
  * @bus: number of PCI bus on which desired PCI device resides
@@ -1047,6 +1050,7 @@
 	child->number = child->secondary = busnr;
 	child->primary = parent->secondary;
 	child->subordinate = 0xff;
+	child->bus_speed = get_bus_speed(child);
 
 	/* Set up default resource pointers.. */
 	for (i = 0; i < 4; i++)
@@ -1358,6 +1373,7 @@
 	list_add_tail(&b->node, &pci_root_buses);
 
 	b->number = b->secondary = bus;
+	b->bus_speed = get_bus_speed(b);
 	b->resource[0] = &ioport_resource;
 	b->resource[1] = &iomem_resource;
 	return b;
@@ -1910,7 +1926,67 @@
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
diff -ruN dist-2.4.6/include/linux/pci.h cobalt-2.4.6/include/linux/pci.h
--- dist-2.4.6/include/linux/pci.h	Tue Jul  3 15:43:41 2001
+++ cobalt-2.4.6/include/linux/pci.h	Mon Jul  9 15:55:48 2001
@@ -420,6 +420,7 @@
 	unsigned char	primary;	/* number of primary bridge */
 	unsigned char	secondary;	/* number of secondary bridge */
 	unsigned char	subordinate;	/* max number of subordinate buses */
+	int		bus_speed;	/* the speed of this PCI segment */
 
 	char		name[48];
 	unsigned short	vendor;

--------------EE07B8749AC5C200506C1446--

