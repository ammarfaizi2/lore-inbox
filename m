Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUFCTSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUFCTSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 15:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUFCTSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 15:18:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:50911 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264228AbUFCTSf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 15:18:35 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org, andreamrl@tiscali.it
Subject: Re: PROBLEM:kernel BUG at mm/page_alloc.c:786!
Date: Thu, 3 Jun 2004 21:18:30 +0200
User-Agent: KMail/1.6.2
References: <200406032001.34172.andreamrl@tiscali.it>
In-Reply-To: <200406032001.34172.andreamrl@tiscali.it>
Cc: ipw2100-admin@linux.intel.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406032118.32794.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andreamrl@tiscali.it wrote:
> I had a kernel bug. I report it following the guidelines at
> There was written "kernel BUG" in the oops  (so suppose not bug in the
> driver). The driver insmodded but didn't worked. I couldn't rmmod it. So

Its very likely a driver bug triggering this message. I added the Intel 
contact address to CC.

> kernel BUG at mm/page_alloc.c:786!
> invalid operand: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c013b11e>]    Tainted: P
> EFLAGS: 00210246   (2.6.6)
> EIP is at __free_pages+0x3e/0x50
> eax: 00000000   ebx: 00001000   ecx: c1011b80   edx: 00000000
> esi: 008dc000   edi: c08dc000   ebp: c3547220   esp: c14cde30
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 1600, threadinfo=c14cc000 task=ccb0b7b0)
> Stack: 00000800 c08db000 d0f3bef6 cf4a3c44 00001000 c08dc000 008dc000
> c3547220 cf4a3c00 c3547220 d0f3cbe9 c3547220 c354763c c3547220 c3547220
> cf4a3c00 c3547000 d0f3dfbb c3547220 fffffff4 d0f3fc97 c3547220 c3547000
> c3547220 Call Trace:
>  [<d0f3bef6>] bd_queue_free+0xa6/0xe0 [ipw2100]
>  [<d0f3cbe9>] ipw2100_rx_free+0x29/0x120 [ipw2100]
>  [<d0f3dfbb>] ipw2100_queues_allocate+0x2b/0x60 [ipw2100]
>  [<d0f3fc97>] ipw2100_pci_init_one+0x367/0x5a0 [ipw2100]
>  [<c0187f0e>] sysfs_new_inode+0x5e/0xb0
>  [<c021c202>] pci_device_probe_static+0x52/0x70
>  [<c021c25c>] __pci_device_probe+0x3c/0x50
>  [<c021c29c>] pci_device_probe+0x2c/0x50
>  [<c0278cef>] bus_match+0x3f/0x70
>  [<c0278e1c>] driver_attach+0x5c/0x90
>  [<c02790cd>] bus_add_driver+0x8d/0xa0
>  [<c027951f>] driver_register+0x2f/0x40
>  [<c021c48c>] pci_register_driver+0x5c/0x90
>  [<d0f3b98d>] ipw2100_proc_init+0xad/0x150 [ipw2100]
>  [<d0ec2065>] ipw2100_init+0x65/0x92 [ipw2100]
>  [<c01326cc>] sys_init_module+0x12c/0x250
>  [<c01051fb>] syscall_call+0x7/0xb

This function looks bogus: If ipw2100_tx_allocate fails, ipw2100_rx_free is 
called. Unfortunately the ipw2100_rx_allocate function was never called. 

int ipw2100_queues_allocate(struct ipw2100_priv *priv)
{
        int err;
        err = ipw2100_tx_allocate(priv);
        if (err)
                goto fail;

        err = ipw2100_rx_allocate(priv);
        if (err)
                goto fail;

        err = ipw2100_msg_allocate(priv);
        if (err)
                goto fail;

        return 0;

 fail:
        ipw2100_rx_free(priv);
        ipw2100_msg_free(priv);
        return -ENOMEM;
}

