Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTE0Hud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 03:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTE0Hud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 03:50:33 -0400
Received: from ns01.counterexample.org ([65.206.41.67]:45188 "EHLO
	ns01.counterexample.org") by vger.kernel.org with ESMTP
	id S262457AbTE0Hua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 03:50:30 -0400
Date: Tue, 27 May 2003 04:03:39 -0400
From: "John T. Guthrie" <guthrie@counterexample.org>
Message-Id: <200305270803.h4R83dMc010911@gauss.counterexample.org>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] reading /proc/hermes/eth1/recs causes an oops in 2.5.69
Cc: guthrie@counterexample.org, hermes@gibson.dropbear.id.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm currently running Red Hat linux 8.0 on my Inspiron 8100 laptop.  Last
night, I decided to check out a recent 2.5 kernel.  While wandering around
in the /proc filesystem, I came across /proc/hermes/eth1/recs.  From what I
had seen in under 2.4.21-pre4, it should have just given me a whole bunch of
interesting information about my wireless card.  Instead, just attempting to
read the file caused an oops.  After the initial oops, the machine wasn't
completely unresponsive, I could still press the keyboard one more time to
generate yet another oops, but then the machine would be completely
unresponsive and had to be power cycled.

Before I post the oops, the kernel running at the time was 2.5.69.  I have
one builtin ethernet interface, which comes up as eth0, and one pcmcia
wireless card that comes up as eth1.  This card uses the orinoco_cs driver.

Here are the contents of /proc/modules just before the oops:

binfmt_misc 11016 0 - Live 0xd48d6000
autofs4 16256 0 - Live 0xd493a000
orinoco_cs 9480 1 - Live 0xd4930000
orinoco 44928 1 orinoco_cs, Live 0xd493f000
hermes 9088 2 orinoco_cs,orinoco,[permanent], Live 0xd48da000
ds 16768 3 orinoco_cs, Live 0xd48f1000
yenta_socket 17600 2 - Live 0xd48d0000
pcmcia_core 69536 3 orinoco_cs,ds,yenta_socket, Live 0xd48df000
3c59x 39720 0 - Live 0xd48b3000
parport_pc 36616 0 - Live 0xd48c0000
parport 43584 1 parport_pc, Live 0xd4825000
ohci1394 35328 0 - Live 0xd4811000
ieee1394 223500 1 ohci1394, Live 0xd48f8000
hid 32320 0 - Live 0xd481c000
usbcore 108884 2 hid, Live 0xd4831000
rtc 13220 0 - Live 0xd480c000

And finally, here is the result of piping the oops text through ksymoops:

ksymoops 2.4.9 on i686 2.4.21-pre4-acpi.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /tmp/module.list (specified)
     -o /lib/modules/2.4.21-pre4-acpi/ (default)
     -m /boot/System.map-2.5.69 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address f00af00a
c013f791
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c013f791>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: f00af00a   ebx: d3ddc640   ecx: c0387524   edx: ce582000
esi: c013f6c0   edi: ce582000   ebp: ce583de8   esp: ce583db0
ds: 007b   es: 007b   ss: 0068
Stack: ce583dd4 00000293 c02ef740 c03995bc ce582000 ce582000 ce583e68 ce582000 
       ce583de8 f00af00a c0385fe0 00000000 c013f6c0 ce582000 ce583e1c c0125612 
       00000000 ce582000 ce583e68 ce583e04 ce582000 ce583e04 ce583e04 00000000 
Call Trace:
 [<c013f6c0>] reap_timer_fnc+0x0/0x230
 [<c0125612>] run_timer_softirq+0xc2/0x1b0
 [<c0121655>] do_softirq+0xb5/0xc0
 [<c010b9c9>] do_IRQ+0x109/0x130
 [<c0109e58>] common_interrupt+0x18/0x20
 [<d48db0b2>] hermes_read_ltv+0x162/0x210 [hermes]
 [<c01b1747>] vsprintf+0x27/0x30
 [<d4945381>] orinoco_proc_get_hermes_recs+0xb1/0x2a0 [orinoco]
 [<d49452d0>] orinoco_proc_get_hermes_recs+0x0/0x2a0 [orinoco]
 [<c017ec16>] proc_file_read+0xc6/0x260
 [<c0152e3f>] vfs_read+0xaf/0x120
 [<c01530cc>] sys_read+0x3c/0x60
 [<c01094eb>] syscall_call+0x7/0xb
Code: 8b 00 0f 18 00 90 81 7d ec 34 75 38 c0 75 80 b9 24 75 38 c0 

>>EIP; c013f791 <reap_timer_fnc+d1/230>   <=====

>>eax; f00af00a <__crc_task_nice+152207/5b44d4>
>>ebx; d3ddc640 <__crc_dev_get_by_flags+358e62/96815b>
>>ecx; c0387524 <cache_chain_sem+0/10>
>>edx; ce582000 <__crc_pnp_add_mem_resource+7713eb/795a6c>
>>esi; c013f6c0 <reap_timer_fnc+0/230>
>>edi; ce582000 <__crc_pnp_add_mem_resource+7713eb/795a6c>
>>ebp; ce583de8 <__crc_pnp_add_mem_resource+7731d3/795a6c>
>>esp; ce583db0 <__crc_pnp_add_mem_resource+77319b/795a6c>

Trace; c013f6c0 <reap_timer_fnc+0/230>
Trace; c0125612 <run_timer_softirq+c2/1b0>
Trace; c0121655 <do_softirq+b5/c0>
Trace; c010b9c9 <do_IRQ+109/130>
Trace; c0109e58 <common_interrupt+18/20>
Trace; d48db0b2 <__crc_vfs_permission+904ed/10560f>
Trace; c01b1747 <vsprintf+27/30>
Trace; d4945381 <__crc_vfs_permission+fa7bc/10560f>
Trace; d49452d0 <__crc_vfs_permission+fa70b/10560f>
Trace; c017ec16 <proc_file_read+c6/260>
Trace; c0152e3f <vfs_read+af/120>
Trace; c01530cc <sys_read+3c/60>
Trace; c01094eb <syscall_call+7/b>

Code;  c013f791 <reap_timer_fnc+d1/230>
00000000 <_EIP>:
Code;  c013f791 <reap_timer_fnc+d1/230>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c013f793 <reap_timer_fnc+d3/230>
   2:   0f 18 00                  prefetchnta (%eax)
Code;  c013f796 <reap_timer_fnc+d6/230>
   5:   90                        nop    
Code;  c013f797 <reap_timer_fnc+d7/230>
   6:   81 7d ec 34 75 38 c0      cmpl   $0xc0387534,0xffffffec(%ebp)
Code;  c013f79e <reap_timer_fnc+de/230>
   d:   75 80                     jne    ffffff8f <_EIP+0xffffff8f>
Code;  c013f7a0 <reap_timer_fnc+e0/230>
   f:   b9 24 75 38 c0            mov    $0xc0387524,%ecx

 <0>Kernel panic: Fatal exception in interrupt

This particular kernel didn't have /proc/ksyms, so I couldn't use that in
this output.  If any information is needed, let me know.  I'm not on the
mailing list, so please cc me on any replies.  (I'm also cc'ing this to
David Gibson as well.)

Thank you very much.

Sincerely,

John Guthrie
guthrie@counterexample.org
