Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVCQXTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVCQXTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVCQXTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:19:22 -0500
Received: from isilmar.linta.de ([213.239.214.66]:44419 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261358AbVCQXSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:18:49 -0500
Date: Fri, 18 Mar 2005 00:18:48 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, akpm@osdl.org
Subject: [PATCH 2/2] PCI-PCI transparent bridge handling improvements (yenta_socket)
Message-ID: <20050317231848.GB24645@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	benh@kernel.crashing.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a follow-up, we can make yenta_socket try harder to limit itself to the
parent bridge windows. This is done by lowering the
PCIBIOS_MIN_CARDBUS_IO and by updating yenta_allocate_res(). It now tries at
first to get resources within the bridge windows, and if they are large
enough (>=BRIDGE_{IO,MEM}_ACC), these are used. If no or only too small
resources were found, it falls back to the resources behind the parent PCI
bridge if this is "transparent". Using this patch may result in such "funny"
/proc/ioports as:

2800-28ff : PCI CardBus #07
3000-3fff : PCI Bus #02
  3000-303f : 0000:02:08.0
    3000-303f : e100
  3400-34ff : PCI CardBus #03
  3800-38ff : PCI CardBus #03
  3c00-3cff : PCI CardBus #07

There weren't enough properly aligned ports available inside PCI Bus #02 to
stuff all four (2x2) IO windows into it, so one was taken outside the
transparent PCI bridge ioport window.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: 2.6.11++/drivers/pcmcia/yenta_socket.c
===================================================================
--- 2.6.11++.orig/drivers/pcmcia/yenta_socket.c	2005-03-17 23:13:58.000000000 +0100
+++ 2.6.11++/drivers/pcmcia/yenta_socket.c	2005-03-17 23:40:38.000000000 +0100
@@ -518,19 +518,23 @@
  * Use an adaptive allocation for the memory resource,
  * sometimes the memory behind pci bridges is limited:
  * 1/8 of the size of the io window of the parent.
- * max 4 MB, min 16 kB.
+ * max 4 MB, min 16 kB. We try very hard to not get
+ * below the "ACC" values, though.
  */
 #define BRIDGE_MEM_MAX 4*1024*1024
+#define BRIDGE_MEM_ACC 128*1024
 #define BRIDGE_MEM_MIN 16*1024
 
 #define BRIDGE_IO_MAX 256
+#define BRIDGE_IO_ACC 256
 #define BRIDGE_IO_MIN 32
 
 #ifndef PCIBIOS_MIN_CARDBUS_IO
 #define PCIBIOS_MIN_CARDBUS_IO PCIBIOS_MIN_IO
 #endif
 
-static void yenta_allocate_res(struct yenta_socket *socket, int nr, unsigned type)
+static int yenta_try_allocate_res(struct yenta_socket *socket, int nr,
+				  unsigned int type, unsigned int run)
 {
 	struct pci_bus *bus;
 	struct resource *root, *res;
@@ -550,11 +554,11 @@
 	res->name = bus->name;
 	res->flags = type;
 	res->start = 0;
-	res->end = 0;
+	res->end = run;
 	root = pci_find_parent_resource(socket->dev, res);
 
 	if (!root)
-		return;
+		return -ENODEV;
 
 	start = config_readl(socket, offset) & mask;
 	end = config_readl(socket, offset+4) | ~mask;
@@ -562,7 +566,8 @@
 		res->start = start;
 		res->end = end;
 		if (request_resource(root, res) == 0)
-			return;
+			return 0;
+
 		printk(KERN_INFO "yenta %s: Preassigned resource %d busy, reconfiguring...\n",
 				pci_name(socket->dev), nr);
 		res->start = res->end = 0;
@@ -571,12 +576,12 @@
 	if (type & IORESOURCE_IO) {
 		align = 1024;
 		size = BRIDGE_IO_MAX;
-		min = BRIDGE_IO_MIN;
+		min = run ? BRIDGE_IO_ACC : BRIDGE_IO_MIN;
 		start = PCIBIOS_MIN_CARDBUS_IO;
 		end = ~0U;
 	} else {
 		unsigned long avail = root->end - root->start;
-		int i;
+		u32 i;
 		size = BRIDGE_MEM_MAX;
 		if (size > avail/8) {
 			size=(avail+1)/8;
@@ -586,26 +591,36 @@
 				i++;
 			size = 1 << i;
 		}
-		if (size < BRIDGE_MEM_MIN)
-			size = BRIDGE_MEM_MIN;
+		i = run ? BRIDGE_MEM_ACC : BRIDGE_MEM_MIN;
+		if (size < i)
+			size = i;
 		min = BRIDGE_MEM_MIN;
 		align = size;
 		start = PCIBIOS_MIN_MEM;
 		end = ~0U;
 	}
-	
+
 	do {
 		if (allocate_resource(root, res, size, start, end, align, NULL, NULL)==0) {
 			config_writel(socket, offset, res->start);
 			config_writel(socket, offset+4, res->end);
-			return;
+			return 0;
 		}
 		size = size/2;
 		align = size;
 	} while (size >= min);
+
+	return -ENODEV;
+}
+
+static void yenta_allocate_res(struct yenta_socket *socket, int nr, unsigned type)
+{
+	if (!(yenta_try_allocate_res(socket, nr, type, 1)) ||
+	    !(yenta_try_allocate_res(socket, nr, type, 0)))
+		return;
+
 	printk(KERN_INFO "yenta %s: no resource of type %x available, trying to continue...\n",
 			pci_name(socket->dev), type);
-	res->start = res->end = 0;
 }
 
 /*
@@ -616,7 +631,7 @@
 	yenta_allocate_res(socket, 0, IORESOURCE_MEM|IORESOURCE_PREFETCH);
 	yenta_allocate_res(socket, 1, IORESOURCE_MEM);
 	yenta_allocate_res(socket, 2, IORESOURCE_IO);
-	yenta_allocate_res(socket, 3, IORESOURCE_IO);	/* PCI isn't clever enough to use this one yet */
+	yenta_allocate_res(socket, 3, IORESOURCE_IO);
 }
 
 
Index: 2.6.11++/include/asm-i386/pci.h
===================================================================
--- 2.6.11++.orig/include/asm-i386/pci.h	2005-03-17 23:13:58.000000000 +0100
+++ 2.6.11++/include/asm-i386/pci.h	2005-03-17 23:31:08.000000000 +0100
@@ -21,7 +21,7 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		(pci_mem_start)
 
-#define PCIBIOS_MIN_CARDBUS_IO	0x4000
+#define PCIBIOS_MIN_CARDBUS_IO	0x2000
 
 void pcibios_config_init(void);
 struct pci_bus * pcibios_scan_root(int bus);
