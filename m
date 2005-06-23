Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVFWSBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVFWSBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVFWSBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:01:47 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:45768 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262642AbVFWSAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:00:52 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Roberto Oppedisano <roppedisano.oppedisano@gmail.com>
Subject: Re: 2.6.12 breaks 8139cp
Date: Thu, 23 Jun 2005 12:00:43 -0600
User-Agent: KMail/1.8.1
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
References: <42B9D21F.7040908@drzeus.cx> <42BAEEB3.6080309@gmail.com>
In-Reply-To: <42BAEEB3.6080309@gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LjvuCWXxuPn16ol"
Message-Id: <200506231200.43671.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_LjvuCWXxuPn16ol
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 23 June 2005 11:17 am, Roberto Oppedisano wrote:
> I'm seeing the same problem with 8139cp (everithing seems fine, mii-tool
> works, but only seldom packets are received from the device). Last good
> kernel for me was 2.6.11-bk4. I tried pci=routeirq on 2.6.12, but made
> no difference. Here's lscpi output (on 2.6.11-bk4).

> 0000:02:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
> 0000:02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 20)

You have a VIA device with dev/function == 0, so 2.6.11 will do the
VIA IRQ fixup for all devices.  2.6.12 will do it only for VIA
devices.  Can you try the attached patch for debugging purposes?

--Boundary-00=_LjvuCWXxuPn16ol
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="via-irq"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via-irq"

Index: work/drivers/pci/quirks.c
===================================================================
--- work.orig/drivers/pci/quirks.c	2005-06-21 13:43:29.000000000 -0600
+++ work/drivers/pci/quirks.c	2005-06-23 10:40:55.000000000 -0600
@@ -510,7 +510,7 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * PIIX3 USB: We have to disable USB interrupts that are

--Boundary-00=_LjvuCWXxuPn16ol--
