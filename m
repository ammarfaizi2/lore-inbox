Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267785AbTBVDO3>; Fri, 21 Feb 2003 22:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267786AbTBVDO3>; Fri, 21 Feb 2003 22:14:29 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:31617 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267785AbTBVDOK>; Fri, 21 Feb 2003 22:14:10 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH][2.5] fix preempt-issues with smp_call_function()
Date: Sat, 22 Feb 2003 04:23:38 +0100
User-Agent: KMail/1.5
References: <20030221142039.GA21532@codemonkey.org.uk> <20030221173602.GC25704@codemonkey.org.uk>
In-Reply-To: <20030221173602.GC25704@codemonkey.org.uk>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_E1uV+LvHN9DKJcG";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302220423.48803.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_E1uV+LvHN9DKJcG
Content-Type: multipart/mixed;
  boundary="Boundary-01=_60uV+wU2X3FsvYg"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_60uV+wU2X3FsvYg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

On Fri, Feb 21, 2003 at 18:36, Dave Jones wrote:
> Ok, here's a first stab at an implementation. Compiles, but is untested..
> Fixes up a few preemption races Thomas highlighted, and converts
> a few smp_call_function() users over to on_each_cpu(), which
> saves quite a bit of code.

Your patch was really fine, I just modified it a bit and fixed some more=20
preempt-issues with the smp_call_function() calls. It compiles and workes=20
with no problems so far... I hope I did not make any big mistakes... ;-)

I hope you like this one, too...

     Thomas

--Boundary-01=_60uV+wU2X3FsvYg
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="preempt_fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="preempt_fix.patch"

diff -urP linux-2.5.62/arch/alpha/kernel/process.c linux-2.5.62_patched/arc=
h/alpha/kernel/process.c
=2D-- linux-2.5.62/arch/alpha/kernel/process.c	Mon Feb 17 23:56:54 2003
+++ linux-2.5.62_patched/arch/alpha/kernel/process.c	Sat Feb 22 02:02:17 20=
03
@@ -155,10 +155,7 @@
 	struct halt_info args;
 	args.mode =3D mode;
 	args.restart_cmd =3D restart_cmd;
=2D#ifdef CONFIG_SMP
=2D	smp_call_function(common_shutdown_1, &args, 1, 0);
=2D#endif
=2D	common_shutdown_1(&args);
+	on_each_cpu(common_shutdown_1, &args, 1, 0);
 }
=20
 void
diff -urP linux-2.5.62/arch/alpha/kernel/smp.c linux-2.5.62_patched/arch/al=
pha/kernel/smp.c
=2D-- linux-2.5.62/arch/alpha/kernel/smp.c	Mon Feb 17 23:56:10 2003
+++ linux-2.5.62_patched/arch/alpha/kernel/smp.c	Sat Feb 22 02:02:17 2003
@@ -899,10 +899,8 @@
 smp_imb(void)
 {
 	/* Must wait other processors to flush their icache before continue. */
=2D	if (smp_call_function(ipi_imb, NULL, 1, 1))
+	if (on_each_cpu(ipi_imb, NULL, 1, 1))
 		printk(KERN_CRIT "smp_imb: timed out\n");
=2D
=2D	imb();
 }
=20
 static void
@@ -916,11 +914,9 @@
 {
 	/* Although we don't have any data to pass, we do want to
 	   synchronize with the other processors.  */
=2D	if (smp_call_function(ipi_flush_tlb_all, NULL, 1, 1)) {
+	if (on_each_cpu(ipi_flush_tlb_all, NULL, 1, 1)) {
 		printk(KERN_CRIT "flush_tlb_all: timed out\n");
 	}
=2D
=2D	tbia();
 }
=20
 #define asn_locked() (cpu_data[smp_processor_id()].asn_lock)
@@ -938,6 +934,8 @@
 void
 flush_tlb_mm(struct mm_struct *mm)
 {
+	preempt_disable();
+
 	if (mm =3D=3D current->active_mm) {
 		flush_tlb_current(mm);
 		if (atomic_read(&mm->mm_users) <=3D 1) {
@@ -948,6 +946,7 @@
 				if (mm->context[cpu])
 					mm->context[cpu] =3D 0;
 			}
+			preempt_enable();
 			return;
 		}
 	}
@@ -955,6 +954,8 @@
 	if (smp_call_function(ipi_flush_tlb_mm, mm, 1, 1)) {
 		printk(KERN_CRIT "flush_tlb_mm: timed out\n");
 	}
+
+	preempt_enable();
 }
=20
 struct flush_tlb_page_struct {
@@ -981,6 +982,8 @@
 	struct flush_tlb_page_struct data;
 	struct mm_struct *mm =3D vma->vm_mm;
=20
+	preempt_disable();
+
 	if (mm =3D=3D current->active_mm) {
 		flush_tlb_current_page(mm, vma, addr);
 		if (atomic_read(&mm->mm_users) <=3D 1) {
@@ -991,6 +994,7 @@
 				if (mm->context[cpu])
 					mm->context[cpu] =3D 0;
 			}
+			preempt_enable();
 			return;
 		}
 	}
@@ -1002,6 +1006,8 @@
 	if (smp_call_function(ipi_flush_tlb_page, &data, 1, 1)) {
 		printk(KERN_CRIT "flush_tlb_page: timed out\n");
 	}
+
+	preempt_enable();
 }
=20
 void
@@ -1030,6 +1036,8 @@
 	if ((vma->vm_flags & VM_EXEC) =3D=3D 0)
 		return;
=20
+	preempt_disable();
+
 	if (mm =3D=3D current->active_mm) {
 		__load_new_mm_context(mm);
 		if (atomic_read(&mm->mm_users) <=3D 1) {
@@ -1040,6 +1048,7 @@
 				if (mm->context[cpu])
 					mm->context[cpu] =3D 0;
 			}
+			preempt_enable();
 			return;
 		}
 	}
@@ -1047,6 +1056,8 @@
 	if (smp_call_function(ipi_flush_icache_page, mm, 1, 1)) {
 		printk(KERN_CRIT "flush_icache_page: timed out\n");
 	}
+
+	preempt_enable();
 }
 =0C
 #ifdef CONFIG_DEBUG_SPINLOCK
