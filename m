Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284776AbRLEWL2>; Wed, 5 Dec 2001 17:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284770AbRLEWLR>; Wed, 5 Dec 2001 17:11:17 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:6 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S284533AbRLEWIq>;
	Wed, 5 Dec 2001 17:08:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: [PATCH] 2.5.1-pre5: per-cpu areas
Date: Thu, 06 Dec 2001 09:09:35 +1100
Message-Id: <E16BkER-0006J0-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch implements convenient per-cpu areas:
    DECLARE_PER_CPU(int myvar);

    ...
    this_cpu(myvar) = 1;

    for (i = 0; i < NR_CPUS; i++)
	per_cpu(myvar, i) = 0;


Good: Simply referring to "myvar" won't work (even on Uniprocessor), so
that mistake is prevented.  Unreferenced variables are warned like
normal (almost).

Bad: Initialization isn't possible in the declaration.  Only
implemented for PPC and x86, but fix is trivial for other
architectures.  Implementation is icky, but getting the linker to
duplicate per-cpu section itself without symbols is beyond my skill.

Feedback appreciated,
Rusty.
--
  Anyone who quotes me is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/linux/smp.h working-2.5.1-pre5-percpu/include/linux/smp.h
--- linux-2.5.1-pre5/include/linux/smp.h	Wed Dec  5 16:49:14 2001
+++ working-2.5.1-pre5-percpu/include/linux/smp.h	Wed Dec  5 18:21:06 2001
@@ -71,7 +71,36 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
+#define __PER_CPU(decl,num)	decl##__##num \
+				__attribute__((section(".data.cpu" #num)))
+
+#if NR_CPUS == 32
+#define PER_CPU(decl)		__PER_CPU(decl, 0); __PER_CPU(decl, 1);	  \
+				__PER_CPU(decl, 2); __PER_CPU(decl, 3);	  \
+				__PER_CPU(decl, 4); __PER_CPU(decl, 5);	  \
+				__PER_CPU(decl, 6); __PER_CPU(decl, 7);	  \
+				__PER_CPU(decl, 8); __PER_CPU(decl, 9);	  \
+				__PER_CPU(decl, 10); __PER_CPU(decl, 11); \
+				__PER_CPU(decl, 12); __PER_CPU(decl, 13); \
+				__PER_CPU(decl, 14); __PER_CPU(decl, 15); \
+				__PER_CPU(decl, 16); __PER_CPU(decl, 17); \
+				__PER_CPU(decl, 18); __PER_CPU(decl, 19); \
+				__PER_CPU(decl, 20); __PER_CPU(decl, 21); \
+				__PER_CPU(decl, 22); __PER_CPU(decl, 23); \
+				__PER_CPU(decl, 24); __PER_CPU(decl, 25); \
+				__PER_CPU(decl, 26); __PER_CPU(decl, 27); \
+				__PER_CPU(decl, 28); __PER_CPU(decl, 29); \
+				__PER_CPU(decl, 30); __PER_CPU(decl, 31)
 #else
+#error NR_CPUS not 32: fix linux/smp.h.
+#endif /* NR_CPUS */
+
+extern void *per_cpu_sections[NR_CPUS];
+
+#define per_cpu(var, cpu)						     \
+*(__typeof__(&var)(&var##__0 - per_cpu_sections[0]) + per_cpu_sections[cpu])
+
+#else /* !SMP */
 
 /*
  *	These macros fold the SMP functionality into a single CPU system
@@ -86,6 +115,10 @@
 #define cpu_number_map(cpu)			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define cpu_online_map				1
-
+#define PER_CPU(decl)				decl
+#define per_cpu(var, cpu)			var
 #endif
+
+#define this_cpu(var)				per_cpu(var,smp_processor_id())
+
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/init/main.c working-2.5.1-pre5-percpu/init/main.c
--- linux-2.5.1-pre5/init/main.c	Tue Dec  4 17:17:28 2001
+++ working-2.5.1-pre5-percpu/init/main.c	Wed Dec  5 17:41:56 2001
@@ -499,6 +499,19 @@
 
 #else
 
+#if NR_CPUS != 32
+#error NR_CPUS not 32: fix init/main.c.
+#endif
+/* Created by linker magic */
+extern void *__cpu0, *__cpu1, *__cpu2, *__cpu3, 
+	*__cpu4, *__cpu5, *__cpu6, *__cpu7, 
+	*__cpu8, *__cpu9, *__cpu10, *__cpu11, 
+	*__cpu12, *__cpu13, *__cpu14, *__cpu15, 
+	*__cpu16, *__cpu17, *__cpu18, *__cpu19, 
+	*__cpu20, *__cpu21, *__cpu22, *__cpu23, 
+	*__cpu24, *__cpu25, *__cpu26, *__cpu27, 
+	*__cpu28, *__cpu29, *__cpu30, *__cpu31;
+void *per_cpu_sections[NR_CPUS];
 
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
@@ -518,6 +531,24 @@
 		barrier();
 	}
 	printk("All processors have done init_idle\n");
+
+	/* Set up per-CPU section pointers */
+	per_cpu_sections[0] = &__cpu0; per_cpu_sections[1] = &__cpu1;
+	per_cpu_sections[2] = &__cpu2; per_cpu_sections[3] = &__cpu3;
+	per_cpu_sections[4] = &__cpu4; per_cpu_sections[5] = &__cpu5;
+	per_cpu_sections[6] = &__cpu6; per_cpu_sections[7] = &__cpu7;
+	per_cpu_sections[8] = &__cpu8; per_cpu_sections[9] = &__cpu9;
+	per_cpu_sections[10] = &__cpu10; per_cpu_sections[11] = &__cpu11;
+	per_cpu_sections[12] = &__cpu12; per_cpu_sections[13] = &__cpu13;
+	per_cpu_sections[14] = &__cpu14; per_cpu_sections[15] = &__cpu15;
+	per_cpu_sections[16] = &__cpu16; per_cpu_sections[17] = &__cpu17;
+	per_cpu_sections[18] = &__cpu18; per_cpu_sections[19] = &__cpu19;
+	per_cpu_sections[20] = &__cpu20; per_cpu_sections[21] = &__cpu21;
+	per_cpu_sections[22] = &__cpu22; per_cpu_sections[23] = &__cpu23;
+	per_cpu_sections[24] = &__cpu24; per_cpu_sections[25] = &__cpu25;
+	per_cpu_sections[26] = &__cpu26; per_cpu_sections[27] = &__cpu27;
+	per_cpu_sections[28] = &__cpu28; per_cpu_sections[29] = &__cpu29;
+	per_cpu_sections[30] = &__cpu30; per_cpu_sections[31] = &__cpu31;
 }
 
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/i386/vmlinux.lds working-2.5.1-pre5-percpu/arch/i386/vmlinux.lds
--- linux-2.5.1-pre5/arch/i386/vmlinux.lds	Tue Jul  3 07:40:14 2001
+++ working-2.5.1-pre5-percpu/arch/i386/vmlinux.lds	Wed Dec  5 18:03:50 2001
@@ -34,6 +34,40 @@
 	CONSTRUCTORS
 	}
 
+  /* Per-cpu sections: cache-line aligned */
+  . = ALIGN(32); __cpu0 = .; .data.cpu0  : { *(.data.cpu0) }
+  . = ALIGN(32); __cpu1 = .; .data.cpu1  : { *(.data.cpu1) }
+  . = ALIGN(32); __cpu2 = .; .data.cpu2  : { *(.data.cpu2) }
+  . = ALIGN(32); __cpu3 = .; .data.cpu3  : { *(.data.cpu3) }
+  . = ALIGN(32); __cpu4 = .; .data.cpu4  : { *(.data.cpu4) }
+  . = ALIGN(32); __cpu5 = .; .data.cpu5  : { *(.data.cpu5) }
+  . = ALIGN(32); __cpu6 = .; .data.cpu6  : { *(.data.cpu6) }
+  . = ALIGN(32); __cpu7 = .; .data.cpu7  : { *(.data.cpu7) }
+  . = ALIGN(32); __cpu8 = .; .data.cpu8  : { *(.data.cpu8) }
+  . = ALIGN(32); __cpu9 = .; .data.cpu9  : { *(.data.cpu9) }
+  . = ALIGN(32); __cpu10 = .; .data.cpu10  : { *(.data.cpu10) }
+  . = ALIGN(32); __cpu11 = .; .data.cpu11  : { *(.data.cpu11) }
+  . = ALIGN(32); __cpu12 = .; .data.cpu12  : { *(.data.cpu12) }
+  . = ALIGN(32); __cpu13 = .; .data.cpu13  : { *(.data.cpu13) }
+  . = ALIGN(32); __cpu14 = .; .data.cpu14  : { *(.data.cpu14) }
+  . = ALIGN(32); __cpu15 = .; .data.cpu15  : { *(.data.cpu15) }
+  . = ALIGN(32); __cpu16 = .; .data.cpu16  : { *(.data.cpu16) }
+  . = ALIGN(32); __cpu17 = .; .data.cpu17  : { *(.data.cpu17) }
+  . = ALIGN(32); __cpu18 = .; .data.cpu18  : { *(.data.cpu18) }
+  . = ALIGN(32); __cpu19 = .; .data.cpu19  : { *(.data.cpu19) }
+  . = ALIGN(32); __cpu20 = .; .data.cpu20  : { *(.data.cpu20) }
+  . = ALIGN(32); __cpu21 = .; .data.cpu21  : { *(.data.cpu21) }
+  . = ALIGN(32); __cpu22 = .; .data.cpu22  : { *(.data.cpu22) }
+  . = ALIGN(32); __cpu23 = .; .data.cpu23  : { *(.data.cpu23) }
+  . = ALIGN(32); __cpu24 = .; .data.cpu24  : { *(.data.cpu24) }
+  . = ALIGN(32); __cpu25 = .; .data.cpu25  : { *(.data.cpu25) }
+  . = ALIGN(32); __cpu26 = .; .data.cpu26  : { *(.data.cpu26) }
+  . = ALIGN(32); __cpu27 = .; .data.cpu27  : { *(.data.cpu27) }
+  . = ALIGN(32); __cpu28 = .; .data.cpu28  : { *(.data.cpu28) }
+  . = ALIGN(32); __cpu29 = .; .data.cpu29  : { *(.data.cpu29) }
+  . = ALIGN(32); __cpu30 = .; .data.cpu30  : { *(.data.cpu30) }
+  . = ALIGN(32); __cpu31 = .; .data.cpu31  : { *(.data.cpu31) }
+
   _edata = .;			/* End of data section */
 
   . = ALIGN(8192);		/* init_task */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/ppc/vmlinux.lds working-2.5.1-pre5-percpu/arch/ppc/vmlinux.lds
--- linux-2.5.1-pre5/arch/ppc/vmlinux.lds	Tue Aug 28 23:58:33 2001
+++ working-2.5.1-pre5-percpu/arch/ppc/vmlinux.lds	Wed Dec  5 18:03:57 2001
@@ -58,6 +58,41 @@
     *(.dynamic)
     CONSTRUCTORS
   }
+
+  /* Per-cpu sections: cache-line aligned */
+  . = ALIGN(32); __cpu0 = .; .data.cpu0  : { *(.data.cpu0) }
+  . = ALIGN(32); __cpu1 = .; .data.cpu1  : { *(.data.cpu1) }
+  . = ALIGN(32); __cpu2 = .; .data.cpu2  : { *(.data.cpu2) }
+  . = ALIGN(32); __cpu3 = .; .data.cpu3  : { *(.data.cpu3) }
+  . = ALIGN(32); __cpu4 = .; .data.cpu4  : { *(.data.cpu4) }
+  . = ALIGN(32); __cpu5 = .; .data.cpu5  : { *(.data.cpu5) }
+  . = ALIGN(32); __cpu6 = .; .data.cpu6  : { *(.data.cpu6) }
+  . = ALIGN(32); __cpu7 = .; .data.cpu7  : { *(.data.cpu7) }
+  . = ALIGN(32); __cpu8 = .; .data.cpu8  : { *(.data.cpu8) }
+  . = ALIGN(32); __cpu9 = .; .data.cpu9  : { *(.data.cpu9) }
+  . = ALIGN(32); __cpu10 = .; .data.cpu10  : { *(.data.cpu10) }
+  . = ALIGN(32); __cpu11 = .; .data.cpu11  : { *(.data.cpu11) }
+  . = ALIGN(32); __cpu12 = .; .data.cpu12  : { *(.data.cpu12) }
+  . = ALIGN(32); __cpu13 = .; .data.cpu13  : { *(.data.cpu13) }
+  . = ALIGN(32); __cpu14 = .; .data.cpu14  : { *(.data.cpu14) }
+  . = ALIGN(32); __cpu15 = .; .data.cpu15  : { *(.data.cpu15) }
+  . = ALIGN(32); __cpu16 = .; .data.cpu16  : { *(.data.cpu16) }
+  . = ALIGN(32); __cpu17 = .; .data.cpu17  : { *(.data.cpu17) }
+  . = ALIGN(32); __cpu18 = .; .data.cpu18  : { *(.data.cpu18) }
+  . = ALIGN(32); __cpu19 = .; .data.cpu19  : { *(.data.cpu19) }
+  . = ALIGN(32); __cpu20 = .; .data.cpu20  : { *(.data.cpu20) }
+  . = ALIGN(32); __cpu21 = .; .data.cpu21  : { *(.data.cpu21) }
+  . = ALIGN(32); __cpu22 = .; .data.cpu22  : { *(.data.cpu22) }
+  . = ALIGN(32); __cpu23 = .; .data.cpu23  : { *(.data.cpu23) }
+  . = ALIGN(32); __cpu24 = .; .data.cpu24  : { *(.data.cpu24) }
+  . = ALIGN(32); __cpu25 = .; .data.cpu25  : { *(.data.cpu25) }
+  . = ALIGN(32); __cpu26 = .; .data.cpu26  : { *(.data.cpu26) }
+  . = ALIGN(32); __cpu27 = .; .data.cpu27  : { *(.data.cpu27) }
+  . = ALIGN(32); __cpu28 = .; .data.cpu28  : { *(.data.cpu28) }
+  . = ALIGN(32); __cpu29 = .; .data.cpu29  : { *(.data.cpu29) }
+  . = ALIGN(32); __cpu30 = .; .data.cpu30  : { *(.data.cpu30) }
+  . = ALIGN(32); __cpu31 = .; .data.cpu31  : { *(.data.cpu31) }
+
   _edata  =  .;
   PROVIDE (edata = .);
 
