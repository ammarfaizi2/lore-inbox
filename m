Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWAZPZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWAZPZM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 10:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWAZPZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 10:25:11 -0500
Received: from ns1.coraid.com ([65.14.39.133]:35734 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932363AbWAZPZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 10:25:08 -0500
Date: Thu, 26 Jan 2006 09:51:58 -0500
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.15-git9a] aoe [1/1]: do not stop retransmit timer when device goes down
Message-ID: <20060126145158.GB23696@coraid.com>
References: <200601260104.37649.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601260104.37649.a1426z@gawab.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 01:04:37AM +0300, Al Boldi wrote:
> Ed L. Cashin wrote:
> > This patch is a bugfix that follows and depends on the
> > eight aoe driver patches sent January 19th.
> 
> Will they also fix this?
> Or is this an md bug?

No, this patch fixes a bug that would cause an AoE device to be
totally unusable, so I think mdadm or mkraid would get an error that
the device was not available before it tried to make a new md device.

> It only happens with aoe.

It looks like in setting up the raid, sysfs_create_link probably has
this going off:

	BUG_ON(!kobj || !kobj->dentry || !name);

> Also, why is aoe slower than nbd?

It wasn't when I tried it.  The userland vblade is slow.  Maybe that's
affecting your results?

> md: bind<etherd/e0.0>
> ------------[ cut here ]------------
> kernel BUG at fs/sysfs/symlink.c:87!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0188166>]    Not tainted VLI
> EFLAGS: 00210246   (2.6.15) 
> EIP is at sysfs_create_link+0x56/0x60
> eax: c66de390   ebx: 00000000   ecx: c03db91f   edx: c7ee0040
> esi: c211bdf8   edi: c7ca0400   ebp: c66de360   esp: c211bdb4
> ds: 007b   es: 007b   ss: 0068
> Process mkraid (pid: 701, threadinfo=c211b000 task=c2300600)
> Stack: c7ca0424 c66de390 c211bdf8 c66de390 c02e5997 c66de390 c6b1b5ec 
> c03db91f 
>        00200296 c0207d56 c66de3a8 c66de360 c02e650f c66de390 09800000 
> 5c4725a7 
>        98831dc4 65687465 652f6472 00302e30 3feed8a3 891a1652 7f3dc64e 
> ab9a9a72 
> Call Trace:
>  [<c02e5997>] bind_rdev_to_array+0x157/0x1a0
>  [<c0207d56>] kobject_init+0x16/0x50
>  [<c02e650f>] md_import_device+0xbf/0x1c0
>  [<c02e80ad>] add_new_disk+0x22d/0x390
>  [<c024403f>] get_random_bytes+0x2f/0x40
>  [<c020be9e>] copy_from_user+0x4e/0x90
>  [<c02e8ef8>] md_ioctl+0x2e8/0x710
>  [<c01fdb46>] blkdev_driver_ioctl+0x56/0x70
>  [<c01fdbf3>] blkdev_ioctl+0x93/0x1a0
>  [<c015a83b>] block_ioctl+0x2b/0x30
>  [<c01641ce>] do_ioctl+0x6e/0x80
>  [<c016435a>] vfs_ioctl+0x6a/0x1e0
>  [<c0164515>] sys_ioctl+0x45/0x70
>  [<c0103009>] syscall_call+0x7/0xb
> Code: 4c 24 04 8b 44 24 18 89 1c 24 89 44 24 08 e8 f2 fe ff ff 8b 53 08 89 c1 
> ff 42 70 0f 8e 0b 02 00 00 8b 5c 24 0c 89 c8 83 c4 10 c3 <0f> 0b 57 00 5e a6 
> 3d c0 eb be 8b 44 24 04 8b 40 30 89 44 24 04 
>  

-- 
  Ed L Cashin <ecashin@coraid.com>