diff -urP linux-2.5.62/arch/i386/kernel/cpuid.c linux-2.5.62_patched/arch/i=
386/kernel/cpuid.c
=2D-- linux-2.5.62/arch/i386/kernel/cpuid.c	Mon Feb 17 23:55:49 2003
+++ linux-2.5.62_patched/arch/i386/kernel/cpuid.c	Sat Feb 22 02:02:17 2003
@@ -44,8 +44,6 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
=20
=2D#ifdef CONFIG_SMP
=2D
 struct cpuid_command {
   int cpu;
   u32 reg;
@@ -64,24 +62,12 @@
 {
   struct cpuid_command cmd;
  =20
=2D  if ( cpu =3D=3D smp_processor_id() ) {
=2D    cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
=2D  } else {
=2D    cmd.cpu  =3D cpu;
=2D    cmd.reg  =3D reg;
=2D    cmd.data =3D data;
=2D   =20
=2D    smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
=2D  }
=2D}
=2D#else /* ! CONFIG_SMP */
=2D
=2Dstatic inline void do_cpuid(int cpu, u32 reg, u32 *data)
=2D{
=2D  cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
+  cmd.cpu  =3D cpu;
+  cmd.reg  =3D reg;
+  cmd.data =3D data;
+ =20
+  on_each_cpu(cpuid_smp_cpuid, &cmd, 1, 1);
 }
=2D
=2D#endif /* ! CONFIG_SMP */
=20
 static loff_t cpuid_seek(struct file *file, loff_t offset, int orig)
 {
diff -urP linux-2.5.62/arch/i386/kernel/io_apic.c linux-2.5.62_patched/arch=
/i386/kernel/io_apic.c
=2D-- linux-2.5.62/arch/i386/kernel/io_apic.c	Mon Feb 17 23:56:10 2003
+++ linux-2.5.62_patched/arch/i386/kernel/io_apic.c	Sat Feb 22 02:02:17 2003
@@ -1376,8 +1376,7 @@
=20
 void print_all_local_APICs (void)
 {
=2D	smp_call_function(print_local_APIC, NULL, 1, 1);
=2D	print_local_APIC(NULL);
+	on_each_cpu(print_local_APIC, NULL, 1, 1);
 }
=20
 void /*__init*/ print_PIC(void)
@@ -1855,8 +1854,7 @@
 	 */=20
 	printk(KERN_INFO "activating NMI Watchdog ...");
=20
=2D	smp_call_function(enable_NMI_through_LVT0, NULL, 1, 1);
=2D	enable_NMI_through_LVT0(NULL);
+	on_each_cpu(enable_NMI_through_LVT0, NULL, 1, 1);
=20
 	printk(" done.\n");
 }
diff -urP linux-2.5.62/arch/i386/kernel/ldt.c linux-2.5.62_patched/arch/i38=
6/kernel/ldt.c
=2D-- linux-2.5.62/arch/i386/kernel/ldt.c	Mon Feb 17 23:56:25 2003
+++ linux-2.5.62_patched/arch/i386/kernel/ldt.c	Sat Feb 22 02:02:17 2003
@@ -55,13 +55,13 @@
 	wmb();
=20
 	if (reload) {
+		preempt_disable();
 		load_LDT(pc);
 #ifdef CONFIG_SMP
=2D		preempt_disable();
 		if (current->mm->cpu_vm_mask !=3D (1 << smp_processor_id()))
 			smp_call_function(flush_ldt, 0, 1, 1);
=2D		preempt_enable();
 #endif
+		preempt_enable();
 	}
 	if (oldsize) {
 		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
diff -urP linux-2.5.62/arch/i386/kernel/microcode.c linux-2.5.62_patched/ar=
ch/i386/kernel/microcode.c
=2D-- linux-2.5.62/arch/i386/kernel/microcode.c	Mon Feb 17 23:56:02 2003
+++ linux-2.5.62_patched/arch/i386/kernel/microcode.c	Sat Feb 22 02:02:17 2=
003
@@ -183,11 +183,8 @@
 	int i, error =3D 0, err;
 	struct microcode *m;
=20
=2D	if (smp_call_function(do_update_one, NULL, 1, 1) !=3D 0) {
=2D		printk(KERN_ERR "microcode: IPI timeout, giving up\n");
+	if (on_each_cpu(do_update_one, NULL, 1, 1) !=3D 0)
 		return -EIO;
=2D	}
=2D	do_update_one(NULL);
=20
 	for (i=3D0; i<NR_CPUS; i++) {
 		err =3D update_req[i].err;
diff -urP linux-2.5.62/arch/i386/kernel/msr.c linux-2.5.62_patched/arch/i38=
6/kernel/msr.c
=2D-- linux-2.5.62/arch/i386/kernel/msr.c	Mon Feb 17 23:56:13 2003
+++ linux-2.5.62_patched/arch/i386/kernel/msr.c	Sat Feb 22 02:02:17 2003
@@ -116,36 +116,28 @@
 {
   struct msr_command cmd;
=20
=2D  if ( cpu =3D=3D smp_processor_id() ) {
=2D    return wrmsr_eio(reg, eax, edx);
=2D  } else {
=2D    cmd.cpu =3D cpu;
=2D    cmd.reg =3D reg;
=2D    cmd.data[0] =3D eax;
=2D    cmd.data[1] =3D edx;
=2D   =20
=2D    smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
=2D    return cmd.err;
=2D  }
+  cmd.cpu =3D cpu;
+  cmd.reg =3D reg;
+  cmd.data[0] =3D eax;
+  cmd.data[1] =3D edx;
+
+  on_each_cpu(msr_smp_wrmsr, &cmd, 1, 1);
+  return cmd.err;
 }
=20
 static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
 {
   struct msr_command cmd;
=20
=2D  if ( cpu =3D=3D smp_processor_id() ) {
=2D    return rdmsr_eio(reg, eax, edx);
=2D  } else {
=2D    cmd.cpu =3D cpu;
=2D    cmd.reg =3D reg;
=2D
=2D    smp_call_function(msr_smp_rdmsr, &cmd, 1, 1);
=2D   =20
=2D    *eax =3D cmd.data[0];
=2D    *edx =3D cmd.data[1];
+  cmd.cpu =3D cpu;
+  cmd.reg =3D reg;
+
+  on_each_cpu(msr_smp_rdmsr, &cmd, 1, 1);
+
+  *eax =3D cmd.data[0];
+  *edx =3D cmd.data[1];
=20
=2D    return cmd.err;
=2D  }
+  return cmd.err;
 }
=20
 #else /* ! CONFIG_SMP */
diff -urP linux-2.5.62/arch/i386/kernel/smp.c linux-2.5.62_patched/arch/i38=
6/kernel/smp.c
=2D-- linux-2.5.62/arch/i386/kernel/smp.c	Mon Feb 17 23:55:52 2003
+++ linux-2.5.62_patched/arch/i386/kernel/smp.c	Sat Feb 22 02:02:17 2003
@@ -436,7 +436,7 @@
 	preempt_enable();
 }
=20
=2Dstatic inline void do_flush_tlb_all_local(void)
+void do_flush_tlb_all(void* info)
 {
 	unsigned long cpu =3D smp_processor_id();
=20
@@ -445,18 +445,9 @@
 		leave_mm(cpu);
 }
=20
=2Dstatic void flush_tlb_all_ipi(void* info)
=2D{
=2D	do_flush_tlb_all_local();
=2D}
=2D
 void flush_tlb_all(void)
 {
=2D	preempt_disable();
=2D	smp_call_function (flush_tlb_all_ipi,0,1,1);
=2D
=2D	do_flush_tlb_all_local();
=2D	preempt_enable();
+	on_each_cpu(do_flush_tlb_all, 0, 1, 1);
 }
=20
 /*
diff -urP linux-2.5.62/arch/i386/kernel/sysenter.c linux-2.5.62_patched/arc=
h/i386/kernel/sysenter.c
=2D-- linux-2.5.62/arch/i386/kernel/sysenter.c	Mon Feb 17 23:57:19 2003
+++ linux-2.5.62_patched/arch/i386/kernel/sysenter.c	Sat Feb 22 02:02:17 20=
03
@@ -95,8 +95,7 @@
 		return 0;
=20
 	memcpy((void *) page, sysent, sizeof(sysent));
=2D	enable_sep_cpu(NULL);
=2D	smp_call_function(enable_sep_cpu, NULL, 1, 1);
+	on_each_cpu(enable_sep_cpu, NULL, 1, 1);
 	return 0;
 }
=20
diff -urP linux-2.5.62/arch/i386/mach-voyager/voyager_smp.c linux-2.5.62_pa=
tched/arch/i386/mach-voyager/voyager_smp.c
=2D-- linux-2.5.62/arch/i386/mach-voyager/voyager_smp.c	Mon Feb 17 23:56:12=
 2003
+++ linux-2.5.62_patched/arch/i386/mach-voyager/voyager_smp.c	Sat Feb 22 02=
:02:17 2003
@@ -1209,8 +1209,8 @@
 		smp_call_function_interrupt();
 }
=20
=2Dstatic inline void
=2Ddo_flush_tlb_all_local(void)
+void
+do_flush_tlb_all(void* info)
 {
 	unsigned long cpu =3D smp_processor_id();
=20
@@ -1220,19 +1220,11 @@
 }
=20
=20
=2Dstatic void
=2Dflush_tlb_all_function(void* info)
=2D{
=2D	do_flush_tlb_all_local();
=2D}
=2D
 /* flush the TLB of every active CPU in the system */
 void
 flush_tlb_all(void)
 {
=2D	smp_call_function (flush_tlb_all_function, 0, 1, 1);
=2D
=2D	do_flush_tlb_all_local();
+	on_each_cpu(do_flush_tlb_all, 0, 1, 1);
 }
=20
 /* used to set up the trampoline for other CPUs when the memory manager
diff -urP linux-2.5.62/arch/i386/mm/pageattr.c linux-2.5.62_patched/arch/i3=
86/mm/pageattr.c
=2D-- linux-2.5.62/arch/i386/mm/pageattr.c	Mon Feb 17 23:56:13 2003
+++ linux-2.5.62_patched/arch/i386/mm/pageattr.c	Sat Feb 22 02:02:17 2003
@@ -130,11 +130,8 @@
 }=20
=20
 static inline void flush_map(void)
=2D{=09
=2D#ifdef CONFIG_SMP=20
=2D	smp_call_function(flush_kernel_map, NULL, 1, 1);
=2D#endif=09
=2D	flush_kernel_map(NULL);
+{
+	on_each_cpu(flush_kernel_map, NULL, 1, 1);
 }
=20
 struct deferred_page {=20
diff -urP linux-2.5.62/arch/i386/oprofile/nmi_int.c linux-2.5.62_patched/ar=
ch/i386/oprofile/nmi_int.c
=2D-- linux-2.5.62/arch/i386/oprofile/nmi_int.c	Mon Feb 17 23:56:59 2003
+++ linux-2.5.62_patched/arch/i386/oprofile/nmi_int.c	Sat Feb 22 02:02:17 2=
003
@@ -95,8 +95,7 @@
 	 * without actually triggering any NMIs as this will
 	 * break the core code horrifically.
 	 */
=2D	smp_call_function(nmi_cpu_setup, NULL, 0, 1);
=2D	nmi_cpu_setup(0);
+	on_each_cpu(nmi_cpu_setup, NULL, 0, 1);
 	set_nmi_callback(nmi_callback);
 	oprofile_pmdev =3D set_nmi_pm_callback(oprofile_pm_callback);
 	return 0;
@@ -148,8 +147,7 @@
 {
 	unset_nmi_pm_callback(oprofile_pmdev);
 	unset_nmi_callback();
=2D	smp_call_function(nmi_cpu_shutdown, NULL, 0, 1);
=2D	nmi_cpu_shutdown(0);
+	on_each_cpu(nmi_cpu_shutdown, NULL, 0, 1);
 }
=20
 =20
@@ -162,8 +160,7 @@
=20
 static int nmi_start(void)
 {
=2D	smp_call_function(nmi_cpu_start, NULL, 0, 1);
=2D	nmi_cpu_start(0);
+	on_each_cpu(nmi_cpu_start, NULL, 0, 1);
 	return 0;
 }
 =20
@@ -177,8 +174,7 @@
 =20
 static void nmi_stop(void)
 {
=2D	smp_call_function(nmi_cpu_stop, NULL, 0, 1);
=2D	nmi_cpu_stop(0);
+	on_each_cpu(nmi_cpu_stop, NULL, 0, 1);
 }
=20
=20
diff -urP linux-2.5.62/arch/ia64/kernel/smp.c linux-2.5.62_patched/arch/ia6=
4/kernel/smp.c
=2D-- linux-2.5.62/arch/ia64/kernel/smp.c	Mon Feb 17 23:57:19 2003
+++ linux-2.5.62_patched/arch/ia64/kernel/smp.c	Sat Feb 22 02:02:17 2003
@@ -206,18 +206,18 @@
 void
 smp_flush_tlb_all (void)
 {
=2D	smp_call_function((void (*)(void *))local_flush_tlb_all, 0, 1, 1);
=2D	local_flush_tlb_all();
+	on_each_cpu((void (*)(void *))local_flush_tlb_all, 0, 1, 1);
 }
=20
 void
 smp_flush_tlb_mm (struct mm_struct *mm)
 {
=2D	local_finish_flush_tlb_mm(mm);
=2D
 	/* this happens for the common case of a single-threaded fork():  */
 	if (likely(mm =3D=3D current->active_mm && atomic_read(&mm->mm_users) =3D=
=3D 1))
+	{
+		local_finish_flush_tlb_mm(mm);
 		return;
+	}
=20
 	/*
 	 * We could optimize this further by using mm->cpu_vm_mask to track which=
 CPUs
@@ -226,7 +226,7 @@
 	 * anyhow, and once a CPU is interrupted, the cost of local_flush_tlb_all=
() is
 	 * rather trivial.
 	 */
=2D	smp_call_function((void (*)(void *))local_finish_flush_tlb_mm, mm, 1, 1=
);
+	on_each_cpu((void (*)(void *))local_finish_flush_tlb_mm, mm, 1, 1);
 }
=20
 /*
diff -urP linux-2.5.62/arch/mips64/kernel/smp.c linux-2.5.62_patched/arch/m=
ips64/kernel/smp.c
=2D-- linux-2.5.62/arch/mips64/kernel/smp.c	Mon Feb 17 23:56:27 2003
+++ linux-2.5.62_patched/arch/mips64/kernel/smp.c	Sat Feb 22 02:02:17 2003
@@ -195,8 +195,7 @@
=20
 void flush_tlb_all(void)
 {
=2D	smp_call_function(flush_tlb_all_ipi, 0, 1, 1);
=2D	_flush_tlb_all();
+	on_each_cpu(flush_tlb_all_ipi, 0, 1, 1);
 }
=20
 static void flush_tlb_mm_ipi(void *mm)
@@ -219,6 +218,8 @@
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
+	preempt_disable();
+
 	if ((atomic_read(&mm->mm_users) !=3D 1) || (current->mm !=3D mm)) {
 		smp_call_function(flush_tlb_mm_ipi, (void *)mm, 1, 1);
 	} else {
@@ -228,6 +229,8 @@
 				CPU_CONTEXT(i, mm) =3D 0;
 	}
 	_flush_tlb_mm(mm);
+
+	preempt_enable();
 }
=20
 struct flush_tlb_data {
@@ -246,6 +249,8 @@
=20
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsi=
gned long end)
 {
+	preempt_disable();
+
 	if ((atomic_read(&mm->mm_users) !=3D 1) || (current->mm !=3D mm)) {
 		struct flush_tlb_data fd;
=20
@@ -260,6 +265,8 @@
 				CPU_CONTEXT(i, mm) =3D 0;
 	}
 	_flush_tlb_range(mm, start, end);
+
+	preempt_enable();
 }
=20
 static void flush_tlb_page_ipi(void *info)
@@ -271,6 +278,8 @@
=20
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 {
+	preempt_disable();
+
 	if ((atomic_read(&vma->vm_mm->mm_users) !=3D 1) || (current->mm !=3D vma-=
>vm_mm)) {
 		struct flush_tlb_data fd;
=20
@@ -284,5 +293,7 @@
 				CPU_CONTEXT(i, vma->vm_mm) =3D 0;
 	}
 	_flush_tlb_page(vma, page);
+
+	preempt_enable();
 }
=20
diff -urP linux-2.5.62/arch/parisc/kernel/cache.c linux-2.5.62_patched/arch=
/parisc/kernel/cache.c
=2D-- linux-2.5.62/arch/parisc/kernel/cache.c	Mon Feb 17 23:56:13 2003
+++ linux-2.5.62_patched/arch/parisc/kernel/cache.c	Sat Feb 22 02:02:17 2003
@@ -39,8 +39,7 @@
 void
 flush_data_cache(void)
 {
=2D	smp_call_function((void (*)(void *))flush_data_cache_local, NULL, 1, 1);
=2D	flush_data_cache_local();
+	on_each_cpu((void (*)(void *))flush_data_cache_local, NULL, 1, 1);
 }
 #endif
=20
diff -urP linux-2.5.62/arch/parisc/kernel/irq.c linux-2.5.62_patched/arch/p=
arisc/kernel/irq.c
=2D-- linux-2.5.62/arch/parisc/kernel/irq.c	Mon Feb 17 23:56:13 2003
+++ linux-2.5.62_patched/arch/parisc/kernel/irq.c	Sat Feb 22 02:02:17 2003
@@ -61,20 +61,17 @@
=20
 static spinlock_t irq_lock =3D SPIN_LOCK_UNLOCKED;  /* protect IRQ regions=
 */
=20
=2D#ifdef CONFIG_SMP
 static void cpu_set_eiem(void *info)
 {
 	set_eiem((unsigned long) info);
 }
=2D#endif
=20
 static inline void disable_cpu_irq(void *unused, int irq)
 {
 	unsigned long eirr_bit =3D EIEM_MASK(irq);
=20
 	cpu_eiem &=3D ~eirr_bit;
=2D	set_eiem(cpu_eiem);
=2D        smp_call_function(cpu_set_eiem, (void *) cpu_eiem, 1, 1);
+        on_each_cpu(cpu_set_eiem, (void *) cpu_eiem, 1, 1);
 }
=20
 static void enable_cpu_irq(void *unused, int irq)
@@ -83,8 +80,7 @@
=20
 	mtctl(eirr_bit, 23);	/* clear EIRR bit before unmasking */
 	cpu_eiem |=3D eirr_bit;
=2D        smp_call_function(cpu_set_eiem, (void *) cpu_eiem, 1, 1);
=2D	set_eiem(cpu_eiem);
+        on_each_cpu(cpu_set_eiem, (void *) cpu_eiem, 1, 1);
 }
=20
 /* mask and disable are the same at the CPU level
@@ -100,8 +96,7 @@
 	** handle *any* unmasked pending interrupts.
 	** ie We don't need to check for pending interrupts here.
 	*/
=2D        smp_call_function(cpu_set_eiem, (void *) cpu_eiem, 1, 1);
=2D	set_eiem(cpu_eiem);
+        on_each_cpu(cpu_set_eiem, (void *) cpu_eiem, 1, 1);
 }
