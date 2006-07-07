Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWGGJZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWGGJZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWGGJZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:25:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750906AbWGGJZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:25:07 -0400
Date: Fri, 7 Jul 2006 02:24:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.17-mm6: strange kobject message
Message-Id: <20060707022420.6f58b58c.akpm@osdl.org>
In-Reply-To: <20060707125942.fe3d467b.pauldrynoff@gmail.com>
References: <20060707125942.fe3d467b.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 12:59:42 +0400
Paul Drynoff <pauldrynoff@gmail.com> wrote:

> Here is dmesg which I got during boot,
> the first part not interesting I already reported about it,
> and I don't remember one of two things: Arjan van de Ven's patch was
> lost or not good enough. The second part is related to kobject,
> I'm not sure is it normal when kobject tell about -EEXIST and print stack?
> Note that this is happened only once per 100 normal booting, I mean the second part.
> 
> =================================
> [ INFO: inconsistent lock state ]
> ---------------------------------
> inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
> dhclient/1952 [HC1[1]:SC0[1]:HE0:SE0] takes:
>  (&ei_local->page_lock){+...}, at: [<c039d78d>] ei_interrupt+0x39/0x32c
> {hardirq-on-W} state was registered at:
>   [<c0133f5b>] lock_acquire+0x57/0x74
>   [<c05b15c2>] _spin_lock+0x1a/0x28
>   [<c039d558>] ei_start_xmit+0x74/0x270
>   [<c053ecc9>] dev_hard_start_xmit+0x1a9/0x1f8
>   [<c05499be>] __qdisc_run+0xb6/0x1a8
>   [<c05403fd>] dev_queue_xmit+0x115/0x23c
>   [<c059e441>] packet_sendmsg_spkt+0x195/0x1d0
>   [<c05348cb>] sock_sendmsg+0xcf/0xf0
>   [<c0534c8a>] sys_sendto+0xb6/0xf0
>   [<c0535e07>] sys_socketcall+0x11f/0x194
>   [<c010336f>] syscall_call+0x7/0xb
> irq event stamp: 8667
> hardirqs last  enabled at (8666): [<c05b18b1>] _spin_unlock_irqrestore+0x3d/0x48
> hardirqs last disabled at (8667): [<c0103553>] common_interrupt+0x1b/0x2c
> softirqs last  enabled at (8632): [<c011f23b>] __do_softirq+0x97/0xa8
> softirqs last disabled at (8660): [<c0540323>] dev_queue_xmit+0x3b/0x23c
> 
> other info that might help us debug this:
> 1 lock held by dhclient/1952:
>  #0:  (&dev->_xmit_lock){-+..}, at: [<c054993f>] __qdisc_run+0x37/0x1a8
> 
> stack backtrace:
>  [<c0103b3e>] show_trace+0x16/0x1c
>  [<c010412a>] dump_stack+0x1a/0x20
>  [<c0132037>] print_usage_bug+0x1d7/0x1e4
>  [<c0132802>] mark_lock+0x432/0x548
>  [<c0133542>] __lock_acquire+0x53e/0xc68
>  [<c0133f5b>] lock_acquire+0x57/0x74
>  [<c05b15c2>] _spin_lock+0x1a/0x28
>  [<c039d78d>] ei_interrupt+0x39/0x32c
>  [<c013b150>] handle_IRQ_event+0x24/0x58
>  [<c013c4e4>] handle_level_irq+0x6c/0xd0
>  [<c0104ed1>] do_IRQ+0x55/0xa8
>  [<c010355d>] common_interrupt+0x25/0x2c
>  [<c013b957>] enable_irq+0x4b/0x9c
>  [<c039d5f3>] ei_start_xmit+0x10f/0x270
>  [<c053ecc9>] dev_hard_start_xmit+0x1a9/0x1f8
>  [<c05499be>] __qdisc_run+0xb6/0x1a8
>  [<c05403fd>] dev_queue_xmit+0x115/0x23c
>  [<c059e441>] packet_sendmsg_spkt+0x195/0x1d0
>  [<c05348cb>] sock_sendmsg+0xcf/0xf0
>  [<c0534c8a>] sys_sendto+0xb6/0xf0
>  [<c0535e07>] sys_socketcall+0x11f/0x194
>  [<c010336f>] syscall_call+0x7/0xb

hm. 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/broken-out/lockdep-annotate-8390c-disable_irq.patch
didn't work.


> kobject_add failed for vcs1 with -EEXIST, don't try to register things with the same name in the same directory.
>  [<c0103b3e>] show_trace+0x16/0x1c
>  [<c010412a>] dump_stack+0x1a/0x20
>  [<c02c9774>] kobject_add+0x114/0x1b4
>  [<c037455f>] class_device_add+0xb3/0x484
>  [<c0374943>] class_device_register+0x13/0x18
>  [<c03749d2>] class_device_create+0x8a/0xbc
>  [<c032d016>] vcs_make_devfs+0x26/0x54
>  [<c0332bd9>] con_open+0x61/0x88
>  [<c0327e7f>] tty_open+0x16f/0x348
>  [<c0164507>] chrdev_open+0x63/0x168
>  [<c015a634>] __dentry_open+0x8c/0x164
>  [<c015a790>] nameidata_to_filp+0x30/0x3c
>  [<c015a7d7>] do_filp_open+0x3b/0x44
>  [<c015a81b>] do_sys_open+0x3b/0xc4
>  [<c015a8cf>] sys_open+0x13/0x18
>  [<c010336f>] syscall_call+0x7/0xb
> kobject_add failed for vcsa1 with -EEXIST, don't try to register things with the same name in the same directory.

We've seen this reported a couple of times before.  It could be a race in
the tty layer where a newly-added vc has the same index as a going-away
one which still has its sysfs file.  Or it could be something else :(

Once someone comes up with a way to reproduce it, we'll fix it though.

