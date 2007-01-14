Return-Path: <linux-kernel-owner+w=401wt.eu-S1751133AbXANHAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbXANHAi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 02:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbXANHAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 02:00:38 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:45624 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbXANHAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 02:00:37 -0500
Date: Sat, 13 Jan 2007 23:00:35 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: ak@muc.de, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: [patch] faster vgetcpu using sidt (take 2)
In-Reply-To: <Pine.LNX.4.64.0701061807530.26307@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.64.0701132245260.27121@twinlark.arctic.org>
References: <Pine.LNX.4.64.0701061807530.26307@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok here is the latest rev of this patch (against 2.6.20-rc4).

timings in cycles:

                baseline   patched    baseline   patched
                no cache   no cache    cache      cache
k8 pre-revF        21        16          14        17
k8 revF            31        17          14        17
core2              38        16          12        14
p4                 49        41          24        24

the degredation in cached timings appears to be due to the 16 byte stack
frame set up for the sidt instruction.  apparently due to -mno-red-zone...
would you accept a patch which re-enables the red-zone for vsyscalls?

here is the slightly updated description:

below is a patch which improves vgetcpu latency on all x86_64 
implementations i've tested.

Nathan Laredo pointed out the sgdt/sidt/sldt instructions are 
userland-accessible and we could use their limit fields to tuck away a few 
bits of per-cpu information.

vgetcpu generally uses lsl at present, but all of sgdt/sidt/sldt are
faster than lsl on all x86_64 processors i've tested.  lsl requires
microcoded permission testing whereas s*dt are free of any such hassle.

sldt is the least expensive of the three instructions however it's a 
hassle to use because processes may want to adjust their ldt.  sidt/sgdt 
have essentially the same performance across all the major architectures 
-- however sidt has the advantage that its limit field is 16-bits, yet any 
value >= 0xfff is essentially "infinite" because there are only 256 (16 
byte) descriptors.  so sidt is probably the best choice of the three.

in benchmarking i've discovered the rdtscp implementation of vgetcpu is 
slower than even the lsl-based implementation on opteron revF.  so i've 
dropped the rdtscp implementation in this patch.  however i've left the 
rdtscp_aux register initialized because i'm sure it's the right choice for 
various proposed vgettimeofday / per-cpu tsc state improvements which need 
the atomic nature of the rdtscp instruction and i hope it'll be used in 
those situations.

at compile time this patch detects if 0x1000 + 
(CONFIG_NR_CPUS<<CONFIG_NODES_SHIFT) will fit in the idt limit field and 
selects the lsl method otherwise.  i've further added a test for the 20 
bit limit of the lsl method and #error in the event it doesn't fit (we 
could fall all the way back to cpuid method if someone has a box with that 
many cpus*nodes, but i'll let someone else handle that case ;).

given this is a compile-time choice, and rdtscp is always slower than 
sidt, i've dropped the vgetcpu_mode variable.

timing tools and test case can be found at 
<http://arctic.org/~dean/vgetcpu/>

-dean

Signed-off-by: dean gaudet <dean@arctic.org>

Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c	2007-01-13 22:20:46.000000000 -0800
+++ linux/arch/x86_64/kernel/time.c	2007-01-13 22:21:01.000000000 -0800
@@ -957,11 +957,6 @@
 	if (unsynchronized_tsc())
 		notsc = 1;
 
