Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264924AbUFAIC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbUFAIC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 04:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbUFAIC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 04:02:57 -0400
Received: from linuxhacker.ru ([217.76.32.60]:29863 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S264924AbUFAICv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 04:02:51 -0400
Date: Tue, 1 Jun 2004 11:01:04 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.4] Lockup detected by NMI Watchdog
Message-ID: <20040601080104.GA94212@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   It's been awhile since last lockup detected by NMI watchdog on this box,
   but this night it happened again. In completely different place too.
   The kernel version is 2.4.26, dual P4 Xeons, HT enabled, spinlock debug
   enabled. 2G RAM ECC RAM, highmem enabled.

NMI Watchdog detected LOCKUP on CPU1, eip c01168e7, registers:
CPU:    1
EIP:    0010:[<c01168e7>]    Not tainted
EFLAGS: 00000002
eax: 00000001   ebx: 00000000   ecx: 00000000   edx: c2833f78
esi: 00000001   edi: c2832000   ebp: c2833f6c   esp: c2833f58
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c2833000)
Stack: f6465280 f5b36000 c0105460 c2832000 c2832000 c2833fac c010cf5d c2833f78
       c0105460 00000000 c2832000 c2832000 c2832000 c2833fac 00000000 c2830018
       c2830018 ffffffef c010548c 00000010 00000246 c2833fc0 c0105522 0102080b
Call Trace:    [<c0105460>] [<c010cf5d>] [<c0105460>] [<c010548c>] [<c0105522>]
  [<c012088b>] [<c01206b4>]

Code: a8 01 75 f5 31 ff f6 42 32 02 75 06 f6 42 2c 03 74 05 bf 01
console shuts up ...
 NMI Watchdog detected LOCKUP on CPU3, eip c0109457, registers:
 NMI Watchdog detected LOCKUP on CPU2, eip c01168e2, registers:
   
>>EIP; c01168e7 <smp_apic_timer_interrupt+47/140>   <=====
   
>>edx; c2833f78 <_end+243b298/384bc380>
>>edi; c2832000 <_end+2439320/384bc380>
>>ebp; c2833f6c <_end+243b28c/384bc380>
>>esp; c2833f58 <_end+243b278/384bc380>

Trace; c0105460 <default_idle+0/40>
Trace; c010cf5d <call_apic_timer_interrupt+5/10>
Trace; c0105460 <default_idle+0/40>
Trace; c010548c <default_idle+2c/40>
Trace; c0105522 <cpu_idle+52/70>
Trace; c012088b <release_console_sem+11b/120>
Trace; c01206b4 <printk+194/200>

Code;  c01168e7 <smp_apic_timer_interrupt+47/140>
00000000 <_EIP>:
Code;  c01168e7 <smp_apic_timer_interrupt+47/140>   <=====
   0:   a8 01                     test   $0x1,%al   <=====
Code;  c01168e9 <smp_apic_timer_interrupt+49/140>
   2:   75 f5                     jne    fffffff9 <_EIP+0xfffffff9>
Code;  c01168eb <smp_apic_timer_interrupt+4b/140>
   4:   31 ff                     xor    %edi,%edi
Code;  c01168ed <smp_apic_timer_interrupt+4d/140>
   6:   f6 42 32 02               testb  $0x2,0x32(%edx)
Code;  c01168f1 <smp_apic_timer_interrupt+51/140>
   a:   75 06                     jne    12 <_EIP+0x12>
Code;  c01168f3 <smp_apic_timer_interrupt+53/140>
   c:   f6 42 2c 03               testb  $0x3,0x2c(%edx)
Code;  c01168f7 <smp_apic_timer_interrupt+57/140>
  10:   74 05                     je     17 <_EIP+0x17>
Code;  c01168f9 <smp_apic_timer_interrupt+59/140>
  12:   bf 01 00 00 00            mov    $0x1,%edi

The code itself seems to be looping in smp_apic_timer_interrupt->irq_enter()'s
loop based on what I see in the disassembly. (cpu1 an cpu2), cpu3 is at
handle_IRQ_event (irq_enter loop as well).
Unfortunatelly data on cpu0's place of execution is unavailable.
(I guess this might be not all that bad idea to print traces from all
available cpus when NMI watchdog triggers, if possible)

Sort of useless bugreport as I see it. I guess I really need to patch in
kgdb and gather more data next time something like this hits.
(will kgdb work in such conditions I wonder?)

Bye,
    Oleg
