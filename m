Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbSIXRgu>; Tue, 24 Sep 2002 13:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbSIXRg3>; Tue, 24 Sep 2002 13:36:29 -0400
Received: from d12lmsgate-4.de.ibm.com ([195.212.91.196]:19853 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261737AbSIXRWs> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:48 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 22_boot.
Date: Tue, 24 Sep 2002 19:24:00 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241924.00075.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rework boot sequence on s390:

Traditionally, device detection os s390 is done completely
at a _very_ early stage during bootup (from init_irq(),
i.e. before memory management or the console are there).

This has always been a bad idea, but now it broke even more
since the linux driver model requires devices detection
to take place after the core_initcalls are done.

We now do only a small amount of scanning (probably
less in the future) at the early stage, the bulk of it
is done from a proper subsys_initcall(). This requires
some changes in related areas:

- the machine check handler initialization is split in
  two halves, since we want to catch major machine malfunctions
  as early as possible, but device machine checks can only
  be caught after the channel subsystem is up.

- some functions that are called from the css initialization
  made some assumptions of when to use kmalloc or bootmem_alloc,
  which were broken anyway. We fix this here and hopefully
  can get rid of bootmem_alloc for the css completely in the future.

- the debug logging feature for s390 was not used for functions
  in the initialization before, since it requires the memory
  management to be working. Now that we can be sure that it
  works, some special cases can be removed.

Now that these changes are done, a partial implementation of the
device model for the channel subsystem is possible, but at this
point, none of the device drivers make use of that yet.

diff -urN linux-2.5.38/arch/s390/kernel/debug.c linux-2.5.38-s390/arch/s390/kernel/debug.c
--- linux-2.5.38/arch/s390/kernel/debug.c	Sun Sep 22 06:25:01 2002
+++ linux-2.5.38-s390/arch/s390/kernel/debug.c	Tue Sep 24 17:53:20 2002
@@ -21,6 +21,7 @@
 #include <asm/semaphore.h>
 
 #include <linux/module.h>
+#include <linux/init.h>
 
 #include <asm/debug.h>
 
@@ -146,7 +147,7 @@
 static debug_info_t *debug_area_last = NULL;
 DECLARE_MUTEX(debug_lock);
 
-static int initialized = 0;
+static int initialized;
 
 static struct file_operations debug_file_ops = {
 	read:    debug_output,
@@ -591,7 +592,7 @@
 
 	MOD_INC_USE_COUNT;
 	if (!initialized)
-		debug_init();
+		BUG();
 	down(&debug_lock);
 
         /* create new debug_info */
@@ -828,18 +829,16 @@
  * - is called exactly once to initialize the debug feature
  */
 
-int debug_init(void)
+static int __init debug_init(void)
 {
 	int rc = 0;
 
 	down(&debug_lock);
-	if (!initialized) {
 #ifdef CONFIG_PROC_FS
-		debug_proc_root_entry = proc_mkdir(DEBUG_DIR_ROOT, NULL);
+	debug_proc_root_entry = proc_mkdir(DEBUG_DIR_ROOT, NULL);
 #endif /* CONFIG_PROC_FS */
-		printk(KERN_INFO "debug: Initialization complete\n");
-		initialized = 1;
-	}
+	printk(KERN_INFO "debug: Initialization complete\n");
+	initialized = 1;
 	up(&debug_lock);
 
 	return rc;
@@ -1173,27 +1172,9 @@
 }
 
 /*
- * init_module:
- */
-
-#ifdef MODULE
-int init_module(void)
-{
-	int rc = 0;
-#ifdef DEBUG
-	printk("debug_module_init: \n");
-#endif
-	rc = debug_init();
-	if (rc) 
-		printk(KERN_INFO "debug: an error occurred with debug_init\n");
-	return rc;
-}
-
-/*
- * cleanup_module:
+ * clean up module
  */
-
-void cleanup_module(void)
+void __exit debug_exit(void)
 {
 #ifdef DEBUG
 	printk("debug_cleanup_module: \n");
@@ -1204,7 +1185,12 @@
 	return;
 }
 
-#endif			/* MODULE */
+/*
+ * module definitions
+ */
+core_initcall(debug_init);
+module_exit(debug_exit);
+MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(debug_register);
 EXPORT_SYMBOL(debug_unregister); 
diff -urN linux-2.5.38/arch/s390/kernel/setup.c linux-2.5.38-s390/arch/s390/kernel/setup.c
--- linux-2.5.38/arch/s390/kernel/setup.c	Tue Sep 24 17:43:30 2002
+++ linux-2.5.38-s390/arch/s390/kernel/setup.c	Tue Sep 24 17:53:20 2002
@@ -78,7 +78,7 @@
 /*
  * cpu_init() initializes state that is per-CPU.
  */
-void __init cpu_init (void)
+void __devinit cpu_init (void)
 {
         int nr = smp_processor_id();
         int addr = hard_smp_processor_id();
diff -urN linux-2.5.38/arch/s390/kernel/smp.c linux-2.5.38-s390/arch/s390/kernel/smp.c
--- linux-2.5.38/arch/s390/kernel/smp.c	Tue Sep 24 17:43:15 2002
+++ linux-2.5.38-s390/arch/s390/kernel/smp.c	Tue Sep 24 17:53:20 2002
@@ -454,7 +454,7 @@
 extern int pfault_init(void);
 extern int pfault_token(void);
 
-int __init start_secondary(void *cpuvoid)
+int __devinit start_secondary(void *cpuvoid)
 {
         /* Setup the cpu */
         cpu_init();
@@ -474,7 +474,7 @@
         return cpu_idle(NULL);
 }
 
-static struct task_struct *__init fork_by_hand(void)
+static struct task_struct *__devinit fork_by_hand(void)
 {
        struct pt_regs regs;
        /* don't care about the psw and regs settings since we'll never
diff -urN linux-2.5.38/arch/s390x/kernel/debug.c linux-2.5.38-s390/arch/s390x/kernel/debug.c
--- linux-2.5.38/arch/s390x/kernel/debug.c	Sun Sep 22 06:25:01 2002
+++ linux-2.5.38-s390/arch/s390x/kernel/debug.c	Tue Sep 24 17:53:20 2002
@@ -21,6 +21,7 @@
 #include <asm/semaphore.h>
 
 #include <linux/module.h>
+#include <linux/init.h>
 
 #include <asm/debug.h>
 
@@ -146,7 +147,7 @@
 static debug_info_t *debug_area_last = NULL;
 DECLARE_MUTEX(debug_lock);
 
-static int initialized = 0;
+static int initialized;
 
 static struct file_operations debug_file_ops = {
 	read:    debug_output,
@@ -591,7 +592,7 @@
 
 	MOD_INC_USE_COUNT;
 	if (!initialized)
-		debug_init();
+		BUG();
 	down(&debug_lock);
 
         /* create new debug_info */
@@ -828,18 +829,16 @@
  * - is called exactly once to initialize the debug feature
  */
 
-int debug_init(void)
+static int __init debug_init(void)
 {
 	int rc = 0;
 
 	down(&debug_lock);
-	if (!initialized) {
 #ifdef CONFIG_PROC_FS
-		debug_proc_root_entry = proc_mkdir(DEBUG_DIR_ROOT, NULL);
+	debug_proc_root_entry = proc_mkdir(DEBUG_DIR_ROOT, NULL);
 #endif /* CONFIG_PROC_FS */
-		printk(KERN_INFO "debug: Initialization complete\n");
-		initialized = 1;
-	}
+	printk(KERN_INFO "debug: Initialization complete\n");
+	initialized = 1;
 	up(&debug_lock);
 
 	return rc;
@@ -1173,27 +1172,9 @@
 }
 
 /*
- * init_module:
- */
-
-#ifdef MODULE
-int init_module(void)
-{
-	int rc = 0;
-#ifdef DEBUG
-	printk("debug_module_init: \n");
-#endif
-	rc = debug_init();
-	if (rc) 
-		printk(KERN_INFO "debug: an error occurred with debug_init\n");
-	return rc;
-}
-
-/*
- * cleanup_module:
+ * clean up module
  */
-
-void cleanup_module(void)
+void __exit debug_exit(void)
 {
 #ifdef DEBUG
 	printk("debug_cleanup_module: \n");
@@ -1204,7 +1185,12 @@
 	return;
 }
 
-#endif			/* MODULE */
+/*
+ * module definitions
+ */
+core_initcall(debug_init);
+module_exit(debug_exit);
+MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(debug_register);
 EXPORT_SYMBOL(debug_unregister); 
diff -urN linux-2.5.38/arch/s390x/kernel/setup.c linux-2.5.38-s390/arch/s390x/kernel/setup.c
--- linux-2.5.38/arch/s390x/kernel/setup.c	Tue Sep 24 17:43:30 2002
+++ linux-2.5.38-s390/arch/s390x/kernel/setup.c	Tue Sep 24 17:53:20 2002
@@ -78,7 +78,7 @@
 /*
  * cpu_init() initializes state that is per-CPU.
  */
-void __init cpu_init (void)
+void __devinit cpu_init (void)
 {
         int nr = smp_processor_id();
         int addr = hard_smp_processor_id();
diff -urN linux-2.5.38/arch/s390x/kernel/smp.c linux-2.5.38-s390/arch/s390x/kernel/smp.c
--- linux-2.5.38/arch/s390x/kernel/smp.c	Tue Sep 24 17:43:15 2002
+++ linux-2.5.38-s390/arch/s390x/kernel/smp.c	Tue Sep 24 17:53:20 2002
@@ -435,7 +435,7 @@
 extern void init_cpu_timer(void);
 extern int pfault_init(void);
 
-int __init start_secondary(void *cpuvoid)
+int __devinit start_secondary(void *cpuvoid)
 {
         /* Setup the cpu */
         cpu_init();
@@ -455,7 +455,7 @@
         return cpu_idle(NULL);
 }
 
-static struct task_struct * __init fork_by_hand(void)
+static struct task_struct * __devinit fork_by_hand(void)
 {
        struct pt_regs regs;
        /* don't care about the psw and regs settings since we'll never
diff -urN linux-2.5.38/drivers/s390/Makefile linux-2.5.38-s390/drivers/s390/Makefile
--- linux-2.5.38/drivers/s390/Makefile	Tue Sep 24 17:42:03 2002
+++ linux-2.5.38-s390/drivers/s390/Makefile	Tue Sep 24 17:53:20 2002
@@ -7,8 +7,9 @@
 obj-$(CONFIG_QDIO) += qdio.o
 
 obj-y += s390mach.o s390dyn.o sysinfo.o
-obj-y += block/ char/ misc/ net/ cio/
+obj-y += cio/ block/ char/ misc/ net/
 
 drivers-y += drivers/s390/built-in.o
 
 include $(TOPDIR)/Rules.make
+
diff -urN linux-2.5.38/drivers/s390/char/con3215.c linux-2.5.38-s390/drivers/s390/char/con3215.c
--- linux-2.5.38/drivers/s390/char/con3215.c	Tue Sep 24 17:42:22 2002
+++ linux-2.5.38-s390/drivers/s390/char/con3215.c	Tue Sep 24 17:53:20 2002
@@ -693,13 +693,12 @@
 
 	if (raw->flags & RAW3215_ACTIVE)
 		return 0;
-	if (request_irq(raw->irq, raw3215_irq, SA_INTERRUPT,
-			"3215 terminal driver", &raw->devstat) != 0)
+	if (s390_request_console_irq(raw->irq, raw3215_irq, SA_INTERRUPT,
+				"3215 terminal driver", &raw->devstat) != 0)
 		return -1;
 	raw->line_pos = 0;
 	raw->flags |= RAW3215_ACTIVE;
 	s390irq_spin_lock_irqsave(raw->irq, flags);
-        set_cons_dev(raw->irq);
 	raw3215_try_io(raw);
 	s390irq_spin_unlock_irqrestore(raw->irq, flags);
 
@@ -1064,7 +1063,6 @@
 	/* Check if 3215 is to be the console */
 	if (!CONSOLE_IS_3215)
 		return;
-	irq = raw3215_find_dev(0);
 
 	/* Set the console mode for VM */
 	if (MACHINE_IS_VM) {
@@ -1072,6 +1070,22 @@
 		cpcmd("TERM AUTOCR OFF", NULL, 0);
 	}
 
+	if (console_device != -1) {
+		/* use the device number that was specified on the
+		 * command line */
+		irq = raw3215_find_dev(0);
+	} else if (MACHINE_IS_VM) {
+		/* under VM, the console is at device number 0009
+		 * by default, so try that */
+		irq = get_irq_by_devno(0x0009);
+	} else {
+		/* unlike in 2.4, we cannot autoprobe here, since
+		 * the channel subsystem is not fully initialized.
+		 * With some luck, the HWC console can take over */
+		printk(KERN_WARNING "3215 console not found\n");
+		return;
+	}
+
 	/* allocate 3215 request structures */
 	raw3215_freelist = NULL;
 	spin_lock_init(&raw3215_freelist_lock);
diff -urN linux-2.5.38/drivers/s390/cio/cio_debug.c linux-2.5.38-s390/drivers/s390/cio/cio_debug.c
--- linux-2.5.38/drivers/s390/cio/cio_debug.c	Sun Sep 22 06:25:06 2002
+++ linux-2.5.38-s390/drivers/s390/cio/cio_debug.c	Tue Sep 24 17:53:20 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio_debug.c
  *   S/390 common I/O routines -- message ids for debugging
- *   $Revision: 1.4 $
+ *   $Revision: 1.5 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -69,4 +69,4 @@
 	return ret;
 }
 
-__initcall (cio_debug_init);
+arch_initcall (cio_debug_init);
diff -urN linux-2.5.38/drivers/s390/cio/requestirq.c linux-2.5.38-s390/drivers/s390/cio/requestirq.c
--- linux-2.5.38/drivers/s390/cio/requestirq.c	Tue Sep 24 17:43:15 2002
+++ linux-2.5.38-s390/drivers/s390/cio/requestirq.c	Tue Sep 24 17:53:20 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/requestirq.c
  *   S/390 common I/O routines -- 
- *   $Revision: 1.7 $
+ *   $Revision: 1.12 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -122,6 +122,34 @@
 					 NULL, irqflags, devname, dev_id);
 }
 
+int
+s390_request_console_irq (int irq,
+			  void (*handler) (int, void *, struct pt_regs *),
+			  unsigned long irqflags,
+			  const char *devname,
+			  void *dev_id)
+{
+	int ret;
+	unsigned long flags;
+
+	s390_device_recognition_irq (irq);
+
+	ret = s390_request_irq_special (irq, (io_handler_func_t) handler,
+					NULL, irqflags, devname, dev_id);
+
+	if (ret)
+		goto out;
+
+	s390irq_spin_lock_irqsave(irq, flags);
+	ret = set_cons_dev(irq);
+	s390irq_spin_unlock_irqrestore(irq, flags);
+
+	if (ret)
+		free_irq(irq, dev_id);
+out:
+	return ret;
+}
+
 /*
  * request_irq wrapper
  */
@@ -151,7 +179,7 @@
 
 	s390irq_spin_lock_irqsave (irq, flags);
 
-	CIO_DEBUG_NOCONS(irq,KERN_DEBUG, printk, 2, 
+	CIO_DEBUG_NOCONS(irq,KERN_DEBUG, DBG, 2, 
 			 "Trying to free IRQ %d\n", 
 			 irq);
 
diff -urN linux-2.5.38/drivers/s390/cio/s390io.c linux-2.5.38-s390/drivers/s390/cio/s390io.c
--- linux-2.5.38/drivers/s390/cio/s390io.c	Tue Sep 24 17:53:20 2002
+++ linux-2.5.38-s390/drivers/s390/cio/s390io.c	Tue Sep 24 17:53:20 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/s390io.c
  *   S/390 common I/O routines
- *   $Revision: 1.11 $
+ *   $Revision: 1.33 $
  *
  *  S390 version
  *    Copyright (C) 1999, 2000 IBM Deutschland Entwicklung GmbH,
@@ -75,9 +75,8 @@
 static __u64 irq_IPL_TOD; // FIXME: can be on stack
 
 static void s390_process_subchannels (void);
-static void s390_device_recognition_all (void);
 static int s390_SenseID (int irq, senseid_t * sid, __u8 lpm);
-static int s390_SetPGID (int irq, __u8 lpm, pgid_t * pgid);
+static int s390_SetPGID (int irq, __u8 lpm);
 static int s390_SensePGID (int irq, __u8 lpm, pgid_t * pgid);
 
 /* FIXME: intermixed with proc.c */
@@ -86,7 +85,6 @@
 
 int cio_show_msg;
 static int cio_notoper_msg = 1;
-static int cio_sid_with_pgid;     /* if we need a PGID for SenseID, switch this on */
 
 static int __init
 cio_setup (char *parm)
@@ -125,25 +123,6 @@
 
 __setup ("cio_notoper_msg=", cio_notoper_setup);
 
-static int __init
-cio_pgid_setup (char *parm)
-{
-	if (!strcmp (parm, "yes")) {
-		cio_sid_with_pgid = 1;
-	} else if (!strcmp (parm, "no")) {
-		cio_sid_with_pgid = 0;
-	} else {
-		printk (KERN_ERR 
-			"cio_pgid_setup : invalid cio_msg parameter '%s'",
-			parm);
-
-	}
-
-	return 1;
-}
-
-__setup ("cio_sid_with_pgid=", cio_pgid_setup);
-
 /* This function is replacing the init_IRQ function in
  * arch/s390(x)/kernel/irq.c and is called early during
  * bootup. Anything called from here must be careful 
@@ -199,8 +178,6 @@
 	cr6 = 0x10000000;
 	__ctl_load (cr6, 6, 6);
 
-	s390_device_recognition_all ();
-
 	init_IRQ_complete = 1;
 
 	local_irq_restore (flags);
@@ -226,6 +203,51 @@
 	/* this is a dummy handler only ... */
 }
 
+/* 
+ * diag210 is used under VM to get information about a virtual device
+ */
+#ifdef CONFIG_ARCH_S390X
+int diag210(diag210_t * addr)
+{
+	/*
+	 * diag 210 needs its data below the 2GB border, so we
+	 * use a static data area to be sure
+	 */
+	static diag210_t diag210_tmp;
+	static spinlock_t diag210_lock = SPIN_LOCK_UNLOCKED;
+	unsigned long flags;
+	int ccode;
+
+	spin_lock_irqsave(&diag210_lock, flags);
+	diag210_tmp = *addr;
+
+	asm volatile (
+		"   sam31\n"
+		"   diag  %1,0,0x210\n"
+		"   sam64\n"
+		"   ipm   %0\n"
+		"   srl   %0,28"
+		: "=d" (ccode) : "a" (__pa(&diag210_tmp)) : "cc", "memory" );
+	
+	*addr = diag210_tmp;
+	spin_unlock_irqrestore(&diag210_lock, flags);
+
+	return ccode;
+}
+#else
+int diag210(diag210_t * addr)
+{
+	int ccode;
+
+	asm volatile (
+		"   diag  %1,0,0x210\n"
+		"   ipm   %0\n"
+		"   srl   %0,28"
+		: "=d" (ccode) : "a" (__pa(addr)) : "cc", "memory" );
+
+	return ccode;
+}
+#endif
 
 /*
  * Input :
@@ -234,31 +256,28 @@
  * Output : none
  */
 static inline void
-_VM_virtual_device_info (__u16 devno, senseid_t * ps)
+VM_virtual_device_info (__u16 devno, senseid_t * ps)
 {
-	diag210_t *p_diag_data;
+	diag210_t diag_data;
 	int ccode;
 
 	int error = 0;
 
 	CIO_TRACE_EVENT (4, "VMvdinf");
 
-	if (init_IRQ_complete) {
-		p_diag_data = kmalloc (sizeof (diag210_t), GFP_DMA);
-	} else {
-		p_diag_data = alloc_bootmem_low (sizeof (diag210_t));
+	diag_data = (diag210_t) {
+		.vrdcdvno = devno,
+		.vrdclen = sizeof (diag_data),
+	};
 
-	}
-
-	p_diag_data->vrdcdvno = devno;
-	p_diag_data->vrdclen = sizeof (diag210_t);
-	ccode = diag210 ((diag210_t *) virt_to_phys (p_diag_data));
+	ccode = diag210 (&diag_data);
 	ps->reserved = 0xff;
 
-	switch (p_diag_data->vrdcvcla) {
+	/* FIXME: this would be much nicer if it were table driven */
+	switch (diag_data.vrdcvcla) {
 	case 0x80:
 
-		switch (p_diag_data->vrdcvtyp) {
+		switch (diag_data.vrdcvtyp) {
 		case 00:
 
 			ps->cu_type = 0x3215;
@@ -277,7 +296,7 @@
 
 	case 0x40:
 
-		switch (p_diag_data->vrdcvtyp) {
+		switch (diag_data.vrdcvtyp) {
 		case 0xC0:
 
 			ps->cu_type = 0x5080;
@@ -314,7 +333,7 @@
 
 	case 0x20:
 
-		switch (p_diag_data->vrdcvtyp) {
+		switch (diag_data.vrdcvtyp) {
 		case 0x84:
 
 			ps->cu_type = 0x3505;
@@ -345,7 +364,7 @@
 
 	case 0x10:
 
-		switch (p_diag_data->vrdcvtyp) {
+		switch (diag_data.vrdcvtyp) {
 		case 0x84:
 
 			ps->cu_type = 0x3525;
@@ -422,7 +441,7 @@
 
 	case 0x08:
 
-		switch (p_diag_data->vrdcvtyp) {
+		switch (diag_data.vrdcvtyp) {
 		case 0x82:
 
 			ps->cu_type = 0x3422;
@@ -477,7 +496,7 @@
 
 	case 02:		/* special device class ... */
 
-		switch (p_diag_data->vrdcvtyp) {
+		switch (diag_data.vrdcvtyp) {
 		case 0x20:	/* OSA */
 
 			ps->cu_type = 0x3088;
@@ -502,13 +521,6 @@
 
 	}
 
-	if (init_IRQ_complete) {
-		kfree (p_diag_data);
-	} else {
-		free_bootmem ((unsigned long) p_diag_data, sizeof (diag210_t));
-
-	}
-
 	if (error) 
 		CIO_DEBUG_ALWAYS(KERN_ERR, 0,
 				 "DIAG X'210' for "
@@ -519,12 +531,11 @@
 				 "rdev model: %02X\n",
 				 devno,
 				 ccode,
-				 p_diag_data->vrdcvcla,
-				 p_diag_data->vrdcvtyp,
-				 p_diag_data->vrdcrccl,
-				 p_diag_data->vrdccrty,
-				 p_diag_data->vrdccrmd);
-		
+				 diag_data.vrdcvcla,
+				 diag_data.vrdcvtyp,
+				 diag_data.vrdcrccl,
+				 diag_data.vrdccrty,
+				 diag_data.vrdccrmd);
 }
 
 /*
@@ -553,7 +564,7 @@
 int
 read_dev_chars (int irq, void **buffer, int length)
 {
-	unsigned int flags;
+	unsigned long flags;
 	ccw1_t *rdc_ccw;
 	devstat_t devstat;
 	char *rdc_buf;
@@ -661,9 +672,11 @@
 
 		}
 
+	} else {
+		local_irq_restore(flags);
 	}
 
-	return (ret);
+	return ret;
 }
 
 /*
@@ -698,7 +711,7 @@
 	 * scan for RCD command in extended SenseID data
 	 */
 
-	for (ciw_cnt = 0; (found == 0) && (ciw_cnt < 62); ciw_cnt++) {
+	for (ciw_cnt = 0; (found == 0) && (ciw_cnt < MAX_CIWS); ciw_cnt++) {
 		if (ioinfo[irq]->senseid.ciw[ciw_cnt].ct == CIW_TYPE_RCD) {
 			/*
 			 * paranoia check ...
@@ -817,11 +830,10 @@
 				} while (retry);
 
 			}
-
-			local_irq_restore (flags);
-
 		}
 
+		local_irq_restore(flags);
+
 		/*
 		 * on success we update the user input parms
 		 */
@@ -867,8 +879,8 @@
 void
 s390_device_recognition_irq (int irq)
 {
-	int ret;
 	char dbf_txt[15];
+	devstat_t devstat;
 
 	sprintf (dbf_txt, "devrec%x", irq);
 	CIO_TRACE_EVENT (4, dbf_txt);
@@ -877,52 +889,78 @@
 	 * We issue the SenseID command on I/O subchannels we think are
 	 *  operational only.
 	 */
-	if ((ioinfo[irq] != INVALID_STORAGE_AREA)
-	    && (!ioinfo[irq]->st)
-	    && (ioinfo[irq]->schib.pmcw.st == 0)
-	    && (ioinfo[irq]->ui.flags.oper == 1)) {
-		int irq_ret;
-		devstat_t devstat;
+	if ((ioinfo[irq]->st) || (!ioinfo[irq]->ui.flags.oper))
+		goto out;
 
-		irq_ret = request_irq (irq,
-				       init_IRQ_handler,
-				       SA_PROBE, "INIT", &devstat);
+	if (request_irq (irq, init_IRQ_handler, SA_PROBE, "INIT", &devstat))
+		goto out;
 
-		if (!irq_ret) {
-			ret = enable_cpu_sync_isc (irq);
+	if (enable_cpu_sync_isc(irq))
+		goto out_freeirq;
 
-			if (!ret) {
-				ioinfo[irq]->ui.flags.unknown = 0;
+	ioinfo[irq]->ui.flags.unknown = 0;
 
-				memset (&ioinfo[irq]->senseid, '\0',
-					sizeof (senseid_t));
+	memset (&ioinfo[irq]->senseid, '\0', sizeof (senseid_t));
 
-				if (cio_sid_with_pgid) {
-					
-					ret = s390_DevicePathVerification(irq,0);
-					
-					if (ret == -EOPNOTSUPP) 
-						/* 
-						 * Doesn't prevent us from proceeding
-						 */
-						ret = 0;
-				}
+	s390_SenseID (irq, &ioinfo[irq]->senseid, 0xff);
 
-				/*
-				 * we'll fallthrough here if we don't want
-				 * to do SPID before SID
-				 */
-				if (!ret) {
-					s390_SenseID (irq, &ioinfo[irq]->senseid, 0xff);
-				}
-				disable_cpu_sync_isc (irq);
+	disable_cpu_sync_isc(irq);
+out_freeirq:
+	free_irq (irq, &devstat);
+out:
+	return;
+}
 
-			}
+static int
+css_bus_match (struct device *dev, struct device_driver *drv)
+{
+	struct subchannel *ioinfo;
+	struct subchannel_driver *sdrv;
 
-			free_irq (irq, &devstat);
+	ioinfo = list_entry (dev, struct subchannel, dev);
+	sdrv   = list_entry (drv, struct subchannel_driver, drv);
 
-		}
-	}
+	return (ioinfo->st == sdrv->st);
+}
+
+struct bus_type css_bus_type = {
+	.name  = "css",
+	.match = &css_bus_match,
+};
+
+static struct device css_bus_device = {
+	.name   = "Channel Subsystem",
+	.bus_id = "css0",
+};
+
+/*
+ * s390_register_subchannel
+ *
+ * initializes the struct device member of a subchannel and gives it to
+ * the device driver core
+ */
+static __devinit void
+s390_register_subchannel (struct subchannel *ioinfo)
+{
+	static const char *subchannel_types[] = {
+		"I/O Subchannel",
+		"CHSC Subchannel",
+		"Message Subchannel",
+		"ADM Subchannel",
+		"undefined subchannel type 4",
+		"undefined subchannel type 5",
+		"undefined subchannel type 6",
+		"undefined subchannel type 7",
+	};
+
+	strncpy (ioinfo->dev.name, subchannel_types[ioinfo->st], DEVICE_NAME_SIZE);
+	snprintf (ioinfo->dev.bus_id, DEVICE_ID_SIZE, "0:%04x", ioinfo->irq);
+
+	ioinfo->dev.bus    = &css_bus_type;
+	ioinfo->dev.parent = &css_bus_device;
+
+	if (device_register(&ioinfo->dev))
+		printk(KERN_WARNING "failed to register subchannel %04x\n", ioinfo->irq);
 }
 
 /*
@@ -931,19 +969,43 @@
  * Used for system wide device recognition.
  *
  */
-static void __init
-s390_device_recognition_all (void)
+static int __init
+s390_probe_css (void)
 {
-	int irq = 0;		/* let's start with subchannel 0 ... */
+	int ret;
+	int irq;
 
-	do {
-		s390_device_recognition_irq (irq);
+	printk (KERN_INFO "probing %d subchannels...\n", highest_subchannel+1);
+
+	if ((ret = bus_register(&css_bus_type)))
+		goto out;
+
+	if ((ret = device_register(&css_bus_device)))
+		goto out_unregister;
+
+	for (irq = 0; irq <= highest_subchannel; irq++) {
+		if (ioinfo[irq] == INVALID_STORAGE_AREA)
+			continue;
+
+		printk(KERN_INFO "subchannel %04x: devno %04x, ",
+				irq, ioinfo[irq]->devno);
 
-		irq++;
+		if (irq != cons_dev) /* console has already been probed */
+			s390_device_recognition_irq (irq);
 
-	} while (irq <= highest_subchannel);
+		s390_register_subchannel(ioinfo[irq]);
+		printk("control unit type %04x\n", ioinfo[irq]->senseid.cu_type);
+	}
+
+out_unregister:
+	if (ret)
+		put_bus(&css_bus_type);
+out:
+	return ret;
 }
 
+subsys_initcall(s390_probe_css);
+
 /*
  * s390_process_subchannels
  *
@@ -1301,7 +1363,13 @@
 static int
 s390_SenseID (int irq, senseid_t * sid, __u8 lpm)
 {
-	ccw1_t *sense_ccw;	/* ccw area for SenseID command */
+	/* SenseID may be called during console initialization,
+	 * before we have a working kmalloc, using a static
+	 * ccw area is the least evil workaround */
+	static ccw1_t sense_ccw[2];	/* ccw area for SenseID command */
+	static spinlock_t sid_lock	/* lock to protect sense_ccw */
+		= SPIN_LOCK_UNLOCKED;
+
 	senseid_t isid;		/* internal sid */
 	devstat_t devstat;	/* required by request_irq() */
 	__u8 pathmask;		/* calulate path mask */
@@ -1318,6 +1386,7 @@
 	char dbf_txt[15];
 	int i;
 	int failure = 0;	/* nothing went wrong yet */
+	unsigned long flags;
 
 	if (ioinfo[irq]->ui.flags.oper == 0) {
 		return -ENODEV;
@@ -1327,44 +1396,27 @@
 	sprintf (dbf_txt, "snsID%x", irq);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
-	inlreq = 0;		/* to make the compiler quiet... */
-
 	if (!ioinfo[irq]->ui.flags.ready) {
-
-		pdevstat = &devstat;
-
+		inlreq = 1;
 		/*
 		 * Perform SENSE ID command processing. We have to request device
 		 *  ownership and provide a dummy I/O handler. We issue sync. I/O
 		 *  requests and evaluate the devstat area on return therefore
 		 *  we don't need a real I/O handler in place.
 		 */
-		irq_ret =
-		    request_irq (irq, init_IRQ_handler, SA_PROBE, "SID",
-				 &devstat);
+		if ((irq_ret = request_irq (irq, init_IRQ_handler,
+						SA_PROBE, "SID", &devstat)))
+				return irq_ret;
 
-		if (irq_ret == 0)
-			inlreq = 1;
 	} else {
 		inlreq = 0;
-		irq_ret = 0;
-		pdevstat = ioinfo[irq]->irq_desc.dev_id;
-
 	}
 
-	if (irq_ret) {
-		return irq_ret;
-	}
+	pdevstat = ioinfo[irq]->irq_desc.dev_id;
 
+	spin_lock_irqsave(&sid_lock, flags);
 	s390irq_spin_lock (irq);
 
-	if (init_IRQ_complete) {
-		sense_ccw = kmalloc (2 * sizeof (ccw1_t), GFP_DMA);
-	} else {
-		sense_ccw = alloc_bootmem_low (2 * sizeof (ccw1_t));
-
-	}
-
 	/* more than one path installed ? */
 	if (ioinfo[irq]->schib.pmcw.pim != 0x80) {
 		sense_ccw[0].cmd_code = CCW_CMD_SUSPEND_RECONN;
@@ -1584,14 +1636,8 @@
 
 	}
 
-	if (init_IRQ_complete) {
-		kfree (sense_ccw);
-	} else {
-		free_bootmem ((unsigned long) sense_ccw, 2 * sizeof (ccw1_t));
-
-	}
-
 	s390irq_spin_unlock (irq);
+	spin_unlock_irqrestore(&sid_lock, flags);
 
 	/*
 	 * If we installed the irq action handler we have to
@@ -1606,7 +1652,7 @@
 	 */
 	if ((sid->cu_type == 0xFFFF)
 	    && (MACHINE_IS_VM)) {
-		_VM_virtual_device_info (ioinfo[irq]->schib.pmcw.dev, sid);
+		VM_virtual_device_info (ioinfo[irq]->schib.pmcw.dev, sid);
 	}
 
 	if (sid->cu_type == 0xFFFF) {
@@ -1622,43 +1668,18 @@
 			  ioinfo[irq]->schib.pmcw.dev, irq);
 
 		ioinfo[irq]->ui.flags.unknown = 1;
-
+		return -ENODEV;
 	}
 
 	/*
 	 * Issue device info message if unit was operational .
 	 */
-	if (!ioinfo[irq]->ui.flags.unknown) {
-		if (sid->dev_type != 0) {
-
-			CIO_DEBUG_IFMSG(KERN_INFO, 2,
-					"SenseID : device %04X reports: "
-					"CU  Type/Mod = %04X/%02X,"
-					" Dev Type/Mod = %04X/%02X\n",
-					ioinfo[irq]->schib.pmcw.dev,
-					sid->cu_type,
-					sid->cu_model,
-					sid->dev_type,
-					sid->dev_model);
+	CIO_DEBUG_IFMSG(KERN_INFO, 2, "SenseID : device %04X reports: "
+		"CU  Type/Mod = %04X/%02X, Dev Type/Mod = %04X/%02X\n",
+		ioinfo[irq]->schib.pmcw.dev, sid->cu_type, sid->cu_model,
+		sid->dev_type, sid->dev_model);
 
-		} else {
-
-			CIO_DEBUG_IFMSG(KERN_INFO, 2,
-					"SenseID : device %04X reports:"
-					" Dev Type/Mod = %04X/%02X\n",
-					ioinfo[irq]->schib.pmcw.dev,
-					sid->cu_type,
-					sid->cu_model);
-		}
-
-	}
-
-	if (!ioinfo[irq]->ui.flags.unknown)
-		irq_ret = 0;
-	else
-		irq_ret = -ENODEV;
-
-	return (irq_ret);
+	return 0;
 }
 
 /*
@@ -1803,7 +1824,6 @@
 		memcpy (&ioinfo[irq]->pgid, &global_pgid, sizeof (pgid_t));
 		ioinfo[irq]->ui.flags.pgid = 1;
 	}
-	memcpy (&pgid, &ioinfo[irq]->pgid, sizeof (pgid_t));
 
 	for (i = 0; i < 8 && !ret; i++) {
 		pathmask = 0x80 >> i;
@@ -1811,46 +1831,38 @@
 		domask = dev_path & pathmask;
 
 		if (domask) {
-			ret = s390_SetPGID (irq, domask, &pgid);
-
-			/*
-			 * For the *first* path we are prepared
-			 *  for recovery
-			 *
-			 *  - If we fail setting the PGID we assume its
-			 *     using  a different PGID already (VM) we
-			 *     try to sense.
-			 */
-			if (ret == -EOPNOTSUPP && first) {
+			if (MACHINE_IS_VM) {
+				/*
+				 * If we are running under VM, try to obtain
+				 * VM's PGID by SensePGID
+				 */
 				*(int *) &pgid = 0;
-
-				ret = s390_SensePGID (irq, domask, &pgid);
-				first = 0;
-
-				if (ret == 0) {
+				
+				if (!s390_SensePGID (irq, domask, &pgid)) 
 					/*
 					 * Check whether we retrieved
 					 *  a reasonable PGID ...
 					 */
 					if (pgid.inf.ps.state1 ==
-					    SNID_STATE1_GROUPED) {
+					    SNID_STATE1_GROUPED) 
 						memcpy (&ioinfo[irq]->pgid,
 							&pgid, sizeof (pgid_t));
-					} else {	/* ungrouped or garbage ... */
-						ret = -EOPNOTSUPP;
 
-					}
-				} else {
-					ioinfo[irq]->ui.flags.pgid_supp = 0;
+			}
+			
+			ret = s390_SetPGID (irq, domask);
 
-					CIO_DEBUG(KERN_WARNING, 2,
-						  "PathVerification(%04X) "
-						  "- Device %04X doesn't "
-						  " support path grouping\n",
-						  irq,
-						  ioinfo[irq]->schib.pmcw.dev);
-					
-				}
+			if (ret == -EOPNOTSUPP) {
+
+				ioinfo[irq]->ui.flags.pgid_supp = 0;
+				
+				CIO_DEBUG(KERN_WARNING, 2,
+					  "PathVerification(%04X) "
+					  "- Device %04X doesn't "
+					  " support path grouping\n",
+					  irq,
+					  ioinfo[irq]->schib.pmcw.dev);
+				
 			} else if (ret == -EIO) {
 
 				CIO_DEBUG(KERN_ERR, 2,
@@ -1873,12 +1885,19 @@
 
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
@@ -1895,7 +1914,7 @@
  *
  */
 static int
-s390_SetPGID (int irq, __u8 lpm, pgid_t * pgid)
+s390_SetPGID (int irq, __u8 lpm)
 {
 	ccw1_t *spid_ccw;	/* ccw area for SPID command */
 	devstat_t devstat;	/* required by request_irq() */
@@ -1953,11 +1972,11 @@
 	spid_ccw[0].flags = CCW_FLAG_SLI | CCW_FLAG_CC;
 
 	spid_ccw[1].cmd_code = CCW_CMD_SET_PGID;
-	spid_ccw[1].cda = (__u32) virt_to_phys (pgid);
+	spid_ccw[1].cda = (__u32) virt_to_phys (&ioinfo[irq]->pgid);
 	spid_ccw[1].count = sizeof (pgid_t);
 	spid_ccw[1].flags = CCW_FLAG_SLI;
 
-	pgid->inf.fc = SPID_FUNC_MULTI_PATH | SPID_FUNC_ESTABLISH;
+	ioinfo[irq]->pgid.inf.fc = SPID_FUNC_MULTI_PATH | SPID_FUNC_ESTABLISH;
 
 	/*
 	 * We now issue a SetPGID request. In case of BUSY
@@ -2011,13 +2030,13 @@
 						spid_ccw[0].cmd_code =
 						    CCW_CMD_SET_PGID;
 						spid_ccw[0].cda = (__u32)
-						    virt_to_phys (pgid);
+						    virt_to_phys (&ioinfo[irq]->pgid);
 						spid_ccw[0].count =
 						    sizeof (pgid_t);
 						spid_ccw[0].flags =
 						    CCW_FLAG_SLI;
 
-						pgid->inf.fc =
+						ioinfo[irq]->pgid.inf.fc =
 						    SPID_FUNC_SINGLE_PATH
 						    | SPID_FUNC_ESTABLISH;
 						mpath = 0;
@@ -2071,6 +2090,7 @@
 
 				retry = 0;
 				ioinfo[irq]->opm &= ~lpm;
+				switch_off_chpids(irq, lpm);
 				irq_ret = -EAGAIN;
 
 			}
@@ -2133,6 +2153,7 @@
 	devstat_t devstat;	/* required by request_irq() */
 	devstat_t *pdevstat = &devstat;
 	char dbf_txt[15];
+	pgid_t * tmp_pgid;
 
 	int irq_ret = 0;	/* return code */
 	int retry = 5;		/* retry count */
@@ -2174,13 +2195,14 @@
 
 	if (init_IRQ_complete) {
 		snid_ccw = kmalloc (sizeof (ccw1_t), GFP_DMA);
+		tmp_pgid = kmalloc (sizeof (pgid_t), GFP_DMA);
 	} else {
 		snid_ccw = alloc_bootmem_low (sizeof (ccw1_t));
-
+		tmp_pgid = alloc_bootmem_low (sizeof (pgid_t));
 	}
 
 	snid_ccw->cmd_code = CCW_CMD_SENSE_PGID;
-	snid_ccw->cda = (__u32) virt_to_phys (pgid);
+	snid_ccw->cda = (__u32) virt_to_phys (tmp_pgid);
 	snid_ccw->count = sizeof (pgid_t);
 	snid_ccw->flags = CCW_FLAG_SLI;
 
@@ -2256,6 +2278,7 @@
 			} else {
 				retry = 0;	/* success ... */
 				irq_ret = 0;
+				memcpy(pgid, tmp_pgid, sizeof(pgid_t));
 
 			}
 		} else if (irq_ret != -ENODEV) {	/* -EIO, or -EBUSY */
@@ -2290,9 +2313,10 @@
 
 	if (init_IRQ_complete) {
 		kfree (snid_ccw);
+		kfree (tmp_pgid);
 	} else {
 		free_bootmem ((unsigned long) snid_ccw, sizeof (ccw1_t));
-
+		free_bootmem ((unsigned long) tmp_pgid, sizeof (tmp_pgid));
 	}
 
 	s390irq_spin_unlock_irqrestore (irq, flags);
@@ -2311,13 +2335,11 @@
  * Function: s390_send_nop
  * 
  * sends a nop CCW to the specified subchannel down the given path(s)
- * FIXME: why not put nop_ccw on the stack, it's only 64 bits?
  */
 int
 s390_send_nop(int irq, __u8 lpm)
 {
  	char dbf_txt[15];
- 	ccw1_t *nop_ccw;
  	devstat_t devstat;
  	devstat_t *pdevstat = &devstat;
  	unsigned long flags;
@@ -2325,6 +2347,14 @@
  	int irq_ret = 0;
  	int inlreq = 0;
 	
+	/* static allocation is necessary because nop_ccw has to be below
+	 * the 2GB border. locking is not required since it nop_ccw is
+	 * never modified */
+	static ccw1_t nop_ccw = {
+		.cmd_code  = CCW_CMD_NOOP,
+		.flags	   = CCW_FLAG_SLI,
+	};
+
  	if (!ioinfo[irq]->ui.flags.oper)
  		/* no sense in trying */
  		return -ENODEV;
@@ -2352,19 +2382,9 @@
  
  	s390irq_spin_lock_irqsave (irq, flags);
  
- 	if (init_IRQ_complete)
- 		nop_ccw = kmalloc (sizeof (ccw1_t), GFP_DMA);
- 	else
- 		nop_ccw = alloc_bootmem_low (sizeof (ccw1_t));
- 
- 	nop_ccw->cmd_code = CCW_CMD_NOOP;
- 	nop_ccw->cda = 0;
- 	nop_ccw->count = 0;
- 	nop_ccw->flags = CCW_FLAG_SLI;
- 
  	memset (pdevstat, '\0', sizeof (devstat_t));
  	
- 	irq_ret = s390_start_IO (irq, nop_ccw, 0xE2D5D6D7, lpm,
+ 	irq_ret = s390_start_IO (irq, &nop_ccw, 0xE2D5D6D7, lpm,
  				 DOIO_WAIT_FOR_INTERRUPT
  				 | DOIO_TIMEOUT
  				 | DOIO_DONT_CALL_INTHDLR
@@ -2376,11 +2396,6 @@
  		cancel_IO(irq);
  	}
  
- 	if (init_IRQ_complete) 
- 		kfree (nop_ccw);
- 	else
- 		free_bootmem ((unsigned long) nop_ccw, sizeof (ccw1_t));
- 
  	s390irq_spin_unlock_irqrestore (irq, flags);
  
  	if (inlreq)
diff -urN linux-2.5.38/drivers/s390/s390mach.c linux-2.5.38-s390/drivers/s390/s390mach.c
--- linux-2.5.38/drivers/s390/s390mach.c	Tue Sep 24 17:43:15 2002
+++ linux-2.5.38-s390/drivers/s390/s390mach.c	Tue Sep 24 17:53:20 2002
@@ -11,6 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/completion.h>
 #ifdef CONFIG_SMP
 #include <linux/smp.h>
 #endif
@@ -51,6 +52,7 @@
 static spinlock_t crw_queue_lock = SPIN_LOCK_UNLOCKED;
 
 static struct semaphore s_sem;
+static DECLARE_COMPLETION(mchchk_thread_active);
 
 #ifdef CONFIG_MACHCHK_WARNING
 static int mchchk_wng_posted = 0;
@@ -103,14 +105,15 @@
 	kernel_thread(s390_machine_check_handler, &s_sem,
 		      CLONE_FS | CLONE_FILES);
 
+	wait_for_completion(&mchchk_thread_active);
+
 	ctl_clear_bit(14, 25);	/* disable damage MCH */
 
 	ctl_set_bit(14, 26);	/* enable degradation MCH */
 	ctl_set_bit(14, 27);	/* enable system recovery MCH */
 
-	ctl_set_bit(14, 28);	/* enable channel report MCH */
 
-#ifdef CONFIG_MACHCK_WARNING
+#ifdef CONFIG_MACHCHK_WARNING
 	ctl_set_bit(14, 24);	/* enable warning MCH */
 #endif
 
@@ -127,6 +130,30 @@
 	return;
 }
 
+/*
+ * initialize the machine check handler really early to be able to
+ * catch all machine checks that happen during boot
+ */
+static int __init
+machine_check_init (void)
+{
+	s390_init_machine_check();
+	return 0;
+}
+arch_initcall(machine_check_init);
+
+/*
+ * Machine checks for the channel subsystem must be enabled
+ * after the channel subsystem is initialized
+ */
+static int __init
+machine_check_crw_init (void)
+{
+	ctl_set_bit(14, 28);	/* enable channel report MCH */
+	return 0;
+}
+device_initcall (machine_check_crw_init);
+
 static void
 s390_handle_damage(char *msg)
 {
@@ -244,6 +271,8 @@
 
 	DBG(KERN_NOTICE "mach_handler : ready\n");
 
+	complete(&mchchk_thread_active);
+
 	do {
 
 		DBG(KERN_NOTICE "mach_handler : waiting for wakeup\n");
diff -urN linux-2.5.38/include/asm-s390/irq.h linux-2.5.38-s390/include/asm-s390/irq.h
--- linux-2.5.38/include/asm-s390/irq.h	Tue Sep 24 17:41:38 2002
+++ linux-2.5.38-s390/include/asm-s390/irq.h	Tue Sep 24 17:53:20 2002
@@ -637,6 +637,12 @@
                               const char              *devname,
                               void                    *dev_id);
 
+extern int s390_request_console_irq (int irq,
+			  void (*handler) (int, void *, struct pt_regs *),
+			  unsigned long irqflags,
+			  const char *devname,
+			  void *dev_id);
+
 extern int set_cons_dev(int irq);
 extern int wait_cons_dev(int irq);
 extern schib_t *s390_get_schib( int irq );
@@ -860,28 +866,8 @@
      __u32 vrdccrft : 8;    /* real device feature (output) */
      } __attribute__ ((packed,aligned(4))) diag210_t;
 
-void VM_virtual_device_info( __u16      devno,   /* device number */
-                             senseid_t *ps );    /* ptr to senseID data */
-
-extern __inline__ int diag210( diag210_t * addr)
-{
-        int ccode;
+extern int diag210( diag210_t * addr);
 
-        __asm__ __volatile__(
-#ifdef CONFIG_ARCH_S390X
-                "   sam31\n"
-                "   diag  %1,0,0x210\n"
-                "   sam64\n"
-#else
-                "   diag  %1,0,0x210\n"
-#endif
-                "   ipm   %0\n"
-                "   srl   %0,28"
-                : "=d" (ccode) 
-		: "a" (addr)
-                : "cc" );
-        return ccode;
-}
 extern __inline__ int chsc( chsc_area_t * chsc_area)
 {
 	int cc;
diff -urN linux-2.5.38/include/asm-s390/s390io.h linux-2.5.38-s390/include/asm-s390/s390io.h
--- linux-2.5.38/include/asm-s390/s390io.h	Sun Sep 22 06:25:16 2002
+++ linux-2.5.38-s390/include/asm-s390/s390io.h	Tue Sep 24 17:53:20 2002
@@ -9,22 +9,25 @@
 #ifndef __s390io_h
 #define __s390io_h
 
+#include <linux/device.h>
+
 /*
  * IRQ data structure used by I/O subroutines
  *
  * Note : If bit flags are added, the "unused" value must be
  *        decremented accordingly !
  */
-typedef struct _ioinfo {
+typedef struct subchannel {
      unsigned int  irq;           /* aka. subchannel number */
      spinlock_t    irq_lock;      /* irq lock */
-     void          *private_data; /* pointer to private data */
-
-     struct _ioinfo *prev;
-     struct _ioinfo *next;
 
      __u8          st;            /* subchannel type */
 
+     void          *private_data; /* pointer to private data */
+
+     struct subchannel *prev;
+     struct subchannel *next;
+
      union {
         unsigned int info;
         struct {
@@ -78,8 +81,26 @@
      unsigned long qflag;         /* queued flags */
      __u8          qlpm;          /* queued logical path mask */
      ssd_info_t    ssd_info;      /* subchannel description */
+     struct device dev;		  /* entry in device tree */
+} __attribute__ ((aligned(8))) ioinfo_t;
+
 
-   } __attribute__ ((aligned(8))) ioinfo_t;
+/*
+ * There are four different subchannel types, but we are currently
+ * only interested in I/O subchannels. This means there is only
+ * one subchannel_driver, other subchannels belonging to css_bus_type
+ * are simply ignored.
+ */
+struct subchannel_driver {
+	enum {
+		SUBCHANNEL_TYPE_IO      = 0,
+		SUBCHANNEL_TYPE_CHSC    = 1,
+		SUBCHANNEL_TYPE_MESSAGE = 2,
+		SUBCHANNEL_TYPE_ADM     = 3,
+	} st;			  /* subchannel type */
+	struct device_driver drv; /* entry in driver tree */
+};
+extern struct bus_type css_bus_type;
 
 #define IOINFO_FLAGS_BUSY    0x80000000
 #define IOINFO_FLAGS_OPER    0x40000000
diff -urN linux-2.5.38/include/asm-s390x/irq.h linux-2.5.38-s390/include/asm-s390x/irq.h
--- linux-2.5.38/include/asm-s390x/irq.h	Tue Sep 24 17:41:38 2002
+++ linux-2.5.38-s390/include/asm-s390x/irq.h	Tue Sep 24 17:53:20 2002
@@ -637,6 +637,12 @@
                               const char              *devname,
                               void                    *dev_id);
 
+extern int s390_request_console_irq (int irq,
+			  void (*handler) (int, void *, struct pt_regs *),
+			  unsigned long irqflags,
+			  const char *devname,
+			  void *dev_id);
+
 extern int set_cons_dev(int irq);
 extern int wait_cons_dev(int irq);
 extern schib_t *s390_get_schib( int irq );
@@ -860,28 +866,8 @@
      __u32 vrdccrft : 8;    /* real device feature (output) */
      } __attribute__ ((packed,aligned(4))) diag210_t;
 
-void VM_virtual_device_info( __u16      devno,   /* device number */
-                             senseid_t *ps );    /* ptr to senseID data */
-
-extern __inline__ int diag210( diag210_t * addr)
-{
-        int ccode;
+extern int diag210( diag210_t * addr);
 
-        __asm__ __volatile__(
-#ifdef CONFIG_ARCH_S390X
-                "   sam31\n"
-                "   diag  %1,0,0x210\n"
-                "   sam64\n"
-#else
-                "   diag  %1,0,0x210\n"
-#endif
-                "   ipm   %0\n"
-                "   srl   %0,28"
-                : "=d" (ccode) 
-		: "a" (addr)
-                : "cc" );
-        return ccode;
-}
 extern __inline__ int chsc( chsc_area_t * chsc_area)
 {
 	int cc;
diff -urN linux-2.5.38/include/asm-s390x/s390io.h linux-2.5.38-s390/include/asm-s390x/s390io.h
--- linux-2.5.38/include/asm-s390x/s390io.h	Sun Sep 22 06:25:36 2002
+++ linux-2.5.38-s390/include/asm-s390x/s390io.h	Tue Sep 24 17:53:20 2002
@@ -9,21 +9,24 @@
 #ifndef __s390io_h
 #define __s390io_h
 
+#include <linux/device.h>
+
 /*
  * IRQ data structure used by I/O subroutines
  *
  * Note : If bit flags are added, the "unused" value must be
  *        decremented accordingly !
  */
-typedef struct _ioinfo {
+typedef struct subchannel {
      unsigned int  irq;           /* aka. subchannel number */
      spinlock_t    irq_lock;      /* irq lock */
-     void          *private_data; /* pointer to private data */
 
-     struct _ioinfo *prev;
-     struct _ioinfo *next;
+     __u8          st;            /* subchannel type */
+
+     void          *private_data; /* pointer to private data */
 
-     __u8          st;            /* subchannel type */	
+     struct subchannel *prev;
+     struct subchannel *next;
 
      union {
         unsigned int info;
@@ -78,8 +81,26 @@
      unsigned long qflag;         /* queued flags */
      __u8          qlpm;          /* queued logical path mask */
      ssd_info_t    ssd_info;      /* subchannel description */
+     struct device dev;		  /* entry in device tree */
+} __attribute__ ((aligned(8))) ioinfo_t;
 
-   } __attribute__ ((aligned(8))) ioinfo_t;
+
+/*
+ * There are four different subchannel types, but we are currently
+ * only interested in I/O subchannels. This means there is only
+ * one subchannel_driver, other subchannels belonging to css_bus_type
+ * are simply ignored.
+ */
+struct subchannel_driver {
+	enum {
+		SUBCHANNEL_TYPE_IO      = 0,
+		SUBCHANNEL_TYPE_CHSC    = 1,
+		SUBCHANNEL_TYPE_MESSAGE = 2,
+		SUBCHANNEL_TYPE_ADM     = 3,
+	} st;			  /* subchannel type */
+	struct device_driver drv; /* entry in driver tree */
+};
+extern struct bus_type css_bus_type;
 
 #define IOINFO_FLAGS_BUSY    0x80000000
 #define IOINFO_FLAGS_OPER    0x40000000

