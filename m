Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268304AbTBYR7W>; Tue, 25 Feb 2003 12:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268314AbTBYR7W>; Tue, 25 Feb 2003 12:59:22 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:48585 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S268304AbTBYR7A>; Tue, 25 Feb 2003 12:59:00 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] fix preempt-issues with smp_call_function()
Date: Tue, 25 Feb 2003 19:08:48 +0100
User-Agent: KMail/1.5
Cc: Dave Jones <davej@codemonkey.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_2E7W+LIafZ0ri3r";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200302251908.55097.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_2E7W+LIafZ0ri3r
Content-Type: multipart/mixed;
  boundary="Boundary-01=_wE7W+3FOPXa9Yot"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_wE7W+3FOPXa9Yot
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hello,

here is a patch to solve all (I hope I missed none) possible problems that=
=20
could occur on SMP machines running a preemptible kernel when=20
smp_call_function() calls a function which should be also executed on the=20
current processor.

This patch is based on the one Dave Jones sent to the LKML last friday and=
=20
applies to the linux kernel version 2.5.63.

Thank you for any response...

    Thomas Schlichter

--Boundary-01=_wE7W+3FOPXa9Yot
Content-Type: text/x-diff;
  charset="us-ascii";
  name="preempt_fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="preempt_fix.patch"

diff -urP linux-2.5.63/arch/alpha/kernel/process.c linux-2.5.63_patched/arc=
h/alpha/kernel/process.c
=2D-- linux-2.5.63/arch/alpha/kernel/process.c	Mon Feb 24 20:05:42 2003
+++ linux-2.5.63_patched/arch/alpha/kernel/process.c	Mon Feb 24 23:02:43 20=
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
diff -urP linux-2.5.63/arch/alpha/kernel/smp.c linux-2.5.63_patched/arch/al=
pha/kernel/smp.c
=2D-- linux-2.5.63/arch/alpha/kernel/smp.c	Mon Feb 24 20:05:14 2003
+++ linux-2.5.63_patched/arch/alpha/kernel/smp.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/i386/kernel/io_apic.c linux-2.5.63_patched/arch=
/i386/kernel/io_apic.c
=2D-- linux-2.5.63/arch/i386/kernel/io_apic.c	Mon Feb 24 20:05:15 2003
+++ linux-2.5.63_patched/arch/i386/kernel/io_apic.c	Mon Feb 24 23:02:43 2003
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
@@ -1843,8 +1842,7 @@
 	 */=20
 	printk(KERN_INFO "activating NMI Watchdog ...");
=20
=2D	smp_call_function(enable_NMI_through_LVT0, NULL, 1, 1);
=2D	enable_NMI_through_LVT0(NULL);
+	on_each_cpu(enable_NMI_through_LVT0, NULL, 1, 1);
=20
 	printk(" done.\n");
 }
diff -urP linux-2.5.63/arch/i386/kernel/ldt.c linux-2.5.63_patched/arch/i38=
6/kernel/ldt.c
=2D-- linux-2.5.63/arch/i386/kernel/ldt.c	Mon Feb 24 20:05:38 2003
+++ linux-2.5.63_patched/arch/i386/kernel/ldt.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/i386/kernel/microcode.c linux-2.5.63_patched/ar=
ch/i386/kernel/microcode.c
=2D-- linux-2.5.63/arch/i386/kernel/microcode.c	Mon Feb 24 20:05:12 2003
+++ linux-2.5.63_patched/arch/i386/kernel/microcode.c	Mon Feb 24 23:02:32 2=
003
@@ -183,11 +183,10 @@
 	int i, error =3D 0, err;
 	struct microcode *m;
