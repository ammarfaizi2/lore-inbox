Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSLQRn5>; Tue, 17 Dec 2002 12:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbSLQRnz>; Tue, 17 Dec 2002 12:43:55 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:3338 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265266AbSLQRmo>; Tue, 17 Dec 2002 12:42:44 -0500
Date: Tue, 17 Dec 2002 17:50:40 +0000
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] oprofile update for 2.5.52
Message-ID: <20021217175040.GA94361@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18OLre-000E0r-00*nzo5tazpUbI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The below patch makes the following changes :

o headers cleanup
o remove deprecated kernel_only
o mention minimum oprofile version
o correctly initialise task_exit statistic
o remove racy debug check (wli saw this oops)
o remove pointless simple_open
o add dump functionality
o remove pessimising FASTCALL

Note that current .51 and also with this patch need to use oprofile CVS,
or here's a tarball :
http://www.movement.uklinux.net/oprofile-0.5cvs.tar.gz

Please apply

thanks
john


diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/init.c linux/arch/i386/oprofile/init.c
--- linux-linus/arch/i386/oprofile/init.c	2002-12-16 03:45:18.000000000 +0000
+++ linux/arch/i386/oprofile/init.c	2002-12-16 03:44:32.000000000 +0000
@@ -7,7 +7,6 @@
  * @author John Levon <levon@movementarian.org>
  */
 
-#include <linux/kernel.h>
 #include <linux/oprofile.h>
 #include <linux/init.h>
  
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/nmi_int.c linux/arch/i386/oprofile/nmi_int.c
--- linux-linus/arch/i386/oprofile/nmi_int.c	2002-12-16 03:45:18.000000000 +0000
+++ linux/arch/i386/oprofile/nmi_int.c	2002-12-17 05:36:10.000000000 +0000
@@ -7,19 +7,13 @@
  * @author John Levon <levon@movementarian.org>
  */
 
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
 #include <linux/oprofile.h>
-#include <linux/pm.h>
-#include <linux/thread_info.h>
 #include <asm/nmi.h>
-#include <asm/ptrace.h>
 #include <asm/msr.h>
 #include <asm/apic.h>
-#include <asm/bitops.h>
-#include <asm/processor.h>
  
 #include "op_counter.h"
 #include "op_x86_model.h"
@@ -27,7 +21,6 @@
 static struct op_x86_model_spec const * model;
 static struct op_msrs cpu_msrs[NR_CPUS];
 static unsigned long saved_lvtpc[NR_CPUS];
-static unsigned long kernel_only;
  
 static int nmi_start(void);
 static void nmi_stop(void);
@@ -53,10 +46,9 @@
 }
  
  
-// FIXME: kernel_only
 static int nmi_callback(struct pt_regs * regs, int cpu)
 {
-	return (model->check_ctrs(cpu, &cpu_msrs[cpu], regs));
+	return model->check_ctrs(cpu, &cpu_msrs[cpu], regs);
 }
  
  
@@ -210,7 +202,6 @@
 		oprofilefs_create_ulong(sb, dir, "user", &counter_config[i].user); 
 	}
 
-	oprofilefs_create_ulong(sb, root, "kernel_only", &kernel_only);
 	return 0;
 }
  
diff -X dontdiff -Naur linux-linus/Documentation/Changes linux/Documentation/Changes
--- linux-linus/Documentation/Changes	2002-12-16 03:58:39.000000000 +0000
+++ linux/Documentation/Changes	2002-12-16 03:57:39.000000000 +0000
@@ -61,6 +61,7 @@
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
 o  procps                 2.0.9                   # ps --version
+o  oprofile               0.5                     # oprofiled --version
 
 Kernel compilation
 ==================
@@ -368,6 +369,10 @@
 ---------
 o  <ftp://ftp.inr.ac.ru/ip-routing/iproute2-2.2.4-now-ss991023.tar.gz>
 
+OProfile
+--------
+o  <http://oprofile.sf.net/download.php3>
+ 
 Suggestions and corrections
 ===========================
 
diff -X dontdiff -Naur linux-linus/drivers/oprofile/buffer_sync.c linux/drivers/oprofile/buffer_sync.c
--- linux-linus/drivers/oprofile/buffer_sync.c	2002-12-16 03:54:20.000000000 +0000
+++ linux/drivers/oprofile/buffer_sync.c	2002-12-16 03:53:07.000000000 +0000
@@ -19,17 +19,17 @@
  * objects.
  */
 
-#include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/timer.h>
-#include <linux/dcookies.h>
+#include <linux/workqueue.h>
 #include <linux/notifier.h>
+#include <linux/dcookies.h>
 #include <linux/profile.h>
