Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261730AbSIXRaA>; Tue, 24 Sep 2002 13:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261729AbSIXR3l>; Tue, 24 Sep 2002 13:29:41 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:46798 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261730AbSIXRWp> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 15_beauty.
Date: Tue, 24 Sep 2002 19:21:47 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241921.47112.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bogus sanity checks and code cleanup.

diff -urN linux-2.5.38/arch/s390/kernel/process.c linux-2.5.38-s390/arch/s390/kernel/process.c
--- linux-2.5.38/arch/s390/kernel/process.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/arch/s390/kernel/process.c	Tue Sep 24 18:52:35 2002
@@ -302,15 +302,15 @@
 	dump->magic = CMAGIC;
 	dump->start_code = 0;
 	dump->start_stack = regs->gprs[15] & ~(PAGE_SIZE - 1);
-	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
-	dump->u_dsize = ((unsigned long) (current->mm->brk + (PAGE_SIZE-1))) >> PAGE_SHIFT;
+	dump->u_tsize = current->mm->end_code >> PAGE_SHIFT;
+	dump->u_dsize = (current->mm->brk + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	dump->u_dsize -= dump->u_tsize;
 	dump->u_ssize = 0;
 	if (dump->start_stack < TASK_SIZE)
-		dump->u_ssize = ((unsigned long) (TASK_SIZE - dump->start_stack)) >> PAGE_SHIFT;
-	memcpy(&dump->regs.gprs[0],regs,sizeof(s390_regs));
+		dump->u_ssize = (TASK_SIZE - dump->start_stack) >> PAGE_SHIFT;
+	memcpy(&dump->regs, regs, sizeof(s390_regs));
 	dump_fpu (regs, &dump->regs.fp_regs);
-	memcpy(&dump->regs.per_info,&current->thread.per_info,sizeof(per_struct));
+	dump->regs.per_info = current->thread.per_info;
 }
 
 /*
diff -urN linux-2.5.38/arch/s390/kernel/setup.c linux-2.5.38-s390/arch/s390/kernel/setup.c
--- linux-2.5.38/arch/s390/kernel/setup.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/arch/s390/kernel/setup.c	Tue Sep 24 18:52:35 2002
@@ -526,7 +526,10 @@
 			       (loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
-		cpuinfo = &safe_get_cpu_lowcore(n)->cpu_data;
+		if (smp_processor_id() == n)
+			cpuinfo = &S390_lowcore.cpu_data;
+		else
+			cpuinfo = &lowcore_ptr[n]->cpu_data;
 		seq_printf(m, "processor %li: "
 			       "version = %02X,  "
 			       "identification = %06X,  "
diff -urN linux-2.5.38/arch/s390/kernel/smp.c linux-2.5.38-s390/arch/s390/kernel/smp.c
--- linux-2.5.38/arch/s390/kernel/smp.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/arch/s390/kernel/smp.c	Tue Sep 24 18:52:35 2002
@@ -173,7 +173,7 @@
         for (i =  0; i < NR_CPUS; i++) {
                 if (!cpu_online(i) || smp_processor_id() == i)
 			continue;
-		low_core_addr = (unsigned long)get_cpu_lowcore(i);
+		low_core_addr = (unsigned long) lowcore_ptr[i];
 		do {
 			rc = signal_processor_ps(&dummy, low_core_addr, i,
 						 sigp_store_status_at_address);
@@ -188,7 +188,7 @@
 void smp_send_stop(void)
 {
         /* write magic number to zero page (absolute 0) */
-        get_cpu_lowcore(smp_processor_id())->panic_magic = __PANIC_MAGIC;
+	lowcore_ptr[smp_processor_id()]->panic_magic = __PANIC_MAGIC;
 
 	/* stop other processors. */
 	do_send_stop();