=20
=2D	if (smp_call_function(do_update_one, NULL, 1, 1) !=3D 0) {
+	if (on_each_cpu(do_update_one, NULL, 1, 1) !=3D 0) {
 		printk(KERN_ERR "microcode: IPI timeout, giving up\n");
 		return -EIO;
 	}
=2D	do_update_one(NULL);
=20
 	for (i=3D0; i<NR_CPUS; i++) {
 		err =3D update_req[i].err;
diff -urP linux-2.5.63/arch/i386/kernel/smp.c linux-2.5.63_patched/arch/i38=
6/kernel/smp.c
=2D-- linux-2.5.63/arch/i386/kernel/smp.c	Mon Feb 24 20:05:06 2003
+++ linux-2.5.63_patched/arch/i386/kernel/smp.c	Mon Feb 24 23:02:43 2003
@@ -436,7 +436,7 @@
 	preempt_enable();
 }
=20
=2Dstatic inline void do_flush_tlb_all_local(void)
+static void do_flush_tlb_all(void* info)
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
diff -urP linux-2.5.63/arch/i386/kernel/sysenter.c linux-2.5.63_patched/arc=
h/i386/kernel/sysenter.c
=2D-- linux-2.5.63/arch/i386/kernel/sysenter.c	Mon Feb 24 20:06:02 2003
+++ linux-2.5.63_patched/arch/i386/kernel/sysenter.c	Mon Feb 24 23:02:43 20=
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
diff -urP linux-2.5.63/arch/i386/mach-voyager/voyager_smp.c linux-2.5.63_pa=
tched/arch/i386/mach-voyager/voyager_smp.c
=2D-- linux-2.5.63/arch/i386/mach-voyager/voyager_smp.c	Mon Feb 24 20:05:16=
 2003
+++ linux-2.5.63_patched/arch/i386/mach-voyager/voyager_smp.c	Mon Feb 24 23=
:02:43 2003
@@ -1209,8 +1209,8 @@
 		smp_call_function_interrupt();
 }
