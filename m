Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVHRMgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVHRMgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 08:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVHRMgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 08:36:03 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:30885 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932197AbVHRMgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 08:36:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=Hij4rmBhtQ0y1JBmTtwoHapd5j5ZJv3gt9hWv+DGmiIQycmvfzvXc2jJek8XsNNWKF9Bp9t5PK+Te9zKVX7mip4TiOflbPuNEgjho+XU05o1sswgApMUj2vPzFU9v7n0qphzlCfk31xPI//servxATHO6bh/lBAWzpTxFdAVvCM=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH,RFC] quirks for VIA VT8237 southbridge
Date: Thu, 18 Aug 2005 14:36:54 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <200508131710.38569.annabellesgarden@yahoo.de> <200508160949.10607.bjorn.helgaas@hp.com> <1124212816.20707.5.camel@localhost.localdomain>
In-Reply-To: <1124212816.20707.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200508181436.54880.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. August 2005 19:20 schrieb Alan Cox:
> 
> PCI interrupt line routing is used for all V-Bus devices. Thats all
> devices in any way on an internal bus of the north or south bridge. The
> quirk is harmless when applied to other devices.
> 
> Note the description of the quirk is still wrong
> 
> 
> > >  * For these devices, this register is defined to be 4 bits wide.
> > >  * Normally this is fine.  However for IO-APIC motherboards, or
> > >  * non-x86 architectures (yes Via exists on PPC among other places),
> > >  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
> > >  * interrupts delivered properly.
> 
> The interrupt line field is used to indicate the ISA type IRQ or the
> APIC pin used for the IRQ delivery. See the data sheet.
> 
> The & 0x0F is the old hack used to get the ISA type IRQ line in use from
> the IRQ number. 
> 

Thanks, Bjorn and Alan!
After thinking again here is a 3rd version to change quirk_via_irq().

Motivation is to cleanup the IOAPIC-case:
Currently as of 2.6.13-rc6 new_irq is wrong then,
as dev->irq isn't the PIN number.

Solutions: either calculate correct new_irq (= PIN-Number & 0x0F)
 or don't apply likely wrong value.

Following diff takes the 2nd way.

Well, VT8237 ignores the wrong new_irq in IOAPIC-Mode,
but its irritating to see dmesg print out nonsense then. 

------
--- linux-2.6.13-rc6/drivers/pci/quirks.c	2005-08-08 11:46:05.000000000 +0200
+++ linux-2.6.13/drivers/pci/quirks.c	2005-08-18 11:55:50.000000000 +0200
@@ -497,9 +516,27 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
  * interrupts delivered properly.
  */
+#ifdef CONFIG_X86_IO_APIC
+	extern struct hw_interrupt_type ioapic_edge_type;
+	extern struct hw_interrupt_type ioapic_level_type;
+#include <linux/irq.h>
+#endif
 static void quirk_via_irq(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
+#ifdef CONFIG_X86_IO_APIC
+	{
+		irq_desc_t *desc = irq_desc + dev->irq;
+		if (desc &&
+		    (desc->handler == &ioapic_edge_type ||
+		     desc->handler == &ioapic_level_type)
+			)
+			return;	/* We cannot guess the right
+				 * new_irq with the simple hack below.
+				 * lets just leave.
+				 */
+	}
+#endif
 
 	new_irq = dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
------

What do you think?

   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
