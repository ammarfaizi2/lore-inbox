Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbTAXTHt>; Fri, 24 Jan 2003 14:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbTAXTHt>; Fri, 24 Jan 2003 14:07:49 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:3825 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261836AbTAXTHr>;
	Fri, 24 Jan 2003 14:07:47 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15921.37163.139583.74988@harpo.it.uu.se>
Date: Fri, 24 Jan 2003 20:16:59 +0100
To: ak@suse.de
Subject: two x86_64 fixes for 2.4.21-pre3
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

1. The new IDE code in -pre references a few new macros and
   inlines from <asm/system.h> that x86_64 doesn't provide.
2. bootsect.S has the same bug that i386' bootsect.S had
   until I fixed it in 2.4.14 or so: it stops the floppy
   controller in a way that cause newer FDCs to lock up.
   The same patch as in i386' bootsect.S fixes the problem.

The x86_64 kernel boots RH8.0 fairly well, but the IA32 emulation
has some rough spots. In particular, "sleep" SEGVs with a #GP
every time, and sys32_ioctl() complains:

sleep[15] general protection rip:4004441c rsp:ffffed60 error:0
sys32_ioctl(hwclock:23): Unknown cmd fd(3) cmd(00004b50) arg(ffffeb50)
date[28] general protection rip:4002141c rsp:ffffebc0 error:0
date[30] general protection rip:400204ee rsp:ffffe4c4 error:0
sys32_ioctl(mount:62): Unknown cmd fd(4) cmd(80041272) arg(ffff6948)
sys32_ioctl(mount:62): Unknown cmd fd(4) cmd(80041272) arg(ffff6948)
sys32_ioctl(mount:69): Unknown cmd fd(4) cmd(80041272) arg(ffff6968)
sys32_ioctl(mount:69): Unknown cmd fd(4) cmd(80041272) arg(ffff6968)
rpmq[120] general protection rip:401c641c rsp:ffffed40 error:0
sleep[140] general protection rip:4003ebe5 rsp:ffffed60 error:0
sys32_ioctl(iwconfig:183): Unknown cmd fd(3) cmd(00008b01) arg(ffffea90)
sleep[196] general protection rip:4003ebe5 rsp:ffffed20 error:0

(The system is vanilla RH8.0 with Athlon binaries, running under
the Virtutech Simics 1.4.7 simulator. The x86_64 kernel was
cross-compiled with binutils-2.13.2.1 and gcc-3.2.1.)

/Mikael

--- linux-2.4.21-pre3/arch/x86_64/boot/bootsect.S.~1~	2002-11-30 17:12:24.000000000 +0100
+++ linux-2.4.21-pre3/arch/x86_64/boot/bootsect.S	2003-01-24 19:15:28.000000000 +0100
@@ -395,9 +395,15 @@
 # NOTE: Doesn't save %ax or %dx; do it yourself if you need to.
 
 kill_motor:
+#if 1
+	xorw	%ax, %ax		# reset FDC
+	xorb	%dl, %dl
+	int	$0x13
+#else
 	movw	$0x3f2, %dx
 	xorb	%al, %al
 	outb	%al, %dx
+#endif
 	ret
 
 sectors:	.word 0
--- linux-2.4.21-pre3/include/asm-x86_64/system.h.~1~	2003-01-24 14:03:58.000000000 +0100
+++ linux-2.4.21-pre3/include/asm-x86_64/system.h	2003-01-24 19:03:39.000000000 +0100
@@ -246,9 +246,14 @@
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 
+#define __save_and_cli(x)	do { __save_flags(x); __cli(); } while(0);
+#define __save_and_sti(x)	do { __save_flags(x); __sti(); } while(0);
+
 /* For spinlocks etc */
-#define local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
-#define local_irq_restore(x)	__asm__ __volatile__("# local_irq_restore \n\t pushq %0 ; popfq": /* no output */ :"g" (x):"memory")
+#define local_irq_save(x)	__save_and_cli(x)
+#define local_irq_set(x)	__save_and_sti(x)
+
+#define local_irq_restore(x)	__restore_flags(x)
 #define local_irq_disable()	__cli()
 #define local_irq_enable()	__sti()
 
@@ -262,6 +267,8 @@
 #define sti() __global_sti()
 #define save_flags(x) ((x)=__global_save_flags())
 #define restore_flags(x) __global_restore_flags(x)
+#define save_and_cli(x) do { save_flags(x); cli(); } while(0);
+#define save_and_sti(x) do { save_flags(x); sti(); } while(0);
 
 #else
 
@@ -269,6 +276,8 @@
 #define sti() __sti()
 #define save_flags(x) __save_flags(x)
 #define restore_flags(x) __restore_flags(x)
+#define save_and_cli(x) __save_and_cli(x)
+#define save_and_sti(x) __save_and_sti(x)
 
 #endif
 