=20
 /*
diff -urP linux-2.5.62/arch/parisc/kernel/smp.c linux-2.5.62_patched/arch/p=
arisc/kernel/smp.c
=2D-- linux-2.5.62/arch/parisc/kernel/smp.c	Mon Feb 17 23:57:18 2003
+++ linux-2.5.62_patched/arch/parisc/kernel/smp.c	Sat Feb 22 02:02:17 2003
@@ -401,7 +401,7 @@
 __setup("maxcpus=3D", maxcpus);
=20
 /*
=2D * Flush all other CPU's tlb and then mine.  Do this with smp_call_funct=
ion()
+ * Flush all other CPU's tlb and then mine.  Do this with on_each_cpu()
  * as we want to ensure all TLB's flushed before proceeding.
  */
=20
@@ -410,8 +410,7 @@
 void
 smp_flush_tlb_all(void)
 {
=2D	smp_call_function((void (*)(void *))flush_tlb_all_local, NULL, 1, 1);
=2D	flush_tlb_all_local();
+	on_each_cpu((void (*)(void *))flush_tlb_all_local, NULL, 1, 1);
 }
=20
=20
diff -urP linux-2.5.62/arch/parisc/mm/init.c linux-2.5.62_patched/arch/pari=
sc/mm/init.c
=2D-- linux-2.5.62/arch/parisc/mm/init.c	Mon Feb 17 23:56:14 2003
+++ linux-2.5.62_patched/arch/parisc/mm/init.c	Sat Feb 22 02:02:17 2003
@@ -974,8 +974,7 @@
 	    do_recycle++;
 	}
 	spin_unlock(&sid_lock);
