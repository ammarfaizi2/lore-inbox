Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbTBKLdU>; Tue, 11 Feb 2003 06:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbTBKLdT>; Tue, 11 Feb 2003 06:33:19 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:7179 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267602AbTBKLc4>; Tue, 11 Feb 2003 06:32:56 -0500
Date: Tue, 11 Feb 2003 11:42:43 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH 2/4] oprofile update: CPU type as string
Message-ID: <20030211114243.GB57908@compsoc.man.ac.uk>
References: <20030211113227.GH53481@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211113227.GH53481@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18iYoF-0005fH-00*rn53bYXNIjA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch updates the horrible enum for the logical CPU type with a
string instead.


diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/init.c linux/arch/i386/oprofile/init.c
--- linux-linus/arch/i386/oprofile/init.c	2003-01-03 02:59:08.000000000 +0000
+++ linux/arch/i386/oprofile/init.c	2003-02-10 19:40:25.000000000 +0000
@@ -16,14 +16,14 @@
  * code unlike the NMI-based code.
  */
  
-extern int nmi_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu);
-extern void timer_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu);
+extern int nmi_init(struct oprofile_operations ** ops);
+extern void timer_init(struct oprofile_operations ** ops);
 
-int __init oprofile_arch_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	if (!nmi_init(ops, cpu))
+	if (!nmi_init(ops))
 #endif
-		timer_init(ops, cpu);
+		timer_init(ops);
 	return 0;
 }
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/nmi_int.c linux/arch/i386/oprofile/nmi_int.c
--- linux-linus/arch/i386/oprofile/nmi_int.c	2003-02-10 19:40:10.000000000 +0000
+++ linux/arch/i386/oprofile/nmi_int.c	2003-02-10 19:40:33.000000000 +0000
@@ -217,7 +217,7 @@
 
 #if !defined(CONFIG_X86_64)
 
-static int __init p4_init(enum oprofile_cpu * cpu)
+static int __init p4_init(void)
 {
 	__u8 cpu_model = current_cpu_data.x86_model;
 
@@ -225,18 +225,18 @@
 		return 0;
 
 #ifndef CONFIG_SMP
-	*cpu = OPROFILE_CPU_P4;
+	nmi_ops.cpu_type = "i386/p4";
 	model = &op_p4_spec;
 	return 1;
 #else
 	switch (smp_num_siblings) {
 		case 1:
-			*cpu = OPROFILE_CPU_P4;
+			nmi_ops.cpu_type = "i386/p4";
 			model = &op_p4_spec;
 			return 1;
 
 		case 2:
-			*cpu = OPROFILE_CPU_P4_HT2;
+			nmi_ops.cpu_type = "i386/p4-ht";
 			model = &op_p4_ht2_spec;
 			return 1;
 	}
@@ -248,16 +248,16 @@
 }
 
 
