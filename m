Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946010AbWBOQde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946010AbWBOQde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946012AbWBOQde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:33:34 -0500
Received: from guru.webcon.ca ([216.194.67.26]:3799 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S1946010AbWBOQdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:33:33 -0500
Date: Wed, 15 Feb 2006 11:33:25 -0500 (EST)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, rhardy@webcon.ca
Subject: Re: Process D-stated in generic_unplug_device
In-Reply-To: <20060215031015.718103b1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602151104490.22996@light.int.webcon.net>
References: <Pine.LNX.4.64.0602141413450.13866@light.int.webcon.net>
 <20060215031015.718103b1.akpm@osdl.org>
Organization: Webcon, Inc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Assp-Spam-Prob: 0.00000
X-Assp-Whitelisted: Yes
X-Assp-Envelope-From: imorgan@webcon.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006, Andrew Morton wrote:

> "Ian E. Morgan" <imorgan@webcon.ca> wrote:
> >
> > After a recent kernel upgrade (essentially 2.6.15.4 + a selection of other
> > patches from -git and -mm), we've had problems with proftpd getting stuck in
> > D-state when being shut down. There is no hot-pluging involved here (so I'm
> > confused about the call to generic_unplug_device).
> > 
> > # /cat/proc/6012/wchan
> > sync_page
> > 
> > A task dump shows:
> > 
> > Feb 14 13:45:12 guru kernel: proftpd       D 00000005     0  6012      1 29519        9328 (NOTLB)
> > Feb 14 13:45:12 guru kernel: da507c50 dd83b520 c03db380 00000005 c152a580 dfc74284 c15a8fc c01e84c2 
> > Feb 14 13:45:12 guru kernel:        c15af8fc da506000 c01e84f4 c15af8fc 00004a32 9ae11a4 0000cd50 dd83b520 
> > Feb 14 13:45:12 guru kernel:        dd83b648 da507ca8 da507cb0 c1400e20 da507c58 c03041b 00000000 c013bd28 
> > Feb 14 13:45:12 guru kernel: Call Trace:
> > Feb 14 13:45:12 guru kernel:  [<c01e84c2>] __generic_unplug_device+0x1a/0x30
> > Feb 14 13:45:13 guru kernel:  [<c01e84f4>] generic_unplug_device+0x1c/0x36
> > Feb 14 13:45:13 guru kernel:  [<c030419b>] io_schedule+0xe/0x16
> > Feb 14 13:45:13 guru kernel:  [<c013bd28>] sync_page+0x3e/0x4b
> > Feb 14 13:45:13 guru kernel:  [<c0304450>] __wait_on_bit_lock+0x41/0x61
> > Feb 14 13:45:13 guru kernel:  [<c013bcea>] sync_page+0x0/0x4b
> > Feb 14 13:45:13 guru kernel:  [<c013c530>] __lock_page+0x91/0x99
> > Feb 14 13:45:13 guru kernel:  [<c012ee49>] wake_bit_function+0x0/0x34
> > Feb 14 13:45:13 guru kernel:  [<c012ee49>] wake_bit_function+0x0/0x34
> > Feb 14 13:45:13 guru kernel:  [<c013d765>] filemap_nopage+0x29a/0x377
> > Feb 14 13:45:13 guru kernel:  [<c014c467>] do_no_page+0x65/0x243
> > Feb 14 13:45:13 guru kernel:  [<c014c8ee>] __handle_mm_fault+0x229/0x24d
> > Feb 14 13:45:13 guru kernel:  [<c01128ee>] do_page_fault+0x1c2/0x5a5
> > Feb 14 13:45:13 guru kernel:  [<c01f8d1e>] __copy_from_user_ll+0x40/0x6c
> > Feb 14 13:45:13 guru kernel:  [<c010371c>] apic_timer_interrupt+0x1c/0x24
> > Feb 14 13:45:13 guru kernel:  [<c011272c>] do_page_fault+0x0/0x5a5
> > Feb 14 13:45:13 guru kernel:  [<c01037e7>] error_code+0x4f/0x54
> > Feb 14 13:45:13 guru kernel:  [<c01a83bb>] reiserfs_copy_from_user_to_file_region+0x4d/xd8
> > Feb 14 13:45:13 guru kernel:  [<c01a975e>] reiserfs_file_write+0x419/0x6ac
> > Feb 14 13:45:13 guru kernel:  [<c01d0efa>] inode_has_perm+0x49/0x6b
> > Feb 14 13:45:13 guru kernel:  [<c01f595a>] prio_tree_insert+0xf3/0x187
> > Feb 14 13:45:13 guru kernel:  [<c01d3131>] selinux_file_permission+0x113/0x159
> > Feb 14 13:45:13 guru kernel:  [<c015abbb>] vfs_write+0xcc/0x18f
> > Feb 14 13:45:13 guru kernel:  [<c015ad3d>] sys_write+0x4b/0x74
> > Feb 14 13:45:13 guru kernel:  [<c0102cb5>] syscall_call+0x7/0xb
> > 
> > Obviously this process is non-killable and requires a reboot to get us back
> > into working order.
> > 
> 
> I assume that we're seeing some stack gunk there and it's really stuck in
> sync_page()->io_schedule().
> 
> This is almost certainly caused by a block layer or (more likely) device
> driver bug: we submitted a read I/O, we're waiting for the completion
> interrupt and it never came.
> 
> Please test vanilla 2.6.16-rc3 and let us know what block device driver is
> involved, which I/O scheduler, etc.
> 
> Also, try mounting the filesystems with `-o barrier=none'.  That barrier
> code seems to have been a source of many problems.

OK, I've attempted to replicate the problem on lab hardware with a variety
of kernels spanning 2.6.15 to 2.6.16-rc3, and can't. The only fundemental
element of the production server that I can't duplicate in the lab right now
is the production server's 3Ware RAID controller (8500-4). Given you
suspect a device driver problem, that could very well be the culprit, but
there were no changes to the 3ware driver between our previous working
kernel (2.6.15.2+patches) and this one that exhibited the problem
(2.6.15.4+patches). Shrug.

The failures were the straw that finally broke us and got us to make the
inevitable switch to vsftpd, and thankfully it doesn't seem to trigger the
problem the way proftpd did, so we're (mostly) happy with that for now.

Given that we can't replicate the problem on our lab hardware, and we don't
want to put our production server through any more pain than it already has
of late, and we've managed a workaround that seems to at least avoid the
problem, we're going to have to let this one lie for now.

Anyways, the device driver at the time of failure was 3w-xxxx (stock
2.6.15.4), and the I/O scheduler was CFQ.

Thanks for your insight.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
    *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------
