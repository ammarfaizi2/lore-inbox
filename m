Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbTCOSsK>; Sat, 15 Mar 2003 13:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbTCOSsK>; Sat, 15 Mar 2003 13:48:10 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:65310
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261489AbTCOSsF>; Sat, 15 Mar 2003 13:48:05 -0500
Date: Sat, 15 Mar 2003 13:55:42 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Any hope for ide-scsi (error handling)?
Message-ID: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to upgrade to 2.5 and one of my stumbling blocks is 
cdwriting, i have both a scsi cdwriter and an ide one and haven't managed 
to write with either (SCSI bug report later). I know i shouldn't be using 
ide-scsi but it gets tiring typing since the gui interfaces to 
cdrecord are still playing catchup (sorry for not being hardcore). 
Unfortunately due to the nature of IDE it also completely takes out the 
harddisk attached to the same cable. I've setup a test rig for this so if 
anyone has suggestions i'm up for testing.

Here is a rather long paste of an attempt at writing with ide-scsi. There 
is a deadlock at the end of it all.

kernel is 2.5.64 (Alan should i be using 2.5.64-ac?)

cdrecord      S CB565DC0 4211491704  1310   1250  1311               
(NOTLB)
Call Trace:
 [<c011cfb2>] schedule+0x182/0x320
 [<c0318a81>] sg_ioctl+0xc71/0xe20

(an ls -l i tried on a harddisk on the same channel)

ls            D C02BDC24 4217658044  1313   1180                1249 
(NOTLB)
Call Trace:
 [<c02bdc24>] do_ide_request+0x14/0x20
 [<c027b510>] generic_unplug_device+0xd0/0xe0
 [<c011cfb2>] schedule+0x182/0x320
 [<c011e779>] io_schedule+0x29/0x40
 [<c015c9dd>] __wait_on_buffer+0xad/0xb0

...

hdd: irq timeout: status=0xd0 { Busy }
ide-scsi: abort called for 530
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c02dc9ec>] scsi_sleep+0x7c/0xa0
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
 [<c011d143>] schedule+0x313/0x320
 [<c01082fe>] __down+0xfe/0x1d0
 [<c011d1a0>] default_wake_function+0x0/0x20
 [<c010ac1b>] show_trace+0x3b/0x80
 [<c010869b>] __down_failed+0xb/0x14
 [<c02dd450>] .text.lock.scsi_error+0x97/0xc7
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c02dc9ec>] scsi_sleep+0x7c/0xa0
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
 [<c011d143>] schedule+0x313/0x320
 [<c01082fe>] __down+0xfe/0x1d0
 [<c011d1a0>] default_wake_function+0x0/0x20
 [<c010ac1b>] show_trace+0x3b/0x80
 [<c010869b>] __down_failed+0xb/0x14
 [<c02dd450>] .text.lock.scsi_error+0x97/0xc7
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c02dc9ec>] scsi_sleep+0x7c/0xa0
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
 [<c011d143>] schedule+0x313/0x320
 [<c01082fe>] __down+0xfe/0x1d0
 [<c011d1a0>] default_wake_function+0x0/0x20
 [<c010ac1b>] show_trace+0x3b/0x80
 [<c010869b>] __down_failed+0xb/0x14
 [<c02dd450>] .text.lock.scsi_error+0x97/0xc7
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c02dc9ec>] scsi_sleep+0x7c/0xa0
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
 [<c011d143>] schedule+0x313/0x320
 [<c01082fe>] __down+0xfe/0x1d0
 [<c011d1a0>] default_wake_function+0x0/0x20
 [<c010ac1b>] show_trace+0x3b/0x80
 [<c010869b>] __down_failed+0xb/0x14
 [<c02dd450>] .text.lock.scsi_error+0x97/0xc7
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c02dc9ec>] scsi_sleep+0x7c/0xa0
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
 [<c011d143>] schedule+0x313/0x320
 [<c01082fe>] __down+0xfe/0x1d0
 [<c011d1a0>] default_wake_function+0x0/0x20
 [<c010ac1b>] show_trace+0x3b/0x80
 [<c010869b>] __down_failed+0xb/0x14
 [<c02dd450>] .text.lock.scsi_error+0x97/0xc7
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c02dc9ec>] scsi_sleep+0x7c/0xa0
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
 [<c011d143>] schedule+0x313/0x320
 [<c01082fe>] __down+0xfe/0x1d0
 [<c011d1a0>] default_wake_function+0x0/0x20
 [<c010ac1b>] show_trace+0x3b/0x80
 [<c010869b>] __down_failed+0xb/0x14
 [<c02dd450>] .text.lock.scsi_error+0x97/0xc7
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c02dc9ec>] scsi_sleep+0x7c/0xa0
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
 [<c011d143>] schedule+0x313/0x320
 [<c01082fe>] __down+0xfe/0x1d0
 [<c011d1a0>] default_wake_function+0x0/0x20
 [<c010ac1b>] show_trace+0x3b/0x80
 [<c010869b>] __down_failed+0xb/0x14
 [<c02dd450>] .text.lock.scsi_error+0x97/0xc7
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c02dc9ec>] scsi_sleep+0x7c/0xa0
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
 [<c011d143>] schedule+0x313/0x320
 [<c01082fe>] __down+0xfe/0x1d0
 [<c011d1a0>] default_wake_function+0x0/0x20
 [<c010ac1b>] show_trace+0x3b/0x80
 [<c010869b>] __down_failed+0xb/0x14
 [<c02dd450>] .text.lock.scsi_error+0x97/0xc7
 [<c02dc950>] scsi_sleep_done+0x0/0x20
 [<c03127fc>] idescsi_abort+0x1bc/0x1d0
 [<c02dc1ba>] scsi_try_to_abort_cmd+0x9a/0xf0
 [<c02dc30e>] scsi_eh_abort_cmds+0x3e/0x80
 [<c02dcef3>] scsi_unjam_host+0xf3/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

