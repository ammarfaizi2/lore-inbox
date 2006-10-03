Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWJCCPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWJCCPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 22:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWJCCPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 22:15:16 -0400
Received: from xenotime.net ([66.160.160.81]:21466 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030246AbWJCCPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 22:15:13 -0400
Date: Mon, 2 Oct 2006 19:16:38 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Linus Torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
Message-Id: <20061002191638.093fde85.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	<p73venk2sjw.fsf@verdi.suse.de>
	<9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
	<Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 15:01:08 -0700 (PDT) Linus Torvalds wrote:

> On Tue, 19 Sep 2006, Jesper Juhl wrote:
> > 
> > The config is attached.
> 
> Can you try without SMP, and with CONFIG_X86_GENERIC (the latter to make 
> sure that we don't do any static optimizations: right now you've told the 
> compile system that you're compiling for an Opteron, and while I _think_ 
> all the SSE optimizations are dynamic at run-time, I haven't checked 
> extensively.

I had no trouble reproducing the boot failure (on Pentium-M), then
I tried TRACE_RESUME().  Nifty, but not really needed here since
earlyprintk worked and contained the fault messages:

[   16.776035] Kernel command line: auto BOOT_IMAGE=lin2618-jj ro root=808 resume=/dev/sda6 splash=silent showopts netconsole=6665@192.168.0.104/eth0,6666@192.168.0.101/00:13:20:e3:97:02 console=ttyS0,115200n8 console=tty0 earlyprintk=serial,ttyS0,115200 initcall_debug debug no387 nofxsr
[   16.801176] netconsole: local port 6665
[   16.804916] netconsole: local IP 192.168.0.104
[   16.809321] netconsole: interface eth0
[   16.813037] netconsole: remote port 6666
[   16.816926] netconsole: remote IP 192.168.0.101
[   16.821418] netconsole: remote ethernet address 00:13:20:e3:97:02
[   16.827663] Enabling fast FPU save and restore... done.
[   16.832704] Enabling unmasked SIMD FPU exception support... done.
[   16.838753] Initializing CPU#0
[   16.841784] math_emulate: 0060:c01062dd
[   16.845579] Kernel panic - not syncing: Math emulation needed in kernel

But CONFIG_MATH_EMULATION=y, so what now?

The panic message is for this:

  else if ( FPU_CS == __KERNEL_CS )
    {
      printk("math_emulate: %04x:%08lx\n",FPU_CS,FPU_EIP);
      panic("Math emulation needed in kernel");
    }

but that doesn't look like a real problem.

Linus mentioned CPU feature bits.  The message log above didn't
make me feel good about them.  Sure enough, we are playing with
features before reading the feature bits.

So, I have a patch that now boots with "no387 nofxsr".
It mixes some sauce into the spaghetti code during init.
The system is somewhat usable.  Network device (tg3) works,
but USB complains about everything and the X driver won't load,
so I don't think that the patch is finished.  :)

and I strongly wish that bugs.h didn't contain ("hide") so
much code.

---
From: Randy Dunlap <rdunlap@xenotime.net>

Math (floating point) emulation has been broken for awhile.
The primary reason for this is that CPU feature bits have
not been read/set yet when they are tested/used, due to
ordering changes in init/main.c.

Changes here:
This is a twisted maze of dependencies.
check_bugs() in init/main.c calls identify_cpu() (the
real CPU ident workhorse) much too late.  Now call
identify_cpu(for the boot cpu) from trap_init().
Still call identify_cpu(for other cpus) from smp_store_cpu_info(),
but add a call here to (new) finish_cpu_setup(&cpu_data)
for setup code that can be done later rather than earlier.
Note:  identify_cpu() wants to know loops_per_jiffy,
so if it is 0, call calibrate_delay() to get it.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/kernel/cpu/common.c |   11 +++++++++++
 arch/i386/kernel/smpboot.c    |    4 +++-
 arch/i386/kernel/traps.c      |    2 ++
 include/asm-i386/bugs.h       |    1 -
 include/linux/smp.h           |    6 ++++++
 init/main.c                   |    2 ++
 6 files changed, 24 insertions(+), 2 deletions(-)

--- linux-2618-g18.orig/arch/i386/kernel/cpu/common.c
+++ linux-2618-g18/arch/i386/kernel/cpu/common.c
@@ -355,6 +355,8 @@ void __cpuinit identify_cpu(struct cpuin
 {
 	int i;
 
+	if (!loops_per_jiffy)
+		calibrate_delay();
 	c->loops_per_jiffy = loops_per_jiffy;
 	c->x86_cache_size = -1;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
@@ -461,7 +463,11 @@ void __cpuinit identify_cpu(struct cpuin
 
 	/* Init Machine Check Exception if available. */
 	mcheck_init(c);
+}
 
+/* after kmem_cache_init => kmalloc works */
+void __cpuinit finish_cpu_setup(struct cpuinfo_x86 *c)
+{
 	if (c == &boot_cpu_data)
 		sysenter_setup();
 	enable_sep_cpu();
@@ -472,6 +478,11 @@ void __cpuinit identify_cpu(struct cpuin
 		mtrr_ap_init();
 }
 
+void __cpuinit finish_boot_cpu_setup(void)
+{
+	finish_cpu_setup(&boot_cpu_data);
+}
+
 #ifdef CONFIG_X86_HT
 void __cpuinit detect_ht(struct cpuinfo_x86 *c)
 {
--- linux-2618-g18.orig/arch/i386/kernel/traps.c
+++ linux-2618-g18/arch/i386/kernel/traps.c
@@ -1249,6 +1249,8 @@ void __init trap_init(void)
 #endif
 	set_trap_gate(19,&simd_coprocessor_error);
 
+	identify_cpu(&boot_cpu_data);
+
 	if (cpu_has_fxsr) {
 		/*
 		 * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
--- linux-2618-g18.orig/include/asm-i386/bugs.h
+++ linux-2618-g18/include/asm-i386/bugs.h
@@ -180,7 +180,6 @@ extern void alternative_instructions(voi
 
 static void __init check_bugs(void)
 {
-	identify_cpu(&boot_cpu_data);
 #ifndef CONFIG_SMP
 	printk("CPU: ");
 	print_cpu_info(&boot_cpu_data);
--- linux-2618-g18.orig/arch/i386/kernel/smpboot.c
+++ linux-2618-g18/arch/i386/kernel/smpboot.c
@@ -159,8 +159,10 @@ static void __devinit smp_store_cpu_info
 	struct cpuinfo_x86 *c = cpu_data + id;
 
 	*c = boot_cpu_data;
-	if (id!=0)
+	if (id != 0) {
 		identify_cpu(c);
+		finish_cpu_setup(c);
+	}
 	/*
 	 * Mask B, Pentium, but not Pentium MMX
 	 */
--- linux-2618-g18.orig/include/linux/smp.h
+++ linux-2618-g18/include/linux/smp.h
@@ -130,4 +130,10 @@ static inline void smp_send_reschedule(i
 
 void smp_setup_processor_id(void);
 
+/*
+ * finish the boot CPU setup:
+ * allows kmalloc etc., which is not possible during identify_cpu().
+ */
+void finish_boot_cpu_setup(void);
+
 #endif /* __LINUX_SMP_H */
--- linux-2618-g18.orig/init/main.c
+++ linux-2618-g18/init/main.c
@@ -49,6 +49,7 @@
 #include <linux/buffer_head.h>
 #include <linux/debug_locks.h>
 #include <linux/lockdep.h>
+#include <linux/smp.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -570,6 +571,7 @@ asmlinkage void __init start_kernel(void
 	cpuset_init_early();
 	mem_init();
 	kmem_cache_init();
+	finish_boot_cpu_setup();
 	setup_per_cpu_pageset();
 	numa_policy_init();
 	if (late_time_init)
