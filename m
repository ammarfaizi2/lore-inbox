Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316933AbSGHNyA>; Mon, 8 Jul 2002 09:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSGHNxH>; Mon, 8 Jul 2002 09:53:07 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:64182 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S316912AbSGHNwj> convert rfc822-to-8bit; Mon, 8 Jul 2002 09:52:39 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.25: s390 fixes.
Date: Mon, 8 Jul 2002 15:51:06 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207081528.22696.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
minimal s/390 fixes:
* smp_num_cpus adaptions
* change link order in drivers/s390 to make cio to get initialised first
* add missing include statements
* remove xpram_release reference
* ## C-preprocessor magic in cio
* define USER_HZ
* add height64 for 64 bit s390
* fix typo in switch_to for 64 bit s390

blue skies,
  Martin.

diff -urN linux-2.5.25/arch/s390/defconfig linux-2.5.25-s390/arch/s390/defconfig
--- linux-2.5.25/arch/s390/defconfig	Sat Jul  6 01:42:33 2002
+++ linux-2.5.25-s390/arch/s390/defconfig	Mon Jul  8 15:18:52 2002
@@ -84,9 +84,6 @@
 #
 # CONFIG_SCSI_7000FASST is not set
 # CONFIG_SCSI_ACARD is not set
-# CONFIG_SCSI_AHA152X is not set
-# CONFIG_SCSI_AHA1542 is not set
-# CONFIG_SCSI_AHA1740 is not set
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_DPT_I2O is not set
@@ -114,7 +111,6 @@
 # CONFIG_SCSI_PCI2220I is not set
 # CONFIG_SCSI_PSI240I is not set
 # CONFIG_SCSI_QLOGIC_FAS is not set
-# CONFIG_SCSI_SIM710 is not set
 # CONFIG_SCSI_SYM53C416 is not set
 # CONFIG_SCSI_T128 is not set
 # CONFIG_SCSI_U14_34F is not set
diff -urN linux-2.5.25/arch/s390/kernel/irq.c linux-2.5.25-s390/arch/s390/kernel/irq.c
--- linux-2.5.25/arch/s390/kernel/irq.c	Sat Jul  6 01:42:27 2002
+++ linux-2.5.25-s390/arch/s390/kernel/irq.c	Mon Jul  8 15:18:52 2002
@@ -66,8 +66,9 @@
 
 	seq_puts(p, "           ");
 
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "CPU%d       ",j);
 
 	seq_putc(p, '\n');
 
diff -urN linux-2.5.25/arch/s390/kernel/setup.c linux-2.5.25-s390/arch/s390/kernel/setup.c
--- linux-2.5.25/arch/s390/kernel/setup.c	Sat Jul  6 01:42:04 2002
+++ linux-2.5.25-s390/arch/s390/kernel/setup.c	Mon Jul  8 15:18:52 2002
@@ -524,7 +524,7 @@
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 			       "# processors    : %i\n"
 			       "bogomips per cpu: %lu.%02lu\n",
-			       smp_num_cpus, loops_per_jiffy/(500000/HZ),
+			       num_online_cpus(), loops_per_jiffy/(500000/HZ),
 			       (loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
diff -urN linux-2.5.25/arch/s390/kernel/smp.c linux-2.5.25-s390/arch/s390/kernel/smp.c
--- linux-2.5.25/arch/s390/kernel/smp.c	Sat Jul  6 01:42:01 2002
+++ linux-2.5.25-s390/arch/s390/kernel/smp.c	Mon Jul  8 15:18:52 2002
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
diff -urN linux-2.5.25/arch/s390/mm/fault.c linux-2.5.25-s390/arch/s390/mm/fault.c
--- linux-2.5.25/arch/s390/mm/fault.c	Sat Jul  6 01:42:33 2002
+++ linux-2.5.25-s390/arch/s390/mm/fault.c	Mon Jul  8 15:18:52 2002
@@ -234,16 +234,18 @@
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, error_code == 4)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
+	default:
+		BUG();
 	}
 
         up_read(&mm->mmap_sem);
diff -urN linux-2.5.25/arch/s390x/defconfig linux-2.5.25-s390/arch/s390x/defconfig
--- linux-2.5.25/arch/s390x/defconfig	Sat Jul  6 01:42:01 2002
+++ linux-2.5.25-s390/arch/s390x/defconfig	Mon Jul  8 15:18:52 2002
@@ -85,9 +85,6 @@
 #
 # CONFIG_SCSI_7000FASST is not set
 # CONFIG_SCSI_ACARD is not set
