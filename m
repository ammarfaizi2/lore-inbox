Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316976AbSFQUWu>; Mon, 17 Jun 2002 16:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSFQUWt>; Mon, 17 Jun 2002 16:22:49 -0400
Received: from [193.168.128.42] ([193.168.128.42]:58802 "HELO psmtp2.dnsg.net")
	by vger.kernel.org with SMTP id <S316976AbSFQUWp>;
	Mon, 17 Jun 2002 16:22:45 -0400
Subject: [PATCH] 2.5.22: s390 fixes.
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Jun 2002 00:21:14 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17K4s7-0000J4-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
some recent changes in the s390 architectures files:
1) Makefile fixes.
2) Add missing include statements.
3) Convert all parametes in the 31 bit emulation wrapper of sys_futex.
4) Remove semicolons after 'fi' in Config.in
5) Fix scheduler defines in system.h
6) Simplifications in qdio.c

blue skies,
  Martin.

diff -urN linux-2.5.22/arch/s390/math-emu/Makefile linux-2.5.22-s390/arch/s390/math-emu/Makefile
--- linux-2.5.22/arch/s390/math-emu/Makefile	Mon Jun 17 17:10:11 2002
+++ linux-2.5.22-s390/arch/s390/math-emu/Makefile	Mon Jun 17 17:25:12 2002
@@ -6,6 +6,7 @@
 obj-$(CONFIG_MATHEMU) := math.o qrnnd.o
 
 EXTRA_CFLAGS = -I. -I$(TOPDIR)/include/math-emu -w
+EXTRA_AFLAGS	:= -traditional
 
 include $(TOPDIR)/Rules.make
 
diff -urN linux-2.5.22/arch/s390/mm/ioremap.c linux-2.5.22-s390/arch/s390/mm/ioremap.c
--- linux-2.5.22/arch/s390/mm/ioremap.c	Mon Jun 17 17:10:11 2002
+++ linux-2.5.22-s390/arch/s390/mm/ioremap.c	Mon Jun 17 17:25:12 2002
@@ -14,6 +14,7 @@
  */
 
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
diff -urN linux-2.5.22/arch/s390x/kernel/wrapper32.S linux-2.5.22-s390/arch/s390x/kernel/wrapper32.S
--- linux-2.5.22/arch/s390x/kernel/wrapper32.S	Mon Jun 17 17:10:11 2002
+++ linux-2.5.22-s390/arch/s390x/kernel/wrapper32.S	Mon Jun 17 17:25:12 2002
@@ -1112,6 +1112,8 @@
 sys32_futex_wrapper:
 	llgtr	%r2,%r2			# void *
 	lgfr	%r3,%r3			# int
+	lgfr	%r4,%r4			# int
+	llgtr	%r5,%r5			# struct timespec *
 	jg	sys_futex		# branch to system call
 
 	.globl	sys32_setxattr_wrapper
diff -urN linux-2.5.22/arch/s390x/mm/ioremap.c linux-2.5.22-s390/arch/s390x/mm/ioremap.c
--- linux-2.5.22/arch/s390x/mm/ioremap.c	Mon Jun 17 17:10:11 2002
+++ linux-2.5.22-s390/arch/s390x/mm/ioremap.c	Mon Jun 17 17:25:12 2002
@@ -14,6 +14,7 @@
  */
 
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
diff -urN linux-2.5.22/drivers/s390/Config.in linux-2.5.22-s390/drivers/s390/Config.in
--- linux-2.5.22/drivers/s390/Config.in	Mon Jun 17 17:10:11 2002
+++ linux-2.5.22-s390/drivers/s390/Config.in	Mon Jun 17 17:25:12 2002
@@ -17,18 +17,18 @@
   dep_tristate '   Support for ECKD Disks' CONFIG_DASD_ECKD $CONFIG_DASD
   if [ "$CONFIG_DASD_ECKD" = "m" ]; then
     bool     '   Automatic activation of ECKD module' CONFIG_DASD_AUTO_ECKD
-  fi;
+  fi
   dep_tristate '   Support for FBA  Disks' CONFIG_DASD_FBA $CONFIG_DASD
   if [ "$CONFIG_DASD_FBA" = "m" ]; then
     bool     '   Automatic activation of FBA  module' CONFIG_DASD_AUTO_FBA
-  fi;
+  fi
 #  dep_tristate '   Support for CKD  Disks' CONFIG_DASD_CKD $CONFIG_DASD
   if [ "$CONFIG_ARCH_S390X" != "y" ]; then
     dep_tristate '   Support for DIAG access to CMS reserved Disks' CONFIG_DASD_DIAG $CONFIG_DASD
     if [ "$CONFIG_DASD_DIAG" = "m" ]; then
       bool     '   Automatic activation of DIAG module' CONFIG_DASD_AUTO_DIAG
