Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbQKOUku>; Wed, 15 Nov 2000 15:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129671AbQKOUkl>; Wed, 15 Nov 2000 15:40:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10762 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129636AbQKOUkX>; Wed, 15 Nov 2000 15:40:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: test11-pre5, Athlon, and Machine Check Architecture
Date: 15 Nov 2000 12:09:55 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uuqij$ejs$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friends,

I noticed a slight bug in my CPUID 2.4.0-test11-pre5, and when I
unwound it, found some interesting things.

This relates to the Machine Check Architecture code (bluesmoke.c),
which in the previous code was conditionalized on running on an Intel
CPU.  It appears that that shouldn't be necessary.

However, since at least AMD Athlon actually advertises MCA, I would
like to verify that the code works on these processors before
submitting it to Linus.  Most importantly, of course, that it doesn't
crash; I don't expect anyone to actually see an #MF exception in real
life.  I'm trying to get confirmation from AMD that the code should
be correct even for Athlon.

If it *doesn't* work, there are two possibilities:

a) Athlon is advertising a capability it doesn't have, or implements
   incorrectly.  This can be handled in setup.c as an Athlon bug.
b) Athlon is implementing a by-the-(Intel-)book correct version of MCA
   that still differs in the details from Intel, and the code isn't
   handling that correctly.  This would be a bluesmoke.c bug and
   should be fixed there.

So I would really appreciate if Athlon-equipped people would test this
patch (against 2.4.0-test11-pre5), and also if there are AMD people
that could comment on their implementation of MCA, I would really
appreciate it.

In the future, if I get around to it, I might also extend bluesmoke.c
to handle the case of a processor which implements MCE but not MCA (in
which case you get the exception that something died, but no
information about what caused it.)

This patch is also available at:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/cpuid-2.4.0-test11-pre5-1.diff

Thanks,

	-hpa

--- include/asm-i386/cpufeature.h.old	Wed Nov 15 11:24:21 2000
+++ include/asm-i386/cpufeature.h	Wed Nov 15 11:35:10 2000
@@ -20,7 +20,7 @@
 #define X86_FEATURE_TSC		(0*32+ 4) /* Time Stamp Counter */
 #define X86_FEATURE_MSR		(0*32+ 5) /* Model-Specific Registers, RDMSR, WRMSR */
 #define X86_FEATURE_PAE		(0*32+ 6) /* Physical Address Extensions */
-#define X86_FEATURE_MCE		(0*32+ 7) /* Machine Check Architecture */
+#define X86_FEATURE_MCE		(0*32+ 7) /* Machine Check Exception */
 #define X86_FEATURE_CX8		(0*32+ 8) /* CMPXCHG8 instruction */
 #define X86_FEATURE_APIC	(0*32+ 9) /* Onboard APIC */
 #define X86_FEATURE_SEP		(0*32+11) /* SYSENTER/SYSEXIT */
--- arch/i386/kernel/bluesmoke.c.old	Wed Nov 15 11:31:55 2000
+++ arch/i386/kernel/bluesmoke.c	Wed Nov 15 11:34:21 2000
@@ -72,10 +72,12 @@
 	int i;
 	static int done;
 
-	if( c->x86_vendor != X86_VENDOR_INTEL )
-		return;
-	
-	if( !test_bit(X86_FEATURE_TSC, &c->x86_capability) )
+	/* We should not check for vendor here.  The MCA capability
+	   bit, below, should only be set if the CPU has the Intel
+	   Machine Check Architecture (it's up to identify_cpu() to
+	   make sure that is true! */
+
+	if( !test_bit(X86_FEATURE_MCE, &c->x86_capability) )
 		return;
 		
 	if( !test_bit(X86_FEATURE_MCA, &c->x86_capability) )
--- arch/i386/kernel/setup.c.old	Wed Nov 15 11:24:19 2000
+++ arch/i386/kernel/setup.c	Wed Nov 15 11:37:38 2000
@@ -1483,7 +1483,6 @@
 #ifndef CONFIG_M686
 	static int f00f_workaround_enabled = 0;
 #endif
-	extern void mcheck_init(struct cpuinfo_x86 *c);
 	char *p = NULL;
 
 #ifndef CONFIG_M686
@@ -1575,9 +1574,6 @@
 
 	if ( p )
 		strcpy(c->x86_model_id, p);
-
-	/* Enable MCA if available */
-	mcheck_init(c);
 }
 
 void __init get_cpu_vendor(struct cpuinfo_x86 *c)
@@ -1797,6 +1793,8 @@
 	return have_cpuid_p();	/* Check to see if CPUID now enabled? */
 }
 
+extern void mcheck_init(struct cpuinfo_x86 *c);
+
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -1919,6 +1917,9 @@
 	 * The vendor-specific functions might have changed features.  Now
 	 * we do "generic changes."
 	 */
+
+	/* Enable Machine Check Architecture if appropriate */
+	mcheck_init(c);
 
 	/* TSC disabled? */
 #ifdef CONFIG_TSC
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