@@ -296,7 +296,7 @@
  */
 static sigp_ccode smp_ext_bitcall(int cpu, ec_bit_sig sig)
 {
-        struct _lowcore *lowcore = get_cpu_lowcore(cpu);
+        struct _lowcore *lowcore = lowcore_ptr[cpu];
         sigp_ccode ccode;
 
         /*
@@ -319,7 +319,7 @@
         for (i = 0; i < NR_CPUS; i++) {
                 if (!cpu_online(i) || smp_processor_id() == i)
                         continue;
-                lowcore = get_cpu_lowcore(i);
+                lowcore = lowcore_ptr[i];
                 /*
                  * Set signaling bit in lowcore of target cpu and kick it
                  */
@@ -519,7 +519,7 @@
 
         unhash_process(idle);
 
-        cpu_lowcore = get_cpu_lowcore(cpu);
+        cpu_lowcore = lowcore_ptr[cpu];
 	cpu_lowcore->save_area[15] = idle->thread.ksp;
 	cpu_lowcore->kernel_stack = (__u32) idle->thread_info + (2*PAGE_SIZE);
         __asm__ __volatile__("la    1,%0\n\t"
@@ -555,7 +555,7 @@
         /*
          *  Initialize prefix pages and stacks for all possible cpus
          */
-        print_cpu_info(&safe_get_cpu_lowcore(0)->cpu_data);
+	print_cpu_info(&S390_lowcore.cpu_data);
 
         for(i = 0; i < NR_CPUS; i++) {
 		if (!cpu_possible(i))
diff -urN linux-2.5.38/arch/s390/mm/fault.c linux-2.5.38-s390/arch/s390/mm/fault.c
--- linux-2.5.38/arch/s390/mm/fault.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/arch/s390/mm/fault.c	Tue Sep 24 18:52:35 2002
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
diff -urN linux-2.5.38/arch/s390x/kernel/process.c linux-2.5.38-s390/arch/s390x/kernel/process.c
--- linux-2.5.38/arch/s390x/kernel/process.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/arch/s390x/kernel/process.c	Tue Sep 24 18:52:35 2002
@@ -292,15 +292,15 @@
 	dump->magic = CMAGIC;
 	dump->start_code = 0;
 	dump->start_stack = regs->gprs[15] & ~(PAGE_SIZE - 1);
-	dump->u_tsize = ((unsigned long) current->mm->end_code) >> PAGE_SHIFT;
-	dump->u_dsize = ((unsigned long) (current->mm->brk + (PAGE_SIZE-1))) >> PAGE_SHIFT;
+	dump->u_tsize = current->mm->end_code >> PAGE_SHIFT;
+	dump->u_dsize = (current->mm->brk + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	dump->u_dsize -= dump->u_tsize;
 	dump->u_ssize = 0;
 	if (dump->start_stack < TASK_SIZE)
-		dump->u_ssize = ((unsigned long) (TASK_SIZE - dump->start_stack)) >> PAGE_SHIFT;
-	memcpy(&dump->regs.gprs[0],regs,sizeof(s390_regs));
+		dump->u_ssize = (TASK_SIZE - dump->start_stack) >> PAGE_SHIFT;
+	memcpy(&dump->regs, regs, sizeof(s390_regs));
 	dump_fpu (regs, &dump->regs.fp_regs);
-	memcpy(&dump->regs.per_info,&current->thread.per_info,sizeof(per_struct));
+	dump->regs.per_info = current->thread.per_info;
 }
 
 /*
diff -urN linux-2.5.38/arch/s390x/kernel/setup.c linux-2.5.38-s390/arch/s390x/kernel/setup.c
--- linux-2.5.38/arch/s390x/kernel/setup.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/arch/s390x/kernel/setup.c	Tue Sep 24 18:52:35 2002
@@ -516,7 +516,10 @@
 				(loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
-		cpuinfo = &safe_get_cpu_lowcore(n)->cpu_data;
+		if (smp_processor_id() == n)
+			cpuinfo = &S390_lowcore.cpu_data;
+		else
+			cpuinfo = &lowcore_ptr[n]->cpu_data;
 		seq_printf(m, "processor %li: "
 				"version = %02X,  "
 				"identification = %06X,  "
diff -urN linux-2.5.38/arch/s390x/kernel/smp.c linux-2.5.38-s390/arch/s390x/kernel/smp.c
--- linux-2.5.38/arch/s390x/kernel/smp.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/arch/s390x/kernel/smp.c	Tue Sep 24 18:52:35 2002
@@ -172,7 +172,7 @@
         for (i =  0; i < NR_CPUS; i++) {
                 if (!cpu_online(i) || smp_processor_id() == i) 
 			continue;
-		low_core_addr = (unsigned long)get_cpu_lowcore(i);
+		low_core_addr = (unsigned long) lowcore_ptr[i];
 		do {
 			rc = signal_processor_ps(&dummy, low_core_addr, i,
 						 sigp_store_status_at_address);
@@ -187,7 +187,7 @@
 void smp_send_stop(void)
 {
 	/* write magic number to zero page (absolute 0) */
-	get_cpu_lowcore(smp_processor_id())->panic_magic = __PANIC_MAGIC;
+	lowcore_ptr[smp_processor_id()]->panic_magic = __PANIC_MAGIC;
 
 	/* stop other processors. */
 	do_send_stop();
@@ -298,7 +298,7 @@
         /*
          * Set signaling bit in lowcore of target cpu and kick it
          */
-	set_bit(sig, &(get_cpu_lowcore(cpu)->ext_call_fast));
+	set_bit(sig, &lowcore_ptr[cpu]->ext_call_fast);
         ccode = signal_processor(cpu, sigp_external_call);
         return ccode;
 }
@@ -317,7 +317,7 @@
                 /*
                  * Set signaling bit in lowcore of target cpu and kick it
                  */
-		set_bit(sig, &(get_cpu_lowcore(i)->ext_call_fast));
+		set_bit(sig, &lowcore_ptr[i]->ext_call_fast);
                 while (signal_processor(i, sigp_external_call) == sigp_busy)
 			udelay(10);
         }
@@ -499,7 +499,7 @@
 
         unhash_process(idle);
 
-        cpu_lowcore = get_cpu_lowcore(cpu);
+        cpu_lowcore = lowcore_ptr[cpu];
 	cpu_lowcore->save_area[15] = idle->thread.ksp;
 	cpu_lowcore->kernel_stack = (__u64) idle->thread_info + (4*PAGE_SIZE);
         __asm__ __volatile__("la    1,%0\n\t"
@@ -535,7 +535,7 @@
         /*
          *  Initialize prefix pages and stacks for all possible cpus
          */
-        print_cpu_info(&safe_get_cpu_lowcore(0)->cpu_data);
+        print_cpu_info(&S390_lowcore.cpu_data);
 
         for(i = 0; i < NR_CPUS; i++) {
 		if (!cpu_possible(i))
diff -urN linux-2.5.38/arch/s390x/mm/fault.c linux-2.5.38-s390/arch/s390x/mm/fault.c
--- linux-2.5.38/arch/s390x/mm/fault.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/arch/s390x/mm/fault.c	Tue Sep 24 18:52:35 2002
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
diff -urN linux-2.5.38/drivers/s390/char/hwc_rw.c linux-2.5.38-s390/drivers/s390/char/hwc_rw.c
--- linux-2.5.38/drivers/s390/char/hwc_rw.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/drivers/s390/char/hwc_rw.c	Tue Sep 24 18:52:35 2002
@@ -2215,8 +2215,6 @@
 void 
 hwc_interrupt_handler (struct pt_regs *regs, __u16 code)
 {
-	int cpu = smp_processor_id ();
-
 	u32 ext_int_param = hwc_ext_int_param ();
 
 	irq_enter ();
diff -urN linux-2.5.38/drivers/s390/cio/airq.c linux-2.5.38-s390/drivers/s390/cio/airq.c
--- linux-2.5.38/drivers/s390/cio/airq.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/drivers/s390/cio/airq.c	Tue Sep 24 18:52:35 2002
@@ -3,7 +3,7 @@
  *   S/390 common I/O routines -- special interrupt registration
  *   currently used only by qdio
  *
- *   $Revision: 1.2 $
+ *   $Revision: 1.3 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -60,7 +60,7 @@
 	sprintf (dbf_txt, "ret:%d", ret);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
-	return (ret);
+	return ret;
 }
 
 int
@@ -85,7 +85,7 @@
 	sprintf (dbf_txt, "ret:%d", ret);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
-	return (ret);
+	return ret;
 }
 
 void
diff -urN linux-2.5.38/drivers/s390/cio/blacklist.c linux-2.5.38-s390/drivers/s390/cio/blacklist.c
--- linux-2.5.38/drivers/s390/cio/blacklist.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/drivers/s390/cio/blacklist.c	Tue Sep 24 18:52:35 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.5 $
+ *   $Revision: 1.7 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -134,7 +134,7 @@
 int
 is_blacklisted (int devno)
 {
-	return (test_bit (devno, &bl_dev));
+	return test_bit (devno, &bl_dev);
 }
 
 #ifdef CONFIG_PROC_FS
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
diff -urN linux-2.5.38/drivers/s390/cio/cio.c linux-2.5.38-s390/drivers/s390/cio/cio.c
--- linux-2.5.38/drivers/s390/cio/cio.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/drivers/s390/cio/cio.c	Tue Sep 24 18:52:35 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.15 $
+ *   $Revision: 1.25 $
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
 
 
@@ -433,8 +433,6 @@
 	int ret = 0;
 	char dbf_txt[15];
 
-	SANITY_CHECK (irq);
-
 	/*
 	 * The flag usage is mutal exclusive ...
 	 */
@@ -456,7 +454,7 @@
 		ret = enable_cpu_sync_isc (irq);
 
 		if (ret) 
-			return (ret);
+			return ret;
 
 	}
 
@@ -556,7 +554,7 @@
 	if (flag & DOIO_DONT_CALL_INTHDLR) 
 		ioinfo[irq]->ui.flags.repnone = 0;
 
-	return (ret);
+	return ret;
 }
 
 int
