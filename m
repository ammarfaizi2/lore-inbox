Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317661AbSHUCLp>; Tue, 20 Aug 2002 22:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSHUCLp>; Tue, 20 Aug 2002 22:11:45 -0400
Received: from hdfdns01.hd.intel.com ([192.52.58.10]:34284 "EHLO
	mail1.hd.intel.com") by vger.kernel.org with ESMTP
	id <S317661AbSHUCLl>; Tue, 20 Aug 2002 22:11:41 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D40004BA468B@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "'alan@redhat.com'" <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] threads in /proc/cpuinfo and cpu_num_threads (fka smp_num
	_siblings)
Date: Tue, 20 Aug 2002 19:15:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C248B8.A4334140"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C248B8.A4334140
Content-Type: text/plain;
	charset="ISO-8859-1"

I think this may have been our mistake, but "siblings" sometimes can be
misleading, in the sense that the number of the siblings usually/often does
not include yourself. 

At the same time, as Alan pointed out, using cpu_num_threads is clearer than
smp_num_sibling because there are going to be non X86 CPUs around one day
with similar properties and it's a more generic name.

So here is a patch against linux-2.4.20-pre2-ac5.
=========================================================================== 
diff -urN linux-2.4.20-pre2-ac5/arch/i386/kernel/setup.c
linux-1/arch/i386/kernel/setup.c
--- linux-2.4.20-pre2-ac5/arch/i386/kernel/setup.c	Tue Aug 20 15:35:18
2002
+++ linux-1/arch/i386/kernel/setup.c	Tue Aug 20 16:45:20 2002
@@ -2331,29 +2331,29 @@
 		int 	cpu = smp_processor_id();
 
 		cpuid(1, &eax, &ebx, &ecx, &edx);
-		smp_num_siblings = (ebx & 0xff0000) >> 16;
+		cpu_num_threads = (ebx & 0xff0000) >> 16;
 
