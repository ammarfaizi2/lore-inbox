Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281410AbRKLKgc>; Mon, 12 Nov 2001 05:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281412AbRKLKgO>; Mon, 12 Nov 2001 05:36:14 -0500
Received: from [195.63.194.11] ([195.63.194.11]:61457 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281410AbRKLKf7>; Mon, 12 Nov 2001 05:35:59 -0500
Message-ID: <3BEFB261.700729A4@evision-ventures.com>
Date: Mon, 12 Nov 2001 12:28:33 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: PATCH 2.4.14 mregparm=3 compilation fixes
In-Reply-To: <E161SuY-000498-00@the-village.bc.nu> <3BEE7A34.BF9526FB@evision-ventures.com>
Content-Type: multipart/mixed;
 boundary="------------22691CBA00D1FBBBB3391630"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------22691CBA00D1FBBBB3391630
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello out there!

The attached patch is fixing compilation and running
of the kernel with -mregparm=3 on IA32. The fixes excluding
the change in arch/i386/Makefile of course apply to the stock kernel
as well, so Linus please include it in 2.4.15 - it just won't hurt...

Well the benchmarks I intended to do (i.e. the byte unix bench)
where not quite conclusive, so I include the results here just
for reference. They where done on a PIII Celeron notebook running
at 700 MHz with 192 of RAM.

- reparm3.report was gathered with the patch applied.

- report was probed without the patch applied.

Maybe someone with more time and who has the proper infrastructure at
hand may provide here some more fine grained tests? 

The patch itself turned out to be much smaller and simpler than
what I did expect. However the space savings are quite significant,
in esp. respective a so small change in the kernel...

BTW. The -pipe compiler options doesn't give any speed advantage
on systems where /tmp is on tmpfs anylonger!

Have fun!
--------------22691CBA00D1FBBBB3391630
Content-Type: text/plain; charset=us-ascii;
 name="mregparm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mregparm.patch"

diff -ur linux-2.4.14-2/arch/i386/Makefile linux-mdcki/arch/i386/Makefile
--- linux-2.4.14-2/arch/i386/Makefile	Thu Apr 12 21:20:31 2001
+++ linux-mdcki/arch/i386/Makefile	Sat Nov 10 00:07:17 2001
@@ -21,7 +21,7 @@
 LDFLAGS=-e stext
 LINKFLAGS =-T $(TOPDIR)/arch/i386/vmlinux.lds $(LDFLAGS)
 
-CFLAGS += -pipe
+CFLAGS += -freg-struct-return -mregparm=3
 
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(shell if $(CC) -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mpreferred-stack-boundary=2"; fi)
diff -ur linux-2.4.14-2/arch/i386/boot/compressed/misc.c linux-mdcki/arch/i386/boot/compressed/misc.c
--- linux-2.4.14-2/arch/i386/boot/compressed/misc.c	Fri Oct  5 03:42:54 2001
+++ linux-mdcki/arch/i386/boot/compressed/misc.c	Sat Nov 10 00:02:08 2001
@@ -9,6 +9,7 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+#include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
 #include <asm/io.h>
@@ -304,7 +305,7 @@
 	short b;
 	} stack_start = { & user_stack [STACK_SIZE] , __KERNEL_DS };
 
-void setup_normal_output_buffer(void)
+static void setup_normal_output_buffer(void)
 {
 #ifdef STANDARD_MEMORY_BIOS_CALL
 	if (EXT_MEM_K < 1024) error("Less than 2MB of memory.\n");
@@ -320,7 +321,7 @@
 	uch *high_buffer_start; int hcount;
 };
 
-void setup_output_buffer_if_we_run_high(struct moveparams *mv)
+static void setup_output_buffer_if_we_run_high(struct moveparams *mv)
 {
 	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
 #ifdef STANDARD_MEMORY_BIOS_CALL
@@ -342,7 +343,7 @@
 	mv->high_buffer_start = high_buffer_start;
 }
 
-void close_output_buffer_if_we_run_high(struct moveparams *mv)
+static void close_output_buffer_if_we_run_high(struct moveparams *mv)
 {
 	if (bytes_out > low_buffer_size) {
 		mv->lcount = low_buffer_size;
@@ -355,7 +356,7 @@
 }
 
 
-int decompress_kernel(struct moveparams *mv, void *rmode)
+asmlinkage int decompress_kernel(struct moveparams *mv, void *rmode)
 {
 	real_mode = rmode;
 
diff -ur linux-2.4.14-2/arch/i386/kernel/bluesmoke.c linux-mdcki/arch/i386/kernel/bluesmoke.c
--- linux-2.4.14-2/arch/i386/kernel/bluesmoke.c	Thu Oct 11 18:04:57 2001
+++ linux-mdcki/arch/i386/kernel/bluesmoke.c	Sat Nov 10 02:24:25 2001
@@ -100,11 +100,11 @@
 
 /*
  *	Call the installed machine check handler for this CPU setup.
- */ 
- 
+ */
+
 static void (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
-void do_machine_check(struct pt_regs * regs, long error_code)
+asmlinkage void do_machine_check(struct pt_regs * regs, long error_code)
 {
 	machine_check_vector(regs, error_code);
 }
diff -ur linux-2.4.14-2/arch/i386/math-emu/fpu_proto.h linux-mdcki/arch/i386/math-emu/fpu_proto.h
--- linux-2.4.14-2/arch/i386/math-emu/fpu_proto.h	Wed Dec 10 02:57:09 1997
+++ linux-mdcki/arch/i386/math-emu/fpu_proto.h	Sat Nov 10 02:31:22 2001
@@ -53,7 +53,7 @@
 extern void fst_i_(void);
 extern void fstp_i(void);
 /* fpu_entry.c */
-extern void math_emulate(long arg);
+asmlinkage extern void math_emulate(long arg);
 extern void math_abort(struct info *info, unsigned int signal);
 /* fpu_etc.c */
 extern void FPU_etc(void);
diff -ur linux-2.4.14-2/include/linux/kernel.h linux-mdcki/include/linux/kernel.h
--- linux-2.4.14-2/include/linux/kernel.h	Fri Nov  9 20:11:22 2001
+++ linux-mdcki/include/linux/kernel.h	Sun Nov 11 12:35:46 2001
@@ -51,7 +51,7 @@
 extern struct notifier_block *panic_notifier_list;
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
-NORET_TYPE void do_exit(long error_code)
+asmlinkage NORET_TYPE void do_exit(long error_code)
 	ATTRIB_NORET;
 NORET_TYPE void complete_and_exit(struct completion *, long)
 	ATTRIB_NORET;
diff -ur linux-2.4.14-2/kernel/sched.c linux-mdcki/kernel/sched.c
--- linux-2.4.14-2/kernel/sched.c	Fri Nov  9 19:56:42 2001
+++ linux-mdcki/kernel/sched.c	Sat Nov 10 02:07:01 2001
@@ -515,7 +515,7 @@
 #endif /* CONFIG_SMP */
 }
 
-void schedule_tail(struct task_struct *prev)
+asmlinkage void schedule_tail(struct task_struct *prev)
 {
 	__schedule_tail(prev);
 }

--------------22691CBA00D1FBBBB3391630
Content-Type: text/plain; charset=us-ascii;
 name="regparm3.report"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regparm3.report"


  BYTE UNIX Benchmarks (Version 3.11)
  System -- Linux kozaczek 2.4.14-mdcki #15 nie lis 11 12:35:45 CET 2001 i686 unknown
  Start Benchmark Run: nie lis 11 14:40:32 CET 2001
   1 interactive users.
Dhrystone 2 without register variables   1263066.6 lps   (10 secs, 6 samples)
Dhrystone 2 using register variables     1264480.5 lps   (10 secs, 6 samples)
Arithmetic Test (type = arithoh)         3179144.1 lps   (10 secs, 6 samples)
Arithmetic Test (type = register)        188804.1 lps   (10 secs, 6 samples)
Arithmetic Test (type = short)           190760.8 lps   (10 secs, 6 samples)
Arithmetic Test (type = int)             188823.6 lps   (10 secs, 6 samples)
Arithmetic Test (type = long)            189990.7 lps   (10 secs, 6 samples)
Arithmetic Test (type = float)           182915.1 lps   (10 secs, 6 samples)
Arithmetic Test (type = double)          183937.8 lps   (10 secs, 6 samples)
System Call Overhead Test                363784.1 lps   (10 secs, 6 samples)
Pipe Throughput Test                     415828.7 lps   (10 secs, 6 samples)
Pipe-based Context Switching Test        196984.2 lps   (10 secs, 6 samples)
Process Creation Test                      3378.5 lps   (10 secs, 6 samples)
Execl Throughput Test                       619.3 lps   (9 secs, 6 samples)
File Read  (10 seconds)                  1327798.0 KBps  (10 secs, 6 samples)
File Write (10 seconds)                  138593.0 KBps  (10 secs, 6 samples)
File Copy  (10 seconds)                   19076.0 KBps  (10 secs, 6 samples)
File Read  (30 seconds)                  1337240.0 KBps  (30 secs, 6 samples)
File Write (30 seconds)                  147663.0 KBps  (30 secs, 6 samples)
File Copy  (30 seconds)                   14968.0 KBps  (30 secs, 6 samples)
C Compiler Test                             388.7 lpm   (60 secs, 3 samples)
Shell scripts (1 concurrent)               1065.8 lpm   (60 secs, 3 samples)
Shell scripts (2 concurrent)                562.8 lpm   (60 secs, 3 samples)
Shell scripts (4 concurrent)                287.0 lpm   (60 secs, 3 samples)
Shell scripts (8 concurrent)                146.0 lpm   (60 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          28902.2 lpm   (60 secs, 6 samples)
Recursion Test--Tower of Hanoi            16393.7 lps   (10 secs, 6 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithmetic Test (type = double)               2541.7   183937.8       72.4
Dhrystone 2 without register variables       22366.3  1263066.6       56.5
Execl Throughput Test                           16.5      619.3       37.5
File Copy  (30 seconds)                        179.0    14968.0       83.6
Pipe-based Context Switching Test             1318.5   196984.2      149.4
Shell scripts (8 concurrent)                     4.0      146.0       36.5
                                                                 =========
     SUM of  6 items                                                 435.9
     AVERAGE                                                          72.6

--------------22691CBA00D1FBBBB3391630
Content-Type: text/plain; charset=iso-8859-1;
 name="report"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="report"


  BYTE UNIX Benchmarks (Version 3.11)
  System -- Linux kozaczek 2.4.14-2 #1 pi± lis 9 22:22:10 CET 2001 i686 unknown
  Start Benchmark Run: nie lis 11 16:10:53 CET 2001
   1 interactive users.
Dhrystone 2 without register variables   1263134.8 lps   (10 secs, 6 samples)
Dhrystone 2 using register variables     1263583.6 lps   (10 secs, 6 samples)
Arithmetic Test (type = arithoh)         3177830.7 lps   (10 secs, 6 samples)
Arithmetic Test (type = register)        189076.1 lps   (10 secs, 6 samples)
Arithmetic Test (type = short)           190665.1 lps   (10 secs, 6 samples)
Arithmetic Test (type = int)             188753.5 lps   (10 secs, 6 samples)
Arithmetic Test (type = long)            190094.2 lps   (10 secs, 6 samples)
Arithmetic Test (type = float)           182872.2 lps   (10 secs, 6 samples)
Arithmetic Test (type = double)          183902.9 lps   (10 secs, 6 samples)
System Call Overhead Test                360235.7 lps   (10 secs, 6 samples)
Pipe Throughput Test                     421456.7 lps   (10 secs, 6 samples)
Pipe-based Context Switching Test        194915.8 lps   (10 secs, 6 samples)
Process Creation Test                      3605.4 lps   (10 secs, 6 samples)
Execl Throughput Test                       608.6 lps   (9 secs, 6 samples)
File Read  (10 seconds)                  1294487.0 KBps  (10 secs, 6 samples)
File Write (10 seconds)                  138403.0 KBps  (10 secs, 6 samples)
File Copy  (10 seconds)                   19158.0 KBps  (10 secs, 6 samples)
File Read  (30 seconds)                  1278293.0 KBps  (30 secs, 6 samples)
File Write (30 seconds)                  147556.0 KBps  (30 secs, 6 samples)
File Copy  (30 seconds)                   15129.0 KBps  (30 secs, 6 samples)
C Compiler Test                             388.8 lpm   (60 secs, 3 samples)
Shell scripts (1 concurrent)               1063.2 lpm   (60 secs, 3 samples)
Shell scripts (2 concurrent)                563.1 lpm   (60 secs, 3 samples)
Shell scripts (4 concurrent)                287.4 lpm   (60 secs, 3 samples)
Shell scripts (8 concurrent)                145.7 lpm   (60 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          28576.1 lpm   (60 secs, 6 samples)
Recursion Test--Tower of Hanoi            16445.3 lps   (10 secs, 6 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithmetic Test (type = double)               2541.7   183902.9       72.4
Dhrystone 2 without register variables       22366.3  1263134.8       56.5
Execl Throughput Test                           16.5      608.6       36.9
File Copy  (30 seconds)                        179.0    15129.0       84.5
Pipe-based Context Switching Test             1318.5   194915.8      147.8
Shell scripts (8 concurrent)                     4.0      145.7       36.4
                                                                 =========
     SUM of  6 items                                                 434.5
     AVERAGE                                                          72.4

--------------22691CBA00D1FBBBB3391630--

