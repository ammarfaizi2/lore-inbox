Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTL1Sfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 13:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTL1Sfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 13:35:48 -0500
Received: from host179.debill.org ([64.245.56.179]:7884 "EHLO mail.debill.org")
	by vger.kernel.org with ESMTP id S261889AbTL1Sfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 13:35:43 -0500
Date: Sun, 28 Dec 2003 12:35:43 -0600
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 IDE CD repeatable panic
Message-ID: <20031228183543.GA9983@debill.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: erik@debill.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using vanilla 2.6.0 I'm getting a 100% repeatable panic while reading
from a bad dvd using an IDE dvdrom drive.  I get a series of messages
on serial console saying

hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0x00
hdc: drive not ready for command
hdc: ATAPI reset complete

and eventually the system panics with "Unable to handle kernel paging
request at virtual address c7de1f74".  The specific address changes
each time, it's been 00000000 a couple times.

A simple dd if=/dev/hdc of=/dev/null bs=1M is enough to trigger it.

This is on a dual Athlon MP 1600+ with 1.5G RAM, on the builtin AMD
IDE controller.  I've reproduced the crash using a UP kernel (compiled
for UP, not just setting command line options).  It happens both on
kernels with all debugging options on and with them all off.  OS is
Debian unstable, gcc version 3.3.3.

I can't reproduce the crash without using DMA - PIO seems safe.

Playing the dvd at normal speed (as opposed to ripping it as fast as I
can) seems safe, too.  I may or may not get the I/O errors, but it
doesn't crash either way.  I have to be using DMA and ripping full
speed ahead.

The whole system lags like mad while ripping from the dvdrom, and gets
pretty much unuseable while doing so in PIO mode.  I also noticed that
using serial console seems to disable virtual consoles, which is
rather annoying.

I'll be happy to post configs, test patches or whatever.

ksymoops output below.


Erik

