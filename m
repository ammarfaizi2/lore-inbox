Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422743AbWBOLLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422743AbWBOLLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 06:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422747AbWBOLLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 06:11:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422743AbWBOLLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 06:11:18 -0500
Date: Wed, 15 Feb 2006 03:10:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Ian E. Morgan" <imorgan@webcon.ca>
Cc: linux-kernel@vger.kernel.org, rhardy@webcon.ca
Subject: Re: Process D-stated in generic_unplug_device
Message-Id: <20060215031015.718103b1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602141413450.13866@light.int.webcon.net>
References: <Pine.LNX.4.64.0602141413450.13866@light.int.webcon.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ian E. Morgan" <imorgan@webcon.ca> wrote:
>
> After a recent kernel upgrade (essentially 2.6.15.4 + a selection of other
> patches from -git and -mm), we've had problems with proftpd getting stuck in
> D-state when being shut down. There is no hot-pluging involved here (so I'm
> confused about the call to generic_unplug_device).
> 
> # /cat/proc/6012/wchan
> sync_page
> 
> A task dump shows:
> 
> Feb 14 13:45:12 guru kernel: proftpd       D 00000005     0  6012      1 29519        9328 (NOTLB)
> Feb 14 13:45:12 guru kernel: da507c50 dd83b520 c03db380 00000005 c152a580 dfc74284 c15a8fc c01e84c2 
> Feb 14 13:45:12 guru kernel:        c15af8fc da506000 c01e84f4 c15af8fc 00004a32 9ae11a4 0000cd50 dd83b520 
> Feb 14 13:45:12 guru kernel:        dd83b648 da507ca8 da507cb0 c1400e20 da507c58 c03041b 00000000 c013bd28 
> Feb 14 13:45:12 guru kernel: Call Trace:
> Feb 14 13:45:12 guru kernel:  [<c01e84c2>] __generic_unplug_device+0x1a/0x30
> Feb 14 13:45:13 guru kernel:  [<c01e84f4>] generic_unplug_device+0x1c/0x36
> Feb 14 13:45:13 guru kernel:  [<c030419b>] io_schedule+0xe/0x16
> Feb 14 13:45:13 guru kernel:  [<c013bd28>] sync_page+0x3e/0x4b
> Feb 14 13:45:13 guru kernel:  [<c0304450>] __wait_on_bit_lock+0x41/0x61
> Feb 14 13:45:13 guru kernel:  [<c013bcea>] sync_page+0x0/0x4b
> Feb 14 13:45:13 guru kernel:  [<c013c530>] __lock_page+0x91/0x99
> Feb 14 13:45:13 guru kernel:  [<c012ee49>] wake_bit_function+0x0/0x34
> Feb 14 13:45:13 guru kernel:  [<c012ee49>] wake_bit_function+0x0/0x34
> Feb 14 13:45:13 guru kernel:  [<c013d765>] filemap_nopage+0x29a/0x377
> Feb 14 13:45:13 guru kernel:  [<c014c467>] do_no_page+0x65/0x243
> Feb 14 13:45:13 guru kernel:  [<c014c8ee>] __handle_mm_fault+0x229/0x24d
> Feb 14 13:45:13 guru kernel:  [<c01128ee>] do_page_fault+0x1c2/0x5a5
> Feb 14 13:45:13 guru kernel:  [<c01f8d1e>] __copy_from_user_ll+0x40/0x6c
> Feb 14 13:45:13 guru kernel:  [<c010371c>] apic_timer_interrupt+0x1c/0x24
> Feb 14 13:45:13 guru kernel:  [<c011272c>] do_page_fault+0x0/0x5a5
> Feb 14 13:45:13 guru kernel:  [<c01037e7>] error_code+0x4f/0x54
> Feb 14 13:45:13 guru kernel:  [<c01a83bb>] reiserfs_copy_from_user_to_file_region+0x4d/xd8
> Feb 14 13:45:13 guru kernel:  [<c01a975e>] reiserfs_file_write+0x419/0x6ac
> Feb 14 13:45:13 guru kernel:  [<c01d0efa>] inode_has_perm+0x49/0x6b
> Feb 14 13:45:13 guru kernel:  [<c01f595a>] prio_tree_insert+0xf3/0x187
> Feb 14 13:45:13 guru kernel:  [<c01d3131>] selinux_file_permission+0x113/0x159
> Feb 14 13:45:13 guru kernel:  [<c015abbb>] vfs_write+0xcc/0x18f
> Feb 14 13:45:13 guru kernel:  [<c015ad3d>] sys_write+0x4b/0x74
> Feb 14 13:45:13 guru kernel:  [<c0102cb5>] syscall_call+0x7/0xb
> 
> Obviously this process is non-killable and requires a reboot to get us back
> into working order.
> 

I assume that we're seeing some stack gunk there and it's really stuck in
sync_page()->io_schedule().

This is almost certainly caused by a block layer or (more likely) device
driver bug: we submitted a read I/O, we're waiting for the completion
interrupt and it never came.

Please test vanilla 2.6.16-rc3 and let us know what block device driver is
involved, which I/O scheduler, etc.

Also, try mounting the filesystems with `-o barrier=none'.  That barrier
code seems to have been a source of many problems.
