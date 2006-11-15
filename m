Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030550AbWKOPP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbWKOPP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWKOPP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:15:59 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:44187
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030550AbWKOPP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:15:58 -0500
Message-Id: <455B3D8B.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 15 Nov 2006 15:17:15 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: fix MTRR code
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While after a previous submission (about one and a half year ago) I got
told that the MTRR code is to be replaced by PAT use, this hasn't
happened. Hence I'd like to ask to reconsider this patch until PAT
handling code shows up.

Until not so long ago, there were system log messages pointing to
inconsistent MTRR setup of the video frame buffer caused by the way vesafb
and X worked. While vesafb was fixed meanwhile, I believe fixing it there
only hides a shortcoming in the MTRR code itself, in that that code is not
symmetric with respect to the ordering of attempts to set up two (or more)
regions where one contains the other. In the current shape, it permits
only setting up sub-regions of pre-exisiting ones. The patch below makes
this symmetric.

While working on that I noticed a few more inconsistencies in that code,
namely
- use of 'unsigned int' for sizes in many, but not all places (the patch
  is converting this to use 'unsigned long' everywhere, which specifically
  might be necessary for x86-64 once a processor supporting more than 44
  physical address bits would become available)
- the code to correct inconsistent settings during secondary processor
  startup tried (if necessary) to correct, among other things, the value
  in IA32_MTRR_DEF_TYPE, however the newly computed value would never get
  used (i.e. stored in the respective MSR)
- the generic range validation code checked that the end of the
  to-be-added range would be above 1MB; the value checked should have been
  the start of the range
