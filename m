Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSK0Rrn>; Wed, 27 Nov 2002 12:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSK0Rrn>; Wed, 27 Nov 2002 12:47:43 -0500
Received: from zero.aec.at ([193.170.194.10]:61701 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261305AbSK0Rre>;
	Wed, 27 Nov 2002 12:47:34 -0500
Date: Wed, 27 Nov 2002 18:54:42 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: [PATCH] Cleanups & fixes for the MTRR driver
Message-ID: <20021127175441.GA10779@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To fix some bugs and cut down code duplication between i386 and x86-64
I decided to reuse (using symlinks) the i386 MTRR driver for x86-64.
To do that I did some cleanups and a few bug fixes in the i386 mtrr driver.

- Convert it to seq_file. This makes it a lot cleaner and gets rid
of some cruft.
- Some long -> int required on 64bit (nop on 32bit) 
- Add some RED-PENs for unfixed bugs (e.g. it doesn't support
physical addresses > 4GB on 32bit hosts and the SMP locking is not
very strong) 
- Remove bogus // in mtrr_write that made the function a nop
(= only ioctl was working for changing) 
- Unify duplicated mtrr_strings define.
- Some other minor fixes and cleanups

Patch for 2.5.49.

Please consider applying, 

-Andi



diff -burpN -X ../KDIFX linux-vanilla/arch/i386/kernel/cpu/mtrr/generic.c linux/arch/i386/kernel/cpu/mtrr/generic.c
--- linux-vanilla/arch/i386/kernel/cpu/mtrr/generic.c	2002-11-13 12:07:27.000000000 +0100
+++ linux/arch/i386/kernel/cpu/mtrr/generic.c	2002-11-27 12:13:18.000000000 +0100
@@ -1,3 +1,5 @@
+/* This only handles 32bit MTRR on 32bit hosts. This is strictly wrong
+   because MTRRs can span upto 40 bits (36bits on most modern x86) */ 
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -30,7 +32,7 @@ get_mtrr_var_range(unsigned int index, s
 static void __init
 get_fixed_ranges(mtrr_type * frs)
 {
-	unsigned long *p = (unsigned long *) frs;
+	unsigned int *p = (unsigned int *) frs;
 	int i;
 
 	rdmsr(MTRRfix64K_00000_MSR, p[0], p[1]);
@@ -46,7 +48,7 @@ void get_mtrr_state(void)
 {
 	unsigned int i;
 	struct mtrr_var_range *vrs;
-	unsigned long lo, dummy;
+	unsigned lo, dummy;
 
 	if (!mtrr_state.var_ranges) {
 		mtrr_state.var_ranges = kmalloc(num_var_ranges * sizeof (struct mtrr_var_range), 
@@ -113,11 +115,10 @@ int generic_get_free_region(unsigned lon
 	return -ENOSPC;
 }
 
-
 void generic_get_mtrr(unsigned int reg, unsigned long *base,
 		      unsigned long *size, mtrr_type * type)
 {
-	unsigned long mask_lo, mask_hi, base_lo, base_hi;
+	unsigned int mask_lo, mask_hi, base_lo, base_hi;
 
 	rdmsr(MTRRphysMask_MSR(reg), mask_lo, mask_hi);
 	if ((mask_lo & 0x800) == 0) {
@@ -143,10 +144,10 @@ void generic_get_mtrr(unsigned int reg, 
 
 static int __init set_fixed_ranges(mtrr_type * frs)
 {
-	unsigned long *p = (unsigned long *) frs;
+	unsigned int *p = (unsigned int *) frs;
 	int changed = FALSE;
 	int i;
-	unsigned long lo, hi;
+	unsigned int lo, hi;
 
 	rdmsr(MTRRfix64K_00000_MSR, lo, hi);
 	if (p[0] != lo || p[1] != hi) {
@@ -228,13 +229,13 @@ static unsigned long set_mtrr_state(u32 
 }
 
 
-static u32 cr4 = 0;
+static unsigned long cr4 = 0;
 static u32 deftype_lo, deftype_hi;
 static spinlock_t set_atomicity_lock = SPIN_LOCK_UNLOCKED;
 
 static void prepare_set(void)
 {
-	u32 cr0;
+	unsigned long cr0;
 
 	/*  Note that this is not ideal, since the cache is only flushed/disabled
 	   for this CPU while the MTRRs are changed, but changing this requires
diff -burpN -X ../KDIFX linux-vanilla/arch/i386/kernel/cpu/mtrr/if.c linux/arch/i386/kernel/cpu/mtrr/if.c
--- linux-vanilla/arch/i386/kernel/cpu/mtrr/if.c	2002-10-19 06:01:18.000000000 +0200
+++ linux/arch/i386/kernel/cpu/mtrr/if.c	2002-11-27 12:33:08.000000000 +0100
@@ -3,27 +3,27 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/seq_file.h>
 #include <asm/uaccess.h>
 
-/* What kind of fucking hack is this? */
-#define MTRR_NEED_STRINGS
+#define LINE_SIZE 80
 
 #include <asm/mtrr.h>
 #include "mtrr.h"
 
-static char *ascii_buffer;
-static unsigned int ascii_buf_bytes;
-
+/* RED-PEN: this is accessed without any locking */
 extern unsigned int *usage_table;
 
-#define LINE_SIZE      80
+static int mtrr_seq_show(struct seq_file *seq, void *offset);
+
+#define FILE_FCOUNT(f) (((struct seq_file *)((f)->private_data))->private)
 
 static int
 mtrr_file_add(unsigned long base, unsigned long size,
 	      unsigned int type, char increment, struct file *file, int page)
 {
 	int reg, max;
-	unsigned int *fcount = file->private_data;
+	unsigned int *fcount = FILE_FCOUNT(file); 
 
 	max = num_var_ranges;
 	if (fcount == NULL) {
@@ -33,7 +33,7 @@ mtrr_file_add(unsigned long base, unsign
 			return -ENOMEM;
 		}
 		memset(fcount, 0, max * sizeof *fcount);
-		file->private_data = fcount;
+		FILE_FCOUNT(file) = fcount;
 	}
 	if (!page) {
 		if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
@@ -79,19 +79,7 @@ mtrr_file_del(unsigned long base, unsign
 	return reg;
 }
 
-static ssize_t
-mtrr_read(struct file *file, char *buf, size_t len, loff_t * ppos)
-{
-	if (*ppos >= ascii_buf_bytes)
-		return 0;
-	if (*ppos + len > ascii_buf_bytes)
-		len = ascii_buf_bytes - *ppos;
-	if (copy_to_user(buf, ascii_buffer + *ppos, len))
-		return -EFAULT;
-	*ppos += len;
-	return len;
-}
-
+/* RED-PEN: seq_file can seek now. this is ignored. */
 static ssize_t
 mtrr_write(struct file *file, const char *buf, size_t len, loff_t * ppos)
 /*  Format of control line:
@@ -149,7 +137,7 @@ mtrr_write(struct file *file, const char
 	ptr += 5;
 	for (; isspace(*ptr); ++ptr) ;
 	for (i = 0; i < MTRR_NUM_TYPES; ++i) {
-//		if (strcmp(ptr, mtrr_strings[i]))
+		if (strcmp(ptr, mtrr_strings[i]))
 			continue;
 		base >>= PAGE_SHIFT;
 		size >>= PAGE_SHIFT;
@@ -173,6 +161,8 @@ mtrr_ioctl(struct inode *inode, struct f
 	struct mtrr_sentry sentry;
 	struct mtrr_gentry gentry;
 
+	printk("mtrr_ioctl %d\n", cmd);
+
 	switch (cmd) {
 	default:
 		return -ENOIOCTLCMD;
@@ -291,10 +281,9 @@ static int
 mtrr_close(struct inode *ino, struct file *file)
 {
 	int i, max;
-	unsigned int *fcount = file->private_data;
+	unsigned int *fcount = FILE_FCOUNT(file);
 
-	if (fcount == NULL)
-		return 0;
+	if (fcount != NULL) {
 	max = num_var_ranges;
 	for (i = 0; i < max; ++i) {
 		while (fcount[i] > 0) {
@@ -304,13 +293,26 @@ mtrr_close(struct inode *ino, struct fil
 		}
 	}
 	kfree(fcount);
-	file->private_data = NULL;
-	return 0;
+		FILE_FCOUNT(file) = NULL;
+	}
+	return single_release(ino, file);
+}
+
+static int mtrr_open(struct inode *inode, struct file *file)
+{
+	if (!mtrr_if) 
+		return -EIO;
+	if (!mtrr_if->get) 
+		return -ENXIO; 
+	return single_open(file, mtrr_seq_show, NULL);
 }
 
 static struct file_operations mtrr_fops = {
 	.owner   = THIS_MODULE,
-	.read    = mtrr_read,
+	.open	 = mtrr_open, 
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
 	.write   = mtrr_write,
 	.ioctl   = mtrr_ioctl,
 	.release = mtrr_close,
@@ -329,14 +331,14 @@ char * attrib_to_str(int x)
 	return (x <= 6) ? mtrr_strings[x] : "?";
 }
 
-void compute_ascii(void)
+static int mtrr_seq_show(struct seq_file *seq, void *offset)
 {
 	char factor;
-	int i, max;
+	int i, max, len;
 	mtrr_type type;
 	unsigned long base, size;
 
-	ascii_buf_bytes = 0;
+	len = 0;
 	max = num_var_ranges;
 	for (i = 0; i < max; i++) {
 		mtrr_if->get(i, &base, &size, &type);
@@ -351,32 +353,19 @@ void compute_ascii(void)
 				factor = 'M';
 				size >>= 20 - PAGE_SHIFT;
 			}
-			sprintf
-			    (ascii_buffer + ascii_buf_bytes,
+			/* RED-PEN: base can be > 32bit */ 
+			len += seq_printf(seq, 
 			     "reg%02i: base=0x%05lx000 (%4liMB), size=%4li%cB: %s, count=%d\n",
 			     i, base, base >> (20 - PAGE_SHIFT), size, factor,
 			     attrib_to_str(type), usage_table[i]);
-			ascii_buf_bytes +=
-			    strlen(ascii_buffer + ascii_buf_bytes);
 		}
 	}
-	devfs_set_file_size(devfs_handle, ascii_buf_bytes);
-#  ifdef CONFIG_PROC_FS
-	if (proc_root_mtrr)
-		proc_root_mtrr->size = ascii_buf_bytes;
-#  endif			/*  CONFIG_PROC_FS  */
+	devfs_set_file_size(devfs_handle, len);	
+	return 0;
 }
 
 static int __init mtrr_if_init(void)
 {
-	int max = num_var_ranges;
-
-	if ((ascii_buffer = kmalloc(max * LINE_SIZE, GFP_KERNEL)) == NULL) {
-		printk("mtrr: could not allocate\n");
-		return -ENOMEM;
-	}
-	ascii_buf_bytes = 0;
-	compute_ascii();
 #ifdef CONFIG_PROC_FS
 	proc_root_mtrr =
 	    create_proc_entry("mtrr", S_IWUSR | S_IRUGO, &proc_root);
diff -burpN -X ../KDIFX linux-vanilla/arch/i386/kernel/cpu/mtrr/main.c linux/arch/i386/kernel/cpu/mtrr/main.c
--- linux-vanilla/arch/i386/kernel/cpu/mtrr/main.c	2002-10-19 06:01:09.000000000 +0200
+++ linux/arch/i386/kernel/cpu/mtrr/main.c	2002-11-27 11:43:26.000000000 +0100
@@ -36,7 +36,6 @@
 #include <linux/pci.h>
 #include <linux/smp.h>
 
-#define MTRR_NEED_STRINGS
 #include <asm/mtrr.h>
 
 #include <asm/uaccess.h>
@@ -54,6 +53,7 @@ static DECLARE_MUTEX(main_lock);
 u32 size_or_mask, size_and_mask;
 
 static struct mtrr_ops * mtrr_ops[X86_VENDOR_NUM] = {};
+
 struct mtrr_ops * mtrr_if = NULL;
 
 __initdata char *mtrr_if_name[] = {
@@ -125,14 +125,6 @@ static void init_table(void)
 	}
 	for (i = 0; i < max; i++)
 		usage_table[i] = 1;
-#ifdef USERSPACE_INTERFACE
-	if ((ascii_buffer = kmalloc(max * LINE_SIZE, GFP_KERNEL)) == NULL) {
-		printk("mtrr: could not allocate\n");
-		return;
-	}
-	ascii_buf_bytes = 0;
-	compute_ascii();
-#endif
 }
 
 struct set_mtrr_data {
@@ -163,7 +155,7 @@ static void ipi_handler(void *info)
 	}
 
 	/*  The master has cleared me to execute  */
-	if (data->smp_reg != ~0UL) 
+	if (data->smp_reg != ~0U) 
 		mtrr_if->set(data->smp_reg, data->smp_base, 
 			     data->smp_size, data->smp_type);
 	else
@@ -253,7 +245,7 @@ static void set_mtrr(unsigned int reg, u
 	 * to replicate across all the APs. 
 	 * If we're doing that @reg is set to something special...
 	 */
-	if (reg != ~0UL) 
+	if (reg != ~0U) 
 		mtrr_if->set(reg,base,size,type);
 
 	/* wait for the others */
@@ -361,7 +353,6 @@ int mtrr_add_page(unsigned long base, un
 		}
 		if (increment)
 			++usage_table[i];
-		compute_ascii();
 		error = i;
 		goto out;
 	}
@@ -370,7 +361,6 @@ int mtrr_add_page(unsigned long base, un
 	if (i >= 0) {
 		set_mtrr(i, base, size, type);
 		usage_table[i] = 1;
-		compute_ascii();
 	} else
 		printk("mtrr: no more MTRRs available\n");
 	error = i;
@@ -491,7 +481,6 @@ int mtrr_del_page(int reg, unsigned long
 	}
 	if (--usage_table[reg] < 1)
 		set_mtrr(reg, 0, 0, 0);
-	compute_ascii();
 	error = reg;
  out:
 	up(&main_lock);
@@ -547,7 +536,7 @@ static void init_other_cpus(void)
 		get_mtrr_state();
 
 	/* bring up the other processors */
-	set_mtrr(~0UL,0,0,0);
+	set_mtrr(~0U,0,0,0);
 
 	if (use_intel()) {
 		finalize_mtrr_state();
@@ -583,7 +572,7 @@ static int __init mtrr_init(void)
 			   query the width (in bits) of the physical
 			   addressable memory on the Hammer family.
 			 */
-			if (boot_cpu_data.x86 == 7
+			if (boot_cpu_data.x86 >= 7 
 			    && (cpuid_eax(0x80000000) >= 0x80000008)) {
 				u32 phys_addr;
 				phys_addr = cpuid_eax(0x80000008) & 0xff;
@@ -643,5 +632,16 @@ static int __init mtrr_init(void)
 	return mtrr_if ? -ENXIO : 0;
 }
 
+char *mtrr_strings[MTRR_NUM_TYPES] =
+{
+    "uncachable",               /* 0 */
+    "write-combining",          /* 1 */
+    "?",                        /* 2 */
+    "?",                        /* 3 */
+    "write-through",            /* 4 */
+    "write-protect",            /* 5 */
+    "write-back",               /* 6 */
+};
+
 core_initcall(mtrr_init);
 
diff -burpN -X ../KDIFX linux-vanilla/arch/i386/kernel/cpu/mtrr/mtrr.h linux/arch/i386/kernel/cpu/mtrr/mtrr.h
--- linux-vanilla/arch/i386/kernel/cpu/mtrr/mtrr.h	2002-10-19 06:01:18.000000000 +0200
+++ linux/arch/i386/kernel/cpu/mtrr/mtrr.h	2002-11-27 12:03:45.000000000 +0100
@@ -85,9 +85,6 @@ void get_mtrr_state(void);
 
 extern void set_mtrr_ops(struct mtrr_ops * ops);
 
-/* Don't even ask... */
-extern void compute_ascii(void);
-
 extern u32 size_or_mask, size_and_mask;
 extern struct mtrr_ops * mtrr_if;
 
diff -burpN -X ../KDIFX linux-vanilla/include/asm-i386/mtrr.h linux/include/asm-i386/mtrr.h
--- linux-vanilla/include/asm-i386/mtrr.h	2002-10-19 06:01:52.000000000 +0200
+++ linux/include/asm-i386/mtrr.h	2002-11-27 12:41:20.000000000 +0100
@@ -65,21 +65,10 @@ struct mtrr_gentry
 #define MTRR_TYPE_WRBACK     6
 #define MTRR_NUM_TYPES       7
 
-#ifdef MTRR_NEED_STRINGS
-static char *mtrr_strings[MTRR_NUM_TYPES] =
-{
-    "uncachable",               /* 0 */
-    "write-combining",          /* 1 */
-    "?",                        /* 2 */
-    "?",                        /* 3 */
-    "write-through",            /* 4 */
-    "write-protect",            /* 5 */
-    "write-back",               /* 6 */
-};
-#endif
-
 #ifdef __KERNEL__
 
+extern char *mtrr_strings[]; 
+
 /*  The following functions are for use by other drivers  */
 # ifdef CONFIG_MTRR
 extern int mtrr_add (unsigned long base, unsigned long size,