-static int __init ppro_init(enum oprofile_cpu * cpu)
+static int __init ppro_init(void)
 {
 	__u8 cpu_model = current_cpu_data.x86_model;
 
 	if (cpu_model > 5) {
-		*cpu = OPROFILE_CPU_PIII;
+		nmi_ops.cpu_type = "i386/piii";
 	} else if (cpu_model > 2) {
-		*cpu = OPROFILE_CPU_PII;
+		nmi_ops.cpu_type = "i386/pii";
 	} else {
-		*cpu = OPROFILE_CPU_PPRO;
+		nmi_ops.cpu_type = "i386/ppro";
 	}
 
 	model = &op_ppro_spec;
@@ -266,7 +266,7 @@
 
 #endif /* !CONFIG_X86_64 */
  
-int __init nmi_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+int __init nmi_init(struct oprofile_operations ** ops)
 {
 	__u8 vendor = current_cpu_data.x86_vendor;
 	__u8 family = current_cpu_data.x86;
@@ -280,7 +280,7 @@
 			if (family < 6)
 				return 0;
 			model = &op_athlon_spec;
-			*cpu = OPROFILE_CPU_ATHLON;
+			nmi_ops.cpu_type = "i386/athlon";
 			break;
  
 #if !defined(CONFIG_X86_64)
@@ -288,13 +288,13 @@
 			switch (family) {
 				/* Pentium IV */
 				case 0xf:
-					if (!p4_init(cpu))
+					if (!p4_init())
 						return 0;
 					break;
 
 				/* A P6-class processor */
 				case 6:
-					if (!ppro_init(cpu))
+					if (!ppro_init())
 						return 0;
 					break;
 
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/timer_int.c linux/arch/i386/oprofile/timer_int.c
--- linux-linus/arch/i386/oprofile/timer_int.c	2003-01-03 03:06:40.000000000 +0000
+++ linux/arch/i386/oprofile/timer_int.c	2003-02-10 19:40:25.000000000 +0000
@@ -45,13 +45,13 @@
 
 static struct oprofile_operations timer_ops = {
 	.start	= timer_start,
-	.stop	= timer_stop
+	.stop	= timer_stop,
+	.cpu_type = "timer"
 };
 
  
-void __init timer_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+void __init timer_init(struct oprofile_operations ** ops)
 {
 	*ops = &timer_ops;
-	*cpu = OPROFILE_CPU_TIMER;
 	printk(KERN_INFO "oprofile: using timer interrupt.\n");
 }
diff -X dontdiff -Naur linux-linus/arch/parisc/oprofile/init.c linux/arch/parisc/oprofile/init.c
--- linux-linus/arch/parisc/oprofile/init.c	2003-01-15 11:00:46.000000000 +0000
+++ linux/arch/parisc/oprofile/init.c	2003-02-11 10:53:47.000000000 +0000
@@ -11,10 +11,10 @@
 #include <linux/oprofile.h>
 #include <linux/init.h>
  
-extern void timer_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu);
+extern void timer_init(struct oprofile_operations ** ops);
 
-int __init oprofile_arch_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
-	timer_init(ops, cpu);
+	timer_init(ops);
 	return 0;
 }
diff -X dontdiff -Naur linux-linus/arch/parisc/oprofile/timer_int.c linux/arch/parisc/oprofile/timer_int.c
--- linux-linus/arch/parisc/oprofile/timer_int.c	2003-01-15 11:00:46.000000000 +0000
+++ linux/arch/parisc/oprofile/timer_int.c	2003-02-11 10:53:30.000000000 +0000
@@ -44,13 +44,13 @@
 
 static struct oprofile_operations timer_ops = {
 	.start	= timer_start,
-	.stop	= timer_stop
+	.stop	= timer_stop,
+	.cpu_type = "timer"
 };
 
  
-void __init timer_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+void __init timer_init(struct oprofile_operations ** ops)
 {
 	*ops = &timer_ops;
-	*cpu = OPROFILE_CPU_TIMER;
 	printk(KERN_INFO "oprofile: using timer interrupt.\n");
 }
diff -X dontdiff -Naur linux-linus/arch/ppc64/oprofile/init.c linux/arch/ppc64/oprofile/init.c
--- linux-linus/arch/ppc64/oprofile/init.c	2002-12-16 03:47:32.000000000 +0000
+++ linux/arch/ppc64/oprofile/init.c	2003-02-10 19:40:25.000000000 +0000
@@ -11,10 +11,10 @@
 #include <linux/oprofile.h>
 #include <linux/init.h>
  
-extern void timer_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu);
+extern void timer_init(struct oprofile_operations ** ops);
 
-int __init oprofile_arch_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
-	timer_init(ops, cpu);
+	timer_init(ops);
 	return 0;
 }
diff -X dontdiff -Naur linux-linus/arch/ppc64/oprofile/timer_int.c linux/arch/ppc64/oprofile/timer_int.c
--- linux-linus/arch/ppc64/oprofile/timer_int.c	2002-12-16 03:47:32.000000000 +0000
+++ linux/arch/ppc64/oprofile/timer_int.c	2003-02-10 19:40:25.000000000 +0000
@@ -44,13 +44,13 @@
 
 static struct oprofile_operations timer_ops = {
 	.start	= timer_start,
-	.stop	= timer_stop
+	.stop	= timer_stop,
+	.cpu_type = "timer"
 };
 
  