hagbard:~ > ksymoops  -o /lib/modules/2.6.0debug/ -m /boot/System.map-2.6.0debug  --no-ksyms case.smpdebug
ksymoops 2.4.9 on i686 2.6.0.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0debug/ (specified)
     -m /boot/System.map-2.6.0debug (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
 Linux version 2.6.0debug (edebill@hagbard) (gcc version 3.3.3 20031206 (prerelease) (Debian)) #118 SMP Sat Dec 27 15:27:10 CST 2003
CPU 1 IS NOW UP!
Machine check exception polling timer started.
e100: eth0: Intel(R) PRO/100 Network Connection
e100: eth0 NIC Link is Up 100 Mbps Full duplex
Unable to handle kernel paging request at virtual address c7de1f74
f8a6d192
*pde = 00020067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<f8a6d192>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000001   ecx: c04c990c   edx: f73a3e98
esi: c7de1f60   edi: 00000040   ebp: d586dd24   esp: d586db0c
ds: 007b   es: 007b   ss: 0068
Stack: 00008000 d586db38 00000058 f73a4f1c 0284e981 00002710 00000096 d726ae00 
       00000080 00000000 c7de1f60 d586dd68 f8a6d168 c04c990c f8a6cf10 00002710 
       00000000 00008000 d586dbac 00000058 c0142979 f7fb2f44 00000220 00000020 
Call Trace:
 [<f8a6d168>] cdrom_read_intr+0x258/0x390 [ide_cd]
 [<f8a6cf10>] cdrom_read_intr+0x0/0x390 [ide_cd]
 [<c0142979>] mempool_alloc+0x59/0x1c0
 [<c0149020>] kmem_cache_alloc+0x140/0x1d0
 [<c0120ca0>] autoremove_wake_function+0x0/0x40
 [<c0142979>] mempool_alloc+0x59/0x1c0
 [<c0120ca0>] autoremove_wake_function+0x0/0x40
 [<c012c1a5>] __mod_timer+0x195/0x390
 [<c0283104>] ata_output_data+0x84/0x90
 [<c012cb7e>] update_process_times+0x2e/0x40
 [<c0117b4e>] smp_apic_timer_interrupt+0x14e/0x160
 [<c010a98a>] apic_timer_interrupt+0x1a/0x20
 [<c012cb7e>] update_process_times+0x2e/0x40
 [<c0117b4e>] smp_apic_timer_interrupt+0x14e/0x160
 [<c010a98a>] apic_timer_interrupt+0x1a/0x20
 [<c0280831>] ide_intr+0x1a1/0x320
 [<f8a6cf10>] cdrom_read_intr+0x0/0x390 [ide_cd]
 [<c010c1f3>] handle_IRQ_event+0x33/0x60
 [<c010c693>] do_IRQ+0xe3/0x220
 [<c010a908>] common_interrupt+0x18/0x20
 [<c0219218>] __copy_to_user_ll+0x28/0x40
 [<c01405f3>] file_read_actor+0xc3/0xe0
 [<c0140282>] do_generic_mapping_read+0x112/0x3c0
 [<c0140530>] file_read_actor+0x0/0xe0
 [<c0140801>] __generic_file_aio_read+0x1f1/0x230
 [<c0140530>] file_read_actor+0x0/0xe0
 [<c0140910>] generic_file_read+0x80/0xb0
 [<c011ad75>] do_page_fault+0x325/0x55d
 [<f8a70514>] idecd_ioctl+0x54/0x60 [ide_cd]
 [<c016ace9>] block_llseek+0x39/0x100
 [<c016260e>] vfs_read+0x9e/0x100
 [<c016284e>] sys_read+0x2e/0x50
 [<c01099e7>] syscall_call+0x7/0xb
Code: 8b 46 14 e9 74 ff ff ff 8b 85 e8 fd ff ff 50 8b 7d 08 57 68 


>>EIP; f8a6d192 <_end+3859bcea/3fb2cb58>   <=====

>>ecx; c04c990c <ide_hwifs+68c/3ac0>
>>edx; f73a3e98 <_end+36ed29f0/3fb2cb58>
>>esi; c7de1f60 <_end+7910ab8/3fb2cb58>
>>ebp; d586dd24 <_end+1539c87c/3fb2cb58>
>>esp; d586db0c <_end+1539c664/3fb2cb58>

Trace; f8a6d168 <_end+3859bcc0/3fb2cb58>
Trace; f8a6cf10 <_end+3859ba68/3fb2cb58>
Trace; c0142979 <mempool_alloc+59/1c0>
Trace; c0149020 <kmem_cache_alloc+140/1d0>
Trace; c0120ca0 <autoremove_wake_function+0/40>
Trace; c0142979 <mempool_alloc+59/1c0>
Trace; c0120ca0 <autoremove_wake_function+0/40>
Trace; c012c1a5 <__mod_timer+195/390>
Trace; c0283104 <ata_output_data+84/90>
Trace; c012cb7e <update_process_times+2e/40>
Trace; c0117b4e <smp_apic_timer_interrupt+14e/160>
Trace; c010a98a <apic_timer_interrupt+1a/20>
Trace; c012cb7e <update_process_times+2e/40>
Trace; c0117b4e <smp_apic_timer_interrupt+14e/160>
Trace; c010a98a <apic_timer_interrupt+1a/20>
Trace; c0280831 <ide_intr+1a1/320>
Trace; f8a6cf10 <_end+3859ba68/3fb2cb58>
Trace; c010c1f3 <handle_IRQ_event+33/60>
Trace; c010c693 <do_IRQ+e3/220>
Trace; c010a908 <common_interrupt+18/20>
Trace; c0219218 <__copy_to_user_ll+28/40>
Trace; c01405f3 <file_read_actor+c3/e0>
Trace; c0140282 <do_generic_mapping_read+112/3c0>
Trace; c0140530 <file_read_actor+0/e0>
Trace; c0140801 <__generic_file_aio_read+1f1/230>
Trace; c0140530 <file_read_actor+0/e0>
Trace; c0140910 <generic_file_read+80/b0>
Trace; c011ad75 <do_page_fault+325/55d>
Trace; f8a70514 <_end+3859f06c/3fb2cb58>
Trace; c016ace9 <block_llseek+39/100>
Trace; c016260e <vfs_read+9e/100>
Trace; c016284e <sys_read+2e/50>
Trace; c01099e7 <syscall_call+7/b>

Code;  f8a6d192 <_end+3859bcea/3fb2cb58>
00000000 <_EIP>:
Code;  f8a6d192 <_end+3859bcea/3fb2cb58>   <=====
   0:   8b 46 14                  mov    0x14(%esi),%eax   <=====
Code;  f8a6d195 <_end+3859bced/3fb2cb58>
   3:   e9 74 ff ff ff            jmp    ffffff7c <_EIP+0xffffff7c>
Code;  f8a6d19a <_end+3859bcf2/3fb2cb58>
   8:   8b 85 e8 fd ff ff         mov    0xfffffde8(%ebp),%eax
Code;  f8a6d1a0 <_end+3859bcf8/3fb2cb58>
   e:   50                        push   %eax
Code;  f8a6d1a1 <_end+3859bcf9/3fb2cb58>
   f:   8b 7d 08                  mov    0x8(%ebp),%edi
Code;  f8a6d1a4 <_end+3859bcfc/3fb2cb58>
  12:   57                        push   %edi
Code;  f8a6d1a5 <_end+3859bcfd/3fb2cb58>
  13:   68 00 00 00 00            push   $0x0

 <0>Kernel panic: Fatal exception in interrupt
