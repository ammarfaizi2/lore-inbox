Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTECBkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 21:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbTECBj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 21:39:59 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:52134 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263225AbTECBjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 21:39:54 -0400
Date: Fri, 2 May 2003 21:50:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH][Experimental] Debugging i386 using hardware task
  switching
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305022152_MC3-1-3721-4272@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  This patch implements i386 debugging with hardware task switching.  So far
it can take snapshots of either kernel or user CPU state and can be used to
time events, again in kernel or user space.  Overhead for taking a snapshot
is about 1000 clocks on PPro 200. Snapshots are taken by placing an 'int 3'
in the code, causing a switch to the debugger TSS which automatically
saves the CPU state in the kernel TSS.  The handler then reads the TSC and
computes clocks elapsed since last invocation, then returns immediately and
the invoking code continues at the next instruction.  Everything is per-cpu
including a 1-page ring buffer for storing events (not currently used.)

  So far it has survived two concurrent copies of this program executing
on SMP:

        main() {
                for (;;) asm("int $3;");
        }

The timer shows 0x3e4 clocks per loop here on uniprocessor and the system
behaves just fine while this is running.

  It also works in kernel mode, tested with this patch, which times how
long __ide_dma_end takes to execute (0x6b0 clocks including debugger overhead):
================================================================================
diff -u --exclude-from=/home/me/.exclude -r 68r/drivers/ide/pci/pdc202xx_old.c 68d/drivers/ide/pci/pdc202xx_old.c
--- 68r/drivers/ide/pci/pdc202xx_old.c  Sat Mar 29 09:16:33 2003
+++ 68d/drivers/ide/pci/pdc202xx_old.c  Fri May  2 20:25:46 2003
@@ -557,6 +557,8 @@
 
 static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
 {
+       int ret;
+       
        if (drive->addressing == 1) {
                ide_hwif_t *hwif        = HWIF(drive);
 //             unsigned long high_16   = pci_resource_start(hwif->pci_dev, 4);
@@ -568,7 +570,12 @@
                clock = hwif->INB(high_16 + 0x11);
                hwif->OUTB(clock & ~(hwif->channel ? 0x08:0x02), high_16+0x11);
        }
-       return __ide_dma_end(drive);
+
+       asm("int $3;");
+       ret = __ide_dma_end(drive);
+       asm("int $3;");
+
+       return ret;
 }
 
 static int pdc202xx_old_ide_dma_test_irq(ide_drive_t *drive)
================================================================================

   Known bugs:

        Invoking this with currently-invalid segment registers
                will cause Bad Things to happen.

   Patch itself is against vanilla 2.5.68:

================================================================================
 arch/i386/kernel/Makefile     |    2 
 arch/i386/kernel/cpu/common.c |   13 +++++-
 arch/i386/kernel/debug.c      |   85 ++++++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/traps.c      |    4 +
 include/asm-i386/processor.h  |    8 ++-
 include/asm-i386/segment.h    |    4 +
 6 files changed, 108 insertions(+), 8 deletions(-)
================================================================================
diff -u --exclude-from=/home/me/.exclude -rN a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile Sat Mar 29 09:16:21 2003
+++ b/arch/i386/kernel/Makefile Wed Apr 30 18:49:50 2003
@@ -7,7 +7,7 @@
 obj-y  := process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
                ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
                pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-               doublefault.o
+               doublefault.o debug.o
 
 obj-y                          += cpu/
 obj-y                          += timers/
diff -u --exclude-from=/home/me/.exclude -rN a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c     Sun Apr 20 06:26:50 2003
+++ b/arch/i386/kernel/cpu/common.c     Wed Apr 30 22:23:15 2003
@@ -20,6 +20,11 @@
 
 extern int disable_pse;
 