=2D	smp_call_function((void (*)(void *))flush_tlb_all_local, NULL, 1, 1);
=2D	flush_tlb_all_local();
+	on_each_cpu((void (*)(void *))flush_tlb_all_local, NULL, 1, 1);
 	if (do_recycle) {
 	    spin_lock(&sid_lock);
 	    recycle_sids(recycle_ndirty,recycle_dirty_array);
diff -urP linux-2.5.62/arch/ppc/kernel/temp.c linux-2.5.62_patched/arch/ppc=
/kernel/temp.c
=2D-- linux-2.5.62/arch/ppc/kernel/temp.c	Mon Feb 17 23:56:16 2003
+++ linux-2.5.62_patched/arch/ppc/kernel/temp.c	Sat Feb 22 02:02:17 2003
@@ -194,10 +194,7 @@
=20
 	/* schedule ourselves to be run again */
 	mod_timer(&tau_timer, jiffies + shrink_timer) ;
=2D#ifdef CONFIG_SMP
=2D	smp_call_function(tau_timeout, NULL, 1, 0);
=2D#endif
=2D	tau_timeout(NULL);
+	on_each_cpu(tau_timeout, NULL, 1, 0);
 }
=20
 /*
@@ -239,10 +236,7 @@
 	tau_timer.expires =3D jiffies + shrink_timer;
 	add_timer(&tau_timer);
 =09
=2D#ifdef CONFIG_SMP
=2D	smp_call_function(TAU_init_smp, NULL, 1, 0);
=2D#endif
=2D	TAU_init_smp(NULL);
+	on_each_cpu(TAU_init_smp, NULL, 1, 0);
 =09
 	printk("Thermal assist unit ");
 #ifdef CONFIG_TAU_INT
diff -urP linux-2.5.62/arch/s390/kernel/smp.c linux-2.5.62_patched/arch/s39=
0/kernel/smp.c
=2D-- linux-2.5.62/arch/s390/kernel/smp.c	Mon Feb 17 23:55:49 2003
+++ linux-2.5.62_patched/arch/s390/kernel/smp.c	Sat Feb 22 02:02:17 2003
@@ -228,8 +228,7 @@
 void machine_restart_smp(char * __unused)=20
 {
 	cpu_restart_map =3D cpu_online_map;
=2D        smp_call_function(do_machine_restart, NULL, 0, 0);
=2D	do_machine_restart(NULL);
+        on_each_cpu(do_machine_restart, NULL, 0, 0);
 }
=20
 static void do_machine_halt(void * __unused)
@@ -247,8 +246,7 @@
=20
 void machine_halt_smp(void)
 {
=2D        smp_call_function(do_machine_halt, NULL, 0, 0);
=2D	do_machine_halt(NULL);
+        on_each_cpu(do_machine_halt, NULL, 0, 0);
 }
=20
 static void do_machine_power_off(void * __unused)
@@ -266,8 +264,7 @@
=20
 void machine_power_off_smp(void)
 {
=2D        smp_call_function(do_machine_power_off, NULL, 0, 0);
=2D	do_machine_power_off(NULL);
+        on_each_cpu(do_machine_power_off, NULL, 0, 0);
 }
=20
 /*
@@ -339,8 +336,7 @@
=20
 void smp_ptlb_all(void)
 {
=2D        smp_call_function(smp_ptlb_callback, NULL, 0, 1);
=2D	local_flush_tlb();
+        on_each_cpu(smp_ptlb_callback, NULL, 0, 1);
 }
=20
 /*
@@ -400,8 +396,7 @@
 	parms.end_ctl =3D cr;
 	parms.orvals[cr] =3D 1 << bit;
 	parms.andvals[cr] =3D 0xFFFFFFFF;
=2D	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
=2D        __ctl_set_bit(cr, bit);
+	on_each_cpu(smp_ctl_bit_callback, &parms, 0, 1);
 }
=20
 /*
@@ -414,8 +409,7 @@
 	parms.end_ctl =3D cr;
 	parms.orvals[cr] =3D 0x00000000;
 	parms.andvals[cr] =3D ~(1 << bit);
=2D	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
=2D        __ctl_clear_bit(cr, bit);
+	on_each_cpu(smp_ctl_bit_callback, &parms, 0, 1);
 }
=20
 /*
diff -urP linux-2.5.62/arch/s390x/kernel/smp.c linux-2.5.62_patched/arch/s3=
90x/kernel/smp.c
=2D-- linux-2.5.62/arch/s390x/kernel/smp.c	Mon Feb 17 23:56:15 2003
+++ linux-2.5.62_patched/arch/s390x/kernel/smp.c	Sat Feb 22 02:02:17 2003
@@ -227,8 +227,7 @@
 void machine_restart_smp(char * __unused)=20
 {
 	cpu_restart_map =3D cpu_online_map;
=2D        smp_call_function(do_machine_restart, NULL, 0, 0);
=2D	do_machine_restart(NULL);
+        on_each_cpu(do_machine_restart, NULL, 0, 0);
 }
=20
 static void do_machine_halt(void * __unused)
@@ -246,8 +245,7 @@
=20
 void machine_halt_smp(void)
 {
=2D        smp_call_function(do_machine_halt, NULL, 0, 0);
=2D	do_machine_halt(NULL);
+        on_each_cpu(do_machine_halt, NULL, 0, 0);
 }
=20
 static void do_machine_power_off(void * __unused)
@@ -265,8 +263,7 @@
=20
 void machine_power_off_smp(void)
 {
=2D        smp_call_function(do_machine_power_off, NULL, 0, 0);
=2D	do_machine_power_off(NULL);
+        on_each_cpu(do_machine_power_off, NULL, 0, 0);
 }
=20
 /*
@@ -383,8 +380,7 @@
 	parms.end_ctl =3D cr;
 	parms.orvals[cr] =3D 1 << bit;
 	parms.andvals[cr] =3D -1L;
=2D	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
=2D        __ctl_set_bit(cr, bit);
+	on_each_cpu(smp_ctl_bit_callback, &parms, 0, 1);
 }
=20
 /*
@@ -397,8 +393,7 @@
 	parms.end_ctl =3D cr;
 	parms.orvals[cr] =3D 0;
 	parms.andvals[cr] =3D ~(1L << bit);
=2D	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
=2D        __ctl_clear_bit(cr, bit);
+	on_each_cpu(smp_ctl_bit_callback, &parms, 0, 1);
 }
=20
=20
diff -urP linux-2.5.62/arch/x86_64/kernel/bluesmoke.c linux-2.5.62_patched/=
arch/x86_64/kernel/bluesmoke.c
=2D-- linux-2.5.62/arch/x86_64/kernel/bluesmoke.c	Mon Feb 17 23:56:55 2003
+++ linux-2.5.62_patched/arch/x86_64/kernel/bluesmoke.c	Sat Feb 22 02:02:18=
 2003
@@ -111,11 +111,7 @@
 {
 	u32 low, high;
 	int i;
=2D	unsigned int *cpu =3D info;
=20
=2D	BUG_ON (*cpu !=3D smp_processor_id());
=2D
=2D	preempt_disable();
 	for (i=3D0; i<banks; i++) {
 		rdmsr(MSR_IA32_MC0_STATUS+i*4, low, high);
=20
@@ -130,20 +126,12 @@
 			wmb();
 		}
 	}
=2D	preempt_enable();
 }
=20
=20
 static void mce_timerfunc (unsigned long data)
 {
=2D	unsigned int i;
=2D
=2D	for (i=3D0; i<smp_num_cpus; i++) {
=2D		if (i =3D=3D smp_processor_id())
=2D			mce_checkregs(&i);
=2D		else
=2D			smp_call_function (mce_checkregs, &i, 1, 1);
=2D	}
+	on_each_cpu (mce_checkregs, NULL, 1, 1);
=20
 	/* Refresh the timer. */
 	mce_timer.expires =3D jiffies + MCE_RATE;