- 	if (cpu_has(&boot_cpu_data, X86_FEATURE_RDTSCP))
-		vgetcpu_mode = VGETCPU_RDTSCP;
-	else
-		vgetcpu_mode = VGETCPU_LSL;
-
 	if (vxtime.hpet_address && notsc) {
 		timetype = hpet_use_timer ? "HPET" : "PIT/HPET";
 		if (hpet_use_timer)
Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c	2007-01-13 22:20:46.000000000 -0800
+++ linux/arch/x86_64/kernel/vsyscall.c	2007-01-13 22:21:01.000000000 -0800
@@ -46,7 +46,11 @@
 
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
 seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
-int __vgetcpu_mode __section_vgetcpu_mode;
+
+/* is this necessary? */
+#ifndef CONFIG_NODES_SHIFT
+#define CONFIG_NODES_SHIFT 0
+#endif
 
 #include <asm/unistd.h>
 
@@ -147,11 +151,11 @@
 long __vsyscall(2)
 vgetcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
 {
-	unsigned int dummy, p;
+	unsigned int p;
 	unsigned long j = 0;
 
 	/* Fast cache - only recompute value once per jiffies and avoid
-	   relatively costly rdtscp/cpuid otherwise.
+	   relatively costly lsl/sidt otherwise.
 	   This works because the scheduler usually keeps the process
 	   on the same CPU and this syscall doesn't guarantee its
 	   results anyways.
@@ -160,21 +164,30 @@
 	   If you don't like it pass NULL. */
 	if (tcache && tcache->blob[0] == (j = __jiffies)) {
 		p = tcache->blob[1];
-	} else if (__vgetcpu_mode == VGETCPU_RDTSCP) {
-		/* Load per CPU data from RDTSCP */
-		rdtscp(dummy, dummy, p);
-	} else {
+	}
+	else {
+#ifdef VGETCPU_USE_SIDT
+                struct {
+                        char pad[6];	/* avoid unaligned stores */
+                        u16 size;
+                        u64 address;
+                } idt;
+
+                asm("sidt %0" : "=m" (idt.size));
+                p = idt.size - 0x1000;
+#else
 		/* Load per CPU data from GDT */
 		asm("lsl %1,%0" : "=r" (p) : "r" (__PER_CPU_SEG));
-	}
-	if (tcache) {
-		tcache->blob[0] = j;
-		tcache->blob[1] = p;
+#endif
+		if (tcache) {
+			tcache->blob[0] = j;
+			tcache->blob[1] = p;
+		}
 	}
 	if (cpu)
-		*cpu = p & 0xfff;
+		*cpu = p >> CONFIG_NODES_SHIFT;
 	if (node)
-		*node = p >> 12;
+		*node = p & ((1<<CONFIG_NODES_SHIFT) - 1);
 	return 0;
 }
 
@@ -250,22 +263,37 @@
    doesn't violate that. We'll find out if it does. */
 static void __cpuinit vsyscall_set_cpu(int cpu)
 {
-	unsigned long *d;
-	unsigned long node = 0;
+	unsigned long cpu_node_encoding = cpu << CONFIG_NODES_SHIFT;
+
 #ifdef CONFIG_NUMA
-	node = cpu_to_node[cpu];
+	cpu_node_encoding |= cpu_to_node[cpu];
 #endif
+
+	/* Even though we never use rdtscp for vgetcpu we set up the rdtscp_aux
+	 * register here for (future) use in vgettimeofday et al.
+	 */
 	if (cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP))
-		write_rdtscp_aux((node << 12) | cpu);
+		write_rdtscp_aux(cpu_node_encoding);
 
+#ifdef VGETCPU_USE_SIDT
+	{
+		struct desc_ptr local_idt;
+
+		local_idt.size = 0x1000 + cpu_node_encoding;
+		local_idt.address = idt_descr.address;
+		asm("lidt %0" :: "m" (local_idt));
+	}
+#else
 	/* Store cpu number in limit so that it can be loaded quickly
-	   in user space in vgetcpu.
-	   12 bits for the CPU and 8 bits for the node. */
-	d = (unsigned long *)(cpu_gdt(cpu) + GDT_ENTRY_PER_CPU);
-	*d = 0x0f40000000000ULL;
-	*d |= cpu;
-	*d |= (node & 0xf) << 12;
-	*d |= (node >> 4) << 48;
+	   in user space in vgetcpu. */
+	{
+		unsigned long *d;
+		d = (unsigned long *)(cpu_gdt(cpu) + GDT_ENTRY_PER_CPU);
+		*d = 0x0f40000000000ULL;
+		*d |= cpu_node_encoding & 0xffff;
+		*d |= (cpu_node_encoding >> 16) << 48;
+	};
+#endif
 }
 
 static void __cpuinit cpu_vsyscall_init(void *arg)
