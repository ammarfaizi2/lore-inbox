Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287881AbSAMFwo>; Sun, 13 Jan 2002 00:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287971AbSAMFwZ>; Sun, 13 Jan 2002 00:52:25 -0500
Received: from [202.135.142.194] ([202.135.142.194]:51718 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S287881AbSAMFwJ>; Sun, 13 Jan 2002 00:52:09 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, paulus@samba.org,
        rth@twiddle.net
Subject: Re: [PATCH] New per-cpu patch v2.5.1 
In-Reply-To: Your message of "Thu, 20 Dec 2001 17:43:35 +0530."
             <20011220174335.A10791@in.ibm.com> 
Date: Sun, 13 Jan 2002 16:52:18 +1100
Message-Id: <E16PdZ4-0004fD-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20011220174335.A10791@in.ibm.com> you write:
> Hi Rusty,
> 
> I appreciate the noble gesture of allowing NUMA people to
> locate the per-cpu areas in different places in memory ;-)
> 
> That said, memcpy of static per-cpu areas doesn't seem right.
> Why copy the same area to all the dynamically allocated per-cpu
> areas ? Also, shouldn't the size be &__per_cpu_end - &__per_cpu_start ?
> And how do we use this with per-cpu data used right
> from smp boot, say apic_timer_irqs[] ?

New patch... this one is better, but runs into the same gcc
assumptions about doing pointer arith outside the object.  Now, noone
is putting string literals in the per-cpu areas, but medium-term we
probably need the arch-specific asm hack to stop bogosity.

By Anton's request, an arch can define __HAVE_ARCH_CPU_OFFSET if it
wants to store each CPU's offset in a spare register to save a mem
access.

If no complaints, I'd like this in 2.5 soon, so we can start using it.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.2-pre10/arch/i386/vmlinux.lds working-2.5.2-pre10-percpu/arch/i386/vmlinux.lds
--- linux-2.5.2-pre10/arch/i386/vmlinux.lds	Tue Jul  3 07:40:14 2001
+++ working-2.5.2-pre10-percpu/arch/i386/vmlinux.lds	Tue Jan  8 14:23:46 2002
@@ -50,6 +50,10 @@
   __initcall_start = .;
   .initcall.init : { *(.initcall.init) }
   __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.2-pre10/arch/ppc/vmlinux.lds working-2.5.2-pre10-percpu/arch/ppc/vmlinux.lds
--- linux-2.5.2-pre10/arch/ppc/vmlinux.lds	Tue Aug 28 23:58:33 2001
+++ working-2.5.2-pre10-percpu/arch/ppc/vmlinux.lds	Tue Jan  8 14:23:46 2002
@@ -96,6 +96,10 @@
   __initcall_start = .;
   .initcall.init : { *(.initcall.init) }
   __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.2-pre10/include/linux/smp.h working-2.5.2-pre10-percpu/include/linux/smp.h
--- linux-2.5.2-pre10/include/linux/smp.h	Tue Jan  8 11:49:34 2002
+++ working-2.5.2-pre10-percpu/include/linux/smp.h	Tue Jan  8 14:38:09 2002
@@ -71,7 +71,17 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
-#else
+#define __per_cpu_data	__attribute__((section(".data.percpu")))
+
+#ifndef __HAVE_ARCH_CPU_OFFSET
+#define per_cpu_offset(cpu) (__per_cpu_offset[(cpu)])
+#endif
+
+#define per_cpu(var, cpu)						  \
+(*(__typeof__(&var)((void *)&var + per_cpu_offset(cpu))))
+
+extern unsigned long __per_cpu_offset[NR_CPUS];
+#else /* !SMP */
 
 /*
  *	These macros fold the SMP functionality into a single CPU system
@@ -88,6 +98,10 @@
 #define cpu_online_map				1
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
+#define __per_cpu_data
+#define per_cpu(var, cpu)			var
 
 #endif
+
+#define this_cpu(var)				per_cpu(var,smp_processor_id())
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.2-pre10/init/main.c working-2.5.2-pre10-percpu/init/main.c
--- linux-2.5.2-pre10/init/main.c	Tue Jan  8 11:49:34 2002
+++ working-2.5.2-pre10-percpu/init/main.c	Tue Jan  8 14:38:19 2002
@@ -305,10 +305,36 @@
 
 #else
 
+unsigned long __per_cpu_offset[NR_CPUS];
+/* Created by linker magic */
+extern char __per_cpu_start, __per_cpu_end;
+
+static void setup_per_cpu_areas(void)
+{
+	unsigned int i;
+	size_t per_cpu_size;
+	char *region;
+	
+	/* Set up per-CPU offset pointers.  Page align to be safe. */
+	per_cpu_size = ((&__per_cpu_end - &__per_cpu_start) + PAGE_SIZE-1)
+		& ~(PAGE_SIZE-1);
+	region = kmalloc(per_cpu_size * smp_num_cpus, GFP_KERNEL);
+	if (!region)
+		panic("Could not allocate per-cpu regions: %u bytes\n",
+		      per_cpu_size * smp_num_cpus);
+	for (i = 0; i < smp_num_cpus; i++) {
+		memcpy(region + per_cpu_size*i, &__per_cpu_start,
+		       &__per_cpu_end - &__per_cpu_start);
+		__per_cpu_offset[i] 
+			= (region + per_cpu_size*i) - &__per_cpu_start;
+	}
+}
 
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
+	setup_per_cpu_areas();
+
 	/* Get other processors into their bootup holding patterns. */
 	smp_boot_cpus();
 	wait_init_idle = cpu_online_map;
