Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268463AbUJDT0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268463AbUJDT0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUJDTYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:24:45 -0400
Received: from port-222-152-48-85.fastadsl.net.nz ([222.152.48.85]:7296 "EHLO
	tornado.reub.net") by vger.kernel.org with ESMTP id S268463AbUJDTQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:16:13 -0400
Message-ID: <4161A17E.7000103@reub.net>
Date: Tue, 05 Oct 2004 08:16:14 +1300
From: Reuben Farrelly <reuben-news@reub.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Hanno Meyer-Thurow <h.mth@web.de>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (as387)] UHCI: check return code from pci_register_driver
References: <Pine.LNX.4.44L0.0410041125290.1358-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0410041125290.1358-100000@ida.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Stern wrote:
> Greg:
> 
> This is all your fault!  :-)
> 
> The patch below fixes the problem in which the UHCI driver doesn't
> properly check the return code from pci_register_driver().
> 
> Alan Stern
> 
> 
> On Fri, 1 Oct 2004, Andrew Morton wrote:
> 
> 
>>Greg's latest tree, on x86_64:
>>
>>Badness in remove_proc_entry at fs/proc/generic.c:688
>>
>>Call Trace:<ffffffff8019cfb6>{remove_proc_entry+391} <ffffffff805a981f>{uhci_hcd_init+224} 
>>       <ffffffff8010c26d>{init+475} <ffffffff8010ff17>{child_rip+8} 
>>       <ffffffff8010c092>{init+0} <ffffffff8010ff0f>{child_rip+0} 
>>
>>
>>                WARN_ON(de->subdir);
>>
>>which is a bit weird.  How did driver/uhci get itself a subdirectory?
>>
>>Maybe it already existed, and uhci_hcd_init() tried to delete it anwyay?
> 
> 
> On Sat, 2 Oct 2004, Reuben Farrelly wrote:
> 
> 
>>slab error in kmem_cache_destroy(): cache `uhci_urb_priv': Can't free
>>all objects
>>  [<c0104ddc>] dump_stack+0x17/0x19
>>  [<c013dfd5>] kmem_cache_destroy+0xea/0x15b
>>  [<c03e17eb>] uhci_hcd_init+0xc8/0xff
>>  [<c03ca89f>] do_initcalls+0x56/0xb3 
>>  [<c01004f5>] init+0x81/0x189
>>  [<c01022f1>] kernel_thread_helper+0x5/0xb
>>drivers/usb/host/uhci-hcd.c: not all urb_priv's were freed!
>>Badness in remove_proc_entry at fs/proc/generic.c:688
>>  [<c0104ddc>] dump_stack+0x17/0x19
>>  [<c017c196>] remove_proc_entry+0x129/0x133
>>  [<c03e1810>] uhci_hcd_init+0xed/0xff
>>  [<c03ca89f>] do_initcalls+0x56/0xb3 
>>  [<c01004f5>] init+0x81/0x189
>>  [<c01022f1>] kernel_thread_helper+0x5/0xb
> 
> 
> 
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ===== drivers/usb/host/uhci-hcd.c 1.134 vs edited =====
> --- 1.134/drivers/usb/host/uhci-hcd.c	2004-09-30 13:58:40 -04:00
> +++ edited/drivers/usb/host/uhci-hcd.c	2004-10-04 10:37:21 -04:00
> @@ -2412,7 +2412,7 @@
>  		goto up_failed;
>  
>  	retval = pci_register_driver(&uhci_pci_driver);
> -	if (retval)
> +	if (retval < 0)
>  		goto init_failed;
>  
>  	return 0;

Confirming fix, this solves the trace that I have been seeing upon bootup.

Reuben
