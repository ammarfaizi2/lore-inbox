Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbUALBwl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 20:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUALBwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 20:52:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58537 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265843AbUALBwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 20:52:39 -0500
Date: Mon, 12 Jan 2004 01:52:38 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: blkdev_get() oopses on floppy
Message-ID: <20040112015238.GH30321@parcelfarce.linux.theplanet.co.uk>
References: <1073861431.5014.85.camel@bip.parateam.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073861431.5014.85.camel@bip.parateam.prv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 11:50:32PM +0100, Xavier Bestel wrote:
> Hi guys,
> 
> I writing a piece of code which piggybacks on a block_device (a bit like
> dm/md). This particular piece of test code:
>         err = blkdev_get(bdev, FMODE_READ, 0, BDEV_RAW);
>         if(err)
>         {
>                 printk(KERN_ERR "blkdev_get: error %d\n", -err);
>                 goto no_get;
>         }
>         printk(KERN_INFO "using device %s\n", dev->bd_disk->disk_name);
>         blkdev_put(bdev, BDEV_RAW);
> no_get:
>         bdput(bdev);

That's wrong - faling blkdev_get() will do bdput() itself.

*NOTE*:  unless you are really forced to, don't use that "open by device
number" crap at all - normal filp_open() will do nicely if you have the
pathname of device in question and it's _much_ better interface.
 
> raw /dev/raw/raw1 /dev/fd0
> cat /dev/raw/raw1 >/dev/null
> 
> and got this oops:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000040
>  printing eip:
> d08a285a
> *pde = 00000000
> Oops: 0000 [#4]
> CPU:    0
> EIP:    0060:[<d08a285a>]    Not tainted
> EFLAGS: 00000296
> EIP is at floppy_open+0x1a/0x410 [floppy]
> eax: 00000000   ebx: d08a2840   ecx: d08a9044   edx: d08a9584
> esi: cfc9aac0   edi: cba1be6c   ebp: cfff108c   esp: cba1bd5c
> ds: 007b   es: 007b   ss: 0068
> Process cat (pid: 16749, threadinfo=cba1a000 task=cc29f3a0)
> Stack: c01fb800 00000000 cba1a000 00000001 cfff1040 cc2d9540 d08a2840 cfc9aac0
>        cfff1040 d08a99c0 c015e964 cfff108c cba1be6c cffff8c8 c11d9b60 cba1a000
>        00000246 cfff104c c0395420 00000000 cfff1040 00000001 cba1be6c cc2d9540
> Call Trace:
>  [<c01fb800>] exact_match+0x0/0x10
>  [<d08a2840>] floppy_open+0x0/0x410 [floppy]
>  [<c015e964>] do_open+0x134/0x410
>  [<c015ecbe>] blkdev_get+0x7e/0xa0
>  [<d08c9087>] raw_open+0x87/0x150 [raw]
>  [<c015f932>] chrdev_open+0xf2/0x220
>  [<c0165516>] open_namei+0xa6/0x400
>  [<c0155630>] dentry_open+0x150/0x210
>  [<c01554d8>] filp_open+0x68/0x70
>  [<c015597b>] sys_open+0x5b/0x90
>  [<c010b3d9>] sysenter_past_esp+0x52/0x71
>  
> Code: 8b 40 40 8b 70 28 b8 f0 ff ff ff 89 44 24 10 c7 47 74 00 00

Lovely...  Which kernel is that?
