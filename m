Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVDXBuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVDXBuw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 21:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVDXBuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 21:50:51 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:15797 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S262224AbVDXBsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 21:48:36 -0400
Date: Sun, 24 Apr 2005 03:48:34 +0200
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel BUG() in exit.c in ptrace/pthread interaction
Message-ID: <20050424014834.GA31463@cs.unibo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: mbellett@cs.unibo.it (Mattia Belletti)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When you run the program in attachment, *even as an ordinary user*, the kernel
panic. Tested kernel is a 2.6.11.7 vanilla with alleged .config. Tested with
similar configuration on both a qemu machine and a real one (only fs changes).
The code is taken by a program of mine, and slightly simplified, but don't
trust comments.

Keywords: ptrace, (p)thread
Kernel version: 2.6.11.7 vanilla
Output:

When the program is run, the kernel triggers a BUG(), and the following one is
repeated quite a lot of times, with increasing Call Trace:

 ------------[ cut here ]------------
kernel BUG at kernel/exit.c:520!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0110cd0>]    Not tainted VLI
EFLAGS: 00000046   (2.6.11.7-crasher) 
EIP is at exit_notify+0x5c0/0x840
eax: d7fffb04   ebx: d7fffaa0   ecx: 00000000   edx: d7fff5fc
esi: d7fff5a0   edi: d75b8540   ebp: d7fff5a0   esp: d6fadf54
ds: 007b   es: 007b   ss: 0068
Process ptrace-thread-f (pid: 808, threadinfo=d6fac000 task=d7fff5a0)
Stack: c010d3b0 b7e9d2e8 00000001 d7fff5fc d7fff640 00000000 00000000 d7fff5fc 
       d6fadf74 d6fadf74 c138a560 d7fff5a0 00000000 00000000 c0111067 d7fff5a0 
       d6fac000 c01184d4 c0118ebe d6fac000 00000000 b7fc8934 d6fac000 c0111244 
Call Trace:
 [<c010d3b0>] mm_release+0x90/0xa0
 [<c0111067>] do_exit+0x117/0x280
 [<c01184d4>] signal_wake_up+0x24/0x30
 [<c0118ebe>] zap_other_threads+0x5e/0xb0
 [<c0111244>] do_group_exit+0x34/0x70
 [<c0102483>] syscall_call+0x7/0xb
Code: 0f 85 79 ff ff ff eb dc 8d 76 00 89 5c 24 08 31 c0 89 44 24 04 8b 83 84 00 00 00 89 04 24 e8 48 82 00 00 e9 0c fc ff ff 8d 76 00 <0f> 0b 08 02 ff cc 27 c0 e9 da fb ff ff 8d 76 00 0f 0b 05 02 ff 
 ------------[ cut here ]------------

Last time this appears, before outputting '=======================' endlessly,
has this form:

 ------------[ cut here ]------------
