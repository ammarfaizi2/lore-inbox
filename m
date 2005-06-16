Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVFPT5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVFPT5s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 15:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVFPT5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 15:57:47 -0400
Received: from magic.adaptec.com ([216.52.22.17]:5801 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261798AbVFPT5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 15:57:42 -0400
Message-ID: <42B1D9AE.5000002@adaptec.com>
Date: Thu, 16 Jun 2005 15:57:34 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops calling sysfs_create_link() from pci_probe()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jun 2005 19:57:02.0775 (UTC) FILETIME=[906ABC70:01C572AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm calling

sysfs_create_link(&class->kobj,
		  &pcidev->driver->driver.kobj, "driver");

To create a link from a syfs directory of an object which I've
created with class_device_regsiter(), to point to the
driver directory of the pci driver.
This is effectively called at the bottom of the pci_driver->probe
function.

But I get this oops:
 printing eip:
c0229e7b
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: aic94xx sas_class
CPU:    0
EIP:    0060:[<c0229e7b>]    Not tainted VLI
EFLAGS: 00010296   (2.6.12-rc6) 
EIP is at kref_get+0xb/0x50
eax: 00000060   ebx: 00000060   ecx: 00000000   edx: 0000002c
esi: e09342cb   edi: df02a997   ebp: fffffff4   esp: d5a81e0c
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 3166, threadinfo=d5a80000 task=df6bc540)
Stack: c014653b dfff5080 000000d0 df02a98c 00000048 c02293aa 00000060 d35257ac 
       c0195d77 00000048 000000d0 c022948e decdc040 c0229460 d335d4b0 c2a0b530 
       00000000 decdc020 decdc014 c0195e0f c2a0b530 e09342c4 00000048 e0935180 
Call Trace:
 [<c014653b>] __kmalloc+0x9b/0xd0
 [<c02293aa>] kobject_get+0x1a/0x30
 [<c0195d77>] sysfs_add_link+0x77/0xd0
 [<c022948e>] kobject_put+0x1e/0x30
 [<c0229460>] kobject_release+0x0/0x10
 [<c0195e0f>] sysfs_create_link+0x3f/0x70
 [<e093419e>] sas_register_ha+0x10e/0x160 [sas_class]
 [<e0a6cf67>] asd_pci_probe+0x6b7/0x760 [aic94xx]
 [<c0235a62>] pci_device_probe_static+0x52/0x70
 [<c0235abc>] __pci_device_probe+0x3c/0x50
 [<c0235afc>] pci_device_probe+0x2c/0x50
 [<c026d40f>] driver_probe_device+0x2f/0x80
 [<c026d55c>] driver_attach+0x5c/0x90
 [<c026da8e>] bus_add_driver+0x9e/0xd0
 [<c0235dbd>] pci_register_driver+0x7d/0xa0
 [<e0814044>] aic94xx_init+0x44/0x58 [aic94xx]
 [<c01389a3>] sys_init_module+0x223/0x250
 [<c0102fb5>] syscall_call+0x7/0xb
Code: 92 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 8b 44 24 04 c7 00 01 00 00 00 c3 90 8d 74 26 00 83 ec 14 89 5c 24 10 8b 5c 24 18 <8b> 03 85 c0 74 0b f0 ff 03 8b 5c 24 10 83 c4 14 c3 c7 04 24 fa 
 

Which suggests that I cannot call this from inside pci_probe(),
but will have to "wait" to call it after pci_regsiter_driver()
returns, effectively after pci_populate_driver_dir() returns.

Is this correct assumption? Or can I call the syslink call
above in other ways?

Thanks,
	Luben