- when contained regions are detected, previously this was allowed only
  when the old region was uncacheable; this can be symmetric (i.e. the new
  region can also be uncacheable) and even further as per Intel's
  documentation write-trough and write-back for either region is also
  compatible with the respective opposite in the other

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc5/arch/i386/kernel/cpu/mtrr/amd.c	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-x86-mtrr/arch/i386/kernel/cpu/mtrr/amd.c	2006-11-06 09:10:39.000000000 +0100
@@ -7,7 +7,7 @@
 
 static void
 amd_get_mtrr(unsigned int reg, unsigned long *base,
-	     unsigned int *size, mtrr_type * type)
+	     unsigned long *size, mtrr_type * type)
 {
 	unsigned long low, high;
 
--- linux-2.6.19-rc5/arch/i386/kernel/cpu/mtrr/centaur.c	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-x86-mtrr/arch/i386/kernel/cpu/mtrr/centaur.c	2006-11-06 09:10:39.000000000 +0100
@@ -17,7 +17,7 @@ static u8 centaur_mcr_type;	/* 0 for win
  */
 
 static int
-centaur_get_free_region(unsigned long base, unsigned long size)
+centaur_get_free_region(unsigned long base, unsigned long size, int replace_reg)
 /*  [SUMMARY] Get a free MTRR.
     <base> The starting (base) address of the region.
     <size> The size (in bytes) of the region.
@@ -26,10 +26,11 @@ centaur_get_free_region(unsigned long ba
 {
 	int i, max;
 	mtrr_type ltype;
-	unsigned long lbase;
-	unsigned int lsize;
+	unsigned long lbase, lsize;
 
 	max = num_var_ranges;
+	if (replace_reg >= 0 && replace_reg < max)
+		return replace_reg;
 	for (i = 0; i < max; ++i) {
 		if (centaur_mcr_reserved & (1 << i))
 			continue;
@@ -49,7 +50,7 @@ mtrr_centaur_report_mcr(int mcr, u32 lo,
 
 static void
 centaur_get_mcr(unsigned int reg, unsigned long *base,
-		unsigned int *size, mtrr_type * type)
+		unsigned long *size, mtrr_type * type)
 {
 	*base = centaur_mcr[reg].high >> PAGE_SHIFT;
 	*size = -(centaur_mcr[reg].low & 0xfffff000) >> PAGE_SHIFT;
--- linux-2.6.19-rc5/arch/i386/kernel/cpu/mtrr/cyrix.c	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-x86-mtrr/arch/i386/kernel/cpu/mtrr/cyrix.c	2006-11-06 09:10:39.000000000 +0100
@@ -9,7 +9,7 @@ int arr3_protected;
 
 static void
 cyrix_get_arr(unsigned int reg, unsigned long *base,
-	      unsigned int *size, mtrr_type * type)
+	      unsigned long *size, mtrr_type * type)
 {
 	unsigned long flags;
 	unsigned char arr, ccr3, rcr, shift;
@@ -77,7 +77,7 @@ cyrix_get_arr(unsigned int reg, unsigned
 }
 
 static int
-cyrix_get_free_region(unsigned long base, unsigned long size)
+cyrix_get_free_region(unsigned long base, unsigned long size, int replace_reg)
 /*  [SUMMARY] Get a free ARR.
     <base> The starting (base) address of the region.
     <size> The size (in bytes) of the region.
@@ -86,9 +86,24 @@ cyrix_get_free_region(unsigned long base
 {
 	int i;
 	mtrr_type ltype;
-	unsigned long lbase;
-	unsigned int  lsize;
+	unsigned long lbase, lsize;
 
+	switch (replace_reg) {
+	case 7:
+		if (size < 0x40)
+			break;
+	case 6:
+	case 5:
+	case 4:
+		return replace_reg;
+	case 3:
+		if (arr3_protected)
+			break;
+	case 2:
+	case 1:
+	case 0:
+		return replace_reg;
+	}
 	/* If we are to set up a region >32M then look at ARR7 immediately */
 	if (size > 0x2000) {
 		cyrix_get_arr(7, &lbase, &lsize, &ltype);
@@ -214,7 +229,7 @@ static void cyrix_set_arr(unsigned int r
 
 typedef struct {
 	unsigned long base;
-	unsigned int size;
+	unsigned long size;
 	mtrr_type type;
 } arr_state_t;
 
--- linux-2.6.19-rc5/arch/i386/kernel/cpu/mtrr/generic.c	2006-11-08 09:21:37.000000000 +0100
+++ 2.6.19-rc5-x86-mtrr/arch/i386/kernel/cpu/mtrr/generic.c	2006-11-06 09:10:39.000000000 +0100
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <asm/io.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
@@ -15,12 +16,19 @@ struct mtrr_state {
 	struct mtrr_var_range *var_ranges;
 	mtrr_type fixed_ranges[NUM_FIXED_RANGES];
 	unsigned char enabled;
+	unsigned char have_fixed;
 	mtrr_type def_type;
 };
 
 static unsigned long smp_changes_mask;
 static struct mtrr_state mtrr_state = {};
 
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "mtrr."
+
+static __initdata int mtrr_show;
+module_param_named(show, mtrr_show, bool, 0);
+
 /*  Get the MSR pair relating to a var range  */
 static void __init
 get_mtrr_var_range(unsigned int index, struct mtrr_var_range *vr)
@@ -43,6 +51,14 @@ get_fixed_ranges(mtrr_type * frs)
 		rdmsr(MTRRfix4K_C0000_MSR + i, p[6 + i * 2], p[7 + i * 2]);
 }
 
+static void __init print_fixed(unsigned base, unsigned step, const mtrr_type*types)
+{
+	unsigned i;
+
+	for (i = 0; i < 8; ++i, ++types, base += step)
+		printk(KERN_INFO "MTRR %05X-%05X %s\n", base, base + step - 1, mtrr_attrib_to_str(*types));
+}
+
 /*  Grab all of the MTRR state for this CPU into *state  */
 void __init get_mtrr_state(void)
 {
@@ -58,13 +74,49 @@ void __init get_mtrr_state(void)
 	} 
 	vrs = mtrr_state.var_ranges;
 
+	rdmsr(MTRRcap_MSR, lo, dummy);
+	mtrr_state.have_fixed = (lo >> 8) & 1;
+
 	for (i = 0; i < num_var_ranges; i++)
 		get_mtrr_var_range(i, &vrs[i]);
-	get_fixed_ranges(mtrr_state.fixed_ranges);
+	if (mtrr_state.have_fixed)
+		get_fixed_ranges(mtrr_state.fixed_ranges);
 
 	rdmsr(MTRRdefType_MSR, lo, dummy);
 	mtrr_state.def_type = (lo & 0xff);
 	mtrr_state.enabled = (lo & 0xc00) >> 10;
+
+	if (mtrr_show) {
+		int high_width;
+
+		printk(KERN_INFO "MTRR default type: %s\n", mtrr_attrib_to_str(mtrr_state.def_type));
+		if (mtrr_state.have_fixed) {
+			printk(KERN_INFO "MTRR fixed ranges %sabled:\n",
+			       mtrr_state.enabled & 1 ? "en" : "dis");
+			print_fixed(0x00000, 0x10000, mtrr_state.fixed_ranges + 0);
+			for (i = 0; i < 2; ++i)
+				print_fixed(0x80000 + i * 0x20000, 0x04000, mtrr_state.fixed_ranges + (i + 1) * 8);
+			for (i = 0; i < 8; ++i)
+				print_fixed(0xC0000 + i * 0x08000, 0x01000, mtrr_state.fixed_ranges + (i + 3) * 8);
+		}
+		printk(KERN_INFO "MTRR variable ranges %sabled:\n",
+		       mtrr_state.enabled & 2 ? "en" : "dis");
+		high_width = ((size_or_mask ? ffs(size_or_mask) - 1 : 32) - (32 - PAGE_SHIFT) + 3) / 4;
+		for (i = 0; i < num_var_ranges; ++i) {
+			if (mtrr_state.var_ranges[i].mask_lo & (1 << 11))
+				printk(KERN_INFO "MTRR %u base %0*X%05X000 mask %0*X%05X000 %s\n",
+				       i,
+				       high_width,
+				       mtrr_state.var_ranges[i].base_hi,
+				       mtrr_state.var_ranges[i].base_lo >> 12,
+				       high_width,
+				       mtrr_state.var_ranges[i].mask_hi,
+				       mtrr_state.var_ranges[i].mask_lo >> 12,
+				       mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo & 0xff));
+			else
+				printk(KERN_INFO "MTRR %u disabled\n", i);
+		}
+	}
 }
 
 /*  Some BIOS's are fucked and don't set all MTRRs the same!  */