-void __init timer_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+void __init timer_init(struct oprofile_operations ** ops)
 {
 	*ops = &timer_ops;
-	*cpu = OPROFILE_CPU_TIMER;
 	printk(KERN_INFO "oprofile: using timer interrupt.\n");
 }
diff -X dontdiff -Naur linux-linus/arch/sparc64/oprofile/init.c linux/arch/sparc64/oprofile/init.c
--- linux-linus/arch/sparc64/oprofile/init.c	2002-12-16 03:45:58.000000000 +0000
+++ linux/arch/sparc64/oprofile/init.c	2003-02-10 19:40:25.000000000 +0000
@@ -11,10 +11,10 @@
 #include <linux/oprofile.h>
 #include <linux/init.h>
  
-extern void timer_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu);
+extern void timer_init(struct oprofile_operations ** ops);
 
-int __init oprofile_arch_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
-	timer_init(ops, cpu);
+	timer_init(ops);
 	return 0;
 }
diff -X dontdiff -Naur linux-linus/arch/sparc64/oprofile/timer_int.c linux/arch/sparc64/oprofile/timer_int.c
--- linux-linus/arch/sparc64/oprofile/timer_int.c	2002-12-16 03:45:58.000000000 +0000
+++ linux/arch/sparc64/oprofile/timer_int.c	2003-02-10 19:40:25.000000000 +0000
@@ -44,13 +44,13 @@
 
 static struct oprofile_operations timer_ops = {
 	.start	= timer_start,
-	.stop	= timer_stop
+	.stop	= timer_stop,
+	.cpu_type = "timer"
 };
 
  
-void __init timer_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+void __init timer_init(struct oprofile_operations ** ops)
 {
 	*ops = &timer_ops;
-	*cpu = OPROFILE_CPU_TIMER;
 	printk(KERN_INFO "oprofile: using timer interrupt.\n");
 }
diff -X dontdiff -Naur linux-linus/drivers/oprofile/oprof.c linux/drivers/oprofile/oprof.c
--- linux-linus/drivers/oprofile/oprof.c	2003-01-03 02:59:11.000000000 +0000
+++ linux/drivers/oprofile/oprof.c	2003-02-10 19:40:25.000000000 +0000
@@ -20,7 +20,6 @@
 #include "oprofile_stats.h"
  
 struct oprofile_operations * oprofile_ops;
-enum oprofile_cpu oprofile_cpu_type;
 unsigned long oprofile_started;
 static unsigned long is_setup;
 static DECLARE_MUTEX(start_sem);
@@ -127,10 +126,16 @@
 	/* Architecture must fill in the interrupt ops and the
 	 * logical CPU type.
 	 */
-	err = oprofile_arch_init(&oprofile_ops, &oprofile_cpu_type);
+	err = oprofile_arch_init(&oprofile_ops);
 	if (err)
 		goto out;
 
+	if (!oprofile_ops->cpu_type) {
+		printk(KERN_ERR "oprofile: cpu_type not set !\n");
+		err = -EFAULT;
+		goto out;
+	}
+
 	err = oprofilefs_register();
 	if (err)
 		goto out;
diff -X dontdiff -Naur linux-linus/drivers/oprofile/oprof.h linux/drivers/oprofile/oprof.h
--- linux-linus/drivers/oprofile/oprof.h	2003-01-03 02:59:11.000000000 +0000
+++ linux/drivers/oprofile/oprof.h	2003-02-10 19:40:25.000000000 +0000
@@ -24,7 +24,6 @@
 extern unsigned long fs_buffer_size;
 extern unsigned long fs_cpu_buffer_size;
 extern unsigned long fs_buffer_watershed;
-extern enum oprofile_cpu oprofile_cpu_type;
 extern struct oprofile_operations * oprofile_ops;
 extern unsigned long oprofile_started;
  
