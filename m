Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSELWAF>; Sun, 12 May 2002 18:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSELWAE>; Sun, 12 May 2002 18:00:04 -0400
Received: from p0211.as-l042.contactel.cz ([194.108.237.211]:9600 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S315437AbSELWAD>;
	Sun, 12 May 2002 18:00:03 -0400
Date: Mon, 13 May 2002 00:00:08 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdc202xx.c fails to compile in 2.5.15
Message-ID: <20020512220008.GA2935@ppc.vc.cvut.cz>
In-Reply-To: <3CDD4DE5.5030200@evision-ventures.com> <877km99nt1.fsf_-_@atlas.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2002 at 09:19:22PM +0200, Zlatko Calusic wrote:
> pdc202xx.x fails to compile in 2.5.15. Error messages below.
> 
> pdc202xx.c:1453: unknown field `exnablebits' specified in initializer
> pdc202xx.c:1453: warning: braces around scalar initializer
> pdc202xx.c:1453: warning: (near initialization for `chipsets[3].init_dma')
> make[3]: *** [pdc202xx.o] Error 1

If you have PDC20265 like I have, you must also remove test on device class,
as 20265 reports itself as generic mass storage (class 0x0180) and not as
IDE (it is real IDE, not RAID, really). 

Because of there are apparently devices on which you must check device class
(2.5.14 talks about CY82C693 and IT8172G), I'll leave proper fix on Martin,
but simple fix below work fine on my Asus A7V.
							Petr Vandrovec
							vandrove@vc.cvut.cz

--- drivers/ide/ide-pci.c	Sun May 12 02:46:44 2002
+++ drivers/ide/ide-pci.c	Fri May 10 00:25:29 2002
@@ -701,7 +701,7 @@
 			hpt374_device_order_fixup(dev, d);
 	} else if (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20268R)
 		pdc20270_device_order_fixup(dev, d);
-	else if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+	else if (1 || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		printk(KERN_INFO "ATA: %s (%04x:%04x) on PCI slot %s\n",
 				dev->name, vendor, device, dev->slot_name);
 		setup_pci_device(dev, d);