@@ -618,7 +616,7 @@
 
 	}
 
-	return (ret);
+	return ret;
 
 }
 
@@ -677,7 +675,7 @@
 
 	}
 
-	return (ret);
+	return ret;
 }
 
 /*
@@ -720,7 +718,7 @@
 		ret = enable_cpu_sync_isc (irq);
 
 		if (ret)
-			return (ret);
+			return ret;
 	}
 
 	/*
@@ -784,7 +782,7 @@
 	if (flag & DOIO_WAIT_FOR_INTERRUPT) 
 		disable_cpu_sync_isc (irq);
 
-	return (ret);
+	return ret;
 }
 
 /*
@@ -803,7 +801,7 @@
 	SANITY_CHECK (irq);
 
 	if (ioinfo[irq] == INVALID_STORAGE_AREA)
-		return (-ENODEV);
+		return -ENODEV;
 
 	/*
 	 * we only allow for clear_IO if the device has an I/O handler associated
@@ -829,7 +827,7 @@
 		ret = enable_cpu_sync_isc (irq);
 
 		if (ret)
-			return (ret);
+			return ret;
 	}
 
 	/*
@@ -891,7 +889,7 @@
 	if (flag & DOIO_WAIT_FOR_INTERRUPT) 
 		disable_cpu_sync_isc (irq);
 
-	return (ret);
+	return ret;
 }
 
 /*
@@ -908,8 +906,6 @@
 	char dbf_txt[15];
 	int ret = 0;
 
-	SANITY_CHECK (irq);
-
 	sprintf (dbf_txt, "cancelIO%x", irq);
 	CIO_TRACE_EVENT (2, dbf_txt);
 
@@ -955,7 +951,6 @@
 	 * Get interrupt info from lowcore
 	 */
 	volatile tpi_info_t *tpi_info = (tpi_info_t *) (__LC_SUBCHANNEL_ID);
