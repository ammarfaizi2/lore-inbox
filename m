Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280942AbRKORAb>; Thu, 15 Nov 2001 12:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280943AbRKORAV>; Thu, 15 Nov 2001 12:00:21 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:44551 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S280942AbRKORAE>;
	Thu, 15 Nov 2001 12:00:04 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 15 Nov 2001 17:55:31 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: kiobuf / vm bug
Message-ID: <20011115175531.A7068@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

I think I have found a kiobuf-related bug in the VM of recent linux
kernels.  2.4.13 is fine, 2.4.14-pre1 doesn't boot my machine,
2.4.14-pre2 + newer kernels are broken.

/me runs a kernel with a few v4l-related patches and my current 0.8.x
bttv version (available from http://bytesex.org/patches/ +
http://bytesex.org/bttv/).

With this kernel I can trigger the following BUG():


ksymoops 2.4.3 on i686 2.4.15-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre4/ (default)
     -m /boot/System.map-2.4.15-pre4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/modules/ide-disk.o) for ide-disk
Error (expand_objects): cannot stat(/modules/ide-probe-mod.o) for ide-probe-mod
Error (expand_objects): cannot stat(/modules/ide-mod.o) for ide-mod
Error (expand_objects): cannot stat(/modules/ext2.o) for ext2
Warning (map_ksym_to_module): cannot match loaded module ext2 to a unique module object.  Trace may not be reliable.
kernel BUG at page_alloc.c:84!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129e5b>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001f   ebx: c1f1e300   ecx: c01e22a0   edx: 00003528
esi: c1f1e300   edi: f94e2000   ebp: 00000000   esp: f3da7ebc
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 738, stackpage=f3da7000)
Stack: c01c0ee7 00000054 c1f1e300 00000000 f94e2000 00000000 f2ee69a0 f2ee69c4 
       00000000 f94e2060 f94e2000 c012a6f3 c0121120 f2ee69ec f2ee69a0 f94cdfa0 
       f94bd6d8 f94e2000 f2ee69ec f94c6b4e f2ee69ec f7ffb800 f2ee69ec f7ffb800 
Call Trace: [<c012a6f3>] [<c0121120>] [<f94cdfa0>] [<f94bd6d8>] [<f94c6b4e>] 
   [<f94cdfa0>] [<f94c3b3d>] [<f94cdfa0>] [<f94cdfa0>] [<f94c3c7c>] [<f94cdfa0>] 
   [<c0107f9d>] [<f94cdfa0>] [<c0108106>] 
Code: 0f 0b 83 c4 08 8b 46 18 a8 80 74 11 6a 56 68 e7 0e 1c c0 e8 

>>EIP; c0129e5a <__free_pages_ok+aa/29c>   <=====
Trace; c012a6f2 <__free_pages+1a/1c>
Trace; c0121120 <unmap_kiobuf+34/48>
Trace; f94cdfa0 <END_OF_CODE+156e2/????>
Trace; f94bd6d8 <.bss.end+4e1a/????>
Trace; f94c6b4e <END_OF_CODE+e290/????>
Trace; f94cdfa0 <END_OF_CODE+156e2/????>
Trace; f94c3b3c <END_OF_CODE+b27e/????>
Trace; f94cdfa0 <END_OF_CODE+156e2/????>
Trace; f94cdfa0 <END_OF_CODE+156e2/????>
Trace; f94c3c7c <END_OF_CODE+b3be/????>
Trace; f94cdfa0 <END_OF_CODE+156e2/????>
Trace; c0107f9c <handle_IRQ_event+30/5c>
Trace; f94cdfa0 <END_OF_CODE+156e2/????>
Trace; c0108106 <do_IRQ+6a/a8>
Code;  c0129e5a <__free_pages_ok+aa/29c>
00000000 <_EIP>:
Code;  c0129e5a <__free_pages_ok+aa/29c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129e5c <__free_pages_ok+ac/29c>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0129e5e <__free_pages_ok+ae/29c>
   5:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c0129e62 <__free_pages_ok+b2/29c>
   8:   a8 80                     test   $0x80,%al
Code;  c0129e64 <__free_pages_ok+b4/29c>
   a:   74 11                     je     1d <_EIP+0x1d> c0129e76 <__free_pages_ok+c6/29c>
Code;  c0129e66 <__free_pages_ok+b6/29c>
   c:   6a 56                     push   $0x56
Code;  c0129e68 <__free_pages_ok+b8/29c>
   e:   68 e7 0e 1c c0            push   $0xc01c0ee7
Code;  c0129e6c <__free_pages_ok+bc/29c>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0129e72 <__free_pages_ok+c2/29c>

 <0>Kernel panic: Aiee, killing interrupt handler!
cpu: 0, clocks: 1002240, slice: 501120

2 warnings and 4 errors issued.  Results may not be reliable.


The Oops seems to be triggered by the following actions:

(1) the application maps /dev/video0.  bttv 0.8.x simply returns some
    shared anonymous memory to as mapping.
(2) the application asks the driver to capture a frame.  bttv will lock
    down the anonymous memory using kiobufs for I/O and prepare
    everything for DMA xfer.
(3) The applications exits for some reason, i.e. the anonymous memory
    will be unmapped while the DMA transfer is active and the pages are
    locked down for I/O.
(4) The DMA xfer is done and bttv's irq handler cleans up everything.
    This includes calling unlock_kiovec+unmap_kiobuf for the locked
    pages.  The unmap_kiobuf call at this point triggeres the Oops
    listed above ...

Anyone has a idea what is going wrong here?

  Gerd

-- 
Gerd Knorr <kraxel@bytesex.org>
