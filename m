Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVC1RRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVC1RRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVC1RRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:17:39 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:24594 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S261953AbVC1RRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:17:34 -0500
Message-ID: <42483C84.6000700@mrv.com>
Date: Mon, 28 Mar 2005 19:19:00 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] paport related OOPS since 2.6.11-bk7
References: <424834B7.5080805@mrv.com> <20050328175837.A2222@flint.arm.linux.org.uk>
In-Reply-To: <20050328175837.A2222@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Mar 28, 2005 at 06:45:43PM +0200, Eran Mann wrote:
> 
>>The OOPS below gets generated consistently when FC3 kudzu is run during 
>>boot (tested between 2.6.11-bk7 and 2.6.11.6-bk1). It seems to be caused 
>>by the hotplug-parport changeset:
>>http://linux.bkbits.net:8080/linux-2.5/cset@4230791b6YtcIhZDSvvWbzSdUpg2zg?nav=index.html|ChangeSet@-4w
>>(reverting this changeset eliminates the oops).
> 
> 
> Please try this instead.
> 
> It appears that the parport driver claims on-board superio devices
> without actually doing anything.  When the driver is removed, we
> try to dereference non-existent driver data to unregister the ports.
> Since we didn't register anything, it's safe to ignore these devices
> in the remove function.
> 
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
> 
> diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/parport/parport_pc.c linux/drivers/parport/parport_pc.c
> --- orig/drivers/parport/parport_pc.c	Sat Mar 19 11:22:08 2005
> +++ linux/drivers/parport/parport_pc.c	Mon Mar 28 17:55:51 2005
> @@ -2976,10 +2976,12 @@ static void __devexit parport_pc_pci_rem
>  
>  	pci_set_drvdata(dev, NULL);
>  
> -	for (i = data->num - 1; i >= 0; i--)
> -		parport_pc_unregister_port(data->ports[i]);
> +	if (data) {
> +		for (i = data->num - 1; i >= 0; i--)
> +			parport_pc_unregister_port(data->ports[i]);
>  
> -	kfree(data);
> +		kfree(data);
> +	}
>  }
>  
>  static struct pci_driver parport_pc_pci_driver = {
> 

Doesn't seem to help. Do you want me to check anything else?
Mar 28 17:13:44 eran kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
Mar 28 17:13:44 eran kernel: parport_pc: VIA parallel port: io=0x378, irq=7
Mar 28 17:13:44 eran kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Mar 28 17:13:44 eran kernel:  printing eip:
Mar 28 17:13:44 eran kernel: d3f37368
Mar 28 17:13:44 eran kernel: *pde = 00000000
Mar 28 17:13:44 eran kernel: Oops: 0000 [#1]
Mar 28 17:13:44 eran kernel: PREEMPT
Mar 28 17:13:44 eran kernel: Modules linked in: parport_pc parport 
binfmt_misc nls_cp437 nls_iso8859_1 ntfs video thermal processor fan 
container button battery ac uhci_hcd usbcore 3c59x mii
Mar 28 17:13:44 eran kernel: CPU:    0
Mar 28 17:13:44 eran kernel: EIP:    0060:[<d3f37368>]    Not tainted VLI
Mar 28 17:13:44 eran kernel: EFLAGS: 00010286   (2.6.11-bk6-patched)
Mar 28 17:13:44 eran kernel: EIP is at parport_pc_pci_remove+0x18/0x40 
[parport_pc]
Mar 28 17:13:44 eran kernel: eax: c12ef844   ebx: c12ef800   ecx: 
c12ef844   edx: d3f37350
Mar 28 17:13:44 eran kernel: esi: 00000000   edi: d3f3cd48   ebp: 
ce585ecc   esp: ce585ec0
Mar 28 17:13:44 eran kernel: ds: 007b   es: 007b   ss: 0068
Mar 28 17:13:44 eran kernel: Process modprobe (pid: 3503, 
threadinfo=ce585000 task=cffdf040)
Mar 28 17:13:44 eran kernel: Stack: c0190441 c12ef800 c12ef844 ce585edc 
c0237c06 c12ef800 c12ef868 ce585ef8
Mar 28 17:13:44 eran kernel:        c02f9c5c c12ef844 c03ff1cd d3f3cd90 
d3f3cd90 d3f375a0 ce585f0c c02f9c80
Mar 28 17:13:44 eran kernel:        c12ef844 d3f3cd48 00000000 ce585f24 
c02fa17a d3f3cd48 d3f3cd48 d3f3cd48
Mar 28 17:13:44 eran kernel: Call Trace:
Mar 28 17:13:44 eran kernel:  [<c0103ecf>] show_stack+0x7f/0xa0
Mar 28 17:13:44 eran kernel:  [<c0104066>] show_registers+0x156/0x1d0
Mar 28 17:13:44 eran kernel:  [<c010428a>] die+0xea/0x180
Mar 28 17:13:44 eran kernel:  [<c0114e22>] do_page_fault+0x482/0x6ba
Mar 28 17:13:44 eran kernel:  [<c0103b33>] error_code+0x2b/0x30
Mar 28 17:13:44 eran kernel:  [<c0237c06>] pci_device_remove+0x36/0x40
Mar 28 17:13:44 eran kernel:  [<c02f9c5c>] device_release_driver+0x7c/0x80
Mar 28 17:13:44 eran kernel:  [<c02f9c80>] driver_detach+0x20/0x30
Mar 28 17:13:44 eran kernel:  [<c02fa17a>] bus_remove_driver+0x4a/0x90
Mar 28 17:13:44 eran kernel:  [<c02fa742>] driver_unregister+0x12/0x20
Mar 28 17:13:44 eran kernel:  [<c0237e45>] pci_unregister_driver+0x15/0x20
Mar 28 17:13:44 eran kernel:  [<d3f3763e>] parport_pc_exit+0x9e/0xae 
[parport_pc]
Mar 28 17:13:44 eran kernel:  [<c01343fe>] sys_delete_module+0x17e/0x1b0
Mar 28 17:13:44 eran kernel:  [<c010304b>] sysenter_past_esp+0x54/0x75
Mar 28 17:13:44 eran kernel: Code: 44 24 04 89 0c 24 ff d2 eb 94 89 f6 
8d bc 27 00 00 00 00 55 89 e5 56 53 83 ec 04 8b 45 08 83 c0 44 8b 70 74 
c7 40 74 00 00 00 00 <8b> 1e eb 10 8d 74 26 00 8b 44 9e 04 89 04 24 e8 
d4 f4 ff ff 4b


-- 
Eran Mann
Senior Software Engineer
MRV International
Tel: 972-4-9936297
Fax: 972-4-9890430
www.mrv.com
