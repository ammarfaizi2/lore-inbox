Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263144AbUJ2IYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbUJ2IYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUJ2IYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:24:13 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:30735 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S263144AbUJ2ITD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:19:03 -0400
Date: Fri, 29 Oct 2004 10:18:48 +0200
From: David Jez <dave.jez@seznam.cz>
To: Jim Nelson <james4765@verizon.net>
Cc: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PCI & IRQ problems on TI Extensa 600CD
Message-ID: <20041029081848.GA5240@stud.fit.vutbr.cz>
References: <20041023142906.GA15789@stud.fit.vutbr.cz> <417AB69E.8010709@verizon.net> <20041025161945.GA82114@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20041025161945.GA82114@stud.fit.vutbr.cz>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi all,

  Last night i solved this problem. It cause by crippled PCI chipset
parody called ALi and his perverse undocumented "features". I think that
use ISA bridge as IRQ router if we haven't any router is guite good idea.
  Everythink with this patch works fine even though i have different irq in
win. See attached logs.
  Jim, can you try this patch please? I assume that you have some kind
of ALi chipset too. Maybe this solves your problem too.
  Martin, Marcelo, please aply :-).

PS: is here anybody who have relevant datascheet?

  Regards,
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-irq.diff"

 pci-irq.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff -urN linux.orig/arch/i386/kernel/pci-irq.c linux/arch/i386/kernel/pci-irq.c
--- linux.orig/arch/i386/kernel/pci-irq.c	Fri Sep 24 15:19:06 2004
+++ linux/arch/i386/kernel/pci-irq.c	Thu Oct 28 15:49:26 2004
@@ -736,6 +736,7 @@
 {
 	switch(device)
 	{
+		case PCI_DEVICE_ID_AL_M1523:
 		case PCI_DEVICE_ID_AL_M1533:
 			r->name = "ALI";
 			r->get = pirq_ali_get;
@@ -814,8 +815,18 @@
 
 	pirq_router_dev = pci_find_slot(rt->rtr_bus, rt->rtr_devfn);
 	if (!pirq_router_dev) {
-		DBG("PCI: Interrupt router not found at %02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
-		return;
+		DBG("PCI: Interrupt router not found at %02x:%02x. Aieee, do you have ALi chipset?\n",
+		    rt->rtr_bus, rt->rtr_devfn);
+		pirq_router_dev = (pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1523, NULL));
+		if (!pirq_router_dev)
+			pirq_router_dev = (pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL));
+		if (!pirq_router_dev) {
+			DBG("PC: ...hmmm sorry...\n");
+			return;
+		} else {
+			DBG("PCI: OK, found %04x:%04x. Let's playing a game!\n",
+			    pirq_router_dev->vendor, pirq_router_dev->device);
+		}
 	}
 
 	for( h = pirq_routers; h->vendor; h++) {

--rwEMma7ioTxnRzrJ
Content-Type: application/x-gtar
Content-Disposition: attachment; filename="data.tgz"
Content-Transfer-Encoding: base64

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

--rwEMma7ioTxnRzrJ--
