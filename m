Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUHNNhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUHNNhS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 09:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUHNNhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 09:37:18 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:29931 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262085AbUHNNhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 09:37:13 -0400
Date: Sat, 14 Aug 2004 09:41:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mulix@mulix.org,
       gene.heskett@verizon.net
Subject: Re: [RFC] HOWTO find oops location
In-Reply-To: <20040814091106.GO17907@granada.merseine.nu>
Message-ID: <Pine.LNX.4.58.0408140904290.18353@montezuma.fsmlabs.com>
References: <200408141153.06625.vda@port.imtp.ilyichevsk.odessa.ua>
 <20040814091106.GO17907@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few very simple methods i use all the time;

compile with CONFIG_DEBUG_INFO (it's safe to select the option and
recompile after the oops even) and then;

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c046a188
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c046a188>]    Not tainted VLI
EFLAGS: 00010246   (2.6.6-mm3)
EIP is at serial_open+0x38/0x170
[...]

(gdb) list *serial_open+0x38
0xc046a188 is in serial_open (drivers/usb/serial/usb-serial.c:465).
460
461             /* get the serial object associated with this tty pointer */
462             serial = usb_serial_get_by_index(tty->index);
463
464             /* set up our port structure making the tty driver remember our port object, and us it */
465             portNumber = tty->index - serial->minor;
466             port = serial->port[portNumber];
467             tty->driver_data = port;
468
469             port->tty = tty;

And then for cases where you deadlock and the NMI watchdog triggers with
%eip in a lock section;

NMI Watchdog detected LOCKUP on CPU0,
eip c0119e5e, registers:
Modules linked in:
CPU:    0
EIP:    0060:[<c0119e5e>]    Tainted:
EFLAGS: 00000086   (2.6.7)
EIP is at .text.lock.sched+0x89/0x12b
[...]

(gdb) disassemble 0xc0119e5e
Dump of assembler code for function Letext:
[...]
0xc0119e59 <Letext+132>:        repz nop
0xc0119e5b <Letext+134>:        cmpb   $0x0,(%edi)
0xc0119e5e <Letext+137>:        jle    0xc0119e59 <Letext+132>
0xc0119e60 <Letext+139>:        jmp    0xc0118183 <scheduler_tick+487>

(gdb) list *scheduler_tick+487
0xc0118183 is in scheduler_tick (include/asm/spinlock.h:124).
119             if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
120                     printk("eip: %p\n", &&here);
121                     BUG();
122             }
123     #endif
124             __asm__ __volatile__(
125                     spin_lock_string
126                     :"=m" (lock->lock) : : "memory");
127     }

But that's not much help since it's pointing to an inline function and not
the real lock location, so just subtract a few bytes;

(gdb) list *scheduler_tick+450
0xc011815e is in scheduler_tick (kernel/sched.c:2021).
2016            cpustat->system += sys_ticks;
2017
2018            /* Task might have expired already, but not scheduled off yet */
2019            if (p->array != rq->active) {
2020                    set_tsk_need_resched(p);
2021                    goto out;
2022            }
2023            spin_lock(&rq->lock);

So we have our lock location. Then there are cases where there is a "Bad
EIP" most common ones are when a bad function pointer is followed or if
some of the kernel text or a module got unloaded/unmapped (e.g. via
__init). You can normally determine which is which by noting that bad eip
for unloaded text normally looks like a valid virtual address.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU: 0
EIP: 0060:[<00000000>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246
[...]
Call Trace:
 [<c01dbbfb>] smb_readdir+0x4fb/0x6e0
 [<c0165560>] filldir64+0x0/0x130
 [<c016524a>] vfs_readdir+0x8a/0x90
 [<c0165560>] filldir64+0x0/0x130
 [<c01656fd>] sys_getdents64+0x6d/0xa6
 [<c0165560>] filldir64+0x0/0x130
 [<c010adff>] syscall_call+0x7/0xb
Code: Bad EIP value.

>From there you're best off examining the call trace to find the culprit.
