Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVAFAxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVAFAxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 19:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVAFAxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 19:53:22 -0500
Received: from CPE-139-168-157-43.nsw.bigpond.net.au ([139.168.157.43]:36600
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S262679AbVAFAxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 19:53:07 -0500
Message-ID: <41DC8BED.3020405@eyal.emu.id.au>
Date: Thu, 06 Jan 2005 11:53:01 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.10 IDE lockups
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to figure out if this is a problem with my system or
a kernel issue.

The symptom is that an IDE disk reports a DMA problem and then the
machine locks up hard (not even SysRq).

I ran an overnight memcheck and all was well.

Now, I cannot blame the software outright because a second disk
(hdb) was added about the time the problems started. Either the
disk is at fault or it just provoked a real software bug.

The new hdb is used strictly for mythtv, and looking at the
latest crash I can say with confidence that hdb had no activity.
It died at 09:20:01 and I was, naturally, still sleeping happily
at the time. Mythtv had no active clients and the log shows
an idle server. BTW, I has a 'sync' done every 10s to reduce
the damage, but I expect it had nothing to write to hdb.

I had lockups where hda reported an errors, and others where
hdb reported the error.

This showed up with 2.6.10, -ac3, -mm1 and -rc3-mm1. At times
I could even see an oops. Here are some snippets. How should I
proceed with the investigation?

Boot log
========
hda: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hda: DMA disabled
hdb: DMA disabled
hda: drive not ready for command
ide0: reset: success

and the system went on without DMA.

serial console
==============
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error

And the machine is dead. I saw this one most of the time

An unusual boot log with 2.6.10-rc3-mm1
===================
------------[ cut here ]------------
PREEMPT SMP
Modules linked in: ichxrom mtdcore chipreg map_funcs ehci_hcd usb_storage scsi_mod uhci_hcd usbcore shpchp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc parport evdev nls_cp437 msdos fat dm_mod rtc unix
CPU:    0
EIP:    0060:[__change_page_attr+412/425]    Not tainted VLI
EFLAGS: 00010002   (2.6.10-rc3-mm1)
EIP is at __change_page_attr+0x19c/0x1a9
eax: ffffffff   ebx: c2ff6000   ecx: c2ff6000   edx: 00000246
esi: 00000000   edi: 00000173   ebp: 00000246   esp: c3dcbf0c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2601, threadinfo=c3dcb000 task=f7b71a60)
Stack: 00000000 00500000 ffb00000 c2ff6000 00000000 00000000 00000246 c0116254         c2ff6000 00000173 ffb00000 f8a80000 00500000 c3dcb000 c0115dbd c2ff6000
        00000500 00000173 c19f0000 00000000 c3dcbf7f f880e2cd ffb00000 00500000
Call Trace:
  [change_page_attr+71/92] change_page_attr+0x47/0x5c
  [ioremap_nocache+147/170] ioremap_nocache+0x93/0xaa
  [pg0+943305421/1069069312] ichxrom_init_one+0x1a4/0x580 [ichxrom]
  [pci_find_device+47/51] pci_find_device+0x2f/0x33
  [pg0+944808020/1069069312] init_ichxrom+0x54/0x56 [ichxrom]
  [sys_init_module+367/542] sys_init_module+0x16f/0x21e
  [syscall_call+7/11] syscall_call+0x7/0xb
Code: fc fe ff ff 80 3e 00 78 15 29 d3 c1 fb 05 c1 e3 0c 09 fb 89 1e f0 ff 49 04 e9 f5 fe ff ff 0f 0b 82 00 44 4e 2d c0 e9 e8 fe ff ff <0f> 0b 6c 00 44 4e 2d c0 e9 71 fe ff ff 55 b8 18 b8 30 c0 57 31
  <6>note: modprobe[2601] exited with preempt_count 1
  [schedule+2904/2909] schedule+0xb58/0xb5d
  [zap_pgd_range+70/98] zap_pgd_range+0x46/0x62
  [cond_resched+39/60] cond_resched+0x27/0x3c
  [unmap_vmas+388/661] unmap_vmas+0x184/0x295
  [exit_mmap+165/400] exit_mmap+0xa5/0x190
  [mmput+67/246] mmput+0x43/0xf6
  [do_exit+424/1333] do_exit+0x1a8/0x535
  [do_trap+0/272] do_trap+0x0/0x110
  [do_invalid_op+0/195] do_invalid_op+0x0/0xc3
  [do_invalid_op+174/195] do_invalid_op+0xae/0xc3
  [buffered_rmqueue+294/586] buffered_rmqueue+0x126/0x24a
  [__change_page_attr+412/425] __change_page_attr+0x19c/0x1a9
  [__alloc_pages+596/1033] __alloc_pages+0x254/0x409
  [smp_call_function+196/272] smp_call_function+0xc4/0x110
  [__get_free_pages+51/63] __get_free_pages+0x33/0x3f
  [error_code+43/48] error_code+0x2b/0x30
  [__change_page_attr+412/425] __change_page_attr+0x19c/0x1a9
  [change_page_attr+71/92] change_page_attr+0x47/0x5c
  [ioremap_nocache+147/170] ioremap_nocache+0x93/0xaa
  [pg0+943305421/1069069312] ichxrom_init_one+0x1a4/0x580 [ichxrom]
  [pci_find_device+47/51] pci_find_device+0x2f/0x33
  [pg0+944808020/1069069312] init_ichxrom+0x54/0x56 [ichxrom]
  [sys_init_module+367/542] sys_init_module+0x16f/0x21e
  [syscall_call+7/11] syscall_call+0x7/0xb

But the machine continued the boot to completion.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	If attaching .zip rename to .dat