-	int cpu = smp_processor_id ();
 
 	/*
 	 * take fast exit if CPU is in sync. I/O state
@@ -1183,7 +1178,7 @@
 	 * take fast exit if no handler is available
 	 */
 	if (!ioinfo[irq]->ui.flags.ready)
-		return (ending_status);
+		return ending_status;
 	
 	/*
 	 * Check whether we must issue a SENSE CCW ourselves if there is no
@@ -1485,7 +1480,8 @@
 		s390_irq_count[cpu]++;
 	}
 
-	sprintf (dbf_txt, "procIRQ%x", irq);
+	CIO_TRACE_EVENT (3, "procIRQ");
+	sprintf (dbf_txt, "%x", irq);
 	CIO_TRACE_EVENT (3, dbf_txt);
 
 	if (ioinfo[irq] == INVALID_STORAGE_AREA) {
@@ -1497,14 +1493,8 @@
 			  "for non-initialized subchannel!\n", irq);
 
 		tsch (irq, &p_init_irb);
-		return (1);
-
-	}
-
-	if (ioinfo[irq]->st) {
-		/* can't be */
-		BUG();
 		return 1;
+
 	}
 
 	dp = &ioinfo[irq]->devstat;
@@ -1715,8 +1705,6 @@
 	int rc = 0;
 	char dbf_txt[15];
 
