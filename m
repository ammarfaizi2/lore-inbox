Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbUKLPIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbUKLPIj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 10:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbUKLPIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 10:08:39 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:43875
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S262546AbUKLPHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 10:07:04 -0500
Message-Id: <s194d196.052@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Fri, 12 Nov 2004 16:07:52 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC] x86 mtrr handling
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartB4946CD8.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartB4946CD8.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Appearantly I am not the first one to observe and be puzzled about log
messages pointing to inconsistent MTRR setup of the video frame buffer;
a patch to address this at the consumer end of the MTRR code (in vesafb)
was posted by Kurt Garloff a while ago, but appearantly wasn't applied,
yet.

Regardless of whether that patch would be applied, and regardless of
considering it correct, I believe that it only hides a shortcoming in
the MTRR code itself, in that that code is not symmetric with respect to
the ordering of attempts to set up two (or more) regions where one
contains the other. In the current shape, it permits only setting up
sub-regions of pre-exisiting ones. The patch below makes this
symmetric.

While working on that I noticed a few more inconsistencies in that
code, namely
- use of 'unsigned int' for sizes in many, but not all places (the
patch is converting this to use 'unsigned long' everywhere, which
specifically might be necessary for x86-64 once a processor supporting
more than 44 physical address bits would become available)
- the code to correct inconsistent settings during secondary processor
startup tried (if necessary) to correct, among other things, the value
in IA32_MTRR_DEF_TYPE, however the newly compute value would never get
used to be stored in the respective MSR
- the generic range validation code checked that the end of the
to-be-added range would be above 1MB; the value checked should have been
the start of the range
- when contained regions are detected, previously this was allowed only
when the old region was uncacheable; this can be symmetric (i.e. the new
region can also be uncacheable) and even further as per Intel's
documentation write-trough and write-back for either region is also
compatible with the respective opposite in the other

Thanks, Jan

diff -apru linux-2.6.9/arch/i386/kernel/cpu/mtrr/amd.c
linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/amd.c
--- linux-2.6.9/arch/i386/kernel/cpu/mtrr/amd.c	2004-10-18
23:54:29.000000000 +0200
+++ linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/amd.c	2004-11-12
15:41:38.213655912 +0100
@@ -7,7 +7,7 @@
 
 static void
 amd_get_mtrr(unsigned int reg, unsigned long *base,
-	     unsigned int *size, mtrr_type * type)
+	     unsigned long *size, mtrr_type * type)
 {
 	unsigned long low, high;
 
diff -apru linux-2.6.9/arch/i386/kernel/cpu/mtrr/centaur.c
linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/centaur.c
--- linux-2.6.9/arch/i386/kernel/cpu/mtrr/centaur.c	2004-10-18
23:53:45.000000000 +0200
+++
linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/centaur.c	2004-11-12
15:41:38.229653480 +0100
@@ -17,7 +17,7 @@ static u8 centaur_mcr_type;	/* 0 for win
  */
 
 static int
-centaur_get_free_region(unsigned long base, unsigned long size)
+centaur_get_free_region(unsigned long base, unsigned long size, int
replace_reg)
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
diff -apru linux-2.6.9/arch/i386/kernel/cpu/mtrr/cyrix.c
linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/cyrix.c
--- linux-2.6.9/arch/i386/kernel/cpu/mtrr/cyrix.c	2004-10-18
23:54:31.000000000 +0200
+++ linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/cyrix.c	2004-11-12
15:41:38.232653024 +0100
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
+cyrix_get_free_region(unsigned long base, unsigned long size, int
replace_reg)
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
 	/* If we are to set up a region >32M then look at ARR7
immediately */
 	if (size > 0x2000) {
 		cyrix_get_arr(7, &lbase, &lsize, &ltype);
diff -apru linux-2.6.9/arch/i386/kernel/cpu/mtrr/generic.c
linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/generic.c
--- linux-2.6.9/arch/i386/kernel/cpu/mtrr/generic.c	2004-10-18
23:54:32.000000000 +0200
+++
linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/generic.c	2004-11-12
15:41:38.235652568 +0100
@@ -94,7 +94,7 @@ void __init mtrr_state_warn(void)
 }
 
 
-int generic_get_free_region(unsigned long base, unsigned long size)
+int generic_get_free_region(unsigned long base, unsigned long size,
int replace_reg)
 /*  [SUMMARY] Get a free MTRR.
     <base> The starting (base) address of the region.
     <size> The size (in bytes) of the region.
@@ -103,10 +103,11 @@ int generic_get_free_region(unsigned lon
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
@@ -116,7 +117,7 @@ int generic_get_free_region(unsigned lon
 }
 
 void generic_get_mtrr(unsigned int reg, unsigned long *base,
-		      unsigned int *size, mtrr_type * type)
+		      unsigned long *size, mtrr_type * type)
 {
 	unsigned int mask_lo, mask_hi, base_lo, base_hi;
 
@@ -199,7 +200,9 @@ static int set_mtrr_var_ranges(unsigned 
 	return changed;
 }
 
-static unsigned long set_mtrr_state(u32 deftype_lo, u32 deftype_hi)
+static u32 deftype_lo, deftype_hi;
+
+static unsigned long set_mtrr_state(void)
 /*  [SUMMARY] Set the MTRR state for this CPU.
     <state> The MTRR state information to read.
     <ctxt> Some relevant CPU context.
@@ -221,7 +224,7 @@ static unsigned long set_mtrr_state(u32 
 	   so to set it we fiddle with the saved value  */
 	if ((deftype_lo & 0xff) != mtrr_state.def_type
 	    || ((deftype_lo & 0xc00) >> 10) != mtrr_state.enabled) {
-		deftype_lo |= (mtrr_state.def_type | mtrr_state.enabled
<< 10);
+		deftype_lo = (deftype_lo & ~0xcff) | mtrr_state.def_type
| (mtrr_state.enabled << 10);
 		change_mask |= MTRR_CHANGE_MASK_DEFTYPE;
 	}
 
@@ -230,7 +233,6 @@ static unsigned long set_mtrr_state(u32 
 
 
 static unsigned long cr4 = 0;
-static u32 deftype_lo, deftype_hi;
 static spinlock_t set_atomicity_lock = SPIN_LOCK_UNLOCKED;
 
 static void prepare_set(void)
@@ -261,7 +263,7 @@ static void prepare_set(void)
 	rdmsr(MTRRdefType_MSR, deftype_lo, deftype_hi);
 
 	/*  Disable MTRRs, and set the default type to uncached  */
-	wrmsr(MTRRdefType_MSR, deftype_lo & 0xf300UL, deftype_hi);
+	wrmsr(MTRRdefType_MSR, deftype_lo & ~0xcff, deftype_hi);
 }
 
 static void post_set(void)
@@ -289,7 +291,7 @@ static void generic_set_all(void)
 	prepare_set();
 
 	/* Actually set the state */
-	mask = set_mtrr_state(deftype_lo,deftype_hi);
+	mask = set_mtrr_state();
 
 	post_set();
 
@@ -351,7 +353,7 @@ int generic_validate_add_page(unsigned l
 		}
 	}
 
