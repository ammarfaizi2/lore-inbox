Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162422AbWKQHww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162422AbWKQHww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162425AbWKQHww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:52:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:52122 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162422AbWKQHwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:52:51 -0500
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH for review] Add vDSO for x86-64 with gettimeofday/clock_gettime/getcpu
Date: Fri, 17 Nov 2006 08:52:29 +0100
User-Agent: KMail/1.9.5
Cc: patches@x86-64.org, davej@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611170852.29465.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Patch for review. Any comments and testing appreciated. However
with the so far missing glibc interface it can be only tested
with custom test programs.]

This implements new vDSO for x86-64.  The concept is similar
to the existing vDSOs on i386 and PPC.  x86-64 has had static
vsyscalls before,  but these are not flexible enough anymore.

A vDSO is a ELF shared library supplied by the kernel that is mapped into 
user address space.  The vDSO mapping is randomized for each process
for security reasons.

Doing this was needed for clock_gettime, because clock_gettime
always needs a syscall fallback and having one at a fixed
address would have made buffer overflow exploits too easy to write.

The vdso can be disabled with vdso=0

It currently includes a new gettimeofday implemention and optimized
clock_gettime(). The gettimeofday implementation is slightly faster
than the one in the old vsyscall.  clock_gettime is significantly faster 
than the syscall for CLOCK_MONOTONIC and CLOCK_REALTIME.

The new calls are generally faster than the old vsyscall. 

On a P4 system (v* = vDSO, other glibc): 

All numbers in cycles

vgetcpu(&cpu, &node, NULL) took 52
old_vgetcpu(&cpu, &node, NULL) took 52
[ Essentially the same code. No difference ]
gettimeofday(&tv, NULL) took 513
vgettimeofday(&tv, NULL) took 335
[ I think that the new vgettimeofday is faster is because
  it avoids a division and is somewhat cleaner than the old code. I plan
  to port these improvements over to the old gettimeofday
  so this difference should disappear ]
clock_gettime(CLOCK_REALTIME, &ts) took 1454
vclock_gettime(CLOCK_REALTIME, &ts) took 305
clock_gettime(CLOCK_MONOTONIC, &ts) took 1616
vclock_gettime(CLOCK_MONOTONIC, &ts) took 309
[ Difference between system call and using the ring 3 fast path ]
vclock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts) took 1673
clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts) took 338
[ For clock_gettime(CLOCK_PROCESS_CPUTIME_ID) it is right now slower,
  because glibc seems to do something magic that doesn't require
  system calls. The vDSO would do a system call to get the information.
  From what i can see the information glibc returns is dubious
  so this might be actually a glibc weakness (I don't know how it can
  figure out the per process CPU time without asking the kernel).
  The returned values also are different. ] 

Advantages over the old x86-64 vsyscalls:
- Extensible
- Randomized
- Cleaner
- Easier to virtualize (the old static address range previously causes
overhead e.g. for Xen because it has to create special page tables for it) 

Weak points: 
- This does some tricks with binutils. Might break on different versions
(tested with gcc 4.0 / binutils 2.6.16.91.0.2 from SUSE 10.0) 
- glibc support still to be written
- The vDSO varies in the full mmap range (2/3*TASK_SIZE-TASK_SIZE). 
This might be inconvenient for some virtual address space hungry 
applications because it is in the middle of the address 
space.  Should be restricted to a smaller range.

The VM interface is partly based on Ingo Molnar's i386 version.

TBD fix address space range issue

Signed-off-by: Andi Kleen <ak@suse.de>

---
 Documentation/kernel-parameters.txt |    2 
 Documentation/x86_64/mm.txt         |    2 
 arch/x86_64/Makefile                |    3 
 arch/x86_64/ia32/ia32_binfmt.c      |    1 
 arch/x86_64/kernel/time.c           |   10 --
 arch/x86_64/kernel/vmlinux.lds.S    |   10 ++
 arch/x86_64/mm/init.c               |   17 ++++
 arch/x86_64/vdso/Makefile           |   48 +++++++++++
 arch/x86_64/vdso/vclock_gettime.c   |  145 ++++++++++++++++++++++++++++++++++++
 arch/x86_64/vdso/vdso-note.S        |   25 ++++++
 arch/x86_64/vdso/vdso-start.S       |    2 
 arch/x86_64/vdso/vdso.S             |    2 
 arch/x86_64/vdso/vdso.lds.S         |   75 ++++++++++++++++++
 arch/x86_64/vdso/vextern.h          |   21 +++++
 arch/x86_64/vdso/vgetcpu.c          |   49 ++++++++++++
 arch/x86_64/vdso/vma.c              |  117 +++++++++++++++++++++++++++++
 arch/x86_64/vdso/vvar.c             |   10 ++
 include/asm-x86_64/auxvec.h         |    2 
 include/asm-x86_64/elf.h            |   13 +++
 include/asm-x86_64/mmu.h            |    1 
 include/asm-x86_64/pgtable.h        |    6 +
 include/asm-x86_64/timex.h          |    7 +
 include/asm-x86_64/vsyscall.h       |    8 +
 23 files changed, 565 insertions(+), 11 deletions(-)