-	SANITY_CHECK (irq);
-
 	if (cons_dev != -1)
 		return -EBUSY;
 
@@ -1750,7 +1738,7 @@
 		}
 	}
 
-	return (rc);
+	return rc;
 }
 
 int
@@ -1801,7 +1789,7 @@
 
 	}
 
-	return (rc);
+	return rc;
 }
 
 /*
diff -urN linux-2.5.38/drivers/s390/cio/cio_debug.h linux-2.5.38-s390/drivers/s390/cio/cio_debug.h
--- linux-2.5.38/drivers/s390/cio/cio_debug.h	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/drivers/s390/cio/cio_debug.h	Tue Sep 24 18:52:35 2002
@@ -3,9 +3,9 @@
 
 #define SANITY_CHECK(irq) do { \
 if (irq > highest_subchannel || irq < 0) \
-		return (-ENODEV); \
+		return -ENODEV; \
 	if (ioinfo[irq] == INVALID_STORAGE_AREA) \
-		return (-ENODEV); \
+		return -ENODEV; \
         if (ioinfo[irq]->st) \
                 return -ENODEV; \
 	} while(0)
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
 
diff -urN linux-2.5.38/drivers/s390/cio/ioinfo.c linux-2.5.38-s390/drivers/s390/cio/ioinfo.c
--- linux-2.5.38/drivers/s390/cio/ioinfo.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/drivers/s390/cio/ioinfo.c	Tue Sep 24 18:52:35 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/ioinfo.c
  *   S/390 common I/O routines -- the ioinfo structure
- *   $Revision: 1.3 $
+ *   $Revision: 1.4 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -102,12 +102,12 @@
 int
 get_dev_info_by_irq (int irq, s390_dev_info_t * pdi)
 {
-	if (irq > highest_subchannel || irq < 0) \
-		return (-ENODEV); \
-	if (ioinfo[irq] == INVALID_STORAGE_AREA) \
-		return (-ENODEV); \
-        if (ioinfo[irq]->st) \
-                return -ENODEV; \
+	if (irq > highest_subchannel || irq < 0) 
+		return -ENODEV; 
+	if (ioinfo[irq] == INVALID_STORAGE_AREA) 
+		return -ENODEV; 
+        if (ioinfo[irq]->st) 
+                return -ENODEV; 
 
 	if (pdi == NULL)
 		return -EINVAL;
@@ -189,7 +189,7 @@
 		}
 	}
 
-	return (rc);
+	return rc;
 
 }
 
@@ -211,7 +211,7 @@
 		}
 	}
 
-	return (rc);
+	return rc;
 }
 
 unsigned int
@@ -235,7 +235,7 @@
 	 *  defined who's device number isn't valid ...
 	 */
 	if (ioinfo[irq]->schib.pmcw.dnv)
-		return (ioinfo[irq]->schib.pmcw.dev);
+		return ioinfo[irq]->schib.pmcw.dev;
 	else
 		return -1;
 }
