Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSHHCEY>; Wed, 7 Aug 2002 22:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSHHCEY>; Wed, 7 Aug 2002 22:04:24 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:35730 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317253AbSHHCEW>; Wed, 7 Aug 2002 22:04:22 -0400
Subject: [PATCH] tsc-disable_B9
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Aug 2002 18:53:34 -0700
Message-Id: <1028771615.22918.188.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, 

	Here is my latest revision of tsc-disable. It includes CodingStyle
changes suggested by Christoph and George Anzinger, as well moving some
of the changes around to accommodate my cyclone-timer patch (which I'll
post in a second). 

As I said before: This patch enables a workaround for multi-node NUMA
systems that are experiencing gettimeofday returning "old" time values.
Because these systems are frequently driven by different crystals, the
CPUs vary slightly in frequency causing the TSCs to drift apart. Thus it
is possible for gettimeofday to return time values behind time values
already seen on another cpu. This patch allows people compiling w/
'Multi-node NUMA support' to pass "notsc" or "bad-tsc" as boot
parameters. "notsc" disables rdtsc calls, and forces the kernel to use
the PIT for gettimeofday calucluations (as normally expected w/ i386
compiled kernels). While "bad-tsc" forces the kernel to use the PIT for
gettimeofday, but does not disable TSC access. 

Comments, suggestions and flames welcome.

thanks
-john

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Wed Aug  7 17:26:31 2002
+++ b/Documentation/Configure.help	Wed Aug  7 17:26:31 2002
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
+  allows you to then specify "bad-tsc" as a boot option to force all nodes 
+  to use the PIT for gettimeofday. 
+  
+  Note: This does not disable access to the unsynced TSCs from userspace, 
+  thus applications using the rdtsc instruction for timing may have 
+  issues. To disable userspace access, instead of "bad-tsc" use the 
+  "notsc" boot option.
+  
+Multiquad support for NUMAQ systems
 CONFIG_MULTIQUAD
   This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
   multiquad box. This changes the way that processors are bootstrapped,
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Wed Aug  7 17:26:31 2002
+++ b/arch/i386/config.in	Wed Aug  7 17:26:31 2002
@@ -79,20 +79,20 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_PPRO_FENCE y
 fi
 if [ "$CONFIG_M586MMX" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PPRO_FENCE y
 fi
 if [ "$CONFIG_M686" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -100,14 +100,14 @@
 fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -115,12 +115,12 @@
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
@@ -133,14 +133,14 @@
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
 fi
 if [ "$CONFIG_MWINCHIPC6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -151,14 +151,14 @@
 if [ "$CONFIG_MWINCHIP2" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
 fi
 if [ "$CONFIG_MWINCHIP3D" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
 fi
@@ -202,7 +202,14 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
+   if [ "$CONFIG_X86_NUMA" = "y" ]; then
+      bool '  Multiquad (IBM/Sequent) NUMAQ support' CONFIG_MULTIQUAD
+   fi
+fi
+
+if [ "$CONFIG_X86_NUMA" != "y" -a "$CONFIG_X86_HAS_TSC" = "y" ]; then
+   define_bool CONFIG_X86_TSC y
 fi
 
 bool 'ISA bus support' CONFIG_ISA
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Wed Aug  7 17:26:31 2002
+++ b/arch/i386/kernel/time.c	Wed Aug  7 17:26:31 2002
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
 
+/* bad-tsc boot option: Used to keep do_gettimeofday from 
+ * using do_fast_gettimeoffset()
+ */
+static int __init bad_tsc_setup(char *str)
+{
+	bad_tsc = 1;
+	return 1;
+}
+__setup("bad-tsc", bad_tsc_setup);
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

