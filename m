Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSHXO6I>; Sat, 24 Aug 2002 10:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSHXO6I>; Sat, 24 Aug 2002 10:58:08 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:13697 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S316437AbSHXO6G>;
	Sat, 24 Aug 2002 10:58:06 -0400
Message-ID: <3D67A042.5030706@colorfullife.com>
Date: Sat, 24 Aug 2002 17:03:30 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com, dhinds@zen.stanford.edu
Subject: [PATCH] reduce size of bridge regions for yenta.c
Content-Type: multipart/mixed;
 boundary="------------040207080401050801020507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040207080401050801020507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

yenta.c tries to allocate 2 bridge regions, each 4 MB: one for 
prefetchable memory, one for non-prefetchable memory.

The size of the regions must be adaptive: in my laptop, the cardbus 
bridge sits behind a pci bridge with a 1 MB bridge region :-(

The attached patch:
- limits the memory window to 1/8 of the window of the parent bridge 
(max 4 MB, min 16 kB)
- frees the resources during module unload
- adds error checking+printk

Please test it - my laptop now works.
Patch vs. 2.4.19, applies to 2.5.30, too.

--
	Manfred

--------------040207080401050801020507
Content-Type: text/plain;
 name="patch-yenta"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-yenta"

--- 2.4/drivers/pcmcia/yenta.c	Sat Aug  3 02:39:44 2002
+++ build-2.4/drivers/pcmcia/yenta.c	Sat Aug 24 16:59:34 2002
@@ -2,6 +2,11 @@
  * Regular lowlevel cardbus driver ("yenta")
  *
  * (C) Copyright 1999, 2000 Linus Torvalds
+ *
+ * Changelog:
+ * Aug 2002: Manfred Spraul <manfred@colorfullife.com>
+ * 	Dynamically adjust the size of the bridge resource
+ * 	
  */
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -704,6 +709,15 @@
 	return 0;
 }
 
+/*
+ * Use an adaptive allocation for the memory resource,
+ * sometimes the size behind pci bridges is limited:
+ * 1/8 of the size of the io window of the parent.
+ * max 4 MB, min 16 kB.
+ */
+#define BRIDGE_SIZE_MAX	4*1024*1024
+#define BRIDGE_SIZE_MIN	16*1024
+
 static void yenta_allocate_res(pci_socket_t *socket, int nr, unsigned type)
 {
 	struct pci_bus *bus;
@@ -735,21 +749,42 @@
 	if (start && end > start) {
 		res->start = start;
 		res->end = end;
-		request_resource(root, res);
-		return;
+		if (request_resource(root, res) == 0)
+			return;
+		printk(KERN_INFO "yenta %s: Preassigned resource %d busy, reconfiguring...\n",
+				socket->dev->slot_name, nr);
+		res->start = res->end = 0;
 	}
 
-	align = size = 4*1024*1024;
-	min = PCIBIOS_MIN_MEM; max = ~0U;
 	if (type & IORESOURCE_IO) {
 		align = 1024;
 		size = 256;
 		min = 0x4000;
 		max = 0xffff;
+	} else {
+		unsigned long avail = root->end - root->start;
+		int i;
+		align = size = BRIDGE_SIZE_MAX;
+		if (size > avail/8) {
+			size=(avail+1)/8;
+			/* round size down to next power of 2 */
+			i = 0;
+			while ((size /= 2) != 0)
+				i++;
+			size = 1 << i;
+		}
+		if (size < BRIDGE_SIZE_MIN)
+			size = BRIDGE_SIZE_MIN;
+		align = size;
+		min = PCIBIOS_MIN_MEM; max = ~0U;
 	}
 		
-	if (allocate_resource(root, res, size, min, max, align, NULL, NULL) < 0)
+	if (allocate_resource(root, res, size, min, max, align, NULL, NULL) < 0) {
+		printk(KERN_INFO "yenta %s: no resource of type %x available, trying to continue...\n",
+				socket->dev->slot_name, type);
+		res->start = res->end = 0;
 		return;
+	}
 
 	config_writel(socket, offset, res->start);
 	config_writel(socket, offset+4, res->end);
@@ -767,6 +802,20 @@
 }
 
 /*
+ * Free the bridge mappings for the device..
+ */
+static void yenta_free_resources(pci_socket_t *socket)
+{
+	int i;
+	for (i=0;i<4;i++) {
+		struct resource *res;
+		res = socket->dev->resource + PCI_BRIDGE_RESOURCES + i;
+		if (res->start != 0 && res->end != 0)
+			release_resource(res);
+		res->start = res->end = 0;
+	}
+}
+/*
  * Close it down - release our resources and go home..
  */
 static void yenta_close(pci_socket_t *sock)
@@ -782,6 +831,7 @@
 
 	if (sock->base)
 		iounmap(sock->base);
+	yenta_free_resources(sock);
 }
 
 #include "ti113x.h"

--------------040207080401050801020507--