-    fi;
-  fi; 
+    fi
+  fi
 fi
 
 endmenu
diff -urN linux-2.5.22/drivers/s390/Makefile linux-2.5.22-s390/drivers/s390/Makefile
--- linux-2.5.22/drivers/s390/Makefile	Mon Jun 17 04:31:32 2002
+++ linux-2.5.22-s390/drivers/s390/Makefile	Mon Jun 17 17:25:20 2002
@@ -7,6 +7,6 @@
 obj-$(CONFIG_QDIO) += qdio.o
 
 obj-y += s390mach.o s390dyn.o sysinfo.o
-obj-y += block/ char/ misc/ net/ scsi/ cio/
+obj-y += block/ char/ misc/ net/ cio/
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.22/drivers/s390/qdio.c linux-2.5.22-s390/drivers/s390/qdio.c
--- linux-2.5.22/drivers/s390/qdio.c	Mon Jun 17 17:10:11 2002
+++ linux-2.5.22-s390/drivers/s390/qdio.c	Mon Jun 17 17:25:12 2002
@@ -61,9 +61,7 @@
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
 MODULE_DESCRIPTION("QDIO base support version 2, " \
 		   "Copyright 2000 IBM Corporation");
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,12))
 MODULE_LICENSE("GPL");
-#endif
 
 /******************** HERE WE GO ***********************************/
 
@@ -1584,7 +1582,7 @@
 			kfree(irq_ptr->input_qs[i]);
 
 next:
-		if (!irq_ptr->output_qs[i]) goto next2;
+		if (!irq_ptr->output_qs[i]) continue;
 		available=0;
 		if (!irq_ptr->output_qs[i]->is_0copy_sbals_q)
 			for (j=0;j<QDIO_MAX_BUFFERS_PER_Q;j++) {
@@ -1599,7 +1597,7 @@
 		if (irq_ptr->output_qs[i]->slib)
 			kfree(irq_ptr->output_qs[i]->slib);
 		kfree(irq_ptr->output_qs[i]);
-next2:
+
 	}
 	if (irq_ptr->qdr) kfree(irq_ptr->qdr);
 	kfree(irq_ptr);
@@ -2191,21 +2189,12 @@
 {
 	int cc;
 
-#ifdef QDIO_32_BIT
-	asm volatile (
-		".insn	rre,0xb25f0000,%1,0	\n\t"
-		"ipm	%0	\n\t"
-		"srl	%0,28	\n\t"
-		: "=d" (cc) : "d" (chsc_area) : "cc"
-		);
-#else /* QDIO_32_BIT */
 	asm volatile (
 		".insn	rre,0xb25f0000,%1,0	\n\t"
 		"ipm	%0	\n\t"
 		"srl	%0,28	\n\t"
 		: "=d" (cc) : "d" (chsc_area) : "cc"
 		);
-#endif /* QDIO_32_BIT */
 
 	return cc;
 }
diff -urN linux-2.5.22/include/asm-s390/system.h linux-2.5.22-s390/include/asm-s390/system.h
--- linux-2.5.22/include/asm-s390/system.h	Mon Jun 17 17:10:11 2002
+++ linux-2.5.22-s390/include/asm-s390/system.h	Mon Jun 17 17:25:12 2002
@@ -18,8 +18,12 @@
 #endif
 #include <linux/kernel.h>
 
-#define prepare_to_switch()	do { } while(0)
-#define switch_to(prev,next) do {					     \
+#define prepare_arch_schedule(prev)		do { } while (0)
+#define finish_arch_schedule(prev)		do { } while (0)
+#define prepare_arch_switch(rq)			do { } while (0)
+#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
+
+#define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
 		break;							     \
 	save_fp_regs1(&prev->thread.fp_regs);				     \
diff -urN linux-2.5.22/include/asm-s390x/system.h linux-2.5.22-s390/include/asm-s390x/system.h
--- linux-2.5.22/include/asm-s390x/system.h	Mon Jun 17 17:10:11 2002
+++ linux-2.5.22-s390/include/asm-s390x/system.h	Mon Jun 17 17:25:12 2002
@@ -18,8 +18,12 @@
 #endif
 #include <linux/kernel.h>
 
-#define prepare_to_switch()	do { } while(0)
-#define switch_to(prev,next) do {					     \
+#define prepare_arch_schedule(prev)		do { } while (0)
+#define finish_arch_schedule(prev)		do { } while (0)
+#define prepare_arch_switch(rq)			do { } while (0)
+#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
+
+#define switch_to(prev,next),last do {					     \
 	if (prev == next)						     \
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
