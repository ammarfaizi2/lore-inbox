Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269025AbTBWXmr>; Sun, 23 Feb 2003 18:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269027AbTBWXmr>; Sun, 23 Feb 2003 18:42:47 -0500
Received: from daimi.au.dk ([130.225.16.1]:45544 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S269025AbTBWXmo>;
	Sun, 23 Feb 2003 18:42:44 -0500
Message-ID: <3E595ED3.5D86FE45@daimi.au.dk>
Date: Mon, 24 Feb 2003 00:52:51 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Panic in i810
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a reproducable kernel panic with different 2.4.x kernels.
I'm using XFree86-4.2.0-8 with a i810 onboard chipset. Sometimes
when I log off X the kernel panics. This can be reproduced by
loging in on a VC as root and typing:

while [ ! -f /tmp/stopit ] ; do
killall gdmlogin || killall gdm ; sleep 7 ; deallocvt
done

The panic first happened on a RH7.3 system with kernel version
2.4.18-19.7.x. I have no serial port so I had to type the panic
from the screen. That did BTW give me a lot of trouble, because
the flashing LEDs prevented my KVM switch from working correctly.
The last 24 lines of the panic is below.

I applied all updates and reproduced the problem with kernel
version 2.4.18-24.7.x. I have no panic dump though, sometimes
the screen is black when this panic happens (but judging from
the hsync and vsync it is in text mode).

I tried reproducing with 2.4.21-pre4 and netconsole. (I have no
serial port, so netconsole is my only option.) Unfortunately the
netconsole patch from http://people.redhat.com/mingo/netconsole-patches/
does not support my onboard sis900 ethernet chip. But I tried
making the same changes to the sis900 driver as this patch has
done to a few others. And it worked. (Might not be stable, but
worked well enough to catch the entire Oops and panic messages.)
The patch and the output is below.


This is the error messages from 2.4.18-19.7.x visible on the
screen:

esi: 04000001   edi: 0000000b   ebp: d11f3eb8   esp: d11f3e6c
ds: 0018   es: 0018   ss: 0018
Process X (pid: 1156, stackpage=d11f3000)
Stack: ce778ec0 04000001 c0109d5a 0000000b d27a8000 d11f3eb8 d11f3eb8 0000000b
       c0340a60 c1d13f40 c0109ef8 0000000b d11f3eb8 c1d13f40 c1281710 00000000
       c02d25bc 00000000 c010c308 c1281710 00000000 cb744000 00000000 c02d25bc
Call Trace: [<c0109d5a>] handle_IRQ_event [kernel] 0x3a (0xd11f3e74))
[<c0109ef8>] do_IRQ [kernel] 0x88 (0xd11f3e94))
[<c010c308>] call_do_IRQ [kernel] 0x5 (0xd11f3eb4))
[<c0114d1b>] flush_kernel_map [kernel] 0xb (0xd11f3ee0))
[<c0114fe9>] change_page_attr [kernel] 0x49 (0xd11f3eec))
[<d4dd5ee3>] agp_generic_destroy_page [agpart] 0x43 (0xd11f3f08))
[<d4dd547d>] agp_free_memory_R48653576 [agpart] 0x5d (0xd11f3f20))
[<d4e76a99>] i810_agp_free_memory [i810] 0x19 (0xd11f3f30))
[<d4e7ca5c>] i810_free_agp [i810] 0x2c (0xd11f3f38))
[<d4e7676d>] i810_agp_free [i810] 0xdd (0xd11f3f44))
[<d4e7a934>] i810_ioctl [i810] 0xe4 (0xd11f3f70))
[<c0146c97>] sys_ioctl [kernel] 0x217 (0xd11f3f94))
[<c010894b>] system_call [kernel] 0x33 (0xd11f3fc0))


Code: 8b 40 08 8b 50 10 0f b7 82 a4 20 00 00 25 ff 9f 00 00 74 55
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