kernel BUG at kernel/exit.c:520!
invalid operand: 0000 [#19]
CPU:    0
EIP:    0060:[<c0110cd0>]    Not tainted VLI
EFLAGS: 00000046   (2.6.11.7-crasher) 
EIP is at exit_notify+0x5c0/0x840
eax: d7fffb04   ebx: d7fffaa0   ecx: d7fff5a0   edx: d7fff5fc
esi: d7fff5a0   edi: d75b8540   ebp: d7fff5a0   esp: d6fac2a4
ds: 007b   es: 007b   ss: 0068
Process ptrace-thread-f (pid: 808, threadinfo=d6fac000 task=d7fff5a0)
Stack: 0000000a d7fff5a0 c011356b d7fff5fc d7fff640 c027bc4c c0103130 d7fff5fc 
       d6fac2c4 d6fac2c4 00000000 d7fff5a0 0000000b 00000000 c0111067 d7fff5a0 
       d7fff5a0 ffffffff 0000007b d6fac000 00000000 c0103130 d7fff5a0 c0102d5e 
Call Trace:
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c019b912>] __delay+0x12/0x20
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c01be900>] i8042_timer_func+0x0/0x20
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c01be900>] i8042_timer_func+0x0/0x20
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010c10d>] scheduler_tick+0x23d/0x290
 [<c01172a2>] update_process_times+0x32/0x110
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c01064c4>] timer_interrupt+0x54/0xf0
 [<c011351e>] __do_softirq+0x2e/0x90
 [<c0124020>] handle_IRQ_event+0x30/0x70
 [<c01240b1>] __do_IRQ+0x51/0xf0
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c01064c4>] timer_interrupt+0x54/0xf0
 [<c011351e>] __do_softirq+0x2e/0x90
 [<c0124020>] handle_IRQ_event+0x30/0x70
 [<c01240b1>] __do_IRQ+0x51/0xf0
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c01064c4>] timer_interrupt+0x54/0xf0
 [<c011351e>] __do_softirq+0x2e/0x90
 [<c0124020>] handle_IRQ_event+0x30/0x70
 [<c01240b1>] __do_IRQ+0x51/0xf0
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c019b912>] __delay+0x12/0x20
 [<c01c4ea0>] serial8250_console_write+0x160/0x250
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c010b6d2>] activate_task+0x62/0x80
 [<c010bf6e>] scheduler_tick+0x9e/0x290
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c011356b>] __do_softirq+0x7b/0x90
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0111067>] do_exit+0x117/0x280
 [<c0103130>] do_invalid_op+0x0/0xd0
 [<c0102d5e>] die+0x14e/0x150
 [<c01031e2>] do_invalid_op+0xb2/0xd0
 [<c0121b12>] get_futex_key+0x42/0x160
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c0121d26>] futex_wake+0x46/0xd0
 [<c012252c>] do_futex+0x6c/0xa0
 [<c010262b>] error_code+0x2b/0x30
 [<c0110cd0>] exit_notify+0x5c0/0x840
 [<c010d3b0>] mm_release+0x90/0xa0
 [<c0111067>] do_exit+0x117/0x280
 [<c01184d4>] signal_wake_up+0x24/0x30
 [<c0118ebe>] zap_other_threads+0x5e/0xb0
 [<c0111244>] do_group_exit+0x34/0x70
 [<c0102483>] syscall_call+0x7/0xb
 =======================

Software:
kernel was compiled under a system with the following characteristics:

>>>
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux ale 2.6.10-as3-virtuale #1 SMP Wed Feb 9 13:43:48 CET 2005 i686 GNU/Linux
 
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.2-pre1
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.20
quota-tools            3.12.
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
./scripts/ver_linux: line 90: udevinfo: command not found
Modules Loaded         
>>>

And run on a qemu machine, between the others:

>>>
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux ubuntu-zoo 2.6.11.7-crasher #1 Tue Apr 19 22:08:08 CEST 2005 i686 GNU/Linux
 
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre2
e2fsprogs              1.35
jfsutils               1.1.4
reiserfsprogs          3.6.17
reiser4progs           0.5.3
xfsprogs               2.6.18
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
udev                   026
>>>

But in fact I tried the original program (which shows the same behaviour) on at
least other two hardwares, with similar results, and this cut down version on
both qemu and my hardware, so I think it's quite indipendent.

I'm not subscribed to lkml, so please CC me in this thread.

-- 
Mat/tia Belletti             - Graduate student @ cs.unibo.it
ICQ: 33292311                - email: mbellett@cs.unibo.it
IRC: RedGlow                 - site(s): http://mbellett.web.cs.unibo.it/
RedGlow@jabber.linux.it/Gaim - Linux user 299762 @ machine 213003

--YiEDa0DAkWCtVeE4
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="ptrace-thread-bug.c"

#include <signal.h>
#include <assert.h>
#include <errno.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#define printf_deb	printf


static int create_tracer(pid_t pid);
static void *tracer_routine(void *arg);


int main(int argc, char *argv[])
{
	int pid, ret, status;

	/* CREATE THE CHILDREN */

	switch(pid = fork())
	{
		case -1:
			perror("first process fork() failed");
			return 1;

		case 0:
			/* child */
			printf_deb("child: pid=%d\n", getpid());
			if(ptrace(PTRACE_TRACEME, 0, 0, 0) != 0){
				perror("first ptrace() failed");
				return 1;
			}
			printf_deb("child: self sigstopping\n");
			ret = kill(getpid(), SIGSTOP);
			assert(ret == 0);
			printf_deb("child: going execvp\n");
			execvp(argv[0], argv);
			perror("execvp() failed");
			return 1;

		default:
			/* father */
			printf_deb("father: pid=%d\n", getpid());
			printf_deb("father: waiting child's selfstopping\n");
			if(waitpid(pid, &status, WUNTRACED) != pid)
			{
				perror("waitpid() for first child's stop failed");
				return 1;
			}
			printf_deb("father: making child go again under ptrace\n");
			break;
	}

	/* CREATE TRACER AND PASS PTRACE STATUS */

	if((ret = create_tracer(pid)) != 0)
		return ret;

	return 0;
}

