Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbSLMBWh>; Thu, 12 Dec 2002 20:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267584AbSLMBWh>; Thu, 12 Dec 2002 20:22:37 -0500
Received: from host217-39-30-89.in-addr.btopenworld.com ([217.39.30.89]:40576
	"EHLO dstc.edu.au") by vger.kernel.org with ESMTP
	id <S267583AbSLMBWa>; Thu, 12 Dec 2002 20:22:30 -0500
Message-Id: <200212130130.BAA19271@tereshkova.dstc.edu.au>
To: linux-kernel@vger.kernel.org
X-face: -[YGaR`*}M3pOPceHtP0Bb{\f!h4e?n{mXfI@DMKL-:8
Subject: [PANIC] 2.5.51: probably NFS-related
Date: Fri, 13 Dec 2002 01:30:19 +0000
From: Ted Phelps <phelps@dstc.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I generated the following panic on an NFS server machine (i586,
linux-2.5.51, SCSI HDD, Adaptec 29160 Host Adapter) whilst mounting
and unmounting an network filesystem on a client machine
(sparc-sun-solaris-2.8).  The backtrace doesn't seem to indicate
anything NFS-specific, but I'm inclined to suspect the NFS code due to
timing and previous troubles with NFSv3 between these machines.

Here's what I was doing on the client:

$ mount -o proto=udp,vers=2 192.168.0.1:/mnt/src /mnt/src
$ ls /mnt/src/bigdir
$ umount /mnt/src

$ mount -o proto=tcp,vers=2 192.168.0.1:/mnt/src /mnt/src
$ ls /mnt/src/bigdir
$ umount /mnt/src

$ mount -o proto=tcp,vers=3 192.168.0.1:/mnt/src /mnt/src
$ ls /mnt/src/bigdir
<<BOOM>>

/mnt/src/bigdir has 143 files in it, over 2K worth of filenames.


I have been unable to use with NFSv3 (UDP or TCP) to mount partitions
on the Solaris machine when the server is running 2.5.50 or 2.5.51.
The filesystem mounts, but listing /mnt/src/bigdir usually generates
the following error:

NFS readdirplus failed for server 192.168.0.1: error 2 (RPC: Can't decode result)

I can provide tcpdump output if that helps...

Thanks,
-Ted


ksymoops 2.4.8 on i586 2.4.19.  Options used
     -v /scratch/build/linux/linux-2.5.51/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.51/kernel (specified)
     -m /boot/System.map-2.5.51 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 2c6b6369
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c012e3c1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010012
eax: 6e6e6f43   ebx: c74ea020   ecx: c74ea0e0   edx: 2c6b6369
esi: c13e7460   edi: 00000000   ebp: c0375ef0   esp: c0375ed4
ds: 0068   es: 0068   ss: 0068
Stack: c13e746c c13e747c 00000008 c1337010 c13e7460 c1337000 00000008 c0375f2c 
       c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
       c0374000 c1337010 c13e74c8 c03dba9c c012dc60 00000000 c0375f34 c012dc68 
Call Trace:
 [<c012e609>] cache_reap+0x1a9/0x270
 [<c012dc60>] reap_timer_fnc+0x0/0x30
 [<c012dc68>] reap_timer_fnc+0x8/0x30
 [<c011d553>] __run_timers+0x83/0x170
 [<c01197e9>] do_softirq+0xa9/0xb0
 [<c010a835>] do_IRQ+0x125/0x150
 [<c0107130>] default_idle+0x0/0x40
 [<c0109418>] common_interrupt+0x18/0x20
 [<c0107130>] default_idle+0x0/0x40
 [<c0107158>] default_idle+0x28/0x40
 [<c01071dd>] cpu_idle+0x2d/0x40
 [<c0105000>] _stext+0x0/0x30
Code: 89 02 89 50 04 8b 43 0c 31 d2 29 c1 89 c8 f7 76 30 89 c1 8b 


>>EIP; c012e3c1 <__free_block+61/100>   <=====

>>ebp; c0375ef0 <init_thread_union+1ef0/2000>
>>esp; c0375ed4 <init_thread_union+1ed4/2000>

Trace; c012e609 <cache_reap+1a9/270>
Trace; c012dc60 <reap_timer_fnc+0/30>
Trace; c012dc68 <reap_timer_fnc+8/30>
Trace; c011d553 <__run_timers+83/170>
Trace; c01197e9 <do_softirq+a9/b0>
Trace; c010a835 <do_IRQ+125/150>
Trace; c0107130 <default_idle+0/40>
Trace; c0109418 <common_interrupt+18/20>
Trace; c0107130 <default_idle+0/40>
Trace; c0107158 <default_idle+28/40>
Trace; c01071dd <cpu_idle+2d/40>
Trace; c0105000 <_stext+0/0>

Code;  c012e3c1 <__free_block+61/100>
00000000 <_EIP>:
Code;  c012e3c1 <__free_block+61/100>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012e3c3 <__free_block+63/100>
   2:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012e3c6 <__free_block+66/100>
   5:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  c012e3c9 <__free_block+69/100>
   8:   31 d2                     xor    %edx,%edx
Code;  c012e3cb <__free_block+6b/100>
   a:   29 c1                     sub    %eax,%ecx
Code;  c012e3cd <__free_block+6d/100>
   c:   89 c8                     mov    %ecx,%eax
Code;  c012e3cf <__free_block+6f/100>
   e:   f7 76 30                  divl   0x30(%esi)
Code;  c012e3d2 <__free_block+72/100>
  11:   89 c1                     mov    %eax,%ecx
Code;  c012e3d4 <__free_block+74/100>
  13:   8b 00                     mov    (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!
       c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c0374000 
      c012e609 c13e7460 c1337010 00000008 c1331f8c c0374000 c0374000 c037400
