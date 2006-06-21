Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWFUKuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWFUKuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWFUKuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:50:23 -0400
Received: from munin.agotnes.com ([202.173.149.60]:61409 "EHLO
	mail.agotnes.com") by vger.kernel.org with ESMTP id S1751498AbWFUKuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:50:21 -0400
Message-ID: <4499245C.8040207@agotnes.com>
Date: Wed, 21 Jun 2006 20:50:04 +1000
From: Johny <kernel@agotnes.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Johny <kernel@agotnes.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       Chris Wedgwood <cw@f00f.org>, sergio@sergiomb.no-ip.org,
       vsu@altlinux.ru
Subject: Re: [Fwd: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues]
References: <44953B4B.9040108@agotnes.com>	<4497DA3F.80302@agotnes.com> <20060620044003.4287426d.akpm@osdl.org>
In-Reply-To: <20060620044003.4287426d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010105060508010309020303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010105060508010309020303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

Success :)

I've attached the patches used vs 2.6.17-rc4 (stock) and 2.6.17-rc6-mm2 
(as the VIA include lists were different). I simply made the change 
manually, based on your and others' inputs (it seemed the simpler option).

Both kernels now boot, and all USB devices are recognised correctly.

Sergio, you can find attached lspci -n output as requested, and indeed, 
I run in XT_PIC mode for interrupts.

I did NOT run the setpci command as requested by Sergey, let me know if 
that helps anyone considering the fix sorted this out.

Where to from here I'll leave with you guys, an entry in the quirks.c 
file certainly is warranted for my motherboard...

I'm happy to test further patches if required on this, for now I'm on 
rc6-mm2 with my attached patch to have both ACX111 networking and USB 
working good :)

Cheers!

:)Johny

Andrew Morton wrote:
> On Tue, 20 Jun 2006 21:21:35 +1000
> Johny <kernel@agotnes.com> wrote:
> 
>> Firstly, apologies for a) the massive x-post and b) the time taken to 
>> get back to people... Please let me know where this is most 
>> appropriately dealt with and I'll keep it off other lists, considering 
>> the latest information;
>>
>> Andrew - please note - this is not a problem exclusive to the -mm 
>> series, on testing various combos I found it in the stock series too.
> 
> Thanks for persisting with this.
> 
>> Stock kernels break for me starting with 2.6.17-rc4 (I tested all rcs 
>> and also .17 itself), rc3 works a treat for using USB. I suspect the 
>> following line missing in dmesg for rc4 is the reason;
>>
>> -PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 11
> 
> yes, that looks suspicious.
> 
>> See the following dmesg files for details;
>>
>> http://www.agotnes.com/kernelStuff/dmesg-2.6.17-rc3-working
>> http://www.agotnes.com/kernelStuff/dmesg-2.6.17-rc4-not-working
>>
>> And the diff, for convenience;
>>
>> http://www.agotnes.com/kernelStuff/diff-rc3_rc4
>>
>> I have a Via chipset motherboard (for my sins), further details 
>> available on request, again, for convenience, the lspci;
>>
>> http://www.agotnes.com/kernelStuff/lspci
>>
>> A couple of possible suspect patches introduced in the changelog for rc4 
>> were (with the first one looking particularly interesting, the others 
>> less interesting as I go down the list);
>>
>> [PATCH] PCI quirk: VIA IRQ fixup should only run for VIA southbridges
> 
> This one, I'd expect.
> 
>> [PATCH] x86_64: avoid IRQ0 ioapic pin collision
>> [PATCH] PCI: fix via irq SATA patch
>> [ALSA] via82xx - Use DXS_SRC as default for VIA8235/8237/8251 chips
>> [ALSA] via82xx: tweak VT8251 workaround
>> [ALSA] via82xx: add support for VIA VT8251 (AC'97)
>>
> 
> You could try a `patch -R' of the below.
> 
> commit 75cf7456dd87335f574dcd53c4ae616a2ad71a11
> Author: Chris Wedgwood <cw@f00f.org>
> Date:   Tue Apr 18 23:57:09 2006 -0700
> 
>     [PATCH] PCI quirk: VIA IRQ fixup should only run for VIA southbridges
>     
>     Alan Cox pointed out that the VIA 'IRQ fixup' was erroneously running
>     on my system which has no VIA southbridge (but I do have a VIA IEEE
>     1394 device).
>     
>     This should address that.  I also changed "Via IRQ" to "VIA IRQ"
>     (initially I read Via as a capitalized via (by way/means of).
>     
>     Signed-off-by: Chris Wedgwood <cw@f00f.org>
>     Acked-by: Jeff Garzik <jeff@garzik.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index c42ae2c..19e2b17 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -642,13 +642,15 @@ static void quirk_via_irq(struct pci_dev
>  	new_irq = dev->irq & 0xf;
>  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>  	if (new_irq != irq) {
> -		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
> +		printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\n",
>  			pci_name(dev), irq, new_irq);
>  		udelay(15);	/* unknown if delay really needed */
>  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>  	}
>  }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
>  
>  /*
>   * VIA VT82C598 has its device ID settable and many BIOSes
> 
> 
> If you have trouble getting it to apply, just manually replace all the
> DECLARE_PCI_FIXUP_ENABLE lines at the end of quirk_via_irq() with the
> single line
> 
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
> 

--------------010105060508010309020303
Content-Type: text/plain;
 name="via.patch-rc4stock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via.patch-rc4stock"

--- usb/drivers/pci/quirks.c	2006-06-21 20:18:56.000000000 +1000
+++ linux-2.6.17-rc4/drivers/pci/quirks.c	2006-06-21 20:13:15.000000000 +1000
@@ -648,9 +648,7 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes

--------------010105060508010309020303
Content-Type: text/plain;
 name="via.patch-rc6-mm2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via.patch-rc6-mm2"

--- usb/drivers/pci/quirks.c	2006-06-21 20:25:41.000000000 +1000
+++ linux-2.6.17-rc6-mm2/drivers/pci/quirks.c	2006-06-21 20:25:08.000000000 +1000
@@ -662,13 +662,7 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes

--------------010105060508010309020303
Content-Type: text/plain;
 name="lspci-n"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-n"

00:00.0 0600: 1106:3205
00:01.0 0604: 1106:b198
00:08.0 0280: 104c:9066
00:10.0 0c03: 1106:3038 (rev 80)
00:10.1 0c03: 1106:3038 (rev 80)
00:10.2 0c03: 1106:3038 (rev 80)
00:10.3 0c03: 1106:3104 (rev 82)
00:11.0 0601: 1106:3177
00:11.1 0101: 1106:0571 (rev 06)
00:11.5 0401: 1106:3059 (rev 50)
00:12.0 0200: 1106:3065 (rev 74)
01:00.0 0300: 1106:7205 (rev 01)

--------------010105060508010309020303--
