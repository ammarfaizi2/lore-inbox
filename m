Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSHOCw3>; Wed, 14 Aug 2002 22:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSHOCw3>; Wed, 14 Aug 2002 22:52:29 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:52169 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316512AbSHOCw1>; Wed, 14 Aug 2002 22:52:27 -0400
Subject: [RFC] linux-2.4.20-pre2_tsc-disable_B11
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Aug 2002 19:40:51 -0700
Message-Id: <1029379252.962.62.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, 
	Just wanted to pass this by you quickly. First, forgive me: internally
we were having some problems with the last version of this patch that I
posted so I've been too busy hunting down the problem to include the
timer.c cleanups we discussed or sync it up w/ your tree. 

The problem is that with my patch on a summit based box, when
HyperThreading is disabled in the BIOS, the io_apic code bugs out when
calling timer_irq_works(). Ends up that after calling "mdelay((10 *
1000) / HZ);" we return and only 4 ticks have passed.

My suspicion is that when HT is disabled, the processor is less busy
switching between threads. Thus calls to mdelay(), which calls
__loop_delay() with my patch, execute faster then they should. 

However, I'm at a bit of a loss, because when HT is enabled, the CPUs
BogoMIPS (thus loops_per_jiffy) drops. This should mean when HT is off,
loops_per_jiffy should be larger, and thus mdelay should take longer.
Looking through the calibrate_delay and mdelay code I can't see anything
that seems off.

Anyway, my options to "just make it work" seem to be:

1) Use the unsynced TSC for udelay.
2) Just increase the time we wait in the io_apic code.

Since the first method breaks on multi-frequency SMP boxes, and is
totally broken with preempt, I opted for #2. While its not very
scientific, I'm not sure how much it matters, as the ioapic is just
checking to make sure the timer interrupt is working. Although I could
be totally wrong. 

Anyway, just wanted to mail you the patch and ask for comments as to
what you or anyone else might think the proper fix is.

thanks
-john


diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Wed Aug 14 19:14:10 2002
+++ b/Documentation/Configure.help	Wed Aug 14 19:14:10 2002
@@ -230,7 +230,21 @@
   network and embedded applications.  For more information see the
   Axis Communication site, <http://developer.axis.com/>.
 
-Multiquad support for NUMA systems
+Multi-node support for NUMA systems
+CONFIG_X86_NUMA
+  This option is used for getting Linux to run on a NUMA multi-node box. 
+  Because multi-node systems suffer from unsynced TSCs, as well as TSC 
+  drift, which can cause gettimeofday to return non-monotonic values, 
+  this option will turn off the CONFIG_X86_TSC optimization. This 
+  allows you to then specify "badtsc" as a boot option to force all nodes 
+  to use the PIT for gettimeofday. 
+  
+  Note: This does not disable access to the unsynced TSCs from userspace, 
+  thus applications using the rdtsc instruction for timing may have 
+  issues. To disable userspace access, instead of "badtsc" use the 
+  "notsc" boot option.
+  
+Multiquad support for NUMAQ systems
 CONFIG_MULTIQUAD
   This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
   multiquad box. This changes the way that processors are bootstrapped,
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Wed Aug 14 19:14:10 2002
+++ b/arch/i386/config.in	Wed Aug 14 19:14:10 2002
@@ -82,7 +82,7 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
@@ -90,14 +90,14 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
 if [ "$CONFIG_M686" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -106,7 +106,7 @@
 fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -114,7 +114,7 @@
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -123,12 +123,12 @@
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MK7" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
@@ -143,14 +143,14 @@
 fi
 if [ "$CONFIG_MCYRIXIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MCRUSOE" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MWINCHIPC6" = "y" ]; then
@@ -163,7 +163,7 @@
 if [ "$CONFIG_MWINCHIP2" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
    define_bool CONFIG_X86_F00F_WORKS_OK y
@@ -171,7 +171,7 @@
 if [ "$CONFIG_MWINCHIP3D" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
    define_bool CONFIG_X86_F00F_WORKS_OK y
@@ -216,8 +216,17 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
+   if [ "$CONFIG_X86_NUMA" = "y" ]; then
+      bool '  Multiquad (IBM/Sequent) NUMAQ support' CONFIG_MULTIQUAD
+   fi
 fi
+
+if [ "$CONFIG_X86_NUMA" != "y" -a "$CONFIG_X86_HAS_TSC" = "y" ]; then
+   define_bool CONFIG_X86_TSC y
+fi
+
+bool 'ISA bus support' CONFIG_ISA
 
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
    define_bool CONFIG_HAVE_DEC_LOCK y
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Wed Aug 14 19:14:10 2002
+++ b/arch/i386/kernel/io_apic.c	Wed Aug 14 19:14:10 2002
@@ -1141,8 +1141,8 @@
 	unsigned int t1 = jiffies;
 
 	sti();
-	/* Let ten ticks pass... */
-	mdelay((10 * 1000) / HZ);
+	/* Let fifteen ticks pass... */
+	mdelay((15 * 1000) / HZ);
 
 	/*
 	 * Expect a few ticks at least, to be sure some possible
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Wed Aug 14 19:14:10 2002
+++ b/arch/i386/kernel/time.c	Wed Aug 14 19:14:10 2002
@@ -69,6 +69,9 @@
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
+/*boot option flag to keep gettimeofday from using do_fastgettimeoffset */
+static int  bad_tsc __initdata = 0;
+
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
 
 /* Cached *multiplier* to convert TSC counts to microseconds.
@@ -634,6 +637,16 @@
 	return 0;
 }
 
+/* badtsc boot option: Used to keep do_gettimeofday from 
+ * using do_fast_gettimeoffset()
+ */
+static int __init bad_tsc_setup(char *str)
+{
+	bad_tsc = 1;
+	return 1;
+}
+__setup("badtsc", bad_tsc_setup);
+
 void __init time_init(void)
 {
 	extern int x86_udelay_tsc;
@@ -672,16 +685,17 @@
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
 			/*
 			 *	We could be more selective here I suspect
 			 *	and just enable this for the next intel chips ?
 			 */
-			x86_udelay_tsc = 1;
+			if(!bad_tsc){
+				use_tsc = 1;
+				x86_udelay_tsc = 1;
 #ifndef do_gettimeoffset
-			do_gettimeoffset = do_fast_gettimeoffset;
+				do_gettimeoffset = do_fast_gettimeoffset;
 #endif
-
+			}
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
 			 * clock/second. Our precision is about 100 ppm.

