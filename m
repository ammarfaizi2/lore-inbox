Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317636AbSHCSMy>; Sat, 3 Aug 2002 14:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSHCSMx>; Sat, 3 Aug 2002 14:12:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5904 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317636AbSHCSMu>; Sat, 3 Aug 2002 14:12:50 -0400
To: Linus Torvalds <torvalds@transmeta.com>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 1: 2.5.29-dma
Message-Id: <E17b3Rn-0006w8-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 19:16:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

The following patch adds support for CONFIG_GENERIC_ISA_DMA, which went
into the 2.4-ac kernel series prior to 2.5 happening.

The following patch allows architectures to decide whether they want
the generic ISA DMA functionality provided by kernel/dma.c and other
supporting files.

In addition, we move the procfs "/proc/dma" support code out of fs/proc
into kernel/dma.c, and adapt it to use the new seq_file code.


 arch/alpha/config.in   |    1 
 arch/i386/config.in    |    1 
 arch/m68k/config.in    |    1 
 arch/mips/config.in    |    1 
 arch/mips64/config.in  |    1 
 arch/parisc/config.in  |    1 
 arch/ppc/config.in     |    1 
 arch/sh/config.in      |    1 
 arch/sparc/config.in   |    1 
 arch/sparc64/config.in |    1 
 fs/proc/proc_misc.c    |    8 ----
 kernel/Makefile        |    5 +-
 kernel/dma.c           |   85 ++++++++++++++++++++++++++++++++++++++-----------
 kernel/ksyms.c         |    7 ----
 14 files changed, 79 insertions, 36 deletions

diff -urN orig/arch/alpha/config.in linux/arch/alpha/config.in
--- orig/arch/alpha/config.in	Sat Jul 27 13:55:09 2002
+++ linux/arch/alpha/config.in	Sat Jul 27 13:58:20 2002
@@ -7,6 +7,7 @@
 define_bool CONFIG_UID16 n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
diff -urN orig/arch/i386/config.in linux/arch/i386/config.in
--- orig/arch/i386/config.in	Sat Jul 27 13:55:09 2002
+++ linux/arch/i386/config.in	Sat Jul 27 13:58:21 2002
@@ -9,6 +9,7 @@
 define_bool CONFIG_SBUS n
 
 define_bool CONFIG_UID16 y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
diff -urN orig/arch/m68k/config.in linux/arch/m68k/config.in
--- orig/arch/m68k/config.in	Sat Jul 27 13:55:10 2002
+++ linux/arch/m68k/config.in	Sat Jul 27 13:59:44 2002
@@ -6,6 +6,7 @@
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 mainmenu_name "Linux/68k Kernel Configuration"
 
diff -urN orig/arch/mips/config.in linux/arch/mips/config.in
--- orig/arch/mips/config.in	Sat Jul 27 13:55:10 2002
+++ linux/arch/mips/config.in	Sat Jul 27 13:59:45 2002
@@ -4,6 +4,7 @@
 #
 define_bool CONFIG_MIPS y
 define_bool CONFIG_SMP n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 mainmenu_name "Linux Kernel Configuration"
 
diff -urN orig/arch/mips64/config.in linux/arch/mips64/config.in
--- orig/arch/mips64/config.in	Sat Jul 27 13:55:10 2002
+++ linux/arch/mips64/config.in	Sat Jul 27 13:59:45 2002
@@ -26,6 +26,7 @@
 
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 #
 # Select some configuration options automatically based on user selections
diff -urN orig/arch/parisc/config.in linux/arch/parisc/config.in
--- orig/arch/parisc/config.in	Sat Jul 27 13:55:10 2002
+++ linux/arch/parisc/config.in	Sat Jul 27 13:59:45 2002
@@ -9,6 +9,7 @@
 define_bool CONFIG_UID16 n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
diff -urN orig/arch/ppc/config.in linux/arch/ppc/config.in
--- orig/arch/ppc/config.in	Sat Jul 27 13:55:10 2002
+++ linux/arch/ppc/config.in	Sat Jul 27 13:59:45 2002
@@ -7,6 +7,7 @@
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 define_bool CONFIG_HAVE_DEC_LOCK y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 mainmenu_name "Linux/PowerPC Kernel Configuration"
 
diff -urN orig/arch/sh/config.in linux/arch/sh/config.in
--- orig/arch/sh/config.in	Sat Jul 27 13:55:10 2002
+++ linux/arch/sh/config.in	Sat Jul 27 13:59:46 2002
@@ -9,6 +9,7 @@
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
diff -urN orig/arch/sparc/config.in linux/arch/sparc/config.in
--- orig/arch/sparc/config.in	Sat Jul 27 13:55:10 2002
+++ linux/arch/sparc/config.in	Sat Jul 27 13:59:46 2002
@@ -6,6 +6,7 @@
 
 define_bool CONFIG_UID16 y
 define_bool CONFIG_HIGHMEM y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
diff -urN orig/arch/sparc64/config.in linux/arch/sparc64/config.in
--- orig/arch/sparc64/config.in	Sat Jul 27 13:55:10 2002
+++ linux/arch/sparc64/config.in	Sat Jul 27 13:59:46 2002
@@ -26,6 +26,7 @@
 define_bool CONFIG_HAVE_DEC_LOCK y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+define_bool CONFIG_GENERIC_ISA_DMA y
 define_bool CONFIG_ISA n
 define_bool CONFIG_ISAPNP n
 define_bool CONFIG_EISA n
