Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWIGMCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWIGMCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 08:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWIGMCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 08:02:37 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:26958 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751598AbWIGMCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 08:02:35 -0400
Date: Thu, 7 Sep 2006 14:02:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [patch] s390: cleanup appldata.
Message-ID: <20060907120233.GC6997@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] cleanup appldata.

Introduce asm header that contains the appldata data structures and
the diag inline assembly.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata.h      |   16 ------
 arch/s390/appldata/appldata_base.c |   81 ++++-----------------------------
 arch/s390/appldata/appldata_os.c   |    1 
 include/asm-s390/appldata.h        |   90 +++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 85 deletions(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2006-09-07 12:38:19.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2006-09-07 12:39:27.000000000 +0200
@@ -14,20 +14,20 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/smp.h>
 #include <linux/interrupt.h>
 #include <linux/proc_fs.h>
 #include <linux/page-flags.h>
 #include <linux/swap.h>
 #include <linux/pagemap.h>
 #include <linux/sysctl.h>
-#include <asm/timer.h>
-//#include <linux/kernel_stat.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/workqueue.h>
+#include <asm/appldata.h>
+#include <asm/timer.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/smp.h>
 
 #include "appldata.h"
 
@@ -39,34 +39,6 @@
 
 #define TOD_MICRO	0x01000			/* nr. of TOD clock units
 						   for 1 microsecond */
-
-/*
- * Parameter list for DIAGNOSE X'DC'
- */
-#ifndef CONFIG_64BIT
-struct appldata_parameter_list {
-	u16 diag;		/* The DIAGNOSE code X'00DC'          */
-	u8  function;		/* The function code for the DIAGNOSE */
-	u8  parlist_length;	/* Length of the parameter list       */
-	u32 product_id_addr;	/* Address of the 16-byte product ID  */
-	u16 reserved;
-	u16 buffer_length;	/* Length of the application data buffer  */
-	u32 buffer_addr;	/* Address of the application data buffer */
-};
-#else
-struct appldata_parameter_list {
-	u16 diag;
-	u8  function;
-	u8  parlist_length;
-	u32 unused01;
-	u16 reserved;
-	u16 buffer_length;
-	u32 unused02;
-	u64 product_id_addr;
-	u64 buffer_addr;
-};
-#endif /* CONFIG_64BIT */
-
 /*
  * /proc entries (sysctl)
  */
@@ -181,46 +153,17 @@ static void appldata_work_fn(void *data)
 int appldata_diag(char record_nr, u16 function, unsigned long buffer,
 			u16 length, char *mod_lvl)
 {
-	unsigned long ry;
-	struct appldata_product_id {
-		char prod_nr[7];			/* product nr. */
-		char prod_fn[2];			/* product function */
-		char record_nr;				/* record nr. */
-		char version_nr[2];			/* version */
-		char release_nr[2];			/* release */
-		char mod_lvl[2];			/* modification lvl. */
-	} appldata_product_id = {
-	/* all strings are EBCDIC, record_nr is byte */
+	struct appldata_product_id id = {
 		.prod_nr    = {0xD3, 0xC9, 0xD5, 0xE4,
-				0xE7, 0xD2, 0xD9},	/* "LINUXKR" */
-		.prod_fn    = {0xD5, 0xD3},		/* "NL" */
+			       0xE7, 0xD2, 0xD9},	/* "LINUXKR" */
+		.prod_fn    = 0xD5D3,			/* "NL" */
 		.record_nr  = record_nr,
-		.version_nr = {0xF2, 0xF6},		/* "26" */
-		.release_nr = {0xF0, 0xF1},		/* "01" */
-		.mod_lvl    = {mod_lvl[0], mod_lvl[1]},
-	};
-	struct appldata_parameter_list appldata_parameter_list = {
-				.diag = 0xDC,
-				.function = function,
-				.parlist_length =
-					sizeof(appldata_parameter_list),
-				.buffer_length = length,
-				.product_id_addr =
-					(unsigned long) &appldata_product_id,
-				.buffer_addr = virt_to_phys((void *) buffer)
+		.version_nr = 0xF2F6,			/* "26" */
+		.release_nr = 0xF0F1,			/* "01" */
+		.mod_lvl    = (mod_lvl[0]) << 8 | mod_lvl[1],
 	};
 
-	if (!MACHINE_IS_VM)
-		return -ENOSYS;
-	ry = -1;
-	asm volatile(
-			"diag %1,%0,0xDC\n\t"
-			: "=d" (ry)
-			: "d" (&appldata_parameter_list),
-			  "m" (appldata_parameter_list),
-			  "m" (appldata_product_id)
-			: "cc");
-	return (int) ry;
+	return appldata_asm(&id, function, (void *) buffer, length);
 }
 /************************ timer, work, DIAG <END> ****************************/
 
diff -urpN linux-2.6/arch/s390/appldata/appldata.h linux-2.6-patched/arch/s390/appldata/appldata.h
--- linux-2.6/arch/s390/appldata/appldata.h	2006-09-07 12:38:19.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata.h	2006-09-07 12:39:27.000000000 +0200
@@ -29,22 +29,6 @@
 #define CTL_APPLDATA_NET_SUM	2125
 #define CTL_APPLDATA_PROC	2126
 
-#ifndef CONFIG_64BIT
-
-#define APPLDATA_START_INTERVAL_REC 0x00	/* Function codes for */
-#define APPLDATA_STOP_REC	    0x01	/* DIAG 0xDC	  */
-#define APPLDATA_GEN_EVENT_RECORD   0x02
-#define APPLDATA_START_CONFIG_REC   0x03
-
-#else
-
-#define APPLDATA_START_INTERVAL_REC 0x80
-#define APPLDATA_STOP_REC	    0x81
-#define APPLDATA_GEN_EVENT_RECORD   0x82
-#define APPLDATA_START_CONFIG_REC   0x83
-
-#endif /* CONFIG_64BIT */
-
 #define P_INFO(x...)	printk(KERN_INFO MY_PRINT_NAME " info: " x)
 #define P_ERROR(x...)	printk(KERN_ERR MY_PRINT_NAME " error: " x)
 #define P_WARNING(x...)	printk(KERN_WARNING MY_PRINT_NAME " status: " x)
diff -urpN linux-2.6/arch/s390/appldata/appldata_os.c linux-2.6-patched/arch/s390/appldata/appldata_os.c
--- linux-2.6/arch/s390/appldata/appldata_os.c	2006-09-07 12:38:19.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_os.c	2006-09-07 12:39:27.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/netdevice.h>
 #include <linux/sched.h>
+#include <asm/appldata.h>
 #include <asm/smp.h>
 
 #include "appldata.h"
diff -urpN linux-2.6/include/asm-s390/appldata.h linux-2.6-patched/include/asm-s390/appldata.h
--- linux-2.6/include/asm-s390/appldata.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/appldata.h	2006-09-07 12:39:27.000000000 +0200
@@ -0,0 +1,90 @@
+/*
+ * include/asm-s390/appldata.h
+ *
+ * Copyright (C) IBM Corp. 2006
+ *
+ * Author(s): Melissa Howland <melissah@us.ibm.com>
+ */
+
+#ifndef _ASM_S390_APPLDATA_H
+#define _ASM_S390_APPLDATA_H
+
+#include <asm/io.h>
+
+#ifndef CONFIG_64BIT
+
+#define APPLDATA_START_INTERVAL_REC	0x00	/* Function codes for */
+#define APPLDATA_STOP_REC		0x01	/* DIAG 0xDC	      */
+#define APPLDATA_GEN_EVENT_REC		0x02
+#define APPLDATA_START_CONFIG_REC	0x03
+
+/*
+ * Parameter list for DIAGNOSE X'DC'
+ */
+struct appldata_parameter_list {
+	u16 diag;		/* The DIAGNOSE code X'00DC'	      */
+	u8  function;		/* The function code for the DIAGNOSE */
+	u8  parlist_length;	/* Length of the parameter list       */
+	u32 product_id_addr;	/* Address of the 16-byte product ID  */
+	u16 reserved;
+	u16 buffer_length;	/* Length of the application data buffer  */
+	u32 buffer_addr;	/* Address of the application data buffer */
+} __attribute__ ((packed));
+
+#else /* CONFIG_64BIT */
+
+#define APPLDATA_START_INTERVAL_REC	0x80
+#define APPLDATA_STOP_REC		0x81
+#define APPLDATA_GEN_EVENT_REC		0x82
+#define APPLDATA_START_CONFIG_REC	0x83
+
+/*
+ * Parameter list for DIAGNOSE X'DC'
+ */
+struct appldata_parameter_list {
+	u16 diag;
+	u8  function;
+	u8  parlist_length;
+	u32 unused01;
+	u16 reserved;
+	u16 buffer_length;
+	u32 unused02;
+	u64 product_id_addr;
+	u64 buffer_addr;
+} __attribute__ ((packed));
+
+#endif /* CONFIG_64BIT */
+
+struct appldata_product_id {
+	char prod_nr[7];	/* product number */
+	u16  prod_fn;		/* product function */
+	u8   record_nr; 	/* record number */
+	u16  version_nr;	/* version */
+	u16  release_nr;	/* release */
+	u16  mod_lvl;		/* modification level */
+} __attribute__ ((packed));
+
+static inline int appldata_asm(struct appldata_product_id *id,
+			       unsigned short fn, void *buffer,
+			       unsigned short length)
+{
+	struct appldata_parameter_list parm_list;
+	int ry;
+
+	if (!MACHINE_IS_VM)
+		return -ENOSYS;
+	parm_list.diag = 0xdc;
+	parm_list.function = fn;
+	parm_list.parlist_length = sizeof(parm_list);
+	parm_list.buffer_length = length;
+	parm_list.product_id_addr = (unsigned long) id;
+	parm_list.buffer_addr = virt_to_phys(buffer);
+	asm volatile(
+		"diag %1,%0,0xdc"
+		: "=d" (ry)
+		: "d" (&parm_list), "m" (parm_list), "m" (*id)
+		: "cc");
+	return ry;
+}
+
+#endif /* _ASM_S390_APPLDATA_H */
