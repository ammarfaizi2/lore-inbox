Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263294AbRFABNP>; Thu, 31 May 2001 21:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263295AbRFABNF>; Thu, 31 May 2001 21:13:05 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:50070 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S263294AbRFABMx>;
	Thu, 31 May 2001 21:12:53 -0400
Message-ID: <3B16EC77.3253DBE@sun.com>
Date: Thu, 31 May 2001 18:14:31 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [PATCH] 66MHz PCI flag from commandline
In-Reply-To: <20010403110005.A3222@atrey.karlin.mff.cuni.cz> <200104041818.NAA08621@isunix.it.ilstu.edu> <20010404201259.A7820@atrey.karlin.mff.cuni.cz> <3ACB7798.1908657B@sun.com> <20010404220712.B929@albireo.ucw.cz> <3ACB8021.D446929E@sun.com> <20010404221547.B1040@albireo.ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------444ED779DC1728EB5DF6A733"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------444ED779DC1728EB5DF6A733
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Martin,

We spoke a while back about a pcispeed= command line param to set the PCI
busspeed values (for later querying, if needed).  Attached is my patch to
implement the feature we agreed upon.  It is against linux-2.4.5.

Below is our previous discussion, as a refresher :).  Please let me know if
this is not suitable for general inclusion in the kernel, and I'll try to
make it so.

Tim

(cc: lkml, alan)


Martin Mares wrote:
> > What do you think of my   pcispeed=0:33,2:66 idea?
 
> anything -- the 33/66 MHz values from the PCI specs are only upper limits),
> I'll welcome this option, but otherwise I'd rather like to use the measuring
> code in IDE driver as it requires no user intervention to get the right
> timing.

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------444ED779DC1728EB5DF6A733
Content-Type: text/plain; charset=us-ascii;
 name="pci-busspeed.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-busspeed.diff"

diff -ruN dist-2.4.5/drivers/pci/pci.c cobalt-2.4.5/drivers/pci/pci.c
--- dist-2.4.5/drivers/pci/pci.c	Sat May 19 17:43:06 2001
+++ cobalt-2.4.5/drivers/pci/pci.c	Thu May 31 14:32:33 2001
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
@@ -928,6 +931,7 @@
 	child->number = child->secondary = busnr;
 	child->primary = parent->secondary;
 	child->subordinate = 0xff;
+	child->bus_speed = get_bus_speed(child);
 
 	/* Set up default resource pointers.. */
 	for (i = 0; i < 4; i++)
@@ -1110,8 +1114,19 @@
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
@@ -1239,6 +1254,7 @@
 	list_add_tail(&b->node, &pci_root_buses);
 
 	b->number = b->secondary = bus;
+	b->bus_speed = get_bus_speed(b);
 	b->resource[0] = &ioport_resource;
 	b->resource[1] = &iomem_resource;
 	return b;
@@ -1739,7 +1755,66 @@
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
 
 
 EXPORT_SYMBOL(pci_read_config_byte);
diff -ruN dist-2.4.5/include/linux/pci.h cobalt-2.4.5/include/linux/pci.h
--- dist-2.4.5/include/linux/pci.h	Fri May 25 18:02:11 2001
+++ cobalt-2.4.5/include/linux/pci.h	Thu May 31 14:33:17 2001
@@ -1,5 +1,5 @@
 /*
- *	$Id: pci.h,v 1.87 1998/10/11 15:13:12 mj Exp $
+ *	$Id: pci.h,v 1.1.1.3 2001/04/04 20:08:09 thockin Exp $
  *
  *	PCI defines and function prototypes
  *	Copyright 1994, Drew Eckhardt
@@ -413,6 +413,7 @@
 	unsigned char	primary;	/* number of primary bridge */
 	unsigned char	secondary;	/* number of secondary bridge */
 	unsigned char	subordinate;	/* max number of subordinate buses */
+	int		bus_speed;	/* the speed of this PCI segment */
 
 	char		name[48];
 	unsigned short	vendor;

--------------444ED779DC1728EB5DF6A733--

