Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269409AbUIIK1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269409AbUIIK1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269411AbUIIK1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:27:19 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:65174 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269409AbUIIK1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:27:09 -0400
Date: Thu, 09 Sep 2004 19:29:09 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] missing pci_disable_device()
In-reply-to: <20040909062009.GD10428@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <41403075.1010103@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <413D0E4E.1000200@jp.fujitsu.com>
 <1094550581.9150.8.camel@localhost.localdomain>
 <413E7925.1010801@jp.fujitsu.com>
 <1094647195.11723.5.camel@localhost.localdomain>
 <413FF05B.8090505@jp.fujitsu.com> <20040909062009.GD10428@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>> I understand that there are some devices that need to be enabled
>> even after their drivers are unloaded, and my approach might not
>> be safe in this case. I think the best way to solve the problem
>> (missing pci_disable_device) is to fix broken drivers one by one.
>> I think debug printk will helpful to fix those drivers, but I
>> don't know what kind of message is appropriate...
> 
> Yes, this should be pointed out with a warning message, which will be
> safer.  How about something like:
> 
> 	dev_warn(&pci_dev->dev, "Device was removed without properly "
> 				"calling pci_disable_device(), please fix.\n");
> 	WARN_ON(1);
> 
> Care to redo your patch with that?

Thank you for your advice.

I changed my patch based on your feedback. But I have one
concern about putting "WARN_ON(1);". I'm worrying that people
might be surprised if stack dump is shown on their console,
especially if the broken driver handles many devices.

For example, following console messages were displayed when I
tested my patch by loading/unloading 'uhci_hcd' which handles
two devices on my machine. How do you think?

Thanks,
Kenji Kaneshige


uhci_hcd 0000:00:1d.0: USB bus 1 deregistered
uhci_hcd 0000:00:1d.0: Device was removed without properly calling pci_disable_device(), please fix.
Badness in pci_device_remove at drivers/pci/pci-driver.c:301

Call Trace:
 [<a000000100019e40>] show_stack+0x80/0xa0
                                sp=e0000002e0177c10 bsp=e0000002e01710c8
 [<a000000100398340>] pci_device_remove+0x140/0x1a0
                                sp=e0000002e0177de0 bsp=e0000002e01710a0
 [<a000000100448be0>] device_release_driver+0x120/0x140
                                sp=e0000002e0177de0 bsp=e0000002e0171078
 [<a000000100448c50>] driver_detach+0x50/0xa0
                                sp=e0000002e0177de0 bsp=e0000002e0171058
 [<a000000100449780>] bus_remove_driver+0xc0/0x180
                                sp=e0000002e0177de0 bsp=e0000002e0171038
 [<a00000010044a250>] driver_unregister+0x30/0xc0
                                sp=e0000002e0177de0 bsp=e0000002e0171020
 [<a000000100398920>] pci_unregister_driver+0x20/0x60
                                sp=e0000002e0177de0 bsp=e0000002e0171008
 [<a0000002000e18b0>] uhci_hcd_cleanup+0x30/0x130 [uhci_hcd]
                                sp=e0000002e0177de0 bsp=e0000002e0170fe8
 [<a0000001000d0a40>] sys_delete_module+0x440/0x4e0
                                sp=e0000002e0177de0 bsp=e0000002e0170f78
 [<a0000001000120a0>] ia64_ret_from_syscall+0x0/0x20
                                sp=e0000002e0177e30 bsp=e0000002e0170f78
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:1d.1: USB bus 2 deregistered
uhci_hcd 0000:00:1d.1: Device was removed without properly calling pci_disable_device(), please fix.
Badness in pci_device_remove at drivers/pci/pci-driver.c:301

Call Trace:
 [<a000000100019e40>] show_stack+0x80/0xa0
                                sp=e0000002e0177c10 bsp=e0000002e01710c8
 [<a000000100398340>] pci_device_remove+0x140/0x1a0
                                sp=e0000002e0177de0 bsp=e0000002e01710a0
 [<a000000100448be0>] device_release_driver+0x120/0x140
                                sp=e0000002e0177de0 bsp=e0000002e0171078
 [<a000000100448c50>] driver_detach+0x50/0xa0
                                sp=e0000002e0177de0 bsp=e0000002e0171058
 [<a000000100449780>] bus_remove_driver+0xc0/0x180
                                sp=e0000002e0177de0 bsp=e0000002e0171038
 [<a00000010044a250>] driver_unregister+0x30/0xc0
                                sp=e0000002e0177de0 bsp=e0000002e0171020
 [<a000000100398920>] pci_unregister_driver+0x20/0x60
                                sp=e0000002e0177de0 bsp=e0000002e0171008
 [<a0000002000e18b0>] uhci_hcd_cleanup+0x30/0x130 [uhci_hcd]
                                sp=e0000002e0177de0 bsp=e0000002e0170fe8
 [<a0000001000d0a40>] sys_delete_module+0x440/0x4e0
                                sp=e0000002e0177de0 bsp=e0000002e0170f78
 [<a0000001000120a0>] ia64_ret_from_syscall+0x0/0x20
                                sp=e0000002e0177e30 bsp=e0000002e0170f78





