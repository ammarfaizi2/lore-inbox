Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267988AbRHNCLq>; Mon, 13 Aug 2001 22:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269326AbRHNCLg>; Mon, 13 Aug 2001 22:11:36 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:30651 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S267988AbRHNCLQ>;
	Mon, 13 Aug 2001 22:11:16 -0400
Message-ID: <3B7889AD.CC22548B@sun.com>
Date: Mon, 13 Aug 2001 19:15:09 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com, jgarzik@mandrakesoft.com, mj@ucw.cz,
        alan@redhat.com
Subject: [PATCH] PCI bus speed commandline
Content-Type: multipart/mixed;
 boundary="------------20AA0005717B7C6CC566A4D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------20AA0005717B7C6CC566A4D0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a very small patch against 2.4.8, which I have been sending for
a while.  It implements a commandline parameter 'pcispeed' which allows the
user to define the PCI bus speed with a priori knowledge, so that drivers
that care can find it.

I spoke about this a while back with you, Martin, and you said the idea
sounded alright.

If there is any reason this can't go into the next 2.4.x release, please
let me know.  It has been in use here for months.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------20AA0005717B7C6CC566A4D0
Content-Type: text/plain; charset=us-ascii;
 name="pci_busspeed.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_busspeed.diff"

diff -ruN dist+patches-2.4.8/drivers/pci/pci.c cobalt-2.4.8/drivers/pci/pci.c
--- dist+patches-2.4.8/drivers/pci/pci.c	Wed Jul  4 09:41:34 2001
+++ cobalt-2.4.8/drivers/pci/pci.c	Mon Aug 13 16:42:12 2001
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
@@ -1361,6 +1376,7 @@
 	list_add_tail(&b->node, &pci_root_buses);
 
 	b->number = b->secondary = bus;
+	b->bus_speed = get_bus_speed(b);
 	b->resource[0] = &ioport_resource;
 	b->resource[1] = &iomem_resource;
 	return b;
@@ -1913,7 +1929,67 @@
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
diff -ruN dist+patches-2.4.8/include/linux/pci.h cobalt-2.4.8/include/linux/pci.h
--- dist+patches-2.4.8/include/linux/pci.h	Fri Aug 10 18:14:42 2001
+++ cobalt-2.4.8/include/linux/pci.h	Mon Aug 13 16:42:50 2001
@@ -1,5 +1,5 @@
 /*
- *	$Id: pci.h,v 1.87 1998/10/11 15:13:12 mj Exp $
+ *	$Id: pci.h,v 1.1.1.3 2001/04/04 20:08:09 thockin Exp $
  *
  *	PCI defines and function prototypes
  *	Copyright 1994, Drew Eckhardt
@@ -420,6 +420,7 @@
 	unsigned char	primary;	/* number of primary bridge */
 	unsigned char	secondary;	/* number of secondary bridge */
 	unsigned char	subordinate;	/* max number of subordinate buses */
+	int		bus_speed;	/* the speed of this PCI segment */
 
 	char		name[48];
 	unsigned short	vendor;

--------------20AA0005717B7C6CC566A4D0--