@@ -258,9 +258,9 @@
 s390_set_private_data(int irq, void *data)
 {
 	if (irq > highest_subchannel || irq < 0)
-		return (-ENODEV);
+		return -ENODEV;
 	if (ioinfo[irq] == INVALID_STORAGE_AREA)
-		return (-ENODEV);
+		return -ENODEV;
         if (ioinfo[irq]->st)
                 return -ENODEV;
 	ioinfo[irq]->private_data = data;
diff -urN linux-2.5.38/drivers/s390/cio/requestirq.c linux-2.5.38-s390/drivers/s390/cio/requestirq.c
--- linux-2.5.38/drivers/s390/cio/requestirq.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/drivers/s390/cio/requestirq.c	Tue Sep 24 18:52:35 2002
@@ -253,8 +253,6 @@
 	int retry = 5;
 	char dbf_txt[15];
 
-	SANITY_CHECK (irq);
-
 	sprintf (dbf_txt, "ensch%x", irq);
 	CIO_TRACE_EVENT (2, dbf_txt);
 
@@ -324,7 +322,7 @@
 	sprintf (dbf_txt, "ret:%d", ret);
 	CIO_TRACE_EVENT (2, dbf_txt);
 
-	return (ret);
+	return ret;
 }
 
 /*
@@ -338,8 +336,6 @@
 	int retry = 5;
 	char dbf_txt[15];
 
-	SANITY_CHECK (irq);
-
 	sprintf (dbf_txt, "dissch%x", irq);
 	CIO_TRACE_EVENT (2, dbf_txt);
 
@@ -427,7 +423,7 @@
 	sprintf (dbf_txt, "ret:%d", ret);
 	CIO_TRACE_EVENT (2, dbf_txt);
 
-	return (ret);
+	return ret;
 }
 
 /* FIXME: there must be a cleaner way to express what happens */
diff -urN linux-2.5.38/drivers/s390/cio/s390io.c linux-2.5.38-s390/drivers/s390/cio/s390io.c
--- linux-2.5.38/drivers/s390/cio/s390io.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/drivers/s390/cio/s390io.c	Tue Sep 24 18:52:35 2002
@@ -565,17 +565,13 @@
 
 	char dbf_txt[15];
 
-	if (!buffer || !length) {
-		return (-EINVAL);
-
-	}
+	if (!buffer || !length) 
+		return -EINVAL;
 
 	SANITY_CHECK (irq);
 
-	if (ioinfo[irq]->ui.flags.oper == 0) {
-		return (-ENODEV);
-
-	}
+	if (ioinfo[irq]->ui.flags.oper == 0) 
+		return -ENODEV;
 
 	sprintf (dbf_txt, "rddevch%x", irq);
 	CIO_TRACE_EVENT (4, dbf_txt);
@@ -687,11 +683,11 @@
 	SANITY_CHECK (irq);
 
 	if (!buffer || !length) {
-		return (-EINVAL);
+		return -EINVAL;
 	} else if (ioinfo[irq]->ui.flags.oper == 0) {
-		return (-ENODEV);
+		return -ENODEV;
 	} else if (ioinfo[irq]->ui.flags.esid == 0) {
-		return (-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 
 	}
 
@@ -857,7 +853,7 @@
 
 	}
 
-	return (ret);
+	return ret;
 
 }
 
@@ -1299,7 +1295,7 @@
 
 	}
 
-	return (ret);
+	return ret;
 }
 
 /*
@@ -1336,10 +1332,8 @@
 	int i;
 	int failure = 0;	/* nothing went wrong yet */
 
-	SANITY_CHECK (irq);
-
 	if (ioinfo[irq]->ui.flags.oper == 0) {
-		return (-ENODEV);
+		return -ENODEV;
 
 	}
 
@@ -1939,10 +1933,8 @@
 	int inlreq = 0;		/* inline request_irq() */
 	int mpath = 1;		/* try multi-path first */
 
-	SANITY_CHECK (irq);
-
 	if (ioinfo[irq]->ui.flags.oper == 0) {
-		return (-ENODEV);
+		return -ENODEV;
 
 	}
 
@@ -2150,7 +2142,7 @@
 	if (inlreq)
 		free_irq (irq, pdevstat);
 
