Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVELJOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVELJOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 05:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVELJOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 05:14:34 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:43298
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261365AbVELJIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 05:08:05 -0400
Message-Id: <s2832b02.028@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 11:08:21 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] enhance x86 MTRR handling
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartA1826D15.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartA1826D15.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

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

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/amd.c linux-2.6.=
12-rc4/arch/i386/kernel/cpu/mtrr/amd.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/amd.c	2005-03-02 =
08:38:09.000000000 +0100
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/amd.c	2005-03-15 =
14:43:04.000000000 +0100
@@ -7,7 +7,7 @@
=20
 static void
 amd_get_mtrr(unsigned int reg, unsigned long *base,
-	     unsigned int *size, mtrr_type * type)
+	     unsigned long *size, mtrr_type * type)
 {
 	unsigned long low, high;
=20
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/centaur.c =
linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/centaur.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/centaur.c	2005-05-11 =
17:27:52.195258960 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/centaur.c	2005-05-11 =
17:50:43.188836256 +0200
@@ -17,7 +17,7 @@ static u8 centaur_mcr_type;	/* 0 for win
  */
=20
 static int
-centaur_get_free_region(unsigned long base, unsigned long size)
+centaur_get_free_region(unsigned long base, unsigned long size, int =
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
=20
 	max =3D num_var_ranges;
+	if (replace_reg >=3D 0 && replace_reg < max)
+		return replace_reg;
 	for (i =3D 0; i < max; ++i) {
 		if (centaur_mcr_reserved & (1 << i))
 			continue;
@@ -49,7 +50,7 @@ mtrr_centaur_report_mcr(int mcr, u32 lo,
=20
 static void
 centaur_get_mcr(unsigned int reg, unsigned long *base,
-		unsigned int *size, mtrr_type * type)
+		unsigned long *size, mtrr_type * type)
 {
 	*base =3D centaur_mcr[reg].high >> PAGE_SHIFT;
 	*size =3D -(centaur_mcr[reg].low & 0xfffff000) >> PAGE_SHIFT;
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/cyrix.c =
linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/cyrix.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/cyrix.c	2005-05-11 =
17:27:52.197258656 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/cyrix.c	2005-05-11 =
17:50:43.191835800 +0200
@@ -9,7 +9,7 @@ int arr3_protected;
=20
 static void
 cyrix_get_arr(unsigned int reg, unsigned long *base,
-	      unsigned int *size, mtrr_type * type)
+	      unsigned long *size, mtrr_type * type)
 {
 	unsigned long flags;
 	unsigned char arr, ccr3, rcr, shift;
@@ -77,7 +77,7 @@ cyrix_get_arr(unsigned int reg, unsigned
 }
=20
 static int
-cyrix_get_free_region(unsigned long base, unsigned long size)
+cyrix_get_free_region(unsigned long base, unsigned long size, int =
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
=20
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
 	/* If we are to set up a region >32M then look at ARR7 immediately =
*/
 	if (size > 0x2000) {
 		cyrix_get_arr(7, &lbase, &lsize, &ltype);
@@ -214,7 +229,7 @@ static void cyrix_set_arr(unsigned int r
=20
 typedef struct {
 	unsigned long base;
-	unsigned int size;
+	unsigned long size;
 	mtrr_type type;
 } arr_state_t;
=20
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/generic.c =
linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/generic.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/generic.c	2005-05-11 =
17:27:52.199258352 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/generic.c	2005-05-11 =
17:53:17.944309848 +0200
@@ -103,7 +103,7 @@ void mtrr_wrmsr(unsigned msr, unsigned a
 			smp_processor_id(), msr, a, b);
 }
=20
-int generic_get_free_region(unsigned long base, unsigned long size)
+int generic_get_free_region(unsigned long base, unsigned long size, int =
replace_reg)
 /*  [SUMMARY] Get a free MTRR.
     <base> The starting (base) address of the region.
     <size> The size (in bytes) of the region.
@@ -112,10 +112,11 @@ int generic_get_free_region(unsigned lon
 {
 	int i, max;
 	mtrr_type ltype;
-	unsigned long lbase;
-	unsigned lsize;
+	unsigned long lbase, lsize;
=20
 	max =3D num_var_ranges;
+	if (replace_reg >=3D 0 && replace_reg < max)
+		return replace_reg;
 	for (i =3D 0; i < max; ++i) {
 		mtrr_if->get(i, &lbase, &lsize, &ltype);
 		if (lsize =3D=3D 0)
@@ -125,7 +126,7 @@ int generic_get_free_region(unsigned lon
 }
=20
 static void generic_get_mtrr(unsigned int reg, unsigned long *base,
-			     unsigned int *size, mtrr_type * type)
+			     unsigned long *size, mtrr_type *type)
 {
 	unsigned int mask_lo, mask_hi, base_lo, base_hi;
=20
@@ -210,7 +211,9 @@ static int set_mtrr_var_ranges(unsigned=20
 	return changed;
 }
=20
-static unsigned long set_mtrr_state(u32 deftype_lo, u32 deftype_hi)
+static u32 deftype_lo, deftype_hi;
+
+static unsigned long set_mtrr_state(void)
 /*  [SUMMARY] Set the MTRR state for this CPU.
     <state> The MTRR state information to read.
     <ctxt> Some relevant CPU context.
@@ -232,7 +235,7 @@ static unsigned long set_mtrr_state(u32=20
 	   so to set it we fiddle with the saved value  */
 	if ((deftype_lo & 0xff) !=3D mtrr_state.def_type
 	    || ((deftype_lo & 0xc00) >> 10) !=3D mtrr_state.enabled) {
-		deftype_lo |=3D (mtrr_state.def_type | mtrr_state.enabled =
<< 10);
+		deftype_lo =3D (deftype_lo & ~0xcff) | mtrr_state.def_type =
| (mtrr_state.enabled << 10);
 		change_mask |=3D MTRR_CHANGE_MASK_DEFTYPE;
 	}
=20
@@ -241,7 +244,6 @@ static unsigned long set_mtrr_state(u32=20
=20
=20
 static unsigned long cr4 =3D 0;
-static u32 deftype_lo, deftype_hi;
 static DEFINE_SPINLOCK(set_atomicity_lock);
=20
 /*
@@ -279,7 +281,7 @@ static void prepare_set(void)
 	rdmsr(MTRRdefType_MSR, deftype_lo, deftype_hi);
=20
 	/*  Disable MTRRs, and set the default type to uncached  */
-	mtrr_wrmsr(MTRRdefType_MSR, deftype_lo & 0xf300UL, deftype_hi);
+	mtrr_wrmsr(MTRRdefType_MSR, deftype_lo & ~0xcff, deftype_hi);
 }
=20
 static void post_set(void)
@@ -308,7 +310,7 @@ static void generic_set_all(void)
 	prepare_set();
=20
 	/* Actually set the state */
-	mask =3D set_mtrr_state(deftype_lo,deftype_hi);
+	mask =3D set_mtrr_state();
=20
 	post_set();
 	local_irq_restore(flags);
@@ -375,7 +377,7 @@ int generic_validate_add_page(unsigned l
 		}
 	}
=20
-	if (base + size < 0x100) {
+	if (base < 0x100) {
 		printk(KERN_WARNING "mtrr: cannot set region below 1 MiB =
(0x%lx000,0x%lx000)\n",
 		       base, size);
 		return -EINVAL;
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/if.c linux-2.6.1=
2-rc4/arch/i386/kernel/cpu/mtrr/if.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/if.c	2005-05-11 =
17:27:52.201258048 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/if.c	2005-05-11 =
17:50:43.233829416 +0200
@@ -155,6 +155,7 @@ mtrr_ioctl(struct inode *inode, struct f
 {
 	int err;
 	mtrr_type type;
+	unsigned long size;
 	struct mtrr_sentry sentry;
 	struct mtrr_gentry gentry;
 	void __user *arg =3D (void __user *) __arg;
@@ -205,15 +206,15 @@ mtrr_ioctl(struct inode *inode, struct f
 			return -EFAULT;
 		if (gentry.regnum >=3D num_var_ranges)
 			return -EINVAL;
-		mtrr_if->get(gentry.regnum, &gentry.base, &gentry.size, =
&type);
+		mtrr_if->get(gentry.regnum, &gentry.base, &size, &type);
=20
 		/* Hide entries that go above 4GB */
-		if (gentry.base + gentry.size > 0x100000
-		    || gentry.size =3D=3D 0x100000)
+		if (gentry.base + size - 1 >=3D (1UL << (8 * sizeof(gentry.=
size) - PAGE_SHIFT))
+		    || size >=3D (1UL << (8 * sizeof(gentry.size) - =
PAGE_SHIFT)))
 			gentry.base =3D gentry.size =3D gentry.type =3D 0;
 		else {
 			gentry.base <<=3D PAGE_SHIFT;
-			gentry.size <<=3D PAGE_SHIFT;
+			gentry.size =3D size << PAGE_SHIFT;
 			gentry.type =3D type;
 		}
=20
@@ -263,8 +264,14 @@ mtrr_ioctl(struct inode *inode, struct f
 			return -EFAULT;
 		if (gentry.regnum >=3D num_var_ranges)
 			return -EINVAL;
-		mtrr_if->get(gentry.regnum, &gentry.base, &gentry.size, =
&type);
-		gentry.type =3D type;
+		mtrr_if->get(gentry.regnum, &gentry.base, &size, &type);
+		/* Hide entries that would overflow */
+		if (size !=3D (__typeof__(gentry.size))size)
+			gentry.base =3D gentry.size =3D gentry.type =3D 0;
+		else {
+			gentry.size =3D size;
+			gentry.type =3D type;
+		}
=20
 		if (copy_to_user(arg, &gentry, sizeof gentry))
 			return -EFAULT;
@@ -323,8 +330,7 @@ static int mtrr_seq_show(struct seq_file
 	char factor;
 	int i, max, len;
 	mtrr_type type;
-	unsigned long base;
-	unsigned int size;
+	unsigned long base, size;
=20
 	len =3D 0;
 	max =3D num_var_ranges;
@@ -343,7 +349,7 @@ static int mtrr_seq_show(struct seq_file
 			}
 			/* RED-PEN: base can be > 32bit */=20
 			len +=3D seq_printf(seq,=20
-				   "reg%02i: base=3D0x%05lx000 (%4liMB), =
size=3D%4i%cB: %s, count=3D%d\n",
+				   "reg%02i: base=3D0x%05lx000 (%4luMB), =
size=3D%4lu%cB: %s, count=3D%d\n",
 			     i, base, base >> (20 - PAGE_SHIFT), size, =
factor,
 			     mtrr_attrib_to_str(type), usage_table[i]);
 		}
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/main.c =
linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/main.c	2005-05-11 =
17:27:52.203257744 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/main.c	2005-05-11 =
17:50:43.238828656 +0200
@@ -169,6 +169,13 @@ static void ipi_handler(void *info)
=20
 #endif
=20
+static inline int types_compatible(mtrr_type type1, mtrr_type type2) {
+	return type1 =3D=3D MTRR_TYPE_UNCACHABLE ||
+	       type2 =3D=3D MTRR_TYPE_UNCACHABLE ||
+	       (type1 =3D=3D MTRR_TYPE_WRTHROUGH && type2 =3D=3D MTRR_TYPE_=
WRBACK) ||
+	       (type1 =3D=3D MTRR_TYPE_WRBACK && type2 =3D=3D MTRR_TYPE_WRT=
HROUGH);
+}
+
 /**
  * set_mtrr - update mtrrs on all processors
  * @reg:	mtrr in question
@@ -301,11 +308,9 @@ static void set_mtrr(unsigned int reg, u
 int mtrr_add_page(unsigned long base, unsigned long size,=20
 		  unsigned int type, char increment)
 {
-	int i;
+	int i, replace, error;
 	mtrr_type ltype;
-	unsigned long lbase;
-	unsigned int lsize;
-	int error;
+	unsigned long lbase, lsize;
=20
 	if (!mtrr_if)
 		return -ENXIO;
@@ -325,32 +330,45 @@ int mtrr_add_page(unsigned long base, un
 		return -ENOSYS;
 	}
=20
+	if (!size) {
+		printk(KERN_WARNING "mtrr: zero sized request\n");
+		return -EINVAL;
+	}
+
 	if (base & size_or_mask || size & size_or_mask) {
 		printk(KERN_WARNING "mtrr: base or size exceeds the MTRR =
width\n");
 		return -EINVAL;
 	}
=20
 	error =3D -EINVAL;
+	replace =3D -1;
=20
 	/*  Search for existing MTRR  */
 	down(&main_lock);
 	for (i =3D 0; i < num_var_ranges; ++i) {
 		mtrr_if->get(i, &lbase, &lsize, &ltype);
-		if (base >=3D lbase + lsize)
-			continue;
-		if ((base < lbase) && (base + size <=3D lbase))
+		if (!lsize || base > lbase + lsize - 1 || base + size - 1 =
< lbase)
 			continue;
 		/*  At this point we know there is some kind of overlap/enc=
losure  */
-		if ((base < lbase) || (base + size > lbase + lsize)) {
+		if (base < lbase || base + size - 1 > lbase + lsize - 1) {
+			if (base <=3D lbase && base + size - 1 >=3D lbase =
+ lsize - 1) {
+				/*  New region encloses an existing region =
 */
+				if (type =3D=3D ltype) {
+					replace =3D replace =3D=3D -1 ? i =
: -2;
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
 		if (ltype !=3D type) {
-			if (type =3D=3D MTRR_TYPE_UNCACHABLE)
+			if (types_compatible(type, ltype))
 				continue;
 			printk (KERN_WARNING "mtrr: type mismatch for =
%lx000,%lx000 old: %s new: %s\n",
 			     base, size, mtrr_attrib_to_str(ltype),
@@ -363,10 +381,18 @@ int mtrr_add_page(unsigned long base, un
 		goto out;
 	}
 	/*  Search for an empty MTRR  */
-	i =3D mtrr_if->get_free_region(base, size);
+	i =3D mtrr_if->get_free_region(base, size, replace);
 	if (i >=3D 0) {
 		set_mtrr(i, base, size, type);
-		usage_table[i] =3D 1;
+		if (likely(replace < 0))
+			usage_table[i] =3D 1;
+		else {
+			usage_table[i] =3D usage_table[replace] + =
!!increment;
+			if (unlikely(replace !=3D i)) {
+				set_mtrr(replace, 0, 0, 0);
+				usage_table[replace] =3D 0;
+			}
+		}
 	} else
 		printk(KERN_INFO "mtrr: no more MTRRs available\n");
 	error =3D i;
@@ -443,8 +469,7 @@ int mtrr_del_page(int reg, unsigned long
 {
 	int i, max;
 	mtrr_type ltype;
-	unsigned long lbase;
-	unsigned int lsize;
+	unsigned long lbase, lsize;
 	int error =3D -EINVAL;
=20
 	if (!mtrr_if)
@@ -555,7 +580,7 @@ static void __init init_other_cpus(void)
 struct mtrr_value {
 	mtrr_type	ltype;
 	unsigned long	lbase;
-	unsigned int	lsize;
+	unsigned long	lsize;
 };
=20
 static struct mtrr_value * mtrr_state;
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/mtrr.h =
linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/mtrr.h
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/mtrr.h	2005-05-11 =
17:27:52.205257440 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/mtrr.h	2005-05-11 =
17:50:43.241828200 +0200
@@ -43,15 +43,16 @@ struct mtrr_ops {
 	void	(*set_all)(void);
=20
 	void	(*get)(unsigned int reg, unsigned long *base,
-		       unsigned int *size, mtrr_type * type);
-	int	(*get_free_region) (unsigned long base, unsigned long =
size);
-
+		       unsigned long *size, mtrr_type * type);
+	int	(*get_free_region)(unsigned long base, unsigned long size,
+				   int replace_reg);
 	int	(*validate_add_page)(unsigned long base, unsigned long =
size,
 				     unsigned int type);
 	int	(*have_wrcomb)(void);
 };
=20
-extern int generic_get_free_region(unsigned long base, unsigned long =
size);
+extern int generic_get_free_region(unsigned long base, unsigned long =
size,
+				   int replace_reg);
 extern int generic_validate_add_page(unsigned long base, unsigned long =
size,
 				     unsigned int type);
=20


--=__PartA1826D15.0__=
Content-Type: text/plain; name="linux-2.6.12-rc4-x86-mtrr.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-x86-mtrr.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

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

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/amd.c linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/amd.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/amd.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/amd.c	2005-03-15 14:43:04.000000000 +0100
@@ -7,7 +7,7 @@
 
 static void
 amd_get_mtrr(unsigned int reg, unsigned long *base,
-	     unsigned int *size, mtrr_type * type)
+	     unsigned long *size, mtrr_type * type)
 {
 	unsigned long low, high;
 
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/centaur.c linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/centaur.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/centaur.c	2005-05-11 17:27:52.195258960 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/centaur.c	2005-05-11 17:50:43.188836256 +0200
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
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/cyrix.c linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/cyrix.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/cyrix.c	2005-05-11 17:27:52.197258656 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/cyrix.c	2005-05-11 17:50:43.191835800 +0200
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
 
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/generic.c linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/generic.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/generic.c	2005-05-11 17:27:52.199258352 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/generic.c	2005-05-11 17:53:17.944309848 +0200
@@ -103,7 +103,7 @@ void mtrr_wrmsr(unsigned msr, unsigned a
 			smp_processor_id(), msr, a, b);
 }
 
-int generic_get_free_region(unsigned long base, unsigned long size)
+int generic_get_free_region(unsigned long base, unsigned long size, int replace_reg)
 /*  [SUMMARY] Get a free MTRR.
     <base> The starting (base) address of the region.
     <size> The size (in bytes) of the region.
@@ -112,10 +112,11 @@ int generic_get_free_region(unsigned lon
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
@@ -125,7 +126,7 @@ int generic_get_free_region(unsigned lon
 }
 
 static void generic_get_mtrr(unsigned int reg, unsigned long *base,
-			     unsigned int *size, mtrr_type * type)
+			     unsigned long *size, mtrr_type *type)
 {
 	unsigned int mask_lo, mask_hi, base_lo, base_hi;
 
@@ -210,7 +211,9 @@ static int set_mtrr_var_ranges(unsigned 
 	return changed;
 }
 
-static unsigned long set_mtrr_state(u32 deftype_lo, u32 deftype_hi)
+static u32 deftype_lo, deftype_hi;
+
+static unsigned long set_mtrr_state(void)
 /*  [SUMMARY] Set the MTRR state for this CPU.
     <state> The MTRR state information to read.
     <ctxt> Some relevant CPU context.
@@ -232,7 +235,7 @@ static unsigned long set_mtrr_state(u32 
 	   so to set it we fiddle with the saved value  */
 	if ((deftype_lo & 0xff) != mtrr_state.def_type
 	    || ((deftype_lo & 0xc00) >> 10) != mtrr_state.enabled) {
-		deftype_lo |= (mtrr_state.def_type | mtrr_state.enabled << 10);
+		deftype_lo = (deftype_lo & ~0xcff) | mtrr_state.def_type | (mtrr_state.enabled << 10);
 		change_mask |= MTRR_CHANGE_MASK_DEFTYPE;
 	}
 
@@ -241,7 +244,6 @@ static unsigned long set_mtrr_state(u32 
 
 
 static unsigned long cr4 = 0;
-static u32 deftype_lo, deftype_hi;
 static DEFINE_SPINLOCK(set_atomicity_lock);
 
 /*
@@ -279,7 +281,7 @@ static void prepare_set(void)
 	rdmsr(MTRRdefType_MSR, deftype_lo, deftype_hi);
 
 	/*  Disable MTRRs, and set the default type to uncached  */
-	mtrr_wrmsr(MTRRdefType_MSR, deftype_lo & 0xf300UL, deftype_hi);
+	mtrr_wrmsr(MTRRdefType_MSR, deftype_lo & ~0xcff, deftype_hi);
 }
 
 static void post_set(void)
@@ -308,7 +310,7 @@ static void generic_set_all(void)
 	prepare_set();
 
 	/* Actually set the state */
-	mask = set_mtrr_state(deftype_lo,deftype_hi);
+	mask = set_mtrr_state();
 
 	post_set();
 	local_irq_restore(flags);
@@ -375,7 +377,7 @@ int generic_validate_add_page(unsigned l
 		}
 	}
 
-	if (base + size < 0x100) {
+	if (base < 0x100) {
 		printk(KERN_WARNING "mtrr: cannot set region below 1 MiB (0x%lx000,0x%lx000)\n",
 		       base, size);
 		return -EINVAL;
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/if.c linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/if.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/if.c	2005-05-11 17:27:52.201258048 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/if.c	2005-05-11 17:50:43.233829416 +0200
@@ -155,6 +155,7 @@ mtrr_ioctl(struct inode *inode, struct f
 {
 	int err;
 	mtrr_type type;
+	unsigned long size;
 	struct mtrr_sentry sentry;
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
@@ -205,15 +206,15 @@ mtrr_ioctl(struct inode *inode, struct f
 			return -EFAULT;
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
 
@@ -263,8 +264,14 @@ mtrr_ioctl(struct inode *inode, struct f
 			return -EFAULT;
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
 
 		if (copy_to_user(arg, &gentry, sizeof gentry))
 			return -EFAULT;
@@ -323,8 +330,7 @@ static int mtrr_seq_show(struct seq_file
 	char factor;
 	int i, max, len;
 	mtrr_type type;
-	unsigned long base;
-	unsigned int size;
+	unsigned long base, size;
 
 	len = 0;
 	max = num_var_ranges;
@@ -343,7 +349,7 @@ static int mtrr_seq_show(struct seq_file
 			}
 			/* RED-PEN: base can be > 32bit */ 
 			len += seq_printf(seq, 
-				   "reg%02i: base=0x%05lx000 (%4liMB), size=%4i%cB: %s, count=%d\n",
+				   "reg%02i: base=0x%05lx000 (%4luMB), size=%4lu%cB: %s, count=%d\n",
 			     i, base, base >> (20 - PAGE_SHIFT), size, factor,
 			     mtrr_attrib_to_str(type), usage_table[i]);
 		}
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/main.c linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/main.c	2005-05-11 17:27:52.203257744 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/main.c	2005-05-11 17:50:43.238828656 +0200
@@ -169,6 +169,13 @@ static void ipi_handler(void *info)
 
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
@@ -301,11 +308,9 @@ static void set_mtrr(unsigned int reg, u
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
@@ -325,32 +330,45 @@ int mtrr_add_page(unsigned long base, un
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
 
 	/*  Search for existing MTRR  */
 	down(&main_lock);
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
@@ -363,10 +381,18 @@ int mtrr_add_page(unsigned long base, un
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
@@ -443,8 +469,7 @@ int mtrr_del_page(int reg, unsigned long
 {
 	int i, max;
 	mtrr_type ltype;
-	unsigned long lbase;
-	unsigned int lsize;
+	unsigned long lbase, lsize;
 	int error = -EINVAL;
 
 	if (!mtrr_if)
@@ -555,7 +580,7 @@ static void __init init_other_cpus(void)
 struct mtrr_value {
 	mtrr_type	ltype;
 	unsigned long	lbase;
-	unsigned int	lsize;
+	unsigned long	lsize;
 };
 
 static struct mtrr_value * mtrr_state;
diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/mtrr.h linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/mtrr.h
--- linux-2.6.12-rc4.base/arch/i386/kernel/cpu/mtrr/mtrr.h	2005-05-11 17:27:52.205257440 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/cpu/mtrr/mtrr.h	2005-05-11 17:50:43.241828200 +0200
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
 

--=__PartA1826D15.0__=--