Index: linux/Documentation/x86_64/mm.txt
===================================================================
--- linux.orig/Documentation/x86_64/mm.txt
+++ linux/Documentation/x86_64/mm.txt
@@ -12,7 +12,7 @@ ffffc20000000000 - ffffe1ffffffffff (=45
 ... unused hole ...
 ffffffff80000000 - ffffffff82800000 (=40MB)   kernel text mapping, from phys 0
 ... unused hole ...
-ffffffff88000000 - fffffffffff00000 (=1919MB) module mapping space
+ffffffff88000000 - ffffffffff600000           module mapping space
 
 The direct mapping covers all memory in the system upto the highest
 memory address (this means in some cases it can also include PCI memory
Index: linux/arch/x86_64/ia32/ia32_binfmt.c
===================================================================
--- linux.orig/arch/x86_64/ia32/ia32_binfmt.c
+++ linux/arch/x86_64/ia32/ia32_binfmt.c
@@ -33,6 +33,7 @@
 
 int sysctl_vsyscall32 = 1;
 
+#undef ARCH_DLINFO
 #define ARCH_DLINFO do {  \
 	if (sysctl_vsyscall32) { \
 	NEW_AUX_ENT(AT_SYSINFO, (u32)(u64)VSYSCALL32_VSYSCALL); \
Index: linux/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ linux/arch/x86_64/kernel/vmlinux.lds.S
@@ -111,6 +111,9 @@ SECTIONS
   .xtime : AT(VLOAD(.xtime)) { *(.xtime) }
   xtime = VVIRT(.xtime);
 
+  .wall_to_monotonic : AT(VLOAD(.wall_to_monotonic)) { *(.wall_to_monotonic) }
+  wall_to_monotonic = VVIRT(.wall_to_monotonic);
+
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
   .jiffies : AT(VLOAD(.jiffies)) { *(.jiffies) }
   jiffies = VVIRT(.jiffies);
@@ -159,6 +162,13 @@ SECTIONS
   . = ALIGN(4096);
   __smp_alt_end = .;
 
+  /* Blob that is mapped into user space */
+  . = ALIGN(4096);
+  vdso_start = . ;
+  .vdso  : AT(ADDR(.vdso) - LOAD_OFFSET) { *(.vdso) }
+  . = ALIGN(4096);
+  vdso_end = .;
+
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
   .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -58,13 +58,6 @@ DEFINE_SPINLOCK(i8253_lock);
 int nohpet __initdata = 0;
 static int notsc __initdata = 0;
 
-#define USEC_PER_TICK (USEC_PER_SEC / HZ)
-#define NSEC_PER_TICK (NSEC_PER_SEC / HZ)
-#define FSEC_PER_TICK (FSEC_PER_SEC / HZ)
-
-#define NS_SCALE	10 /* 2^10, carefully chosen */
-#define US_SCALE	32 /* 2^32, arbitralrily chosen */
-
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
 static unsigned long hpet_period;			/* fsecs / HPET clock */
@@ -79,6 +72,7 @@ struct vxtime_data __vxtime __section_vx
 volatile unsigned long __jiffies __section_jiffies = INITIAL_JIFFIES;
 struct timespec __xtime __section_xtime;
 struct timezone __sys_tz __section_sys_tz;
+struct timespec __wall_to_monotonic __section_wall_to_monotonic;
 
 /*
  * do_gettimeoffset() returns microseconds since last timer interrupt was
@@ -464,6 +458,7 @@ static unsigned int cyc2ns_scale __read_
 
 static inline void set_cyc2ns_scale(unsigned long cpu_khz)
 {
+	vxtime.cyc2ns_scale =
 	cyc2ns_scale = (NSEC_PER_MSEC << NS_SCALE) / cpu_khz;
 }
 
@@ -998,6 +993,7 @@ void time_init_gtod(void)
 	printk(KERN_INFO "time.c: Detected %d.%03d MHz processor.\n",
 		cpu_khz / 1000, cpu_khz % 1000);
 	vxtime.quot = (USEC_PER_SEC << US_SCALE) / vxtime_hz;
+	vxtime.quot_nsec = (NSEC_PER_SEC << NS_SCALE) / vxtime_hz;
 	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
 	vxtime.last_tsc = get_cycles_sync();
 
Index: linux/arch/x86_64/mm/init.c
===================================================================
--- linux.orig/arch/x86_64/mm/init.c
+++ linux/arch/x86_64/mm/init.c
@@ -152,6 +152,14 @@ static __init void set_pte_phys(unsigned
 	__flush_tlb_one(vaddr);
 }
 
+void __init
+set_kernel_map(void *vaddr,unsigned long len,unsigned long phys,pgprot_t prot)
+{
+	void *end = vaddr + ALIGN(len, PAGE_SIZE);
+	for (; vaddr < end; vaddr += PAGE_SIZE, phys += PAGE_SIZE)
+		set_pte_phys((unsigned long)vaddr, phys, prot);
+}
+
 /* NOTE: this is meant to be run only at boot */
 void __init 
 __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t prot)
@@ -773,3 +781,12 @@ int in_gate_area_no_task(unsigned long a
 {
 	return (addr >= VSYSCALL_START) && (addr < VSYSCALL_END);
 }
+
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm && vma->vm_start == (long)vma->vm_mm->context.vdso)
+		return "[vdso]";
+	if (vma == &gate_vma)
+		return "[vsyscall]";
+	return NULL;
+}
Index: linux/arch/x86_64/vdso/vdso-note.S
===================================================================
--- /dev/null
+++ linux/arch/x86_64/vdso/vdso-note.S
@@ -0,0 +1,25 @@
+/*
+ * This supplies .note.* sections to go into the PT_NOTE inside the vDSO text.
+ * Here we can supply some information useful to userland.
+ */
+
+#include <linux/uts.h>
+#include <linux/version.h>
+
+#define ASM_ELF_NOTE_BEGIN(name, flags, vendor, type)			      \
+	.section name, flags;						      \
+	.balign 4;							      \
+	.long 1f - 0f;		/* name length */			      \
+	.long 3f - 2f;		/* data length */			      \
+	.long type;		/* note type */				      \
+0:	.asciz vendor;		/* vendor name */			      \
+1:	.balign 4;							      \
+2:
+
+#define ASM_ELF_NOTE_END						      \
+3:	.balign 4;		/* pad out section */			      \
+	.previous
+
+	ASM_ELF_NOTE_BEGIN(".note.kernel-version", "a", UTS_SYSNAME, 0)
+	.long LINUX_VERSION_CODE
+	ASM_ELF_NOTE_END
Index: linux/arch/x86_64/vdso/vdso.lds.S
===================================================================
--- /dev/null
+++ linux/arch/x86_64/vdso/vdso.lds.S
@@ -0,0 +1,75 @@
+/*
+ * Linker script for vsyscall DSO.  The vsyscall page is an ELF shared
+ * object prelinked to its virtual address, and with only one read-only
+ * segment (that fits in one page).  This script controls its layout.
+ */
+#include <asm/asm-offsets.h>
+
+#define VDSO_PRELINK 0xffffffffff700000
+
+SECTIONS
+{
+  . = VDSO_PRELINK + SIZEOF_HEADERS;
+
+  .hash           : { *(.hash) }		:text
+  .gnu.hash       : { *(.gnu.hash) }
+  .dynsym         : { *(.dynsym) }
+  .dynstr         : { *(.dynstr) }
+  .gnu.version    : { *(.gnu.version) }
+  .gnu.version_d  : { *(.gnu.version_d) }
+  .gnu.version_r  : { *(.gnu.version_r) }
+
+  /* This linker script is used both with -r and with -shared.
+     For the layouts to match, we need to skip more than enough
+     space for the dynamic symbol table et al.  If this amount
+     is insufficient, ld -shared will barf.  Just increase it here.  */
+  . = VDSO_PRELINK + 0x400;
+
+  .text           : { *(.text) }		:text
+  .text.ptr       : { *(.text.ptr) }		:text
+  . = VDSO_PRELINK + 0x900;
+  .data           : { *(.data) }		:text
+  .bss            : { *(.bss) }			:text
+  /* altinstructions needs work for Intel platforms */
+  .note		  : { *(.note.*) }		:text :note
+  .eh_frame_hdr   : { *(.eh_frame_hdr) }	:text :eh_frame_hdr
+  .eh_frame       : { KEEP (*(.eh_frame)) }	:text
+  .dynamic        : { *(.dynamic) }		:text :dynamic
+  .useless        : {
+  	*(.got.plt) *(.got)
+	*(.gnu.linkonce.d.*)
+	*(.dynbss)
+	*(.gnu.linkonce.b.*)
+  }						:text
+  /* altinstructions are only in -syms */
+  /DISCARD/ : { *(.altinstructions) }
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+  text PT_LOAD FILEHDR PHDRS FLAGS(5); /* PF_R|PF_X */
+  dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
+  note PT_NOTE FLAGS(4); /* PF_R */
+  eh_frame_hdr 0x6474e550; /* PT_GNU_EH_FRAME, but ld doesn't match the name */
+}
+
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+  LINUX_2.6 {
+    global:
+	clock_gettime;
+	__vdso_clock_gettime;
+	gettimeofday;
+	__vdso_gettimeofday;
+	getcpu;
+	__vdso_getcpu;
+    local: *;
+  };
+}
Index: linux/arch/x86_64/vdso/Makefile
===================================================================
--- /dev/null
+++ linux/arch/x86_64/vdso/Makefile
@@ -0,0 +1,48 @@
+#
+# x86-64 vDSO.
+#
+
+# files to link into the vdso
+# vdso-start.o has to be first
+vobjs-y := vdso-start.o vdso-note.o vclock_gettime.o vgetcpu.o vvar.o
+
+# files to link into kernel
+obj-y := vma.o vdso.o vdso-syms.o
+
+vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
+
+$(obj)/vdso.o: $(obj)/vdso.so
+
+targets += vdso.so vdso.lds
+
+# The DSO images are built using a special linker script.
+quiet_cmd_syscall = SYSCALL $@
+      cmd_syscall = $(CC) -m elf_x86_64 -nostdlib $(SYSCFLAGS_$(@F)) \
+		          -Wl,-T,$(filter-out FORCE,$^) -o $@
+
+export CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+
+vdso-flags = -fPIC -shared -s -Wl,-soname=linux-vdso.so.1 -fvisibility=hidden \
+		 $(call ld-option, -Wl$(comma)--hash-style=sysv)
+SYSCFLAGS_vdso.so = $(vdso-flags)
+
+$(obj)/vdso.o: $(src)/vdso.S $(obj)/vdso.so
+
+$(obj)/vdso.so: $(src)/vdso.lds $(vobjs) FORCE
+	$(call if_changed,syscall)
+
+CF := $(PROFILING) -mcmodel=small -fPIC -g0 -O2 -fasynchronous-unwind-tables
+
+$(obj)/vclock_gettime.o: CFLAGS = $(CF)
+$(obj)/vgetcpu.o: CFLAGS = $(CF)
+
+# We also create a special relocatable object that should mirror the symbol
+# table and layout of the linked DSO.  With ld -R we can then refer to
+# these symbols in the kernel code rather than hand-coded addresses.
+extra-y += vdso-syms.o
+$(obj)/built-in.o: $(obj)/vdso-syms.o
+$(obj)/built-in.o: ld_flags += -R $(obj)/vdso-syms.o
+
+SYSCFLAGS_vdso-syms.o = -r -d
+$(obj)/vdso-syms.o: $(src)/vdso.lds $(vobjs) FORCE
+	$(call if_changed,syscall)
Index: linux/arch/x86_64/vdso/vclock_gettime.c
===================================================================
--- /dev/null
+++ linux/arch/x86_64/vdso/vclock_gettime.c
@@ -0,0 +1,145 @@
+/*
+ * Copyright 2006 Andi Kleen, SUSE Labs.
+ * Subject to the GNU Public License, v.2
+ *
+ * Fast user context implementation of clock_gettime and gettimeofday.
+ *
+ * The code should have no internal unresolved relocations.
+ * Check with readelf after changing.
+ */
+
+#include <linux/kernel.h>
+#include <linux/posix-timers.h>
+#include <linux/time.h>
+#include <linux/string.h>
+#include <asm/vsyscall.h>
+#include <asm/timex.h>
+#include <asm/hpet.h>
+#include <asm/unistd.h>
+#include <asm/io.h>
+#include "vextern.h"
+
+static inline void normalize_ts(struct timespec *ts)
+{
+	while (unlikely(ts->tv_nsec >= NSEC_PER_SEC)) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		++ts->tv_sec;
+	}
+	while (unlikely(ts->tv_nsec < 0)) {
+		ts->tv_nsec += NSEC_PER_SEC;
+		--ts->tv_sec;
+	}
+}
+
+static inline unsigned long long vcycles_2_ns(unsigned long long cyc)
+{
+	return (cyc * vdso_vxtime->cyc2ns_scale) >> NS_SCALE;
+}
+
+static inline unsigned long vhpet_2_ns(unsigned long ticks)
+{
+	return (ticks * vdso_vxtime->quot_nsec)  >> NS_SCALE;
+}
+
+/* noinline to get only a single patch point for CPUID. Besides
+   it saves icache. */
+static noinline void vgetns(struct timespec *ts)
+{
+	unsigned long nsec = vdso_xtime->tv_nsec;
+	if (vdso_vxtime->mode == VXTIME_HPET) {
+		/* Should support 64bit HPET here */
+		long count = hpet_readl(HPET_COUNTER);
+		nsec += vhpet_2_ns(count - vdso_vxtime->last);
+	} else {
+		long t;
+		/* Synchronize the pipeline on CPUs where RDTSC can be
+		   speculated to avoid non monoticities. Normal alternative
+		   section doesn't work here in the vDSO. Patching is done
+	           by hand in vma.c */
+		unsigned eax;
+		asm volatile(
+			"	.globl vdso_sync_cpuid\n"
+		        "vdso_sync_cpuid: cpuid"
+			: "=a" (eax)
+			: "0" (1)
+			: "ebx","ecx","edx","memory");
+		rdtscll(t);
+		t -= vdso_vxtime->last_tsc;
+		/* Mostly broken hack to handle unsynchronized TSCs
+		   that should go away. Really need per CPU
+		   TSC. Normally we avoid this by not using TSC on
+		   machines which are known to do this. */
+		if (t < 0)
+			t = 0;
+		nsec += vcycles_2_ns(t);
+	}
+	ts->tv_nsec = nsec;
+	ts->tv_sec = vdso_xtime->tv_sec;
+}
+
+static inline int do_realtime(struct timespec *ts)
+{
+	unsigned long seq;
+	do {
+		seq = read_seqbegin(vdso_xtime_lock);
+		vgetns(ts);
+	} while (unlikely(read_seqretry(vdso_xtime_lock, seq)));
+	normalize_ts(ts);
+	return 0;
+}
+
+static inline int do_monotonic(struct timespec *ts)
+{
+	unsigned long seq;
+	do {
+		seq = read_seqbegin(vdso_xtime_lock);
+		vgetns(ts);
+		ts->tv_sec += vdso_wall_to_monotonic->tv_sec;
+		ts->tv_nsec += vdso_wall_to_monotonic->tv_nsec;
+	} while (unlikely(read_seqretry(vdso_xtime_lock, seq)));
+	normalize_ts(ts);
+	return 0;
+}
+
+int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
+{
+	long ret;
+	/* Fast path */
+	if (likely(*vdso_sysctl_vsyscall))
+		switch (clock) {
+		case CLOCK_REALTIME:
+			return do_realtime(ts);
+		case CLOCK_MONOTONIC:
+			return do_monotonic(ts);
+		}
+
+	/* In all other cases do normal system call */
+	asm("syscall" : "=a" (ret) :
+	    "0" (__NR_clock_gettime),"D" (clock), "S" (ts));
+	return ret;
+}
+int clock_gettime(clockid_t, struct timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime")));
+
+int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	long ret;
+	if (likely(*vdso_sysctl_vsyscall)) {
+		BUILD_BUG_ON(offsetof(struct timeval, tv_usec) !=
+			     offsetof(struct timespec, tv_nsec) ||
+			     sizeof(*tv) != sizeof(struct timespec));
+		do_realtime((struct timespec *)tv);
+		tv->tv_usec /= 1000;
+		if (unlikely(tz != NULL)) {
+			/* This relies on gcc inlining the memcpy. We'll notice
+			   if it ever fails to do so. */
+			memcpy(tz, vdso_sys_tz, sizeof(struct timezone));
+		}
+		return 0;
+	}
+	asm("syscall" : "=a" (ret) :
+	    "0" (__NR_gettimeofday), "D" (tv), "S" (tz));
+	return ret;
+}
+int gettimeofday(struct timeval *, struct timezone *)
+	__attribute__((weak, alias("__vdso_gettimeofday")));
Index: linux/arch/x86_64/vdso/vma.c
===================================================================
--- /dev/null
+++ linux/arch/x86_64/vdso/vma.c
@@ -0,0 +1,117 @@
+/*
+ * Set up the VMAs to tell the VM about the vDSO.
+ */
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <asm/vsyscall.h>
+#include <asm/proto.h>
+
+int vdso_enabled = 1;
+
+#define VEXTERN(x) extern typeof(__ ## x) *vdso_ ## x;
+#include "vextern.h"
+#undef VEXTERN
+
+static void check(char *name, unsigned long val)
+{
+	if (val != VMAGIC)
+		panic("%s has wrong value %lx\n", name, val);
+}
+
+extern char vdso_kernel_start[], vdso_start[], vdso_end[];
+extern unsigned short vdso_sync_cpuid;
+
+static int __init init_vdso_vars(void)
+{
+	set_kernel_map(vdso_kernel_start, vdso_end-vdso_start,
+		       __pa_symbol(&vdso_start), PAGE_KERNEL);
+#define VEXTERN(x) check(#x, (unsigned long)vdso_ ## x); vdso_ ## x = &__ ## x;
+#include "vextern.h"
+#undef VEXTERN
+
+	/* Remove pipeline synchronization on CPUs which have synchronized
+	   RDTSC like Intel Netburst.
+	   Normally this would be done by alternative(), but I didn't
+	   find a clean way to get the alternative section from the vdso
+	   into the main kernel image. So do it by hand instead. -AK */
+	if (boot_cpu_has(X86_FEATURE_SYNC_RDTSC)) {
+		printk("vdso_sync_cpuid %p:%x\n", &vdso_sync_cpuid, vdso_sync_cpuid);
+		vdso_sync_cpuid = 0x9090; 	/* NOP it out */
+	}
+
+	return 0;
+}
+__initcall(init_vdso_vars);
+
+static struct page *syscall_nopage(struct vm_area_struct *vma,
+				unsigned long adr, int *type)
+{
+	struct page *p = virt_to_page(adr - vma->vm_start + vdso_start);
+	get_page(p);
+	return p;
+}
+
+/* Prevent VMA merging */
+static void syscall_vma_close(struct vm_area_struct *vma)
+{
+}
+
+static struct vm_operations_struct syscall_vm_ops = {
+	.close = syscall_vma_close,
+	.nopage = syscall_nopage,
+};
+
+struct linux_binprm;
+
+/* Setup a VMA at program startup for the vsyscall page */
+int arch_setup_additional_pages(struct linux_binprm *bprm, int exstack)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr;
+	int ret;
+
+	if (!vdso_enabled)
+		return 0;
+
+	down_write(&mm->mmap_sem);
+	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		ret = addr;
+		goto up_fail;
+	}
+
+	vma = kmem_cache_zalloc(vm_area_cachep, SLAB_KERNEL);
+	if (!vma) {
+		ret = -ENOMEM;
+		goto up_fail;
+	}
+
+	vma->vm_start = addr;
+	vma->vm_end = addr + round_up(vdso_end - vdso_start, PAGE_SIZE);
+	/* MAYWRITE to allow gdb to COW and set breakpoints */
+	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYWRITE;
+	vma->vm_flags |= mm->def_flags;
+	vma->vm_page_prot = protection_map[vma->vm_flags & 7];
+	vma->vm_ops = &syscall_vm_ops;
+	vma->vm_mm = mm;
+
+	ret = insert_vm_struct(mm, vma);
+	if (unlikely(ret)) {
+		kmem_cache_free(vm_area_cachep, vma);
+		goto up_fail;
+	}
+
+	current->mm->context.vdso = (void *)addr;
+	mm->total_vm++;
+up_fail:
+	up_write(&mm->mmap_sem);
+	return ret;
+}
+
+static __init int vdso_setup(char *s)
+{
+	vdso_enabled = simple_strtoul(s, NULL, 0);
+	return 0;
+}
+__setup("vdso=", vdso_setup);
Index: linux/arch/x86_64/vdso/vdso.S
===================================================================
--- /dev/null
+++ linux/arch/x86_64/vdso/vdso.S
@@ -0,0 +1,2 @@
+	.section ".vdso","a"
+	.incbin "arch/x86_64/vdso/vdso.so"
Index: linux/arch/x86_64/vdso/vdso-start.S
===================================================================
--- /dev/null
+++ linux/arch/x86_64/vdso/vdso-start.S
@@ -0,0 +1,2 @@
+	.globl vdso_kernel_start
+vdso_kernel_start:
Index: linux/arch/x86_64/Makefile
===================================================================
--- linux.orig/arch/x86_64/Makefile
+++ linux/arch/x86_64/Makefile
@@ -82,7 +82,8 @@ head-y := arch/x86_64/kernel/head.o arch
 libs-y 					+= arch/x86_64/lib/
 core-y					+= arch/x86_64/kernel/ \
 					   arch/x86_64/mm/ \
