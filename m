Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVCCEmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVCCEmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVCBWXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:23:41 -0500
Received: from hera.cwi.nl ([192.16.191.8]:62592 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262518AbVCBWVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:21:30 -0500
Date: Wed, 2 Mar 2005 23:21:06 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Andries Brouwer <Andries.Brouwer@cwi.nl>,
       torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
Message-ID: <20050302222106.GI20190@apps.cwi.nl>
References: <20050228192001.GA14221@apps.cwi.nl> <1109721162.15795.47.camel@localhost.localdomain> <20050302075037.GH20190@apps.cwi.nl> <20050302080255.GA28512@redhat.com> <1109771140.20986.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109771140.20986.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 01:45:43PM +0000, Alan Cox wrote:
> On Mer, 2005-03-02 at 08:02, Dave Jones wrote:
> > If there are any of them still being used out there, I'd be even
> > more surprised if they're running 2.6.  Then again, there are
> > probably loonies out there running it on 386/486's. 8-)
> 
> I have one here running 2.4 still. I can test a 2.6 fix for the mtrr
> init happily enough.

Good. If I understand things correctly - you or davej or someone will
correct me otherwise - failing to initialise mtrr does not break anything,
it would just mean slower access to certain kinds of memory for certain
kinds of access patterns. (Would you test using an X benchmark?)

Below roughly speaking the same patch as before, but with calls
to the cyrix and centaur mtrr init routines inserted.

Andries

-----

diff -uprN -X /linux/dontdiff a/arch/i386/kernel/cpu/mtrr/centaur.c b/arch/i386/kernel/cpu/mtrr/centaur.c
--- a/arch/i386/kernel/cpu/mtrr/centaur.c	2003-12-18 03:58:38.000000000 +0100
+++ b/arch/i386/kernel/cpu/mtrr/centaur.c	2005-03-02 23:22:10.000000000 +0100
@@ -86,6 +86,7 @@ static void centaur_set_mcr(unsigned int
 	centaur_mcr[reg].low = low;
 	wrmsr(MSR_IDT_MCR0 + reg, low, high);
 }
+
 /*
  *	Initialise the later (saner) Winchip MCR variant. In this version
  *	the BIOS can pass us the registers it has used (but not their values)
@@ -168,7 +169,7 @@ centaur_mcr0_init(void)
  *	Initialise Winchip series MCR registers
  */
 
-static void __init
+void __init
 centaur_mcr_init(void)
 {
 	struct set_mtrr_context ctxt;
@@ -203,7 +204,6 @@ static int centaur_validate_add_page(uns
 
 static struct mtrr_ops centaur_mtrr_ops = {
 	.vendor            = X86_VENDOR_CENTAUR,
-	.init              = centaur_mcr_init,
 	.set               = centaur_set_mcr,
 	.get               = centaur_get_mcr,
 	.get_free_region   = centaur_get_free_region,
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/cpu/mtrr/cyrix.c b/arch/i386/kernel/cpu/mtrr/cyrix.c
--- a/arch/i386/kernel/cpu/mtrr/cyrix.c	2003-12-18 03:58:56.000000000 +0100
+++ b/arch/i386/kernel/cpu/mtrr/cyrix.c	2005-03-02 23:22:40.000000000 +0100
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
@@ -257,7 +257,7 @@ static void cyrix_set_all(void)
  *   - (maybe) disable ARR3
  * Just to be sure, we enable ARR usage by the processor (CCR5 bit 5 set)
  */
-static void __init
+void __init
 cyrix_arr_init(void)
 {
 	struct set_mtrr_context ctxt;
@@ -344,7 +344,6 @@ cyrix_arr_init(void)
 
 static struct mtrr_ops cyrix_mtrr_ops = {
 	.vendor            = X86_VENDOR_CYRIX,
-	.init              = cyrix_arr_init,
 	.set_all	   = cyrix_set_all,
 	.set               = cyrix_set_arr,
 	.get               = cyrix_get_arr,
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/cpu/mtrr/generic.c b/arch/i386/kernel/cpu/mtrr/generic.c
--- a/arch/i386/kernel/cpu/mtrr/generic.c	2005-03-02 20:54:48.000000000 +0100
+++ b/arch/i386/kernel/cpu/mtrr/generic.c	2005-03-02 20:56:19.000000000 +0100
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
+++ b/arch/i386/kernel/cpu/mtrr/main.c	2005-03-02 23:21:46.000000000 +0100
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
 
@@ -526,6 +522,8 @@ EXPORT_SYMBOL(mtrr_del);
  * These should be called implicitly, but we can't yet until all the initcall
  * stuff is done...
  */
+extern void centaur_mcr_init(void);
+extern void cyrix_arr_init(void);
 extern void amd_init_mtrr(void);
 extern void cyrix_init_mtrr(void);
 extern void centaur_init_mtrr(void);
@@ -665,6 +663,7 @@ static int __init mtrr_init(void)
 			break;
 		case X86_VENDOR_CENTAUR:
 			if (cpu_has_centaur_mcr) {
+				centaur_mcr_init();
 				mtrr_if = mtrr_ops[X86_VENDOR_CENTAUR];
 				size_or_mask = 0xfff00000;	/* 32 bits */
 				size_and_mask = 0;
@@ -672,6 +671,7 @@ static int __init mtrr_init(void)
 			break;
 		case X86_VENDOR_CYRIX:
 			if (cpu_has_cyrix_arr) {
+				cyrix_arr_init();
 				mtrr_if = mtrr_ops[X86_VENDOR_CYRIX];
 				size_or_mask = 0xfff00000;	/* 32 bits */
 				size_and_mask = 0;
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/cpu/mtrr/mtrr.h b/arch/i386/kernel/cpu/mtrr/mtrr.h
--- a/arch/i386/kernel/cpu/mtrr/mtrr.h	2004-10-30 21:43:59.000000000 +0200
+++ b/arch/i386/kernel/cpu/mtrr/mtrr.h	2005-03-02 23:17:52.000000000 +0100
@@ -37,7 +37,6 @@ typedef u8 mtrr_type;
 struct mtrr_ops {
 	u32	vendor;
 	u32	use_intel_if;
-	void	(*init)(void);
 	void	(*set)(unsigned int reg, unsigned long base,
 		       unsigned long size, mtrr_type type);
 	void	(*set_all)(void);
@@ -57,7 +56,6 @@ extern int generic_validate_add_page(uns
 
 extern struct mtrr_ops generic_mtrr_ops;
 
-extern int generic_have_wrcomb(void);
 extern int positive_have_wrcomb(void);
 
 /* library functions for processor-specific routines */
@@ -96,4 +94,3 @@ void finalize_mtrr_state(void);
 void mtrr_state_warn(void);
 char *mtrr_attrib_to_str(int x);
 
-extern char * mtrr_if_name[];