diff -urP linux-2.5.62/arch/x86_64/kernel/cpuid.c linux-2.5.62_patched/arch=
/x86_64/kernel/cpuid.c
=2D-- linux-2.5.62/arch/x86_64/kernel/cpuid.c	Mon Feb 17 23:56:02 2003
+++ linux-2.5.62_patched/arch/x86_64/kernel/cpuid.c	Sat Feb 22 02:02:18 2003
@@ -63,16 +63,12 @@
 static inline void do_cpuid(int cpu, u32 reg, u32 *data)
 {
   struct cpuid_command cmd;
=2D =20
=2D  if ( cpu =3D=3D smp_processor_id() ) {
=2D    cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
=2D  } else {
=2D    cmd.cpu  =3D cpu;
=2D    cmd.reg  =3D reg;
=2D    cmd.data =3D data;
=2D   =20
=2D    smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
=2D  }
+
+  cmd.cpu  =3D cpu;
+  cmd.reg  =3D reg;
+  cmd.data =3D data;
+
+  on_each_cpu(cpuid_smp_cpuid, &cmd, 1, 1);
 }
 #else /* ! CONFIG_SMP */
=20
diff -urP linux-2.5.62/arch/x86_64/kernel/io_apic.c linux-2.5.62_patched/ar=
ch/x86_64/kernel/io_apic.c
=2D-- linux-2.5.62/arch/x86_64/kernel/io_apic.c	Mon Feb 17 23:56:15 2003
+++ linux-2.5.62_patched/arch/x86_64/kernel/io_apic.c	Sat Feb 22 02:02:18 2=
003
@@ -926,8 +926,7 @@
=20
 void print_all_local_APICs (void)
 {
=2D	smp_call_function(print_local_APIC, NULL, 1, 1);
=2D	print_local_APIC(NULL);
+	on_each_cpu(print_local_APIC, NULL, 1, 1);
 }
=20
 void /*__init*/ print_PIC(void)
diff -urP linux-2.5.62/arch/x86_64/kernel/ldt.c linux-2.5.62_patched/arch/x=
86_64/kernel/ldt.c
=2D-- linux-2.5.62/arch/x86_64/kernel/ldt.c	Mon Feb 17 23:56:58 2003
+++ linux-2.5.62_patched/arch/x86_64/kernel/ldt.c	Sat Feb 22 02:02:18 2003
@@ -60,13 +60,13 @@
 	pc->size =3D mincount;
 	wmb();
 	if (reload) {
+		preempt_disable();
 		load_LDT(pc);
 #ifdef CONFIG_SMP
=2D		preempt_disable();
 		if (current->mm->cpu_vm_mask !=3D (1<<smp_processor_id()))
 			smp_call_function(flush_ldt, 0, 1, 1);
=2D		preempt_enable();
 #endif
+		preempt_enable();
 	}
 	if (oldsize) {
 		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
diff -urP linux-2.5.62/arch/x86_64/kernel/msr.c linux-2.5.62_patched/arch/x=
86_64/kernel/msr.c
=2D-- linux-2.5.62/arch/x86_64/kernel/msr.c	Mon Feb 17 23:55:57 2003
+++ linux-2.5.62_patched/arch/x86_64/kernel/msr.c	Sat Feb 22 02:02:18 2003
@@ -120,36 +120,28 @@
 {
   struct msr_command cmd;
=20
=2D  if ( cpu =3D=3D smp_processor_id() ) {
=2D    return wrmsr_eio(reg, eax, edx);
=2D  } else {
=2D    cmd.cpu =3D cpu;
=2D    cmd.reg =3D reg;
=2D    cmd.data[0] =3D eax;
=2D    cmd.data[1] =3D edx;
=2D   =20
=2D    smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
=2D    return cmd.err;
=2D  }
+  cmd.cpu =3D cpu;
+  cmd.reg =3D reg;
+  cmd.data[0] =3D eax;
+  cmd.data[1] =3D edx;
+
+  on_each_cpu(msr_smp_wrmsr, &cmd, 1, 1);
+  return cmd.err;
 }
=20
 static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
 {
   struct msr_command cmd;
=20
=2D  if ( cpu =3D=3D smp_processor_id() ) {
=2D    return rdmsr_eio(reg, eax, edx);
=2D  } else {
=2D    cmd.cpu =3D cpu;
=2D    cmd.reg =3D reg;
=2D
=2D    smp_call_function(msr_smp_rdmsr, &cmd, 1, 1);
=2D   =20
=2D    *eax =3D cmd.data[0];
=2D    *edx =3D cmd.data[1];
+  cmd.cpu =3D cpu;
+  cmd.reg =3D reg;
+
+  on_each_cpu(msr_smp_rdmsr, &cmd, 1, 1);
+
+  *eax =3D cmd.data[0];
+  *edx =3D cmd.data[1];
=20
=2D    return cmd.err;
=2D  }
+  return cmd.err;
 }
=20
 #else /* ! CONFIG_SMP */
diff -urP linux-2.5.62/arch/x86_64/kernel/smp.c linux-2.5.62_patched/arch/x=
86_64/kernel/smp.c
=2D-- linux-2.5.62/arch/x86_64/kernel/smp.c	Mon Feb 17 23:56:09 2003
+++ linux-2.5.62_patched/arch/x86_64/kernel/smp.c	Sat Feb 22 02:02:18 2003
@@ -328,7 +328,7 @@
 	preempt_enable();
 }
=20
=2Dstatic inline void do_flush_tlb_all_local(void)
+void do_flush_tlb_all(void* info)
 {
 	unsigned long cpu =3D smp_processor_id();
=20
@@ -337,16 +337,9 @@
 		leave_mm(cpu);
 }
