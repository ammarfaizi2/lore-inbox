Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSKYMwV>; Mon, 25 Nov 2002 07:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSKYMwV>; Mon, 25 Nov 2002 07:52:21 -0500
Received: from elin.scali.no ([62.70.89.10]:64273 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S263137AbSKYMwT>;
	Mon, 25 Nov 2002 07:52:19 -0500
Date: Mon, 25 Nov 2002 14:01:03 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Hard lockup in tg3 driver on Dell 2650
Message-ID: <Pine.LNX.4.44.0211251344330.5004-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've tested out some Dell 2650s with onboard dual Broadcom NetXtreme 
BCM5701 Gigabit Ethernet controllers. The boxes are running the 2.4.20-rc2 
(tg3 driver is version 1.2 from 14th of November) with kdb patch (Keith 
Owens) and the irq balancing patch (Ingo Molnar). They are also booted 
with NMI watchdog (because I experienced lockups).

When I try to benchmark the adapters (doesn't matter which one)  with 
netpipe-2.4 (NPtcp) I get a hard lockup around 256k messages. Because of 
the NMI watchdog it triggers kdb :

NMI Watchdog detected LOCKUP on CPU1, eip f895ded6, registers:
CPU:    1
EIP:    0010:[<f895ded6>]    Tainted: PF
EFLAGS: 00000086
eax: f692dd60   ebx: f5e6e580   ecx: f7fc3ebc   edx: f5db3000
esi: f692dc00   edi: 04000001   ebp: f7fc3e6c   esp: f7fc3e54
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=f7fc3000)
Stack: 00000006 00000292 f692dd60 f5e6e580 00000001 04000001 f7fc3e8c c010a900
       0000001d f692dc00 f7fc3ebc f7fc3ebc c0358680 0000001d f7fc3eb4 c010ab14
       0000001d f7fc3ebc f5e6e580 f5e6e580 00000001 00000202 f692dd60 f692dc00
Call Trace:    [<c010a900>] [<c010ab14>] [<f89578b0>] [<c01e89d0>] [<c011f41b>]
  [<c010ab51>] [<c0107040>] [<c0107040>] [<c010706c>] [<c0107102>] [<c011ad9b>]
  [<c011b056>]

Code: 7e f9 e9 20 9a ff ff 80 3b 00 f3 90 7e f9 e9 90 9b ff ff 80
console shuts up ...

Entering kdb (current=0xf7fc2000, pid 0) on processor 1 due to NonMaskable 
Interrupt @ 0xf895ded6
eax = 0xf692dd60 ebx = 0xf5e6e580 ecx = 0xf7fc3ebc edx = 0xf5db3000
esi = 0xf692dc00 edi = 0x04000001 esp = 0xf7fc3e54 eip = 0xf895ded6
ebp = 0xf7fc3e6c xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000086
xds = 0xf79a0018 xes = 0x00000018 origeax = 0xf692dd60 &regs = 0xf7fc3e20
[1]kdb> bt
0xf7fc2000 00000000 00000000  1  001  run   0xf7fc2370*swapper
EBP        EIP        Function (args)
           0xf895ded6 [tg3].text.lock.tg3+0x45
                               tg3 .text 0xf8955060 0xf895de91 0xf895e0d0
0xf7fc3e6c 0xf89578fd [tg3]tg3_interrupt+0x1d (0x1d, 0xf692dc00, 0xf7fc3ebc, 0xf7fc3ebc, 0xc0358680)
                               tg3 .text 0xf8955060 0xf89578e0 0xf8957a60
0xf7fc3e8c 0xc010a900 handle_IRQ_event+0x50 (0x1d, 0xf7fc3ebc, 0xf5e6e580, 0xf5e6e580, 0x1)
                               kernel .text 0xc0100000 0xc010a8b0 
0xc010a930
0xf7fc3eb4 0xc010ab14 do_IRQ+0xa4 (0x202, 0xf692dcc0, 0x68, 0xf692dd60, 0xf692dc00)
                               kernel .text 0xc0100000 0xc010aa70 
0xc010ab60
0xf7fc3f00 0xc023fb74 call_do_IRQ+0x5 (0xc036ab10, 0x46, 0x1, 0xf7fc3f70, 0xc0358680)
                               kernel .rodata 0xc0230200 0xc023fb6f 
0xc023fb7c
           0xc011f41b do_softirq+0x7b (0xf5e6e580, 0x80, 0xf7fc2000, 0xc0107040, 0xf7fc2000)
                               kernel .text 0xc0100000 0xc011f3a0 
0xc011f480
0xf7fc3f68 0xc010ab51 do_IRQ+0xe1 (0xf7fc2000, 0xffffe000, 0xf7fc2000, 0xc0107040, 0xf7fc2000)
                               kernel .text 0xc0100000 0xc010aa70 
0xc010ab60
0xf7fc3fa4 0xc023fb74 call_do_IRQ+0x5 (0x601080b, 0x0, 0x0)
                               kernel .rodata 0xc0230200 0xc023fb6f 
0xc023fb7c
           0xc0107102 cpu_idle+0x52
                               kernel .text 0xc0100000 0xc01070b0 
0xc0107120
0xf7fc3fc0 0xc0341156 start_secondary+0x26
                               kernel .text.init 0xc033a000 0xc0341130 
0xc0341160



It seems like there's a deadlock in the interrupt handler (the 
spin_lock_irqsave(&tp->lock, flags); ). I checked the other CPU but it was 
idle (i.e not holding the same spinlock).

This problem is always reproducible...

Regards,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY


