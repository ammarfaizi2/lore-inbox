Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbVIPLJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbVIPLJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 07:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVIPLJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 07:09:27 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:58242 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932643AbVIPLJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 07:09:27 -0400
Date: Fri, 16 Sep 2005 15:09:02 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Ilia Mirkin <imirkin@MIT.EDU>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: pci detection on alpha fails to assign irq to on-board usb device
Message-ID: <20050916150902.A4004@jurassic.park.msu.ru>
References: <1126830006.7002.12.camel@localhost> <20050916025416.GA31585@kroah.com> <1126844006.10966.68.camel@INFERNAL.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1126844006.10966.68.camel@INFERNAL.mit.edu>; from imirkin@MIT.EDU on Fri, Sep 16, 2005 at 12:13:25AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 12:13:25AM -0400, Ilia Mirkin wrote:
> Tried with 2.6.13.1 -- same thing. If you think that there are relevant
> patches that went into -rc1 that are not in .1, I could try that out
> too. A cursory look does not suggest any though.

USB has never worked on these machines with stock kernels.
Please try appended patch (also make sure that "usb_enable" is "on"
in SRM.

Ivan.

--- linux/arch/alpha/kernel/sys_dp264.c.orig	Fri Sep 16 14:41:22 2005
+++ linux/arch/alpha/kernel/sys_dp264.c	Fri Sep 16 14:48:13 2005
@@ -395,6 +395,22 @@ clipper_init_irq(void)
  */
 
 static int __init
+isa_irq_fixup(struct pci_dev *dev, int irq)
+{
+	u8 irq8;
+
+	if (irq > 0)
+		return irq;
+
+	/* This interrupt is routed via ISA bridge, so we'll
+	   just have to trust whatever value the console might
+	   have assigned.  */
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq8);
+
+	return irq8 & 0xf;
+}
+
+static int __init
 dp264_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	static char irq_tab[6][5] __initdata = {
@@ -407,25 +423,13 @@ dp264_map_irq(struct pci_dev *dev, u8 sl
 		{ 16+ 3, 16+ 3, 16+ 2, 16+ 1, 16+ 0}  /* IdSel 10 slot 3 */
 	};
 	const long min_idsel = 5, max_idsel = 10, irqs_per_slot = 5;
-
 	struct pci_controller *hose = dev->sysdata;
 	int irq = COMMON_TABLE_LOOKUP;
 
-	if (irq > 0) {
+	if (irq > 0)
 		irq += 16 * hose->index;
-	} else {
-		/* ??? The Contaq IDE controller on the ISA bridge uses
-		   "legacy" interrupts 14 and 15.  I don't know if anything
-		   can wind up at the same slot+pin on hose1, so we'll
-		   just have to trust whatever value the console might
-		   have assigned.  */
-
-		u8 irq8;
-		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq8);
-		irq = irq8;
-	}
 
-	return irq;
+	return isa_irq_fixup(dev, irq);
 }
 
 static int __init
@@ -453,7 +457,8 @@ monet_map_irq(struct pci_dev *dev, u8 sl
 		{    24,    24,    25,    26,    27}  /* IdSel 15 slot 5 PCI2*/
 	};
 	const long min_idsel = 3, max_idsel = 15, irqs_per_slot = 5;
-	return COMMON_TABLE_LOOKUP;
+
+	return isa_irq_fixup(dev, COMMON_TABLE_LOOKUP);
 }
 
 static u8 __init
@@ -507,7 +512,8 @@ webbrick_map_irq(struct pci_dev *dev, u8
 		{    47,    47,    46,    45,    44}, /* IdSel 17 slot 3 */
 	};
 	const long min_idsel = 7, max_idsel = 17, irqs_per_slot = 5;
-	return COMMON_TABLE_LOOKUP;
+
+	return isa_irq_fixup(dev, COMMON_TABLE_LOOKUP);
 }
 
 static int __init
@@ -524,14 +530,13 @@ clipper_map_irq(struct pci_dev *dev, u8 
 		{    -1,    -1,    -1,    -1,    -1}  /* IdSel 7 ISA Bridge */
 	};
 	const long min_idsel = 1, max_idsel = 7, irqs_per_slot = 5;
-
 	struct pci_controller *hose = dev->sysdata;
 	int irq = COMMON_TABLE_LOOKUP;
 
 	if (irq > 0)
 		irq += 16 * hose->index;
 
-	return irq;
+	return isa_irq_fixup(dev, irq);
 }
 
 static void __init