=20
=2Dstatic void flush_tlb_all_ipi(void* info)
=2D{
=2D	do_flush_tlb_all_local();
=2D}
=2D
 void flush_tlb_all(void)
 {
=2D	smp_call_function (flush_tlb_all_ipi,0,1,1);
=2D
=2D	do_flush_tlb_all_local();
+	on_each_cpu(do_flush_tlb_all, 0, 1, 1);
 }
=20
 void smp_kdb_stop(void)
diff -urP linux-2.5.62/arch/x86_64/mm/pageattr.c linux-2.5.62_patched/arch/=
x86_64/mm/pageattr.c
=2D-- linux-2.5.62/arch/x86_64/mm/pageattr.c	Mon Feb 17 23:56:14 2003
+++ linux-2.5.62_patched/arch/x86_64/mm/pageattr.c	Sat Feb 22 02:02:18 2003
@@ -122,11 +122,8 @@
 }=20
=20
 static inline void flush_map(unsigned long address)
=2D{=09
=2D#ifdef CONFIG_SMP=20
=2D	smp_call_function(flush_kernel_map, (void *)address, 1, 1);
=2D#endif=09
=2D	flush_kernel_map((void *)address);
+{
+	on_each_cpu(flush_kernel_map, (void *)address, 1, 1);
 }
=20
 struct deferred_page {=20
diff -urP linux-2.5.62/drivers/char/agp/agp.h linux-2.5.62_patched/drivers/=
char/agp/agp.h
=2D-- linux-2.5.62/drivers/char/agp/agp.h	Mon Feb 17 23:56:13 2003
+++ linux-2.5.62_patched/drivers/char/agp/agp.h	Sat Feb 22 02:02:18 2003
@@ -34,24 +34,10 @@
=20
 #define PFX "agpgart: "
=20
=2D#ifdef CONFIG_SMP
=2Dstatic void ipi_handler(void *null)
=2D{
=2D	flush_agp_cache();
=2D}
=2D
=2Dstatic void __attribute__((unused)) global_cache_flush(void)
=2D{
=2D	if (smp_call_function(ipi_handler, NULL, 1, 1) !=3D 0)
=2D		panic(PFX "timed out waiting for the other CPUs!\n");
=2D	flush_agp_cache();
=2D}
=2D#else
 static inline void global_cache_flush(void)
 {
=2D	flush_agp_cache();
+	on_each_cpu(flush_agp_cache, NULL, 1, 1);
 }
=2D#endif	/* !CONFIG_SMP */
=20
 enum aper_size_type {
 	U8_APER_SIZE,
diff -urP linux-2.5.62/drivers/s390/char/sclp.c linux-2.5.62_patched/driver=
s/s390/char/sclp.c
=2D-- linux-2.5.62/drivers/s390/char/sclp.c	Mon Feb 17 23:56:20 2003
+++ linux-2.5.62_patched/drivers/s390/char/sclp.c	Sat Feb 22 02:02:18 2003
@@ -481,8 +481,7 @@
 do_machine_quiesce(void)
 {
 	cpu_quiesce_map =3D cpu_online_map;
=2D	smp_call_function(do_load_quiesce_psw, NULL, 0, 0);
=2D	do_load_quiesce_psw(NULL);
+	on_each_cpu(do_load_quiesce_psw, NULL, 0, 0);
 }
 #else
 static void
diff -urP linux-2.5.62/drivers/s390/net/iucv.c linux-2.5.62_patched/drivers=
/s390/net/iucv.c
=2D-- linux-2.5.62/drivers/s390/net/iucv.c	Mon Feb 17 23:55:52 2003
+++ linux-2.5.62_patched/drivers/s390/net/iucv.c	Sat Feb 22 02:02:18 2003
@@ -617,10 +617,7 @@
 	ulong b2f0_result =3D 0x0deadbeef;
=20
 	iucv_debug(1, "entering");
=2D	if (smp_processor_id() =3D=3D 0)
=2D		iucv_declare_buffer_cpu0(&b2f0_result);
=2D	else
=2D		smp_call_function(iucv_declare_buffer_cpu0, &b2f0_result, 0, 1);
+	on_each_cpu(iucv_declare_buffer_cpu0, &b2f0_result, 0, 1);
 	iucv_debug(1, "Address of EIB =3D %p", iucv_external_int_buffer);
 	if (b2f0_result =3D=3D 0x0deadbeef)
 	    b2f0_result =3D 0xaa;
@@ -639,10 +636,7 @@
 {
 	iucv_debug(1, "entering");
 	if (declare_flag) {
=2D		if (smp_processor_id() =3D=3D 0)
=2D			iucv_retrieve_buffer_cpu0(0);
=2D		else
=2D			smp_call_function(iucv_retrieve_buffer_cpu0, 0, 0, 1);
+		on_each_cpu(iucv_retrieve_buffer_cpu0, 0, 0, 1);
 		declare_flag =3D 0;
 	}
 	iucv_debug(1, "exiting");
diff -urP linux-2.5.62/fs/buffer.c linux-2.5.62_patched/fs/buffer.c
=2D-- linux-2.5.62/fs/buffer.c	Mon Feb 17 23:56:17 2003
+++ linux-2.5.62_patched/fs/buffer.c	Sat Feb 22 02:02:18 2003
@@ -1404,10 +1404,7 @@
 =09
 static void invalidate_bh_lrus(void)
 {
=2D	preempt_disable();
=2D	invalidate_bh_lru(NULL);
=2D	smp_call_function(invalidate_bh_lru, NULL, 1, 1);
=2D	preempt_enable();
+	on_each_cpu(invalidate_bh_lru, NULL, 1, 1);
 }
=20
 void set_bh_page(struct buffer_head *bh,
diff -urP linux-2.5.62/include/asm-alpha/agp.h linux-2.5.62_patched/include=
/asm-alpha/agp.h
=2D-- linux-2.5.62/include/asm-alpha/agp.h	Mon Feb 17 23:55:50 2003
+++ linux-2.5.62_patched/include/asm-alpha/agp.h	Sat Feb 22 02:02:18 2003
@@ -8,6 +8,10 @@
 #define map_page_into_agp(page)=20
 #define unmap_page_from_agp(page)=20
 #define flush_agp_mappings()=20
=2D#define flush_agp_cache() mb()
+
+static void flush_agp_cache(void* info)
+{
+	mb();
+}
=20
 #endif
diff -urP linux-2.5.62/include/asm-i386/agp.h linux-2.5.62_patched/include/=
asm-i386/agp.h
=2D-- linux-2.5.62/include/asm-i386/agp.h	Mon Feb 17 23:55:49 2003
+++ linux-2.5.62_patched/include/asm-i386/agp.h	Sat Feb 22 02:02:18 2003
@@ -18,6 +18,9 @@
 /* Could use CLFLUSH here if the cpu supports it. But then it would
    need to be called for each cacheline of the whole page so it may not be=
=20
    worth it. Would need a page for it. */
=2D#define flush_agp_cache() asm volatile("wbinvd":::"memory")
+static void flush_agp_cache(void *info)
+{
+	__asm__ __volatile__ ("wbinvd": : :"memory");
+}
=20
 #endif
diff -urP linux-2.5.62/include/asm-ia64/agp.h linux-2.5.62_patched/include/=
asm-ia64/agp.h
=2D-- linux-2.5.62/include/asm-ia64/agp.h	Mon Feb 17 23:56:15 2003
+++ linux-2.5.62_patched/include/asm-ia64/agp.h	Sat Feb 22 02:02:18 2003
@@ -16,7 +16,14 @@
 #define map_page_into_agp(page)		/* nothing */
 #define unmap_page_from_agp(page)	/* nothing */
 #define flush_agp_mappings()		/* nothing */
=2D#define flush_agp_cache()		mb()
+
+/* Could use CLFLUSH here if the cpu supports it. But then it would
+   need to be called for each cacheline of the whole page so it may not be=
=20
+   worth it. Would need a page for it. */
+static void flush_agp_cache(void* info)
+{
+	mb();
+}
=20
 /* Page-protection value to be used for AGP memory mapped into kernel spac=
e.  */
 #define PAGE_AGP			PAGE_KERNEL
diff -urP linux-2.5.62/include/asm-parisc/cacheflush.h linux-2.5.62_patched=
/include/asm-parisc/cacheflush.h
=2D-- linux-2.5.62/include/asm-parisc/cacheflush.h	Mon Feb 17 23:57:01 2003
+++ linux-2.5.62_patched/include/asm-parisc/cacheflush.h	Sat Feb 22 02:02:1=
8 2003
@@ -25,16 +25,10 @@
=20
 extern void flush_cache_all_local(void);
=20
=2D#ifdef CONFIG_SMP
 static inline void flush_cache_all(void)
 {
=2D	smp_call_function((void (*)(void *))flush_cache_all_local, NULL, 1, 1);
=2D	flush_cache_all_local();
+	on_each_cpu((void (*)(void *))flush_cache_all_local, NULL, 1, 1);
 }
=2D#else
=2D#define flush_cache_all flush_cache_all_local
=2D#endif
=2D
=20
 /* The following value needs to be tuned and probably scaled with the
  * cache size.
diff -urP linux-2.5.62/include/asm-sparc64/agp.h linux-2.5.62_patched/inclu=
de/asm-sparc64/agp.h
=2D-- linux-2.5.62/include/asm-sparc64/agp.h	Mon Feb 17 23:55:55 2003
+++ linux-2.5.62_patched/include/asm-sparc64/agp.h	Sat Feb 22 02:02:18 2003
@@ -6,6 +6,13 @@
 #define map_page_into_agp(page)=20
 #define unmap_page_from_agp(page)=20
 #define flush_agp_mappings()=20
=2D#define flush_agp_cache() mb()
+
+/* Could use CLFLUSH here if the cpu supports it. But then it would
+   need to be called for each cacheline of the whole page so it may not be=
=20
+   worth it. Would need a page for it. */
+static void flush_agp_cache(void* info)
+{
+	mb();
+}
=20
 #endif
diff -urP linux-2.5.62/include/asm-x86_64/agp.h linux-2.5.62_patched/includ=
e/asm-x86_64/agp.h
=2D-- linux-2.5.62/include/asm-x86_64/agp.h	Mon Feb 17 23:55:49 2003
+++ linux-2.5.62_patched/include/asm-x86_64/agp.h	Sat Feb 22 02:02:18 2003
@@ -18,6 +18,9 @@
 /* Could use CLFLUSH here if the cpu supports it. But then it would
    need to be called for each cacheline of the whole page so it may not be=
=20
    worth it. Would need a page for it. */
=2D#define flush_agp_cache() asm volatile("wbinvd":::"memory")
+static void flush_agp_cache(void* info)
+{
+	__asm__ __volatile__ ("wbinvd": : :"memory");
+}
=20
 #endif
diff -urP linux-2.5.62/include/linux/smp.h linux-2.5.62_patched/include/lin=
ux/smp.h
=2D-- linux-2.5.62/include/linux/smp.h	Mon Feb 17 23:56:16 2003
+++ linux-2.5.62_patched/include/linux/smp.h	Sat Feb 22 02:06:57 2003
@@ -10,9 +10,10 @@
=20
 #ifdef CONFIG_SMP
=20
+#include <linux/preempt.h>
 #include <linux/kernel.h>
 #include <linux/compiler.h>
=2D#include <linux/threads.h>
+#include <linux/thread_info.h>
 #include <asm/smp.h>
 #include <asm/bug.h>
=20
@@ -54,6 +55,31 @@
 			      int retry, int wait);
=20
 /*
+ * Call a function on all processors
+ */
+static inline int on_each_cpu(void (*func) (void *info), void *info,
+			      int retry, int wait)
+{
+	int ret =3D 0;
+
+	preempt_disable();
+
+	if(num_online_cpus() =3D=3D 1)
+		goto only_one;
+
+	ret =3D smp_call_function(func, info, retry, wait);
+	if(ret !=3D 0)
+		printk(KERN_ERR "%p: IPI timeout, giving up\n",
+			__builtin_return_address(0));
+
+only_one:
+	func(info);
+	preempt_enable();
+
+	return ret;
+}
+
+/*
  * True once the per process idle is forked
  */
 extern int smp_threads_ready;
@@ -96,6 +122,7 @@
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
 #define smp_call_function(func,info,retry,wait)	({ 0; })
+#define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define cpu_online_map				1
diff -urP linux-2.5.62/mm/slab.c linux-2.5.62_patched/mm/slab.c
=2D-- linux-2.5.62/mm/slab.c	Mon Feb 17 23:56:45 2003
+++ linux-2.5.62_patched/mm/slab.c	Sat Feb 22 02:02:18 2003
@@ -1116,12 +1116,16 @@
 static void smp_call_function_all_cpus(void (*func) (void *arg), void *arg)
 {
 	check_irq_on();
+	preempt_disable();
+
 	local_irq_disable();
 	func(arg);
 	local_irq_enable();
=20
 	if (smp_call_function(func, arg, 1, 1))
 		BUG();
+
+	preempt_enable();
 }
=20
 static void free_block (kmem_cache_t* cachep, void** objpp, int len);

--Boundary-01=_60uV+wU2X3FsvYg--

--Boundary-03=_E1uV+LvHN9DKJcG
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Vu1DYAiN+WRIZzQRAstkAJ0e3ZtPSBDLqZwSeSdPw5wqhHXDfACg9MNI
2OYqGu+1GEd8KNIad2cfr8k=
=1smC
-----END PGP SIGNATURE-----

--Boundary-03=_E1uV+LvHN9DKJcG--

