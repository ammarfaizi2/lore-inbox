Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSGWPwp>; Tue, 23 Jul 2002 11:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318120AbSGWPv6>; Tue, 23 Jul 2002 11:51:58 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:45001 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S318116AbSGWPvm>; Tue, 23 Jul 2002 11:51:42 -0400
Message-Id: <200207231554.g6NFsfW107208@d06relay02.portsmouth.uk.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] 2.5.27: s390 fixes.
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Mail-Copies-To: arndb@de.ibm.com
Date: Tue, 23 Jul 2002 19:47:26 +0200
References: <200207221950.45748.schwidefsky@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updated patch part 2/6:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683.1.1 -> 1.683.1.2
#	arch/s390/kernel/smp.c	1.12    -> 1.13   
#	include/asm-s390x/smp.h	1.4     -> 1.5    
#	include/asm-s390/smp.h	1.5     -> 1.6    
#	arch/s390/kernel/irq.c	1.8     -> 1.9    
#	arch/s390x/kernel/smp.c	1.11    -> 1.12   
#	include/asm-s390x/tlbflush.h	1.1     -> 1.2    
#	include/asm-s390x/bitops.h	1.3     -> 1.4    
#	include/asm-s390/tlbflush.h	1.1     -> 1.2    
#	arch/s390x/kernel/irq.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/23	arnd@bergmann-dalldorf.de	1.683.1.2
# smp_num_cpus adaptions
# --------------------------------------------
#
diff -Nru a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
--- a/arch/s390/kernel/irq.c	Tue Jul 23 18:53:43 2002
+++ b/arch/s390/kernel/irq.c	Tue Jul 23 18:53:43 2002
@@ -66,8 +66,9 @@
 
 	seq_puts(p, "           ");
 
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "CPU%d       ",j);
 
 	seq_putc(p, '\n');
 
diff -Nru a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
--- a/arch/s390/kernel/smp.c	Tue Jul 23 18:53:43 2002
+++ b/arch/s390/kernel/smp.c	Tue Jul 23 18:53:43 2002
@@ -48,7 +48,6 @@
  * An array with a pointer the lowcore of every CPU.
  */
 static int       max_cpus = NR_CPUS;	  /* Setup configured maximum number of CPUs to activate	*/
-int              smp_num_cpus;
 struct _lowcore *lowcore_ptr[NR_CPUS];
 cycles_t         cacheflush_time=0;
 int              smp_threads_ready=0;      /* Set when the idlers are all forked. */
