Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVB1TVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVB1TVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVB1TVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:21:48 -0500
Received: from hera.cwi.nl ([192.16.191.8]:23275 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261726AbVB1TUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 14:20:10 -0500
Date: Mon, 28 Feb 2005 20:20:03 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove dead cyrix/centaur mtrr init code
Message-ID: <20050228192001.GA14221@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are several cases where __init function pointers are
stored in a general purpose struct. For example, a SCSI
template may contain a __init detect function.
Have not yet thought of an elegant way to avoid this.

One such case is the mtrr code, where struct mtrr_ops has an
init field pointing at __init functions. Unless I overlook
something, this case may be easy to settle, since the .init
field is never used.

The patch below comments out the declaration and initialisation
of the .init field of struct mtrr_ops, and puts #if 0 ... #endif
around the centaur_mcr_init() and cyrix_arr_init() code.

Simultaneously a number of variables are made static.

Andries

-----

diff -uprN -X /linux/dontdiff a/arch/i386/kernel/cpu/mtrr/centaur.c b/arch/i386/kernel/cpu/mtrr/centaur.c
--- a/arch/i386/kernel/cpu/mtrr/centaur.c	2003-12-18 03:58:38.000000000 +0100
+++ b/arch/i386/kernel/cpu/mtrr/centaur.c	2005-02-28 20:21:05.000000000 +0100
@@ -86,6 +86,8 @@ static void centaur_set_mcr(unsigned int
 	centaur_mcr[reg].low = low;
 	wrmsr(MSR_IDT_MCR0 + reg, low, high);
 }
+
+#if 0
 /*
  *	Initialise the later (saner) Winchip MCR variant. In this version
  *	the BIOS can pass us the registers it has used (but not their values)
@@ -183,6 +185,7 @@ centaur_mcr_init(void)
 
 	set_mtrr_done(&ctxt);
 }
+#endif
 
 static int centaur_validate_add_page(unsigned long base, 
 				     unsigned long size, unsigned int type)
@@ -203,7 +206,7 @@ static int centaur_validate_add_page(uns
 
 static struct mtrr_ops centaur_mtrr_ops = {
 	.vendor            = X86_VENDOR_CENTAUR,
-	.init              = centaur_mcr_init,
+//	.init              = centaur_mcr_init,
 	.set               = centaur_set_mcr,
 	.get               = centaur_get_mcr,
 	.get_free_region   = centaur_get_free_region,
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/cpu/mtrr/cyrix.c b/arch/i386/kernel/cpu/mtrr/cyrix.c
--- a/arch/i386/kernel/cpu/mtrr/cyrix.c	2003-12-18 03:58:56.000000000 +0100
+++ b/arch/i386/kernel/cpu/mtrr/cyrix.c	2005-02-28 20:19:25.000000000 +0100
@@ -218,12 +218,12 @@ typedef struct {
 	mtrr_type type;
 } arr_state_t;
 
-arr_state_t arr_state[8] __initdata = {
+static arr_state_t arr_state[8] __initdata = {
 	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL},
 	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}
 };
 
-unsigned char ccr_state[7] __initdata = { 0, 0, 0, 0, 0, 0, 0 };
+static unsigned char ccr_state[7] __initdata = { 0, 0, 0, 0, 0, 0, 0 };
 
 static void cyrix_set_all(void)
 {
@@ -243,6 +243,7 @@ static void cyrix_set_all(void)
 	post_set();
 }
 
+#if 0
 /*
  * On Cyrix 6x86(MX) and M II the ARR3 is special: it has connection
  * with the SMM (System Management Mode) mode. So we need the following:
@@ -341,10 +342,11 @@ cyrix_arr_init(void)
 	if (ccrc[6])
 		printk(KERN_INFO "mtrr: ARR3 was write protected, unprotected\n");
 }
+#endif
 
 static struct mtrr_ops cyrix_mtrr_ops = {
 	.vendor            = X86_VENDOR_CYRIX,
-	.init              = cyrix_arr_init,
+//	.init              = cyrix_arr_init,
 	.set_all	   = cyrix_set_all,
 	.set               = cyrix_set_arr,
 	.get               = cyrix_get_arr,
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/cpu/mtrr/generic.c b/arch/i386/kernel/cpu/mtrr/generic.c
--- a/arch/i386/kernel/cpu/mtrr/generic.c	2005-02-26 12:13:28.000000000 +0100
+++ b/arch/i386/kernel/cpu/mtrr/generic.c	2005-02-28 20:19:25.000000000 +0100
@@ -19,8 +19,7 @@ struct mtrr_state {
 };
 
 static unsigned long smp_changes_mask;
-struct mtrr_state mtrr_state = {};
-
+static struct mtrr_state mtrr_state = {};
 
 /*  Get the MSR pair relating to a var range  */
 static void __init
@@ -383,7 +382,7 @@ int generic_validate_add_page(unsigned l
 }
 
 
-int generic_have_wrcomb(void)
+static int generic_have_wrcomb(void)
 {
 	unsigned long config, dummy;
 	rdmsr(MTRRcap_MSR, config, dummy);
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/cpu/mtrr/main.c b/arch/i386/kernel/cpu/mtrr/main.c
--- a/arch/i386/kernel/cpu/mtrr/main.c	2004-12-29 03:39:42.000000000 +0100
+++ b/arch/i386/kernel/cpu/mtrr/main.c	2005-02-28 20:19:25.000000000 +0100
@@ -57,10 +57,6 @@ static struct mtrr_ops * mtrr_ops[X86_VE
 
 struct mtrr_ops * mtrr_if = NULL;
 
-__initdata char *mtrr_if_name[] = {
-    "none", "Intel", "AMD K6", "Cyrix ARR", "Centaur MCR"
-};
-
 static void set_mtrr(unsigned int reg, unsigned long base,
 		     unsigned long size, mtrr_type type);
 
@@ -100,7 +96,7 @@ static int have_wrcomb(void)
 }
 
 /*  This function returns the number of variable MTRRs  */
-void __init set_num_var_ranges(void)
+static void __init set_num_var_ranges(void)
 {
 	unsigned long config = 0, dummy;
 
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/cpu/mtrr/mtrr.h b/arch/i386/kernel/cpu/mtrr/mtrr.h
--- a/arch/i386/kernel/cpu/mtrr/mtrr.h	2004-10-30 21:43:59.000000000 +0200
+++ b/arch/i386/kernel/cpu/mtrr/mtrr.h	2005-02-28 20:19:25.000000000 +0100
@@ -37,7 +37,7 @@ typedef u8 mtrr_type;
 struct mtrr_ops {
 	u32	vendor;
 	u32	use_intel_if;
-	void	(*init)(void);
+//	void	(*init)(void);
 	void	(*set)(unsigned int reg, unsigned long base,
 		       unsigned long size, mtrr_type type);
 	void	(*set_all)(void);
@@ -57,7 +57,6 @@ extern int generic_validate_add_page(uns
 
 extern struct mtrr_ops generic_mtrr_ops;
 
-extern int generic_have_wrcomb(void);
 extern int positive_have_wrcomb(void);
 
 /* library functions for processor-specific routines */
@@ -96,4 +95,3 @@ void finalize_mtrr_state(void);
 void mtrr_state_warn(void);
 char *mtrr_attrib_to_str(int x);
 
-extern char * mtrr_if_name[];
