Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUCaUHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 15:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUCaUHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 15:07:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:16260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262416AbUCaUG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 15:06:56 -0500
Date: Wed, 31 Mar 2004 12:06:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2
Message-Id: <20040331120634.39c959fd.akpm@osdl.org>
In-Reply-To: <200403311102.58136.jbarnes@sgi.com>
References: <20040317201454.5b2e8a3c.akpm@osdl.org>
	<20040330113620.33d01d9c.akpm@osdl.org>
	<200403301144.26050.jbarnes@sgi.com>
	<200403311102.58136.jbarnes@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@sgi.com> wrote:
>
> On Tuesday 30 March 2004 11:44 am, Jesse Barnes wrote:
> > It looks like there's a bug in the sysrq implementation in the sn_serial
> > driver.  Once the initial console is opened, sysrq no longer works.  All
> > I've determined so far is that both CPUs in my box are in cpu_idle
> > somewhere... Anyway, I'll keep looking.
> 
> Ah, now sysrq is working (just had to configure it correctly).

great.

>  I've seen two
> backtraces in the hangs I've seen.  The one I just reproduced looks like this:
> 
> Enabling local filesystem quotas:  [  OK  ]
> Enabling swap space:  [  OK  ]
> INIT: Entering runlevel: 3
> Entering non-interactive startup
> Starting sysstat:  [  OK  ]
> Setting network parameters:  ^[SYSSysRq : Show State
> [ bunch of kernel daemon traces ]
> ...
> S10network    S a0000001000d8cf0     0  1143   1104  1156               (NOTLB)
> 
> Call Trace:
>  [<a0000001000c4200>] schedule+0xda0/0x1360
>                                 sp=e00000387a27fdc0 bsp=e00000387a2791b8
>  [<a0000001000d8cf0>] sys_wait4+0x450/0x660
>                                 sp=e00000387a27fdd0 bsp=e00000387a2790f0
>  [<a000000100011a60>] ia64_ret_from_syscall+0x0/0x20
>                                 sp=e00000387a27fe30 bsp=e00000387a2790b8
> initlog       S a0000001000e8650     0  1156   1143  1157               (NOTLB)
> 
> Call Trace:
>  [<a0000001000c4200>] schedule+0xda0/0x1360
>                                 sp=e00000387af47ce0 bsp=e00000387af411a0
>  [<a0000001000e8650>] schedule_timeout+0x190/0x1a0
>                                 sp=e00000387af47cf0 bsp=e00000387af41168
>  [<a00000010072eb70>] unix_wait_for_peer+0x210/0x220
>                                 sp=e00000387af47d30 bsp=e00000387af41130
>  [<a00000010072ee30>] unix_stream_connect+0x2b0/0xd00
>                                 sp=e00000387af47d90 bsp=e00000387af41098
>  [<a0000001006285f0>] sys_connect+0xf0/0x140
>                                 sp=e00000387af47da0 bsp=e00000387af41020
>  [<a000000100011a60>] ia64_ret_from_syscall+0x0/0x20
>                                 sp=e00000387af47e30 bsp=e00000387af41020
> sysctl        Z a0000001000d7330     0  1157   1156                     (L-TLB)
> 
> Call Trace:
>  [<a0000001000c4200>] schedule+0xda0/0x1360
>                                 sp=e00000347a5a7e20 bsp=e00000347a5a1078
>  [<a0000001000d7330>] do_exit+0x490/0x500
>                                 sp=e00000347a5a7e30 bsp=e00000347a5a1018
>  [<a0000001000d77b0>] do_group_exit+0x290/0x360
>                                 sp=e00000347a5a7e30 bsp=e00000347a5a0fe0
>  [<a000000100011a60>] ia64_ret_from_syscall+0x0/0x20
>                                 sp=e00000347a5a7e30 bsp=e00000347a5a0fc8
> 
> and the CPU is in cpu_idle (somewhere, either default_idle or somewhere
> along that call path).  The other failure was also a hang, and it looked
> like an infinite number of page faults was being generated, something
> like
> 
> ...
>  [<a0000001001233c0>] __free_pages+0x60/0x140
>                                 sp=e0000030148ebb80 bsp=e0000030148e5388
>  [<a00000010012b670>] slab_destroy+0x2f0/0x3e0
>                                 sp=e0000030148ebb80 bsp=e0000030148e5338
>  [<a000000100130120>] reap_timer_fnc+0x480/0x680
>                                 sp=e0000030148ebb80 bsp=e0000030148e5268
>  [<a0000001000e7ee0>] run_timer_softirq+0x380/0x5c0
>                                 sp=e0000030148ebb90 bsp=e0000030148e51e0
>  [<a0000001000dbd10>] __do_softirq+0x1d0/0x1e0
>                                 sp=e0000030148ebbb0 bsp=e0000030148e5160
>  [<a0000001000dbda0>] do_softirq+0x80/0xe0
>                                 sp=e0000030148ebbb0 bsp=e0000030148e5100
>  [<a000000100018300>] ia64_handle_irq+0x180/0x1c0
>                                 sp=e0000030148ebbb0 bsp=e0000030148e50c0
>  [<a000000100011c00>] ia64_leave_kernel+0x0/0x280
>                                 sp=e0000030148ebbb0 bsp=e0000030148e50c0
>  [<a000000100019d20>] default_idle+0xe0/0x180
> 

So are we to assume that this is the offending process?  That the periodic
slab reaping code has screwed up?
