Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268408AbTGIQmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbTGIQmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:42:55 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:51341 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S268408AbTGIQmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:42:47 -0400
Subject: [BUG][USB] 2.4.22-pre2
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Content-Type: text/plain
Message-Id: <1057769826.8465.30.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 09 Jul 2003 12:57:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Loading and using the pl2303 serial module works fine the first time,
but when you close the port the kernel goes oops.  Unplugging the
adapter makes life much worse - unfortunately, I can't find the message
in my logs :( but it streams an error about usb interrupts.  (I can
reproduce if needed).

Its dead simple to reproduce - plug a pl2303 in, open /dev/ttyUSB0 with
(eg) minicom or pppd, close it, check logs.

System seems stable after the crash.  Kernel has swsusp but this oops is
from a clean boot, before suspending/resuming.

This kernel has preempt and updated acpi; if that is a potential issue I
can build a stock -pre3 and try to reproduce.

ksymoops 2.4.8 on i686 2.4.22-pre2-dis5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre2-dis5/ (default)
     -m /boot/System.map-2.4.22-pre2-dis5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000014
e4d19794
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e4d19794>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210087
eax: d9ee8c00   ebx: ded0d880   ecx: 00000004   edx: 00000000
esi: d8b8cb80   edi: ded0d880   ebp: 00200292   esp: dc85be80
ds: 0018   es: 0018   ss: 0018
Process minicom (pid: 20629, stackpage=dc85b000)
Stack: ded0d880 d8b8cb80 00200282 ded0d884 e4d1a51b ded0d880 ded0d880 00000000
       c3d5d270 00000000 d7176c1c d7176c74 00000000 e28bd5fd ded0d880 e4d2846f
       ded0d880 e4d2933d 00000001 d7176c1c d7176c1c e29265a7 d7176c1c d6d33f00
Call Trace:    [<e4d1a51b>] [<e28bd5fd>] [<e4d2846f>] [<e4d2933d>] [<e29265a7>]
  [<e2926665>] [<c01c221e>] [<c0123283>] [<c014353a>] [<c0163130>] [<c01631cb>]
  [<c01c261f>] [<c0139f6c>] [<c01385bd>] [<c013863e>] [<c010915f>]
Code: 8b 52 14 83 ea 1c 8b 42 04 8b 5a 08 25 00 00 00 2f 0d 00 00


>>EIP; e4d19794 <[uhci]uhci_reset_interrupt+24/a0>   <=====

>>eax; d9ee8c00 <_end+19b6b580/225309e0>
>>ebx; ded0d880 <_end+1e990200/225309e0>
>>esi; d8b8cb80 <_end+1880f500/225309e0>
>>edi; ded0d880 <_end+1e990200/225309e0>
>>esp; dc85be80 <_end+1c4de800/225309e0>

Trace; e4d1a51b <[uhci]uhci_unlink_urb+14b/190>
Trace; e28bd5fd <[usbcore]usb_unlink_urb+3d/40>
Trace; e4d2846f <[pl2303]pl2303_close+df/1c0>
Trace; e4d2933d <[pl2303]__module_parm_desc_debug+25/e68>
Trace; e29265a7 <[usbserial]__serial_close+87/b0>
Trace; e2926665 <[usbserial]serial_close+95/c0>
Trace; c01c221e <release_dev+55e/5a0>
Trace; c0123283 <in_group_p+23/30>
Trace; c014353a <vfs_permission+8a/130>
Trace; c0163130 <ext3_lookup+0/b0>
Trace; c01631cb <ext3_lookup+9b/b0>
Trace; c01c261f <tty_release+f/20>
Trace; c0139f6c <fput+fc/120>
Trace; c01385bd <filp_close+4d/80>
Trace; c013863e <sys_close+4e/60>
Trace; c010915f <system_call+33/38>

Code;  e4d19794 <[uhci]uhci_reset_interrupt+24/a0>
00000000 <_EIP>:
Code;  e4d19794 <[uhci]uhci_reset_interrupt+24/a0>   <=====
   0:   8b 52 14                  mov    0x14(%edx),%edx   <=====
Code;  e4d19797 <[uhci]uhci_reset_interrupt+27/a0>
   3:   83 ea 1c                  sub    $0x1c,%edx
Code;  e4d1979a <[uhci]uhci_reset_interrupt+2a/a0>
   6:   8b 42 04                  mov    0x4(%edx),%eax
Code;  e4d1979d <[uhci]uhci_reset_interrupt+2d/a0>
   9:   8b 5a 08                  mov    0x8(%edx),%ebx
Code;  e4d197a0 <[uhci]uhci_reset_interrupt+30/a0>
   c:   25 00 00 00 2f            and    $0x2f000000,%eax
Code;  e4d197a5 <[uhci]uhci_reset_interrupt+35/a0>
  11:   0d 00 00 00 00            or     $0x0,%eax


1 warning issued.  Results may not be reliable.

-- 
Disconnect <lkml@sigkill.net>

