Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131229AbRAOUfF>; Mon, 15 Jan 2001 15:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131436AbRAOUe4>; Mon, 15 Jan 2001 15:34:56 -0500
Received: from [62.172.234.2] ([62.172.234.2]:14721 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131229AbRAOUej>; Mon, 15 Jan 2001 15:34:39 -0500
Date: Mon, 15 Jan 2001 20:33:17 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386/setup.c cpuinfo notsc
In-Reply-To: <Pine.LNX.4.10.10101112018220.28973-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101152017450.1032-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Linus Torvalds wrote
(under Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"):
> 
> We _want_ /proc/cpuinfo to reflect the fact that the kernel considers
> FSXR/XMM to not exist. That is true information, and is in fact something
> that install scripts etc can find extremely useful.
> 
> [snip]
>
> Similarly, when we disable TSC, it's also telling user-land that this
> machine does not appear to have a working TSC for some reason. User-land
> applications may also care about the fact that TSC seems to skip time if
> the machine is idle etc (which was apparently the problem with some broken
> Cyrix chips).

That's how "notsc" used to behave, but since 2.4.0-test11
"notsc" has left "tsc" in /proc/cpuinfo.  setup.c has a bogus
"#ifdef CONFIG_TSC" which should be "#ifndef CONFIG_X86_TSC".

HPA, Maciej and I discussed that around 5 Dec 2000; but HPA
was of Andrea's persuasion, that we should not mask caps out
of (real CPU entries in) /proc/cpuinfo, so we made no change.

In discussion we found a more worrying error in the SMP case:
boot_cpu_data is supposed to be left with those x86_capabilities
common to all CPUs, but the code to do so was unaware that
boot_cpu_data is overwritten in booting each CPU.  Even if all
CPUs have the same features, I imagine the Linux-defined ones
(CXMMX, K6_MTRR, CYRIX_ARR, CENTAUR_MCR) were unintentionally
masked out of the final boot_cpu_data.

The patch below fixes both those issues, and also clears
"pse" from /proc/cpuinfo in the same way if "mem=nopentium".
Tempted to rename "tsc_disable" to "disable_x86_tsc", but resisted.

I think there are still anomalies in the Cyrix and Centaur TSC
handling - shouldn't dodgy_tsc() check Centaur too?  shouldn't
we set X86_CR4_TSD wherever we clear X86_FEATURE_TSC? - but I
don't have those CPUs to test, I'm wary of disabling TSC since
finding RH7.0 installed on i686 needs rdtsc to run /sbin/init,
and even if they are wrong then "notsc" corrects the situation:
not 2.4.1 material.

Hugh

--- linux-2.4.1-pre3/arch/i386/kernel/setup.c	Fri Jan 12 15:20:33 2001
+++ linux/arch/i386/kernel/setup.c	Mon Jan 15 18:07:15 2001
@@ -148,6 +148,7 @@
 
 static int disable_x86_serial_nr __initdata = 1;
 static int disable_x86_fxsr __initdata = 0;
+static int disable_x86_pse __initdata = 0;
 
 /*
  * This is set up by the setup-routine at boot-time
@@ -550,6 +551,7 @@
 			if (!memcmp(from+4, "nopentium", 9)) {
 				from += 9+4;
 				clear_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability);
+				disable_x86_pse = 1;
 			} else if (!memcmp(from+4, "exactmap", 8)) {
 				from += 8+4;
 				e820.nr_map = 0;
@@ -1884,6 +1886,9 @@
 	return have_cpuid_p();	/* Check to see if CPUID now enabled? */
 }
 
+static __u32 common_x86_capability[NCAPINTS] __initdata = {
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff };
+
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -2007,8 +2012,12 @@
 	 * we do "generic changes."
 	 */
 
+	/* PSE disabled? */
+	if (disable_x86_pse)
+		clear_bit(X86_FEATURE_PSE, &c->x86_capability);
+
 	/* TSC disabled? */
-#ifdef CONFIG_TSC
+#ifndef CONFIG_X86_TSC
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
 #endif
@@ -2043,16 +2052,13 @@
 	       c->x86_capability[3]);
 
 	/*
-	 * On SMP, boot_cpu_data holds the common feature set between
-	 * all CPUs; so make sure that we indicate which features are
-	 * common between the CPUs.  The first time this routine gets
-	 * executed, c == &boot_cpu_data.
+	 * On SMP, boot_cpu_data is to hold the feature set common
+	 * between all CPUs.  But boot_cpu_data is rewritten by each CPU
+	 * as it boots, so overwrite that with common features each time.
 	 */
-	if ( c != &boot_cpu_data ) {
-		/* AND the already accumulated flags with these */
-		for ( i = 0 ; i < NCAPINTS ; i++ )
-			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
-	}
+	for ( i = 0 ; i < NCAPINTS ; i++ )
+		boot_cpu_data.x86_capability[i] =
+		common_x86_capability[i] &= c->x86_capability[i];
 
 	printk("CPU: Common caps: %08x %08x %08x %08x\n",
 	       boot_cpu_data.x86_capability[0],

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