-# CONFIG_SCSI_AHA152X is not set
-# CONFIG_SCSI_AHA1542 is not set
-# CONFIG_SCSI_AHA1740 is not set
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_DPT_I2O is not set
@@ -115,7 +112,6 @@
 # CONFIG_SCSI_PCI2220I is not set
 # CONFIG_SCSI_PSI240I is not set
 # CONFIG_SCSI_QLOGIC_FAS is not set
-# CONFIG_SCSI_SIM710 is not set
 # CONFIG_SCSI_SYM53C416 is not set
 # CONFIG_SCSI_T128 is not set
 # CONFIG_SCSI_U14_34F is not set
diff -urN linux-2.5.25/arch/s390x/kernel/irq.c linux-2.5.25-s390/arch/s390x/kernel/irq.c
--- linux-2.5.25/arch/s390x/kernel/irq.c	Sat Jul  6 01:42:38 2002
+++ linux-2.5.25-s390/arch/s390x/kernel/irq.c	Mon Jul  8 15:18:52 2002
@@ -66,8 +66,9 @@
 
 	seq_puts(p, "           ");
 
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(i))
+			seq_printf(p, "CPU%d       ",j);
 
 	seq_putc(p, '\n');
 
diff -urN linux-2.5.25/arch/s390x/kernel/setup.c linux-2.5.25-s390/arch/s390x/kernel/setup.c
--- linux-2.5.25/arch/s390x/kernel/setup.c	Sat Jul  6 01:42:21 2002
+++ linux-2.5.25-s390/arch/s390x/kernel/setup.c	Mon Jul  8 15:18:52 2002
@@ -514,7 +514,7 @@
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 				"# processors    : %i\n"
 				"bogomips per cpu: %lu.%02lu\n",
-				smp_num_cpus, loops_per_jiffy/(500000/HZ),
+				num_online_cpus(), loops_per_jiffy/(500000/HZ),
 				(loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
diff -urN linux-2.5.25/arch/s390x/kernel/smp.c linux-2.5.25-s390/arch/s390x/kernel/smp.c
--- linux-2.5.25/arch/s390x/kernel/smp.c	Sat Jul  6 01:42:28 2002
+++ linux-2.5.25-s390/arch/s390x/kernel/smp.c	Mon Jul  8 15:18:52 2002
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
diff -urN linux-2.5.25/arch/s390x/mm/fault.c linux-2.5.25-s390/arch/s390x/mm/fault.c
--- linux-2.5.25/arch/s390x/mm/fault.c	Sat Jul  6 01:42:20 2002
+++ linux-2.5.25-s390/arch/s390x/mm/fault.c	Mon Jul  8 15:18:52 2002
@@ -234,16 +234,18 @@
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, error_code == 4)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
+	default:
+		BUG();
 	}
 
         up_read(&mm->mmap_sem);
diff -urN linux-2.5.25/drivers/s390/Makefile linux-2.5.25-s390/drivers/s390/Makefile
--- linux-2.5.25/drivers/s390/Makefile	Sat Jul  6 01:42:24 2002
+++ linux-2.5.25-s390/drivers/s390/Makefile	Mon Jul  8 15:18:52 2002
@@ -7,6 +7,6 @@
 obj-$(CONFIG_QDIO) += qdio.o
 
 obj-y += s390mach.o s390dyn.o sysinfo.o
-obj-y += block/ char/ misc/ net/ cio/
+obj-y += cio/ block/ char/ misc/ net/
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.25/drivers/s390/block/dasd_diag.c linux-2.5.25-s390/drivers/s390/block/dasd_diag.c
--- linux-2.5.25/drivers/s390/block/dasd_diag.c	Sat Jul  6 01:42:02 2002
+++ linux-2.5.25-s390/drivers/s390/block/dasd_diag.c	Mon Jul  8 15:18:52 2002
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/dasd.h>
 #include <asm/debug.h>
diff -urN linux-2.5.25/drivers/s390/block/dasd_eckd.c linux-2.5.25-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5.25/drivers/s390/block/dasd_eckd.c	Sat Jul  6 01:42:01 2002
+++ linux-2.5.25-s390/drivers/s390/block/dasd_eckd.c	Mon Jul  8 15:18:52 2002
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/debug.h>
 #include <asm/idals.h>
