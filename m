Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSLUA4U>; Fri, 20 Dec 2002 19:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSLUA4U>; Fri, 20 Dec 2002 19:56:20 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:26565 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261310AbSLUA4M>; Fri, 20 Dec 2002 19:56:12 -0500
Date: Sat, 21 Dec 2002 02:04:03 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Some i386 cleanups - MTRR, bootflag
Message-ID: <20021221010403.GA3922@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I decided to share some more code between i386 and x86-64. It is 
currently done using symlinks done by the x86-64 specific makefile. 
One of the candidates was the MTRR driver

This patch does:
- fix one warning in bootflag.c
- change a few longs to int and int to long in the MTRR driver 
to make it 64bit clean (should be a NOP for 32bit i386, but is needed
for x86-64)
- Convert the MTRR /proc interface to seq_file and remove
the broken compute_ascii() hack. This fixes some broken 
code e.g. the old mtrr_write was completely broken because
the loop checking for commands started with a "continue"
- remove duplicated mtrr type strings.

Patch for 2.5.52. Please consider applying.

-Andi

diff -burpN -X ../KDIFX linux-vanilla/arch/i386/kernel/bootflag.c linux/arch/i386/kernel/bootflag.c
--- linux-vanilla/arch/i386/kernel/bootflag.c	2002-10-19 06:02:27.000000000 +0200
+++ linux/arch/i386/kernel/bootflag.c	2002-12-21 02:46:02.000000000 +0100
@@ -48,7 +48,7 @@ static int __init sbf_struct_valid(unsig
 	unsigned int i;
 	struct sbf_boot sb;
 	
-	memcpy_fromio(&sb, tptr, sizeof(sb));
+	memcpy_fromio(&sb, (void *)tptr, sizeof(sb));
 
 	if(sb.sbf_len != 40 && sb.sbf_len != 39)
 		// 39 on IBM ThinkPad A21m, BIOS version 1.02b (KXET24WW; 2000-12-19).
diff -burpN -X ../KDIFX linux-vanilla/arch/i386/kernel/cpu/mtrr/amd.c linux/arch/i386/kernel/cpu/mtrr/amd.c
--- linux-vanilla/arch/i386/kernel/cpu/mtrr/amd.c	2002-10-19 06:01:55.000000000 +0200
+++ linux/arch/i386/kernel/cpu/mtrr/amd.c	2002-11-28 07:38:45.000000000 +0100
@@ -7,7 +7,7 @@
 
 static void
 amd_get_mtrr(unsigned int reg, unsigned long *base,
-	     unsigned long *size, mtrr_type * type)
+	     unsigned int *size, mtrr_type * type)
 {
 	unsigned long low, high;
 
diff -burpN -X ../KDIFX linux-vanilla/arch/i386/kernel/cpu/mtrr/centaur.c linux/arch/i386/kernel/cpu/mtrr/centaur.c
--- linux-vanilla/arch/i386/kernel/cpu/mtrr/centaur.c	2002-10-19 06:01:19.000000000 +0200
+++ linux/arch/i386/kernel/cpu/mtrr/centaur.c	2002-11-28 07:45:37.000000000 +0100
@@ -26,7 +26,8 @@ centaur_get_free_region(unsigned long ba
 {
 	int i, max;
 	mtrr_type ltype;
-	unsigned long lbase, lsize;
+	unsigned long lbase;
+	unsigned int lsize;
 
 	max = num_var_ranges;
 	for (i = 0; i < max; ++i) {
@@ -48,7 +49,7 @@ mtrr_centaur_report_mcr(int mcr, u32 lo,
 
 static void
 centaur_get_mcr(unsigned int reg, unsigned long *base,
-		unsigned long *size, mtrr_type * type)
+		unsigned int *size, mtrr_type * type)
 {
 	*base = centaur_mcr[reg].high >> PAGE_SHIFT;
 	*size = -(centaur_mcr[reg].low & 0xfffff000) >> PAGE_SHIFT;
diff -burpN -X ../KDIFX linux-vanilla/arch/i386/kernel/cpu/mtrr/cyrix.c linux/arch/i386/kernel/cpu/mtrr/cyrix.c
--- linux-vanilla/arch/i386/kernel/cpu/mtrr/cyrix.c	2002-10-19 06:01:56.000000000 +0200
+++ linux/arch/i386/kernel/cpu/mtrr/cyrix.c	2002-11-28 07:41:50.000000000 +0100
@@ -9,7 +9,7 @@ int arr3_protected;
 
 static void
 cyrix_get_arr(unsigned int reg, unsigned long *base,
-	      unsigned long *size, mtrr_type * type)
+	      unsigned int *size, mtrr_type * type)
 {
 	unsigned long flags;
 	unsigned char arr, ccr3, rcr, shift;
@@ -86,7 +86,8 @@ cyrix_get_free_region(unsigned long base
 {
 	int i;
 	mtrr_type ltype;
-	unsigned long lbase, lsize;
+	unsigned long lbase;
+	unsigned int  lsize;
 
 	/* If we are to set up a region >32M then look at ARR7 immediately */
 	if (size > 0x2000) {
@@ -213,7 +214,7 @@ static void cyrix_set_arr(unsigned int r
 
 typedef struct {
 	unsigned long base;
-	unsigned long size;
+	unsigned int size;
 	mtrr_type type;
 } arr_state_t;
 
diff -burpN -X ../KDIFX linux-vanilla/arch/i386/kernel/cpu/mtrr/generic.c linux/arch/i386/kernel/cpu/mtrr/generic.c
--- linux-vanilla/arch/i386/kernel/cpu/mtrr/generic.c	2002-11-13 12:07:27.000000000 +0100
+++ linux/arch/i386/kernel/cpu/mtrr/generic.c	2002-11-28 07:45:24.000000000 +0100
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
@@ -102,7 +104,8 @@ int generic_get_free_region(unsigned lon
 {
 	int i, max;
 	mtrr_type ltype;
-	unsigned long lbase, lsize;
+	unsigned long lbase;
+	unsigned lsize;
 
 	max = num_var_ranges;
 	for (i = 0; i < max; ++i) {
@@ -113,11 +116,10 @@ int generic_get_free_region(unsigned lon
 	return -ENOSPC;
 }
 
-
 void generic_get_mtrr(unsigned int reg, unsigned long *base,
-		      unsigned long *size, mtrr_type * type)
+		      unsigned int *size, mtrr_type * type)
 {
-	unsigned long mask_lo, mask_hi, base_lo, base_hi;
+	unsigned int mask_lo, mask_hi, base_lo, base_hi;
 
 	rdmsr(MTRRphysMask_MSR(reg), mask_lo, mask_hi);
 	if ((mask_lo & 0x800) == 0) {
@@ -143,10 +145,10 @@ void generic_get_mtrr(unsigned int reg, 
 
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
@@ -228,13 +230,13 @@ static unsigned long set_mtrr_state(u32 
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
+++ linux/arch/i386/kernel/cpu/mtrr/if.c	2002-11-28 07:43:51.000000000 +0100
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
@@ -329,14 +331,15 @@ char * attrib_to_str(int x)
 	return (x <= 6) ? mtrr_strings[x] : "?";
 }
 
-void compute_ascii(void)
+static int mtrr_seq_show(struct seq_file *seq, void *offset)
 {
 	char factor;
-	int i, max;
+	int i, max, len;
 	mtrr_type type;
-	unsigned long base, size;
+	unsigned long base;
+	unsigned int size;
 
-	ascii_buf_bytes = 0;
+	len = 0;
 	max = num_var_ranges;
 	for (i = 0; i < max; i++) {
 		mtrr_if->get(i, &base, &size, &type);
@@ -351,32 +354,19 @@ void compute_ascii(void)
 				factor = 'M';
 				size >>= 20 - PAGE_SHIFT;
 			}
-			sprintf
-			    (ascii_buffer + ascii_buf_bytes,
-			     "reg%02i: base=0x%05lx000 (%4liMB), size=%4li%cB: %s, count=%d\n",
+			/* RED-PEN: base can be > 32bit */ 
+			len += seq_printf(seq, 
+				   "reg%02i: base=0x%05lx000 (%4liMB), size=%4i%cB: %s, count=%d\n",
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
+++ linux/arch/i386/kernel/cpu/mtrr/main.c	2002-11-28 07:40:22.000000000 +0100
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
@@ -306,7 +298,8 @@ int mtrr_add_page(unsigned long base, un
 {
 	int i;
 	mtrr_type ltype;
-	unsigned long lbase, lsize;
+	unsigned long lbase;
+	unsigned int lsize;
 	int error;
 
 	if (!mtrr_if)
@@ -346,7 +339,7 @@ int mtrr_add_page(unsigned long base, un
 		if ((base < lbase) || (base + size > lbase + lsize)) {
 			printk(KERN_WARNING
 			       "mtrr: 0x%lx000,0x%lx000 overlaps existing"
-			       " 0x%lx000,0x%lx000\n", base, size, lbase,
+			       " 0x%lx000,0x%x000\n", base, size, lbase,
 			       lsize);
 			goto out;
 		}
@@ -361,7 +354,6 @@ int mtrr_add_page(unsigned long base, un
 		}
 		if (increment)
 			++usage_table[i];
-		compute_ascii();
 		error = i;
 		goto out;
 	}
@@ -370,7 +362,6 @@ int mtrr_add_page(unsigned long base, un
 	if (i >= 0) {
 		set_mtrr(i, base, size, type);
 		usage_table[i] = 1;
-		compute_ascii();
 	} else
 		printk("mtrr: no more MTRRs available\n");
 	error = i;
@@ -447,7 +438,8 @@ int mtrr_del_page(int reg, unsigned long
 {
 	int i, max;
 	mtrr_type ltype;
-	unsigned long lbase, lsize;
+	unsigned long lbase;
+	unsigned int lsize;
 	int error = -EINVAL;
 
 	if (!mtrr_if)
@@ -491,7 +483,6 @@ int mtrr_del_page(int reg, unsigned long
 	}
 	if (--usage_table[reg] < 1)
 		set_mtrr(reg, 0, 0, 0);
-	compute_ascii();
 	error = reg;
  out:
 	up(&main_lock);
@@ -547,7 +538,7 @@ static void init_other_cpus(void)
 		get_mtrr_state();
 
 	/* bring up the other processors */
-	set_mtrr(~0UL,0,0,0);
+	set_mtrr(~0U,0,0,0);
 
 	if (use_intel()) {
 		finalize_mtrr_state();
@@ -583,7 +574,7 @@ static int __init mtrr_init(void)
 			   query the width (in bits) of the physical
 			   addressable memory on the Hammer family.
 			 */
-			if (boot_cpu_data.x86 == 7
+			if (boot_cpu_data.x86 >= 7 
 			    && (cpuid_eax(0x80000000) >= 0x80000008)) {
 				u32 phys_addr;
 				phys_addr = cpuid_eax(0x80000008) & 0xff;
@@ -643,5 +634,16 @@ static int __init mtrr_init(void)
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
+++ linux/arch/i386/kernel/cpu/mtrr/mtrr.h	2002-11-28 07:37:22.000000000 +0100
@@ -43,7 +43,7 @@ struct mtrr_ops {
 	void	(*set_all)(void);
 
 	void	(*get)(unsigned int reg, unsigned long *base,
-		       unsigned long *size, mtrr_type * type);
+		       unsigned int *size, mtrr_type * type);
 	int	(*get_free_region) (unsigned long base, unsigned long size);
 
 	int	(*validate_add_page)(unsigned long base, unsigned long size,
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
@@ -31,7 +31,7 @@
 struct mtrr_sentry
 {
     unsigned long base;    /*  Base address     */
-    unsigned long size;    /*  Size of region   */
+    unsigned int size;    /*  Size of region   */
     unsigned int type;     /*  Type of region   */
 };
 
@@ -39,7 +39,7 @@ struct mtrr_gentry
 {
     unsigned int regnum;   /*  Register number  */
     unsigned long base;    /*  Base address     */
-    unsigned long size;    /*  Size of region   */
+    unsigned int size;    /*  Size of region   */
     unsigned int type;     /*  Type of region   */
 };
 
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