@@ -95,7 +147,7 @@ void mtrr_wrmsr(unsigned msr, unsigned a
 			smp_processor_id(), msr, a, b);
 }
 
-int generic_get_free_region(unsigned long base, unsigned long size)
+int generic_get_free_region(unsigned long base, unsigned long size, int replace_reg)
 /*  [SUMMARY] Get a free MTRR.
     <base> The starting (base) address of the region.
     <size> The size (in bytes) of the region.
@@ -104,10 +156,11 @@ int generic_get_free_region(unsigned lon
 {
 	int i, max;
 	mtrr_type ltype;
-	unsigned long lbase;
-	unsigned lsize;
+	unsigned long lbase, lsize;
 
 	max = num_var_ranges;
+	if (replace_reg >= 0 && replace_reg < max)
+		return replace_reg;
 	for (i = 0; i < max; ++i) {
 		mtrr_if->get(i, &lbase, &lsize, &ltype);
 		if (lsize == 0)
@@ -117,7 +170,7 @@ int generic_get_free_region(unsigned lon
 }
 
 static void generic_get_mtrr(unsigned int reg, unsigned long *base,
-			     unsigned int *size, mtrr_type * type)
+			     unsigned long *size, mtrr_type *type)
 {
 	unsigned int mask_lo, mask_hi, base_lo, base_hi;
 
@@ -202,7 +255,9 @@ static int set_mtrr_var_ranges(unsigned 
 	return changed;
 }
 
-static unsigned long set_mtrr_state(u32 deftype_lo, u32 deftype_hi)
+static u32 deftype_lo, deftype_hi;
+
+static unsigned long set_mtrr_state(void)
 /*  [SUMMARY] Set the MTRR state for this CPU.
     <state> The MTRR state information to read.
     <ctxt> Some relevant CPU context.
@@ -217,14 +272,14 @@ static unsigned long set_mtrr_state(u32 
 		if (set_mtrr_var_ranges(i, &mtrr_state.var_ranges[i]))
 			change_mask |= MTRR_CHANGE_MASK_VARIABLE;
 
-	if (set_fixed_ranges(mtrr_state.fixed_ranges))
+	if (mtrr_state.have_fixed && set_fixed_ranges(mtrr_state.fixed_ranges))
 		change_mask |= MTRR_CHANGE_MASK_FIXED;
 
 	/*  Set_mtrr_restore restores the old value of MTRRdefType,
 	   so to set it we fiddle with the saved value  */
 	if ((deftype_lo & 0xff) != mtrr_state.def_type
 	    || ((deftype_lo & 0xc00) >> 10) != mtrr_state.enabled) {
-		deftype_lo |= (mtrr_state.def_type | mtrr_state.enabled << 10);
+		deftype_lo = (deftype_lo & ~0xcff) | mtrr_state.def_type | (mtrr_state.enabled << 10);
 		change_mask |= MTRR_CHANGE_MASK_DEFTYPE;
 	}
 
