Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287518AbSA3AsD>; Tue, 29 Jan 2002 19:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287552AbSA3Ary>; Tue, 29 Jan 2002 19:47:54 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:26897 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S287518AbSA3Arm>; Tue, 29 Jan 2002 19:47:42 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6 
In-Reply-To: Your message of "Tue, 29 Jan 2002 14:21:50 -0800."
             <3C57207E.28598C1F@zip.com.au> 
Date: Wed, 30 Jan 2002 11:48:16 +1100
Message-Id: <E16VivB-0005sI-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C57207E.28598C1F@zip.com.au> you write:
> Rusty Russell wrote:
> > Yes.  But for a large amount of code it doesn't matter, and most
> > architectures don't know how many CPUs there are before smp_init().
> > Of course, we could make it NR_CPUS...
> 
> I don't think there's a need.  You can use .data.percpu directly
> for the boot CPU, dynamically allocate storage for the others.
> This actually saves one CPU's worth of memory :)

No it doesn't: we discard the original anyway (it's within the init
section).  You also destroy the "derive smp_processor_id from per-cpu
pointer register" idea by making them non-contiguous.

>  unsigned long __per_cpu_offset[NR_CPUS] = { (unsigned long *)&__per_cpu_star
t, };
> 
> Then each CPU has, at all times, a valid personal __per_cpu_offset[]
> entry.   The only restriction is that the boot CPU cannot
> touch other CPU's per-cpu data before those CPUs are brought
> up.

You still can't use anything like the slab allocator in
eg. cpu_init(), which is inviting trouble.  I think we really are best
off allocating up front and avoiding this whole mess.  Patch below
(no, it won't boot at the moment, since the per_cpu area will be size
0, and that hits a BUG() in alloc_bootmem, but if you put something in
it it works).

Other patches to follow...
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/arch/i386/vmlinux.lds working-2.5.3-pre6-percpu/arch/i386/vmlinux.lds
--- linux-2.5.3-pre6/arch/i386/vmlinux.lds	Tue Jan 29 09:16:52 2002
+++ working-2.5.3-pre6-percpu/arch/i386/vmlinux.lds	Wed Jan 30 10:17:38 2002
@@ -58,6 +58,10 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/arch/ppc/vmlinux.lds working-2.5.3-pre6-percpu/arch/ppc/vmlinux.lds
--- linux-2.5.3-pre6/arch/ppc/vmlinux.lds	Tue Jan 29 09:16:53 2002
+++ working-2.5.3-pre6-percpu/arch/ppc/vmlinux.lds	Wed Jan 30 10:17:38 2002
@@ -104,6 +104,10 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/include/linux/smp.h working-2.5.3-pre6-percpu/include/linux/smp.h
--- linux-2.5.3-pre6/include/linux/smp.h	Thu Jan 17 16:35:24 2002
+++ working-2.5.3-pre6-percpu/include/linux/smp.h	Wed Jan 30 10:17:38 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/init/main.c working-2.5.3-pre6-percpu/init/main.c
--- linux-2.5.3-pre6/init/main.c	Tue Jan 29 09:17:09 2002
+++ working-2.5.3-pre6-percpu/init/main.c	Wed Jan 30 10:43:33 2002
@@ -272,8 +272,33 @@
 #define smp_init()	do { } while (0)
 #endif
 
+static inline void setup_per_cpu_areas(void)
+{
+}
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
+	region = alloc_bootmem_pages(per_cpu_size*NR_CPUS);
+	for (i = 0; i < NR_CPUS; i++) {
+		memcpy(region + per_cpu_size*i, &__per_cpu_start,
+		       &__per_cpu_end - &__per_cpu_start);
+		__per_cpu_offset[i] 
+			= (region + per_cpu_size*i) - &__per_cpu_start;
+	}
+}
+
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
@@ -316,6 +341,7 @@
 	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
+	setup_per_cpu_areas();
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