=20
=2Dstatic inline void
=2Ddo_flush_tlb_all_local(void)
+static void
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
diff -urP linux-2.5.63/arch/i386/mm/pageattr.c linux-2.5.63_patched/arch/i3=
86/mm/pageattr.c
=2D-- linux-2.5.63/arch/i386/mm/pageattr.c	Mon Feb 24 20:05:29 2003
+++ linux-2.5.63_patched/arch/i386/mm/pageattr.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/i386/oprofile/nmi_int.c linux-2.5.63_patched/ar=
ch/i386/oprofile/nmi_int.c
=2D-- linux-2.5.63/arch/i386/oprofile/nmi_int.c	Mon Feb 24 20:05:44 2003
+++ linux-2.5.63_patched/arch/i386/oprofile/nmi_int.c	Mon Feb 24 23:02:43 2=
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
diff -urP linux-2.5.63/arch/ia64/kernel/smp.c linux-2.5.63_patched/arch/ia6=
4/kernel/smp.c
=2D-- linux-2.5.63/arch/ia64/kernel/smp.c	Mon Feb 24 20:06:01 2003
+++ linux-2.5.63_patched/arch/ia64/kernel/smp.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/mips64/kernel/smp.c linux-2.5.63_patched/arch/m=
ips64/kernel/smp.c
=2D-- linux-2.5.63/arch/mips64/kernel/smp.c	Mon Feb 24 20:05:38 2003
+++ linux-2.5.63_patched/arch/mips64/kernel/smp.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/parisc/kernel/cache.c linux-2.5.63_patched/arch=
/parisc/kernel/cache.c
=2D-- linux-2.5.63/arch/parisc/kernel/cache.c	Mon Feb 24 20:05:29 2003
+++ linux-2.5.63_patched/arch/parisc/kernel/cache.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/parisc/kernel/irq.c linux-2.5.63_patched/arch/p=
arisc/kernel/irq.c
=2D-- linux-2.5.63/arch/parisc/kernel/irq.c	Mon Feb 24 20:05:16 2003
+++ linux-2.5.63_patched/arch/parisc/kernel/irq.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/parisc/kernel/smp.c linux-2.5.63_patched/arch/p=
arisc/kernel/smp.c
=2D-- linux-2.5.63/arch/parisc/kernel/smp.c	Mon Feb 24 20:06:01 2003
+++ linux-2.5.63_patched/arch/parisc/kernel/smp.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/parisc/mm/init.c linux-2.5.63_patched/arch/pari=
sc/mm/init.c
=2D-- linux-2.5.63/arch/parisc/mm/init.c	Mon Feb 24 20:05:32 2003
+++ linux-2.5.63_patched/arch/parisc/mm/init.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/ppc/kernel/temp.c linux-2.5.63_patched/arch/ppc=
/kernel/temp.c
=2D-- linux-2.5.63/arch/ppc/kernel/temp.c	Mon Feb 24 20:05:33 2003
+++ linux-2.5.63_patched/arch/ppc/kernel/temp.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/s390/kernel/smp.c linux-2.5.63_patched/arch/s39=
0/kernel/smp.c
=2D-- linux-2.5.63/arch/s390/kernel/smp.c	Mon Feb 24 20:05:05 2003
+++ linux-2.5.63_patched/arch/s390/kernel/smp.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/s390x/kernel/smp.c linux-2.5.63_patched/arch/s3=
90x/kernel/smp.c
=2D-- linux-2.5.63/arch/s390x/kernel/smp.c	Mon Feb 24 20:05:32 2003
+++ linux-2.5.63_patched/arch/s390x/kernel/smp.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/x86_64/kernel/bluesmoke.c linux-2.5.63_patched/=
arch/x86_64/kernel/bluesmoke.c
=2D-- linux-2.5.63/arch/x86_64/kernel/bluesmoke.c	Mon Feb 24 20:05:43 2003
+++ linux-2.5.63_patched/arch/x86_64/kernel/bluesmoke.c	Mon Feb 24 23:02:43=
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
diff -urP linux-2.5.63/arch/x86_64/kernel/io_apic.c linux-2.5.63_patched/ar=
ch/x86_64/kernel/io_apic.c
=2D-- linux-2.5.63/arch/x86_64/kernel/io_apic.c	Mon Feb 24 20:05:32 2003
+++ linux-2.5.63_patched/arch/x86_64/kernel/io_apic.c	Mon Feb 24 23:02:43 2=
003
@@ -928,8 +928,7 @@
=20
 void print_all_local_APICs (void)
 {
=2D	smp_call_function(print_local_APIC, NULL, 1, 1);
=2D	print_local_APIC(NULL);
+	on_each_cpu(print_local_APIC, NULL, 1, 1);
 }
=20
 void /*__init*/ print_PIC(void)
diff -urP linux-2.5.63/arch/x86_64/kernel/ldt.c linux-2.5.63_patched/arch/x=
86_64/kernel/ldt.c
=2D-- linux-2.5.63/arch/x86_64/kernel/ldt.c	Mon Feb 24 20:05:44 2003
+++ linux-2.5.63_patched/arch/x86_64/kernel/ldt.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/arch/x86_64/kernel/smp.c linux-2.5.63_patched/arch/x=
86_64/kernel/smp.c
=2D-- linux-2.5.63/arch/x86_64/kernel/smp.c	Mon Feb 24 20:05:13 2003
+++ linux-2.5.63_patched/arch/x86_64/kernel/smp.c	Mon Feb 24 23:02:43 2003
@@ -328,7 +328,7 @@
 	preempt_enable();
 }
