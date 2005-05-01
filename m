Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVEATJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVEATJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 15:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbVEATJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 15:09:24 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:46239 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262647AbVEATJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 15:09:11 -0400
Message-ID: <42752954.5050600@jp.fujitsu.com>
Date: Mon, 02 May 2005 04:09:08 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
References: <20050421111346.GA21421@elf.ucw.cz> <20050429061825.36f98cc0.akpm@osdl.org>
In-Reply-To: <20050429061825.36f98cc0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> 
>>
>>Without this patch, Linux provokes emergency disk shutdowns and
>>similar nastiness. It was in SuSE kernels for some time, IIRC.
>>
> 
> 
> With this patch when running `halt -p' my ia64 Tiger (using
> tiger_defconfig) gets a stream of badnesses in iosapic_unregister_intr()
> and then hangs up.
> 
> Unfortunately it all seems to happen after the serial port has been
> disabled because nothing comes out.  I set the console to a squitty font
> and took a piccy.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02505.jpg
> 
> I guess it's an ia64 problem.  I'll leave the patch in -mm for now.
> 

I guess the stream of badness was occured as follows:

    pcibios_disable_device() for ia64 assumes that pci_enable_device()
    and pci_disable_device() are balanced. But with 'properly stop
    devices before power off' patch, pci_disable_device() becomes to be
    called twice for e1000 device at halt time, through reboot_notifier_list
    callback and through device_suspend(). As a result, iosapic_unregister_intr()
    was called for already unregistered gsi and then stream of badness
    was displayed.

I think the following patch will remove this stream of badness. I'm
sorry but I have not checked if the stream of badness is actually
removed because I'm on vacation and I can't look at my display
(I'm working via remote console). Could you try this patch?

By the way, I don't think this stream of badness is related to hang up,
because the problem (hang up) was reproduced even on my test kernel that
doesn't call pcibios_disable_device().

Thanks,
Kenji Kaneshige
---


There might be some cases that pci_disable_device() is called even if
the device is already disabled. In this case, pcibios_disable_device()
should not call acpi_pci_irq_disable() for the device.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.12-rc3-mm2-kanesige/arch/ia64/pci/pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/ia64/pci/pci.c~fix_pcibios_disable_device_ia64 arch/ia64/pci/pci.c
--- linux-2.6.12-rc3-mm2/arch/ia64/pci/pci.c~fix_pcibios_disable_device_ia64	2005-05-02 03:12:23.000000000 +0900
+++ linux-2.6.12-rc3-mm2-kanesige/arch/ia64/pci/pci.c	2005-05-02 03:12:23.000000000 +0900
@@ -512,7 +512,8 @@ pcibios_enable_device (struct pci_dev *d
 void
 pcibios_disable_device (struct pci_dev *dev)
 {
-	acpi_pci_irq_disable(dev);
+	if (dev->is_enabled)
+		acpi_pci_irq_disable(dev);
 }
 #endif /* CONFIG_ACPI_DEALLOCATE_IRQ */
 

_