-					   arch/x86_64/crypto/
+					   arch/x86_64/crypto/ \
+					   arch/x86_64/vdso/
 core-$(CONFIG_IA32_EMULATION)		+= arch/x86_64/ia32/
 drivers-$(CONFIG_PCI)			+= arch/x86_64/pci/
 drivers-$(CONFIG_OPROFILE)		+= arch/x86_64/oprofile/
Index: linux/include/asm-x86_64/pgtable.h
===================================================================
--- linux.orig/include/asm-x86_64/pgtable.h
+++ linux/include/asm-x86_64/pgtable.h
@@ -419,6 +419,9 @@ void vmalloc_sync_all(void);
 
 extern int kern_addr_valid(unsigned long addr); 
 
+extern void set_kernel_map(void *vaddr, unsigned long len,
+			   unsigned long phys, pgprot_t prot);
+
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
@@ -447,4 +450,7 @@ extern int kern_addr_valid(unsigned long
 #define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
 
+extern void
+fix_set_pte_phys(unsigned long vaddr, unsigned long phys, pgprot_t prot);
+
 #endif /* _X86_64_PGTABLE_H */
Index: linux/include/asm-x86_64/mmu.h
===================================================================
--- linux.orig/include/asm-x86_64/mmu.h
+++ linux/include/asm-x86_64/mmu.h
@@ -15,6 +15,7 @@ typedef struct { 
 	rwlock_t ldtlock; 
 	int size;
 	struct semaphore sem; 
+	void *vdso;
 } mm_context_t;
 
 #endif
Index: linux/include/asm-x86_64/vsyscall.h
===================================================================
--- linux.orig/include/asm-x86_64/vsyscall.h
+++ linux/include/asm-x86_64/vsyscall.h
@@ -23,6 +23,7 @@ enum vsyscall_num {
 #define __section_sysctl_vsyscall __attribute__ ((unused, __section__ (".sysctl_vsyscall"), aligned(16)))
 #define __section_xtime __attribute__ ((unused, __section__ (".xtime"), aligned(16)))
 #define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock"), aligned(16)))
+#define __section_wall_to_monotonic __attribute__ ((unused, __section__ (".wall_to_monotonic"), aligned(16)))
 
 #define VXTIME_TSC	1
 #define VXTIME_HPET	2
@@ -33,11 +34,13 @@ enum vsyscall_num {
 
 struct vxtime_data {
 	long hpet_address;	/* HPET base address */
-	int last;
 	unsigned long last_tsc;
 	long quot;
 	long tsc_quot;
+	int last;
 	int mode;
+	long quot_nsec;
+	long cyc2ns_scale;
 };
 
 #define hpet_readl(a)           readl((const void __iomem *)fix_to_virt(FIX_HPET_BASE) + a)
@@ -49,7 +52,9 @@ extern int __vgetcpu_mode;
 extern struct timespec __xtime;
 extern volatile unsigned long __jiffies;
 extern struct timezone __sys_tz;
+extern int __sysctl_vsyscall;
 extern seqlock_t __xtime_lock;
+extern struct timespec __wall_to_monotonic;
 
 /* kernel space (writeable) */
 extern struct vxtime_data vxtime;
@@ -57,6 +62,7 @@ extern int vgetcpu_mode;
 extern struct timezone sys_tz;
 extern int sysctl_vsyscall;
 extern seqlock_t xtime_lock;
+extern struct timespec wall_to_monotonic;
 
 extern int sysctl_vsyscall;
 
Index: linux/include/asm-x86_64/auxvec.h
===================================================================
--- linux.orig/include/asm-x86_64/auxvec.h
+++ linux/include/asm-x86_64/auxvec.h
@@ -1,4 +1,6 @@
 #ifndef __ASM_X86_64_AUXVEC_H
 #define __ASM_X86_64_AUXVEC_H
 
+#define AT_SYSINFO_EHDR		33
+
 #endif
Index: linux/include/asm-x86_64/timex.h
===================================================================
--- linux.orig/include/asm-x86_64/timex.h
+++ linux/include/asm-x86_64/timex.h
@@ -46,4 +46,11 @@ extern int read_current_timer(unsigned l
 
 extern struct vxtime_data vxtime;
 
+#define USEC_PER_TICK (USEC_PER_SEC / HZ)
+#define NSEC_PER_TICK (NSEC_PER_SEC / HZ)
+#define FSEC_PER_TICK (FSEC_PER_SEC / HZ)
+
+#define NS_SCALE	10 /* 2^10, carefully chosen */
+#define US_SCALE	32 /* 2^32, arbitralrily chosen */
+
 #endif
Index: linux/include/asm-x86_64/elf.h
===================================================================
--- linux.orig/include/asm-x86_64/elf.h
+++ linux/include/asm-x86_64/elf.h
@@ -163,6 +163,19 @@ extern int dump_task_fpu (struct task_st
 /* 1GB for 64bit, 8MB for 32bit */
 #define STACK_RND_MASK (test_thread_flag(TIF_IA32) ? 0x7ff : 0x3fffff)
 
+
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+                                       int executable_stack);
+
+extern int vdso_enabled;
+
+#define ARCH_DLINFO						\
+do if (vdso_enabled) {						\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,(unsigned long)current->mm->context.vdso);\
+} while (0)
+
 #endif
 
 #endif
Index: linux/arch/x86_64/vdso/vextern.h
===================================================================
--- /dev/null
+++ linux/arch/x86_64/vdso/vextern.h
@@ -0,0 +1,21 @@
+#ifndef VEXTERN
+#include <asm/vsyscall.h>
+#define VEXTERN(x) \
+	extern typeof(x) *vdso_ ## x __attribute__((visibility("hidden")));
+#endif
+
+#define VMAGIC 0xfeedbabeabcdefabUL
+
+/* Any kernel variables used in the vDSO must be exported in the main
+   kernel's vmlinux.lds.S/vsyscall.h/proper __section and
+   put into vextern.h and be referenced as a pointer with vdso prefix.
+   The main kernel later fills in the values.   */
+
+VEXTERN(xtime_lock)
+VEXTERN(xtime)
+VEXTERN(vxtime)
+VEXTERN(jiffies)
+VEXTERN(sysctl_vsyscall)
+VEXTERN(wall_to_monotonic)
+VEXTERN(vgetcpu_mode)
+VEXTERN(sys_tz)
Index: linux/arch/x86_64/vdso/vgetcpu.c
===================================================================
--- /dev/null
+++ linux/arch/x86_64/vdso/vgetcpu.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2006 Andi Kleen, SUSE Labs.
+ * Subject to the GNU Public License, v.2
+ *
+ * Fast user context implementation of getcpu()
+ */
+
+#include <linux/kernel.h>
+#include <linux/getcpu.h>
+#include <linux/jiffies.h>
+#include <linux/time.h>
+#include <asm/vsyscall.h>
+#include "vextern.h"
+
+long __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
+{
+	unsigned int dummy, p;
+	unsigned long j = 0;
+
+	/* Fast cache - only recompute value once per jiffies and avoid
+	   relatively costly rdtscp/cpuid otherwise.
+	   This works because the scheduler usually keeps the process
+	   on the same CPU and this syscall doesn't guarantee its
+	   results anyways.
+	   We do this here because otherwise user space would do it on
+	   its own in a likely inferior way (no access to jiffies).
+	   If you don't like it pass NULL. */
+	if (tcache && tcache->blob[0] == (j = __jiffies)) {
+		p = tcache->blob[1];
+	} else if (*vdso_vgetcpu_mode == VGETCPU_RDTSCP) {
+		/* Load per CPU data from RDTSCP */
+		rdtscp(dummy, dummy, p);
+	} else {
+		/* Load per CPU data from GDT */
+		asm("lsl %1,%0" : "=r" (p) : "r" (__PER_CPU_SEG));
+	}
+	if (tcache) {
+		tcache->blob[0] = j;
+		tcache->blob[1] = p;
+	}
+	if (cpu)
+		*cpu = p & 0xfff;
+	if (node)
+		*node = p >> 12;
+	return 0;
+}
+
+long getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
+	__attribute__((weak, alias("__vdso_getcpu")));
Index: linux/arch/x86_64/vdso/vvar.c
===================================================================
--- /dev/null
+++ linux/arch/x86_64/vdso/vvar.c
@@ -0,0 +1,10 @@
+/* Define vDSO variables. These are part of the vDSO */
+#include <linux/kernel.h>
+#include <linux/time.h>
+#include <asm/vsyscall.h>
+#include <asm/timex.h>
+
+#define __hidden __attribute__((visibility("hidden")))
+
+#define VEXTERN(x) typeof (__ ## x) *vdso_ ## x __hidden = (void *)VMAGIC;
+#include "vextern.h"
Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt
+++ linux/Documentation/kernel-parameters.txt
@@ -1682,7 +1682,7 @@ and is between 256 and 4096 characters. 
 	usbhid.mousepoll=
 			[USBHID] The interval which mice are to be polled at.
 
-	vdso=		[IA-32]
+	vdso=		[IA32,X86-64]
 			vdso=1: enable VDSO (default)
 			vdso=0: disable VDSO mapping
 
