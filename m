Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSFYQAm>; Tue, 25 Jun 2002 12:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSFYQAl>; Tue, 25 Jun 2002 12:00:41 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:29435 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S315536AbSFYQAg> convert rfc822-to-8bit; Tue, 25 Jun 2002 12:00:36 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24: s390 fixes.
Date: Tue, 25 Jun 2002 17:57:07 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206251757.07517.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
some small fixes for s390 & s390x.
* cpu_online/num_online_cpus replacements for smp_num_cpus.
* Add missing include statements.
* Really remove xpram_release function.
* ## C-preprocessor magic in cio.
* Fix typo in switch_to for s390x.

blue skies,
  Martin.

diff -urN linux-2.5.24/arch/s390/kernel/irq.c linux-2.5.24-s390/arch/s390/kernel/irq.c
--- linux-2.5.24/arch/s390/kernel/irq.c	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-s390/arch/s390/kernel/irq.c	Tue Jun 25 15:36:11 2002
@@ -66,8 +66,9 @@
 
 	seq_puts(p, "           ");
 
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "CPU%d       ",j);
 
 	seq_putc(p, '\n');
 
diff -urN linux-2.5.24/arch/s390/kernel/setup.c linux-2.5.24-s390/arch/s390/kernel/setup.c
--- linux-2.5.24/arch/s390/kernel/setup.c	Fri Jun 21 00:53:44 2002
+++ linux-2.5.24-s390/arch/s390/kernel/setup.c	Tue Jun 25 15:36:11 2002
@@ -524,7 +524,7 @@
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 			       "# processors    : %i\n"
 			       "bogomips per cpu: %lu.%02lu\n",
-			       smp_num_cpus, loops_per_jiffy/(500000/HZ),
+			       num_online_cpus(), loops_per_jiffy/(500000/HZ),
 			       (loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
diff -urN linux-2.5.24/arch/s390/kernel/smp.c linux-2.5.24-s390/arch/s390/kernel/smp.c
--- linux-2.5.24/arch/s390/kernel/smp.c	Fri Jun 21 00:53:42 2002
+++ linux-2.5.24-s390/arch/s390/kernel/smp.c	Tue Jun 25 15:36:11 2002
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
diff -urN linux-2.5.24/arch/s390x/kernel/irq.c linux-2.5.24-s390/arch/s390x/kernel/irq.c
--- linux-2.5.24/arch/s390x/kernel/irq.c	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-s390/arch/s390x/kernel/irq.c	Tue Jun 25 15:36:11 2002
@@ -66,8 +66,9 @@
 
 	seq_puts(p, "           ");
 
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(i))
+			seq_printf(p, "CPU%d       ",j);
 
 	seq_putc(p, '\n');
 
diff -urN linux-2.5.24/arch/s390x/kernel/setup.c linux-2.5.24-s390/arch/s390x/kernel/setup.c
--- linux-2.5.24/arch/s390x/kernel/setup.c	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-s390/arch/s390x/kernel/setup.c	Tue Jun 25 15:36:11 2002
@@ -514,7 +514,7 @@
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 				"# processors    : %i\n"
 				"bogomips per cpu: %lu.%02lu\n",
