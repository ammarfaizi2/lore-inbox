Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289811AbSAWMII>; Wed, 23 Jan 2002 07:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289815AbSAWMH6>; Wed, 23 Jan 2002 07:07:58 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:39583 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289811AbSAWMHr>; Wed, 23 Jan 2002 07:07:47 -0500
Date: Wed, 23 Jan 2002 14:02:48 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.2-pre2-3 SMP broken on UP boxen
Message-ID: <Pine.LNX.4.44.0201231357480.12928-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
	My test box is a single proc machine running an SMP kernel. As of 
2.5.2-pre2 it panics on boot. The reason is kinda obvious, 
smp_processor_id() will always return the same as global_irq_holder.
How come we do this check now?

kernel/sched.c
asmlinkage void schedule(void)
{
	task_t *prev = current, *next;
	runqueue_t *rq = this_rq();
	prio_array_t *array;
	list_t *queue;
	int idx;
	if (unlikely(in_interrupt()))
		BUG();
	release_kernel_lock(prev, smp_processor_id()); <==
	spin_lock_irq(&rq->lock);
<snip>

include/asm-i386/smplock.h
#define release_kernel_lock(task, cpu)		\
do {						\
	if (unlikely(task->lock_depth >= 0)) {	\
		spin_unlock(&kernel_flag);	\
		if (global_irq_holder == (cpu))	\ <== Ugg....
				BUG();		\
	}					\
} while (0)

Here is the oops...

<snip>
CPU0: Intel Pentium II (Deschutes) stepping 02
per-CPU timeslice cutoff: 1463.72 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 350.7822 MHz.
..... host bus clock speed is 100.2233 MHz.
cpu: 0, clocks: 1002233, slice: 501116
CPU0<T0:1002224,T1:501104,D:4,S:501116,C:1002233>
kernel BUG at sched.c:588!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0119fdf>]    Not tainted
EFLAGS: 00010082
eax: 0000001b   ebx: c0338000   ecx: c031ee64   edx: 00000c43
esi: c037bca0   edi: c0338000   ebp: c0339f84   esp: c0339f58
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0339000)
Stack: c02da9e4 0000024c c0339f8c c0339fc0 c0105000 0008e000 c0107661 c0338000 
       c0338000 c0339fc0 c0105000 0008e000 c0109199 00010f00 c0105090 00000000 
       c0339fc0 c0105000 0008e000 00000001 00100018 00000018 00000078 c010725d 
Call Trace: [<c0105000>] [<c0107661>] [<c0105000>] [<c0109199>] [<c0105090>] 
   [<c0105000>] [<c010725d>] [<c0105019>] [<c0105090>] 

Code: 0f 0b 5a 59 fa 81 7e 04 ad 4e ad de 74 33 68 e3 9f 11 c0 68 
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing

>>EIP; c0119fdf <schedule+bf/4b0>   <=====
Trace; c0105000 <_stext+0/0>
Trace; c0107661 <sys_clone+21/30>
Trace; c0105000 <_stext+0/0>
Trace; c0109199 <reschedule+5/c>
Trace; c0105090 <init+0/1f0>
Trace; c0105000 <_stext+0/0>
Trace; c010725d <kernel_thread+1d/30>
Trace; c0105019 <rest_init+19/90>
Trace; c0105090 <init+0/1f0>
Code;  c0119fdf <schedule+bf/4b0>

00000000 <_EIP>:
Code;  c0119fdf <schedule+bf/4b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0119fe1 <schedule+c1/4b0>
   2:   5a                        pop    %edx
Code;  c0119fe2 <schedule+c2/4b0>
   3:   59                        pop    %ecx
Code;  c0119fe3 <schedule+c3/4b0>
   4:   fa                        cli
Code;  c0119fe4 <schedule+c4/4b0>
   5:   81 7e 04 ad 4e ad de      cmpl   $0xdead4ead,0x4(%esi)
Code;  c0119feb <schedule+cb/4b0>
   c:   74 33                     je     41 <_EIP+0x41> c011a020 <schedule+100/4b0>
Code;  c0119fed <schedule+cd/4b0>
   e:   68 e3 9f 11 c0            push   $0xc0119fe3
Code;  c0119ff2 <schedule+d2/4b0>
  13:   68 00 00 00 00            push   $0x0

0xc0119fbb <schedule+155>:      xchg   %bl,0xc037a400
0xc0119fc1 <schedule+161>:      movzbl 0xc031d120,%eax
0xc0119fc8 <schedule+168>:      mov    0xfffffff0(%ebp),%ecx
0xc0119fcb <schedule+171>:      cmp    0x20(%ecx),%eax
0xc0119fce <schedule+174>:      jne    0xc0119fe3 <schedule+195>
0xc0119fd0 <schedule+176>:      push   $0x24c
0xc0119fd5 <schedule+181>:      push   $0xc02da9e4
0xc0119fda <schedule+186>:      call   0xc0118570 <do_BUG>
0xc0119fdf <schedule+191>:      ud2a
0xc0119fe1 <schedule+193>:      pop    %edx
0xc0119fe2 <schedule+194>:      pop    %ecx


