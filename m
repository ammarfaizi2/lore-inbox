Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVD1KhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVD1KhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 06:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVD1KhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 06:37:14 -0400
Received: from mx02.stofanet.dk ([212.10.10.12]:2777 "EHLO mx02.stofanet.dk")
	by vger.kernel.org with ESMTP id S261998AbVD1Kgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 06:36:47 -0400
Message-ID: <4270BCCA.6030209@molgaard.org>
Date: Thu, 28 Apr 2005 12:36:58 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jesper Juhl <juhl-lkml@dif.dk>, mj@ucw.cz
Subject: Re: [PATCH] 2.4.30 PicoPower IRQ router
References: <426C9DED.9010206@molgaard.org> <200504261740.08794.lists@b-open-solutions.it> <426E8FE4.5040307@molgaard.org> <20050427112850.GA18533@nd47.coderock.org> <426FD8C7.5080800@molgaard.org> <Pine.LNX.4.62.0504272250300.2481@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504272250300.2481@dragon.hyggekrogen.localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> A few more style comments below. Nice cleanup compared to the first 
> version though. Now let's get it perfect :-)
> 

Let's try :-)

> Proper form would be:  Signed-off-by: Sune Molgaard <sune@molgaard.org>

Signed-off-by: Sune Mølgaard <sune@molgaard.org>

> This mismatch is found several places in the patch. Besides, the patch 
> seems whitespace damaged - the lines seem to be indented with spaces, not 
> tabs. Perhaps your email client mangled it?
> 

How do I tell?

>>+        switch(device)
>>+       {
> 
> 
> The opening brace goes on the same line as the switch statement.
> 
> See Documentation/CodingStyle Chapter 2

The other switch statements in the file are bracketed like this. I think 
changing that would be up to that author. Correct me if I am wrong.

--Begin patch--
diff -Npru linux-2.4.30/arch/i386/kernel/pci-irq.c \
linux/arch/i386/kernel/pci-irq.c
--- linux-2.4.30/arch/i386/kernel/pci-irq.c     2005-04-04 
03:42:19.000000000 +0200
+++ linux/arch/i386/kernel/pci-irq.c    2005-04-28 12:31:34.999771672 +0200
@@ -157,6 +157,25 @@ static void write_config_nybble(struct p
  }

  /*
+ * PicoPower PT86C523
+ */
+
+static int pirq_pico_get(struct pci_dev *router, struct pci_dev *dev, 
int pirq)
+{
+       outb(0x10+((pirq-1)>>1), 0x24);
+       return ((pirq-1)&1) ? (inb(0x26)>>4) : (inb(0x26)&0xf);
+}
+
+static int pirq_pico_set(struct pci_dev *router, struct pci_dev *dev, 
int pirq, int irq)
+{
+       outb(0x10+((pirq-1)>>1), 0x24);
+       unsigned int x;
+       x = inb(0x26);
+       x = ((pirq-1)&1) ? ((x&0x0f)|(irq<<4)) : ((x&0xf0)|(irq));
+       outb(x,0x26);
+}
+
+/*
   * ALI pirq entries are damn ugly, and completely undocumented.
   * This has been figured out from pirq tables, and it's not a pretty
   * picture.
@@ -609,6 +628,24 @@ static int pirq_bios_set(struct pci_dev

  #endif

+static __init int pico_router_probe(struct irq_router *r, struct 
pci_dev *router, u16 device)
+{
+       switch(device)
+       {
+               case PCI_DEVICE_PICOPOWER_PT86C523:
+                       r->name = "PicoPower PT86C523";
+                       r->get = pirq_pico_get;
+                       r->set = pirq_pico_set;
+                       return 1;
+
+               case PCI_DEVICE_PICOPOWER_PT86C523BBP:
+                       r->name = "PicoPower PT86C523 rev. BB+";
+                       r->get = pirq_pico_get;
+                       r->set = pirq_pico_set;
+                       return 1;
+       }
+       return 0;
+}

  static __init int intel_router_probe(struct irq_router *r, struct 
pci_dev *router, u16 device)
  {
@@ -814,6 +851,7 @@ static __init int amd_router_probe(struc
  }

  static __initdata struct irq_router_handler pirq_routers[] = {
+       { PCI_VENDOR_ID_PICOPOWER, pico_router_probe },
         { PCI_VENDOR_ID_INTEL, intel_router_probe },
         { PCI_VENDOR_ID_AL, ali_router_probe },
         { PCI_VENDOR_ID_ITE, ite_router_probe },
diff -Npru linux-2.4.30/include/linux/pci_ids.h \
linux/include/linux/pci_ids.h
--- linux-2.4.30/include/linux/pci_ids.h        2005-04-04 
03:42:20.000000000 +0200
+++ linux/include/linux/pci_ids.h       2005-04-27 20:04:12.195597128 +0200
@@ -119,6 +119,10 @@

  /* Vendors and devices.  Sort key: vendor first, device next. */

+#define PCI_VENDOR_ID_PICOPOWER             0x104c
+#define PCI_DEVICE_ID_PICOPOWER_PT86C523    0x0002
+#define PCI_DEVICE_ID_PICOPOWER_PT86C523BBP 0x8002
+
  #define PCI_VENDOR_ID_DYNALINK         0x0675
  #define PCI_DEVICE_ID_DYNALINK_IS64PH  0x1702

--End patch--

Best regards,

Sune Mølgaard

-- 
Now, suddenly, dynamic HTML makes the Web as interactive as my old Apple 
IIc.
- Peter Merholz