-#include <linux/workqueue.h>
-
+#include <linux/fs.h>
+ 
+#include "oprofile_stats.h"
 #include "event_buffer.h"
 #include "cpu_buffer.h"
-#include "oprofile_stats.h"
+#include "buffer_sync.h"
  
 #define DEFAULT_EXPIRE (HZ / 4)
  
diff -X dontdiff -Naur linux-linus/drivers/oprofile/cpu_buffer.c linux/drivers/oprofile/cpu_buffer.c
--- linux-linus/drivers/oprofile/cpu_buffer.c	2002-12-16 03:54:21.000000000 +0000
+++ linux/drivers/oprofile/cpu_buffer.c	2002-12-17 16:59:03.000000000 +0000
@@ -19,13 +19,10 @@
 
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
-#include <linux/smp.h>
 #include <linux/errno.h>
-#include <linux/cache.h>
  
 #include "cpu_buffer.h"
 #include "oprof.h"
-#include "oprofile_stats.h"
 
 struct oprofile_cpu_buffer cpu_buffer[NR_CPUS] __cacheline_aligned;
 
@@ -68,6 +65,7 @@
 		b->sample_received = 0;
 		b->sample_lost_locked = 0;
 		b->sample_lost_overflow = 0;
+		b->sample_lost_task_exit = 0;
 	}
 	return 0;
 fail:
@@ -92,9 +90,6 @@
 	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[cpu];
 	struct task_struct * task;
 
-	/* temporary ? */
-	BUG_ON(!oprofile_started);
- 
 	cpu_buf->sample_received++;
  
 	if (!spin_trylock(&cpu_buf->int_lock)) {
diff -X dontdiff -Naur linux-linus/drivers/oprofile/event_buffer.c linux/drivers/oprofile/event_buffer.c
--- linux-linus/drivers/oprofile/event_buffer.c	2002-12-16 03:54:21.000000000 +0000
+++ linux/drivers/oprofile/event_buffer.c	2002-12-16 03:53:07.000000000 +0000
@@ -12,19 +12,15 @@
  * escape value ESCAPE_CODE followed by an identifying code.
  */
 
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/sched.h>
 #include <linux/vmalloc.h>
-#include <linux/smp.h>
-#include <linux/dcookies.h>
 #include <linux/oprofile.h>
+#include <linux/sched.h>
+#include <linux/dcookies.h>
+#include <linux/fs.h>
 #include <asm/uaccess.h>
-#include <asm/atomic.h>
-
-#include "event_buffer.h"
-#include "cpu_buffer.h"
+ 
 #include "oprof.h"
+#include "event_buffer.h"
 #include "oprofile_stats.h"
 
 DECLARE_MUTEX(buffer_sem);
diff -X dontdiff -Naur linux-linus/drivers/oprofile/event_buffer.h linux/drivers/oprofile/event_buffer.h
--- linux-linus/drivers/oprofile/event_buffer.h	2002-12-16 03:54:21.000000000 +0000
+++ linux/drivers/oprofile/event_buffer.h	2002-12-16 03:53:07.000000000 +0000
@@ -11,7 +11,7 @@
 #define EVENT_BUFFER_H
 
 #include <linux/types.h> 
-#include <linux/sem.h>
+#include <asm/semaphore.h>
  
 int alloc_event_buffer(void);
 
diff -X dontdiff -Naur linux-linus/drivers/oprofile/oprof.c linux/drivers/oprofile/oprof.c
--- linux-linus/drivers/oprofile/oprof.c	2002-12-16 03:54:21.000000000 +0000
+++ linux/drivers/oprofile/oprof.c	2002-12-17 17:23:18.000000000 +0000
@@ -10,12 +10,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/notifier.h>
-#include <linux/profile.h>
 #include <linux/oprofile.h>
+#include <asm/semaphore.h>
 
 #include "oprof.h"
 #include "event_buffer.h"
@@ -86,6 +82,7 @@
 		goto out;
 
 	oprofile_started = 1;
+ 
 	oprofile_reset_stats();
 out:
 	up(&start_sem); 
@@ -148,6 +145,10 @@
 	oprofilefs_unregister();
 }
 
-MODULE_LICENSE("GPL");
+ 
 module_init(oprofile_init);
 module_exit(oprofile_exit);
+ 
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Levon <levon@movementarian.org>");
+MODULE_DESCRIPTION("OProfile system profiler");
diff -X dontdiff -Naur linux-linus/drivers/oprofile/oprof.h linux/drivers/oprofile/oprof.h
--- linux-linus/drivers/oprofile/oprof.h	2002-12-16 03:54:21.000000000 +0000
+++ linux/drivers/oprofile/oprof.h	2002-12-17 17:00:08.000000000 +0000
@@ -10,9 +10,6 @@
 #ifndef OPROF_H
 #define OPROF_H
 