diff -X dontdiff -Naur linux-linus/drivers/oprofile/oprofile_files.c linux/drivers/oprofile/oprofile_files.c
--- linux-linus/drivers/oprofile/oprofile_files.c	2003-01-03 02:59:11.000000000 +0000
+++ linux/drivers/oprofile/oprofile_files.c	2003-02-10 19:40:25.000000000 +0000
@@ -21,9 +21,7 @@
  
 static ssize_t cpu_type_read(struct file * file, char * buf, size_t count, loff_t * offset)
 {
-	unsigned long cpu_type = oprofile_cpu_type;
-
-	return oprofilefs_ulong_to_user(&cpu_type, buf, count, offset);
+	return oprofilefs_str_to_user(oprofile_ops->cpu_type, buf, count, offset);
 }
  
  
diff -X dontdiff -Naur linux-linus/drivers/oprofile/oprofilefs.c linux/drivers/oprofile/oprofilefs.c
--- linux-linus/drivers/oprofile/oprofilefs.c	2003-01-03 02:59:11.000000000 +0000
+++ linux/drivers/oprofile/oprofilefs.c	2003-02-10 19:40:25.000000000 +0000
@@ -44,6 +44,29 @@
 	.drop_inode 	= generic_delete_inode,
 };
 
+
+ssize_t oprofilefs_str_to_user(char const * str, char * buf, size_t count, loff_t * offset)
+{
+	size_t len = strlen(str);
+
+	if (!count)
+		return 0;
+
+	if (*offset > len)
+		return 0;
+
+	if (count > len - *offset)
+		count = len - *offset;
+
+	if (copy_to_user(buf, str + *offset, count))
+		return -EFAULT;
+
+	*offset += count;
+
+	return count;
+}
+
+
 #define TMPBUFSIZE 50
 
 ssize_t oprofilefs_ulong_to_user(unsigned long * val, char * buf, size_t count, loff_t * offset)
diff -X dontdiff -Naur linux-linus/include/linux/oprofile.h linux/include/linux/oprofile.h
--- linux-linus/include/linux/oprofile.h	2003-02-10 19:40:10.000000000 +0000
+++ linux/include/linux/oprofile.h	2003-02-10 19:40:25.000000000 +0000
@@ -21,24 +21,6 @@
 struct dentry;
 struct file_operations;
  
-/* This is duplicated from user-space so
- * must be kept in sync :(
- */
-enum oprofile_cpu {
-	OPROFILE_CPU_PPRO,
-	OPROFILE_CPU_PII,
-	OPROFILE_CPU_PIII,
-	OPROFILE_CPU_ATHLON,
-	OPROFILE_CPU_TIMER,
-	OPROFILE_UNUSED1, /* 2.4's RTC mode */
-	OPROFILE_CPU_P4,
-	OPROFILE_CPU_IA64,
-	OPROFILE_CPU_IA64_1,
-	OPROFILE_CPU_IA64_2,
-	OPROFILE_CPU_HAMMER,
-	OPROFILE_CPU_P4_HT2
-};
-
 /* Operations structure to be filled in */
 struct oprofile_operations {
 	/* create any necessary configuration files in the oprofile fs.
@@ -52,14 +34,16 @@
 	int (*start)(void);
 	/* Stop delivering interrupts. */
 	void (*stop)(void);
+	/* CPU identification string. */
+	char * cpu_type;
 };
 
 /**
  * One-time initialisation. *ops must be set to a filled-in
- * operations structure. oprofile_cpu_type must be set.
+ * operations structure.
  * Return 0 on success.
  */
-int oprofile_arch_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu);
+int oprofile_arch_init(struct oprofile_operations ** ops);
  
 /**
  * Add a sample. This may be called from any context. Pass
@@ -91,6 +75,12 @@
 	char const * name);
 
 /**
+ * Write the given asciz string to the given user buffer @buf, updating *offset
+ * appropriately. Returns bytes written or -EFAULT.
+ */
+ssize_t oprofilefs_str_to_user(char const * str, char * buf, size_t count, loff_t * offset);
+
+/**
  * Convert an unsigned long value into ASCII and copy it to the user buffer @buf,
  * updating *offset appropriately. Returns bytes written or -EFAULT.
  */
