Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVKUQrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVKUQrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVKUQrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:47:05 -0500
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:17126 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751037AbVKUQrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:47:02 -0500
Date: Mon, 21 Nov 2005 10:46:48 -0600
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: Jens Axboe <axboe@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       hpa@zytor.com, sitniko@infonet.ee
Subject: Re: [PATCH 1/3] cciss: bug fix for hpacucli
Message-ID: <20051121164648.GA7714@beardog.cca.cpqcorp.net>
References: <20051118163357.GA10928@beardog.cca.cpqcorp.net> <20051118204946.GB25454@suse.de> <20051121082810.GV25454@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121082810.GV25454@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 09:28:10AM +0100, Jens Axboe wrote:
> On Fri, Nov 18 2005, Jens Axboe wrote:
> > On Fri, Nov 18 2005, mikem wrote:
> > > Patch 1 of 3
> > > 
> > > This patch fixes a bug that breaks hpacucli, a command line interface
> > > for the HP Array Config Utility. Without this fix the utility will
> > > not detect any controllers in the system. I thought I had already fixed
> > > this, but I guess not.
> > > 
> > > Thanks to all who reported the issue. Please consider this this inclusion.
> > 
> > Lovely, hope this makes it able to configure my drives on the tiger now
> > :).
> 
> This sort-of makes it work. I get some complaints about unaligned access
> when setting up a test array:
> 
> => controller slot=0 create type=logicaldrive drives=all raid=1 drivetype=sas
> .hpacucli(12458): unaligned access to 0x60000fffffcb370e, ip=0x40000000003c8550
> => controller slot=0 create type=logicaldrive drives=all raid=1 drivetype=sata
> .hpacucli(12458): unaligned access to 0x60000fffffcb4aee, ip=0x40000000003c8550
> .hpacucli(12458): unaligned access to 0x60000fffffcb370e, ip=0x40000000003c8550
> .hpacucli(12458): unaligned access to 0x60000fffffcb370e, ip=0x40000000003c8550

This seems to be coming out of user space. We'll work with the application
folks to investigate. There is a library called infomanager that's used
by the app. There may be an issue there. Call you strace the program and
send me the results? I haven't seen this in my lab with a vendor kernel.

> 
> Invoking hpacucli again later on makes it trigger a kobj warning:
> 
> Badness in kref_get at lib/kref.c:32

Hmmm, is this with my put_disk patch installed?

mikem

> 
> Call Trace:
>  [<a000000100013560>] show_stack+0x80/0xa0
>                                 sp=e0000001f5547b20 bsp=e0000001f5541250
>  [<a000000100013e30>] dump_stack+0x30/0x60
>                                 sp=e0000001f5547cf0 bsp=e0000001f5541238
>  [<a00000010034fec0>] kref_get+0xa0/0xc0
>                                 sp=e0000001f5547cf0 bsp=e0000001f5541218
>  [<a00000010034e470>] kobject_get+0x30/0x60
>                                 sp=e0000001f5547cf0 bsp=e0000001f55411f0
>  [<a00000010034eb80>] kobject_add+0x20/0x380
>                                 sp=e0000001f5547cf0 bsp=e0000001f55411b8
>  [<a0000001001b7ff0>] register_disk+0x70/0x200
>                                 sp=e0000001f5547cf0 bsp=e0000001f5541188
>  [<a0000001003385d0>] add_disk+0x90/0xc0
>                                 sp=e0000001f5547cf0 bsp=e0000001f5541168
>  [<a000000202e1aa40>] rebuild_lun_table+0xaa0/0xb20 [cciss]
>                                 sp=e0000001f5547cf0 bsp=e0000001f55410a8
>  [<a000000202e1bbc0>] cciss_ioctl+0xa20/0x3be0 [cciss]
>                                 sp=e0000001f5547d00 bsp=e0000001f5540fc0
>  [<a0000001003346b0>] blkdev_driver_ioctl+0xd0/0x160
>                                 sp=e0000001f5547e10 bsp=e0000001f5540f78
>  [<a000000100335050>] blkdev_ioctl+0x170/0xb40
>                                 sp=e0000001f5547e10 bsp=e0000001f5540f20
>  [<a000000100147cc0>] block_ioctl+0x40/0x60
>                                 sp=e0000001f5547e10 bsp=e0000001f5540ef0
>  [<a000000100160740>] do_ioctl+0x160/0x1a0
>                                 sp=e0000001f5547e10 bsp=e0000001f5540eb0
>  [<a000000100160880>] vfs_ioctl+0x100/0x8e0
>                                 sp=e0000001f5547e10 bsp=e0000001f5540e68
>  [<a0000001001610c0>] sys_ioctl+0x60/0xc0
>                                 sp=e0000001f5547e20 bsp=e0000001f5540de8
>  [<a00000010000bc80>] ia64_ret_from_syscall+0x0/0x20
>                                 sp=e0000001f5547e30 bsp=e0000001f5540de8
>  [<a000000000010640>] __kernel_syscall_via_break+0x0/0x20
>                                 sp=e0000001f5548000 bsp=e0000001f5540de8
> 
> -- 
> Jens Axboe
> 