/*! Structure used to pass data to the tracer thread so that it can
 * cooperate on creation. */
struct tracer_creation_data
{
	/*! Semaphore used to know when the tracer has finished
	 * initialization */
	sem_t s;
	/*! PID of the process which is going to be managed */
	pid_t pid;
};

/*! Creates a tracer.
 *
 * tracer creation is made of two parts: thread creation, and ptrace
 * status passing. In the second one, current thread detach the process while
 * stopping it at the same time, and then the tracer attach to the
 * process, and awakes it.
 *
 * \param	pid	The PID of the process for which the tracer is
 * 			created.
 * \return	An error code, or 0
 */
static int create_tracer(pid_t pid)
{
	pthread_t ga;
	struct tracer_creation_data tracer_cd;

	/* create the new thread in detached state (we don't care about thread
	 * termination, they care about themselves) */
	tracer_cd.pid = pid;
	if(sem_init(&tracer_cd.s, 0, 0) != 0)
	{
		perror("semaphore creation failed");
		return 1;
	}

	/* detach process and stop it, and then tell the tracer he can
	 * attach */
	printf_deb("father: detaching\n");
	if(ptrace(PTRACE_DETACH, pid, 0, SIGSTOP) != 0)
	{
		printf_deb("father: error while detaching %d\n", pid);
		perror("child detach failed");
		return 1;
	}

	printf_deb("father: thread creation\n");
	if((errno = pthread_create(&ga, NULL, tracer_routine, &tracer_cd)) != 0)
	{
		perror("tracer thread creation failed");
		return 1;
	}

	/* wait for the tracer to be ready */
	printf_deb("father: waiting for end\n");
	if(sem_wait(&tracer_cd.s) != 0)
	{
		perror("dispatcher mutex problem");
		return 1;
	}

	/* destroy semaphores */
	printf_deb("father: destroying semaphore\n");
	if(sem_destroy(&tracer_cd.s) != 0)
	{
		perror("failed to complete tracer creation\n");
		return 1;
	}

	printf_deb("father: all done\n");
	return 0;
}

/*! Routine common to all tracers.
 *
 * Cooperate with create_tracer to complete ptrace passing process,
 * then waits for the dispatching of signals and manage them.
 *
 * \param	arg	A struct tracer_creation_data which is used to complete
 * 			startup
 * \return	Not used, required by pthread_create signature.
 */
static void *tracer_routine(void *arg)
{
	struct tracer_creation_data *tracer_cd = (struct tracer_creation_data*)arg;
	pid_t pid = tracer_cd->pid;
	pthread_t tid = pthread_self();

	/* wait for the dispatcher to detach the process, and then attach */
	printf_deb("thread %lu: attaching\n", tid);
	if(ptrace(PTRACE_ATTACH, pid, 0, 0) != 0)
	{
		perror("child attach failed");
		exit(1);
	}

	/* tell the dispatcher he's done, and can dispose the data */
	printf_deb("thread %lu: unlocking\n", tid);
	if(sem_post(&tracer_cd->s) != 0)
	{
		perror("tracer failed to unlock");
		exit(1);
	}

	/* ok - we've attached it, now it can go until next syscall */
	printf_deb("thread %lu: unlocking child\n", tid);
	if(ptrace(PTRACE_SYSCALL, pid, 0, 0) != 0)
	{
		perror("failed to make first child start");
		exit(1);
	}

	for(;;)
		pause();

	return NULL;
}


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.6.11.7-crasher"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11.7-crasher
# Tue Apr 19 22:04:50 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
# CONFIG_KOBJECT_UEVENT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMII=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_IP_TCPDIAG is not set
# CONFIG_IP_TCPDIAG_IPV6 is not set
CONFIG_IPV6=y
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
CONFIG_INET6_TUNNEL=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_NETFILTER is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_4KSTACKS is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--YiEDa0DAkWCtVeE4--