-#include <linux/spinlock.h>
-#include <linux/oprofile.h>
- 
 int oprofile_setup(void);
 void oprofile_shutdown(void); 
 
@@ -22,6 +19,8 @@
 int oprofile_start(void);
 void oprofile_stop(void);
 
+struct oprofile_operations;
+ 
 extern unsigned long fs_buffer_size;
 extern unsigned long fs_cpu_buffer_size;
 extern unsigned long fs_buffer_watershed;
@@ -29,6 +28,9 @@
 extern struct oprofile_operations * oprofile_ops;
 extern unsigned long oprofile_started;
  
+struct super_block;
+struct dentry;
+
 void oprofile_create_files(struct super_block * sb, struct dentry * root);
  
 #endif /* OPROF_H */
diff -X dontdiff -Naur linux-linus/drivers/oprofile/oprofile_files.c linux/drivers/oprofile/oprofile_files.c
--- linux-linus/drivers/oprofile/oprofile_files.c	2002-12-16 03:54:21.000000000 +0000
+++ linux/drivers/oprofile/oprofile_files.c	2002-12-17 17:23:07.000000000 +0000
@@ -7,26 +7,18 @@
  * @author John Levon <levon@movementarian.org>
  */
 
-#include <linux/oprofile.h>
 #include <linux/fs.h>
-#include <linux/slab.h>
-#include <asm/uaccess.h>
- 
-#include "oprof.h"
+#include <linux/oprofile.h>
+
 #include "event_buffer.h"
 #include "oprofile_stats.h"
+#include "oprof.h"
  
 unsigned long fs_buffer_size = 131072;
 unsigned long fs_cpu_buffer_size = 8192;
 unsigned long fs_buffer_watershed = 32768; /* FIXME: tune */
 
  
-static int simple_open(struct inode * inode, struct file * filp)
-{
-	return 0;
-}
-
-
 static ssize_t cpu_type_read(struct file * file, char * buf, size_t count, loff_t * offset)
 {
 	unsigned long cpu_type = oprofile_cpu_type;
@@ -36,7 +28,6 @@
  
  
 static struct file_operations cpu_type_fops = {
-	.open		= simple_open,
 	.read		= cpu_type_read,
 };
  
@@ -71,15 +62,26 @@
 
  
 static struct file_operations enable_fops = {
-	.open		= simple_open,
 	.read		= enable_read,
 	.write		= enable_write,
 };
 
+
+static ssize_t dump_write(struct file *file, char const * buf, size_t count, loff_t * offset)
+{
+	wake_up_buffer_waiter();
+	return count;
+}
+
+
+static struct file_operations dump_fops = {
+	.write		= dump_write,
+};
  
 void oprofile_create_files(struct super_block * sb, struct dentry * root)
 {
 	oprofilefs_create_file(sb, root, "enable", &enable_fops);
+	oprofilefs_create_file(sb, root, "dump", &dump_fops);
 	oprofilefs_create_file(sb, root, "buffer", &event_buffer_fops);
 	oprofilefs_create_ulong(sb, root, "buffer_size", &fs_buffer_size);
 	oprofilefs_create_ulong(sb, root, "buffer_watershed", &fs_buffer_watershed);
diff -X dontdiff -Naur linux-linus/drivers/oprofile/oprofilefs.c linux/drivers/oprofile/oprofilefs.c
--- linux-linus/drivers/oprofile/oprofilefs.c	2002-12-16 03:54:21.000000000 +0000
+++ linux/drivers/oprofile/oprofilefs.c	2002-12-16 03:53:08.000000000 +0000
@@ -12,12 +12,9 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/pagemap.h>
-#include <linux/fs.h>
-#include <linux/dcache.h>
-#include <linux/file.h>
-#include <linux/namei.h>
 #include <linux/oprofile.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
 #include <asm/uaccess.h>
 
 #include "oprof.h"
diff -X dontdiff -Naur linux-linus/include/linux/oprofile.h linux/include/linux/oprofile.h
--- linux-linus/include/linux/oprofile.h	2002-12-16 03:55:21.000000000 +0000
+++ linux/include/linux/oprofile.h	2002-12-16 03:54:18.000000000 +0000
@@ -55,7 +55,7 @@
  * Add a sample. This may be called from any context. Pass
  * smp_processor_id() as cpu.
  */
-extern void FASTCALL(oprofile_add_sample(unsigned long eip, unsigned long event, int cpu));
+extern void oprofile_add_sample(unsigned long eip, unsigned long event, int cpu);
 
 /**
  * Create a file of the given name as a child of the given root, with