-	return (irq_ret);
+	return irq_ret;
 }
 
 /*
@@ -2172,10 +2164,8 @@
 	int inlreq = 0;		/* inline request_irq() */
 	unsigned long flags;
 
-	SANITY_CHECK (irq);
-
 	if (ioinfo[irq]->ui.flags.oper == 0) {
-		return (-ENODEV);
+		return -ENODEV;
 
 	}
 
@@ -2339,7 +2329,7 @@
 	if (inlreq)
 		free_irq (irq, pdevstat);
 
-	return (irq_ret);
+	return irq_ret;
 }
 
 /*
@@ -2360,8 +2350,6 @@
  	int irq_ret = 0;
  	int inlreq = 0;
 	
- 	SANITY_CHECK(irq);
-	
  	if (!ioinfo[irq]->ui.flags.oper)
  		/* no sense in trying */
  		return -ENODEV;
diff -urN linux-2.5.38/drivers/s390/s390mach.c linux-2.5.38-s390/drivers/s390/s390mach.c
--- linux-2.5.38/drivers/s390/s390mach.c	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/drivers/s390/s390mach.c	Tue Sep 24 18:52:35 2002
@@ -314,7 +314,7 @@
 
 	} while (1);
 
-	return (0);
+	return 0;
 }
 
 /*
@@ -557,7 +557,7 @@
 
 	} while (ccode == 0);
 
-	return (count);
+	return count;
 }
 
 #ifdef CONFIG_MACHCHK_WARNING
@@ -587,6 +587,6 @@
 
 	DBG(KERN_DEBUG "post_warning : 1 warning machine check posted\n");
 
-	return (1);
+	return 1;
 }
 #endif
diff -urN linux-2.5.38/include/asm-s390/debug.h linux-2.5.38-s390/include/asm-s390/debug.h
--- linux-2.5.38/include/asm-s390/debug.h	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/include/asm-s390/debug.h	Tue Sep 24 18:52:35 2002
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
diff -urN linux-2.5.38/include/asm-s390/lowcore.h linux-2.5.38-s390/include/asm-s390/lowcore.h
--- linux-2.5.38/include/asm-s390/lowcore.h	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/include/asm-s390/lowcore.h	Tue Sep 24 18:52:35 2002
@@ -176,25 +176,16 @@
 	__u8         pad12[0x1000-0xe04];      /* 0xe04 */
 } __attribute__((packed)); /* End structure*/
 
+#define S390_lowcore (*((struct _lowcore *) 0))
+extern struct _lowcore *lowcore_ptr[];
+
 extern __inline__ void set_prefix(__u32 address)
 {
         __asm__ __volatile__ ("spx %0" : : "m" (address) : "memory" );
 }
 
-#define S390_lowcore (*((struct _lowcore *) 0))
-extern struct _lowcore *lowcore_ptr[];
-
-#ifndef CONFIG_SMP
-#define get_cpu_lowcore(cpu)      (&S390_lowcore)
-#define safe_get_cpu_lowcore(cpu) (&S390_lowcore)
-#else
-#define get_cpu_lowcore(cpu)      (lowcore_ptr[(cpu)])
-#define safe_get_cpu_lowcore(cpu) \
-        ((cpu) == smp_processor_id() ? &S390_lowcore : lowcore_ptr[(cpu)])
-#endif
-#endif /* __ASSEMBLY__ */
-
 #define __PANIC_MAGIC           0xDEADC0DE
 
 #endif
 
+#endif
diff -urN linux-2.5.38/include/asm-s390/system.h linux-2.5.38-s390/include/asm-s390/system.h
--- linux-2.5.38/include/asm-s390/system.h	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/include/asm-s390/system.h	Tue Sep 24 18:52:35 2002
@@ -184,18 +184,18 @@
 #define local_irq_enable() ({ \
         __u8 __dummy; \
         __asm__ __volatile__ ( \
-                "stosm 0(%0),0x03" : : "a" (&__dummy) : "memory"); \
+                "stosm 0(%1),0x03" : "=m" (__dummy) : "a" (&__dummy) ); \
         })
 
 #define local_irq_disable() ({ \
         __u32 __flags; \
         __asm__ __volatile__ ( \
-                "stnsm 0(%0),0xFC" : : "a" (&__flags) : "memory"); \
+                "stnsm 0(%1),0xFC" : "=m" (__flags) : "a" (&__flags) ); \
         __flags; \
         })
 
 #define local_save_flags(x) \
