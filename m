Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278683AbRJXRsf>; Wed, 24 Oct 2001 13:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278682AbRJXRsR>; Wed, 24 Oct 2001 13:48:17 -0400
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:28337 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S278680AbRJXRsA>; Wed, 24 Oct 2001 13:48:00 -0400
Date: Wed, 24 Oct 2001 18:49:39 +0100
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cachesize detection & MCA cleanup.
Message-ID: <20011024184939.A5980@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 Patch below adds boottime argument for cachesize detection
fixup for buggy Intel P3 Tualatins. (More info available at
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=53736 )

Also cleans up the machine check architecture initialisation,
and makes some extra functions static/__init

regards,

Dave.


--- linux/arch/i386/kernel/setup.c	Mon Oct 15 21:43:24 2001
+++ linux-dj/arch/i386/kernel/setup.c	Tue Oct 23 19:06:49 2001
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
-void __init add_memory_region(unsigned long long start,
+static void __init add_memory_region(unsigned long long start,
                                   unsigned long long size, int type)
 {
 	int x = e820.nr_map;
@@ -667,7 +549,7 @@
  */
 #define LOWMEMSIZE()	(0x9f000)
 
-void __init setup_memory_region(void)
+static void __init setup_memory_region(void)
 {
 	char *who = "BIOS-e820";
 
@@ -699,7 +581,7 @@
 } /* setup_memory_region */
 
 
-static inline void parse_mem_cmdline (char ** cmdline_p)
+static void __init parse_mem_cmdline (char ** cmdline_p)
 {
 	char c = ' ', *to = command_line, *from = COMMAND_LINE;
 	int len = 0;
@@ -1036,6 +922,15 @@
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
 
@@ -1106,12 +1027,25 @@
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
 
@@ -1252,7 +1186,6 @@
 			break;
 
 		case 6:	/* An Athlon/Duron. We can trust the BIOS probably */
-			mcheck_init(c);
 			break;		
 	}
 
@@ -1263,11 +1196,11 @@
 /*
  * Read Cyrix DEVID registers (DIR) to get more detailed info. about the CPU
  */
-static void do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
+static void __init do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
 {
 	unsigned char ccr2, ccr3;
 	unsigned long flags;
-
+	
 	/* we test for DEVID by checking whether CCR3 is writable */
 	local_irq_save(flags);
 	ccr3 = getCx86(CX86_CCR3);
@@ -1303,7 +1236,7 @@
  * Actually since bugs.h doesnt even reference this perhaps someone should
  * fix the documentation ???
  */
-unsigned char Cx86_dir0_msb __initdata = 0;
+static unsigned char Cx86_dir0_msb __initdata = 0;
 
 static char Cx86_model[][9] __initdata = {
 	"Cx486", "Cx486", "5x86 ", "6x86", "MediaGX ", "6x86MX ",
@@ -1336,7 +1269,7 @@
 static void __init check_cx686_slop(struct cpuinfo_x86 *c)
 {
 	unsigned long flags;
-
+	
 	if (Cx86_dir0_msb == 3) {
 		unsigned char ccr3, ccr5;
 
@@ -1599,7 +1813,6 @@
 				c->x86_cache_size = (cc>>24)+(dd>>24);
 			}
 			sprintf( c->x86_model_id, "WinChip %s", name );
-			mcheck_init(c);
 			break;
 
 		case 6:
@@ -1885,7 +2108,6 @@
 		strcpy(c->x86_model_id, p);
 
 	/* Enable MCA if available */
-	mcheck_init(c);
 }
 
 void __init get_cpu_vendor(struct cpuinfo_x86 *c)
@@ -2021,14 +2243,14 @@
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
@@ -2123,7 +2345,6 @@
    	        {
 			unsigned char ccr3, ccr4;
 			unsigned long flags;
-
 			printk(KERN_INFO "Enabling CPUID on Cyrix processor.\n");
 			local_irq_save(flags);
 			ccr3 = getCx86(CX86_CCR3);
@@ -2266,7 +2487,7 @@
 		init_rise(c);
 		break;
 	}
-	
+
 	printk(KERN_DEBUG "CPU: After vendor init, caps: %08x %08x %08x %08x\n",
 	       c->x86_capability[0],
 	       c->x86_capability[1],
@@ -2293,6 +2514,9 @@
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
