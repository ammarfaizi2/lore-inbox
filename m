Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTEVLl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 07:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTEVLl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 07:41:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60640 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261783AbTEVLlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 07:41:25 -0400
Date: Thu, 22 May 2003 17:27:02 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, page0588@sundance.sjsu.edu,
       greg@kroah.com, tytso@us.ibm.com
Subject: Re: kernel BUG at include/linux/dcache.h:271!
Message-ID: <20030522115702.GA1150@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200305211911.51467.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305211911.51467.ivg2@cornell.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 11:08:37PM +0000, Ivan Gyurdiev wrote:
> 1) Kernel is 2.5.69 bitkeeper as of May 21.
> The following occurs when removing the rd module from the kernel.
> I get a segmentation fault, and lsmod freezes. Kernel log says:
> 
> agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
> agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
> ACPI: No IRQ known for interrupt pin C of device 00:11.5
> PCI: Setting latency timer of device 00:11.5 to 64
> devfs_mk_dir(rd): could not append to dir: dffcd8c0 ""
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> ------------[ cut here ]------------
> kernel BUG at include/linux/dcache.h:271!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0186dec>]    Tainted: PF 
> EFLAGS: 00010246
> EIP is at sysfs_remove_dir+0x1c/0x152
> eax: 00000000   ebx: e09e18c4   ecx: c034eba0   edx: 00000000
> esi: d5acee40   edi: d58a8980   ebp: e09e1840   esp: d5a2bed8
> ds: 007b   es: 007b   ss: 0068
> Process rmmod (pid: 1302, threadinfo=d5a2a000 task=d5e30640)
> Stack: 00000000 00000000 dfdf4b40 00000000 e09e18c4 00000001 d58a8980 e09e1840 
>        c01e3a03 e09e18c4 c034eba0 e09e18c4 e09e18c4 c01e3a53 e09e18c4 d58a88c0 
>        c022b45d e09e18c4 d58a88c0 c022f3c3 d58a88c0 d58a88c0 d58a88c0 c01858f8 
> Call Trace:
>  [<e09e18c4>] rd_queue+0x44/0x148 [rd]
>  [<e09e1840>] rd_bdev+0x0/0x40 [rd]
>  [<c01e3a03>] kobject_del+0x43/0x80
>  [<e09e18c4>] rd_queue+0x44/0x148 [rd]
>  [<e09e18c4>] rd_queue+0x44/0x148 [rd]
>  [<e09e18c4>] rd_queue+0x44/0x148 [rd]
>  [<c01e3a53>] kobject_unregister+0x13/0x30
>  [<e09e18c4>] rd_queue+0x44/0x148 [rd]
>  [<c022b45d>] elv_unregister_queue+0x1d/0x40
>  [<e09e18c4>] rd_queue+0x44/0x148 [rd]
>  [<c022f3c3>] unlink_gendisk+0x13/0x40
>  [<c01858f8>] del_gendisk+0x58/0xe0

I think it is due to wrong representation of ramdisks in sysfs. Infact it is 
leaking dentries. The problem is that we have multiple ramdisks but all have
common request queue and common elevator. In terms of sysfs we 
have multiple kobjects for multiple ramdisks, but one single kobject for the 
ramdisks' common elevator. 

While initializing, different kobjects are allocated for the ramdisks but,
the common elevator uses the same kobject. In other words, every init
of a ramdisk, the common elevator.kobj->parent will be different and it will
allocate a new dentry, overwrite the elevator.kobj->dentry
and loose the earlier allocated dentries. (see: elv_register_queue())

While exiting, it ends up in removing the same dentry (allocated at the last)
again and BUGs in dget on dentry with zero ref count.

Not sure where it should be fixed 
ramdisk 
 - should have separate queues on for each ramdisk

elevator 
 - should not re-register already registered queue in elv_register_queue

sysfs 
 - should handle kobject with multiple parent kobjects 

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