diff -urN linux-2.5.25/drivers/s390/block/dasd_fba.c linux-2.5.25-s390/drivers/s390/block/dasd_fba.c
--- linux-2.5.25/drivers/s390/block/dasd_fba.c	Sat Jul  6 01:42:32 2002
+++ linux-2.5.25-s390/drivers/s390/block/dasd_fba.c	Mon Jul  8 15:18:52 2002
@@ -16,6 +16,7 @@
 
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/idals.h>
 #include <asm/ebcdic.h>
diff -urN linux-2.5.25/drivers/s390/block/dasd_proc.c linux-2.5.25-s390/drivers/s390/block/dasd_proc.c
--- linux-2.5.25/drivers/s390/block/dasd_proc.c	Sat Jul  6 01:42:18 2002
+++ linux-2.5.25-s390/drivers/s390/block/dasd_proc.c	Mon Jul  8 15:18:52 2002
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
+#include <linux/vmalloc.h>
 
 #include <asm/debug.h>
 #include <asm/irq.h>
diff -urN linux-2.5.25/drivers/s390/block/xpram.c linux-2.5.25-s390/drivers/s390/block/xpram.c
--- linux-2.5.25/drivers/s390/block/xpram.c	Sat Jul  6 01:42:33 2002
+++ linux-2.5.25-s390/drivers/s390/block/xpram.c	Mon Jul  8 15:18:52 2002
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
diff -urN linux-2.5.25/drivers/s390/cio/cio_debug.h linux-2.5.25-s390/drivers/s390/cio/cio_debug.h
--- linux-2.5.25/drivers/s390/cio/cio_debug.h	Sat Jul  6 01:42:32 2002
+++ linux-2.5.25-s390/drivers/s390/cio/cio_debug.h	Mon Jul  8 15:18:52 2002
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
 
diff -urN linux-2.5.25/drivers/s390/misc/chandev.c linux-2.5.25-s390/drivers/s390/misc/chandev.c
--- linux-2.5.25/drivers/s390/misc/chandev.c	Sat Jul  6 01:42:21 2002
+++ linux-2.5.25-s390/drivers/s390/misc/chandev.c	Mon Jul  8 15:18:52 2002
@@ -24,6 +24,7 @@
 #include <asm/s390dyn.h>
 #include <asm/queue.h>
 #include <linux/kmod.h>
+#include <linux/tqueue.h>
 #ifndef MIN
 #define MIN(a,b) ((a<b)?a:b)
 #endif
diff -urN linux-2.5.25/drivers/s390/net/ctcmain.c linux-2.5.25-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.25/drivers/s390/net/ctcmain.c	Sat Jul  6 01:42:21 2002
+++ linux-2.5.25-s390/drivers/s390/net/ctcmain.c	Mon Jul  8 15:18:52 2002
@@ -49,6 +49,7 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 
 #include <linux/signal.h>
 #include <linux/string.h>
diff -urN linux-2.5.25/drivers/s390/net/lcs.c linux-2.5.25-s390/drivers/s390/net/lcs.c
--- linux-2.5.25/drivers/s390/net/lcs.c	Sat Jul  6 01:42:04 2002
+++ linux-2.5.25-s390/drivers/s390/net/lcs.c	Mon Jul  8 15:18:52 2002
@@ -124,6 +124,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <asm/system.h>
diff -urN linux-2.5.25/include/asm-s390/param.h linux-2.5.25-s390/include/asm-s390/param.h
--- linux-2.5.25/include/asm-s390/param.h	Sat Jul  6 01:42:04 2002
+++ linux-2.5.25-s390/include/asm-s390/param.h	Mon Jul  8 15:18:52 2002
@@ -9,6 +9,12 @@
 #ifndef _ASMS390_PARAM_H
 #define _ASMS390_PARAM_H
 
+#ifdef __KERNEL__
+# define HZ		100		/* Internal kernel timer frequency */
+# define USER_HZ	100		/* .. some user interfaces are in "ticks" */
+# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
+#endif
+
 #ifndef HZ
 #define HZ 100
 #endif
@@ -24,9 +30,5 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
-
-#ifdef __KERNEL__
-# define CLOCKS_PER_SEC		HZ	/* frequency at which times() counts */
-#endif
 
 #endif
diff -urN linux-2.5.25/include/asm-s390/pgalloc.h linux-2.5.25-s390/include/asm-s390/pgalloc.h
--- linux-2.5.25/include/asm-s390/pgalloc.h	Sat Jul  6 01:42:31 2002
+++ linux-2.5.25-s390/include/asm-s390/pgalloc.h	Mon Jul  8 15:18:52 2002
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
 
 #define check_pgt_cache()	do {} while (0)
 