This is the error messages from 2.4.21-pre4 dumped with
netconsole and passed through ksymoops. (The kernel is
tainted because of the missing module license in netconsole):

ksymoops 2.4.4 on i686 2.4.21-pre4-nc.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre4-nc/ (default)
     -m /boot/System.map-2.4.21-pre4-nc (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/reiserfs.o) for reiserfs
Warning (map_ksym_to_module): cannot match loaded module reiserfs to a unique module object.  Trace may not be reliable.
Unable to handle kernel NULL pointer dereference at virtual address 00000008
d4e8bb72
*pde = 11123067
Oops: 0000
CPU:    0
EIP:    0010:[<d4e8bb72>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013202
eax: 00000000   ebx: ce38d920   ecx: d2460000   edx: 0000c010
esi: 04000001   edi: 0000000b   ebp: d0e4fed4   esp: d0e4fe88
ds: 0018   es: 0018   ss: 0018
Process X (pid: 1432, stackpage=d0e4f000)
Stack: ce38d920 04000001 c0109d2a 0000000b d2460000 d0e4fed4 d0e4fed4 0000000b 
       c02a6a60 d3b1fbe0 c0109ea8 0000000b d0e4fed4 d3b1fbe0 c024a9d0 d023a000 
       000017f7 d2460000 c021af54 c024a9d0 c1306b00 00000001 d023a000 000017f7 
Call Trace:    [<c0109d2a>] [<c0109ea8>] [<c0110018>] [<c0127c7d>] [<d4de1ee0>]
  [<d4de1473>] [<d4e82ae9>] [<d4e88adc>] [<d4e8276d>] [<d4e86994>] [<c0141e27>]
  [<c0108923>]
Code: 8b 40 08 8b 50 10 0f b7 82 a4 20 00 00 25 ff 9f 00 00 74 55 

>>EIP; d4e8bb72 <[i810]i810_dma_service+12/80>   <=====
Trace; c0109d2a <handle_IRQ_event+3a/70>
Trace; c0109ea8 <do_IRQ+68/b0>
Trace; c0110018 <pcibios_setup+1a8/240>
Trace; c0127c7d <unlock_page+d/70>
Trace; d4de1ee0 <[agpgart]agp_generic_destroy_page+50/70>
Trace; d4de1473 <[agpgart]agp_free_memory+53/90>
Trace; d4e82ae9 <[i810]i810_agp_free_memory+19/20>
Trace; d4e88adc <[i810]i810_free_agp+2c/80>
Trace; d4e8276d <[i810]i810_agp_free+dd/100>
Trace; d4e86994 <[i810]i810_ioctl+e4/f0>
Trace; c0141e27 <sys_ioctl+177/190>
Trace; c0108923 <system_call+33/38>
Code;  d4e8bb72 <[i810]i810_dma_service+12/80>
00000000 <_EIP>:
Code;  d4e8bb72 <[i810]i810_dma_service+12/80>   <=====
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=====
Code;  d4e8bb75 <[i810]i810_dma_service+15/80>
   3:   8b 50 10                  mov    0x10(%eax),%edx
Code;  d4e8bb78 <[i810]i810_dma_service+18/80>
   6:   0f b7 82 a4 20 00 00      movzwl 0x20a4(%edx),%eax
Code;  d4e8bb7f <[i810]i810_dma_service+1f/80>
   d:   25 ff 9f 00 00            and    $0x9fff,%eax
Code;  d4e8bb84 <[i810]i810_dma_service+24/80>
  12:   74 55                     je     69 <_EIP+0x69> d4e8bbdb <[i810]i810_dma_service+7b/80>

 <0>Kernel panic: Aiee, killing interrupt handler!

2 warnings and 1 error issued.  Results may not be reliable.


The netconsole patch with my modifications is here:
http://www.daimi.au.dk/~kasperd/linux_kernel/netconsole-2.4.20.patch

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