-        __asm__ __volatile__("stosm 0(%0),0" : : "a" (&x) : "memory")
+        __asm__ __volatile__("stosm 0(%1),0" : "=m" (x) : "a" (&x) )
 
 #define local_irq_restore(x) \
         __asm__ __volatile__("ssm   0(%0)" : : "a" (&x) : "memory")
diff -urN linux-2.5.38/include/asm-s390x/debug.h linux-2.5.38-s390/include/asm-s390x/debug.h
--- linux-2.5.38/include/asm-s390x/debug.h	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/include/asm-s390x/debug.h	Tue Sep 24 18:52:35 2002
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
diff -urN linux-2.5.38/include/asm-s390x/lowcore.h linux-2.5.38-s390/include/asm-s390x/lowcore.h
--- linux-2.5.38/include/asm-s390x/lowcore.h	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/include/asm-s390x/lowcore.h	Tue Sep 24 18:52:35 2002
@@ -194,25 +194,17 @@
 	__u8         pad17[0x2000-0x1400];      /* 0x1400 */
 } __attribute__((packed)); /* End structure*/
 
+#define S390_lowcore (*((struct _lowcore *) 0))
+extern struct _lowcore *lowcore_ptr[];
+
 extern __inline__ void set_prefix(__u32 address)
 {
         __asm__ __volatile__ ("spx %0" : : "m" (address) : "memory" );
 }
 
-#define S390_lowcore (*((struct _lowcore *) 0))
-extern struct _lowcore *lowcore_ptr[];
+#define __PANIC_MAGIC           0xDEADC0DE
 
-#ifndef CONFIG_SMP
-#define get_cpu_lowcore(cpu)      (&S390_lowcore)
-#define safe_get_cpu_lowcore(cpu) (&S390_lowcore)
-#else
-#define get_cpu_lowcore(cpu)      (lowcore_ptr[(cpu)])
-#define safe_get_cpu_lowcore(cpu) \
-        ((cpu) == smp_processor_id() ? &S390_lowcore : lowcore_ptr[(cpu)])
 #endif
-#endif /* __ASSEMBLY__ */
-
-#define __PANIC_MAGIC           0xDEADC0DE
 
 #endif
 
diff -urN linux-2.5.38/include/asm-s390x/system.h linux-2.5.38-s390/include/asm-s390x/system.h
--- linux-2.5.38/include/asm-s390x/system.h	Tue Sep 24 18:51:42 2002
+++ linux-2.5.38-s390/include/asm-s390x/system.h	Tue Sep 24 18:52:35 2002
@@ -202,21 +202,21 @@
 #define local_irq_enable() ({ \
         unsigned long __dummy; \
         __asm__ __volatile__ ( \
-                "stosm 0(%0),0x03" : : "a" (&__dummy) : "memory"); \
+                "stosm 0(%1),0x03" : "=m" (__dummy) : "a" (&__dummy) ); \
         })
 
 #define local_irq_disable() ({ \
         unsigned long __flags; \
         __asm__ __volatile__ ( \
-                "stnsm 0(%0),0xFC" : : "a" (&__flags) : "memory"); \
+                "stnsm 0(%1),0xfc" : "=m" (__flags) : "a" (&__flags) ); \
         __flags; \
         })
 
 #define local_save_flags(x) \
-        __asm__ __volatile__("stosm 0(%0),0" : : "a" (&x) : "memory")
+        __asm__ __volatile__("stosm 0(%1),0" : "=m" (x) : "a" (&x) )
 
 #define local_irq_restore(x) \
-        __asm__ __volatile__("ssm   0(%0)" : : "a" (&x) : "memory")
+        __asm__ __volatile__("ssm   0(%0)" : : "a" (&x) )
 
 #define irqs_disabled()			\
 ({					\

