Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTL2NBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 08:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTL2NBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 08:01:07 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:17568 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S263364AbTL2NA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 08:00:59 -0500
Date: Mon, 29 Dec 2003 14:00:56 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: linux-lvm@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: System hangs after echo value > /sys/block/dm-0/queue/nr_requests
Message-ID: <20031229130055.GA30647@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you echo a value (any value; for example the default 128) to
/sys/block/dm-0/queue/nr_requests the shell you are in hangs.
After about 5 seconds, the whole system hangs 100%.

The system responds to interrupts (ping / sysrq) but that's it.
For the rest it's dead in the water.

This is with Linux 2.6.0 and the deadline IO scheduler.

There is no oops or panic. With sysrq I managed to get a backtrace
of the process doing the echo:

bash          R 00000001    16   657      1                 656 (NOTLB)
f6d45e60 00000082 c2432c80 00000001 00000003 00000000 c03ba4a0 00000000
       00000000 00000000 00000000 00000000 00000000 f738b680 f738b714 c01484d4
       f738b714 00000000 00000000 00000000 00000000 f738b680 00001000 00000000
Call Trace:
 [<c01484d4>] vmtruncate+0x79/0x112
 [<c016f0b2>] inode_setattr+0x106/0x17d
 [<c016f29b>] notify_change+0x119/0x16a
 [<c013b0a5>] unlock_page+0x15/0x57
 [<c01482c2>] do_wp_page+0x2c7/0x2f2
 [<c013ee4b>] buffered_rmqueue+0xc4/0x143
 [<c013ef71>] __alloc_pages+0xa7/0x317
 [<c01ff557>] queue_var_store+0x23/0x31
 [<c01ff690>] queue_requests_store+0x11b/0x17d
 [<c01ff751>] queue_attr_store+0x32/0x36
 [<c0185a3a>] flush_write_buffer+0x3b/0x47
 [<c0185aa0>] sysfs_write_file+0x5a/0x69
 [<c0185a46>] sysfs_write_file+0x0/0x69
 [<c0156300>] vfs_write+0xb0/0x119
 [<c015640e>] sys_write+0x42/0x63
 [<c010b20b>] syscall_call+0x7/0xb


A "show regs" shows:

SysRq : Show Regs
 
Pid: 6, comm:             events/0
EIP: 0060:[<c01197b2>] CPU: 0
EIP is at smp_call_function+0x130/0x15b
 EFLAGS: 00000297    Not tainted
EAX: 00000000 EBX: 00000001 ECX: 00000000 EDX: 00000002
ESI: 00000001 EDI: 00000297 EBP: f7fda580 DS: 007b ES: 007b
CR0: 8005003b CR2: 400c6fe0 CR3: 36c1d000 CR4: 000006d0
Call Trace:
 [<c0113780>] mce_checkregs+0x0/0x92
 [<c0113839>] do_mce_timer+0x27/0x2b
 [<c0113780>] mce_checkregs+0x0/0x92
 [<c01319f5>] worker_thread+0x1be/0x283
 [<c0113812>] do_mce_timer+0x0/0x2b
 [<c011f07d>] default_wake_function+0x0/0x12
 [<c011f07d>] default_wake_function+0x0/0x12
 [<c0131837>] worker_thread+0x0/0x283
 [<c0109269>] kernel_thread_helper+0x5/0xb

The sysrq reboot function doesn't work - it you use it, the kernel
stops responding to sysrq requests as well.

Mike.
-- 
When life hands you lemons, grab the salt and pass the tequila.
