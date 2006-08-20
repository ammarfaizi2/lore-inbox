Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWHTWjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWHTWjq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWHTWjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:39:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751380AbWHTWjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:39:45 -0400
Date: Sun, 20 Aug 2006 15:36:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: Re: 2.6.18-rc4-mm2
Message-Id: <20060820153616.74e698df.akpm@osdl.org>
In-Reply-To: <200608202327.44932.m.kozlowski@tuxland.pl>
References: <20060819220008.843d2f64.akpm@osdl.org>
	<200608202327.44932.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006 23:27:44 +0200
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 	I get this on my laptop when doing reboot or shutdown. Config is attached.
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------
> cardmgr/4736 is trying to acquire lock:
> (pcmcia_socket_list_rwsem){----}, at: [<de86de50>] adjust_memory+0x92/0xe6 
> [rsrc_nonstatic]
> 
> but task is already holding lock:
> (pcmcia_socket_list_rwsem){----}, at: [<de8653bf>] 
> pcmcia_adjust_resource_info+0x1c/0xfe [pcmcia_core]
> 
> other info that might help us debug this:
> 2 locks held by cardmgr/4736:
> #0:  (pcmcia_socket_list_rwsem){----}, at: [<de8653bf>] 
> pcmcia_adjust_resource_info+0x1c/0xfe [pcmcia_core]
> #1:  (rsrc_mutex){--..}, at: [<c03d7e67>] mutex_lock+0x1c/0x1f
>  
> stack backtrace:
> [<c010366e>] show_trace_log_lvl+0x16b/0x17e
> [<c0103693>] show_trace+0x12/0x16
> [<c0103792>] dump_stack+0x19/0x1d
> [<c012d0e0>] print_deadlock_bug+0xbe/0xc3
> [<c012d141>] check_deadlock+0x5c/0x6c
> [<c012e87e>] __lock_acquire+0x31d/0x92c
> [<c012f550>] lock_acquire+0x6f/0x8c
> [<c012b8a8>] down_read+0x3c/0x4d
> [<de86de50>] adjust_memory+0x92/0xe6 [rsrc_nonstatic]
> [<de86dfb3>] nonstatic_adjust_resource_info+0x55/0x57 [rsrc_nonstatic]
> [<de86546b>] pcmcia_adjust_resource_info+0xc8/0xfe [pcmcia_core]
> [<ded427a2>] ds_ioctl+0x33e/0x5ec [pcmcia]
> [<c0173748>] do_ioctl+0x5c/0x79
> [<c01738c8>] vfs_ioctl+0x55/0x196
> [<c0173a42>] sys_ioctl+0x39/0x5b
> [<c010300f>] syscall_call+0x7/0xb
> [<b7f2c584>] 0xb7f2c584
> [<c0103693>] show_trace+0x12/0x16
> [<c0103792>] dump_stack+0x19/0x1d
> [<c012d0e0>] print_deadlock_bug+0xbe/0xc3
> [<c012d141>] check_deadlock+0x5c/0x6c
> [<c012e87e>] __lock_acquire+0x31d/0x92c
> [<c012f550>] lock_acquire+0x6f/0x8c
> [<c012b8a8>] down_read+0x3c/0x4d
> [<de86de50>] adjust_memory+0x92/0xe6 [rsrc_nonstatic]
> [<de86dfb3>] nonstatic_adjust_resource_info+0x55/0x57 [rsrc_nonstatic]
> [<de86546b>] pcmcia_adjust_resource_info+0xc8/0xfe [pcmcia_core]
> [<ded427a2>] ds_ioctl+0x33e/0x5ec [pcmcia]
> [<c0173748>] do_ioctl+0x5c/0x79
> [<c01738c8>] vfs_ioctl+0x55/0x196
> [<c0173a42>] sys_ioctl+0x39/0x5b
> [<c010300f>] syscall_call+0x7/0xb

yup, thanks.  recursive down_read() is deadlockable - an intervening
down_write() from another task wil cause everything to jam up.
