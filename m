Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268758AbUJEEF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268758AbUJEEF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 00:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268762AbUJEEF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 00:05:58 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:18952 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268758AbUJEEFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 00:05:52 -0400
Date: Tue, 5 Oct 2004 14:05:42 +1000
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] Backport Via IRQ mask fix
Message-ID: <20041005040542.GA10876@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcelo:

Here is a backport of the Via APIC IRQ mask fix that Al Viro made to 2.6.
This is his original description:

# ChangeSet
#   2004/06/23 10:55:18-07:00 viro@parcelfarce.linux.theplanet.co.uk 
#   [PATCH] bug in V-link handling (arch/i386/pci/irq.c)
#   
#   	Via southbridges use register 0x3c of the on-board devices (USB and
#   AC97) to control interrupt routing for those.  In drivers/pci/quirks.c we
#   set it correctly (dev->irq & 15).  However, in pirq_enable_irq() where the
#   second half of that stuff lives, we forget to apply the mask.
#   
#   	That's what causes problems with ioapic on via motherboards in 2.6.
#   One-liner below ACKed by Alan, verified on via-based boxen here, obviously
#   doesn't affect non-via ones (we only set interrupt_line_quirk for via
#   chipsets). 

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== arch/i386/kernel/pci-irq.c 1.29 vs edited =====
--- 1.29/arch/i386/kernel/pci-irq.c	2004-08-24 08:01:27 +10:00
+++ edited/arch/i386/kernel/pci-irq.c	2004-10-05 14:03:34 +10:00
@@ -1129,6 +1129,6 @@
 	/* VIA bridges use interrupt line for apic/pci steering across
 	   the V-Link */
 	else if (interrupt_line_quirk)
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq & 15);
 		
 }

--y0ulUmNC+osPPQO6--
