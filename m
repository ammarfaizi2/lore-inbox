Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWEPPEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWEPPEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWEPPEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:04:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18897 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932068AbWEPPEK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:04:10 -0400
Subject: Re: pcmcia oops on 2.6.17-rc[12]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
In-Reply-To: <Pine.LNX.4.64.0605151629350.3866@g5.osdl.org>
References: <20060423192251.GD8896@iucha.net>
	 <20060423150206.546b7483.akpm@osdl.org>
	 <20060508145609.GA3983@rhlx01.fht-esslingen.de>
	 <20060508084301.5025b25d.akpm@osdl.org>
	 <20060508163453.GB19040@flint.arm.linux.org.uk>
	 <1147730828.26686.165.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org>
	 <1147734026.26686.200.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605151629350.3866@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 16:16:44 +0100
Message-Id: <1147792604.2151.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 16:37 -0700, Linus Torvalds wrote:
> ISA design. And PCMCIA is no longer an excuse, exactly because of some 
> systems that will route even the 16-bit interrupts through a PCI irq.

The patch below cleans up the pcmcia code a bit on the IRQ side (I did
this while debugging the problem just so I could read wtf it was doing),
and also adds a warning and passes back the correct information when a
device asks for exclusive but gets given shared. This at least means the
dmesg dump of a problem triggered by this will have a signature to find.

Alan

Signed-off-by: Alan Cox <alan@redhat.com>


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17-rc4/drivers/pcmcia/pcmcia_resource.c linux-2.6.17-rc4/drivers/pcmcia/pcmcia_resource.c
--- linux.vanilla-2.6.17-rc4/drivers/pcmcia/pcmcia_resource.c	2006-05-15 15:46:04.000000000 +0100
+++ linux-2.6.17-rc4/drivers/pcmcia/pcmcia_resource.c	2006-05-16 14:59:42.000000000 +0100
@@ -788,6 +788,7 @@
 	struct pcmcia_socket *s = p_dev->socket;
 	config_t *c;
 	int ret = CS_IN_USE, irq = 0;
+	int type;
 
 	if (!(s->state & SOCKET_PRESENT))
 		return CS_NO_CARD;
@@ -797,6 +798,13 @@
 	if (c->state & CONFIG_IRQ_REQ)
 		return CS_IN_USE;
 
+	/* Decide what type of interrupt we are registering */
+	type = 0;
+	if (s->functions > 1)		/* All of this ought to be handled higher up */
+		type = SA_SHIRQ;
+	if (req->Attributes & IRQ_TYPE_DYNAMIC_SHARING)
+		type = SA_SHIRQ;
+	
 #ifdef CONFIG_PCMCIA_PROBE
 	if (s->irq.AssignedIRQ != 0) {
 		/* If the interrupt is already assigned, it must be the same */
@@ -822,9 +830,7 @@
 			 * marked as used by the kernel resource management core */
 			ret = request_irq(irq,
 					  (req->Attributes & IRQ_HANDLE_PRESENT) ? req->Handler : test_action,
-					  ((req->Attributes & IRQ_TYPE_DYNAMIC_SHARING) ||
-					   (s->functions > 1) ||
-					   (irq == s->pci_irq)) ? SA_SHIRQ : 0,
+					  type, 
 					  p_dev->devname,
 					  (req->Attributes & IRQ_HANDLE_PRESENT) ? req->Instance : data);
 			if (!ret) {
@@ -839,18 +845,21 @@
 	if (ret && !s->irq.AssignedIRQ) {
 		if (!s->pci_irq)
 			return ret;
+		type = SA_SHIRQ;
 		irq = s->pci_irq;
 	}
 
-	if (ret && req->Attributes & IRQ_HANDLE_PRESENT) {
-		if (request_irq(irq, req->Handler,
-				((req->Attributes & IRQ_TYPE_DYNAMIC_SHARING) ||
-				 (s->functions > 1) ||
-				 (irq == s->pci_irq)) ? SA_SHIRQ : 0,
-				p_dev->devname, req->Instance))
+	if (ret && (req->Attributes & IRQ_HANDLE_PRESENT)) {
+		if (request_irq(irq, req->Handler, type,  p_dev->devname, req->Instance))
 			return CS_IN_USE;
 	}
 
+	/* Make sure the fact the request type was overridden is passed back */
+	if (type == SA_SHIRQ && !(req->Attributes & IRQ_TYPE_DYNAMIC_SHARING)) {
+		req->Attributes |= IRQ_TYPE_DYNAMIC_SHARING;
+		printk(KERN_WARNING "pcmcia: request for exclusive IRQ could not be fulfilled.\n");
+		printk(KERN_WARNING "pcmcia: the driver needs updating to supported shared IRQ lines.\n");
+	}
 	c->irq.Attributes = req->Attributes;
 	s->irq.AssignedIRQ = req->AssignedIRQ = irq;
 	s->irq.Config++;