diff -urN orig/fs/proc/proc_misc.c linux/fs/proc/proc_misc.c
--- orig/fs/proc/proc_misc.c	Sun Jul 21 21:37:16 2002
+++ linux/fs/proc/proc_misc.c	Tue Jul 23 09:54:09 2002
@@ -430,13 +430,6 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-static int dma_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_dma_list(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
 static int ioports_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -589,7 +582,6 @@
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
 		{"filesystems",	filesystems_read_proc},
-		{"dma",		dma_read_proc},
 		{"ioports",	ioports_read_proc},
 		{"cmdline",	cmdline_read_proc},
 #ifdef CONFIG_SGI_DS1286
diff -urN orig/kernel/Makefile linux/kernel/Makefile
--- orig/kernel/Makefile	Sat Jul 27 13:55:25 2002
+++ linux/kernel/Makefile	Sat Jul 27 14:14:38 2002
@@ -10,13 +10,14 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o
+		printk.o platform.o suspend.o dma.o
 
-obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
+obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o platform.o
 
+obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN orig/kernel/dma.c linux/kernel/dma.c
--- orig/kernel/dma.c	Thu Feb 22 11:25:48 2001
+++ linux/kernel/dma.c	Wed Jun  5 19:26:12 2002
@@ -9,11 +9,14 @@
  *   [It also happened to remove the sizeof(char *) == sizeof(int)
  *   assumption introduced because of those /proc/dma patches. -- Hennus]
  */
-
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
 #include <asm/dma.h>
 #include <asm/system.h>
 
@@ -65,20 +68,6 @@
 	{ 0, 0 }
 };
 
-int get_dma_list(char *buf)
-{
-	int i, len = 0;
-
-	for (i = 0 ; i < MAX_DMA_CHANNELS ; i++) {
-		if (dma_chan_busy[i].lock) {
-		    len += sprintf(buf+len, "%2d: %s\n",
-				   i,
-				   dma_chan_busy[i].device_id);
-		}
-	}
-	return len;
-} /* get_dma_list */
-
 
 int request_dma(unsigned int dmanr, const char * device_id)
 {
@@ -109,6 +98,19 @@
 
 } /* free_dma */
 
+static int proc_dma_show(struct seq_file *m, void *v)
+{
+	int i;
+
+	for (i = 0 ; i < MAX_DMA_CHANNELS ; i++) {
+		if (dma_chan_busy[i].lock) {
+		    seq_printf(m, "%2d: %s\n", i,
+			       dma_chan_busy[i].device_id);
+		}
+	}
+	return 0;
+}
+
 #else
 
 int request_dma(unsigned int dmanr, const char *device_id)
@@ -120,9 +122,54 @@
 {
 }
 
-int get_dma_list(char *buf)
-{	
-	strcpy(buf, "No DMA\n");
-	return 7;
+static int proc_dma_show(struct seq_file *m, void *v)
+{
+	seq_puts(m, "No DMA\n");
+	return 0;
 }
+
 #endif
+
+#ifdef CONFIG_PROC_FS
+static int proc_dma_open(struct inode *inode, struct file *file)
+{
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	struct seq_file *m;
+	int res;
+
+	if (!buf)
+		return -ENOMEM;
+	res = single_open(file, proc_dma_show, NULL);
+	if (!res) {
+		m = file->private_data;
+		m->buf = buf;
+		m->size = PAGE_SIZE;
+	} else
+		kfree(buf);
+	return res;
+}
+
+static struct file_operations proc_dma_operations = {
+	open:		proc_dma_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	single_release,
+};
+
+static int __init proc_dma_init(void)
+{
+	struct proc_dir_entry *e;
+
+	e = create_proc_entry("dma", 0, NULL);
+	if (e)
+		e->proc_fops = &proc_dma_operations;
+
+	return 0;
+}
+
+__initcall(proc_dma_init);
+#endif
+
+EXPORT_SYMBOL(request_dma);
+EXPORT_SYMBOL(free_dma);
+EXPORT_SYMBOL(dma_spin_lock);
diff -urN orig/kernel/ksyms.c linux/kernel/ksyms.c
--- orig/kernel/ksyms.c	Sun Jul  7 23:21:28 2002
+++ linux/kernel/ksyms.c	Sun Jul  7 17:42:16 2002
@@ -64,9 +64,6 @@
 extern void *sys_call_table;
 
 extern struct timezone sys_tz;
-extern int request_dma(unsigned int dmanr, const char * deviceID);
-extern void free_dma(unsigned int dmanr);
-extern spinlock_t dma_spin_lock;
 
 #ifdef CONFIG_MODVERSIONS
 const struct module_symbol __export_Using_Versions
@@ -437,10 +434,6 @@
 EXPORT_SYMBOL(brw_kiovec);
 EXPORT_SYMBOL(kiobuf_wait_for_io);
 
-/* dma handling */
-EXPORT_SYMBOL(request_dma);
-EXPORT_SYMBOL(free_dma);
-EXPORT_SYMBOL(dma_spin_lock);
 #ifdef HAVE_DISABLE_HLT
 EXPORT_SYMBOL(disable_hlt);
 EXPORT_SYMBOL(enable_hlt);

