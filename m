Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262316AbRFBJV6>; Sat, 2 Jun 2001 05:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbRFBJVj>; Sat, 2 Jun 2001 05:21:39 -0400
Received: from host213-123-127-165.btopenworld.com ([213.123.127.165]:6668
	"EHLO argo.dyndns.org") by vger.kernel.org with ESMTP
	id <S262316AbRFBJV2>; Sat, 2 Jun 2001 05:21:28 -0400
X-test: X
To: linux-kernel@vger.kernel.org
From: lk@mailandnews.com
Subject: CUV4X-D lockup on boot
Date: 02 Jun 2001 10:21:26 +0100
Message-ID: <m31yp3qlt5.fsf@fork.man2.dom>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ASUS CUV4X-D Dual Processor Mainboard based on a VIA
694XDP chipset. I notice from the archives that someone else
has also reported a lockup with the m/b when using two cpus
and have some info that may be useful to track it down.

Using kernel 2.4.5 the kernel locks up sporadically at boot
time. When I enable the NMI watchdog it occasionally gets
enabled prior to the lockup and perhaps can be useful for
debugging the problem. Here's what happens:

I typed this in, so there may be typos:
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
[locks up here, or before activating NMI watchdog]
[this normally happens next but not in this case
 number of MP IRQ sources: 21.
 number of IO-APIC #2 registers: 24.
 testing the IO APIC.......................
]
NMI Watchdog detected LOCKUP on CPU1, registers:
CPU : 1
EIP: 0010:[<c0235cdb>]
EFLAGS: 00000246
eax: 00000000 ebx: 00000000 ecx: 00000001 edx: 00000001
esi: 00000000 edi: 00000000 ebp: 00000000 esp: cfff5fa4
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage = cfff5000)
Stack: 00000000 00000000 00000000 00000000 c0235e8f 00000001 00000002 c0235eaa
       00000000 00000019 00000000 c1442000 00002700 0000b00f 00000000 00000000
       0000000d 0000000e 00000000 00000000 c00bcf60 00000000 c0172029
Call Trace: [<c0172029>]
Code: 85 c0 74 bf 00 e0 ff ff 21 e7 31 f6 bd 10 00 00 00 31 db
Console shuts up ...

[ksymoops output]
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
activating NMI Watchdog ... done.
[locks up here, or before activating NMI watchdog]
NMI Watchdog detected LOCKUP on CPU1, registers:
EIP: 0010:[<c0235cdb>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000246
eax: 00000000 ebx: 00000000 ecx: 00000001 edx: 00000001
esi: 00000000 edi: 00000000 ebp: 00000000 esp: cfff5fa4
ds: 0018 es: 0018 ss: 0018
Stack: 00000000 00000000 00000000 00000000 c0235e8f 00000001 00000002 c0235eaa
       00000000 00000019 00000000 c1442000 00002700 0000b00f 00000000 00000000
       0000000d 0000000e 00000000 00000000 c00bcf60 00000000 c0172029
Call Trace: [<c0172029>]
Code: 85 c0 74 bf 00 e0 ff ff 21 e7 31 f6 bd 10 00 00 00 31 db

>>EIP; c0235cdb <synchronize_tsc_ap+1b/a0>   <=====
Trace; c0172029 <set_cursor+69/80>
Code;  c0235cdb <synchronize_tsc_ap+1b/a0>
00000000 <_EIP>:
Code;  c0235cdb <synchronize_tsc_ap+1b/a0>   <=====
   0:   85 c0                     test   %eax,%eax   <=====
Code;  c0235cdd <synchronize_tsc_ap+1d/a0>
   2:   74 bf                     je     ffffffc3 <_EIP+0xffffffc3> c0235c9e <synchronize_tsc_bp+1ee/210>
Code;  c0235cdf <synchronize_tsc_ap+1f/a0>
   4:   00 e0                     add    %ah,%al
Code;  c0235ce1 <synchronize_tsc_ap+21/a0>
   6:   ff                        (bad)  
Code;  c0235ce2 <synchronize_tsc_ap+22/a0>
   7:   ff 21                     jmp    *(%ecx)
Code;  c0235ce4 <synchronize_tsc_ap+24/a0>
   9:   e7 31                     out    %eax,$0x31
Code;  c0235ce6 <synchronize_tsc_ap+26/a0>
   b:   f6 bd 10 00 00 00         idiv   0x10(%ebp),%al
Code;  c0235cec <synchronize_tsc_ap+2c/a0>
  11:   31 db                     xor    %ebx,%ebx


2 warnings issued.  Results may not be reliable.

# cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 937.557
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1867.77

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 937.557
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1874.32

If this doesn't make someone go "aha!" then I can set up a serial
port for debugging and repeat this a few times.

Thanks,

Paul