+extern unsigned long debug_stack[NR_CPUS][256];
+extern struct tss_struct debug_tss[NR_CPUS];
+extern struct tss_struct init_debug_tss;
+extern void debug_fn(void);
+
 static void default_init(struct cpuinfo_x86 * c)
 {
        /* Not much we can do here... */
@@ -491,13 +496,17 @@
 
        load_esp0(t, thread->esp0);
        set_tss_desc(cpu,t);
-       cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
        load_TR_desc();
        load_LDT(&init_mm.context);
 
        /* Set up doublefault TSS pointer in the GDT */
        __set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
-       cpu_gdt_table[cpu][GDT_ENTRY_DOUBLEFAULT_TSS].b &= 0xfffffdff;
+
+       /* Set up debug TSS pointer in the GDT */
+       memcpy(&debug_tss[cpu], &init_debug_tss, sizeof(init_debug_tss));
+       /* FIXME const 256 */
+       debug_tss[cpu].esp0 = debug_tss[cpu].esp = debug_stack[cpu] + 256;
+       __set_tss_desc(cpu, GDT_ENTRY_DEBUG_TSS, debug_tss + cpu);
 
        /* Clear %fs and %gs. */
        asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
diff -u --exclude-from=/home/me/.exclude -rN a/arch/i386/kernel/debug.c b/arch/i386/kernel/debug.c
--- a/arch/i386/kernel/debug.c  Wed Dec 31 19:00:00 1969
+++ b/arch/i386/kernel/debug.c  Fri May  2 15:25:45 2003
@@ -0,0 +1,85 @@
+#include <linux/mm.h>
+#include <linux/threads.h>
+
+#include <asm/desc.h>
+
+/* FIXME #define size */
+static unsigned long debug_buffer[NR_CPUS][1024]; /* one page per cpu */
+/*
+ * Buffer layout:
+ *     0-15   work area
+ *     16-end  ring buffer for events
+ */
+
+unsigned long debug_stack[NR_CPUS][256];
+struct tss_struct debug_tss[NR_CPUS] __cacheline_aligned;
+
+void debug_fn(void)
+{
+       /*
+        * Initialize the handler here.  Save as much state as possible
+        * in regs since they are restored by task switch.
+        *
+        *          ebp -> per-cpu buffer
+        *          edi -> offset into buffer
+        *          esi -> #calls
+        *          ebx -> GDT
+        *      edx:eax -> last tsc
+        *          ecx -> 32-bit tsc delta
+        */
+       
+       asm("movl %0,%%ebp": :"r" (debug_buffer + smp_processor_id()));
+
+       asm("sgdtl 2(%ebp);"
+           "movl  4(%ebp),%ebx;"
+           "movl  $16,%edi;");         /* edi -> GDT */
+
+       /*
+        * Now handle the event.  May want to init separately with int3
+        * from kernel during setup. If so, remove this goto.
+        */
+       goto debug_handler;
+       
+debug_return:
+       /*
+        * Verify the kernel TSS:
+        *   - invalid fs,gs -> 0
+        *   -    "    ds,es -> __USER_DS
+        *   -    "    cs,ss -> ?
+        */
+        
+       /* FIXME: kernel TSS is at GDT+128 */
+
+       asm("iret");
+
+debug_handler:
+       /*
+        * Do something...
+        */
+       
+       asm("movl %eax,(%ebp)");        /* save old tsc                 */
+       asm("rdtsc");                   /* FIXME: must be supported     */ 
+       asm("movl %eax,%ecx");
+       asm("subl (%ebp),%ecx");        /* ecx = tsc delta              */
+       asm("incl %esi");               /* esi = counter                */
+       
+       goto debug_return;
+}
+
+struct tss_struct init_debug_tss = {
+       .esp0           = 0,            /* percpu */
+       .ss0            = __KERNEL_DS,
+       .ldt            = __KERNEL_LDT,
+       .bitmap         = INVALID_IO_BITMAP_OFFSET,
+       .io_bitmap      = { [0 ... IO_BITMAP_SIZE ] = ~0 },
+
+       .eip            = (unsigned long) debug_fn,
+       .eflags         = 0x00000082,   /* interrupts off */
+       .esp            = 0,            /* percpu */
+       .es             = __USER_DS,
+       .cs             = __KERNEL_CS,
+       .ss             = __KERNEL_DS,
+       .ds             = __USER_DS,
+
+       .__cr3          = __pa(swapper_pg_dir)
+};
diff -u --exclude-from=/home/me/.exclude -rN a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c  Sun Apr 20 06:26:50 2003
+++ b/arch/i386/kernel/traps.c  Wed Apr 30 22:29:18 2003
@@ -853,7 +853,9 @@
        set_trap_gate(0,&divide_error);
        set_intr_gate(1,&debug);
        set_intr_gate(2,&nmi);
-       set_system_gate(3,&int3);       /* int3-5 can be called from all */
+       /* set_system_gate(3,&int3); */ /* int3-5 can be called from all */
+       set_task_gate(3,GDT_ENTRY_DEBUG_TSS);
+       idt_table[3].b |= 0x6000; /* DPL 3 */
        set_system_gate(4,&overflow);
        set_system_gate(5,&bounds);
        set_trap_gate(6,&invalid_op);
diff -u --exclude-from=/home/me/.exclude -rN a/include/asm-i386/processor.h b/include/asm-i386/processor.h
--- a/include/asm-i386/processor.h      Sun Apr 20 06:26:52 2003
+++ b/include/asm-i386/processor.h      Wed Apr 30 20:31:38 2003
@@ -177,8 +177,10 @@
        return edx;
 }
 
