Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSGVRww>; Mon, 22 Jul 2002 13:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317744AbSGVRww>; Mon, 22 Jul 2002 13:52:52 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:9207 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S317743AbSGVRwX> convert rfc822-to-8bit; Mon, 22 Jul 2002 13:52:23 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.27: s390 fixes.
Date: Mon, 22 Jul 2002 19:50:45 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207221950.45748.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
s390 fixes for 2.5.27:
* designated initializer rework from Rusty Russell
* add sys_security system call
* smp_num_cpus adaptions
* link order in drivers/s390 to make cio get initialised first
* replace kdev_t in dasd driver structures by bdev pointer
* pass bdev pointer instead of a inode pointer in dasd ioctls
* replace tq_immediate by tasklet in con3215, ctctty and iucv
* add missing include statements
* remove xpram_release
* ## C-preprocessor magic in cio
* define USER_HZ
* add hweight64 in bitops
* fix typo in switch_to

blue skies,
  Martin.

diff -urN linux-2.5.27/arch/s390/kernel/debug.c linux-2.5.27-s390/arch/s390/kernel/debug.c
--- linux-2.5.27/arch/s390/kernel/debug.c	Sat Jul 20 21:11:08 2002
+++ linux-2.5.27-s390/arch/s390/kernel/debug.c	Mon Jul 22 19:36:37 2002
@@ -149,10 +149,10 @@
 static int initialized = 0;
 
 static struct file_operations debug_file_ops = {
-	read:    debug_output,
-	write:   debug_input,	
-	open:    debug_open,
-	release: debug_close,
+	.read    = debug_output,
+	.write   = debug_input,	
+	.open    = debug_open,
+	.release = debug_close,
 };
 
 static struct proc_dir_entry *debug_proc_root_entry;
diff -urN linux-2.5.27/arch/s390/kernel/entry.S linux-2.5.27-s390/arch/s390/kernel/entry.S
--- linux-2.5.27/arch/s390/kernel/entry.S	Sat Jul 20 21:11:10 2002
+++ linux-2.5.27-s390/arch/s390/kernel/entry.S	Mon Jul 22 18:30:51 2002
@@ -581,7 +581,8 @@
 	.long  sys_futex
 	.long  sys_sched_setaffinity
 	.long  sys_sched_getaffinity	 /* 240 */
-	.rept  255-240
+	.long  sys_security
+	.rept  255-241
 	.long  sys_ni_syscall
 	.endr
 
diff -urN linux-2.5.27/arch/s390/kernel/irq.c linux-2.5.27-s390/arch/s390/kernel/irq.c
--- linux-2.5.27/arch/s390/kernel/irq.c	Sat Jul 20 21:11:19 2002
+++ linux-2.5.27-s390/arch/s390/kernel/irq.c	Mon Jul 22 18:42:28 2002
@@ -66,8 +66,9 @@
 
 	seq_puts(p, "           ");
 
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "CPU%d       ",j);
 
 	seq_putc(p, '\n');
 
diff -urN linux-2.5.27/arch/s390/kernel/ptrace.c linux-2.5.27-s390/arch/s390/kernel/ptrace.c
--- linux-2.5.27/arch/s390/kernel/ptrace.c	Sat Jul 20 21:11:13 2002
+++ linux-2.5.27-s390/arch/s390/kernel/ptrace.c	Mon Jul 22 18:30:51 2002
@@ -227,6 +227,9 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
+		ret = security_ops->ptrace(current->parent, current);
+		if (ret)
+			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
 		ret = 0;
diff -urN linux-2.5.27/arch/s390/kernel/setup.c linux-2.5.27-s390/arch/s390/kernel/setup.c
--- linux-2.5.27/arch/s390/kernel/setup.c	Sat Jul 20 21:11:07 2002
+++ linux-2.5.27-s390/arch/s390/kernel/setup.c	Mon Jul 22 19:36:37 2002
@@ -524,7 +524,7 @@
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 			       "# processors    : %i\n"
 			       "bogomips per cpu: %lu.%02lu\n",
-			       smp_num_cpus, loops_per_jiffy/(500000/HZ),
+			       num_online_cpus(), loops_per_jiffy/(500000/HZ),
 			       (loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
@@ -553,8 +553,8 @@
 {
 }
 struct seq_operations cpuinfo_op = {
-	start:	c_start,
-	next:	c_next,
-	stop:	c_stop,
-	show:	show_cpuinfo,
+	.start = c_start,
+	.next  = c_next,
+	.stop  = c_stop,
+	.show  = show_cpuinfo,
 };
diff -urN linux-2.5.27/arch/s390/kernel/smp.c linux-2.5.27-s390/arch/s390/kernel/smp.c
--- linux-2.5.27/arch/s390/kernel/smp.c	Sat Jul 20 21:11:04 2002
+++ linux-2.5.27-s390/arch/s390/kernel/smp.c	Mon Jul 22 18:30:51 2002
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
diff -urN linux-2.5.27/arch/s390/mm/fault.c linux-2.5.27-s390/arch/s390/mm/fault.c
--- linux-2.5.27/arch/s390/mm/fault.c	Sat Jul 20 21:11:32 2002
+++ linux-2.5.27-s390/arch/s390/mm/fault.c	Mon Jul 22 18:30:51 2002
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
diff -urN linux-2.5.27/arch/s390x/kernel/debug.c linux-2.5.27-s390/arch/s390x/kernel/debug.c
--- linux-2.5.27/arch/s390x/kernel/debug.c	Sat Jul 20 21:11:08 2002
+++ linux-2.5.27-s390/arch/s390x/kernel/debug.c	Mon Jul 22 19:36:37 2002
@@ -149,10 +149,10 @@
 static int initialized = 0;
 
 static struct file_operations debug_file_ops = {
-	read:    debug_output,
-	write:   debug_input,	
-	open:    debug_open,
-	release: debug_close,
+	.read    = debug_output,
+	.write   = debug_input,	
+	.open    = debug_open,
+	.release = debug_close,
 };
 
 static struct proc_dir_entry *debug_proc_root_entry;
diff -urN linux-2.5.27/arch/s390x/kernel/entry.S linux-2.5.27-s390/arch/s390x/kernel/entry.S
--- linux-2.5.27/arch/s390x/kernel/entry.S	Sat Jul 20 21:11:11 2002
+++ linux-2.5.27-s390/arch/s390x/kernel/entry.S	Mon Jul 22 18:30:51 2002
@@ -612,7 +612,8 @@
 	.long  SYSCALL(sys_futex,sys32_futex_wrapper)
 	.long  SYSCALL(sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
 	.long  SYSCALL(sys_sched_getaffinity,sys32_sched_getaffinity_wrapper)
-        .rept  255-240
+	.long  SYSCALL(sys_security, sys_ni_syscall)
+        .rept  255-241
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
 	.endr
 
diff -urN linux-2.5.27/arch/s390x/kernel/irq.c linux-2.5.27-s390/arch/s390x/kernel/irq.c
--- linux-2.5.27/arch/s390x/kernel/irq.c	Sat Jul 20 21:12:29 2002
+++ linux-2.5.27-s390/arch/s390x/kernel/irq.c	Mon Jul 22 18:43:02 2002
@@ -66,8 +66,9 @@
 
 	seq_puts(p, "           ");
 
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(i))
+			seq_printf(p, "CPU%d       ",j);
 
 	seq_putc(p, '\n');
 
diff -urN linux-2.5.27/arch/s390x/kernel/linux32.c linux-2.5.27-s390/arch/s390x/kernel/linux32.c
--- linux-2.5.27/arch/s390x/kernel/linux32.c	Sat Jul 20 21:11:10 2002
+++ linux-2.5.27-s390/arch/s390x/kernel/linux32.c	Mon Jul 22 18:30:51 2002
@@ -514,16 +514,15 @@
 	if (!p)
 		return -ENOMEM;
 
+	err = -EINVAL;
 	if (second > MSGMAX || first < 0 || second < 0)
-		return -EINVAL;
+		goto out;
 
 	err = -EFAULT;
 	if (!uptr)
 		goto out;
-
-	err = get_user (p->mtype, &up->mtype);
-	err |= __copy_from_user (p->mtext, &up->mtext, second);
-	if (err)
+        if (get_user (p->mtype, &up->mtype) ||
+	    __copy_from_user (p->mtext, &up->mtext, second))
 		goto out;
 	old_fs = get_fs ();
 	set_fs (KERNEL_DS);
diff -urN linux-2.5.27/arch/s390x/kernel/linux32.h linux-2.5.27-s390/arch/s390x/kernel/linux32.h
--- linux-2.5.27/arch/s390x/kernel/linux32.h	Sat Jul 20 21:12:22 2002
+++ linux-2.5.27-s390/arch/s390x/kernel/linux32.h	Mon Jul 22 18:30:51 2002
@@ -8,8 +8,6 @@
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/export.h>
 
-#ifdef CONFIG_S390_SUPPORT
-
 /* Macro that masks the high order bit of an 32 bit pointer and converts it*/
 /*       to a 64 bit pointer */
 #define A(__x) ((unsigned long)((__x) & 0x7FFFFFFFUL))
@@ -241,6 +239,4 @@
 	sigset_t32		uc_sigmask;	/* mask last for extensibility */
 };
 
-#endif /* !CONFIG_S390_SUPPORT */
- 
 #endif /* _ASM_S390X_S390_H */
diff -urN linux-2.5.27/arch/s390x/kernel/setup.c linux-2.5.27-s390/arch/s390x/kernel/setup.c
--- linux-2.5.27/arch/s390x/kernel/setup.c	Sat Jul 20 21:11:14 2002
+++ linux-2.5.27-s390/arch/s390x/kernel/setup.c	Mon Jul 22 19:36:37 2002
@@ -514,7 +514,7 @@
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 				"# processors    : %i\n"
 				"bogomips per cpu: %lu.%02lu\n",