-				smp_num_cpus, loops_per_jiffy/(500000/HZ),
+				num_online_cpus(), loops_per_jiffy/(500000/HZ),
 				(loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
diff -urN linux-2.5.24/arch/s390x/kernel/smp.c linux-2.5.24-s390/arch/s390x/kernel/smp.c
--- linux-2.5.24/arch/s390x/kernel/smp.c	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-s390/arch/s390x/kernel/smp.c	Tue Jun 25 15:36:11 2002
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
diff -urN linux-2.5.24/drivers/s390/block/dasd_diag.c linux-2.5.24-s390/drivers/s390/block/dasd_diag.c
--- linux-2.5.24/drivers/s390/block/dasd_diag.c	Fri Jun 21 00:53:42 2002
+++ linux-2.5.24-s390/drivers/s390/block/dasd_diag.c	Tue Jun 25 15:36:11 2002
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/dasd.h>
 #include <asm/debug.h>
diff -urN linux-2.5.24/drivers/s390/block/dasd_eckd.c linux-2.5.24-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5.24/drivers/s390/block/dasd_eckd.c	Fri Jun 21 00:53:41 2002
+++ linux-2.5.24-s390/drivers/s390/block/dasd_eckd.c	Tue Jun 25 15:36:11 2002
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/debug.h>
 #include <asm/idals.h>
diff -urN linux-2.5.24/drivers/s390/block/dasd_fba.c linux-2.5.24-s390/drivers/s390/block/dasd_fba.c
--- linux-2.5.24/drivers/s390/block/dasd_fba.c	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-s390/drivers/s390/block/dasd_fba.c	Tue Jun 25 15:36:11 2002
@@ -16,6 +16,7 @@
 
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/idals.h>
 #include <asm/ebcdic.h>
diff -urN linux-2.5.24/drivers/s390/block/dasd_proc.c linux-2.5.24-s390/drivers/s390/block/dasd_proc.c
--- linux-2.5.24/drivers/s390/block/dasd_proc.c	Fri Jun 21 00:53:46 2002
+++ linux-2.5.24-s390/drivers/s390/block/dasd_proc.c	Tue Jun 25 15:36:11 2002
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
+#include <linux/vmalloc.h>
 
 #include <asm/debug.h>
 #include <asm/irq.h>
diff -urN linux-2.5.24/drivers/s390/block/xpram.c linux-2.5.24-s390/drivers/s390/block/xpram.c
--- linux-2.5.24/drivers/s390/block/xpram.c	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-s390/drivers/s390/block/xpram.c	Tue Jun 25 15:36:11 2002
@@ -15,7 +15,6 @@
  *   Device specific file operations
  *        xpram_iotcl
  *        xpram_open
- *        xpram_release
  *
  * "ad-hoc" partitioning:
  *    the expanded memory can be partitioned among several devices 
@@ -36,6 +35,7 @@
 #include <linux/blkpg.h>
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/device.h>
+#include <linux/bio.h>
 #include <asm/uaccess.h>
 
 #define XPRAM_NAME	"xpram"
@@ -328,7 +328,6 @@
 	return 0;
 }
 