-	if (base + size < 0x100) {
+	if (base < 0x100) {
 		printk(KERN_WARNING "mtrr: cannot set region below 1 MiB
(0x%lx000,0x%lx000)\n",
 		       base, size);
 		return -EINVAL;
diff -apru linux-2.6.9/arch/i386/kernel/cpu/mtrr/if.c
linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/if.c
--- linux-2.6.9/arch/i386/kernel/cpu/mtrr/if.c	2004-10-18
23:53:43.000000000 +0200
+++ linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/if.c	2004-11-12
15:41:38.239651960 +0100
@@ -151,6 +151,7 @@ mtrr_ioctl(struct inode *inode, struct f
 {
 	int err;
 	mtrr_type type;
+	unsigned long size;
 	struct mtrr_sentry sentry;
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
@@ -201,15 +202,15 @@ mtrr_ioctl(struct inode *inode, struct f
 			return -EFAULT;
 		if (gentry.regnum >= num_var_ranges)
 			return -EINVAL;
-		mtrr_if->get(gentry.regnum, &gentry.base, &gentry.size,
&type);
+		mtrr_if->get(gentry.regnum, &gentry.base, &size,
&type);
 
 		/* Hide entries that go above 4GB */
-		if (gentry.base + gentry.size > 0x100000
-		    || gentry.size == 0x100000)
+		if (gentry.base + size - 1 >= (1UL << (8 *
sizeof(gentry.size) - PAGE_SHIFT))
+		    || size >= (1UL << (8 * sizeof(gentry.size) -
PAGE_SHIFT)))
 			gentry.base = gentry.size = gentry.type = 0;
 		else {
 			gentry.base <<= PAGE_SHIFT;
-			gentry.size <<= PAGE_SHIFT;
+			gentry.size = size << PAGE_SHIFT;
 			gentry.type = type;
 		}
 
@@ -259,8 +260,14 @@ mtrr_ioctl(struct inode *inode, struct f
 			return -EFAULT;
 		if (gentry.regnum >= num_var_ranges)
 			return -EINVAL;
-		mtrr_if->get(gentry.regnum, &gentry.base, &gentry.size,
&type);
-		gentry.type = type;
+		mtrr_if->get(gentry.regnum, &gentry.base, &size,
&type);
+		/* Hide entries that would overflow */
+		if (size != (__typeof__(gentry.size))size)
+			gentry.base = gentry.size = gentry.type = 0;
+		else {
+			gentry.size = size;
+			gentry.type = type;
+		}
 
 		if (copy_to_user(arg, &gentry, sizeof gentry))
 			return -EFAULT;
@@ -319,8 +326,7 @@ static int mtrr_seq_show(struct seq_file
 	char factor;
 	int i, max, len;
 	mtrr_type type;
-	unsigned long base;
-	unsigned int size;
+	unsigned long base, size;
 
 	len = 0;
 	max = num_var_ranges;
@@ -339,7 +345,7 @@ static int mtrr_seq_show(struct seq_file
 			}
 			/* RED-PEN: base can be > 32bit */ 
 			len += seq_printf(seq, 
-				   "reg%02i: base=0x%05lx000 (%4liMB),
size=%4i%cB: %s, count=%d\n",
+				   "reg%02i: base=0x%05lx000 (%4luMB),
size=%4lu%cB: %s, count=%d\n",
 			     i, base, base >> (20 - PAGE_SHIFT), size,
factor,
 			     mtrr_attrib_to_str(type), usage_table[i]);
 		}
diff -apru linux-2.6.9/arch/i386/kernel/cpu/mtrr/main.c
linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.6.9/arch/i386/kernel/cpu/mtrr/main.c	2004-10-18
23:53:08.000000000 +0200
+++ linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/main.c	2004-11-12
15:41:38.250650288 +0100
@@ -170,6 +170,13 @@ static void ipi_handler(void *info)
 
 #endif
 
+static inline int types_compatible(mtrr_type type1, mtrr_type type2)
{
+	return type1 == MTRR_TYPE_UNCACHABLE ||
+	       type2 == MTRR_TYPE_UNCACHABLE ||
+	       (type1 == MTRR_TYPE_WRTHROUGH && type2 ==
MTRR_TYPE_WRBACK) ||
+	       (type1 == MTRR_TYPE_WRBACK && type2 ==
MTRR_TYPE_WRTHROUGH);
+}
+
 /**
  * set_mtrr - update mtrrs on all processors
  * @reg:	mtrr in question
@@ -305,11 +312,9 @@ static void set_mtrr(unsigned int reg, u
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
@@ -329,32 +334,45 @@ int mtrr_add_page(unsigned long base, un
 		return -ENOSYS;
 	}
 
+	if (!size) {
+		printk(KERN_WARNING "mtrr: zero sized request\n");
+		return -EINVAL;
+	}
+
 	if (base & size_or_mask || size & size_or_mask) {
 		printk(KERN_WARNING "mtrr: base or size exceeds the MTRR
width\n");
 		return -EINVAL;
 	}
 
 	error = -EINVAL;
+	replace = -1;
 
 	/*  Search for existing MTRR  */
 	down(&main_lock);
 	for (i = 0; i < num_var_ranges; ++i) {
 		mtrr_if->get(i, &lbase, &lsize, &ltype);
-		if (base >= lbase + lsize)
-			continue;
-		if ((base < lbase) && (base + size <= lbase))
+		if (!lsize || base > lbase + lsize - 1 || base + size -
1 < lbase)
 			continue;
 		/*  At this point we know there is some kind of
overlap/enclosure  */
-		if ((base < lbase) || (base + size > lbase + lsize)) {
+		if (base < lbase || base + size - 1 > lbase + lsize - 1)
{
+			if (base <= lbase && base + size - 1 >= lbase +
lsize - 1) {
+				/*  New region encloses an existing
region  */
+				if (type == ltype) {
+					replace = replace == -1 ? i :
-2;
+					continue;
+				}
+				else if (types_compatible(type, ltype))
+					continue;
+			}
 			printk(KERN_WARNING
 			       "mtrr: 0x%lx000,0x%lx000 overlaps
existing"
-			       " 0x%lx000,0x%x000\n", base, size,
lbase,
+			       " 0x%lx000,0x%lx000\n", base, size,
lbase,
 			       lsize);
 			goto out;
 		}
 		/*  New region is enclosed by an existing region  */
 		if (ltype != type) {
-			if (type == MTRR_TYPE_UNCACHABLE)
+			if (types_compatible(type, ltype))
 				continue;
 			printk (KERN_WARNING "mtrr: type mismatch for
%lx000,%lx000 old: %s new: %s\n",
 			     base, size, mtrr_attrib_to_str(ltype),
@@ -367,10 +385,18 @@ int mtrr_add_page(unsigned long base, un
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
+			usage_table[i] = usage_table[replace] +
!!increment;
+			if (unlikely(replace != i)) {
+				set_mtrr(replace, 0, 0, 0);
+				usage_table[replace] = 0;
+			}
+		}
 	} else
 		printk(KERN_INFO "mtrr: no more MTRRs available\n");
 	error = i;
@@ -447,8 +473,7 @@ int mtrr_del_page(int reg, unsigned long
 {
 	int i, max;
 	mtrr_type ltype;
-	unsigned long lbase;
-	unsigned int lsize;
+	unsigned long lbase, lsize;
 	int error = -EINVAL;
 
 	if (!mtrr_if)
@@ -559,7 +584,7 @@ static void __init init_other_cpus(void)
 struct mtrr_value {
 	mtrr_type	ltype;
 	unsigned long	lbase;
-	unsigned int	lsize;
+	unsigned long	lsize;
 };
 
 static struct mtrr_value * mtrr_state;
diff -apru linux-2.6.9/arch/i386/kernel/cpu/mtrr/mtrr.h
linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/mtrr.h
--- linux-2.6.9/arch/i386/kernel/cpu/mtrr/mtrr.h	2004-10-18
23:55:36.000000000 +0200
+++ linux-2.6.9-mtrr/arch/i386/kernel/cpu/mtrr/mtrr.h	2004-11-12
15:45:12.198125328 +0100
@@ -43,15 +43,16 @@ struct mtrr_ops {
 	void	(*set_all)(void);
 
 	void	(*get)(unsigned int reg, unsigned long *base,
-		       unsigned int *size, mtrr_type * type);
-	int	(*get_free_region) (unsigned long base, unsigned long
size);
-
+		       unsigned long *size, mtrr_type * type);
+	int	(*get_free_region)(unsigned long base, unsigned long
size,
+				   int replace_reg);
 	int	(*validate_add_page)(unsigned long base, unsigned long
size,
 				     unsigned int type);
 	int	(*have_wrcomb)(void);
 };
 
-extern int generic_get_free_region(unsigned long base, unsigned long
size);
+extern int generic_get_free_region(unsigned long base, unsigned long
size,
+				   int replace_reg);
 extern int generic_validate_add_page(unsigned long base, unsigned long
size,
 				     unsigned int type);
 


--=__PartB4946CD8.0__=
Content-Type: application/octet-stream; name="linux-2.6.9-x86-mtrr.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.9-x86-mtrr.patch"

ZGlmZiAtYXBydSBsaW51eC0yLjYuOS9hcmNoL2kzODYva2VybmVsL2NwdS9tdHJyL2FtZC5jIGxp
bnV4LTIuNi45LW10cnIvYXJjaC9pMzg2L2tlcm5lbC9jcHUvbXRyci9hbWQuYwotLS0gbGludXgt
Mi42LjkvYXJjaC9pMzg2L2tlcm5lbC9jcHUvbXRyci9hbWQuYwkyMDA0LTEwLTE4IDIzOjU0OjI5
LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjktbXRyci9hcmNoL2kzODYva2VybmVsL2Nw
dS9tdHJyL2FtZC5jCTIwMDQtMTEtMTIgMTU6NDE6MzguMjEzNjU1OTEyICswMTAwCkBAIC03LDcg
KzcsNyBAQAogCiBzdGF0aWMgdm9pZAogYW1kX2dldF9tdHJyKHVuc2lnbmVkIGludCByZWcsIHVu
c2lnbmVkIGxvbmcgKmJhc2UsCi0JICAgICB1bnNpZ25lZCBpbnQgKnNpemUsIG10cnJfdHlwZSAq
IHR5cGUpCisJICAgICB1bnNpZ25lZCBsb25nICpzaXplLCBtdHJyX3R5cGUgKiB0eXBlKQogewog
CXVuc2lnbmVkIGxvbmcgbG93LCBoaWdoOwogCmRpZmYgLWFwcnUgbGludXgtMi42LjkvYXJjaC9p
Mzg2L2tlcm5lbC9jcHUvbXRyci9jZW50YXVyLmMgbGludXgtMi42LjktbXRyci9hcmNoL2kzODYv
a2VybmVsL2NwdS9tdHJyL2NlbnRhdXIuYwotLS0gbGludXgtMi42LjkvYXJjaC9pMzg2L2tlcm5l
bC9jcHUvbXRyci9jZW50YXVyLmMJMjAwNC0xMC0xOCAyMzo1Mzo0NS4wMDAwMDAwMDAgKzAyMDAK
KysrIGxpbnV4LTIuNi45LW10cnIvYXJjaC9pMzg2L2tlcm5lbC9jcHUvbXRyci9jZW50YXVyLmMJ
MjAwNC0xMS0xMiAxNTo0MTozOC4yMjk2NTM0ODAgKzAxMDAKQEAgLTE3LDcgKzE3LDcgQEAgc3Rh
dGljIHU4IGNlbnRhdXJfbWNyX3R5cGU7CS8qIDAgZm9yIHdpbgogICovCiAKIHN0YXRpYyBpbnQK
LWNlbnRhdXJfZ2V0X2ZyZWVfcmVnaW9uKHVuc2lnbmVkIGxvbmcgYmFzZSwgdW5zaWduZWQgbG9u
ZyBzaXplKQorY2VudGF1cl9nZXRfZnJlZV9yZWdpb24odW5zaWduZWQgbG9uZyBiYXNlLCB1bnNp
Z25lZCBsb25nIHNpemUsIGludCByZXBsYWNlX3JlZykKIC8qICBbU1VNTUFSWV0gR2V0IGEgZnJl
ZSBNVFJSLgogICAgIDxiYXNlPiBUaGUgc3RhcnRpbmcgKGJhc2UpIGFkZHJlc3Mgb2YgdGhlIHJl
Z2lvbi4KICAgICA8c2l6ZT4gVGhlIHNpemUgKGluIGJ5dGVzKSBvZiB0aGUgcmVnaW9uLgpAQCAt
MjYsMTAgKzI2LDExIEBAIGNlbnRhdXJfZ2V0X2ZyZWVfcmVnaW9uKHVuc2lnbmVkIGxvbmcgYmEK
IHsKIAlpbnQgaSwgbWF4OwogCW10cnJfdHlwZSBsdHlwZTsKLQl1bnNpZ25lZCBsb25nIGxiYXNl
OwotCXVuc2lnbmVkIGludCBsc2l6ZTsKKwl1bnNpZ25lZCBsb25nIGxiYXNlLCBsc2l6ZTsKIAog
CW1heCA9IG51bV92YXJfcmFuZ2VzOworCWlmIChyZXBsYWNlX3JlZyA+PSAwICYmIHJlcGxhY2Vf
cmVnIDwgbWF4KQorCQlyZXR1cm4gcmVwbGFjZV9yZWc7CiAJZm9yIChpID0gMDsgaSA8IG1heDsg
KytpKSB7CiAJCWlmIChjZW50YXVyX21jcl9yZXNlcnZlZCAmICgxIDw8IGkpKQogCQkJY29udGlu
dWU7CkBAIC00OSw3ICs1MCw3IEBAIG10cnJfY2VudGF1cl9yZXBvcnRfbWNyKGludCBtY3IsIHUz
MiBsbywKIAogc3RhdGljIHZvaWQKIGNlbnRhdXJfZ2V0X21jcih1bnNpZ25lZCBpbnQgcmVnLCB1
bnNpZ25lZCBsb25nICpiYXNlLAotCQl1bnNpZ25lZCBpbnQgKnNpemUsIG10cnJfdHlwZSAqIHR5
cGUpCisJCXVuc2lnbmVkIGxvbmcgKnNpemUsIG10cnJfdHlwZSAqIHR5cGUpCiB7CiAJKmJhc2Ug
PSBjZW50YXVyX21jcltyZWddLmhpZ2ggPj4gUEFHRV9TSElGVDsKIAkqc2l6ZSA9IC0oY2VudGF1
cl9tY3JbcmVnXS5sb3cgJiAweGZmZmZmMDAwKSA+PiBQQUdFX1NISUZUOwpkaWZmIC1hcHJ1IGxp
bnV4LTIuNi45L2FyY2gvaTM4Ni9rZXJuZWwvY3B1L210cnIvY3lyaXguYyBsaW51eC0yLjYuOS1t
dHJyL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L210cnIvY3lyaXguYwotLS0gbGludXgtMi42LjkvYXJj
aC9pMzg2L2tlcm5lbC9jcHUvbXRyci9jeXJpeC5jCTIwMDQtMTAtMTggMjM6NTQ6MzEuMDAwMDAw
MDAwICswMjAwCisrKyBsaW51eC0yLjYuOS1tdHJyL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L210cnIv
Y3lyaXguYwkyMDA0LTExLTEyIDE1OjQxOjM4LjIzMjY1MzAyNCArMDEwMApAQCAtOSw3ICs5LDcg
QEAgaW50IGFycjNfcHJvdGVjdGVkOwogCiBzdGF0aWMgdm9pZAogY3lyaXhfZ2V0X2Fycih1bnNp
Z25lZCBpbnQgcmVnLCB1bnNpZ25lZCBsb25nICpiYXNlLAotCSAgICAgIHVuc2lnbmVkIGludCAq
c2l6ZSwgbXRycl90eXBlICogdHlwZSkKKwkgICAgICB1bnNpZ25lZCBsb25nICpzaXplLCBtdHJy
X3R5cGUgKiB0eXBlKQogewogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJdW5zaWduZWQgY2hhciBh
cnIsIGNjcjMsIHJjciwgc2hpZnQ7CkBAIC03Nyw3ICs3Nyw3IEBAIGN5cml4X2dldF9hcnIodW5z
aWduZWQgaW50IHJlZywgdW5zaWduZWQKIH0KIAogc3RhdGljIGludAotY3lyaXhfZ2V0X2ZyZWVf
cmVnaW9uKHVuc2lnbmVkIGxvbmcgYmFzZSwgdW5zaWduZWQgbG9uZyBzaXplKQorY3lyaXhfZ2V0
X2ZyZWVfcmVnaW9uKHVuc2lnbmVkIGxvbmcgYmFzZSwgdW5zaWduZWQgbG9uZyBzaXplLCBpbnQg
cmVwbGFjZV9yZWcpCiAvKiAgW1NVTU1BUlldIEdldCBhIGZyZWUgQVJSLgogICAgIDxiYXNlPiBU
aGUgc3RhcnRpbmcgKGJhc2UpIGFkZHJlc3Mgb2YgdGhlIHJlZ2lvbi4KICAgICA8c2l6ZT4gVGhl
IHNpemUgKGluIGJ5dGVzKSBvZiB0aGUgcmVnaW9uLgpAQCAtODYsOSArODYsMjQgQEAgY3lyaXhf
Z2V0X2ZyZWVfcmVnaW9uKHVuc2lnbmVkIGxvbmcgYmFzZQogewogCWludCBpOwogCW10cnJfdHlw
ZSBsdHlwZTsKLQl1bnNpZ25lZCBsb25nIGxiYXNlOwotCXVuc2lnbmVkIGludCAgbHNpemU7CisJ
dW5zaWduZWQgbG9uZyBsYmFzZSwgbHNpemU7CiAKKwlzd2l0Y2ggKHJlcGxhY2VfcmVnKSB7CisJ
Y2FzZSA3OgorCQlpZiAoc2l6ZSA8IDB4NDApCisJCQlicmVhazsKKwljYXNlIDY6CisJY2FzZSA1
OgorCWNhc2UgNDoKKwkJcmV0dXJuIHJlcGxhY2VfcmVnOworCWNhc2UgMzoKKwkJaWYgKGFycjNf
cHJvdGVjdGVkKQorCQkJYnJlYWs7CisJY2FzZSAyOgorCWNhc2UgMToKKwljYXNlIDA6CisJCXJl
dHVybiByZXBsYWNlX3JlZzsKKwl9CiAJLyogSWYgd2UgYXJlIHRvIHNldCB1cCBhIHJlZ2lvbiA+
MzJNIHRoZW4gbG9vayBhdCBBUlI3IGltbWVkaWF0ZWx5ICovCiAJaWYgKHNpemUgPiAweDIwMDAp
IHsKIAkJY3lyaXhfZ2V0X2Fycig3LCAmbGJhc2UsICZsc2l6ZSwgJmx0eXBlKTsKZGlmZiAtYXBy
dSBsaW51eC0yLjYuOS9hcmNoL2kzODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYyBsaW51eC0y
LjYuOS1tdHJyL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jCi0tLSBsaW51eC0y
LjYuOS9hcmNoL2kzODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYwkyMDA0LTEwLTE4IDIzOjU0
OjMyLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjktbXRyci9hcmNoL2kzODYva2VybmVs
L2NwdS9tdHJyL2dlbmVyaWMuYwkyMDA0LTExLTEyIDE1OjQxOjM4LjIzNTY1MjU2OCArMDEwMApA
QCAtOTQsNyArOTQsNyBAQCB2b2lkIF9faW5pdCBtdHJyX3N0YXRlX3dhcm4odm9pZCkKIH0KIAog
Ci1pbnQgZ2VuZXJpY19nZXRfZnJlZV9yZWdpb24odW5zaWduZWQgbG9uZyBiYXNlLCB1bnNpZ25l
ZCBsb25nIHNpemUpCitpbnQgZ2VuZXJpY19nZXRfZnJlZV9yZWdpb24odW5zaWduZWQgbG9uZyBi
YXNlLCB1bnNpZ25lZCBsb25nIHNpemUsIGludCByZXBsYWNlX3JlZykKIC8qICBbU1VNTUFSWV0g
R2V0IGEgZnJlZSBNVFJSLgogICAgIDxiYXNlPiBUaGUgc3RhcnRpbmcgKGJhc2UpIGFkZHJlc3Mg
b2YgdGhlIHJlZ2lvbi4KICAgICA8c2l6ZT4gVGhlIHNpemUgKGluIGJ5dGVzKSBvZiB0aGUgcmVn
aW9uLgpAQCAtMTAzLDEwICsxMDMsMTEgQEAgaW50IGdlbmVyaWNfZ2V0X2ZyZWVfcmVnaW9uKHVu
c2lnbmVkIGxvbgogewogCWludCBpLCBtYXg7CiAJbXRycl90eXBlIGx0eXBlOwotCXVuc2lnbmVk
IGxvbmcgbGJhc2U7Ci0JdW5zaWduZWQgbHNpemU7CisJdW5zaWduZWQgbG9uZyBsYmFzZSwgbHNp
emU7CiAKIAltYXggPSBudW1fdmFyX3JhbmdlczsKKwlpZiAocmVwbGFjZV9yZWcgPj0gMCAmJiBy
ZXBsYWNlX3JlZyA8IG1heCkKKwkJcmV0dXJuIHJlcGxhY2VfcmVnOwogCWZvciAoaSA9IDA7IGkg
PCBtYXg7ICsraSkgewogCQltdHJyX2lmLT5nZXQoaSwgJmxiYXNlLCAmbHNpemUsICZsdHlwZSk7
CiAJCWlmIChsc2l6ZSA9PSAwKQpAQCAtMTE2LDcgKzExNyw3IEBAIGludCBnZW5lcmljX2dldF9m
cmVlX3JlZ2lvbih1bnNpZ25lZCBsb24KIH0KIAogdm9pZCBnZW5lcmljX2dldF9tdHJyKHVuc2ln
bmVkIGludCByZWcsIHVuc2lnbmVkIGxvbmcgKmJhc2UsCi0JCSAgICAgIHVuc2lnbmVkIGludCAq
c2l6ZSwgbXRycl90eXBlICogdHlwZSkKKwkJICAgICAgdW5zaWduZWQgbG9uZyAqc2l6ZSwgbXRy
cl90eXBlICogdHlwZSkKIHsKIAl1bnNpZ25lZCBpbnQgbWFza19sbywgbWFza19oaSwgYmFzZV9s
bywgYmFzZV9oaTsKIApAQCAtMTk5LDcgKzIwMCw5IEBAIHN0YXRpYyBpbnQgc2V0X210cnJfdmFy
X3Jhbmdlcyh1bnNpZ25lZCAKIAlyZXR1cm4gY2hhbmdlZDsKIH0KIAotc3RhdGljIHVuc2lnbmVk
IGxvbmcgc2V0X210cnJfc3RhdGUodTMyIGRlZnR5cGVfbG8sIHUzMiBkZWZ0eXBlX2hpKQorc3Rh
dGljIHUzMiBkZWZ0eXBlX2xvLCBkZWZ0eXBlX2hpOworCitzdGF0aWMgdW5zaWduZWQgbG9uZyBz
ZXRfbXRycl9zdGF0ZSh2b2lkKQogLyogIFtTVU1NQVJZXSBTZXQgdGhlIE1UUlIgc3RhdGUgZm9y
IHRoaXMgQ1BVLgogICAgIDxzdGF0ZT4gVGhlIE1UUlIgc3RhdGUgaW5mb3JtYXRpb24gdG8gcmVh
ZC4KICAgICA8Y3R4dD4gU29tZSByZWxldmFudCBDUFUgY29udGV4dC4KQEAgLTIyMSw3ICsyMjQs
NyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBzZXRfbXRycl9zdGF0ZSh1MzIgCiAJICAgc28gdG8g
c2V0IGl0IHdlIGZpZGRsZSB3aXRoIHRoZSBzYXZlZCB2YWx1ZSAgKi8KIAlpZiAoKGRlZnR5cGVf
bG8gJiAweGZmKSAhPSBtdHJyX3N0YXRlLmRlZl90eXBlCiAJICAgIHx8ICgoZGVmdHlwZV9sbyAm
IDB4YzAwKSA+PiAxMCkgIT0gbXRycl9zdGF0ZS5lbmFibGVkKSB7Ci0JCWRlZnR5cGVfbG8gfD0g
KG10cnJfc3RhdGUuZGVmX3R5cGUgfCBtdHJyX3N0YXRlLmVuYWJsZWQgPDwgMTApOworCQlkZWZ0
eXBlX2xvID0gKGRlZnR5cGVfbG8gJiB+MHhjZmYpIHwgbXRycl9zdGF0ZS5kZWZfdHlwZSB8ICht
dHJyX3N0YXRlLmVuYWJsZWQgPDwgMTApOwogCQljaGFuZ2VfbWFzayB8PSBNVFJSX0NIQU5HRV9N
QVNLX0RFRlRZUEU7CiAJfQogCkBAIC0yMzAsNyArMjMzLDYgQEAgc3RhdGljIHVuc2lnbmVkIGxv
bmcgc2V0X210cnJfc3RhdGUodTMyIAogCiAKIHN0YXRpYyB1bnNpZ25lZCBsb25nIGNyNCA9IDA7
Ci1zdGF0aWMgdTMyIGRlZnR5cGVfbG8sIGRlZnR5cGVfaGk7CiBzdGF0aWMgc3BpbmxvY2tfdCBz
ZXRfYXRvbWljaXR5X2xvY2sgPSBTUElOX0xPQ0tfVU5MT0NLRUQ7CiAKIHN0YXRpYyB2b2lkIHBy
ZXBhcmVfc2V0KHZvaWQpCkBAIC0yNjEsNyArMjYzLDcgQEAgc3RhdGljIHZvaWQgcHJlcGFyZV9z
ZXQodm9pZCkKIAlyZG1zcihNVFJSZGVmVHlwZV9NU1IsIGRlZnR5cGVfbG8sIGRlZnR5cGVfaGkp
OwogCiAJLyogIERpc2FibGUgTVRSUnMsIGFuZCBzZXQgdGhlIGRlZmF1bHQgdHlwZSB0byB1bmNh
Y2hlZCAgKi8KLQl3cm1zcihNVFJSZGVmVHlwZV9NU1IsIGRlZnR5cGVfbG8gJiAweGYzMDBVTCwg
ZGVmdHlwZV9oaSk7CisJd3Jtc3IoTVRSUmRlZlR5cGVfTVNSLCBkZWZ0eXBlX2xvICYgfjB4Y2Zm
LCBkZWZ0eXBlX2hpKTsKIH0KIAogc3RhdGljIHZvaWQgcG9zdF9zZXQodm9pZCkKQEAgLTI4OSw3
ICsyOTEsNyBAQCBzdGF0aWMgdm9pZCBnZW5lcmljX3NldF9hbGwodm9pZCkKIAlwcmVwYXJlX3Nl
dCgpOwogCiAJLyogQWN0dWFsbHkgc2V0IHRoZSBzdGF0ZSAqLwotCW1hc2sgPSBzZXRfbXRycl9z
dGF0ZShkZWZ0eXBlX2xvLGRlZnR5cGVfaGkpOworCW1hc2sgPSBzZXRfbXRycl9zdGF0ZSgpOwog
CiAJcG9zdF9zZXQoKTsKIApAQCAtMzUxLDcgKzM1Myw3IEBAIGludCBnZW5lcmljX3ZhbGlkYXRl
X2FkZF9wYWdlKHVuc2lnbmVkIGwKIAkJfQogCX0KIAotCWlmIChiYXNlICsgc2l6ZSA8IDB4MTAw
KSB7CisJaWYgKGJhc2UgPCAweDEwMCkgewogCQlwcmludGsoS0VSTl9XQVJOSU5HICJtdHJyOiBj
YW5ub3Qgc2V0IHJlZ2lvbiBiZWxvdyAxIE1pQiAoMHglbHgwMDAsMHglbHgwMDApXG4iLAogCQkg
ICAgICAgYmFzZSwgc2l6ZSk7CiAJCXJldHVybiAtRUlOVkFMOwpkaWZmIC1hcHJ1IGxpbnV4LTIu
Ni45L2FyY2gvaTM4Ni9rZXJuZWwvY3B1L210cnIvaWYuYyBsaW51eC0yLjYuOS1tdHJyL2FyY2gv
aTM4Ni9rZXJuZWwvY3B1L210cnIvaWYuYwotLS0gbGludXgtMi42LjkvYXJjaC9pMzg2L2tlcm5l
bC9jcHUvbXRyci9pZi5jCTIwMDQtMTAtMTggMjM6NTM6NDMuMDAwMDAwMDAwICswMjAwCisrKyBs
aW51eC0yLjYuOS1tdHJyL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L210cnIvaWYuYwkyMDA0LTExLTEy
IDE1OjQxOjM4LjIzOTY1MTk2MCArMDEwMApAQCAtMTUxLDYgKzE1MSw3IEBAIG10cnJfaW9jdGwo
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGYKIHsKIAlpbnQgZXJyOwogCW10cnJfdHlwZSB0
eXBlOworCXVuc2lnbmVkIGxvbmcgc2l6ZTsKIAlzdHJ1Y3QgbXRycl9zZW50cnkgc2VudHJ5Owog
CXN0cnVjdCBtdHJyX2dlbnRyeSBnZW50cnk7CiAJdm9pZCBfX3VzZXIgKmFyZyA9ICh2b2lkIF9f
dXNlciAqKSBfX2FyZzsKQEAgLTIwMSwxNSArMjAyLDE1IEBAIG10cnJfaW9jdGwoc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGYKIAkJCXJldHVybiAtRUZBVUxUOwogCQlpZiAoZ2VudHJ5LnJl
Z251bSA+PSBudW1fdmFyX3JhbmdlcykKIAkJCXJldHVybiAtRUlOVkFMOwotCQltdHJyX2lmLT5n
ZXQoZ2VudHJ5LnJlZ251bSwgJmdlbnRyeS5iYXNlLCAmZ2VudHJ5LnNpemUsICZ0eXBlKTsKKwkJ
bXRycl9pZi0+Z2V0KGdlbnRyeS5yZWdudW0sICZnZW50cnkuYmFzZSwgJnNpemUsICZ0eXBlKTsK
IAogCQkvKiBIaWRlIGVudHJpZXMgdGhhdCBnbyBhYm92ZSA0R0IgKi8KLQkJaWYgKGdlbnRyeS5i
YXNlICsgZ2VudHJ5LnNpemUgPiAweDEwMDAwMAotCQkgICAgfHwgZ2VudHJ5LnNpemUgPT0gMHgx
MDAwMDApCisJCWlmIChnZW50cnkuYmFzZSArIHNpemUgLSAxID49ICgxVUwgPDwgKDggKiBzaXpl
b2YoZ2VudHJ5LnNpemUpIC0gUEFHRV9TSElGVCkpCisJCSAgICB8fCBzaXplID49ICgxVUwgPDwg
KDggKiBzaXplb2YoZ2VudHJ5LnNpemUpIC0gUEFHRV9TSElGVCkpKQogCQkJZ2VudHJ5LmJhc2Ug
PSBnZW50cnkuc2l6ZSA9IGdlbnRyeS50eXBlID0gMDsKIAkJZWxzZSB7CiAJCQlnZW50cnkuYmFz
ZSA8PD0gUEFHRV9TSElGVDsKLQkJCWdlbnRyeS5zaXplIDw8PSBQQUdFX1NISUZUOworCQkJZ2Vu
dHJ5LnNpemUgPSBzaXplIDw8IFBBR0VfU0hJRlQ7CiAJCQlnZW50cnkudHlwZSA9IHR5cGU7CiAJ
CX0KIApAQCAtMjU5LDggKzI2MCwxNCBAQCBtdHJyX2lvY3RsKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IHN0cnVjdCBmCiAJCQlyZXR1cm4gLUVGQVVMVDsKIAkJaWYgKGdlbnRyeS5yZWdudW0gPj0gbnVt
X3Zhcl9yYW5nZXMpCiAJCQlyZXR1cm4gLUVJTlZBTDsKLQkJbXRycl9pZi0+Z2V0KGdlbnRyeS5y
ZWdudW0sICZnZW50cnkuYmFzZSwgJmdlbnRyeS5zaXplLCAmdHlwZSk7Ci0JCWdlbnRyeS50eXBl
ID0gdHlwZTsKKwkJbXRycl9pZi0+Z2V0KGdlbnRyeS5yZWdudW0sICZnZW50cnkuYmFzZSwgJnNp
emUsICZ0eXBlKTsKKwkJLyogSGlkZSBlbnRyaWVzIHRoYXQgd291bGQgb3ZlcmZsb3cgKi8KKwkJ
aWYgKHNpemUgIT0gKF9fdHlwZW9mX18oZ2VudHJ5LnNpemUpKXNpemUpCisJCQlnZW50cnkuYmFz
ZSA9IGdlbnRyeS5zaXplID0gZ2VudHJ5LnR5cGUgPSAwOworCQllbHNlIHsKKwkJCWdlbnRyeS5z
aXplID0gc2l6ZTsKKwkJCWdlbnRyeS50eXBlID0gdHlwZTsKKwkJfQogCiAJCWlmIChjb3B5X3Rv
X3VzZXIoYXJnLCAmZ2VudHJ5LCBzaXplb2YgZ2VudHJ5KSkKIAkJCXJldHVybiAtRUZBVUxUOwpA
QCAtMzE5LDggKzMyNiw3IEBAIHN0YXRpYyBpbnQgbXRycl9zZXFfc2hvdyhzdHJ1Y3Qgc2VxX2Zp
bGUKIAljaGFyIGZhY3RvcjsKIAlpbnQgaSwgbWF4LCBsZW47CiAJbXRycl90eXBlIHR5cGU7Ci0J
dW5zaWduZWQgbG9uZyBiYXNlOwotCXVuc2lnbmVkIGludCBzaXplOworCXVuc2lnbmVkIGxvbmcg
YmFzZSwgc2l6ZTsKIAogCWxlbiA9IDA7CiAJbWF4ID0gbnVtX3Zhcl9yYW5nZXM7CkBAIC0zMzks
NyArMzQ1LDcgQEAgc3RhdGljIGludCBtdHJyX3NlcV9zaG93KHN0cnVjdCBzZXFfZmlsZQogCQkJ
fQogCQkJLyogUkVELVBFTjogYmFzZSBjYW4gYmUgPiAzMmJpdCAqLyAKIAkJCWxlbiArPSBzZXFf
cHJpbnRmKHNlcSwgCi0JCQkJICAgInJlZyUwMmk6IGJhc2U9MHglMDVseDAwMCAoJTRsaU1CKSwg
c2l6ZT0lNGklY0I6ICVzLCBjb3VudD0lZFxuIiwKKwkJCQkgICAicmVnJTAyaTogYmFzZT0weCUw
NWx4MDAwICglNGx1TUIpLCBzaXplPSU0bHUlY0I6ICVzLCBjb3VudD0lZFxuIiwKIAkJCSAgICAg
aSwgYmFzZSwgYmFzZSA+PiAoMjAgLSBQQUdFX1NISUZUKSwgc2l6ZSwgZmFjdG9yLAogCQkJICAg
ICBtdHJyX2F0dHJpYl90b19zdHIodHlwZSksIHVzYWdlX3RhYmxlW2ldKTsKIAkJfQpkaWZmIC1h
cHJ1IGxpbnV4LTIuNi45L2FyY2gvaTM4Ni9rZXJuZWwvY3B1L210cnIvbWFpbi5jIGxpbnV4LTIu
Ni45LW10cnIvYXJjaC9pMzg2L2tlcm5lbC9jcHUvbXRyci9tYWluLmMKLS0tIGxpbnV4LTIuNi45
L2FyY2gvaTM4Ni9rZXJuZWwvY3B1L210cnIvbWFpbi5jCTIwMDQtMTAtMTggMjM6NTM6MDguMDAw
MDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuOS1tdHJyL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L210
cnIvbWFpbi5jCTIwMDQtMTEtMTIgMTU6NDE6MzguMjUwNjUwMjg4ICswMTAwCkBAIC0xNzAsNiAr
MTcwLDEzIEBAIHN0YXRpYyB2b2lkIGlwaV9oYW5kbGVyKHZvaWQgKmluZm8pCiAKICNlbmRpZgog
CitzdGF0aWMgaW5saW5lIGludCB0eXBlc19jb21wYXRpYmxlKG10cnJfdHlwZSB0eXBlMSwgbXRy
cl90eXBlIHR5cGUyKSB7CisJcmV0dXJuIHR5cGUxID09IE1UUlJfVFlQRV9VTkNBQ0hBQkxFIHx8
CisJICAgICAgIHR5cGUyID09IE1UUlJfVFlQRV9VTkNBQ0hBQkxFIHx8CisJICAgICAgICh0eXBl
MSA9PSBNVFJSX1RZUEVfV1JUSFJPVUdIICYmIHR5cGUyID09IE1UUlJfVFlQRV9XUkJBQ0spIHx8
CisJICAgICAgICh0eXBlMSA9PSBNVFJSX1RZUEVfV1JCQUNLICYmIHR5cGUyID09IE1UUlJfVFlQ
RV9XUlRIUk9VR0gpOworfQorCiAvKioKICAqIHNldF9tdHJyIC0gdXBkYXRlIG10cnJzIG9uIGFs
bCBwcm9jZXNzb3JzCiAgKiBAcmVnOgltdHJyIGluIHF1ZXN0aW9uCkBAIC0zMDUsMTEgKzMxMiw5
IEBAIHN0YXRpYyB2b2lkIHNldF9tdHJyKHVuc2lnbmVkIGludCByZWcsIHUKIGludCBtdHJyX2Fk
ZF9wYWdlKHVuc2lnbmVkIGxvbmcgYmFzZSwgdW5zaWduZWQgbG9uZyBzaXplLCAKIAkJICB1bnNp
Z25lZCBpbnQgdHlwZSwgY2hhciBpbmNyZW1lbnQpCiB7Ci0JaW50IGk7CisJaW50IGksIHJlcGxh
Y2UsIGVycm9yOwogCW10cnJfdHlwZSBsdHlwZTsKLQl1bnNpZ25lZCBsb25nIGxiYXNlOwotCXVu
c2lnbmVkIGludCBsc2l6ZTsKLQlpbnQgZXJyb3I7CisJdW5zaWduZWQgbG9uZyBsYmFzZSwgbHNp
emU7CiAKIAlpZiAoIW10cnJfaWYpCiAJCXJldHVybiAtRU5YSU87CkBAIC0zMjksMzIgKzMzNCw0
NSBAQCBpbnQgbXRycl9hZGRfcGFnZSh1bnNpZ25lZCBsb25nIGJhc2UsIHVuCiAJCXJldHVybiAt
RU5PU1lTOwogCX0KIAorCWlmICghc2l6ZSkgeworCQlwcmludGsoS0VSTl9XQVJOSU5HICJtdHJy
OiB6ZXJvIHNpemVkIHJlcXVlc3RcbiIpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisKIAlpZiAo
YmFzZSAmIHNpemVfb3JfbWFzayB8fCBzaXplICYgc2l6ZV9vcl9tYXNrKSB7CiAJCXByaW50ayhL
RVJOX1dBUk5JTkcgIm10cnI6IGJhc2Ugb3Igc2l6ZSBleGNlZWRzIHRoZSBNVFJSIHdpZHRoXG4i
KTsKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCiAJZXJyb3IgPSAtRUlOVkFMOworCXJlcGxhY2Ug
PSAtMTsKIAogCS8qICBTZWFyY2ggZm9yIGV4aXN0aW5nIE1UUlIgICovCiAJZG93bigmbWFpbl9s
b2NrKTsKIAlmb3IgKGkgPSAwOyBpIDwgbnVtX3Zhcl9yYW5nZXM7ICsraSkgewogCQltdHJyX2lm
LT5nZXQoaSwgJmxiYXNlLCAmbHNpemUsICZsdHlwZSk7Ci0JCWlmIChiYXNlID49IGxiYXNlICsg
bHNpemUpCi0JCQljb250aW51ZTsKLQkJaWYgKChiYXNlIDwgbGJhc2UpICYmIChiYXNlICsgc2l6
ZSA8PSBsYmFzZSkpCisJCWlmICghbHNpemUgfHwgYmFzZSA+IGxiYXNlICsgbHNpemUgLSAxIHx8
IGJhc2UgKyBzaXplIC0gMSA8IGxiYXNlKQogCQkJY29udGludWU7CiAJCS8qICBBdCB0aGlzIHBv
aW50IHdlIGtub3cgdGhlcmUgaXMgc29tZSBraW5kIG9mIG92ZXJsYXAvZW5jbG9zdXJlICAqLwot
CQlpZiAoKGJhc2UgPCBsYmFzZSkgfHwgKGJhc2UgKyBzaXplID4gbGJhc2UgKyBsc2l6ZSkpIHsK
KwkJaWYgKGJhc2UgPCBsYmFzZSB8fCBiYXNlICsgc2l6ZSAtIDEgPiBsYmFzZSArIGxzaXplIC0g
MSkgeworCQkJaWYgKGJhc2UgPD0gbGJhc2UgJiYgYmFzZSArIHNpemUgLSAxID49IGxiYXNlICsg
bHNpemUgLSAxKSB7CisJCQkJLyogIE5ldyByZWdpb24gZW5jbG9zZXMgYW4gZXhpc3RpbmcgcmVn
aW9uICAqLworCQkJCWlmICh0eXBlID09IGx0eXBlKSB7CisJCQkJCXJlcGxhY2UgPSByZXBsYWNl
ID09IC0xID8gaSA6IC0yOworCQkJCQljb250aW51ZTsKKwkJCQl9CisJCQkJZWxzZSBpZiAodHlw
ZXNfY29tcGF0aWJsZSh0eXBlLCBsdHlwZSkpCisJCQkJCWNvbnRpbnVlOworCQkJfQogCQkJcHJp
bnRrKEtFUk5fV0FSTklORwogCQkJICAgICAgICJtdHJyOiAweCVseDAwMCwweCVseDAwMCBvdmVy
bGFwcyBleGlzdGluZyIKLQkJCSAgICAgICAiIDB4JWx4MDAwLDB4JXgwMDBcbiIsIGJhc2UsIHNp
emUsIGxiYXNlLAorCQkJICAgICAgICIgMHglbHgwMDAsMHglbHgwMDBcbiIsIGJhc2UsIHNpemUs
IGxiYXNlLAogCQkJICAgICAgIGxzaXplKTsKIAkJCWdvdG8gb3V0OwogCQl9CiAJCS8qICBOZXcg
cmVnaW9uIGlzIGVuY2xvc2VkIGJ5IGFuIGV4aXN0aW5nIHJlZ2lvbiAgKi8KIAkJaWYgKGx0eXBl
ICE9IHR5cGUpIHsKLQkJCWlmICh0eXBlID09IE1UUlJfVFlQRV9VTkNBQ0hBQkxFKQorCQkJaWYg
KHR5cGVzX2NvbXBhdGlibGUodHlwZSwgbHR5cGUpKQogCQkJCWNvbnRpbnVlOwogCQkJcHJpbnRr
IChLRVJOX1dBUk5JTkcgIm10cnI6IHR5cGUgbWlzbWF0Y2ggZm9yICVseDAwMCwlbHgwMDAgb2xk
OiAlcyBuZXc6ICVzXG4iLAogCQkJICAgICBiYXNlLCBzaXplLCBtdHJyX2F0dHJpYl90b19zdHIo
bHR5cGUpLApAQCAtMzY3LDEwICszODUsMTggQEAgaW50IG10cnJfYWRkX3BhZ2UodW5zaWduZWQg
bG9uZyBiYXNlLCB1bgogCQlnb3RvIG91dDsKIAl9CiAJLyogIFNlYXJjaCBmb3IgYW4gZW1wdHkg
TVRSUiAgKi8KLQlpID0gbXRycl9pZi0+Z2V0X2ZyZWVfcmVnaW9uKGJhc2UsIHNpemUpOworCWkg
PSBtdHJyX2lmLT5nZXRfZnJlZV9yZWdpb24oYmFzZSwgc2l6ZSwgcmVwbGFjZSk7CiAJaWYgKGkg
Pj0gMCkgewogCQlzZXRfbXRycihpLCBiYXNlLCBzaXplLCB0eXBlKTsKLQkJdXNhZ2VfdGFibGVb
aV0gPSAxOworCQlpZiAobGlrZWx5KHJlcGxhY2UgPCAwKSkKKwkJCXVzYWdlX3RhYmxlW2ldID0g
MTsKKwkJZWxzZSB7CisJCQl1c2FnZV90YWJsZVtpXSA9IHVzYWdlX3RhYmxlW3JlcGxhY2VdICsg
ISFpbmNyZW1lbnQ7CisJCQlpZiAodW5saWtlbHkocmVwbGFjZSAhPSBpKSkgeworCQkJCXNldF9t
dHJyKHJlcGxhY2UsIDAsIDAsIDApOworCQkJCXVzYWdlX3RhYmxlW3JlcGxhY2VdID0gMDsKKwkJ
CX0KKwkJfQogCX0gZWxzZQogCQlwcmludGsoS0VSTl9JTkZPICJtdHJyOiBubyBtb3JlIE1UUlJz
IGF2YWlsYWJsZVxuIik7CiAJZXJyb3IgPSBpOwpAQCAtNDQ3LDggKzQ3Myw3IEBAIGludCBtdHJy
X2RlbF9wYWdlKGludCByZWcsIHVuc2lnbmVkIGxvbmcKIHsKIAlpbnQgaSwgbWF4OwogCW10cnJf
dHlwZSBsdHlwZTsKLQl1bnNpZ25lZCBsb25nIGxiYXNlOwotCXVuc2lnbmVkIGludCBsc2l6ZTsK
Kwl1bnNpZ25lZCBsb25nIGxiYXNlLCBsc2l6ZTsKIAlpbnQgZXJyb3IgPSAtRUlOVkFMOwogCiAJ
aWYgKCFtdHJyX2lmKQpAQCAtNTU5LDcgKzU4NCw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbml0
X290aGVyX2NwdXModm9pZCkKIHN0cnVjdCBtdHJyX3ZhbHVlIHsKIAltdHJyX3R5cGUJbHR5cGU7
CiAJdW5zaWduZWQgbG9uZwlsYmFzZTsKLQl1bnNpZ25lZCBpbnQJbHNpemU7CisJdW5zaWduZWQg
bG9uZwlsc2l6ZTsKIH07CiAKIHN0YXRpYyBzdHJ1Y3QgbXRycl92YWx1ZSAqIG10cnJfc3RhdGU7
CmRpZmYgLWFwcnUgbGludXgtMi42LjkvYXJjaC9pMzg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmgg
bGludXgtMi42LjktbXRyci9hcmNoL2kzODYva2VybmVsL2NwdS9tdHJyL210cnIuaAotLS0gbGlu
dXgtMi42LjkvYXJjaC9pMzg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmgJMjAwNC0xMC0xOCAyMzo1
NTozNi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi45LW10cnIvYXJjaC9pMzg2L2tlcm5l
bC9jcHUvbXRyci9tdHJyLmgJMjAwNC0xMS0xMiAxNTo0NToxMi4xOTgxMjUzMjggKzAxMDAKQEAg
LTQzLDE1ICs0MywxNiBAQCBzdHJ1Y3QgbXRycl9vcHMgewogCXZvaWQJKCpzZXRfYWxsKSh2b2lk
KTsKIAogCXZvaWQJKCpnZXQpKHVuc2lnbmVkIGludCByZWcsIHVuc2lnbmVkIGxvbmcgKmJhc2Us
Ci0JCSAgICAgICB1bnNpZ25lZCBpbnQgKnNpemUsIG10cnJfdHlwZSAqIHR5cGUpOwotCWludAko
KmdldF9mcmVlX3JlZ2lvbikgKHVuc2lnbmVkIGxvbmcgYmFzZSwgdW5zaWduZWQgbG9uZyBzaXpl
KTsKLQorCQkgICAgICAgdW5zaWduZWQgbG9uZyAqc2l6ZSwgbXRycl90eXBlICogdHlwZSk7CisJ
aW50CSgqZ2V0X2ZyZWVfcmVnaW9uKSh1bnNpZ25lZCBsb25nIGJhc2UsIHVuc2lnbmVkIGxvbmcg
c2l6ZSwKKwkJCQkgICBpbnQgcmVwbGFjZV9yZWcpOwogCWludAkoKnZhbGlkYXRlX2FkZF9wYWdl
KSh1bnNpZ25lZCBsb25nIGJhc2UsIHVuc2lnbmVkIGxvbmcgc2l6ZSwKIAkJCQkgICAgIHVuc2ln
bmVkIGludCB0eXBlKTsKIAlpbnQJKCpoYXZlX3dyY29tYikodm9pZCk7CiB9OwogCi1leHRlcm4g
aW50IGdlbmVyaWNfZ2V0X2ZyZWVfcmVnaW9uKHVuc2lnbmVkIGxvbmcgYmFzZSwgdW5zaWduZWQg
bG9uZyBzaXplKTsKK2V4dGVybiBpbnQgZ2VuZXJpY19nZXRfZnJlZV9yZWdpb24odW5zaWduZWQg
bG9uZyBiYXNlLCB1bnNpZ25lZCBsb25nIHNpemUsCisJCQkJICAgaW50IHJlcGxhY2VfcmVnKTsK
IGV4dGVybiBpbnQgZ2VuZXJpY192YWxpZGF0ZV9hZGRfcGFnZSh1bnNpZ25lZCBsb25nIGJhc2Us
IHVuc2lnbmVkIGxvbmcgc2l6ZSwKIAkJCQkgICAgIHVuc2lnbmVkIGludCB0eXBlKTsKIAo=

--=__PartB4946CD8.0__=--
