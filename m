Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVDYHg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVDYHg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 03:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVDYHg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 03:36:28 -0400
Received: from mx01.stofanet.dk ([212.10.10.11]:32153 "EHLO mx01.stofanet.dk")
	by vger.kernel.org with ESMTP id S262550AbVDYHgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 03:36:19 -0400
Message-ID: <426C9DED.9010206@molgaard.org>
Date: Mon, 25 Apr 2005 09:36:13 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.30 PicoPower IRQ router
Content-Type: multipart/mixed;
 boundary="------------000607080107000004010202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000607080107000004010202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

The following patch fixes Picopower PT86C523 (found in e.g. Dell 
Latitude XPI P150CD and, so I've heard, IBM Thinkpad 760 series) getting 
irq 0, and thus not working with yenta.
Patch is made from recommendations from David Hinds.

Best regards,

Sune Mølgaard

--------------000607080107000004010202
Content-Type: text/x-patch;
 name="linux-2.4.30-pico.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.30-pico.patch"

--- linux-2.4.30/arch/i386/kernel/pci-irq.c	2005-04-04 03:42:19.000000000 +0200
+++ linux/arch/i386/kernel/pci-irq.c	2005-04-25 08:43:02.501678464 +0200
@@ -157,6 +157,25 @@
 }
 
 /*
+ * PicoPower PT86C523
+ */
+
+static int pirq_pico_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+  outb(0x10+((pirq-1)>>1), 0x24);
+  return ((pirq-1)&1) ? (inb(0x26)>>4) : (inb(0x26)&0xf);
+}
+
+static int pirq_pico_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq) 
+{ 
+  outb(0x10+((pirq-1)>>1), 0x24);
+  unsigned int x;
+  x = inb(0x26); 
+  x = ((pirq-1)&1) ? ((x&0x0f)|(irq<<4)) : ((x&0xf0)|(irq)); 
+  outb(x,0x26); 
+} 
+
+/*
  * ALI pirq entries are damn ugly, and completely undocumented.
  * This has been figured out from pirq tables, and it's not a pretty
  * picture.
@@ -609,6 +628,23 @@
 
 #endif
 
+static __init int pico_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
+{
+  switch(device)
+  {
+    case 0x0002:
+      r->name = "PicoPower PT86C523";
+      r->get = pirq_pico_get;
+      r->set = pirq_pico_set;
+      return 1;
+
+    case 0x8002:
+      r->name = "PicoPower PT86C523 rev. BB+";
+      r->get = pirq_pico_get;
+      r->set = pirq_pico_set;
+      return 1;
+  }
+}
 
 static __init int intel_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
@@ -814,6 +850,7 @@
 }
 		
 static __initdata struct irq_router_handler pirq_routers[] = {
+        { 0x1066, pico_router_probe },
 	{ PCI_VENDOR_ID_INTEL, intel_router_probe },
 	{ PCI_VENDOR_ID_AL, ali_router_probe },
 	{ PCI_VENDOR_ID_ITE, ite_router_probe },

--------------000607080107000004010202--
