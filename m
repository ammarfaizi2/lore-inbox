Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280900AbRKCAuf>; Fri, 2 Nov 2001 19:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280903AbRKCAuR>; Fri, 2 Nov 2001 19:50:17 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:5816 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S280902AbRKCAuH>; Fri, 2 Nov 2001 19:50:07 -0500
Date: Sat, 3 Nov 2001 00:50:39 +0000 (GMT)
From: Dave Jones <davej@suse.de>
X-X-Sender: <davej@noodles.codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] More setup.c bits from -ac
Message-ID: <Pine.LNX.4.33.0111030047020.25694-100000@noodles.codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,
 patch below brings .14pre in sync with -ac, and adds..

- 'cachesize' bootflag to work around buggy P3 Tualatins.
- Some functions made static
- Unifies machine check architecture setup.

no reported problems since they went into -ac.

regards,

Dave.


diff -urN --exclude-from=/home/davej/.exclude linux-2.4.14-pre6/arch/i386/kernel/setup.c linux-2.4.13-ac6/arch/i386/kernel/setup.c
--- linux-2.4.14-pre6/arch/i386/kernel/setup.c	Sat Nov  3 00:08:02 2001
+++ linux-2.4.13-ac6/arch/i386/kernel/setup.c	Sat Nov  3 00:24:55 2001
@@ -67,6 +67,10 @@
  *
  *  AMD Athlon/Duron/Thunderbird bluesmoke support.
  *  Dave Jones <davej@suse.de>, April 2001.
+ *
+ *  CacheSize bug workaround updates for AMD, Intel & VIA Cyrix.
+ *  Dave Jones <davej@suse.de>, September, October 2001.
+ *
  */

 /*
@@ -1035,6 +1045,15 @@
 #endif
 }

+static int cachesize_override __initdata = -1;
+static int __init cachesize_setup(char *str)
+{
+	get_option (&str, &cachesize_override);
+	return 1;
+}
+__setup("cachesize=", cachesize_setup);
+
+
 #ifndef CONFIG_X86_TSC
 static int tsc_disable __initdata = 0;

@@ -1105,12 +1150,25 @@
 			l2size = 256;
 	}

+	/* Intel PIII Tualatin. This comes in two flavours.
+	 * One has 256kb of cache, the other 512. We have no way
+	 * to determine which, so we use a boottime override
+	 * for the 512kb model, and assume 256 otherwise.
+	 */
+	if ((c->x86_vendor == X86_VENDOR_INTEL) && (c->x86 == 6) &&
+		(c->x86_model == 11) && (l2size == 0))
+		l2size = 256;
+
 	/* VIA C3 CPUs (670-68F) need further shifting. */
 	if (c->x86_vendor == X86_VENDOR_CENTAUR && (c->x86 == 6) &&
 		((c->x86_model == 7) || (c->x86_model == 8))) {
 		l2size = l2size >> 8;
 	}

+	/* Allow user to override all this if necessary. */
+	if (cachesize_override != -1)
+		l2size = cachesize_override;
+
 	if ( l2size == 0 )
 		return;		/* Again, no L2 cache is possible */

@@ -1251,7 +1309,6 @@
 			break;

 		case 6:	/* An Athlon/Duron. We can trust the BIOS probably */
-			mcheck_init(c);
 			break;
 	}

@@ -1879,7 +1936,6 @@
 				c->x86_cache_size = (cc>>24)+(dd>>24);
 			}
 			sprintf( c->x86_model_id, "WinChip %s", name );
-			mcheck_init(c);
 			break;

 		case 6:
@@ -2165,7 +2231,6 @@
 		strcpy(c->x86_model_id, p);

 	/* Enable MCA if available */
-	mcheck_init(c);
 }

 void __init get_cpu_vendor(struct cpuinfo_x86 *c)
@@ -2301,14 +2366,14 @@
 }


-int __init x86_serial_nr_setup(char *s)
+static int __init x86_serial_nr_setup(char *s)
 {
 	disable_x86_serial_nr = 0;
 	return 1;
 }
 __setup("serialnumber", x86_serial_nr_setup);

-int __init x86_fxsr_setup(char * s)
+static int __init x86_fxsr_setup(char * s)
 {
 	disable_x86_fxsr = 1;
 	return 1;
@@ -2403,7 +2468,6 @@
    	        {
 			unsigned char ccr3, ccr4;
 			unsigned long flags;
-
 			printk(KERN_INFO "Enabling CPUID on Cyrix processor.\n");
 			local_irq_save(flags);
 			ccr3 = getCx86(CX86_CCR3);
@@ -2546,7 +2610,7 @@
 		init_rise(c);
 		break;
 	}
-
+
 	printk(KERN_DEBUG "CPU: After vendor init, caps: %08x %08x %08x %08x\n",
 	       c->x86_capability[0],
 	       c->x86_capability[1],
@@ -2573,6 +2637,9 @@
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);

+	/* Init Machine Check Exception if available. */
+	mcheck_init(c);
+
 	/* If the model name is still unset, do table lookup. */
 	if ( !c->x86_model_id[0] ) {
 		char *p;


-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .

