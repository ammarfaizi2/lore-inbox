Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934558AbWKXKoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934558AbWKXKoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 05:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934560AbWKXKoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 05:44:11 -0500
Received: from bill.weihenstephan.org ([82.135.35.21]:15572 "EHLO
	bill.weihenstephan.org") by vger.kernel.org with ESMTP
	id S934558AbWKXKoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 05:44:10 -0500
From: Juergen Beisert <juergen127@kreuzholzen.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: [PATCH 001/001] i386/pci: fix nibble permutation and add Cyrix 5530 IRQ router
Date: Fri, 24 Nov 2006 11:44:05 +0100
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241144.06267.juergen127@kreuzholzen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Beisert <juergen.beisert@weihenstephan.org>

This patch adds CYRIX_5530_LEGACY to the list of known PCI interrupt router,
to setup chipset's routing register with valid data. It seems never be a
problem if the BIOS sets up these registers. But in the presence of LinuxBios
it fails for Cyrix 5530, due to LinuxBios does not setup these registers
(it leave it at their reset values).

I have no Cyrix 5520 to check, but as the comment in the source states the
Cyrix 5520 and Cyrix 5530 do interrupt routing in the same way. But the
(pirq-1)^1 expression to set a route always sets the wrong nibble, so
INTA/INTB and INTC/INTD are permuted and do not work as expected.

Signed-off-by: Juergen Beisert <juergen.beisert@weihenstephan.org>

Index: arch/i386/pci/irq.c
===================================================================
--- arch/i386/pci/irq.c
+++ arch/i386/pci/irq.c
@@ -306,12 +306,12 @@ static int pirq_opti_set(struct pci_dev
  */
 static int pirq_cyrix_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	return read_config_nybble(router, 0x5C, (pirq-1)^1);
+	return read_config_nybble(router, 0x5C, pirq-1);
 }

 static int pirq_cyrix_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	write_config_nybble(router, 0x5C, (pirq-1)^1, irq);
+	write_config_nybble(router, 0x5C, pirq-1, irq);
 	return 1;
 }

@@ -642,6 +642,7 @@ static __init int cyrix_router_probe(str
 {
 	switch(device)
 	{
+		case PCI_DEVICE_ID_CYRIX_5530_LEGACY:
 		case PCI_DEVICE_ID_CYRIX_5520:
 			r->name = "NatSemi";
 			r->get = pirq_cyrix_get;
