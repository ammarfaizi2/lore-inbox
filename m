Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVG1MKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVG1MKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVG1MKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:10:33 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:21326 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261415AbVG1MKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:10:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type;
  b=i72aZDNYHuUxzSn/ysIc4+FTCPed0g0NQcQq4IEfWM1mEr5Rjrho77IlMc0gKoNqop5MCIA8uiQE2btMDh7ym92IQSNrBA3OGi9IP8mv4gJuXdC+91WYPhLUwh3jC10u+AUqIqmDcgGv4jnlhc7bZKlrcYyw4ZzHUDtinpwWMa4=  ;
Message-ID: <42E8CB27.4010100@yahoo.com.au>
Date: Thu, 28 Jul 2005 22:10:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, "Brown, Len" <len.brown@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: VIA PCI routing problem
Content-Type: multipart/mixed;
 boundary="------------090103020300040301070105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090103020300040301070105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Sorry in taking so long to track this down. I just got motivated
today.

I have a VIA SMP system and somewhere between 2.6.12-rc3 and 2.6.12
the USB mouse started moving around really slowly. Anyway, it turns
out that the attached patch (against 2.6.13-rc3-git8) fixes the problem.

Let me know if any info is needed or if you would like me to test a
patch.

This is a regression versus 2.6.11 so it would be good to have a fix in
2.6.13.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


--------------090103020300040301070105
Content-Type: text/plain;
 name="via-irq-revert.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-irq-revert.patch"

Index: linux-2.6/arch/i386/pci/irq.c
===================================================================
--- linux-2.6.orig/arch/i386/pci/irq.c	2005-07-28 19:03:48.000000000 +1000
+++ linux-2.6/arch/i386/pci/irq.c	2005-07-28 21:58:52.000000000 +1000
@@ -1132,6 +1132,7 @@ static int pirq_enable_irq(struct pci_de
 		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
 		       'A' + pin, pci_name(dev), msg);
 	}
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq & 15);
 	return 0;
 }
 
Index: linux-2.6/drivers/pci/quirks.c
===================================================================
--- linux-2.6.orig/drivers/pci/quirks.c	2005-07-28 21:41:56.000000000 +1000
+++ linux-2.6/drivers/pci/quirks.c	2005-07-28 21:59:35.000000000 +1000
@@ -499,6 +499,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
  */
 static void quirk_via_irq(struct pci_dev *dev)
 {
+#if 0
 	u8 irq, new_irq;
 
 	new_irq = dev->irq & 0xf;
@@ -509,6 +510,7 @@ static void quirk_via_irq(struct pci_dev
 		udelay(15);	/* unknown if delay really needed */
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
+#endif
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
 
Index: linux-2.6/drivers/acpi/pci_irq.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_irq.c	2005-07-28 19:04:00.000000000 +1000
+++ linux-2.6/drivers/acpi/pci_irq.c	2005-07-28 21:58:14.000000000 +1000
@@ -444,6 +444,8 @@ acpi_pci_irq_enable (
 		}
  	}
 
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq & 15);
+
 	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
 
 	printk(KERN_INFO PREFIX "PCI Interrupt %s[%c] -> ",

--------------090103020300040301070105--
Send instant messages to your online friends http://au.messenger.yahoo.com 
