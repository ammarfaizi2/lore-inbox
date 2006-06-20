Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWFTLk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWFTLk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWFTLk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:40:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932605AbWFTLk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:40:27 -0400
Date: Tue, 20 Jun 2006 04:40:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johny <kernel@agotnes.com>
Cc: kernel@agotnes.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       Chris Wedgwood <cw@f00f.org>
Subject: Re: [Fwd: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB
 issues]
Message-Id: <20060620044003.4287426d.akpm@osdl.org>
In-Reply-To: <4497DA3F.80302@agotnes.com>
References: <44953B4B.9040108@agotnes.com>
	<4497DA3F.80302@agotnes.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 21:21:35 +1000
Johny <kernel@agotnes.com> wrote:

> Firstly, apologies for a) the massive x-post and b) the time taken to 
> get back to people... Please let me know where this is most 
> appropriately dealt with and I'll keep it off other lists, considering 
> the latest information;
> 
> Andrew - please note - this is not a problem exclusive to the -mm 
> series, on testing various combos I found it in the stock series too.

Thanks for persisting with this.

> Stock kernels break for me starting with 2.6.17-rc4 (I tested all rcs 
> and also .17 itself), rc3 works a treat for using USB. I suspect the 
> following line missing in dmesg for rc4 is the reason;
> 
> -PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 11

yes, that looks suspicious.

> See the following dmesg files for details;
> 
> http://www.agotnes.com/kernelStuff/dmesg-2.6.17-rc3-working
> http://www.agotnes.com/kernelStuff/dmesg-2.6.17-rc4-not-working
> 
> And the diff, for convenience;
> 
> http://www.agotnes.com/kernelStuff/diff-rc3_rc4
> 
> I have a Via chipset motherboard (for my sins), further details 
> available on request, again, for convenience, the lspci;
> 
> http://www.agotnes.com/kernelStuff/lspci
> 
> A couple of possible suspect patches introduced in the changelog for rc4 
> were (with the first one looking particularly interesting, the others 
> less interesting as I go down the list);
> 
> [PATCH] PCI quirk: VIA IRQ fixup should only run for VIA southbridges

This one, I'd expect.

> [PATCH] x86_64: avoid IRQ0 ioapic pin collision
> [PATCH] PCI: fix via irq SATA patch
> [ALSA] via82xx - Use DXS_SRC as default for VIA8235/8237/8251 chips
> [ALSA] via82xx: tweak VT8251 workaround
> [ALSA] via82xx: add support for VIA VT8251 (AC'97)
> 

You could try a `patch -R' of the below.

commit 75cf7456dd87335f574dcd53c4ae616a2ad71a11
Author: Chris Wedgwood <cw@f00f.org>
Date:   Tue Apr 18 23:57:09 2006 -0700

    [PATCH] PCI quirk: VIA IRQ fixup should only run for VIA southbridges
    
    Alan Cox pointed out that the VIA 'IRQ fixup' was erroneously running
    on my system which has no VIA southbridge (but I do have a VIA IEEE
    1394 device).
    
    This should address that.  I also changed "Via IRQ" to "VIA IRQ"
    (initially I read Via as a capitalized via (by way/means of).
    
    Signed-off-by: Chris Wedgwood <cw@f00f.org>
    Acked-by: Jeff Garzik <jeff@garzik.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c42ae2c..19e2b17 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -642,13 +642,15 @@ static void quirk_via_irq(struct pci_dev
 	new_irq = dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
-		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
+		printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\n",
 			pci_name(dev), irq, new_irq);
 		udelay(15);	/* unknown if delay really needed */
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes


If you have trouble getting it to apply, just manually replace all the
DECLARE_PCI_FIXUP_ENABLE lines at the end of quirk_via_irq() with the
single line

DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);

