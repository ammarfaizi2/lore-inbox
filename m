Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289376AbSAVTrA>; Tue, 22 Jan 2002 14:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289377AbSAVTqs>; Tue, 22 Jan 2002 14:46:48 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:53889 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S289375AbSAVTq2>;
	Tue, 22 Jan 2002 14:46:28 -0500
Date: Tue, 22 Jan 2002 20:47:38 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Richard Gooch <rgooch@atnf.csiro.au>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix MTRR inconsistencies on Intel SMT CPUs
Message-ID: <Pine.LNX.4.33.0201222042430.3728-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch: Fix MTRR inconsistencies on Intel SMT (Foster, Prestonia) CPUs

The two logical CPUs in an Intel SMT CPU share their MTRR registers.
The implementation of set_mtrr_smp() in arch/i386/mtrr.c assumes that
each processor has its own MTRR registers. This can lead to incionsistencies
in the MTRR serttings on SMP systems.

This simple patch fixes this by making sure that only one of the
logical CPUs writes to the MTRR registers,
using the fact that the apic id of the CPUs differs by 1.

This may not be a perfect solution, but it fixes the problem (machine becomes
horribly sluggish after modifying the MTRRs e.g. at X startup) on my machine.

This patch is against 2.4.17.

Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>

--- include/asm-i386/processor.h.orig	Thu Nov 22 20:46:19 2001
+++ include/asm-i386/processor.h	Tue Jan 22 20:33:52 2002
@@ -90,6 +90,7 @@
 #define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  boot_cpu_data.x86_capability))
 #define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  boot_cpu_data.x86_capability))
 #define cpu_has_apic	(test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
+#define cpu_has_ht      (test_bit(X86_FEATURE_HT,   boot_cpu_data.x86_capability))

 extern char ignore_irq13;

--- arch/i386/kernel/mtrr.c.orig	Fri Nov  9 22:58:02 2001
+++ arch/i386/kernel/mtrr.c	Tue Jan 22 20:35:57 2002
@@ -378,7 +378,7 @@
 static int arr3_protected;

 /*  Put the processor into a state where MTRRs can be safely set  */
