Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUGHTvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUGHTvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 15:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUGHTvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 15:51:17 -0400
Received: from www.dubki.ru ([195.225.129.2]:4045 "EHLO mail.dubki.ru")
	by vger.kernel.org with ESMTP id S263736AbUGHTvC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 15:51:02 -0400
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Kernel crash in interrupt handler: nested interrupt breaks saved %eip?
Date: Thu, 8 Jul 2004 23:51:06 +0400
User-Agent: KMail/1.6.2
Cc: ghost@cs.msu.su, hbd@cs.msu.su, bahmurov@cs.msu.su
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407082351.13682@sercond.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello.

Recently I've got a server crash (complete hang). Server has it's console 
on serial port, so crash log was available:

root@zigzag:/home/nikita/adm> ksymoops -m /boot/System.map-2.6.6-1-k7-smp < 
crash_log
ksymoops 2.4.9 on i686 2.6.6-1-k7-smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6-1-k7-smp/ (default)
     -m /boot/System.map-2.6.6-1-k7-smp (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 2c031041
*pde = 00000000
Oops: 0002 [#1]
CPU:    1
EIP:    0060:[<c02262a2>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286   (2.6.6-1-k7-smp)
eax: c207c000   ebx: 00000001   ecx: 00000011   edx: c207c000
esi: c0336e98   edi: 0000000a   ebp: c03629e0   esp: c207df38
ds: 007b   es: 007b   ss: 0068
Stack: 00000068 00000001 c0124566 c0336e98 00000046 c207c000 00000013 
c012459d
       c207c000 c01089f8 00000013 c0332cc0 00000001 c0332cd8 f6d3d21c 
c207c000
       00000000 00000000 00000000 c0106bb8 c207c000 c0104030 c207c000 
00000000
Call Trace:
 [<c0124566>] __do_softirq+0xa6/0xb0
 [<c012459d>] do_softirq+0x2d/0x30
 [<c01089f8>] do_IRQ+0x138/0x190
 [<c0106bb8>] common_interrupt+0x18/0x20
 [<c0104030>] default_idle+0x0/0x40
 [<c010405c>] default_idle+0x2c/0x40
 [<c01040e3>] cpu_idle+0x33/0x40
 [<c0120681>] printk+0x1a1/0x1f0
Code: 10 8b 40 10 03 2c 85 20 50 36 c0 a1 80 99 2c c0 89 44 24 08


>>EIP; c02262a2 <net_rx_action+12/100>   <=====

>>eax; c207c000 <__crc_sysfs_remove_dir+37704/567b6a>
>>edx; c207c000 <__crc_sysfs_remove_dir+37704/567b6a>
>>esi; c0336e98 <softirq_vec+18/100>
>>ebp; c03629e0 <per_cpu__softnet_data+0/240>
>>esp; c207df38 <__crc_sysfs_remove_dir+3963c/567b6a>

Trace; c0124566 <__do_softirq+a6/b0>
Trace; c012459d <do_softirq+2d/30>
Trace; c01089f8 <do_IRQ+138/190>
Trace; c0106bb8 <common_interrupt+18/20>
Trace; c0104030 <default_idle+0/40>
Trace; c010405c <default_idle+2c/40>
Trace; c01040e3 <cpu_idle+33/40>
Trace; c0120681 <printk+1a1/1f0>

Code;  c02262a2 <net_rx_action+12/100>
00000000 <_EIP>:
Code;  c02262a2 <net_rx_action+12/100>   <=====
   0:   10 8b 40 10 03 2c         adc    %cl,0x2c031040(%ebx)   <=====
Code;  c02262a8 <net_rx_action+18/100>
   6:   85 20                     test   %esp,(%eax)
Code;  c02262aa <net_rx_action+1a/100>
   8:   50                        push   %eax
Code;  c02262ab <net_rx_action+1b/100>
   9:   36 c0 a1 80 99 2c c0      shlb   $0x89,%ss:0xc02c9980(%ecx)
Code;  c02262b2 <net_rx_action+22/100>
  10:   89
Code;  c02262b3 <net_rx_action+23/100>
  11:   44                        inc    %esp
Code;  c02262b4 <net_rx_action+24/100>
  12:   24 08                     and    $0x8,%al

 <0>Kernel panic: Fatal exception in interrupt

I tried to debug this. Server runs debian's 2.6.6-1-k7-smp kernel; vmlinux 
file is not available. So (after reboot) I just attached gdb 
to /proc/kcore.

First I tried to examine __do_softirq() function near 0xc0124566 address.
The assembly code near that point is:

0xc0124561:     mov    %esi,(%esp)
0xc0124564:     call   *(%esi)
0xc0124566:     jmp    0xc0124507

Comparing this with function source, it definitly corresponds to the 
h->action(h) call inside

	do {
		if (pending & 1)
			h->action(h);
		h++;
		pending >>= 1;
	} while (pending);

'h' variable is in %esi register, and %esi value in the crash log points to 
4th element of softirq_vec array; 'action' pointer of that element really 
points to net_rx_action() function mentioned in the crash log.

The assembly of the start of that function is

0xc0226290:     push   %ebp
0xc0226291:     mov    $0xffffe000,%eax
0xc0226296:     mov    $0xc03629e0,%ebp
0xc022629b:     push   %edi
0xc022629c:     and    %esp,%eax
0xc022629e:     push   %esi
0xc022629f:     push   %ebx
0xc02262a0:     sub    $0x10,%esp
0xc02262a3:     mov    0x10(%eax),%eax
0xc02262a6:     add    0xc0365020(,%eax,4),%ebp

The crash address - 0xc02262a2 - is inside a multi-byte instruction. 
Processor tried to read from that address and executed instruction
 adc    %cl,0x2c031040(%ebx)
that caused invalid memory access and the crash.

So the question is - how could invalid address (0xc02262a2) get into %eip.

Interrupts at the beginning of net_rx_action() on this code path are 
enabled - this is after local_irq_enable() in __do_softirq(), but before 
local_irq_disable() in net_rx_action().

So I think that an interrupt happened at that time, and %eip was broken 
inside the handler.

(other possible reasons I could think of are hardware fault and stack 
breakage inside net_rx_action(); both seem to be much less probable: 
hardware is in every day use and works stable; crash happened after days 
of stable operation - so the probable reason is a RARE event such as an 
interrupt at exact point; register values look like only several few first 
instructions of net_rx_action() have been executed, it's almost impossible 
to get these values if it was overwritten %eip in the stack in nested 
calls).

Some time ago I was playing with home-written RTAI-like realtime kernel 
extension, and while debugging it found code in the kernel that alters 
saved %eip value under some conditions (e.g. to restart an instruction).
Due to bug in my code, that happened at unwanted time, causing user-level 
process resume with invalid %eip and mystorious segfaults in the middle of 
instructions.

Of course I'm not sure, but it looks like something similar caused the 
crash I'm writing about. Somewhere in the nested interrupt handler it was 
not detected correctly that a nested interrupt from code handling another 
interrupt is hapenning, and saved %eip was altered.

At this point I fell I can't go forward - I'm not that familiar with 
lowlevel kernel code. So I'm looking for some help ...


All that is about debian's 2.6.6-1-k7-smp kernel, installed as a debian 
package on a server that has 2 AMD CPUs and a Tyan motherboard. Kernel 
pre-emption is enabled in the debian kernel; complete system.map is 
available at http://zigzag.lvk.cs.msu.su/~nikita/System.map-2.6.6-1-k7-smp
I may provide detailed system information if needed.

Nikita Youshchenko
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7aWwsTbPknTfAB4RAnkqAJ9Ee8NWFHmzdV8E/DCxHITDNsZScQCfV1fK
7EI2aXIsIjjDNQMa2HWHq2g=
=D0cC
-----END PGP SIGNATURE-----
