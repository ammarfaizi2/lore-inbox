Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbULQVpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbULQVpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 16:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbULQVpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 16:45:44 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47553 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262161AbULQVpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 16:45:25 -0500
Subject: SMP Kernel behaviour question
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-t/K+uLvTLjMJb6t7B847"
Organization: 
Message-Id: <1103318564.5383.90.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Dec 2004 13:22:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t/K+uLvTLjMJb6t7B847
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I ran into it while playing with kexec/kdump on 2.6.10-rc2-mm4 and
just curious on whats going on here.

I wanted to test kexec/kdump behaviour while a process is looping
busily for a spinlock. I wrote a small test case - where one
process holds a spinlock and other process spins for it forever.

On my SMP box (8-way, P-III, 8GB RAM), I was expecting to see
one CPU spinning for lock and others doing other stuff. Instead
I saw machine hang - all my windows frozen, console locked up,
I can't login or ssh. I forced a kexec dump using "sysrq" 
and the dump shows me that all other CPUs are doing idling.

So, I am wondering why the machine doesn't respond while there
are CPUs doing nothing. I checked getty and sshd processes and
they are doing nothing (in schedule()).

Here are the stacks for all CPUS. Any ideas ? 

Thanks,
Badari



--=-t/K+uLvTLjMJb6t7B847
Content-Disposition: attachment; filename=stackinfo.out
Content-Type: text/plain; name=stackinfo.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

> bt -a

PID: 0      TASK: c0404b60  CPU: 0   COMMAND: "swapper"
 #0 [c04cff70] crash_dump_nmi_callback at c011288b
 #1 [c04cff74] do_nmi at c0105a11
 #2 [c04cff8c] nmi_stack_correct at c0104753
 #3 [c04cffc8] cpu_idle at c0101b14
 
PID: 7858   TASK: f7b525b0  CPU: 1   COMMAND: "locky"
 #0 [f6f73e18] panic at c011b81a
 #1 [f6f73e28] __handle_sysrq at c028cb2b
 #2 [f6f73e54] receive_chars at c02b1430
 #3 [f6f73e88] serial8250_interrupt at c02b18ed
 #4 [f6f73eb4] handle_IRQ_event at c0138ff1
 #5 [f6f73edc] __do_IRQ at c013910d
 #6 [f6f73f08] do_IRQ at c0105fd7
 #7 [f6f73f10] common_interrupt at c010453d
    EAX: c0450b14  EBX: 19999999  ECX: c028cf00  EDX: 19999999  EBP: f6f73f48
    DS:  007b      ESI: 0000ac02  ES:  007b      EDI: 00000000
    CS:  0060      EIP: c038cba8  ERR: ffffff04  EFLAGS: 00000286
 #8 [f6f73f44] _spin_lock at c038cba8
 #9 [f6f73f4c] raw_ctl_ioctl at c028d195
#10 [f6f73f94] sys_ioctl at c016f18d
#11 [f6f73fc0] system_call at c0103bcc
    EAX: 00000036  EBX: 00000003  ECX: 0000ac02  EDX: 19999999
    DS:  007b      ESI: 40012f2c  ES:  007b      EDI: bffff5d4
    SS:  007b      ESP: bffff528  EBP: bffff548
    CS:  0073      EIP: 400e97d4  ERR: 00000036  EFLAGS: 00000246
 
PID: 0      TASK: c7969020  CPU: 2   COMMAND: "swapper"
 #0 [c7995f58] crash_dump_nmi_callback at c011288b
 #1 [c7995f5c] do_nmi at c0105a11
 #2 [c7995f74] nmi_stack_correct at c0104753
 #3 [c7995fb0] cpu_idle at c0101b14
 
PID: 5017   TASK: f7a9a530  CPU: 3   COMMAND: "sshd"
 #0 [f6d23ec4] crash_dump_nmi_callback at c011288b
 #1 [f6d23ec8] do_nmi at c0105a11
 #2 [f6d23ee0] nmi_stack_correct at c0104753
 #3 [f6d23f1c] tty_write at c0279993
 #4 [f6d23f68] vfs_write at c015bfdd
 #5 [f6d23f94] sys_write at c015c146
 #6 [f6d23fc0] system_call at c0103bcc
    EAX: 00000004  EBX: 00000006  ECX: 080aff50  EDX: 00000001
    DS:  007b      ESI: 080a9dc4  ES:  007b      EDI: 080a9d08
    SS:  007b      ESP: bffff348  EBP: bffff3c8
    CS:  0073      EIP: b7deaad4  ERR: 00000004  EFLAGS: 00000202

PID: 1503   TASK: f7f2c080  CPU: 4   COMMAND: "syslogd"
 #0 [f7a7fe50] crash_dump_nmi_callback at c011288b
 #1 [f7a7fe54] do_nmi at c0105a11
 #2 [f7a7fe6c] nmi_stack_correct at c0104753
 #3 [f7a7fea8] tty_write at c0279993
 #4 [f7a7fef4] do_readv_writev at c015c4a3
 #5 [f7a7ff78] vfs_writev at c015c5f0
 #6 [f7a7ff94] sys_writev at c015c6f2
 #7 [f7a7ffc0] system_call at c0103bcc
    EAX: 00000092  EBX: 00000001  ECX: bfffeeb0  EDX: 00000006
    DS:  007b      ESI: 00000006  ES:  007b      EDI: 00000001
    SS:  007b      ESP: bfffe9fc  EBP: bfffea18
    CS:  0073      EIP: b7f84a22  ERR: 00000092  EFLAGS: 00000296
 
PID: 0      TASK: c796e040  CPU: 5   COMMAND: "swapper"
 #0 [c799bef0] crash_dump_nmi_callback at c011288b
 #1 [c799bef4] do_nmi at c0105a11
 #2 [c799bf0c] nmi_stack_correct at c0104753
 #3 [c799bf5c] schedule at c038b8b9
 #4 [c799bfb0] cpu_idle at c0101b18
 
PID: 0      TASK: c7970a80  CPU: 6   COMMAND: "swapper"
 #0 [c79adf58] crash_dump_nmi_callback at c011288b
 #1 [c79adf5c] do_nmi at c0105a11
 #2 [c79adf74] nmi_stack_correct at c0104753
 #3 [c79adfb0] cpu_idle at c0101b14
 
PID: 7857   TASK: f71e8a40  CPU: 7   COMMAND: "vmstat"
 #0 [f68b3ef4] crash_dump_nmi_callback at c011288b
 #1 [f68b3ef8] do_nmi at c0105a11
 #2 [f68b3f10] nmi_stack_correct at c0104753
 #3 [f68b3f4c] proc_root_readdir at c018c3be
 #4 [f68b3f70] vfs_readdir at c016f360
 #5 [f68b3f90] sys_getdents64 at c016f7ab
 #6 [f68b3fc0] system_call at c0103bcc
    EAX: 000000dc  EBX: 00000006  ECX: 0804f038  EDX: 00000400
    DS:  007b      ESI: 00000000  ES:  007b      EDI: 00000006
    SS:  007b      ESP: bffff2fc  EBP: bffff378
    CS:  0073      EIP: 400bdcbb  ERR: 000000dc  EFLAGS: 00000212



--=-t/K+uLvTLjMJb6t7B847--

