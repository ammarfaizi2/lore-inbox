Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbTC1GDW>; Fri, 28 Mar 2003 01:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbTC1GDV>; Fri, 28 Mar 2003 01:03:21 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:60670
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262276AbTC1GDS>; Fri, 28 Mar 2003 01:03:18 -0500
Date: Fri, 28 Mar 2003 01:10:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] reproducible smp_call_function/_interrupt cache update
 race.
Message-ID: <Pine.LNX.4.50.0303280051250.2884-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
	I'm not quite sure how to describe this. I have a 3 Processor 
Pentium 133 system which has been oopsing reliably (i have over 5 of 
these oopses). What appears to be the problem is that the current memory 
barrier in smp_call_function is a simple gcc anti optimisation barrier, we 
really need a memory barrier there so that the other cpu's get the right 
value when they get IPI'd immediately afterwards. The system was going 
down reliably under my test load in under 5minutes, i have run with this 
patch for;

02:11:24  up 45 min,  5 users,  load average: 175.21, 174.89, 160.77

The patch has also been tested on 8way P3 700 (Shouldn't we be doing an
sfence there?). I wouldn't think performance regression would be an issue
seeing as it is slow path code. If would appreciate it if someone with 
more ia32 cache-fu could clue bat me if need be...

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
 