-static void set_mtrr_prepare (struct set_mtrr_context *ctxt)
+static void set_mtrr_prepare (struct set_mtrr_context *ctxt, int doit)
 {
     unsigned long tmp;

@@ -406,7 +406,8 @@
     if ( mtrr_if == MTRR_IF_INTEL ) {
 	/*  Disable MTRRs, and set the default type to uncached  */
 	rdmsr (MTRRdefType_MSR, ctxt->deftype_lo, ctxt->deftype_hi);
-	wrmsr (MTRRdefType_MSR, ctxt->deftype_lo & 0xf300UL, ctxt->deftype_hi);
+	if (doit)
+	     wrmsr (MTRRdefType_MSR, ctxt->deftype_lo & 0xf300UL, ctxt->deftype_hi);
     } else {
 	/* Cyrix ARRs - everything else were excluded at the top */
 	tmp = getCx86 (CX86_CCR3);
@@ -416,7 +417,7 @@
 }   /*  End Function set_mtrr_prepare  */

 /*  Restore the processor after a set_mtrr_prepare  */
-static void set_mtrr_done (struct set_mtrr_context *ctxt)
+static void set_mtrr_done (struct set_mtrr_context *ctxt, int doit)
 {
     if ( mtrr_if != MTRR_IF_INTEL && mtrr_if != MTRR_IF_CYRIX_ARR ) {
 	 __restore_flags (ctxt->flags);
@@ -427,7 +428,7 @@
     wbinvd();

     /*  Restore MTRRdefType  */
-    if ( mtrr_if == MTRR_IF_INTEL ) {
+    if ( mtrr_if == MTRR_IF_INTEL && doit ) {
 	/* Intel (P6) standard MTRRs */
 	wrmsr (MTRRdefType_MSR, ctxt->deftype_lo, ctxt->deftype_hi);
     } else {
@@ -674,7 +675,7 @@
 {
     struct set_mtrr_context ctxt;

-    if (do_safe) set_mtrr_prepare (&ctxt);
+    if (do_safe) set_mtrr_prepare (&ctxt, 1);
     if (size == 0)
     {
 	/* The invalid bit is kept in the mask, so we simply clear the
@@ -688,7 +689,7 @@
 	wrmsr (MTRRphysMask_MSR (reg), -size << PAGE_SHIFT | 0x800,
 		(-size & size_and_mask) >> (32 - PAGE_SHIFT));
     }
-    if (do_safe) set_mtrr_done (&ctxt);
+    if (do_safe) set_mtrr_done (&ctxt, 1);
 }   /*  End Function intel_set_mtrr_up  */

 static void cyrix_set_arr_up (unsigned int reg, unsigned long base,
@@ -726,13 +727,13 @@
 	}
     }

-    if (do_safe) set_mtrr_prepare (&ctxt);
+    if (do_safe) set_mtrr_prepare (&ctxt, 1);
     base <<= PAGE_SHIFT;
     setCx86(arr,    ((unsigned char *) &base)[3]);
     setCx86(arr+1,  ((unsigned char *) &base)[2]);
     setCx86(arr+2, (((unsigned char *) &base)[1]) | arr_size);
     setCx86(CX86_RCR_BASE + reg, arr_type);
-    if (do_safe) set_mtrr_done (&ctxt);
+    if (do_safe) set_mtrr_done (&ctxt, 1);
 }   /*  End Function cyrix_set_arr_up  */

 static void amd_set_mtrr_up (unsigned int reg, unsigned long base,
@@ -750,7 +751,7 @@
     u32 regs[2];
     struct set_mtrr_context ctxt;

-    if (do_safe) set_mtrr_prepare (&ctxt);
+    if (do_safe) set_mtrr_prepare (&ctxt, 1);
     /*
      *	Low is MTRR0 , High MTRR 1
      */
@@ -777,7 +778,7 @@
      */
 	wbinvd();
 	wrmsr (MSR_K6_UWCCR, regs[0], regs[1]);
-    if (do_safe) set_mtrr_done (&ctxt);
+    if (do_safe) set_mtrr_done (&ctxt, 1);
 }   /*  End Function amd_set_mtrr_up  */


@@ -788,7 +789,7 @@
     struct set_mtrr_context ctxt;
     unsigned long low, high;

-    if (do_safe) set_mtrr_prepare( &ctxt );
+    if (do_safe) set_mtrr_prepare( &ctxt, 1 );
     if (size == 0)
     {
         /*  Disable  */
@@ -810,7 +811,7 @@
     centaur_mcr[reg].high = high;
     centaur_mcr[reg].low = low;
     wrmsr (MSR_IDT_MCR0 + reg, low, high);
-    if (do_safe) set_mtrr_done( &ctxt );
+    if (do_safe) set_mtrr_done( &ctxt, 1 );
 }   /*  End Function centaur_set_mtrr_up  */

 static void (*set_mtrr_up) (unsigned int reg, unsigned long base,
@@ -1003,19 +1004,21 @@
 {
     struct set_mtrr_data *data = info;
     struct set_mtrr_context ctxt;
+    int doit = !(cpu_has_ht && (x86_cpu_to_apicid[smp_processor_id ()] & 1U));

-    set_mtrr_prepare (&ctxt);
+    set_mtrr_prepare (&ctxt, doit);
     /*  Notify master that I've flushed and disabled my cache  */
     atomic_dec (&undone_count);
     while (wait_barrier_execute) barrier ();
     /*  The master has cleared me to execute  */
-    (*set_mtrr_up) (data->smp_reg, data->smp_base, data->smp_size,
-		    data->smp_type, FALSE);
+    if (doit)
+	 (*set_mtrr_up) (data->smp_reg, data->smp_base, data->smp_size,
+			 data->smp_type, FALSE);
     /*  Notify master CPU that I've executed the function  */
     atomic_dec (&undone_count);
     /*  Wait for master to clear me to enable cache and return  */
     while (wait_barrier_cache_enable) barrier ();
-    set_mtrr_done (&ctxt);
+    set_mtrr_done (&ctxt, doit);
 }   /*  End Function ipi_handler  */

 static void set_mtrr_smp (unsigned int reg, unsigned long base,
@@ -1023,6 +1026,7 @@
 {
     struct set_mtrr_data data;
     struct set_mtrr_context ctxt;
+    int doit = !(cpu_has_ht && (x86_cpu_to_apicid[smp_processor_id ()] & 1U));

     data.smp_reg = reg;
     data.smp_base = base;
@@ -1035,20 +1039,21 @@
     if (smp_call_function (ipi_handler, &data, 1, 0) != 0)
 	panic ("mtrr: timed out waiting for other CPUs\n");
     /* Flush and disable the local CPU's cache */
-    set_mtrr_prepare (&ctxt);
+    set_mtrr_prepare (&ctxt, doit);
     /*  Wait for all other CPUs to flush and disable their caches  */
     while (atomic_read (&undone_count) > 0) barrier ();
     /* Set up for completion wait and then release other CPUs to change MTRRs*/
     atomic_set (&undone_count, smp_num_cpus - 1);
     wait_barrier_execute = FALSE;
-    (*set_mtrr_up) (reg, base, size, type, FALSE);
+    if (doit)
+	 (*set_mtrr_up) (reg, base, size, type, FALSE);
     /*  Now wait for other CPUs to complete the function  */
     while (atomic_read (&undone_count) > 0) barrier ();
     /*  Now all CPUs should have finished the function. Release the barrier to
 	allow them to re-enable their caches and return from their interrupt,
 	then enable the local cache and return  */
     wait_barrier_cache_enable = FALSE;
-    set_mtrr_done (&ctxt);
+    set_mtrr_done (&ctxt, doit);
 }   /*  End Function set_mtrr_smp  */


@@ -1889,7 +1894,7 @@
     struct set_mtrr_context ctxt;
     int i;

-    set_mtrr_prepare (&ctxt); /* flush cache and enable MAPEN */
+    set_mtrr_prepare (&ctxt, 1); /* flush cache and enable MAPEN */

      /* the CCRs are not contiguous */
     for(i=0; i<4; i++) setCx86(CX86_CCR0 + i, ccr_state[i]);
@@ -1898,7 +1903,7 @@
       cyrix_set_arr_up(i,
         arr_state[i].base, arr_state[i].size, arr_state[i].type, FALSE);

-    set_mtrr_done (&ctxt); /* flush cache and disable MAPEN */
+    set_mtrr_done (&ctxt, 1); /* flush cache and disable MAPEN */
 }   /*  End Function cyrix_arr_init_secondary  */

 #endif
@@ -1926,7 +1931,7 @@
     int i;
 #endif

-    set_mtrr_prepare (&ctxt); /* flush cache and enable MAPEN */
+    set_mtrr_prepare (&ctxt, 1); /* flush cache and enable MAPEN */

     /* Save all CCRs locally */
     ccr[0] = getCx86 (CX86_CCR0);
@@ -1975,7 +1980,7 @@
         &arr_state[i].base, &arr_state[i].size, &arr_state[i].type);
 #endif

-    set_mtrr_done (&ctxt); /* flush cache and disable MAPEN */
+    set_mtrr_done (&ctxt, 1); /* flush cache and disable MAPEN */

     if ( ccrc[5] ) printk ("mtrr: ARR usage was not enabled, enabled manually\n");
     if ( ccrc[3] ) printk ("mtrr: ARR3 cannot be changed\n");
@@ -2075,14 +2080,14 @@
 {
     struct set_mtrr_context ctxt;

-    set_mtrr_prepare (&ctxt);
+    set_mtrr_prepare (&ctxt, 1);

     if(boot_cpu_data.x86_model==4)
     	centaur_mcr0_init();
     else if(boot_cpu_data.x86_model==8 || boot_cpu_data.x86_model == 9)
     	centaur_mcr1_init();

-    set_mtrr_done (&ctxt);
+    set_mtrr_done (&ctxt, 1);
 }   /*  End Function centaur_mcr_init  */

 static int __init mtrr_setup(void)
@@ -2192,9 +2197,9 @@
     /*  Note that this is not ideal, since the cache is only flushed/disabled
 	for this CPU while the MTRRs are changed, but changing this requires
 	more invasive changes to the way the kernel boots  */
-    set_mtrr_prepare (&ctxt);
+    set_mtrr_prepare (&ctxt, 1);
     mask = set_mtrr_state (&smp_mtrr_state, &ctxt);
-    set_mtrr_done (&ctxt);
+    set_mtrr_done (&ctxt, 1);
     /*  Use the atomic bitops to update the global mask  */
     for (count = 0; count < sizeof mask * 8; ++count)
     {