@@ -150,7 +149,7 @@
  */
 {
 	struct call_data_struct data;
-	int cpus = smp_num_cpus-1;
+	int cpus = num_online_cpus()-1;
 
 	if (!cpus || !atomic_read(&smp_commenced))
 		return 0;
@@ -185,8 +184,8 @@
         int i, rc;
 
         /* stop all processors */
-        for (i =  0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i)
+        for (i =  0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i)
 			continue;
 		do {
 			rc = signal_processor_ps(&dummy, 0, i, sigp_stop);
@@ -201,8 +200,8 @@
         int i, rc;
 
         /* store status of all processors in their lowcores (real 0) */
-        for (i =  0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i)
+        for (i =  0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i)
 			continue;
 		low_core_addr = (unsigned long)get_cpu_lowcore(i);
 		do {
@@ -347,8 +346,8 @@
         struct _lowcore *lowcore;
         int i;
 
-        for (i = 0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i)
+        for (i = 0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i)
                         continue;
                 lowcore = get_cpu_lowcore(i);
                 /*
@@ -459,24 +458,24 @@
 
 void smp_count_cpus(void)
 {
-        int curr_cpu;
+        int curr_cpu, num_cpus;
 
         current_thread_info()->cpu = 0;
-        smp_num_cpus = 1;
+        num_cpus = 1;
 	phys_cpu_present_map = 1;
 	cpu_online_map = 1;
         for (curr_cpu = 0;
-             curr_cpu <= 65535 && smp_num_cpus < max_cpus; curr_cpu++) {
+             curr_cpu <= 65535 && num_cpus < max_cpus; curr_cpu++) {
                 if ((__u16) curr_cpu == boot_cpu_addr)
                         continue;
-                __cpu_logical_map[smp_num_cpus] = (__u16) curr_cpu;
-                if (signal_processor(smp_num_cpus, sigp_sense) ==
+                __cpu_logical_map[num_cpus] = (__u16) curr_cpu;
+                if (signal_processor(num_cpus, sigp_sense) ==
                     sigp_not_operational)
                         continue;
-		set_bit(smp_num_cpus, &phys_cpu_present_map);
-                smp_num_cpus++;
+		set_bit(num_cpus, &phys_cpu_present_map);
+                num_cpus++;
         }
-        printk("Detected %d CPU's\n",(int) smp_num_cpus);
+        printk("Detected %d CPU's\n",(int) num_cpus);
         printk("Boot cpu address %2X\n", boot_cpu_addr);
 }
 
@@ -591,7 +590,9 @@
          */
         print_cpu_info(&safe_get_cpu_lowcore(0)->cpu_data);
 
-        for(i = 0; i < smp_num_cpus; i++) {
+        for(i = 0; i < NR_CPUS; i++) {
+		if (!test_bit(i, &phys_cpu_present_map))
+			continue;
 		lowcore_ptr[i] = (struct _lowcore *)
 			__get_free_page(GFP_KERNEL|GFP_DMA);
 		async_stack = __get_free_pages(GFP_KERNEL,1);
@@ -637,5 +638,4 @@
 EXPORT_SYMBOL(kernel_flag);
 EXPORT_SYMBOL(smp_ctl_set_bit);
 EXPORT_SYMBOL(smp_ctl_clear_bit);
-EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(smp_call_function);
diff -Nru a/arch/s390x/kernel/irq.c b/arch/s390x/kernel/irq.c
--- a/arch/s390x/kernel/irq.c	Tue Jul 23 18:53:43 2002
+++ b/arch/s390x/kernel/irq.c	Tue Jul 23 18:53:43 2002
@@ -66,8 +66,9 @@
 
 	seq_puts(p, "           ");
 
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(i))
+			seq_printf(p, "CPU%d       ",j);
 
 	seq_putc(p, '\n');
 
diff -Nru a/arch/s390x/kernel/smp.c b/arch/s390x/kernel/smp.c
--- a/arch/s390x/kernel/smp.c	Tue Jul 23 18:53:43 2002
+++ b/arch/s390x/kernel/smp.c	Tue Jul 23 18:53:43 2002
@@ -47,7 +47,6 @@
  * An array with a pointer the lowcore of every CPU.
  */
 static int       max_cpus = NR_CPUS;	  /* Setup configured maximum number of CPUs to activate	*/
-int              smp_num_cpus;
 struct _lowcore *lowcore_ptr[NR_CPUS];
 cycles_t         cacheflush_time=0;
 int              smp_threads_ready=0;      /* Set when the idlers are all forked. */
@@ -149,7 +148,7 @@
  */
 {
 	struct call_data_struct data;
-	int cpus = smp_num_cpus-1;
+	int cpus = num_online_cpus()-1;
 
 	if (!cpus || !atomic_read(&smp_commenced))
 		return 0;
@@ -184,8 +183,8 @@
         int i, rc;
 
         /* stop all processors */
-        for (i =  0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i)
+        for (i =  0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i)
 			continue;
 		do {
 			rc = signal_processor_ps(&dummy, 0, i, sigp_stop);
@@ -200,8 +199,8 @@
         int i, rc;
 
         /* store status of all processors in their lowcores (real 0) */
-        for (i =  0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i) 
+        for (i =  0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i) 
 			continue;
 		low_core_addr = (unsigned long)get_cpu_lowcore(i);
 		do {
@@ -342,8 +341,8 @@
 {
         int i;
 
-        for (i = 0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i)
+        for (i = 0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i)
                         continue;
                 /*
                  * Set signaling bit in lowcore of target cpu and kick it
@@ -440,24 +439,24 @@
 
 void smp_count_cpus(void)
 {
-        int curr_cpu;
+        int curr_cpu, num_cpus;
 
         current_thread_info()->cpu = 0;
-        smp_num_cpus = 1;
+        num_cpus = 1;
 	phys_cpu_present_map = 1;
         cpu_online_map = 1;
         for (curr_cpu = 0;
-             curr_cpu <= 65535 && smp_num_cpus < max_cpus; curr_cpu++) {
+             curr_cpu <= 65535 && num_cpus < max_cpus; curr_cpu++) {
                 if ((__u16) curr_cpu == boot_cpu_addr)
                         continue;
-                __cpu_logical_map[smp_num_cpus] = (__u16) curr_cpu;
-                if (signal_processor(smp_num_cpus, sigp_sense) ==
+                __cpu_logical_map[num_cpus] = (__u16) curr_cpu;
+                if (signal_processor(num_cpus, sigp_sense) ==
                     sigp_not_operational)
                         continue;
-		set_bit(smp_num_cpus, &phys_cpu_present_map);
-                smp_num_cpus++;
+		set_bit(num_cpus, &phys_cpu_present_map);
+                num_cpus++;
         }
-        printk("Detected %d CPU's\n",(int) smp_num_cpus);
+        printk("Detected %d CPU's\n",(int) num_cpus);
         printk("Boot cpu address %2X\n", boot_cpu_addr);
 }
 
@@ -571,7 +570,9 @@
          */
         print_cpu_info(&safe_get_cpu_lowcore(0)->cpu_data);
 
-        for(i = 0; i < smp_num_cpus; i++) {
+        for(i = 0; i < NR_CPUS; i++) {
+		if (!test_bit(i, &phys_cpu_present_map))
+			continue;
                 lowcore_ptr[i] = (struct _lowcore *)
                                     __get_free_pages(GFP_KERNEL|GFP_DMA, 1);
 		async_stack = __get_free_pages(GFP_KERNEL,2);
@@ -616,5 +617,4 @@
 EXPORT_SYMBOL(kernel_flag);
 EXPORT_SYMBOL(smp_ctl_set_bit);
 EXPORT_SYMBOL(smp_ctl_clear_bit);
-EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(smp_call_function);
diff -Nru a/include/asm-s390/smp.h b/include/asm-s390/smp.h
--- a/include/asm-s390/smp.h	Tue Jul 23 18:53:43 2002
+++ b/include/asm-s390/smp.h	Tue Jul 23 18:53:43 2002
@@ -46,14 +46,19 @@
 
 #define smp_processor_id() (current_thread_info()->cpu)
 
-extern __inline__ int cpu_logical_map(int cpu)
+#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+
+extern inline unsigned int num_online_cpus(void)
 {
-        return cpu;
+	return hweight32(cpu_online_map);
 }
 
-extern __inline__ int cpu_number_map(int cpu)
+extern inline int any_online_cpu(unsigned int mask)
 {
-        return cpu;
+	if (mask & cpu_online_map)
+		return __ffs(mask & cpu_online_map);
+
+	return -1;
 }
 
 extern __inline__ __u16 hard_smp_processor_id(void)
diff -Nru a/include/asm-s390/tlbflush.h b/include/asm-s390/tlbflush.h
--- a/include/asm-s390/tlbflush.h	Tue Jul 23 18:53:43 2002
+++ b/include/asm-s390/tlbflush.h	Tue Jul 23 18:53:43 2002
@@ -91,8 +91,7 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if ((smp_num_cpus > 1) &&
-	    ((atomic_read(&mm->mm_count) != 1) ||
+	if (((atomic_read(&mm->mm_count) != 1) ||
 	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
 		mm->cpu_vm_mask = (1UL << smp_processor_id());
 		global_flush_tlb();
diff -Nru a/include/asm-s390x/bitops.h b/include/asm-s390x/bitops.h
--- a/include/asm-s390x/bitops.h	Tue Jul 23 18:53:43 2002
+++ b/include/asm-s390x/bitops.h	Tue Jul 23 18:53:43 2002
@@ -811,7 +811,14 @@
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
  */
-
+#define hweight64(x)						\
+({								\
+	unsigned long __x = (x);				\
+	unsigned int __w;					\
+	__w = generic_hweight32((unsigned int) __x);		\
+	__w += generic_hweight32((unsigned int) (__x>>32));	\
+	__w;							\
+})
 #define hweight32(x) generic_hweight32(x)
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
diff -Nru a/include/asm-s390x/smp.h b/include/asm-s390x/smp.h
--- a/include/asm-s390x/smp.h	Tue Jul 23 18:53:43 2002
+++ b/include/asm-s390x/smp.h	Tue Jul 23 18:53:43 2002
@@ -46,14 +46,19 @@
 
 #define smp_processor_id() (current_thread_info()->cpu)
 
-extern __inline__ int cpu_logical_map(int cpu)
+#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+
+extern inline unsigned int num_online_cpus(void)
 {
-        return cpu;
+	return hweight64(cpu_online_map);
 }
 
-extern __inline__ int cpu_number_map(int cpu)
+extern inline int any_online_cpu(unsigned int mask)
 {
-        return cpu;
+	if (mask & cpu_online_map)
+		return __ffs(mask & cpu_online_map);
+
+	return -1;
 }
 
 extern __inline__ __u16 hard_smp_processor_id(void)
diff -Nru a/include/asm-s390x/tlbflush.h b/include/asm-s390x/tlbflush.h
--- a/include/asm-s390x/tlbflush.h	Tue Jul 23 18:53:43 2002
+++ b/include/asm-s390x/tlbflush.h	Tue Jul 23 18:53:43 2002
@@ -88,8 +88,7 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if ((smp_num_cpus > 1) &&
-	    ((atomic_read(&mm->mm_count) != 1) ||
+	if (((atomic_read(&mm->mm_count) != 1) ||
 	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
 		mm->cpu_vm_mask = (1UL << smp_processor_id());