-
 static int xpram_ioctl (struct inode *inode, struct file *filp,
 		 unsigned int cmd, unsigned long arg)
 {
@@ -336,8 +335,6 @@
 	unsigned long size;
 	int idx;
 
-	if ((!inode) || kdev_none(inode->i_rdev))
-		return -EINVAL;
 	idx = minor(inode->i_rdev);
 	if (idx >= xpram_devs)
 		return -ENODEV;
@@ -378,7 +375,6 @@
 	owner:   THIS_MODULE,
 	ioctl:   xpram_ioctl,
 	open:    xpram_open,
-	release: xpram_release,
 };
 
 /*
diff -urN linux-2.5.24/drivers/s390/cio/cio_debug.h linux-2.5.24-s390/drivers/s390/cio/cio_debug.h
--- linux-2.5.24/drivers/s390/cio/cio_debug.h	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-s390/drivers/s390/cio/cio_debug.h	Tue Jun 25 15:36:11 2002
@@ -20,14 +20,14 @@
 #define CIO_MSG_EVENT(imp, args...) do { \
         if (cio_debug_initialized) \
                 debug_sprintf_event(cio_debug_msg_id, \
-                                    imp, \
+                                    imp , \
                                     ##args); \
         } while (0)
 
 #define CIO_CRW_EVENT(imp, args...) do { \
         if (cio_debug_initialized) \
                 debug_sprintf_event(cio_debug_crw_id, \
-                                    imp, \
+                                    imp , \
                                     ##args); \
         } while (0)
 
diff -urN linux-2.5.24/drivers/s390/misc/chandev.c linux-2.5.24-s390/drivers/s390/misc/chandev.c
--- linux-2.5.24/drivers/s390/misc/chandev.c	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-s390/drivers/s390/misc/chandev.c	Tue Jun 25 15:36:11 2002
@@ -24,6 +24,7 @@
 #include <asm/s390dyn.h>
 #include <asm/queue.h>
 #include <linux/kmod.h>
+#include <linux/tqueue.h>
 #ifndef MIN
 #define MIN(a,b) ((a<b)?a:b)
 #endif
diff -urN linux-2.5.24/drivers/s390/net/ctcmain.c linux-2.5.24-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.24/drivers/s390/net/ctcmain.c	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-s390/drivers/s390/net/ctcmain.c	Tue Jun 25 15:36:11 2002
@@ -49,6 +49,7 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 
 #include <linux/signal.h>
 #include <linux/string.h>
diff -urN linux-2.5.24/drivers/s390/net/iucv.c linux-2.5.24-s390/drivers/s390/net/iucv.c
--- linux-2.5.24/drivers/s390/net/iucv.c	Fri Jun 21 00:53:44 2002
+++ linux-2.5.24-s390/drivers/s390/net/iucv.c	Tue Jun 25 15:36:11 2002
@@ -44,6 +44,7 @@
 #include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/errno.h>
 #include <asm/atomic.h>
 #include "iucv.h"
 #include <asm/io.h>
@@ -302,7 +303,7 @@
 	if (debuglevel < 3)
 		return;
 
-	printk(KERN_DEBUG __FUNCTION__ ": %s\n", title);
+	printk(KERN_DEBUG "%s\n", title);
 	printk("  ");
 	for (i = 0; i < len; i++) {
 		if (!(i % 16) && i != 0)
@@ -318,7 +319,7 @@
 #define iucv_debug(lvl, fmt, args...) \
 do { \
 	if (debuglevel >= lvl) \
-		printk(KERN_DEBUG __FUNCTION__ ": " fmt "\n" , ## args); \
+		printk(KERN_DEBUG "%s: " fmt "\n", __FUNCTION__ , ## args); \
 } while (0)
 
 #else
diff -urN linux-2.5.24/drivers/s390/net/lcs.c linux-2.5.24-s390/drivers/s390/net/lcs.c
--- linux-2.5.24/drivers/s390/net/lcs.c	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-s390/drivers/s390/net/lcs.c	Tue Jun 25 15:36:11 2002
@@ -124,6 +124,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <asm/system.h>
diff -urN linux-2.5.24/include/asm-s390/pgalloc.h linux-2.5.24-s390/include/asm-s390/pgalloc.h
--- linux-2.5.24/include/asm-s390/pgalloc.h	Fri Jun 21 00:53:54 2002
+++ linux-2.5.24-s390/include/asm-s390/pgalloc.h	Tue Jun 25 15:36:11 2002
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
 
 #define check_pgt_cache()	do {} while (0)
 
diff -urN linux-2.5.24/include/asm-s390/smp.h linux-2.5.24-s390/include/asm-s390/smp.h
--- linux-2.5.24/include/asm-s390/smp.h	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-s390/include/asm-s390/smp.h	Tue Jun 25 15:36:11 2002
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
diff -urN linux-2.5.24/include/asm-s390/tlbflush.h linux-2.5.24-s390/include/asm-s390/tlbflush.h
--- linux-2.5.24/include/asm-s390/tlbflush.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-s390/include/asm-s390/tlbflush.h	Tue Jun 25 15:36:11 2002
@@ -91,8 +91,7 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if ((smp_num_cpus > 1) &&
-	    ((atomic_read(&mm->mm_count) != 1) ||
+	if (((atomic_read(&mm->mm_count) != 1) ||
 	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
 		mm->cpu_vm_mask = (1UL << smp_processor_id());
 		global_flush_tlb();
diff -urN linux-2.5.24/include/asm-s390x/bitops.h linux-2.5.24-s390/include/asm-s390x/bitops.h
--- linux-2.5.24/include/asm-s390x/bitops.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-s390/include/asm-s390x/bitops.h	Tue Jun 25 15:36:11 2002
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
diff -urN linux-2.5.24/include/asm-s390x/pgalloc.h linux-2.5.24-s390/include/asm-s390x/pgalloc.h
--- linux-2.5.24/include/asm-s390x/pgalloc.h	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-s390/include/asm-s390x/pgalloc.h	Tue Jun 25 15:36:11 2002
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
 
 #define check_pgt_cache()	do { } while (0)
 
diff -urN linux-2.5.24/include/asm-s390x/smp.h linux-2.5.24-s390/include/asm-s390x/smp.h
--- linux-2.5.24/include/asm-s390x/smp.h	Fri Jun 21 00:53:52 2002
+++ linux-2.5.24-s390/include/asm-s390x/smp.h	Tue Jun 25 15:36:11 2002
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
diff -urN linux-2.5.24/include/asm-s390x/system.h linux-2.5.24-s390/include/asm-s390x/system.h
--- linux-2.5.24/include/asm-s390x/system.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-s390/include/asm-s390x/system.h	Tue Jun 25 15:36:11 2002
@@ -23,7 +23,7 @@
 #define prepare_arch_switch(rq)			do { } while (0)
 #define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
 
-#define switch_to(prev,next),last do {					     \
+#define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
diff -urN linux-2.5.24/include/asm-s390x/tlbflush.h linux-2.5.24-s390/include/asm-s390x/tlbflush.h
--- linux-2.5.24/include/asm-s390x/tlbflush.h	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-s390/include/asm-s390x/tlbflush.h	Tue Jun 25 15:36:11 2002
@@ -88,8 +88,7 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if ((smp_num_cpus > 1) &&
-	    ((atomic_read(&mm->mm_count) != 1) ||
+	if (((atomic_read(&mm->mm_count) != 1) ||
 	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
 		mm->cpu_vm_mask = (1UL << smp_processor_id());
 		global_flush_tlb();

