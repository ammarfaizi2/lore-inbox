Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279959AbRKIQOS>; Fri, 9 Nov 2001 11:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279973AbRKIQOI>; Fri, 9 Nov 2001 11:14:08 -0500
Received: from [62.144.170.218] ([62.144.170.218]:54788 "EHLO kommserv.eb.de")
	by vger.kernel.org with ESMTP id <S279968AbRKIQN6>;
	Fri, 9 Nov 2001 11:13:58 -0500
Date: Fri, 9 Nov 2001 16:11:18 GMT
Message-Id: <200111091611.QAA26283@dix.eb.de>
From: Thomas Braun <nospam@link-up.de>
To: linux-kernel@vger.kernel.org
Subject: Oops/Aiee in 2.4.14 when unloading PCMCIA modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get an oops every time when I stop PCMCIA with
    cardctl eject; killproc /sbin/cardmgr; lsmod
With a "sleep 2" before lsmod it does not happen. I tried kernel
2.4.1[34] with modutils 2.4.{2,10}, pcmcia-cs-3.1.29.

The lsmod before unloading:
Module                  Size  Used by
serial_cb               1268   1
tulip_cb               32608   2
cb_enabler              2720   4  [serial_cb tulip_cb]
ds                      6944   2  [cb_enabler]
i82365                 23312   2
pcmcia_core            43104   0  [cb_enabler ds i82365]
apm                     8768   1
ide-disk                6624   6
ide-probe-mod           7696   0
ide-mod                60460   6  [ide-disk ide-probe-mod]

The lspci for the PCMCIA card:
06:00.0 Non-VGA unclassified device: Xircom Cardbus Ethernet 10/100
        Flags: fast devsel, IRQ 9
        [virtual] I/O ports at 0200 [disabled]
        [virtual] Memory at 60013000 (32-bit, non-prefetchable) [disabled]
        [virtual] Memory at 60012000 (32-bit, non-prefetchable) [disabled]
        Expansion ROM at 6000c000 [disabled]

06:00.1 Non-VGA unclassified device: Xircom Cardbus Ethernet + 56k Modem
        Flags: fast devsel, IRQ 9
        [virtual] I/O ports at 0280 [disabled]
        [virtual] Memory at 60011000 (32-bit, non-prefetchable) [disabled]
        [virtual] Memory at 60010000 (32-bit, non-prefetchable) [disabled]
        Expansion ROM at 60008000 [disabled]

Below the ksymoops. (Is the compare_maps warning due to loading the ide
modules in initrd?) It is tainted from the PCMCIA modules.

I can make more tests if needed or provide more data.
Thanks for any help.

Regards,
Thomas

ksymoops 2.4.0 on i686 2.4.14a.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14a/ (default)
     -m /boot/System.map-2.4.14a (default)

Warning (compare_maps): mismatch on symbol ide_devfs_handle  , ide-mod says c8824be0, /lib/modules/2.4.14a/kernel/drivers/ide/ide-mod.o says c88240b0.  Ignoring /lib/modules/2.4.14a/kernel/drivers/ide/ide-mod.o entry
Warning (compare_maps): mismatch on symbol ide_hwifs  , ide-mod says c8822d40, /lib/modules/2.4.14a/kernel/drivers/ide/ide-mod.o says c8822210.  Ignoring /lib/modules/2.4.14a/kernel/drivers/ide/ide-mod.o entry
Warning (compare_maps): mismatch on symbol ide_probe  , ide-mod says c8822d20, /lib/modules/2.4.14a/kernel/drivers/ide/ide-mod.o says c88221f0.  Ignoring /lib/modules/2.4.14a/kernel/drivers/ide/ide-mod.o entry
Oops: 0002
CPU:    0
EIP:    0010:[<c011933c>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000ce0   ebx: 00001000   ecx: c778a510   edx: 00000610
esi: 00000002   edi: 00000000   ebp: c02165c0   esp: c6663f58
ds: 0018   es: 0018   ss: 0018
Process pcmcia (pid: 1003, stackpage=c6663000)
Stack: 00000000 c02165a0 00000000 c02165c0 c6663fc4 c01193cf c010ac96 c0116406
       c0116340 00000000 00000001 c02165c0 fffffffe c011616a c02165c0 00000000
       c0214900 00000000 c6663fbc 00000046 c010817d 00000000 080caa18 00000000
Call Trace: [<c01193cf>] [<c010ac96>] [<c0116406>] [<c0116340>] [<c011616a>]
   [<c010817d>] [<c0109f48>]
Code: 89 42 04 89 10 c7 41 04 00 00 00 00 c7 01 00 00 00 00 fb 53

>>EIP; c011933c <timer_bh+228/27c>   <=====
Trace; c01193cf <do_timer+3f/70>
Trace; c010ac96 <timer_interrupt+62/110>
Trace; c0116406 <bh_action+1a/48>
Trace; c0116340 <tasklet_hi_action+40/60>
Trace; c011616a <do_softirq+5a/ac>
Trace; c010817d <do_IRQ+a1/b4>
Trace; c0109f48 <call_do_IRQ+5/d>
Code;  c011933c <timer_bh+228/27c>
00000000 <_EIP>:
Code;  c011933c <timer_bh+228/27c>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c011933f <timer_bh+22b/27c>
   3:   89 10                     mov    %edx,(%eax)
Code;  c0119341 <timer_bh+22d/27c>
   5:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c0119348 <timer_bh+234/27c>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c011934e <timer_bh+23a/27c>
  12:   fb                        sti
Code;  c011934f <timer_bh+23b/27c>
  13:   53                        push   %ebx

 <0>Kernel panic: Aiee, killing interrupt handler!

3 warnings issued.  Results may not be reliable.