@@ -233,7 +288,6 @@ static unsigned long set_mtrr_state(u32 
 
 
 static unsigned long cr4 = 0;
-static u32 deftype_lo, deftype_hi;
 static DEFINE_SPINLOCK(set_atomicity_lock);
 
 /*
@@ -271,7 +325,7 @@ static void prepare_set(void) __acquires
 	rdmsr(MTRRdefType_MSR, deftype_lo, deftype_hi);
 
 	/*  Disable MTRRs, and set the default type to uncached  */
-	mtrr_wrmsr(MTRRdefType_MSR, deftype_lo & 0xf300UL, deftype_hi);
+	mtrr_wrmsr(MTRRdefType_MSR, deftype_lo & ~0xcff, deftype_hi);
 }
 
 static void post_set(void) __releases(set_atomicity_lock)
@@ -300,7 +354,7 @@ static void generic_set_all(void)
 	prepare_set();
 
 	/* Actually set the state */
-	mask = set_mtrr_state(deftype_lo,deftype_hi);
+	mask = set_mtrr_state();
 
 	post_set();
 	local_irq_restore(flags);
@@ -374,7 +428,7 @@ int generic_validate_add_page(unsigned l
 		}
 	}
 
-	if (base + size < 0x100) {
+	if (base < 0x100) {
 		printk(KERN_WARNING "mtrr: cannot set region below 1 MiB (0x%lx000,0x%lx000)\n",
 		       base, size);
 		return -EINVAL;
--- linux-2.6.19-rc5/arch/i386/kernel/cpu/mtrr/if.c	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-x86-mtrr/arch/i386/kernel/cpu/mtrr/if.c	2006-11-06 09:10:39.000000000 +0100
@@ -17,7 +17,7 @@ extern unsigned int *usage_table;
 
 #define FILE_FCOUNT(f) (((struct seq_file *)((f)->private_data))->private)
 
-static char *mtrr_strings[MTRR_NUM_TYPES] =
+static const char *const mtrr_strings[MTRR_NUM_TYPES] =
 {
     "uncachable",               /* 0 */
     "write-combining",          /* 1 */
@@ -28,7 +28,7 @@ static char *mtrr_strings[MTRR_NUM_TYPES
     "write-back",               /* 6 */
 };
 
-char *mtrr_attrib_to_str(int x)
+const char *mtrr_attrib_to_str(int x)
 {
 	return (x <= 6) ? mtrr_strings[x] : "?";
 }
@@ -155,6 +155,7 @@ mtrr_ioctl(struct file *file, unsigned i
 {
 	int err = 0;
 	mtrr_type type;
+	unsigned long size;
 	struct mtrr_sentry sentry;
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
@@ -235,15 +236,15 @@ mtrr_ioctl(struct file *file, unsigned i
 	case MTRRIOC_GET_ENTRY:
 		if (gentry.regnum >= num_var_ranges)
 			return -EINVAL;
-		mtrr_if->get(gentry.regnum, &gentry.base, &gentry.size, &type);
+		mtrr_if->get(gentry.regnum, &gentry.base, &size, &type);
 
 		/* Hide entries that go above 4GB */
-		if (gentry.base + gentry.size > 0x100000
-		    || gentry.size == 0x100000)
+		if (gentry.base + size - 1 >= (1UL << (8 * sizeof(gentry.size) - PAGE_SHIFT))
+		    || size >= (1UL << (8 * sizeof(gentry.size) - PAGE_SHIFT)))
 			gentry.base = gentry.size = gentry.type = 0;
 		else {
 			gentry.base <<= PAGE_SHIFT;
-			gentry.size <<= PAGE_SHIFT;
+			gentry.size = size << PAGE_SHIFT;
 			gentry.type = type;
 		}
 
@@ -273,8 +274,14 @@ mtrr_ioctl(struct file *file, unsigned i
 	case MTRRIOC_GET_PAGE_ENTRY:
 		if (gentry.regnum >= num_var_ranges)
 			return -EINVAL;
-		mtrr_if->get(gentry.regnum, &gentry.base, &gentry.size, &type);
-		gentry.type = type;
+		mtrr_if->get(gentry.regnum, &gentry.base, &size, &type);
+		/* Hide entries that would overflow */
+		if (size != (__typeof__(gentry.size))size)
+			gentry.base = gentry.size = gentry.type = 0;
+		else {
+			gentry.size = size;
+			gentry.type = type;
+		}
 		break;
 	}
 
@@ -353,8 +360,7 @@ static int mtrr_seq_show(struct seq_file
 	char factor;
 	int i, max, len;
 	mtrr_type type;
-	unsigned long base;
-	unsigned int size;
+	unsigned long base, size;
 
 	len = 0;
 	max = num_var_ranges;
@@ -373,7 +379,7 @@ static int mtrr_seq_show(struct seq_file
 			}
 			/* RED-PEN: base can be > 32bit */ 
 			len += seq_printf(seq, 
-				   "reg%02i: base=0x%05lx000 (%4liMB), size=%4i%cB: %s, count=%d\n",
+				   "reg%02i: base=0x%05lx000 (%4luMB), size=%4lu%cB: %s, count=%d\n",
 			     i, base, base >> (20 - PAGE_SHIFT), size, factor,
 			     mtrr_attrib_to_str(type), usage_table[i]);
 		}
--- linux-2.6.19-rc5/arch/i386/kernel/cpu/mtrr/main.c	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-x86-mtrr/arch/i386/kernel/cpu/mtrr/main.c	2006-11-10 08:56:35.000000000 +0100
@@ -168,6 +168,13 @@ static void ipi_handler(void *info)
 
 #endif
 
+static inline int types_compatible(mtrr_type type1, mtrr_type type2) {
+	return type1 == MTRR_TYPE_UNCACHABLE ||
+	       type2 == MTRR_TYPE_UNCACHABLE ||
+	       (type1 == MTRR_TYPE_WRTHROUGH && type2 == MTRR_TYPE_WRBACK) ||
+	       (type1 == MTRR_TYPE_WRBACK && type2 == MTRR_TYPE_WRTHROUGH);
+}
+
 /**
  * set_mtrr - update mtrrs on all processors
  * @reg:	mtrr in question
@@ -300,11 +307,9 @@ static void set_mtrr(unsigned int reg, u
 int mtrr_add_page(unsigned long base, unsigned long size, 
 		  unsigned int type, char increment)
 {
-	int i;
+	int i, replace, error;
 	mtrr_type ltype;
-	unsigned long lbase;
-	unsigned int lsize;
-	int error;
+	unsigned long lbase, lsize;
 
 	if (!mtrr_if)
 		return -ENXIO;
@@ -324,12 +329,18 @@ int mtrr_add_page(unsigned long base, un
 		return -ENOSYS;
 	}
 
+	if (!size) {
+		printk(KERN_WARNING "mtrr: zero sized request\n");
+		return -EINVAL;
+	}
+
 	if (base & size_or_mask || size & size_or_mask) {
 		printk(KERN_WARNING "mtrr: base or size exceeds the MTRR width\n");
 		return -EINVAL;
 	}
 
 	error = -EINVAL;
+	replace = -1;
 
 	/* No CPU hotplug when we change MTRR entries */
 	lock_cpu_hotplug();
@@ -337,21 +348,28 @@ int mtrr_add_page(unsigned long base, un
 	mutex_lock(&mtrr_mutex);
 	for (i = 0; i < num_var_ranges; ++i) {
 		mtrr_if->get(i, &lbase, &lsize, &ltype);
-		if (base >= lbase + lsize)
-			continue;
-		if ((base < lbase) && (base + size <= lbase))
+		if (!lsize || base > lbase + lsize - 1 || base + size - 1 < lbase)
 			continue;
 		/*  At this point we know there is some kind of overlap/enclosure  */
-		if ((base < lbase) || (base + size > lbase + lsize)) {
+		if (base < lbase || base + size - 1 > lbase + lsize - 1) {
+			if (base <= lbase && base + size - 1 >= lbase + lsize - 1) {
+				/*  New region encloses an existing region  */
+				if (type == ltype) {
+					replace = replace == -1 ? i : -2;
+					continue;
+				}
+				else if (types_compatible(type, ltype))
+					continue;
+			}
 			printk(KERN_WARNING
 			       "mtrr: 0x%lx000,0x%lx000 overlaps existing"
-			       " 0x%lx000,0x%x000\n", base, size, lbase,
+			       " 0x%lx000,0x%lx000\n", base, size, lbase,
 			       lsize);
 			goto out;
 		}
 		/*  New region is enclosed by an existing region  */
 		if (ltype != type) {
-			if (type == MTRR_TYPE_UNCACHABLE)
+			if (types_compatible(type, ltype))
 				continue;
 			printk (KERN_WARNING "mtrr: type mismatch for %lx000,%lx000 old: %s new: %s\n",
 			     base, size, mtrr_attrib_to_str(ltype),
@@ -364,10 +382,18 @@ int mtrr_add_page(unsigned long base, un
 		goto out;
 	}
 	/*  Search for an empty MTRR  */
-	i = mtrr_if->get_free_region(base, size);
+	i = mtrr_if->get_free_region(base, size, replace);
 	if (i >= 0) {
 		set_mtrr(i, base, size, type);
-		usage_table[i] = 1;
+		if (likely(replace < 0))
+			usage_table[i] = 1;
+		else {
+			usage_table[i] = usage_table[replace] + !!increment;
+			if (unlikely(replace != i)) {
+				set_mtrr(replace, 0, 0, 0);
+				usage_table[replace] = 0;
+			}
+		}
 	} else
 		printk(KERN_INFO "mtrr: no more MTRRs available\n");
 	error = i;
@@ -455,8 +481,7 @@ int mtrr_del_page(int reg, unsigned long
 {
 	int i, max;
 	mtrr_type ltype;
-	unsigned long lbase;
-	unsigned int lsize;
+	unsigned long lbase, lsize;
 	int error = -EINVAL;
 
 	if (!mtrr_if)
@@ -555,7 +580,7 @@ static void __init init_ifs(void)
 struct mtrr_value {
 	mtrr_type	ltype;
 	unsigned long	lbase;
-	unsigned int	lsize;
+	unsigned long	lsize;
 };
 
 static struct mtrr_value * mtrr_state;
--- linux-2.6.19-rc5/arch/i386/kernel/cpu/mtrr/mtrr.h	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-x86-mtrr/arch/i386/kernel/cpu/mtrr/mtrr.h	2006-11-06 09:10:39.000000000 +0100
@@ -43,15 +43,16 @@ struct mtrr_ops {
 	void	(*set_all)(void);
 
 	void	(*get)(unsigned int reg, unsigned long *base,
-		       unsigned int *size, mtrr_type * type);
-	int	(*get_free_region) (unsigned long base, unsigned long size);
-
+		       unsigned long *size, mtrr_type * type);
+	int	(*get_free_region)(unsigned long base, unsigned long size,
+				   int replace_reg);
 	int	(*validate_add_page)(unsigned long base, unsigned long size,
 				     unsigned int type);
 	int	(*have_wrcomb)(void);
 };
 
-extern int generic_get_free_region(unsigned long base, unsigned long size);
+extern int generic_get_free_region(unsigned long base, unsigned long size,
+				   int replace_reg);
 extern int generic_validate_add_page(unsigned long base, unsigned long size,
 				     unsigned int type);
 
@@ -62,17 +63,17 @@ extern int positive_have_wrcomb(void);
 /* library functions for processor-specific routines */
 struct set_mtrr_context {
 	unsigned long flags;
-	unsigned long deftype_lo;
-	unsigned long deftype_hi;
 	unsigned long cr4val;
-	unsigned long ccr3;
+	u32 deftype_lo;
+	u32 deftype_hi;
+	u32 ccr3;
 };
 
 struct mtrr_var_range {
-	unsigned long base_lo;
-	unsigned long base_hi;
-	unsigned long mask_lo;
-	unsigned long mask_hi;
+	u32 base_lo;
+	u32 base_hi;
+	u32 mask_lo;
+	u32 mask_hi;
 };
 
 void set_mtrr_done(struct set_mtrr_context *ctxt);
@@ -92,6 +93,6 @@ extern struct mtrr_ops * mtrr_if;
 extern unsigned int num_var_ranges;
 
 void mtrr_state_warn(void);
-char *mtrr_attrib_to_str(int x);
+const char *mtrr_attrib_to_str(int x);
 void mtrr_wrmsr(unsigned, unsigned, unsigned);
 