=20
=2Dstatic inline void do_flush_tlb_all_local(void)
+static void do_flush_tlb_all(void* info)
 {
 	unsigned long cpu =3D smp_processor_id();
=20
@@ -337,18 +337,9 @@
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
 void smp_kdb_stop(void)
diff -urP linux-2.5.63/arch/x86_64/mm/pageattr.c linux-2.5.63_patched/arch/=
x86_64/mm/pageattr.c
=2D-- linux-2.5.63/arch/x86_64/mm/pageattr.c	Mon Feb 24 20:05:32 2003
+++ linux-2.5.63_patched/arch/x86_64/mm/pageattr.c	Mon Feb 24 23:02:43 2003
@@ -123,12 +123,7 @@
=20
 static inline void flush_map(unsigned long address)
 {=09
=2D	preempt_disable();
=2D#ifdef CONFIG_SMP=20
=2D	smp_call_function(flush_kernel_map, (void *)address, 1, 1);
=2D#endif=09
=2D	flush_kernel_map((void *)address);
=2D	preempt_enable();
+	on_each_cpu(flush_kernel_map, (void *)address, 1, 1);
 }
=20
 struct deferred_page {=20
diff -urP linux-2.5.63/drivers/char/agp/agp.h linux-2.5.63_patched/drivers/=
char/agp/agp.h
=2D-- linux-2.5.63/drivers/char/agp/agp.h	Mon Feb 24 20:05:29 2003
+++ linux-2.5.63_patched/drivers/char/agp/agp.h	Mon Feb 24 23:02:43 2003
@@ -42,9 +42,8 @@
=20
 static void __attribute__((unused)) global_cache_flush(void)
 {
=2D	if (smp_call_function(ipi_handler, NULL, 1, 1) !=3D 0)
+	if (on_each_cpu(ipi_handler, NULL, 1, 1) !=3D 0)
 		panic(PFX "timed out waiting for the other CPUs!\n");
=2D	flush_agp_cache();
 }
 #else
 static inline void global_cache_flush(void)
diff -urP linux-2.5.63/drivers/s390/char/sclp.c linux-2.5.63_patched/driver=
s/s390/char/sclp.c
=2D-- linux-2.5.63/drivers/s390/char/sclp.c	Mon Feb 24 20:05:35 2003
+++ linux-2.5.63_patched/drivers/s390/char/sclp.c	Mon Feb 24 23:02:43 2003
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
diff -urP linux-2.5.63/fs/buffer.c linux-2.5.63_patched/fs/buffer.c
=2D-- linux-2.5.63/fs/buffer.c	Mon Feb 24 20:05:34 2003
+++ linux-2.5.63_patched/fs/buffer.c	Mon Feb 24 23:02:43 2003
@@ -1403,10 +1403,7 @@
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
diff -urP linux-2.5.63/include/asm-parisc/cacheflush.h linux-2.5.63_patched=
/include/asm-parisc/cacheflush.h
=2D-- linux-2.5.63/include/asm-parisc/cacheflush.h	Mon Feb 24 20:05:47 2003
+++ linux-2.5.63_patched/include/asm-parisc/cacheflush.h	Mon Feb 24 23:02:4=
3 2003
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
diff -urP linux-2.5.63/include/linux/smp.h linux-2.5.63_patched/include/lin=
ux/smp.h
=2D-- linux-2.5.63/include/linux/smp.h	Mon Feb 24 20:05:33 2003
+++ linux-2.5.63_patched/include/linux/smp.h	Mon Feb 24 23:02:44 2003
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
@@ -54,6 +55,25 @@
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
+	if(num_online_cpus() > 1)
+		ret =3D smp_call_function(func, info, retry, wait);
+	func(info);
+
+	preempt_enable();
+
+	return ret;
+}
+
+/*
  * True once the per process idle is forked
  */
 extern int smp_threads_ready;
@@ -96,6 +116,7 @@
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
 #define smp_call_function(func,info,retry,wait)	({ 0; })
+#define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define cpu_online_map				1
diff -urP linux-2.5.63/mm/slab.c linux-2.5.63_patched/mm/slab.c
=2D-- linux-2.5.63/mm/slab.c	Mon Feb 24 20:05:39 2003
+++ linux-2.5.63_patched/mm/slab.c	Mon Feb 24 23:02:44 2003
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

--Boundary-01=_wE7W+3FOPXa9Yot--

--Boundary-03=_2E7W+LIafZ0ri3r
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+W7E2YAiN+WRIZzQRAusNAKDHMFPpMaJ+cX9JoHxN/grVOrn/agCfRpkR
M7Np9tNGk0K9hNTZUaRv5Fk=
=cRWE
-----END PGP SIGNATURE-----

--Boundary-03=_2E7W+LIafZ0ri3r--

