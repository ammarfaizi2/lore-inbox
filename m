Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288092AbSAQCYm>; Wed, 16 Jan 2002 21:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288112AbSAQCYd>; Wed, 16 Jan 2002 21:24:33 -0500
Received: from air-1.osdl.org ([65.201.151.5]:46607 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S288092AbSAQCYU>;
	Wed, 16 Jan 2002 21:24:20 -0500
Date: Wed, 16 Jan 2002 18:21:42 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
cc: <linux-kernel@vger.kernel.org>, <large-discuss@lists.sourceforge.net>,
        Heiko Carstens <Heiko.Carstens@de.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        Anton Blanchard <antonb@au1.ibm.com>,
        Greg Kroah-Hartman <ghartman@us.ibm.com>, <rusty@rustcorp.com.au>
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.5.0
In-Reply-To: <20011219160402.3D14.K-SUGANUMA@mvj.biglobe.ne.jp>
Message-ID: <Pine.LNX.4.33L2.0201161815580.13155-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

I've identified and fixed the problems on x86.
There were problems in arch/i386/kernel/mtrr.c and bluesmoke.c.

In both cases, the problems are with __init functions
and/or __initdata.

Patch is at end of email.  CPU online/offline support now works
with mtrr.c and bluesmoke.c in my testing.

This patch is against Linux 2.5.0 plus your version 0.7
2.5.0 hotplug cpu patch (from sf.net/projects/lhcs).

Thanks,
~Randy

On Wed, 19 Dec 2001, Kimio Suganuma wrote:

| Hi,
|
| As you mentioned, CPU online caused panic when MTRR was on
| on my system. I've only tested with no MTRR configuration. :-(
| I'll investigate the problem but I'm not sure I can find
| a resolution. (I know nothing about MTRR... )
| Does anybody have an idea for the problem?
|
| Thanks,
| Kimi
|
| On Tue, 18 Dec 2001 18:29:30 -0800 (PST)
| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
|
| > Hi,
| >
| > I applied this patch to Linux 2.5.0 and tried to use it on
| > a 2-way x86 system with dual Intel Pentium III's (1 GHz).
| > Results:
| >   echo 0 > /proc/sys/kernel/cpu/1/online
| > seems to work: "top" stops reporting about the second CPU.
| >
| > However,
| >   echo 1 > /proc/sys/kernel/cpu/1/online
| > results in an Oops in set_mtrr_var_range_testing().
| >
| > (same oops that I had encountered when I ported the 2.4.5
| > patch to 2.4.13)
| >
| > Does this work for you?  I can connect a serial console to
| > it and provide you with a complete oops report if you want
| > that, and I'm available to help work on it.
| >
| > In linux/arch/i386/kernel/mtrr.c, the functions
| >   set_mtrr_var_range_testing() and
| >   set_mtrr_fixed_testing()
| > need to have the "__init" removed from them, but this
| > doesn't fix the oops problem.
| >
| > Thanks,
| > --
| > ~Randy


--- linux-250/arch/i386/kernel/mtrr.c	Mon Dec 17 17:45:35 2001
+++ linux-250-cpu/arch/i386/kernel/mtrr.c	Wed Jan 16 16:19:44 2002
@@ -839,7 +839,7 @@

 /*  Set the MSR pair relating to a var range. Returns TRUE if
     changes are made  */
-static int __init set_mtrr_var_range_testing (unsigned int index,
+static int set_mtrr_var_range_testing (unsigned int index,
 						  struct mtrr_var_range *vr)
 {
     unsigned int lo, hi;
@@ -877,7 +877,7 @@
 	rdmsr(MTRRfix4K_C0000_MSR + i, p[6 + i*2], p[7 + i*2]);
 }   /*  End Function get_fixed_ranges  */

-static int __init set_fixed_ranges_testing(mtrr_type *frs)
+static int set_fixed_ranges_testing(mtrr_type *frs)
 {
     unsigned long *p = (unsigned long *)frs;
     int changed = FALSE;
@@ -949,7 +949,7 @@
 /*  Free resources associated with a struct mtrr_state  */
 static void __init finalize_mtrr_state(struct mtrr_state *state)
 {
-    if (state->var_ranges) kfree (state->var_ranges);
+    /* NOT for cpu online/offline support: if (state->var_ranges) kfree (state->var_ranges); */
 }   /*  End Function finalize_mtrr_state  */


@@ -1876,13 +1876,13 @@
     mtrr_type type;
 } arr_state_t;

-arr_state_t arr_state[8] __initdata =
+arr_state_t arr_state[8] =
 {
     {0UL,0UL,0UL}, {0UL,0UL,0UL}, {0UL,0UL,0UL}, {0UL,0UL,0UL},
     {0UL,0UL,0UL}, {0UL,0UL,0UL}, {0UL,0UL,0UL}, {0UL,0UL,0UL}
 };

-unsigned char ccr_state[7] __initdata = { 0, 0, 0, 0, 0, 0, 0 };
+unsigned char ccr_state[7] = { 0, 0, 0, 0, 0, 0, 0 };

 static void cyrix_arr_init_secondary(void)
 {
@@ -2170,8 +2170,8 @@

 #ifdef CONFIG_SMP

-static volatile unsigned long smp_changes_mask __initdata = 0;
-static struct mtrr_state smp_mtrr_state __initdata = {0, 0};
+static volatile unsigned long smp_changes_mask = 0;
+static struct mtrr_state smp_mtrr_state = {0, 0};

 void __init mtrr_init_boot_cpu(void)
 {
--- linux-250/arch/i386/kernel/bluesmoke.c.org	Tue Jan 15 14:55:38 2002
+++ linux-250-cpu/arch/i386/kernel/bluesmoke.c	Wed Jan 16 17:52:26 2002
@@ -10,7 +10,7 @@
 #include <asm/processor.h>
 #include <asm/msr.h>

-static int mce_disabled __initdata = 0;
+static int mce_disabled = 0;

 /*
  *	Machine Check Handler For PII/PIII
@@ -120,7 +120,7 @@
  *	Set up machine check reporting for Intel processors
  */

-static void __init intel_mcheck_init(struct cpuinfo_x86 *c)
+static void intel_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
@@ -191,7 +191,7 @@
  *	Set up machine check reporting on the Winchip C6 series
  */

-static void __init winchip_mcheck_init(struct cpuinfo_x86 *c)
+static void winchip_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 lo, hi;
 	/* Not supported on C3 */