-				smp_num_cpus, loops_per_jiffy/(500000/HZ),
+				num_online_cpus(), loops_per_jiffy/(500000/HZ),
 				(loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
@@ -543,8 +543,8 @@
 {
 }
 struct seq_operations cpuinfo_op = {
-	start:	c_start,
-	next:	c_next,
-	stop:	c_stop,
-	show:	show_cpuinfo,
+	.start = c_start,
+	.next  = c_next,
+	.stop  = c_stop,
+	.show  = show_cpuinfo,
 };
diff -urN linux-2.5.27/arch/s390x/kernel/smp.c linux-2.5.27-s390/arch/s390x/kernel/smp.c
--- linux-2.5.27/arch/s390x/kernel/smp.c	Sat Jul 20 21:11:21 2002
+++ linux-2.5.27-s390/arch/s390x/kernel/smp.c	Mon Jul 22 18:30:51 2002
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
diff -urN linux-2.5.27/arch/s390x/mm/fault.c linux-2.5.27-s390/arch/s390x/mm/fault.c
--- linux-2.5.27/arch/s390x/mm/fault.c	Sat Jul 20 21:11:13 2002
+++ linux-2.5.27-s390/arch/s390x/mm/fault.c	Mon Jul 22 18:30:51 2002
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
diff -urN linux-2.5.27/drivers/s390/Makefile linux-2.5.27-s390/drivers/s390/Makefile
--- linux-2.5.27/drivers/s390/Makefile	Sat Jul 20 21:11:19 2002
+++ linux-2.5.27-s390/drivers/s390/Makefile	Mon Jul 22 18:30:51 2002
@@ -7,6 +7,6 @@
 obj-$(CONFIG_QDIO) += qdio.o
 
 obj-y += s390mach.o s390dyn.o sysinfo.o
-obj-y += block/ char/ misc/ net/ cio/
+obj-y += cio/ block/ char/ misc/ net/
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.27/drivers/s390/block/dasd.c linux-2.5.27-s390/drivers/s390/block/dasd.c
--- linux-2.5.27/drivers/s390/block/dasd.c	Sat Jul 20 21:11:17 2002
+++ linux-2.5.27-s390/drivers/s390/block/dasd.c	Mon Jul 22 19:36:37 2002
@@ -292,8 +292,8 @@
 		return -ENODEV;
 	minor = devmap->devindex % DASD_PER_MAJOR;
 
-	/* Set kdev and the device name. */
-	device->kdev = mk_kdev(gdp->major, minor << DASD_PARTN_BITS);
+	/* Set bdev and the device name. */
+	device->bdev = bdget(MKDEV(gdp->major, minor << DASD_PARTN_BITS));
 	dasd_device_name(device->name, minor, 0, gdp);
 
 	/* Find a discipline for the device. */
@@ -304,14 +304,14 @@
 	/* Add a proc directory and the dasd device entry to devfs. */
 	sprintf(buffer, "%04x", device->devinfo.devno);
 	dir = devfs_mk_dir(dasd_devfs_handle, buffer, device);
-	gdp->de_arr[minor(device->kdev) >> DASD_PARTN_BITS] = dir;
+	gdp->de_arr[minor] = dir;
 	if (devmap->features & DASD_FEATURE_READONLY)
 		devfs_perm = S_IFBLK | S_IRUSR;
 	else
 		devfs_perm = S_IFBLK | S_IRUSR | S_IWUSR;
 	device->devfs_entry = devfs_register(dir, "device", DEVFS_FL_DEFAULT,
-					     major(device->kdev),
-					     minor(device->kdev),
+					     gdp->major,
+					     minor << DASD_PARTN_BITS,
 					     devfs_perm,
 					     &dasd_device_operations, NULL);
 	device->state = DASD_STATE_KNOWN;
@@ -326,6 +326,7 @@
 {
 	struct gendisk *gdp;
 	dasd_devmap_t *devmap;
+	struct block_device *bdev;
 	int minor;
 
 	devmap = dasd_devmap_from_devno(device->devinfo.devno);
@@ -341,6 +342,11 @@
 	/* Forget the discipline information. */
 	device->discipline = NULL;
 	device->state = DASD_STATE_NEW;
+
+	/* Forget the block device */
+	bdev = device->bdev;
+	device->bdev = NULL;
+	bdput(bdev);
 }
 
 /*
@@ -427,21 +433,29 @@
 }
 
 /*
+ * get the kdev_t of a device 
+ * FIXME: remove this when no longer needed
+ */
+static inline kdev_t
+dasd_partition_to_kdev_t(dasd_device_t *device, unsigned int partition)
+{
+	return to_kdev_t(device->bdev->bd_dev+partition);
+}
+
+
+/*
  * Setup block device.
  */
 static inline int
 dasd_state_accept_to_ready(dasd_device_t * device)
 {
 	dasd_devmap_t *devmap;
-	int major, minor;
 	int rc, i;
 
 	devmap = dasd_devmap_from_devno(device->devinfo.devno);
 	if (devmap->features & DASD_FEATURE_READONLY) {
-		major = major(device->kdev);
-		minor = minor(device->kdev);
 		for (i = 0; i < (1 << DASD_PARTN_BITS); i++)
-			set_device_ro(mk_kdev(major, minor+i), 1);
+			set_device_ro(dasd_partition_to_kdev_t(device, i), 1);
 		DEV_MESSAGE (KERN_WARNING, device, "%s",
 			     "setting read-only mode ");
 	}
@@ -1547,11 +1561,9 @@
 			goto restart;
 		}
 
-		/* Dechain request from device request queue ... */
+		/* Rechain request on device device request queue */
 		cqr->endclk = get_clock();
-		list_del(&cqr->list);
-		/* ... and add it to list of final requests. */
-		list_add_tail(&cqr->list, final_queue);
+		list_move_tail(&cqr->list, final_queue);
 	}
 }
 
@@ -1580,6 +1592,10 @@
 	dasd_ccw_req_t *cqr;
 	int nr_queued;
 
+	/* No bdev, no queue. */
+	bdev = device->bdev;
+	if (!bdev)
+		return;
 	queue = device->request_queue;
 	/* No queue ? Then there is nothing to do. */
 	if (queue == NULL)
@@ -1602,9 +1618,6 @@
 		if (cqr->status == DASD_CQR_QUEUED)
 			nr_queued++;
 	}
-	bdev = bdget(kdev_t_to_nr(device->kdev));
-	if (!bdev)
-		return;
 	while (!blk_queue_plugged(queue) &&
 	       !blk_queue_empty(queue) &&
 		nr_queued < DASD_CHANQ_MAX_SIZE) {
@@ -1636,7 +1649,6 @@
 		dasd_profile_start(device, cqr, req);
 		nr_queued++;
 	}
-	bdput(bdev);
 }
 
 /*
@@ -1715,11 +1727,9 @@
 			__dasd_process_erp(device, cqr);
 			continue;
 		}
-		/* Dechain request from device request queue ... */
+		/* Rechain request on device request queue */
 		cqr->endclk = get_clock();
-		list_del(&cqr->list);
-		/* ... and add it to list of flushed requests. */
-		list_add_tail(&cqr->list, &flush_queue);
+		list_move_tail(&cqr->list, &flush_queue);
 	}
 	spin_unlock_irq(get_irq_lock(device->devinfo.irq));
 	/* Now call the callback function of flushed requests */
@@ -2186,10 +2196,10 @@
 
 struct
 block_device_operations dasd_device_operations = {
-	owner:THIS_MODULE,
-	open:dasd_open,
-	release:dasd_release,
-	ioctl:dasd_ioctl,
+	.owner=THIS_MODULE,
+	.open=dasd_open,
+	.release=dasd_release,
+	.ioctl=dasd_ioctl,
 };
 
 
diff -urN linux-2.5.27/drivers/s390/block/dasd_devmap.c linux-2.5.27-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.5.27/drivers/s390/block/dasd_devmap.c	Sat Jul 20 21:11:21 2002
+++ linux-2.5.27-s390/drivers/s390/block/dasd_devmap.c	Mon Jul 22 18:30:51 2002
@@ -449,6 +449,15 @@
 }
 
 /*
+ * Find the devmap for a device corresponding to a block_device.
+ */
+dasd_devmap_t *
+dasd_devmap_from_bdev(struct block_device *bdev)
+{
+	return dasd_devmap_from_kdev(to_kdev_t(bdev->bd_dev));
+}
+
+/*
  * Find the device structure for device number devno. If it does not
  * exists yet, allocate it. Increase the reference counter in the device
  * structure and return a pointer to it.
diff -urN linux-2.5.27/drivers/s390/block/dasd_diag.c linux-2.5.27-s390/drivers/s390/block/dasd_diag.c
--- linux-2.5.27/drivers/s390/block/dasd_diag.c	Sat Jul 20 21:11:05 2002
+++ linux-2.5.27-s390/drivers/s390/block/dasd_diag.c	Mon Jul 22 19:36:37 2002
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/dasd.h>
 #include <asm/debug.h>
@@ -489,19 +490,19 @@
  * for one request. Give a little safety and the result is 240.
  */
 static dasd_discipline_t dasd_diag_discipline = {
-	owner:THIS_MODULE,
-	name:"DIAG",
-	ebcname:"DIAG",
-	max_blocks:240,
-	check_device:dasd_diag_check_device,
-	fill_geometry:dasd_diag_fill_geometry,
-	start_IO:dasd_start_diag,
-	examine_error:dasd_diag_examine_error,
-	erp_action:dasd_diag_erp_action,
-	erp_postaction:dasd_diag_erp_postaction,
-	build_cp:dasd_diag_build_cp,
-	dump_sense:dasd_diag_dump_sense,
-	fill_info:dasd_diag_fill_info,
+	.owner=THIS_MODULE,
+	.name="DIAG",
+	.ebcname="DIAG",
+	.max_blocks=240,
+	.check_device=dasd_diag_check_device,
+	.fill_geometry=dasd_diag_fill_geometry,
+	.start_IO=dasd_start_diag,
+	.examine_error=dasd_diag_examine_error,
+	.erp_action=dasd_diag_erp_action,
+	.erp_postaction=dasd_diag_erp_postaction,
+	.build_cp=dasd_diag_build_cp,
+	.dump_sense=dasd_diag_dump_sense,
+	.fill_info=dasd_diag_fill_info,
 };
 
 int
diff -urN linux-2.5.27/drivers/s390/block/dasd_eckd.c linux-2.5.27-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5.27/drivers/s390/block/dasd_eckd.c	Sat Jul 20 21:11:04 2002
+++ linux-2.5.27-s390/drivers/s390/block/dasd_eckd.c	Mon Jul 22 19:36:37 2002
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/debug.h>
 #include <asm/idals.h>