ide-scsi: reset called for 530
bad: scheduling while atomic!
Call Trace:
 [<c011d143>] schedule+0x313/0x320
 [<c012bd84>] schedule_timeout+0x64/0xb0
 [<c012bd10>] process_timeout+0x0/0x10
 [<c0312973>] idescsi_reset+0x163/0x180
 [<c02dc3da>] scsi_try_bus_device_reset+0x8a/0x100
 [<c02dc499>] scsi_eh_bus_device_reset+0x49/0xc0
 [<c02dcd47>] scsi_eh_ready_devs+0x17/0x60
 [<c02dcf07>] scsi_unjam_host+0x107/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

NMI Watchdog detected LOCKUP on CPU0, eip c02be73d, registers:
CPU:    0
EIP:    0060:[<c02be73d>]    Tainted: PF 
EFLAGS: 00000086
EIP is at .text.lock.ide_io+0x40/0x93
eax: d1e6cdcc   ebx: c1616000   ecx: 00000106   edx: 00000001
esi: c12d7500   edi: d1e6cdcc   ebp: c1617e08   esp: c1617de0
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_1 (pid: 12, threadinfo=c1616000 task=c1760080)
Stack: c05c3160 c12d7500 00000282 c1617e08 c03557e1 c05c3160 0018e20c d1e6cdf0 
       c12d7500 c02bdcc0 c1617e30 c012c272 d1e6cdcc d1e6cdcc fffffffd c1617e50 
       00000000 00000001 c0561ee8 fffffffd c1617e50 c0127698 c12d7500 00000000 
Call Trace:
 [<c03557e1>] i8042_timer_func+0x21/0x30
 [<c02bdcc0>] ide_timer_expiry+0x0/0x310
 [<c012c272>] __run_timers+0xd2/0x1f7
 [<c0127698>] do_softirq+0xc8/0xd0
 [<c0117307>] smp_apic_timer_interrupt+0x77/0x80
 [<c010a9ba>] apic_timer_interrupt+0x1a/0x20
 [<c011d036>] schedule+0x206/0x320
 [<c012bd84>] schedule_timeout+0x64/0xb0
 [<c012bd10>] process_timeout+0x0/0x10
 [<c0312973>] idescsi_reset+0x163/0x180
 [<c02dc3da>] scsi_try_bus_device_reset+0x8a/0x100
 [<c02dc499>] scsi_eh_bus_device_reset+0x49/0xc0
 [<c02dcd47>] scsi_eh_ready_devs+0x17/0x60
 [<c02dcf07>] scsi_unjam_host+0x107/0x120
 [<c02dd026>] scsi_error_handler+0x106/0x140
 [<c02dcf20>] scsi_error_handler+0x0/0x140
 [<c0107435>] kernel_thread_helper+0x5/0x10

Code: f3 90 80 3d e0 20 56 c0 00 7e f5 e9 b7 f5 ff ff f3 90 80 3d 
