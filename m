Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbUKBFA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUKBFA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S377998AbUKAWlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:41:13 -0500
Received: from eva.fit.vutbr.cz ([147.229.10.14]:53516 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S310424AbUKAU1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:27:36 -0500
Date: Mon, 1 Nov 2004 21:27:30 +0100
From: David Jez <dave.jez@seznam.cz>
To: Jim Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI & IRQ problems on TI Extensa 600CD
Message-ID: <20041101202730.GA49588@stud.fit.vutbr.cz>
References: <20041023142906.GA15789@stud.fit.vutbr.cz> <417AB69E.8010709@verizon.net> <20041025161945.GA82114@stud.fit.vutbr.cz> <20041029081848.GA5240@stud.fit.vutbr.cz> <41821250.70502@verizon.net> <20041101084211.GA98600@stud.fit.vutbr.cz> <4186334E.40109@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <4186334E.40109@verizon.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi Jim,

> Need to compile a new kernel for this thing w/o tridentfb - doesn't work 
> right on my system for some reason.
> 
> <dmesg - haven't compiled a 2.6.9 for it yet>
>
> PCI: PCI BIOS revision 2.10 entry at 0xfd930, last bus=6
> PCI: Using configuration type 1
> Linux Kernel Card Services
>   options:  [pci] [cardbus] [pm]
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
  IRQ router is missing.

> PCI: No IRQ known for interrupt pin A of device 0000:00:02.0. Please try 
> using pci=biosirq.
> PCI: No IRQ known for interrupt pin B of device 0000:00:02.1. Please try 
> using pci=biosirq.
>
> 00:00.0 Class 0600: 8086:1235 (rev 02)
> 00:01.0 Class 0601: 8086:122e (rev 02)
> 00:02.0 Class 0607: 104c:ac12 (rev 04)
> 00:02.1 Class 0607: 104c:ac12 (rev 04)
> 00:03.0 Class 0300: 1023:9660 (rev d3)
> 00:05.0 Class 0400: 1014:0057
> 
> No PCI interrupt routing table was found.
> 
> Interrupt router at 00:01.0: Intel 82371FB PIIX PCI-to-ISA bridge
>   PIRQ1 (link 0x60): irq 11
>   PIRQ2 (link 0x61): irq 11
>   PIRQ3 (link 0x62): unrouted
>   PIRQ4 (link 0x63): unrouted
>   Serial IRQ: [disabled] [quiet] [frame=17] [pulse=4]
>   Level mask: 0x0800 [11]
  It looks that you have same problem and kernel doesn't find IRQ
router. So try attached patch (for 2.6.9 and added your bridge) if it helps.
I think that it may help (look at dump_pirq results).
  You can try turn on DEBUG (in file arch/i386/pci/pci.h) and see debug
messages on screen.

  Dave
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="irq-2.6.9.diff"

--- linux-2.6.9/arch/i386/pci/irq.c.orig	Mon Oct 18 23:55:29 2004
+++ linux-2.6.9/arch/i386/pci/irq.c	Mon Nov  1 21:17:01 2004
@@ -589,6 +589,7 @@
 {
 	switch(device)
 	{
+	case PCI_DEVICE_ID_AL_M1523:
 	case PCI_DEVICE_ID_AL_M1533:
 	case PCI_DEVICE_ID_AL_M1563:
 		printk("PCI: Using ALI IRQ Router\n");
@@ -668,8 +669,20 @@
 
 	pirq_router_dev = pci_find_slot(rt->rtr_bus, rt->rtr_devfn);
 	if (!pirq_router_dev) {
-		DBG("PCI: Interrupt router not found at %02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
-		return;
+		DBG("PCI: Interrupt router not found at %02x:%02x. Aieee, do you have crippled chipset?\n",
+		    rt->rtr_bus, rt->rtr_devfn);
+		pirq_router_dev = (pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1523, NULL));
+		if (!pirq_router_dev)
+			pirq_router_dev = (pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL));
+		if (!pirq_router_dev)
+			pirq_router_dev = (pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, NULL));
+		if (!pirq_router_dev) {
+			DBG("PCI: ...hmmm sorry...\n");
+			return;
+		} else {
+			DBG("PCI: OK, found %04x:%04x. Let's playing a game!\n",
+			    pirq_router_dev->vendor, pirq_router_dev->device);
+		}
 	}
 
 	for( h = pirq_routers; h->vendor; h++) {

--cNdxnHkX5QqsyA0e--