@@ -73,25 +74,25 @@
 static
 devreg_t dasd_eckd_known_devices[] = {
 	{
-		ci: { hc: { ctype: 0x3880, dtype:3390 } },
-		flag:(DEVREG_MATCH_CU_TYPE | DEVREG_MATCH_DEV_TYPE |
+		.ci = { .hc = { .ctype = 0x3880, .dtype = 3390 } },
+		.flag = (DEVREG_MATCH_CU_TYPE | DEVREG_MATCH_DEV_TYPE |
 		      DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.oper_func = dasd_oper_handler
 	},
 	{
-		ci: { hc: { ctype:0x3990 } },
-		flag:(DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.ci = { .hc = { .ctype = 0x3990 } },
+		.flag =(DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
+		.oper_func = dasd_oper_handler
 	},
 	{
-		ci: { hc: { ctype:0x2105 } },
-		flag:(DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.ci = { .hc = { .ctype = 0x2105 } },
+		.flag = (DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
+		.oper_func = dasd_oper_handler
 	},
 	{
-		ci: { hc: { ctype:0x9343 } },
-		flag:(DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.ci = { .hc = { .ctype = 0x9343 } },
+		.flag = (DEVREG_MATCH_CU_TYPE | DEVREG_TYPE_DEVCHARS),
+		.oper_func = dasd_oper_handler
 	}
 };
 #endif
@@ -1092,7 +1093,8 @@
  * Buils a channel programm to releases a prior reserved 
  * (see dasd_eckd_reserve) device.
  */
-static int dasd_eckd_release(void *inp, int no, long args)
+static int
+dasd_eckd_release(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1101,7 +1103,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1134,7 +1136,8 @@
  * 'timeout the request'. This leads to an terminate IO if 
  * the interrupt is outstanding for a certain time. 
  */
-static int dasd_eckd_reserve(void *inp, int no, long args)
+static int
+dasd_eckd_reserve(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1143,7 +1146,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1168,7 +1171,7 @@
 
 	if (rc == -EIO) {
 		/* Request got an eror or has been timed out. */
-		dasd_eckd_release(inp, no, args);
+		dasd_eckd_release(bdev, no, args);
 	}
 	dasd_kfree_request(cqr, cqr->device);
 	dasd_put_device(devmap);
@@ -1180,7 +1183,8 @@
  * Buils a channel programm to break a device's reservation. 
  * (unconditional reserve)
  */
-static int dasd_eckd_steal_lock(void *inp, int no, long args)
+static int
+dasd_eckd_steal_lock(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1189,7 +1193,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1213,7 +1217,7 @@
 
 	if (rc == -EIO) {
 		/* Request got an eror or has been timed out. */
-		dasd_eckd_release(inp, no, args);
+		dasd_eckd_release(bdev, no, args);
 	}
 	dasd_kfree_request(cqr, cqr->device);
 	dasd_put_device(devmap);
@@ -1223,7 +1227,8 @@
 /*
  * Read performance statistics
  */
-static int dasd_eckd_performance(void *inp, int no, long args)
+static int
+dasd_eckd_performance(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1233,7 +1238,7 @@
 	ccw1_t *ccw;
 	int rc;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1292,7 +1297,8 @@
  * Set attributes (cache operations)
  * Stores the attributes for cache operation to be used in Define Extend (DE).
  */
-static int dasd_eckd_set_attrib(void *inp, int no, long args)
+static int
+dasd_eckd_set_attrib(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -1304,7 +1310,7 @@
 	if (!args)
 		return -EINVAL;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -1414,22 +1420,22 @@
  * for one request. Give a little safety and the result is 240.
  */
 static dasd_discipline_t dasd_eckd_discipline = {
-	owner:THIS_MODULE,
-	name:"ECKD",
-	ebcname:"ECKD",
-	max_blocks:240,
-	check_device:dasd_eckd_check_device,
-	do_analysis:dasd_eckd_do_analysis,
-	fill_geometry:dasd_eckd_fill_geometry,
-	start_IO:dasd_start_IO,
-	term_IO:dasd_term_IO,
-	format_device:dasd_eckd_format_device,
-	examine_error:dasd_eckd_examine_error,
-	erp_action:dasd_eckd_erp_action,
-	erp_postaction:dasd_eckd_erp_postaction,
-	build_cp:dasd_eckd_build_cp,
-	dump_sense:dasd_eckd_dump_sense,
-	fill_info:dasd_eckd_fill_info,
+	.owner=THIS_MODULE,
+	.name="ECKD",
+	.ebcname="ECKD",
+	.max_blocks=240,
+	.check_device=dasd_eckd_check_device,
+	.do_analysis=dasd_eckd_do_analysis,
+	.fill_geometry=dasd_eckd_fill_geometry,
+	.start_IO=dasd_start_IO,
+	.term_IO=dasd_term_IO,
+	.format_device=dasd_eckd_format_device,
+	.examine_error=dasd_eckd_examine_error,
+	.erp_action=dasd_eckd_erp_action,
+	.erp_postaction=dasd_eckd_erp_postaction,
+	.build_cp=dasd_eckd_build_cp,
+	.dump_sense=dasd_eckd_dump_sense,
+	.fill_info=dasd_eckd_fill_info,
 };
 
 int
diff -urN linux-2.5.27/drivers/s390/block/dasd_fba.c linux-2.5.27-s390/drivers/s390/block/dasd_fba.c
--- linux-2.5.27/drivers/s390/block/dasd_fba.c	Sat Jul 20 21:11:27 2002
+++ linux-2.5.27-s390/drivers/s390/block/dasd_fba.c	Mon Jul 22 19:36:37 2002
@@ -16,6 +16,7 @@
 
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
+#include <linux/bio.h>
 
 #include <asm/idals.h>
 #include <asm/ebcdic.h>
@@ -47,16 +48,16 @@
 static
 devreg_t dasd_fba_known_devices[] = {
 	{
-		ci: {hc: {ctype: 0x6310, dtype:0x9336}},
-		flag:(DEVREG_MATCH_CU_TYPE |
+		.ci = { .hc = { .ctype = 0x6310, .dtype = 0x9336}},
+		.flag = (DEVREG_MATCH_CU_TYPE |
 		      DEVREG_MATCH_DEV_TYPE | DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.oper_func = dasd_oper_handler
 	},
 	{
-		ci: {hc: {ctype: 0x3880, dtype:0x3370}},
-		flag:(DEVREG_MATCH_CU_TYPE |
+		.ci = { .hc = { .ctype = 0x3880, .dtype = 0x3370}},
+		.flag = (DEVREG_MATCH_CU_TYPE |
 		      DEVREG_MATCH_DEV_TYPE | DEVREG_TYPE_DEVCHARS),
-		oper_func:dasd_oper_handler
+		.oper_func = dasd_oper_handler
 	}
 };
 #endif
@@ -393,21 +394,21 @@
  * for one request. Give a little safety and the result is 96.
  */
 static dasd_discipline_t dasd_fba_discipline = {
-	owner:THIS_MODULE,
-	name:"FBA ",
-	ebcname:"FBA ",
-	max_blocks:96,
-	check_device:dasd_fba_check_device,
-	do_analysis:dasd_fba_do_analysis,
-	fill_geometry:dasd_fba_fill_geometry,
-	start_IO:dasd_start_IO,
-	term_IO:dasd_term_IO,
-	examine_error:dasd_fba_examine_error,
-	erp_action:dasd_fba_erp_action,
-	erp_postaction:dasd_fba_erp_postaction,
-	build_cp:dasd_fba_build_cp,
-	dump_sense:dasd_fba_dump_sense,
-	fill_info:dasd_fba_fill_info,
+	.owner=THIS_MODULE,
+	.name="FBA ",
+	.ebcname="FBA ",
+	.max_blocks=96,
+	.check_device=dasd_fba_check_device,
+	.do_analysis=dasd_fba_do_analysis,
+	.fill_geometry=dasd_fba_fill_geometry,
+	.start_IO=dasd_start_IO,
+	.term_IO=dasd_term_IO,
+	.examine_error=dasd_fba_examine_error,
+	.erp_action=dasd_fba_erp_action,
+	.erp_postaction=dasd_fba_erp_postaction,
+	.build_cp=dasd_fba_build_cp,
+	.dump_sense=dasd_fba_dump_sense,
+	.fill_info=dasd_fba_fill_info,
 };
 
 int
diff -urN linux-2.5.27/drivers/s390/block/dasd_genhd.c linux-2.5.27-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5.27/drivers/s390/block/dasd_genhd.c	Sat Jul 20 21:11:31 2002
+++ linux-2.5.27-s390/drivers/s390/block/dasd_genhd.c	Mon Jul 22 18:30:51 2002
@@ -200,13 +200,15 @@
  * Return pointer to gendisk structure by kdev.
  */
 struct gendisk *
-dasd_gendisk_from_major(int major)
+dasd_gendisk_from_bdev(struct block_device *bdev)
 {
 	struct list_head *l;
 	struct major_info *mi;
 	struct gendisk *gdp;
+	int major;
 
 	spin_lock(&dasd_major_lock);
+	major = MAJOR(bdev->bd_dev);
 	gdp = NULL;
 	list_for_each(l, &dasd_major_info) {
 		mi = list_entry(l, struct major_info, list);
@@ -322,7 +324,8 @@
 void
 dasd_setup_partitions(dasd_device_t * device)
 {
-	grok_partitions(device->kdev, device->blocks << device->s2b_shift);
+	grok_partitions(to_kdev_t(device->bdev->bd_dev),
+			device->blocks << device->s2b_shift);
 }
 
 /*
@@ -335,14 +338,14 @@
 	struct gendisk *gdp;
 	int minor, i;
 
-	gdp = dasd_gendisk_from_major(major(device->kdev));
+	gdp = dasd_gendisk_from_bdev(device->bdev);
 	if (gdp == NULL)
 		return;
 
-	wipe_partitions(device->kdev);
+	wipe_partitions(to_kdev_t(device->bdev->bd_dev));
 
 	/* FIXME: do we really need that */
-	minor = minor(device->kdev);
+	minor = MINOR(device->bdev->bd_dev);
 	for (i = 0; i < (1 << DASD_PARTN_BITS); i++)
 		gdp->sizes[minor + i] = 0;
 
@@ -351,7 +354,7 @@
 	 * but the 1 as third parameter makes it do an unregister...
 	 * FIXME: there must be a better way to get rid of the devfs entries
 	 */
-	devfs_register_partitions(gdp, minor(device->kdev), 1);
+	devfs_register_partitions(gdp, minor, 1);
 }
 
 extern int (*genhd_dasd_name)(char *, int, int, struct gendisk *);
diff -urN linux-2.5.27/drivers/s390/block/dasd_int.h linux-2.5.27-s390/drivers/s390/block/dasd_int.h
--- linux-2.5.27/drivers/s390/block/dasd_int.h	Sat Jul 20 21:11:28 2002
+++ linux-2.5.27-s390/drivers/s390/block/dasd_int.h	Mon Jul 22 18:30:51 2002
@@ -69,7 +69,9 @@
 /*
  * SECTION: Type definitions
  */
-typedef int (*dasd_ioctl_fn_t) (void *inp, int no, long args);
+struct dasd_device_t;
+
+typedef int (*dasd_ioctl_fn_t) (struct block_device *bdev, int no, long args);
 
 typedef struct {
 	struct list_head list;
@@ -139,9 +141,8 @@
 /* messages to be written via klogd and dbf */
 #define DEV_MESSAGE(d_loglevel,d_device,d_string,d_args...)\
 do { \
-	printk(d_loglevel PRINTK_HEADER " /dev/%-7s(%3d:%3d),%04x@%02x: " \
-	       d_string "\n", d_device->name, \
-	       major(d_device->kdev), minor(d_device->kdev), \
+	printk(d_loglevel PRINTK_HEADER " %s,%04x@%02x: " \
+	       d_string "\n", bdevname(d_device->bdev), \
 	       d_device->devinfo.devno, d_device->devinfo.irq, \
 	       d_args); \
 	DBF_DEV_EVENT(DBF_ALERT, d_device, d_string, d_args); \
@@ -153,8 +154,6 @@
 	DBF_EVENT(DBF_ALERT, d_string, d_args); \
 } while(0)
 
-struct dasd_device_t;
-
 typedef struct dasd_ccw_req_t {
 	unsigned int magic;		/* Eye catcher */
         struct list_head list;		/* list_head for request queueing. */
@@ -262,7 +261,7 @@
 typedef struct dasd_device_t {
 	/* Block device stuff. */
 	char name[16];			/* The device name in /dev. */
-	kdev_t kdev;
+	struct block_device *bdev;
 	devfs_handle_t devfs_entry;
 	request_queue_t *request_queue;
 	spinlock_t request_queue_lock;
@@ -467,6 +466,7 @@
 dasd_devmap_t *dasd_devmap_from_devindex(int);
 dasd_devmap_t *dasd_devmap_from_irq(int);
 dasd_devmap_t *dasd_devmap_from_kdev(kdev_t);
+dasd_devmap_t *dasd_devmap_from_bdev(struct block_device *bdev);
 dasd_device_t *dasd_get_device(dasd_devmap_t *);
 void dasd_put_device(dasd_devmap_t *);
 
@@ -480,7 +480,7 @@
 void dasd_gendisk_exit(void);
 int  dasd_gendisk_new_major(void);
 int  dasd_gendisk_major_index(int);
-struct gendisk *dasd_gendisk_from_major(int);
+struct gendisk *dasd_gendisk_from_bdev(struct block_device *bdev);
 struct gendisk *dasd_gendisk_from_devindex(int);
 int  dasd_device_name(char *, int, int, struct gendisk *);
 void dasd_setup_partitions(dasd_device_t *);
diff -urN linux-2.5.27/drivers/s390/block/dasd_ioctl.c linux-2.5.27-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.5.27/drivers/s390/block/dasd_ioctl.c	Sat Jul 20 21:11:05 2002
+++ linux-2.5.27-s390/drivers/s390/block/dasd_ioctl.c	Mon Jul 22 18:30:51 2002
@@ -91,6 +91,7 @@
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 	dasd_ioctl_list_t *ioctl;
+	struct block_device *bdev;
 	struct list_head *l;
 	const char *dir;
 	int rc;
@@ -101,13 +102,17 @@
 		PRINT_DEBUG("empty data ptr");
 		return -EINVAL;
 	}
-	devmap = dasd_devmap_from_kdev(inp->i_rdev);
+	bdev = bdget(kdev_t_to_nr(inp->i_rdev));
+	if (!bdev)
+		return -EINVAL;
+
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device)) {
 		MESSAGE(KERN_WARNING,
-			"No device registered as device (%d:%d)",
-			major(inp->i_rdev), minor(inp->i_rdev));
+			"No device registered as device %s", bdevname(bdev));
+		bdput(bdev);
 		return -EINVAL;
 	}
 	dir = _IOC_DIR (no) == _IOC_NONE ? "0" :
@@ -125,11 +130,12 @@
 			if (ioctl->owner) {
 				if (try_inc_mod_count(ioctl->owner) != 0)
 					continue;
-				rc = ioctl->handler(inp, no, data);
+				rc = ioctl->handler(bdev, no, data);
 				__MOD_DEC_USE_COUNT(ioctl->owner);
 			} else
-				rc = ioctl->handler(inp, no, data);
+				rc = ioctl->handler(bdev, no, data);
 			dasd_put_device(devmap);
+			bdput(bdev);
 			return rc;
 		}
 	}
@@ -138,10 +144,12 @@
 		      "unknown ioctl 0x%08x=%s'0x%x'%d(%d) data %8lx", no,
 		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
 	dasd_put_device(devmap);
+	bdput(bdev);
 	return -ENOTTY;
 }
 
-static int dasd_ioctl_api_version(void *inp, int no, long args)
+static int
+dasd_ioctl_api_version(struct block_device *bdev, int no, long args)
 {
 	int ver = DASD_API_VERSION;
 	return put_user(ver, (int *) args);
@@ -150,7 +158,8 @@
 /*
  * Enable device.
  */
-static int dasd_ioctl_enable(void *inp, int no, long args)
+static int
+dasd_ioctl_enable(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -158,7 +167,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -172,14 +181,15 @@
 /*
  * Disable device.
  */
-static int dasd_ioctl_disable(void *inp, int no, long args)
+static int
+dasd_ioctl_disable(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -245,7 +255,8 @@
 /*
  * Format device.
  */
-static int dasd_ioctl_format(void *inp, int no, long args)
+static int
+dasd_ioctl_format(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -257,8 +268,8 @@
 	if (!args)
 		return -EINVAL;
 	/* fdata == NULL is no longer a valid arg to dasd_format ! */
-	partn = minor(((struct inode *) inp)->i_rdev) & DASD_PARTN_MASK;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	partn = MINOR(bdev->bd_dev) & DASD_PARTN_MASK;
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -283,14 +294,15 @@
 /*
  * Reset device profile information
  */
-static int dasd_ioctl_reset_profile(void *inp, int no, long args)
+static int
+dasd_ioctl_reset_profile(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -303,13 +315,14 @@
 /*
  * Return device profile information
  */
-static int dasd_ioctl_read_profile(void *inp, int no, long args)
+static int
+dasd_ioctl_read_profile(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 	int rc;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -322,12 +335,14 @@
 	return rc;
 }
 #else
-static int dasd_ioctl_reset_profile(void *inp, int no, long args)
+static int
+dasd_ioctl_reset_profile(struct block_device *bdev, int no, long args)
 {
 	return -ENOSYS;
 }
 
-static int dasd_ioctl_read_profile(void *inp, int no, long args)
+static int
+dasd_ioctl_read_profile(struct block_device *bdev, int no, long args)
 {
 	return -ENOSYS;
 }
@@ -336,15 +351,16 @@
 /*
  * Return dasd information. Used for BIODASDINFO and BIODASDINFO2.
  */
-static int dasd_ioctl_information(void *inp, int no, long args)
+static int
+dasd_ioctl_information(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
-	dasd_information2_t dasd_info;
+	dasd_information2_t *dasd_info;
 	unsigned long flags;
 	int rc;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -354,20 +370,26 @@
 		return -EINVAL;
 	}
 
-	rc = device->discipline->fill_info(device, &dasd_info);
+	dasd_info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
+	if (dasd_info == NULL) {
+		dasd_put_device(devmap);
+		return -ENOMEM;
+	}
+	rc = device->discipline->fill_info(device, dasd_info);
 	if (rc) {
 		dasd_put_device(devmap);
+		kfree(dasd_info);
 		return rc;
 	}
 
-	dasd_info.devno = device->devinfo.devno;
-	dasd_info.schid = device->devinfo.irq;
-	dasd_info.cu_type = device->devinfo.sid_data.cu_type;
-	dasd_info.cu_model = device->devinfo.sid_data.cu_model;
-	dasd_info.dev_type = device->devinfo.sid_data.dev_type;
-	dasd_info.dev_model = device->devinfo.sid_data.dev_model;
-	dasd_info.open_count = atomic_read(&device->open_count);
-	dasd_info.status = device->state;
+	dasd_info->devno = device->devinfo.devno;
+	dasd_info->schid = device->devinfo.irq;
+	dasd_info->cu_type = device->devinfo.sid_data.cu_type;
+	dasd_info->cu_model = device->devinfo.sid_data.cu_model;
+	dasd_info->dev_type = device->devinfo.sid_data.dev_type;
+	dasd_info->dev_model = device->devinfo.sid_data.dev_model;
+	dasd_info->open_count = atomic_read(&device->open_count);
+	dasd_info->status = device->state;
 	
 	/*
 	 * check if device is really formatted
@@ -375,16 +397,16 @@
 	 */
 	if ((device->state < DASD_STATE_READY) ||
 	    (dasd_check_blocksize(device->bp_block)))
-		dasd_info.format = DASD_FORMAT_NONE;
+		dasd_info->format = DASD_FORMAT_NONE;
 	
-	dasd_info.features = devmap->features;
+	dasd_info->features = devmap->features;
 	
 	if (device->discipline)
-		memcpy(dasd_info.type, device->discipline->name, 4);
+		memcpy(dasd_info->type, device->discipline->name, 4);
 	else
-		memcpy(dasd_info.type, "none", 4);
-	dasd_info.req_queue_len = 0;
-	dasd_info.chanq_len = 0;
+		memcpy(dasd_info->type, "none", 4);
+	dasd_info->req_queue_len = 0;
+	dasd_info->chanq_len = 0;
 	if (device->request_queue->request_fn) {
 		struct list_head *l;
 #ifdef DASD_EXTENDED_PROFILING
@@ -392,45 +414,46 @@
 			struct list_head *l;
 			spin_lock_irqsave(&device->lock, flags);
 			list_for_each(l, &device->request_queue->queue_head)
-				dasd_info.req_queue_len++;
+				dasd_info->req_queue_len++;
 			spin_unlock_irqrestore(&device->lock, flags);
 		}
 #endif				/* DASD_EXTENDED_PROFILING */
 		spin_lock_irqsave(get_irq_lock(device->devinfo.irq), flags);
 		list_for_each(l, &device->ccw_queue)
-			dasd_info.chanq_len++;
+			dasd_info->chanq_len++;
 		spin_unlock_irqrestore(get_irq_lock(device->devinfo.irq),
 				       flags);
 	}
 	
 	rc = 0;
-	if (copy_to_user((long *) args, (long *) &dasd_info,
+	if (copy_to_user((long *) args, (long *) dasd_info,
 			 ((no == (unsigned int) BIODASDINFO2) ?
 			  sizeof (dasd_information2_t) :
 			  sizeof (dasd_information_t))))
 		rc = -EFAULT;
 	dasd_put_device(devmap);
+	kfree(dasd_info);
 	return rc;
 }
 
 /*
  * Set read only
  */
-static int dasd_ioctl_set_ro(void *inp, int no, long args)
+static int
+dasd_ioctl_set_ro(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
-	int major, minor;
 	int intval, i;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (minor(((struct inode *) inp)->i_rdev) & DASD_PARTN_MASK)
+	if (MINOR(bdev->bd_dev) & DASD_PARTN_MASK)
 		// ro setting is not allowed for partitions
 		return -EINVAL;
 	if (get_user(intval, (int *) args))
 		return -EFAULT;
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -439,57 +462,55 @@
 		devmap->features |= DASD_FEATURE_READONLY;
 	else
 		devmap->features &= ~DASD_FEATURE_READONLY;
-	major = major(device->kdev);
-	minor = minor(device->kdev);
 	for (i = 0; i < (1 << DASD_PARTN_BITS); i++)
-		set_device_ro(mk_kdev(major, minor + i), intval);
+		set_device_ro(to_kdev_t(bdev->bd_dev + i), intval);
 	dasd_put_device(devmap);
 	return 0;
 }
 
-static int dasd_ioctl_blkioctl(void *inp, int no, long args)
+static int
+dasd_ioctl_blkioctl(struct block_device *bdev, int no, long args)
 {
-	return blk_ioctl(((struct inode *) inp)->i_bdev, no, args);
+	return blk_ioctl(bdev, no, args);
 }
 
 /*
  * Return device size in number of sectors.
  */
-static int dasd_ioctl_blkgetsize(void *inp, int no, long args)
+static int
+dasd_ioctl_blkgetsize(struct block_device *bdev, int no, long args)
 {
 	struct gendisk *gdp;
-	kdev_t kdev;
 	long blocks;
 
-	kdev = ((struct inode *) inp)->i_rdev;
-	gdp = dasd_gendisk_from_major(major(kdev));
+	gdp = dasd_gendisk_from_bdev(bdev);
 	if (gdp == NULL)
 		return -EINVAL;
-	blocks = gdp->sizes[minor(kdev)] << 1;
+	blocks = gdp->sizes[MINOR(bdev->bd_dev)] << 1;
 	return put_user(blocks, (long *) args);
 }
 
 /*
  * Return device size in number of sectors, 64bit version.
  */
-static int dasd_ioctl_blkgetsize64(void *inp, int no, long args)
+static int
+dasd_ioctl_blkgetsize64(struct block_device *bdev, int no, long args)
 {
 	struct gendisk *gdp;
-	kdev_t kdev;
 	u64 blocks;
 
-	kdev = ((struct inode *) inp)->i_rdev;
-	gdp = dasd_gendisk_from_major(major(kdev));
+	gdp = dasd_gendisk_from_bdev(bdev);
 	if (gdp == NULL)
 		return -EINVAL;
-	blocks = gdp->sizes[minor(kdev)] << 1;
+	blocks = gdp->sizes[MINOR(bdev->bd_dev)] << 1;
 	return put_user(blocks << 10, (u64 *) args);
 }
 
 /*
  * Reread partition table.
  */
-static int dasd_ioctl_rr_partition(void *inp, int no, long args)
+static int
+dasd_ioctl_rr_partition(struct block_device *bdev, int no, long args)
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
@@ -497,7 +518,7 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	devmap = dasd_devmap_from_kdev(((struct inode *) inp)->i_rdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -514,16 +535,15 @@
 /*
  * Return disk geometry.
  */
-static int dasd_ioctl_getgeo(void *inp, int no, long args)
+static int
+dasd_ioctl_getgeo(struct block_device *bdev, int no, long args)
 {
 	struct hd_geometry geo = { 0, };
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
-	kdev_t kdev;
 	int rc;
 
-	kdev = ((struct inode *) inp)->i_rdev;
-	devmap = dasd_devmap_from_kdev(kdev);
+	devmap = dasd_devmap_from_bdev(bdev);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
 	if (IS_ERR(device))
@@ -532,7 +552,7 @@
 	if (device != NULL && device->discipline != NULL &&
 	    device->discipline->fill_geometry != NULL) {
 		device->discipline->fill_geometry(device, &geo);
-		geo.start = get_start_sect(kdev);
+		geo.start = get_start_sect(to_kdev_t(bdev->bd_dev));
 		if (copy_to_user((struct hd_geometry *) args, &geo,
 				 sizeof (struct hd_geometry)))
 			rc = -EFAULT;
diff -urN linux-2.5.27/drivers/s390/block/dasd_proc.c linux-2.5.27-s390/drivers/s390/block/dasd_proc.c
--- linux-2.5.27/drivers/s390/block/dasd_proc.c	Sat Jul 20 21:11:10 2002
+++ linux-2.5.27-s390/drivers/s390/block/dasd_proc.c	Mon Jul 22 19:36:37 2002
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
+#include <linux/vmalloc.h>
 
 #include <asm/debug.h>
 #include <asm/irq.h>
@@ -274,10 +275,10 @@
 }
 
 static struct file_operations dasd_devices_file_ops = {
-	read:dasd_generic_read,		/* read */
-	write:dasd_devices_write,	/* write */
-	open:dasd_devices_open,		/* open */
-	release:dasd_generic_close,	/* close */
+	.read=dasd_generic_read,		/* read */
+	.write=dasd_devices_write,	/* write */
+	.open=dasd_devices_open,		/* open */
+	.release=dasd_generic_close,	/* close */
 };
 
 static struct inode_operations dasd_devices_inode_ops = {
@@ -430,10 +431,10 @@
 }
 
 static struct file_operations dasd_statistics_file_ops = {
-	read:	dasd_generic_read,	/* read */
-	write:	dasd_statistics_write,	/* write */
-	open:	dasd_statistics_open,	/* open */
-	release:dasd_generic_close,	/* close */
+	.read=dasd_generic_read,	/* read */
+	.write=dasd_statistics_write,	/* write */
+	.open=dasd_statistics_open,	/* open */
+	.release=dasd_generic_close,	/* close */
 };
 
 static struct inode_operations dasd_statistics_inode_ops = {
diff -urN linux-2.5.27/drivers/s390/block/xpram.c linux-2.5.27-s390/drivers/s390/block/xpram.c
--- linux-2.5.27/drivers/s390/block/xpram.c	Sat Jul 20 21:11:30 2002
+++ linux-2.5.27-s390/drivers/s390/block/xpram.c	Mon Jul 22 19:36:37 2002
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
@@ -48,8 +48,8 @@
 #define PRINT_ERR(x...)		printk(KERN_ERR XPRAM_NAME " error:" x)
 
 static struct device xpram_sys_device = {
-	name: "S/390 expanded memory RAM disk",
-	bus_id: "xpram",
+	.name = "S/390 expanded memory RAM disk",
+	.bus_id = "xpram",
 };
 
 typedef struct {
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
@@ -375,10 +372,9 @@
 
 static struct block_device_operations xpram_devops =
 {
-	owner:   THIS_MODULE,
-	ioctl:   xpram_ioctl,
-	open:    xpram_open,
-	release: xpram_release,
+	.owner = THIS_MODULE,
+	.ioctl = xpram_ioctl,
+	.open = xpram_open,
 };
 
 /*
diff -urN linux-2.5.27/drivers/s390/char/con3215.c linux-2.5.27-s390/drivers/s390/char/con3215.c
--- linux-2.5.27/drivers/s390/char/con3215.c	Sat Jul 20 21:11:09 2002
+++ linux-2.5.27-s390/drivers/s390/char/con3215.c	Mon Jul 22 19:36:37 2002
@@ -89,7 +89,7 @@
         int written;                  /* number of bytes in write requests */
 	devstat_t devstat;	      /* device status structure for do_IO */
 	struct tty_struct *tty;	      /* pointer to tty structure if present */
-	struct tq_struct tqueue;      /* task queue to bottom half */
+	struct tasklet_struct tasklet;
 	raw3215_req *queued_read;     /* pointer to queued read requests */
 	raw3215_req *queued_write;    /* pointer to queued write requests */
 	wait_queue_head_t empty_wait; /* wait queue for flushing */
@@ -341,7 +341,7 @@
  * The bottom half handler routine for 3215 devices. It tries to start
  * the next IO and wakes up processes waiting on the tty.
  */
-static void raw3215_softint(void *data)
+static void raw3215_tasklet(void *data)
 {
 	raw3215_info *raw;
 	struct tty_struct *tty;
@@ -377,12 +377,7 @@
         if (raw->flags & RAW3215_BH_PENDING)
                 return;       /* already pending */
         raw->flags |= RAW3215_BH_PENDING;
-	INIT_LIST_HEAD(&raw->tqueue.list);
-	raw->tqueue.sync = 0;
-        raw->tqueue.routine = raw3215_softint;
-        raw->tqueue.data = raw;
-        queue_task(&raw->tqueue, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
+	tasklet_hi_schedule(&raw->tasklet);
 }
 
 /*
@@ -824,12 +819,12 @@
  *  The console structure for the 3215 console
  */
 static struct console con3215 = {
-	name:		"tty3215",
-	write:		con3215_write,
-	device:		con3215_device,
-	unblank:	con3215_unblank,
-	setup:		con3215_consetup,
-	flags:		CON_PRINTBUFFER,
+	.name =		"tty3215",
+	.write =	con3215_write,
+	.device =	con3215_device,
+	.unblank =	con3215_unblank,
+	.setup =	con3215_consetup,
+	.flags =	CON_PRINTBUFFER,
 };
 
 #endif
@@ -867,8 +862,9 @@
 			kfree(raw);
 			return -ENOMEM;
 		}
-		raw->tqueue.routine = raw3215_softint;
-		raw->tqueue.data = raw;
+		tasklet_init(&raw->tasklet, 
+			     (void (*)(unsigned long)) raw3215_tasklet,
+			     (unsigned long) raw);
                 init_waitqueue_head(&raw->empty_wait);
 		raw3215[line] = raw;
 	}
@@ -1097,8 +1093,9 @@
 	/* Find the first console */
 	raw->irq = raw3215_find_dev(0);
 	raw->flags |= RAW3215_FIXED;
-	raw->tqueue.routine = raw3215_softint;
-	raw->tqueue.data = raw;
+	tasklet_init(&raw->tasklet, 
+		     (void (*)(unsigned long)) raw3215_tasklet,
+		     (unsigned long) raw);
         init_waitqueue_head(&raw->empty_wait);
 
 	/* Request the console irq */
diff -urN linux-2.5.27/drivers/s390/char/ctrlchar.c linux-2.5.27-s390/drivers/s390/char/ctrlchar.c
--- linux-2.5.27/drivers/s390/char/ctrlchar.c	Sat Jul 20 21:12:29 2002
+++ linux-2.5.27-s390/drivers/s390/char/ctrlchar.c	Mon Jul 22 18:30:51 2002
@@ -26,7 +26,7 @@
 
 static void
 ctrlchar_handle_sysrq(struct tty_struct *tty) {
-	handle_sysrq(ctrlchar_sysrq_key, NULL, NULL, tty);
+	handle_sysrq(ctrlchar_sysrq_key, NULL, tty);
 }
 #endif
 
diff -urN linux-2.5.27/drivers/s390/char/hwc_con.c linux-2.5.27-s390/drivers/s390/char/hwc_con.c
--- linux-2.5.27/drivers/s390/char/hwc_con.c	Sat Jul 20 21:11:06 2002
+++ linux-2.5.27-s390/drivers/s390/char/hwc_con.c	Mon Jul 22 19:36:37 2002
@@ -34,11 +34,11 @@
 struct console hwc_console =
 {
 
-	name:hwc_console_name,
-	write:hwc_console_write,
-	device:hwc_console_device,
-	unblank:hwc_console_unblank,
-	flags:CON_PRINTBUFFER,
+	.name=hwc_console_name,
+	.write=hwc_console_write,
+	.device=hwc_console_device,
+	.unblank=hwc_console_unblank,
+	.flags=CON_PRINTBUFFER,
 };
 
 void 
diff -urN linux-2.5.27/drivers/s390/char/tape.c linux-2.5.27-s390/drivers/s390/char/tape.c
--- linux-2.5.27/drivers/s390/char/tape.c	Sat Jul 20 21:11:25 2002
+++ linux-2.5.27-s390/drivers/s390/char/tape.c	Mon Jul 22 19:36:37 2002
@@ -199,9 +199,9 @@
 
 static struct file_operations tape_proc_devices_file_ops =
 {
-	read:tape_proc_devices_read,	/* read */
-	open:tape_proc_devices_open,	/* open */
-	release:tape_proc_devices_release,	/* close */
+	.read=tape_proc_devices_read,		/* read */
+	.open=tape_proc_devices_open,		/* open */
+	.release=tape_proc_devices_release,	/* close */
 };
 
 /* 
diff -urN linux-2.5.27/drivers/s390/char/tapechar.c linux-2.5.27-s390/drivers/s390/char/tapechar.c
--- linux-2.5.27/drivers/s390/char/tapechar.c	Sat Jul 20 21:11:16 2002
+++ linux-2.5.27-s390/drivers/s390/char/tapechar.c	Mon Jul 22 19:36:37 2002
@@ -40,11 +40,11 @@
  */
 static struct file_operations tape_fops =
 {
-	read:tapechar_read,
-	write:tapechar_write,
-	ioctl:tapechar_ioctl,
-	open:tapechar_open,
-	release:tapechar_release,
+	.read=tapechar_read,
+	.write=tapechar_write,
+	.ioctl=tapechar_ioctl,
+	.open=tapechar_open,
+	.release=tapechar_release,
 };
 
 int tapechar_major = TAPECHAR_MAJOR;
diff -urN linux-2.5.27/drivers/s390/char/tubfs.c linux-2.5.27-s390/drivers/s390/char/tubfs.c
--- linux-2.5.27/drivers/s390/char/tubfs.c	Sat Jul 20 21:11:24 2002
+++ linux-2.5.27-s390/drivers/s390/char/tubfs.c	Mon Jul 22 19:36:37 2002
@@ -24,13 +24,13 @@
 
 static struct file_operations fs3270_fops = {
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0))
-	owner: THIS_MODULE,		/* owner */
+	.owner: THIS_MODULE,		/* owner */
 #endif
-	read: 	fs3270_read,	/* read */
-	write:	fs3270_write,	/* write */
-	ioctl:	fs3270_ioctl,	/* ioctl */
-	open: 	fs3270_open,	/* open */
-	release:fs3270_close,	/* release */
+	.read=fs3270_read,	/* read */
+	.write=fs3270_write,	/* write */
+	.ioctl=fs3270_ioctl,	/* ioctl */
+	.open=fs3270_open,	/* open */
+	.release=fs3270_close,	/* release */
 };
 
 #ifdef CONFIG_DEVFS_FS
diff -urN linux-2.5.27/drivers/s390/cio/blacklist.c linux-2.5.27-s390/drivers/s390/cio/blacklist.c
--- linux-2.5.27/drivers/s390/cio/blacklist.c	Sat Jul 20 21:11:12 2002
+++ linux-2.5.27-s390/drivers/s390/cio/blacklist.c	Mon Jul 22 18:30:51 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.5 $
+ *   $Revision: 1.6 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -243,10 +243,10 @@
 		return -EFAULT;
 	}
 	buf[user_len] = '\0';
-
+#if 0
 	CIO_DEBUG(KERN_DEBUG, 2, 
 		  "/proc/cio_ignore: '%s'\n", buf);
-
+#endif
 	blacklist_parse_proc_parameters (buf);
 
 	vfree (buf);
diff -urN linux-2.5.27/drivers/s390/cio/chsc.c linux-2.5.27-s390/drivers/s390/cio/chsc.c
--- linux-2.5.27/drivers/s390/cio/chsc.c	Sat Jul 20 21:11:05 2002
+++ linux-2.5.27-s390/drivers/s390/cio/chsc.c	Mon Jul 22 19:36:37 2002
@@ -70,13 +70,13 @@
 		*ssd_res = &chsc_area_ssd.response_block.response_block_data.ssd_res;
 
 	chsc_area_ssd = (chsc_area_t) {
-		request_block: {
-			command_code1: 0x0010,
-			command_code2: 0x0004,
-			request_block_data: {
-				ssd_req: {
-					f_sch: irq,
-					l_sch: irq,
+		.request_block = {
+			.command_code1 = 0x0010,
+			.command_code2 = 0x0004,
+			.request_block_data = {
+				.ssd_req = {
+					.f_sch = irq,
+					.l_sch = irq,
 				}
 			}
 		}
@@ -554,9 +554,9 @@
 	 * allocation or prove that this function does not have to be
 	 * reentrant! */
 	static chsc_area_t chsc_area_sei __attribute__ ((aligned(PAGE_SIZE))) = {
-		request_block: {
-			command_code1: 0x0010,
-			command_code2: 0x000e
+		.request_block = {
+			.command_code1 = 0x0010,
+			.command_code2 = 0x000e
 		}
 	};
 
diff -urN linux-2.5.27/drivers/s390/cio/cio.c linux-2.5.27-s390/drivers/s390/cio/cio.c
--- linux-2.5.27/drivers/s390/cio/cio.c	Sat Jul 20 21:12:26 2002
+++ linux-2.5.27-s390/drivers/s390/cio/cio.c	Mon Jul 22 18:30:51 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.15 $
+ *   $Revision: 1.17 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -52,7 +52,7 @@
 	}
 	DBG ("%s\n", buffer);
 	if (cio_debug_initialized) 
-		debug_text_event (cio_debug_trace_id, level, buffer);
+		debug_text_event (cio_debug_msg_id, level, buffer);
 }
 
 
@@ -1448,7 +1448,7 @@
 	
 	ioinfo[irq]->devstat.intparm = 0;
 	
-	if (!ioinfo[irq]->ui.flags.s_pend) 
+	if (!(ioinfo[irq]->ui.flags.s_pend || ioinfo[irq]->ui.flags.repnone))
 		ioinfo[irq]->irq_desc.handler (irq, udp, NULL);
 	
 	return 1;
diff -urN linux-2.5.27/drivers/s390/cio/cio_debug.h linux-2.5.27-s390/drivers/s390/cio/cio_debug.h
--- linux-2.5.27/drivers/s390/cio/cio_debug.h	Sat Jul 20 21:11:28 2002
+++ linux-2.5.27-s390/drivers/s390/cio/cio_debug.h	Mon Jul 22 18:30:51 2002
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
 
diff -urN linux-2.5.27/drivers/s390/cio/proc.c linux-2.5.27-s390/drivers/s390/cio/proc.c
--- linux-2.5.27/drivers/s390/cio/proc.c	Sat Jul 20 21:11:08 2002
+++ linux-2.5.27-s390/drivers/s390/cio/proc.c	Mon Jul 22 19:36:37 2002
@@ -154,7 +154,7 @@
 }
 
 static struct file_operations chan_subch_file_ops = {
-	read:chan_subch_read, open:chan_subch_open, release:chan_subch_close,
+	.read=chan_subch_read, .open=chan_subch_open, .release=chan_subch_close,
 };
 
 static int
@@ -245,8 +245,8 @@
 }
 
 static struct file_operations cio_irq_proc_file_ops = {
-	read:cio_irq_proc_read, open:cio_irq_proc_open,
-	release:cio_irq_proc_close,
+	.read=cio_irq_proc_read, .open=cio_irq_proc_open,
+	.release=cio_irq_proc_close,
 };
 
 static int
diff -urN linux-2.5.27/drivers/s390/cio/requestirq.c linux-2.5.27-s390/drivers/s390/cio/requestirq.c
--- linux-2.5.27/drivers/s390/cio/requestirq.c	Sat Jul 20 21:11:28 2002
+++ linux-2.5.27-s390/drivers/s390/cio/requestirq.c	Mon Jul 22 18:30:51 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/requestirq.c
  *   S/390 common I/O routines -- 
- *   $Revision: 1.7 $
+ *   $Revision: 1.8 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -141,7 +141,7 @@
 
 	s390irq_spin_lock_irqsave (irq, flags);
 
-	CIO_DEBUG_NOCONS(irq,KERN_DEBUG, printk, 2, 
+	CIO_DEBUG_NOCONS(irq,KERN_DEBUG, DBG, 2, 
 			 "Trying to free IRQ %d\n", 
 			 irq);
 
diff -urN linux-2.5.27/drivers/s390/cio/s390io.c linux-2.5.27-s390/drivers/s390/cio/s390io.c
--- linux-2.5.27/drivers/s390/cio/s390io.c	Sat Jul 20 21:11:32 2002
+++ linux-2.5.27-s390/drivers/s390/cio/s390io.c	Mon Jul 22 18:30:51 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/s390io.c
  *   S/390 common I/O routines
- *   $Revision: 1.11 $
+ *   $Revision: 1.12 $
  *
  *  S390 version
  *    Copyright (C) 1999, 2000 IBM Deutschland Entwicklung GmbH,
@@ -1910,12 +1910,19 @@
 
 				ret = 0;
 
-			} else {
+			} else if (ret == -ENODEV) {
 
 				CIO_DEBUG(KERN_ERR, 2,
-					  "PathVerification(%04X) - "
-					  "Unexpected error on device %04X\n",
+					  "PathVerification(%04X) "
+					  "- Device %04X is no longer there?!?\n",
 					  irq, ioinfo[irq]->schib.pmcw.dev);
+
+			} else if (ret) {
+
+				CIO_DEBUG(KERN_ERR, 2,
+					  "PathVerification(%04X) - "
+					  "Unexpected error %d on device %04X\n",
+					  irq, ret, ioinfo[irq]->schib.pmcw.dev);
 				
 				ioinfo[irq]->ui.flags.pgid_supp = 0;
 			}
diff -urN linux-2.5.27/drivers/s390/misc/chandev.c linux-2.5.27-s390/drivers/s390/misc/chandev.c
--- linux-2.5.27/drivers/s390/misc/chandev.c	Sat Jul 20 21:11:14 2002
+++ linux-2.5.27-s390/drivers/s390/misc/chandev.c	Mon Jul 22 18:30:51 2002
@@ -24,6 +24,7 @@
 #include <asm/s390dyn.h>
 #include <asm/queue.h>
 #include <linux/kmod.h>
+#include <linux/tqueue.h>
 #ifndef MIN
 #define MIN(a,b) ((a<b)?a:b)
 #endif
diff -urN linux-2.5.27/drivers/s390/net/ctcmain.c linux-2.5.27-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.27/drivers/s390/net/ctcmain.c	Sat Jul 20 21:11:13 2002
+++ linux-2.5.27-s390/drivers/s390/net/ctcmain.c	Mon Jul 22 19:36:37 2002
@@ -49,6 +49,7 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 
 #include <linux/signal.h>
 #include <linux/string.h>
@@ -2888,17 +2889,17 @@
 }
 
 static struct file_operations ctc_stat_fops = {
-	read:    ctc_stat_read,
-	write:   ctc_stat_write,
-	open:    ctc_stat_open,
-	release: ctc_stat_close,
+	.read    = ctc_stat_read,
+	.write   = ctc_stat_write,
+	.open    = ctc_stat_open,
+	.release = ctc_stat_close,
 };
 
 static struct file_operations ctc_ctrl_fops = {
-	read:    ctc_ctrl_read,
-	write:   ctc_ctrl_write,
-	open:    ctc_ctrl_open,
-	release: ctc_ctrl_close,
+	.read    = ctc_ctrl_read,
+	.write   = ctc_ctrl_write,
+	.open    = ctc_ctrl_open,
+	.release = ctc_ctrl_close,
 };
 
 static struct proc_dir_entry *ctc_dir = NULL;
diff -urN linux-2.5.27/drivers/s390/net/ctctty.c linux-2.5.27-s390/drivers/s390/net/ctctty.c
--- linux-2.5.27/drivers/s390/net/ctctty.c	Sat Jul 20 21:11:22 2002
+++ linux-2.5.27-s390/drivers/s390/net/ctctty.c	Mon Jul 22 18:30:51 2002
@@ -86,7 +86,7 @@
   wait_queue_head_t	open_wait;
   wait_queue_head_t	close_wait;
   struct semaphore      write_sem;
-  struct tq_struct      tq;
+  struct tasklet_struct tasklet;
   struct timer_list     stoptimer;
 } ctc_tty_info;
 
@@ -272,8 +272,7 @@
 	 */
 	skb_queue_tail(&info->rx_queue, skb);
 	/* Schedule dequeuing */
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static int
@@ -390,8 +389,7 @@
 	skb_reserve(skb, skb_res);
 	*(skb_put(skb, 1)) = c;
 	skb_queue_head(&info->tx_queue, skb);
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static void
@@ -400,8 +398,7 @@
 	if (ctc_tty_shuttingdown)
 		return;
 	info->flags |= CTC_ASYNC_TX_LINESTAT;
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static void
@@ -562,8 +559,7 @@
 	}
 	if (skb_queue_len(&info->tx_queue)) {
 		info->lsr &= ~UART_LSR_TEMT;
-		queue_task(&info->tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		tasklet_schedule(&info->tasklet);
 	}
 	if (from_user)
 		up(&info->write_sem);
@@ -628,8 +624,7 @@
 		return;
 	if (tty->stopped || tty->hw_stopped || (!skb_queue_len(&info->tx_queue)))
 		return;
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 /*
@@ -1170,8 +1165,9 @@
  * the lower levels.
  */
 static void
-ctc_tty_task(ctc_tty_info *info)
+ctc_tty_task(unsigned long arg)
 {
+	ctc_tty_info *info = (void *)arg;
 	unsigned long saveflags;
 	int again;
 
@@ -1182,8 +1178,7 @@
 			info->lsr |= UART_LSR_TEMT;
 		again |= ctc_tty_readmodem(info);
 		if (again) {
-			queue_task(&info->tq, &tq_immediate);
-			mark_bh(IMMEDIATE_BH);
+			tasklet_schedule(&info->tasklet);
 		}
 	}
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
@@ -1243,14 +1238,8 @@
 	for (i = 0; i < CTC_TTY_MAX_DEVICES; i++) {
 		info = &driver->info[i];
 		init_MUTEX(&info->write_sem);
-#if LINUX_VERSION_CODE >= 0x020400
-		INIT_LIST_HEAD(&info->tq.list);
-#else
-		info->tq.next    = NULL;
-#endif
-		info->tq.sync    = 0;
-		info->tq.routine = (void *)(void *)ctc_tty_task;
-		info->tq.data    = info;
+		tasklet_init(&info->tasklet, ctc_tty_task,
+				(unsigned long) info);
 		info->magic = CTC_ASYNC_MAGIC;
 		info->line = i;
 		info->tty = 0;
@@ -1331,10 +1320,6 @@
 		kfree(driver);
 		driver = NULL;
 	} else {
-		int i;
-
-		for (i = 0; i < CTC_TTY_MAX_DEVICES; i++)
-			driver->info[i].tq.routine = NULL;
 		tty_unregister_driver(&driver->ctc_tty_device);
 	}
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
diff -urN linux-2.5.27/drivers/s390/net/iucv.c linux-2.5.27-s390/drivers/s390/net/iucv.c
--- linux-2.5.27/drivers/s390/net/iucv.c	Sat Jul 20 21:11:07 2002
+++ linux-2.5.27-s390/drivers/s390/net/iucv.c	Mon Jul 22 18:30:51 2002
@@ -41,9 +41,9 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/errno.h>
 #include <asm/atomic.h>
 #include "iucv.h"
 #include <asm/io.h>
@@ -99,16 +99,14 @@
 static struct list_head  iucv_irq_queue;
 static spinlock_t iucv_irq_queue_lock = SPIN_LOCK_UNLOCKED;
 
-static struct tq_struct  iucv_tq;
-
-static atomic_t   iucv_bh_scheduled = ATOMIC_INIT (0);
-
 /*
  *Internal function prototypes
  */
-static void iucv_bh_handler(void);
+static void iucv_tasklet_handler(unsigned long);
 static void iucv_irq_handler(struct pt_regs *, __u16);
 
+static DECLARE_TASKLET(iucv_tasklet,iucv_tasklet_handler,0);
+
 /************ FUNCTION ID'S ****************************/
 
 #define ACCEPT          10
@@ -302,7 +300,7 @@
 	if (debuglevel < 3)
 		return;
 
-	printk(KERN_DEBUG __FUNCTION__ ": %s\n", title);
+	printk(KERN_DEBUG "%s\n", title);
 	printk("  ");
 	for (i = 0; i < len; i++) {
 		if (!(i % 16) && i != 0)
@@ -318,7 +316,7 @@
 #define iucv_debug(lvl, fmt, args...) \
 do { \
 	if (debuglevel >= lvl) \
-		printk(KERN_DEBUG __FUNCTION__ ": " fmt "\n" , ## args); \
+		printk(KERN_DEBUG "%s: " fmt "\n", __FUNCTION__ , ## args); \
 } while (0)
 
 #else
@@ -385,11 +383,6 @@
 	}
 	memset(iucv_param_pool, 0, sizeof(iucv_param) * PARAM_POOL_SIZE);
 
-	/* Initialize task queue */
-	INIT_LIST_HEAD(&iucv_tq.list);
-	iucv_tq.sync = 0;
-	iucv_tq.routine = (void *)iucv_bh_handler;
-
 	/* Initialize irq queue */
 	INIT_LIST_HEAD(&iucv_irq_queue);
 
@@ -2177,7 +2170,7 @@
  * @code: irq code
  *
  * Handles external interrupts coming in from CP.
- * Places the interrupt buffer on a queue and schedules iucv_bh_handler().
+ * Places the interrupt buffer on a queue and schedules iucv_tasklet_handler().
  */
 static void
 iucv_irq_handler(struct pt_regs *regs, __u16 code)
@@ -2201,10 +2194,7 @@
 	list_add_tail(&irqdata->queue, &iucv_irq_queue);
 	spin_unlock(&iucv_irq_queue_lock);
 
-	if (atomic_compare_and_swap (0, 1, &iucv_bh_scheduled) == 0) {
-		queue_task (&iucv_tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
-	}
+	tasklet_schedule(&iucv_tasklet);
 
 	irq_exit(cpu, 0x4000);
 	return;
@@ -2215,7 +2205,7 @@
  * @int_buf: Pointer to copy of external interrupt buffer
  *
  * The workhorse for handling interrupts queued by iucv_irq_handler().
- * This function is called from the bottom half iucv_bh_handler().
+ * This function is called from the bottom half iucv_tasklet_handler().
  */
 static void
 iucv_do_int(iucv_GeneralInterrupt * int_buf)
@@ -2385,19 +2375,17 @@
 }
 
 /**
- * iucv_bh_handler:
+ * iucv_tasklet_handler:
  *
  * This function loops over the queue of irq buffers and runs iucv_do_int()
  * on every queue element.
  */
 static void
-iucv_bh_handler(void)
+iucv_tasklet_handler(unsigned long ignored)
 {
 	struct list_head head;
 	struct list_head *next;
 	ulong  flags;
-
-	atomic_set(&iucv_bh_scheduled, 0);
 
 	spin_lock_irqsave(&iucv_irq_queue_lock, flags);
 	list_add(&head, &iucv_irq_queue);
diff -urN linux-2.5.27/drivers/s390/net/lcs.c linux-2.5.27-s390/drivers/s390/net/lcs.c
--- linux-2.5.27/drivers/s390/net/lcs.c	Sat Jul 20 21:11:08 2002
+++ linux-2.5.27-s390/drivers/s390/net/lcs.c	Mon Jul 22 18:44:42 2002
@@ -124,6 +124,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <asm/system.h>
diff -urN linux-2.5.27/drivers/s390/net/netiucv.c linux-2.5.27-s390/drivers/s390/net/netiucv.c
--- linux-2.5.27/drivers/s390/net/netiucv.c	Sat Jul 20 21:11:23 2002
+++ linux-2.5.27-s390/drivers/s390/net/netiucv.c	Mon Jul 22 19:36:37 2002
@@ -465,13 +465,13 @@
 }
 
 static iucv_interrupt_ops_t netiucv_ops = {
-	ConnectionPending:  netiucv_callback_connreq,
-	ConnectionComplete: netiucv_callback_connack,
-	ConnectionSevered:  netiucv_callback_connrej,
-	ConnectionQuiesced: netiucv_callback_connsusp,
-	ConnectionResumed:  netiucv_callback_connres,
-	MessagePending:     netiucv_callback_rx,
-	MessageComplete:    netiucv_callback_txdone
+	.ConnectionPending  = netiucv_callback_connreq,
+	.ConnectionComplete = netiucv_callback_connack,
+	.ConnectionSevered  = netiucv_callback_connrej,
+	.ConnectionQuiesced = netiucv_callback_connsusp,
+	.ConnectionResumed  = netiucv_callback_connres,
+	.MessagePending     = netiucv_callback_rx,
+	.MessageComplete    = netiucv_callback_txdone
 };
 
 /**
@@ -1566,24 +1566,24 @@
 }
 
 static struct file_operations netiucv_stat_fops = {
-	read:    netiucv_stat_read,
-	write:   netiucv_stat_write,
-	open:    netiucv_stat_open,
-	release: netiucv_stat_close,
+	.read    = netiucv_stat_read,
+	.write   = netiucv_stat_write,
+	.open    = netiucv_stat_open,
+	.release = netiucv_stat_close,
 };
 
 static struct file_operations netiucv_buffer_fops = {
-	read:    netiucv_buffer_read,
-	write:   netiucv_buffer_write,
-	open:    netiucv_buffer_open,
-	release: netiucv_buffer_close,
+	.read    = netiucv_buffer_read,
+	.write   = netiucv_buffer_write,
+	.open    = netiucv_buffer_open,
+	.release = netiucv_buffer_close,
 };
 
 static struct file_operations netiucv_user_fops = {
-	read:    netiucv_user_read,
-	write:   netiucv_user_write,
-	open:    netiucv_user_open,
-	release: netiucv_user_close,
+	.read    = netiucv_user_read,
+	.write   = netiucv_user_write,
+	.open    = netiucv_user_open,
+	.release = netiucv_user_close,
 };
 
 static struct proc_dir_entry *netiucv_dir = NULL;
diff -urN linux-2.5.27/include/asm-s390/debug.h linux-2.5.27-s390/include/asm-s390/debug.h
--- linux-2.5.27/include/asm-s390/debug.h	Sat Jul 20 21:11:03 2002
+++ linux-2.5.27-s390/include/asm-s390/debug.h	Mon Jul 22 18:30:51 2002
@@ -160,7 +160,8 @@
 }
 
 extern debug_entry_t *
-debug_sprintf_event(debug_info_t* id,int level,char *string,...);
+debug_sprintf_event(debug_info_t* id,int level,char *string,...)
+	__attribute__ ((format(printf, 3, 4)));
 
 
 extern inline debug_entry_t* 
@@ -195,7 +196,8 @@
 
 
 extern debug_entry_t *
-debug_sprintf_exception(debug_info_t* id,int level,char *string,...);
+debug_sprintf_exception(debug_info_t* id,int level,char *string,...)
+	__attribute__ ((format(printf, 3, 4)));
 
 int debug_register_view(debug_info_t* id, struct debug_view* view);
 int debug_unregister_view(debug_info_t* id, struct debug_view* view);
diff -urN linux-2.5.27/include/asm-s390/param.h linux-2.5.27-s390/include/asm-s390/param.h
--- linux-2.5.27/include/asm-s390/param.h	Sat Jul 20 21:11:07 2002
+++ linux-2.5.27-s390/include/asm-s390/param.h	Mon Jul 22 18:30:51 2002
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
diff -urN linux-2.5.27/include/asm-s390/pgalloc.h linux-2.5.27-s390/include/asm-s390/pgalloc.h
--- linux-2.5.27/include/asm-s390/pgalloc.h	Sat Jul 20 21:11:25 2002
+++ linux-2.5.27-s390/include/asm-s390/pgalloc.h	Mon Jul 22 18:30:51 2002
@@ -16,6 +16,8 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
 
 #define check_pgt_cache()	do {} while (0)
 
diff -urN linux-2.5.27/include/asm-s390/smp.h linux-2.5.27-s390/include/asm-s390/smp.h
--- linux-2.5.27/include/asm-s390/smp.h	Sat Jul 20 21:11:19 2002
+++ linux-2.5.27-s390/include/asm-s390/smp.h	Mon Jul 22 18:30:51 2002
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
diff -urN linux-2.5.27/include/asm-s390/tlbflush.h linux-2.5.27-s390/include/asm-s390/tlbflush.h
--- linux-2.5.27/include/asm-s390/tlbflush.h	Sat Jul 20 21:12:26 2002
+++ linux-2.5.27-s390/include/asm-s390/tlbflush.h	Mon Jul 22 18:30:51 2002
@@ -91,8 +91,7 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if ((smp_num_cpus > 1) &&
-	    ((atomic_read(&mm->mm_count) != 1) ||
+	if (((atomic_read(&mm->mm_count) != 1) ||
 	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
 		mm->cpu_vm_mask = (1UL << smp_processor_id());
 		global_flush_tlb();
diff -urN linux-2.5.27/include/asm-s390/unistd.h linux-2.5.27-s390/include/asm-s390/unistd.h
--- linux-2.5.27/include/asm-s390/unistd.h	Sat Jul 20 21:12:31 2002
+++ linux-2.5.27-s390/include/asm-s390/unistd.h	Mon Jul 22 18:32:07 2002
@@ -231,6 +231,7 @@
 #define __NR_futex		238
 #define __NR_sched_setaffinity	239
 #define __NR_sched_getaffinity	240
+#define __NR_security		241	/* syscall for security modules */
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
diff -urN linux-2.5.27/include/asm-s390x/bitops.h linux-2.5.27-s390/include/asm-s390x/bitops.h
--- linux-2.5.27/include/asm-s390x/bitops.h	Sat Jul 20 21:12:22 2002
+++ linux-2.5.27-s390/include/asm-s390x/bitops.h	Mon Jul 22 18:30:51 2002
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
diff -urN linux-2.5.27/include/asm-s390x/debug.h linux-2.5.27-s390/include/asm-s390x/debug.h
--- linux-2.5.27/include/asm-s390x/debug.h	Sat Jul 20 21:11:22 2002
+++ linux-2.5.27-s390/include/asm-s390x/debug.h	Mon Jul 22 18:30:51 2002
@@ -160,7 +160,8 @@
 }
 
 extern debug_entry_t *
-debug_sprintf_event(debug_info_t* id,int level,char *string,...);
+debug_sprintf_event(debug_info_t* id,int level,char *string,...)
+	__attribute__ ((format(printf, 3, 4)));
 
 
 extern inline debug_entry_t* 
@@ -195,7 +196,8 @@
 
 
 extern debug_entry_t *
-debug_sprintf_exception(debug_info_t* id,int level,char *string,...);
+debug_sprintf_exception(debug_info_t* id,int level,char *string,...)
+	__attribute__ ((format(printf, 3, 4)));
 
 int debug_register_view(debug_info_t* id, struct debug_view* view);
 int debug_unregister_view(debug_info_t* id, struct debug_view* view);
diff -urN linux-2.5.27/include/asm-s390x/param.h linux-2.5.27-s390/include/asm-s390x/param.h
--- linux-2.5.27/include/asm-s390x/param.h	Sat Jul 20 21:11:03 2002
+++ linux-2.5.27-s390/include/asm-s390x/param.h	Mon Jul 22 18:30:51 2002
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
diff -urN linux-2.5.27/include/asm-s390x/pgalloc.h linux-2.5.27-s390/include/asm-s390x/pgalloc.h
--- linux-2.5.27/include/asm-s390x/pgalloc.h	Sat Jul 20 21:11:08 2002
+++ linux-2.5.27-s390/include/asm-s390x/pgalloc.h	Mon Jul 22 18:30:51 2002
@@ -16,6 +16,8 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
 
 #define check_pgt_cache()	do { } while (0)
 
diff -urN linux-2.5.27/include/asm-s390x/smp.h linux-2.5.27-s390/include/asm-s390x/smp.h
--- linux-2.5.27/include/asm-s390x/smp.h	Sat Jul 20 21:11:18 2002
+++ linux-2.5.27-s390/include/asm-s390x/smp.h	Mon Jul 22 18:30:51 2002
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
diff -urN linux-2.5.27/include/asm-s390x/system.h linux-2.5.27-s390/include/asm-s390x/system.h
--- linux-2.5.27/include/asm-s390x/system.h	Sat Jul 20 21:12:22 2002
+++ linux-2.5.27-s390/include/asm-s390x/system.h	Mon Jul 22 18:30:51 2002
@@ -23,7 +23,7 @@
 #define prepare_arch_switch(rq)			do { } while (0)
 #define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
 
-#define switch_to(prev,next),last do {					     \
+#define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
diff -urN linux-2.5.27/include/asm-s390x/tlbflush.h linux-2.5.27-s390/include/asm-s390x/tlbflush.h
--- linux-2.5.27/include/asm-s390x/tlbflush.h	Sat Jul 20 21:11:28 2002
+++ linux-2.5.27-s390/include/asm-s390x/tlbflush.h	Mon Jul 22 18:30:51 2002
@@ -88,8 +88,7 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if ((smp_num_cpus > 1) &&
-	    ((atomic_read(&mm->mm_count) != 1) ||
+	if (((atomic_read(&mm->mm_count) != 1) ||
 	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
 		mm->cpu_vm_mask = (1UL << smp_processor_id());
 		global_flush_tlb();
diff -urN linux-2.5.27/include/asm-s390x/unistd.h linux-2.5.27-s390/include/asm-s390x/unistd.h
--- linux-2.5.27/include/asm-s390x/unistd.h	Sat Jul 20 21:11:09 2002
+++ linux-2.5.27-s390/include/asm-s390x/unistd.h	Mon Jul 22 18:32:14 2002
@@ -198,6 +198,7 @@
 #define __NR_futex		238
 #define __NR_sched_setaffinity	239
 #define __NR_sched_getaffinity	240
+#define __NR_security		241	/* syscall for security modules */
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */

