Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263251AbTDCIAY>; Thu, 3 Apr 2003 03:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263257AbTDCIAY>; Thu, 3 Apr 2003 03:00:24 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:21758
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263251AbTDCIAW>; Thu, 3 Apr 2003 03:00:22 -0500
Date: Thu, 3 Apr 2003 03:07:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] smp_call_function needs mb() - oopsable
Message-ID: <Pine.LNX.4.50.0304030119270.29397-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 3 Processor Pentium 133 system w/ 512k external cache which is 
oopsing reliably in the exact same location. The problem is that the 
current memory barrier in smp_call_function is a simple gcc optimisation 
barrier, we really need a memory barrier there so that the other cpu's 
get the updated value when they get IPI'd immediately afterwards. The 
sequence looks like this;

cpu0					cpu1	
smp_call_function() {			...
	...				...
	call_data = &data		...
	send_IPI()			smp_call_function_interrupt() {
						func = call_data->func <== [1]

[1] at this point cpu1 loads memory, which hasn't been written back yet, 
to a local register.

0xc0114e30 <smp_call_function_interrupt>:       push   %esi
0xc0114e31 <smp_call_function_interrupt+1>:     mov    0xc02e9830,%eax
0xc0114e36 <smp_call_function_interrupt+6>:     push   %ebx
0xc0114e37 <smp_call_function_interrupt+7>:     mov    (%eax),%ecx
0xc0114e39 <smp_call_function_interrupt+9>:     mov    0x4(%eax),%edx
0xc0114e3c <smp_call_function_interrupt+12>:    mov    0x10(%eax),%esi
0xc0114e3f <smp_call_function_interrupt+15>:    xor    %eax,%eax
0xc0114e41 <smp_call_function_interrupt+17>:    xchg   %eax,0xffffd0b0
0xc0114e47 <smp_call_function_interrupt+23>:    lock addl $0x0,0x0(%esp,1)
0xc0114e4d <smp_call_function_interrupt+29>:    mov    0xc02e9830,%eax
0xc0114e52 <smp_call_function_interrupt+34>:    lock incl 0x8(%eax)
0xc0114e56 <smp_call_function_interrupt+38>:    mov    $0xffffe000,%ebx
0xc0114e5b <smp_call_function_interrupt+43>:    and    %esp,%ebx
0xc0114e5d <smp_call_function_interrupt+45>:    mov    0x14(%ebx),%eax
0xc0114e60 <smp_call_function_interrupt+48>:    add    $0x10000,%eax
0xc0114e65 <smp_call_function_interrupt+53>:    mov    %eax,0x14(%ebx)
0xc0114e68 <smp_call_function_interrupt+56>:    push   %edx
0xc0114e69 <smp_call_function_interrupt+57>:    call   *%ecx

The only reason i appear to be seeing this problem is probably due to 
cache controller hardware which is present in the box (old 'highend' MP 
server). I have been unable to reproduce this on much larger SMP boxes 
(saner cache coherency hardware).

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 11
cpu MHz         : 133.314
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic
bogomips        : 266.24

Patch against 2.5.66 appended.

Unable to handle kernel NULL pointer dereference at virtual address 00000200
 printing eip:
00000200
*pde = 00000000
Oops: 0000 [#1]
CPU:    2
EIP:    0060:[<00000200>]    Not tainted
EFLAGS: 00210082
EIP is at 0x200
eax: 00000026   ebx: c7666000   ecx: c7666000   edx: c7666000
esi: 00000200   edi: c034ad74   ebp: c0bc8000   esp: c7667fa8
ds: 007b   es: 007b   ss: 0068
Process rhn-applet (pid: 1654, threadinfo=c7666000 task=c0785340)
Stack: c0116407 c034ad74 40a2d760 08458490 00000004 bfffec78 c010a41a 40a2d760 
       00000000 00000000 08458490 00000004 bfffec78 0830d800 0000007b 0000007b 
       fffffffb 40a23da4 00000073 00200202 bfffec48 0000007b 
Call Trace:
 [<c0116407>] smp_call_function_interrupt+0x57/0xb0
 [<c034ad74>] sr_do_ioctl+0x124/0x250
 [<c010a41a>] call_function_interrupt+0x1a/0x20

Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!

Index: linux-2.5.66/arch/i386/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/arch/i386/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.5.66/arch/i386/kernel/smp.c	24 Mar 2003 23:40:27 -0000	1.1.1.1
+++ linux-2.5.66/arch/i386/kernel/smp.c	28 Mar 2003 05:08:54 -0000
@@ -522,7 +521,8 @@ int smp_call_function (void (*func) (voi
 
 	spin_lock(&call_lock);
 	call_data = &data;
-	wmb();
+	mb();
+	
 	/* Send a message to all other CPUs and wait for them to respond */
 	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 