-#define load_cr3(pgdir) \
-       asm volatile("movl %0,%%cr3": :"r" (__pa(pgdir)))
+#define load_cr3(pgdir) { \
+               init_tss[smp_processor_id()].__cr3 = __pa(pgdir); \
+               asm volatile("movl %0,%%cr3": :"r" (__pa(pgdir))); \
+       }
 
 
 /*
@@ -417,7 +419,7 @@
        .ss0            = __KERNEL_DS,                                  \
        .esp1           = sizeof(init_tss[0]) + (long)&init_tss[0],     \
        .ss1            = __KERNEL_CS,                                  \
-       .ldt            = GDT_ENTRY_LDT,                                \
+       .ldt            = __KERNEL_LDT,                                 \
        .bitmap         = INVALID_IO_BITMAP_OFFSET,                     \
        .io_bitmap      = { [ 0 ... IO_BITMAP_SIZE ] = ~0 },            \
 }
diff -u --exclude-from=/home/me/.exclude -rN a/include/asm-i386/segment.h b/include/asm-i386/segment.h
--- a/include/asm-i386/segment.h        Tue Mar  4 22:29:04 2003
+++ b/include/asm-i386/segment.h        Wed Apr 30 19:06:01 2003
@@ -42,7 +42,7 @@
  *  27 - unused
  *  28 - unused
  *  29 - unused
- *  30 - unused
+ *  30 - TSS for debugger
  *  31 - TSS for double fault handler
  */
 #define GDT_ENTRY_TLS_ENTRIES  3
@@ -67,10 +67,12 @@
 
 #define GDT_ENTRY_TSS                  (GDT_ENTRY_KERNEL_BASE + 4)
 #define GDT_ENTRY_LDT                  (GDT_ENTRY_KERNEL_BASE + 5)
+#define __KERNEL_LDT (GDT_ENTRY_LDT * 8)
 
 #define GDT_ENTRY_PNPBIOS_BASE         (GDT_ENTRY_KERNEL_BASE + 6)
 #define GDT_ENTRY_APMBIOS_BASE         (GDT_ENTRY_KERNEL_BASE + 11)
 
+#define GDT_ENTRY_DEBUG_TSS            30
 #define GDT_ENTRY_DOUBLEFAULT_TSS      31
 
 /*
------
 Chuck
