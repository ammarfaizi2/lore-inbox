Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTFUXCN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 19:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTFUXCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 19:02:13 -0400
Received: from dm4-159.slc.aros.net ([66.219.220.159]:31114 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S263743AbTFUXCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 19:02:09 -0400
Message-ID: <3EF4E73A.4070108@aros.net>
Date: Sat, 21 Jun 2003 17:16:10 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Pavel Machek <pavel@ucw.cz>, Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [PATCH] nbd driver for 2.5+: fix for module removal & new block
 device layer
References: <3EF4D2C8.6060608@aros.net> <20030621225500.GL6754@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030621225500.GL6754@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Sat, Jun 21, 2003 at 03:48:56PM -0600, Lou Langholtz wrote:
>  
>
>>This patch prevents memory corruption from "rmmod nbd" with the existing 
>>2.5.72 (and earlier) nbd driver. It does this by updating the nbd driver 
>>to the new block layer requirement that every disk has its own 
>>request_queue structure. This is the first of a series of patchlets 
>>designed to break down the essential changes I proposed in my last 
>>"enormous" patch. Note that another patchlet will make the whole 
>>allocation of per nbd_device memory be dynamic (rather than staticly 
>>tied to MAX_NBD). Please try out this patch and let me know how nbd is 
>>working for you before versus after. With any luck, some of these 
>>smaller patch breakdowns can actually see there way into new kernel 
>>releases. Thanks.
>>    
>>
>	a) you don't have to have queue per device.  It often does make
>sense (for nbd it's almost certainly a win), but it's not required.
>
Unfortunately the way the sysfs code is implemented for struct gendisk 
it is actually the case that every gendisk has to have its own 
request_queue or else dcache.c BUG's and memory gets corrupted when you 
put and release this disks:

Jun 21 12:59:07 cyprus kernel: nbd: registered device at major 43
Jun 21 12:59:25 cyprus kernel: ------------[ cut here ]------------
Jun 21 12:59:25 cyprus kernel: kernel BUG at include/linux/dcache.h:273!
Jun 21 12:59:25 cyprus kernel: invalid operand: 0000 [#1]
Jun 21 12:59:25 cyprus kernel: CPU:    0
Jun 21 12:59:25 cyprus kernel: EIP:    0060:[<c017849d>]    Tainted: GF
Jun 21 12:59:25 cyprus kernel: EFLAGS: 00210246
Jun 21 12:59:25 cyprus kernel: EIP is at sysfs_remove_dir+0x1d/0x13f
Jun 21 12:59:25 cyprus kernel: eax: 00000000   ebx: e0947ac4   ecx: 
c026b6e0   edx: 00000000
Jun 21 12:59:25 cyprus kernel: esi: 00000078   edi: db10b900   ebp: 
d1f2fee0   esp: d1f2fec8
Jun 21 12:59:25 cyprus kernel: ds: 007b   es: 007b   ss: 0068
Jun 21 12:59:25 cyprus kernel: Process rmmod (pid: 3794, 
threadinfo=d1f2e000 task=cf2bb300)
Jun 21 12:59:25 cyprus kernel: Stack: d4a45d00 dfda21c0 dfda21e8 
e0947ac4 00000078 d0c10344 d1f2fef8 c0205873
Jun 21 12:59:25 cyprus kernel:        e0947ac4 c0450280 e0947ac4 
e0947ac4 d1f2ff08 c02058b4 e0947ac4 d0c10280
Jun 21 12:59:25 cyprus kernel:        d1f2ff18 c02673ee e0947ac4 
d0c10280 d1f2ff2c c026b224 d0c10280 d0c10280
Jun 21 12:59:25 cyprus kernel: Call Trace:
Jun 21 12:59:25 cyprus kernel:  [<e0947ac4>] nbd_queue+0x44/0x180 [nbd]
Jun 21 12:59:25 cyprus kernel:  [<c0205873>] kobject_del+0x43/0x70
Jun 21 12:59:25 cyprus kernel:  [<e0947ac4>] nbd_queue+0x44/0x180 [nbd]
Jun 21 12:59:25 cyprus last message repeated 2 times
Jun 21 12:59:25 cyprus kernel:  [<c02058b4>] kobject_unregister+0x14/0x20
Jun 21 12:59:25 cyprus kernel:  [<e0947ac4>] nbd_queue+0x44/0x180 [nbd]
Jun 21 12:59:25 cyprus kernel:  [<c02673ee>] elv_unregister_queue+0x1e/0x40
Jun 21 12:59:25 cyprus kernel:  [<e0947ac4>] nbd_queue+0x44/0x180 [nbd]
Jun 21 12:59:25 cyprus kernel:  [<c026b224>] unlink_gendisk+0x14/0x40
Jun 21 12:59:25 cyprus kernel:  [<c0177301>] del_gendisk+0x61/0xe0
Jun 21 12:59:25 cyprus kernel:  [<e0945a5c>] nbd_dev+0x1dc/0x2200 [nbd]
Jun 21 12:59:25 cyprus kernel:  [<e0944c5d>] +0x1d/0x60 [nbd]
Jun 21 12:59:25 cyprus kernel:  [<e0947c00>] +0x0/0x140 [nbd]
Jun 21 12:59:25 cyprus kernel:  [<c012ce9e>] sys_delete_module+0x12e/0x170
Jun 21 12:59:25 cyprus kernel:  [<e0947c00>] +0x0/0x140 [nbd]
Jun 21 12:59:25 cyprus kernel:  [<c013e5c7>] sys_munmap+0x57/0x80
Jun 21 12:59:25 cyprus kernel:  [<c010ac4d>] sysenter_past_esp+0x52/0x71
Jun 21 12:59:25 cyprus kernel:
Jun 21 12:59:25 cyprus kernel: Code: 0f 0b 11 01 3b fa 3a c0 ff 07 85 ff 
0f 84 08 01 00 00 8b 47

>	b) you definitely don't have to use separate queue locks.  The
>thing will work fine with spinlock being shared and I doubt that there
>will be any noticable extra contention.
>
Probably not noticeable no.

>	c) please, make allocation of queue dynamic _and_ separate from
>any other allocated objects.
>  
>
Will do!