Index: linux/include/asm-x86_64/vsyscall.h
===================================================================
--- linux.orig/include/asm-x86_64/vsyscall.h	2007-01-13 22:20:46.000000000 -0800
+++ linux/include/asm-x86_64/vsyscall.h	2007-01-13 22:21:01.000000000 -0800
@@ -17,7 +17,6 @@
 #include <linux/seqlock.h>
 
 #define __section_vxtime __attribute__ ((unused, __section__ (".vxtime"), aligned(16)))
-#define __section_vgetcpu_mode __attribute__ ((unused, __section__ (".vgetcpu_mode"), aligned(16)))
 #define __section_jiffies __attribute__ ((unused, __section__ (".jiffies"), aligned(16)))
 #define __section_sys_tz __attribute__ ((unused, __section__ (".sys_tz"), aligned(16)))
 #define __section_sysctl_vsyscall __attribute__ ((unused, __section__ (".sysctl_vsyscall"), aligned(16)))
@@ -28,9 +27,6 @@
 #define VXTIME_HPET	2
 #define VXTIME_PMTMR	3
 
-#define VGETCPU_RDTSCP	1
-#define VGETCPU_LSL	2
-
 struct vxtime_data {
 	long hpet_address;	/* HPET base address */
 	int last;
@@ -45,7 +41,6 @@
 
 /* vsyscall space (readonly) */
 extern struct vxtime_data __vxtime;
-extern int __vgetcpu_mode;
 extern struct timespec __xtime;
 extern volatile unsigned long __jiffies;
 extern struct timezone __sys_tz;
@@ -53,7 +48,6 @@
 
 /* kernel space (writeable) */
 extern struct vxtime_data vxtime;
-extern int vgetcpu_mode;
 extern struct timezone sys_tz;
 extern int sysctl_vsyscall;
 extern seqlock_t xtime_lock;
@@ -62,6 +56,28 @@
 
 #define ARCH_HAVE_XTIME_LOCK 1
 
+/*
+ * To use the IDT limit for vgetcpu we encode things like so:
+ *
+ *   0x1000 + node + (cpu << CONFIG_NODES_SHIFT)
+ *
+ * this ensures a system using this method has an IDT limit other than
+ * 0xfff, while systems not using this method will have an IDT limit
+ * of 0xfff.  (just in case anyone cares to have a test).
+ *
+ * This test verifies the various config options are in an appropriate
+ * range for the 16-bit limit field.
+ */
+#if 0x1000 + (CONFIG_NR_CPUS << CONFIG_NODES_SHIFT) <= 0x10000
+#define VGETCPU_USE_SIDT 1
+
+/* might as well test this somewhere -- the lsl method of vgetcpu has
+ * only 20 bits available to it.
+ */
+#elif (CONFIG_NR_CPUS << CONFIG_NODES_SHIFT) >= (1<<20)
+#error "(CONFIG_NR_CPUS << CONFIG_NODES_SHIFT) out of range for existing vgetcpu implementations"
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_64_VSYSCALL_H_ */
Index: linux/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux.orig/arch/x86_64/kernel/vmlinux.lds.S	2007-01-13 22:20:46.000000000 -0800
+++ linux/arch/x86_64/kernel/vmlinux.lds.S	2007-01-13 22:21:01.000000000 -0800
@@ -94,9 +94,6 @@
   .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
   vxtime = VVIRT(.vxtime);
 
-  .vgetcpu_mode : AT(VLOAD(.vgetcpu_mode)) { *(.vgetcpu_mode) }
-  vgetcpu_mode = VVIRT(.vgetcpu_mode);
-
   .sys_tz : AT(VLOAD(.sys_tz)) { *(.sys_tz) }
   sys_tz = VVIRT(.sys_tz);
 