-		if (smp_num_siblings == 1) {
+		if (cpu_num_threads == 1) {
 			printk(KERN_INFO  "CPU: Hyper-Threading is
disabled\n");
-		} else if (smp_num_siblings > 1 ) {
+		} else if (cpu_num_threads > 1 ) {
 			index_lsb = 0;
 			index_msb = 31;
 			/*
-			 * At this point we only support two siblings per
+			 * At this point we only support two threads per
 			 * processor package.
 			 */
-#define NR_SIBLINGS	2
-			if (smp_num_siblings != NR_SIBLINGS) {
-				printk(KERN_WARNING "CPU: Unsupported number
of the siblings %d", smp_num_siblings);
-				smp_num_siblings = 1;
+#define NR_XEON_THREADS	2
+			if (cpu_num_threads != NR_XEON_THREADS) {
+				printk(KERN_WARNING "CPU: Unsupported number
of SMT threads %d", cpu_num_threads);
+				cpu_num_threads = 1;
 				return;
 			}
-			tmp = smp_num_siblings;
+			tmp = cpu_num_threads;
 			while ((tmp & 1) == 0) {
 				tmp >>=1 ;
 				index_lsb++;
 			}
-			tmp = smp_num_siblings;
+			tmp = cpu_num_threads;
 			while ((tmp & 0x80000000 ) == 0) {
 				tmp <<=1 ;
 				index_msb--;
@@ -2962,7 +2962,7 @@
 
 #ifdef CONFIG_SMP
 	seq_printf(m, "physical id\t: %d\n",phys_proc_id[n]);
-	seq_printf(m, "siblings\t: %d\n",smp_num_siblings);
+	seq_printf(m, "threads\t\t: %d\n",cpu_num_threads);
 #endif
 	
 	
 	/* We use exception 16 if we have hardware math and we've either
seen it or the CPU claims it is internal */
diff -urN linux-2.4.20-pre2-ac5/arch/i386/kernel/smpboot.c
linux-1/arch/i386/kernel/smpboot.c
--- linux-2.4.20-pre2-ac5/arch/i386/kernel/smpboot.c	Tue Aug 20 15:35:18
2002
+++ linux-1/arch/i386/kernel/smpboot.c	Tue Aug 20 15:39:56 2002
@@ -56,8 +56,8 @@
 /* Total count of live CPUs */
 int smp_num_cpus = 1;
 
-/* Number of siblings per CPU package */
-int smp_num_siblings = 1;
+/* Number of threads per CPU package */
+int cpu_num_threads = 1;
 int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 
 /* Bitmask of currently online CPUs */
@@ -1158,7 +1158,7 @@
 	 * that we can tell the sibling CPU efficiently.
 	 */
 	if (test_bit(X86_FEATURE_HT, boot_cpu_data.x86_capability)
-	    && smp_num_siblings > 1) {
+	    && cpu_num_threads > 1) {
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
 			cpu_sibling_map[cpu] = NO_PROC_ID;
 		
@@ -1175,7 +1175,7 @@
 				}
 			}
 			if (cpu_sibling_map[cpu] == NO_PROC_ID) {
-				smp_num_siblings = 1;
+				cpu_num_threads = 1;
 				printk(KERN_WARNING "WARNING: No sibling
found for CPU %d.\n", cpu);
 			}
 		}
diff -urN linux-2.4.20-pre2-ac5/fs/binfmt_elf.c linux-1/fs/binfmt_elf.c
--- linux-2.4.20-pre2-ac5/fs/binfmt_elf.c	Tue Aug 20 15:35:20 2002
+++ linux-1/fs/binfmt_elf.c	Tue Aug 20 15:39:56 2002
@@ -150,7 +150,7 @@
 	 * removed for 2.5
 	 */
 	 
-	if(smp_num_siblings > 1)
+	if(cpu_num_threads > 1)
 		u_platform = u_platform - ((current->pid % 64) << 7);
 #endif	
 
diff -urN linux-2.4.20-pre2-ac5/include/asm-i386/smp.h
linux-1/include/asm-i386/smp.h
--- linux-2.4.20-pre2-ac5/include/asm-i386/smp.h	Tue Aug 20 15:35:20
2002
+++ linux-1/include/asm-i386/smp.h	Tue Aug 20 16:48:22 2002
@@ -74,7 +74,7 @@
 extern unsigned long cpu_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
-extern int smp_num_siblings;
+extern int cpu_num_threads;
 extern int cpu_sibling_map[];
 
 extern void smp_flush_tlb(void);
diff -urN linux-2.4.20-pre2-ac5/include/asm-i386/smp_balance.h
linux-1/include/asm-i386/smp_balance.h
--- linux-2.4.20-pre2-ac5/include/asm-i386/smp_balance.h	Tue Aug 20
15:35:20 2002
+++ linux-1/include/asm-i386/smp_balance.h	Tue Aug 20 15:39:56 2002
@@ -28,7 +28,7 @@
 static inline int arch_load_balance(int this_cpu, int idle)
 {
 	/* Special hack for hyperthreading */
-       if (smp_num_siblings > 1 && idle &&
!idle_cpu(cpu_sibling_map[this_cpu])) {
+       if (cpu_num_threads > 1 && idle &&
!idle_cpu(cpu_sibling_map[this_cpu])) {
                int found;
                struct runqueue *rq_target;
 


------_=_NextPart_000_01C248B8.A4334140
Content-Type: application/octet-stream;
	name="cpu_num_threads.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cpu_num_threads.patch"

diff -urN linux-2.4.20-pre2-ac5/arch/i386/kernel/setup.c =
linux-1/arch/i386/kernel/setup.c=0A=
--- linux-2.4.20-pre2-ac5/arch/i386/kernel/setup.c	Tue Aug 20 15:35:18 =
2002=0A=
+++ linux-1/arch/i386/kernel/setup.c	Tue Aug 20 16:45:20 2002=0A=
@@ -2331,29 +2331,29 @@=0A=
 		int 	cpu =3D smp_processor_id();=0A=
 =0A=
 		cpuid(1, &eax, &ebx, &ecx, &edx);=0A=
-		smp_num_siblings =3D (ebx & 0xff0000) >> 16;=0A=
+		cpu_num_threads =3D (ebx & 0xff0000) >> 16;=0A=
 =0A=
-		if (smp_num_siblings =3D=3D 1) {=0A=
+		if (cpu_num_threads =3D=3D 1) {=0A=
 			printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");=0A=
-		} else if (smp_num_siblings > 1 ) {=0A=
+		} else if (cpu_num_threads > 1 ) {=0A=
 			index_lsb =3D 0;=0A=
 			index_msb =3D 31;=0A=
 			/*=0A=
-			 * At this point we only support two siblings per=0A=
+			 * At this point we only support two threads per=0A=
 			 * processor package.=0A=
 			 */=0A=
-#define NR_SIBLINGS	2=0A=
-			if (smp_num_siblings !=3D NR_SIBLINGS) {=0A=
-				printk(KERN_WARNING "CPU: Unsupported number of the siblings %d", =
smp_num_siblings);=0A=
-				smp_num_siblings =3D 1;=0A=
+#define NR_XEON_THREADS	2=0A=
+			if (cpu_num_threads !=3D NR_XEON_THREADS) {=0A=
+				printk(KERN_WARNING "CPU: Unsupported number of SMT threads %d", =
cpu_num_threads);=0A=
+				cpu_num_threads =3D 1;=0A=
 				return;=0A=
 			}=0A=
-			tmp =3D smp_num_siblings;=0A=
+			tmp =3D cpu_num_threads;=0A=
 			while ((tmp & 1) =3D=3D 0) {=0A=
 				tmp >>=3D1 ;=0A=
 				index_lsb++;=0A=
 			}=0A=
-			tmp =3D smp_num_siblings;=0A=
+			tmp =3D cpu_num_threads;=0A=
 			while ((tmp & 0x80000000 ) =3D=3D 0) {=0A=
 				tmp <<=3D1 ;=0A=
 				index_msb--;=0A=
@@ -2962,7 +2962,7 @@=0A=
 =0A=
 #ifdef CONFIG_SMP=0A=
 	seq_printf(m, "physical id\t: %d\n",phys_proc_id[n]);=0A=
-	seq_printf(m, "siblings\t: %d\n",smp_num_siblings);=0A=
+	seq_printf(m, "threads\t\t: %d\n",cpu_num_threads);=0A=
 #endif=0A=
 	=0A=
 	/* We use exception 16 if we have hardware math and we've either seen =
it or the CPU claims it is internal */=0A=
diff -urN linux-2.4.20-pre2-ac5/arch/i386/kernel/smpboot.c =
linux-1/arch/i386/kernel/smpboot.c=0A=
--- linux-2.4.20-pre2-ac5/arch/i386/kernel/smpboot.c	Tue Aug 20 =
15:35:18 2002=0A=
+++ linux-1/arch/i386/kernel/smpboot.c	Tue Aug 20 15:39:56 2002=0A=
@@ -56,8 +56,8 @@=0A=
 /* Total count of live CPUs */=0A=
 int smp_num_cpus =3D 1;=0A=
 =0A=
-/* Number of siblings per CPU package */=0A=
-int smp_num_siblings =3D 1;=0A=
+/* Number of threads per CPU package */=0A=
+int cpu_num_threads =3D 1;=0A=
 int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */=0A=
 =0A=
 /* Bitmask of currently online CPUs */=0A=
@@ -1158,7 +1158,7 @@=0A=
 	 * that we can tell the sibling CPU efficiently.=0A=
 	 */=0A=
 	if (test_bit(X86_FEATURE_HT, boot_cpu_data.x86_capability)=0A=
-	    && smp_num_siblings > 1) {=0A=
+	    && cpu_num_threads > 1) {=0A=
 		for (cpu =3D 0; cpu < NR_CPUS; cpu++)=0A=
 			cpu_sibling_map[cpu] =3D NO_PROC_ID;=0A=
 		=0A=
@@ -1175,7 +1175,7 @@=0A=
 				}=0A=
 			}=0A=
 			if (cpu_sibling_map[cpu] =3D=3D NO_PROC_ID) {=0A=
-				smp_num_siblings =3D 1;=0A=
+				cpu_num_threads =3D 1;=0A=
 				printk(KERN_WARNING "WARNING: No sibling found for CPU %d.\n", =
cpu);=0A=
 			}=0A=
 		}=0A=
diff -urN linux-2.4.20-pre2-ac5/fs/binfmt_elf.c =
linux-1/fs/binfmt_elf.c=0A=
--- linux-2.4.20-pre2-ac5/fs/binfmt_elf.c	Tue Aug 20 15:35:20 2002=0A=
+++ linux-1/fs/binfmt_elf.c	Tue Aug 20 15:39:56 2002=0A=
@@ -150,7 +150,7 @@=0A=
 	 * removed for 2.5=0A=
 	 */=0A=
 	 =0A=
-	if(smp_num_siblings > 1)=0A=
+	if(cpu_num_threads > 1)=0A=
 		u_platform =3D u_platform - ((current->pid % 64) << 7);=0A=
 #endif	=0A=
 =0A=
diff -urN linux-2.4.20-pre2-ac5/include/asm-i386/smp.h =
linux-1/include/asm-i386/smp.h=0A=
--- linux-2.4.20-pre2-ac5/include/asm-i386/smp.h	Tue Aug 20 15:35:20 =
2002=0A=
+++ linux-1/include/asm-i386/smp.h	Tue Aug 20 16:48:22 2002=0A=
@@ -74,7 +74,7 @@=0A=
 extern unsigned long cpu_online_map;=0A=
 extern volatile unsigned long smp_invalidate_needed;=0A=
 extern int pic_mode;=0A=
-extern int smp_num_siblings;=0A=
+extern int cpu_num_threads;=0A=
 extern int cpu_sibling_map[];=0A=
 =0A=
 extern void smp_flush_tlb(void);=0A=
diff -urN linux-2.4.20-pre2-ac5/include/asm-i386/smp_balance.h =
linux-1/include/asm-i386/smp_balance.h=0A=
--- linux-2.4.20-pre2-ac5/include/asm-i386/smp_balance.h	Tue Aug 20 =
15:35:20 2002=0A=
+++ linux-1/include/asm-i386/smp_balance.h	Tue Aug 20 15:39:56 2002=0A=
@@ -28,7 +28,7 @@=0A=
 static inline int arch_load_balance(int this_cpu, int idle)=0A=
 {=0A=
 	/* Special hack for hyperthreading */=0A=
-       if (smp_num_siblings > 1 && idle && =
!idle_cpu(cpu_sibling_map[this_cpu])) {=0A=
+       if (cpu_num_threads > 1 && idle && =
!idle_cpu(cpu_sibling_map[this_cpu])) {=0A=
                int found;=0A=
                struct runqueue *rq_target;=0A=
 =0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=

------_=_NextPart_000_01C248B8.A4334140--
