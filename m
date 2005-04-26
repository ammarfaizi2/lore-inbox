Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVDZTA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVDZTA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 15:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDZTA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 15:00:56 -0400
Received: from mx02.stofanet.dk ([212.10.10.12]:20194 "EHLO mx02.stofanet.dk")
	by vger.kernel.org with ESMTP id S261734AbVDZTAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 15:00:40 -0400
Message-ID: <426E8FE4.5040307@molgaard.org>
Date: Tue, 26 Apr 2005 21:00:52 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mj@ucw.cz
Subject: Re: [PATCH] 2.4.30 PicoPower IRQ router
References: <426C9DED.9010206@molgaard.org> <200504261740.08794.lists@b-open-solutions.it>
In-Reply-To: <200504261740.08794.lists@b-open-solutions.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Amici wrote:
> just in case you didn't notice: your patch is empty :)

How so? I see it fine in the mail that came back to me, but ok. I'll
repost below.

> and try to gather info on someone actually in charge of the subsystem 
> you are modifying and CC him. random patches on l-k may not get the 
> needed attention.
> 

I thought of that and forwarded to Martin Mares, but thank you for the tip

Best regards,

Sune

--Start patch--

--- linux-2.4.30/arch/i386/kernel/pci-irq.c	2005-04-04
03:42:19.000000000 +0200
+++ linux/arch/i386/kernel/pci-irq.c	2005-04-25 08:43:02.501678464 +0200
@@ -157,6 +157,25 @@
  }

  /*
+ * PicoPower PT86C523
+ */
+
+static int pirq_pico_get(struct pci_dev *router, struct pci_dev *dev,
int pirq)
+{
+  outb(0x10+((pirq-1)>>1), 0x24);
+  return ((pirq-1)&1) ? (inb(0x26)>>4) : (inb(0x26)&0xf);
+}
+
+static int pirq_pico_set(struct pci_dev *router, struct pci_dev *dev,
int pirq, int irq)
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

+static __init int pico_router_probe(struct irq_router *r, struct
pci_dev *router, u16 device)
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

  static __init int intel_router_probe(struct irq_router *r, struct
pci_dev *router, u16 device)
  {
@@ -814,6 +850,7 @@
  }
  		
  static __initdata struct irq_router_handler pirq_routers[] = {
+        { 0x1066, pico_router_probe },
  	{ PCI_VENDOR_ID_INTEL, intel_router_probe },
  	{ PCI_VENDOR_ID_AL, ali_router_probe },
  	{ PCI_VENDOR_ID_ITE, ite_router_probe },

--End patch--

-- 
The best way to accelerate a Macintosh is at 9.8m sec sec.
- Marcus Dolengo