diff -urN linux-2.5.25/include/asm-s390/smp.h linux-2.5.25-s390/include/asm-s390/smp.h
--- linux-2.5.25/include/asm-s390/smp.h	Sat Jul  6 01:42:27 2002
+++ linux-2.5.25-s390/include/asm-s390/smp.h	Mon Jul  8 15:18:52 2002
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
diff -urN linux-2.5.25/include/asm-s390/tlbflush.h linux-2.5.25-s390/include/asm-s390/tlbflush.h
--- linux-2.5.25/include/asm-s390/tlbflush.h	Sat Jul  6 01:42:38 2002
+++ linux-2.5.25-s390/include/asm-s390/tlbflush.h	Mon Jul  8 15:18:52 2002
@@ -91,8 +91,7 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if ((smp_num_cpus > 1) &&
-	    ((atomic_read(&mm->mm_count) != 1) ||
+	if (((atomic_read(&mm->mm_count) != 1) ||
 	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
 		mm->cpu_vm_mask = (1UL << smp_processor_id());
 		global_flush_tlb();
diff -urN linux-2.5.25/include/asm-s390x/bitops.h linux-2.5.25-s390/include/asm-s390x/bitops.h
--- linux-2.5.25/include/asm-s390x/bitops.h	Sat Jul  6 01:42:37 2002
+++ linux-2.5.25-s390/include/asm-s390x/bitops.h	Mon Jul  8 15:18:52 2002
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
diff -urN linux-2.5.25/include/asm-s390x/param.h linux-2.5.25-s390/include/asm-s390x/param.h
--- linux-2.5.25/include/asm-s390x/param.h	Sat Jul  6 01:42:00 2002
+++ linux-2.5.25-s390/include/asm-s390x/param.h	Mon Jul  8 15:18:52 2002
@@ -9,11 +9,14 @@
 #ifndef _ASMS390_PARAM_H
 #define _ASMS390_PARAM_H
 
-#ifndef HZ
-#define HZ 100
 #ifdef __KERNEL__
-#define hz_to_std(a) (a)
+# define HZ		100		/* Internal kernel timer frequency */
+# define USER_HZ	100		/* .. some user interfaces are in "ticks" */
+# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
+
+#ifndef HZ
+#define HZ 100
 #endif
 
 #define EXEC_PAGESIZE	4096
@@ -28,8 +31,4 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
-#ifdef __KERNEL__
-# define CLOCKS_PER_SEC		HZ	/* frequency at which times() counts */
-#endif
-                                 
 #endif
diff -urN linux-2.5.25/include/asm-s390x/pgalloc.h linux-2.5.25-s390/include/asm-s390x/pgalloc.h
--- linux-2.5.25/include/asm-s390x/pgalloc.h	Sat Jul  6 01:42:05 2002
+++ linux-2.5.25-s390/include/asm-s390x/pgalloc.h	Mon Jul  8 15:18:52 2002
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
 
 #define check_pgt_cache()	do { } while (0)
 
diff -urN linux-2.5.25/include/asm-s390x/smp.h linux-2.5.25-s390/include/asm-s390x/smp.h
--- linux-2.5.25/include/asm-s390x/smp.h	Sat Jul  6 01:42:23 2002
+++ linux-2.5.25-s390/include/asm-s390x/smp.h	Mon Jul  8 15:18:52 2002
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
diff -urN linux-2.5.25/include/asm-s390x/system.h linux-2.5.25-s390/include/asm-s390x/system.h
--- linux-2.5.25/include/asm-s390x/system.h	Sat Jul  6 01:42:37 2002
+++ linux-2.5.25-s390/include/asm-s390x/system.h	Mon Jul  8 15:18:52 2002
@@ -23,7 +23,7 @@
 #define prepare_arch_switch(rq)			do { } while (0)
 #define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
 
-#define switch_to(prev,next),last do {					     \
+#define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
diff -urN linux-2.5.25/include/asm-s390x/tlbflush.h linux-2.5.25-s390/include/asm-s390x/tlbflush.h
--- linux-2.5.25/include/asm-s390x/tlbflush.h	Sat Jul  6 01:42:32 2002
+++ linux-2.5.25-s390/include/asm-s390x/tlbflush.h	Mon Jul  8 15:19:09 2002
@@ -88,8 +88,7 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if ((smp_num_cpus > 1) &&
-	    ((atomic_read(&mm->mm_count) != 1) ||
+	if (((atomic_read(&mm->mm_count) != 1) ||
 	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
 		mm->cpu_vm_mask = (1UL << smp_processor_id());
 		global_flush_tlb();

