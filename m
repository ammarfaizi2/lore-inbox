Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbUDAIee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbUDAIee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:34:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:35261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262796AbUDAIe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:34:29 -0500
Date: Thu, 1 Apr 2004 00:34:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: dmorris@metavize.com, jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.2] Badness in futex_wait revisited
Message-Id: <20040401003418.6485d6bf.akpm@osdl.org>
In-Reply-To: <1080785801.32535.116.camel@bach>
References: <40311703.8070309@metavize.com>
	<20040217051911.6AC112C066@lists.samba.org>
	<20040331165656.GG19280@mail.shareable.org>
	<406B0219.3000309@metavize.com>
	<20040331183243.GA20418@mail.shareable.org>
	<406B1522.9050204@metavize.com>
	<1080785801.32535.116.camel@bach>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>  On Thu, 2004-04-01 at 04:59, Dirk Morris wrote:
>  > Jamie Lokier wrote:
>  > 
>  > >If you have a small test program (or pair of programs) that
>  > >consistently triggers this message on any machine running 2.6.4, that
>  > >would be very helpful indeed.
>  > >  
>  > >
>  > Here ya go. :)

Dirk, thanks for that.  It's worth its weight.

> 
>  Doesn't work for me (2.6.5-rc1 Debian unstable 2xi686).

It works here.  You're probably using some steam-driven debian userspace.

There seem to be two call traces according to dmesg:

true 0 waking futex-prob: 1732 1732
Badness in task_rq_lock at kernel/sched.c:277
Call Trace:
 [<c011c678>] task_rq_lock+0x78/0xf4
 [<c011ccbd>] try_to_wake_up+0x1d/0x2c0
 [<c012d35b>] send_signal+0xdb/0x128
 [<c011cf80>] wake_up_state+0xc/0x10
 [<c012ea0d>] do_notify_parent+0x499/0x54c
 [<c0178454>] dput+0x1c/0x274
 [<c016226c>] __fput+0xfc/0x124
 [<c0160b6e>] filp_close+0x62/0x70
 [<c0125c1e>] exit_notify+0x61e/0x660
 [<c0126102>] do_exit+0x4a2/0x4b4
 [<c012625c>] sys_exit_group+0x0/0x14
 [<c012626c>] sys_exit_group+0x10/0x14
 [<c038d3f2>] sysenter_past_esp+0x43/0x65

sshd 0 waking futex-prob: 1732 1732
Badness in task_rq_lock at kernel/sched.c:277
Call Trace:
 [<c011c678>] task_rq_lock+0x78/0xf4
 [<c011ccbd>] try_to_wake_up+0x1d/0x2c0
 [<c014a86c>] kmem_cache_alloc+0x20/0x68
 [<c012d2be>] send_signal+0x3e/0x128
 [<c011cf80>] wake_up_state+0xc/0x10
 [<c012d97c>] group_send_sig_info+0x2cc/0x3f0
 [<c012dafe>] __kill_pg_info+0x5e/0x90
 [<c012db62>] kill_pg_info+0x32/0x5c
 [<c012df03>] kill_pg+0x1b/0x20
 [<c02536e0>] n_tty_receive_buf+0x530/0x11bc
 [<c0334a85>] release_sock+0x75/0x7f
 [<c0355fee>] tcp_recvmsg+0x656/0x694
 [<c0202141>] avc_has_perm+0x41/0x4d
 [<c02561f3>] pty_write+0x12b/0x198
 [<c02550dd>] write_chan+0x195/0x1f4
 [<c011f088>] default_wake_function+0x0/0x1c
 [<c011f088>] default_wake_function+0x0/0x1c
 [<c024f982>] tty_write+0x22a/0x2e4
 [<c0254f48>] write_chan+0x0/0x1f4
 [<c0161517>] vfs_write+0xb7/0xf0
 [<c01615d0>] sys_write+0x30/0x50
 [<c038d3f2>] sysenter_past_esp+0x43/0x65


But setting a breakpoint in task_rq_lock(), kgdb only ever seems to find
one:

Breakpoint 1, task_rq_lock (p=0xcf3a8330, flags=0xcf105e88) at kernel/sched.c:274
274                     printk("%s %i waking %s: %i %i\n",
(gdb) bt
#0  task_rq_lock (p=0xcf3a8330, flags=0xcf105e88) at kernel/sched.c:274
#1  0xc011ce7d in try_to_wake_up (p=0xcf3a8330, state=1, sync=0) at kernel/sched.c:792
#2  0xc011cf80 in wake_up_state (p=0xcf29d420, state=3473952768) at kernel/sched.c:849
#3  0xc012ea0d in do_notify_parent (tsk=0xcf29d420, sig=17) at kernel/signal.c:552
#4  0xc0125c1e in exit_notify (tsk=0xcf29d420) at kernel/exit.c:716
#5  0xc0126102 in do_exit (code=0) at kernel/exit.c:790
#6  0xc012625c in do_group_exit (exit_code=0) at kernel/exit.c:861
#7  0xc012626c in sys_exit_group (error_code=0) at kernel/exit.c:872
#8  0xc038d3f2 in sysenter_past_esp () at net/key/af_key.c:2834

Looks like breakage in the signal code.
