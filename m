Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318928AbSHEXI3>; Mon, 5 Aug 2002 19:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318901AbSHEXI3>; Mon, 5 Aug 2002 19:08:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:18620 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318930AbSHEXIY>;
	Mon, 5 Aug 2002 19:08:24 -0400
Subject: [PATCH] tsc-disable_B7
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Cc: Leah Cunningham <leahc@us.ibm.com>, wilhelm.nuesser@sap.com,
       paramjit@us.ibm.com
Content-Type: multipart/mixed; boundary="=-3mfmRLwjPUxVzEkzmafq"
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Aug 2002 15:58:07 -0700
Message-Id: <1028588288.1073.42.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3mfmRLwjPUxVzEkzmafq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Marcelo,
	This patch enables a workaround for multi-node NUMA systems that are
experiencing gettimeofday returning "old" time values. Because these
systems are frequently driven by different crystals, the CPUs vary
slightly in frequency causing the TSCs to drift apart. Thus it is
possible for gettimeofday to return time values behind time values
already seen on another cpu. This patch allows people compiling w/
'Multi-node NUMA support' to pass "notsc" or "bad-tsc" as boot
parameters. "notsc" disables rdtsc calls, and forces the kernel to use
the PIT for gettimeofday calucluations (as normally expected w/ i386
compiled kernels). While "bad-tsc" forces the kernel to use the PIT for
gettimeofday, but does not disable TSC access. 

Thanks to Matt Wilson for suggestions on this revision.

Comments, suggestions and flames welcome.

thanks
-john



--=-3mfmRLwjPUxVzEkzmafq
Content-Disposition: attachment; filename=linux-2.4.19_tsc-disable_B7.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=linux-2.4.19_tsc-disable_B7.patch; charset=ISO-8859-1

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Mon Aug  5 15:41:40 2002
+++ b/Documentation/Configure.help	Mon Aug  5 15:41:40 2002
@@ -233,7 +233,21 @@
   network and embedded applications.  For more information see the
   Axis Communication site, <http://developer.axis.com/>.
=20
-Multiquad support for NUMA systems
+Multi-node support for NUMA systems
+CONFIG_X86_NUMA
+  This option is used for getting Linux to run on a NUMA multi-node box.=20
+  Because multi-node systems suffer from unsynced TSCs, as well as TSC=20
+  drift, which can cause gettimeofday to return non-monotonic values,=20
+  this option will turn off the CONFIG_X86_TSC optimization. This=20
+  allows you to then specify "bad-tsc" as a boot option to force all nodes=
=20
+  to use the PIT for gettimeofday.=20
+ =20
+  Note: This does not disable access to the unsynced TSCs from userspace,=20
+  thus applications using the rdtsc instruction for timing may have=20
+  issues. To disable userspace access, instead of "bad-tsc" use the=20
+  "notsc" boot option.
+ =20
+Multiquad support for NUMAQ systems
 CONFIG_MULTIQUAD
   This option is used for getting Linux to run on a (IBM/Sequent) NUMA=20
   multiquad box. This changes the way that processors are bootstrapped,
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Mon Aug  5 15:41:40 2002
+++ b/arch/i386/config.in	Mon Aug  5 15:41:40 2002
@@ -80,20 +80,20 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_PPRO_FENCE y
 fi
 if [ "$CONFIG_M586MMX" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PPRO_FENCE y
 fi
 if [ "$CONFIG_M686" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -101,14 +101,14 @@
 fi
 if [ "$CONFIG_MPENTIUMIII" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MPENTIUM4" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -116,12 +116,12 @@
 if [ "$CONFIG_MK6" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MK7" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
@@ -134,14 +134,14 @@
 fi
 if [ "$CONFIG_MCYRIXIII" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MCRUSOE" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
 fi
 if [ "$CONFIG_MWINCHIPC6" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -152,14 +152,14 @@
 if [ "$CONFIG_MWINCHIP2" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
 fi
 if [ "$CONFIG_MWINCHIP3D" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
 fi
@@ -198,8 +198,20 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+	bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
+	if [ "$CONFIG_X86_NUMA" =3D "y" ]; then
+		bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_MULTIQUAD
+	fi
 fi
+
+if [ "$CONFIG_X86_HAS_TSC" =3D "y" ]; then
+	if [ "$CONFIG_X86_NUMA" =3D "y" ]; then
+		define_bool CONFIG_X86_TSC n
+	else
+		define_bool CONFIG_X86_TSC y
+	fi
+fi
+
=20
 if [ "$CONFIG_SMP" =3D "y" -a "$CONFIG_X86_CMPXCHG" =3D "y" ]; then
    define_bool CONFIG_HAVE_DEC_LOCK y
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Aug  5 15:41:40 2002
+++ b/arch/i386/kernel/time.c	Mon Aug  5 15:41:40 2002
@@ -569,6 +569,15 @@
 #define CALIBRATE_LATCH	(5 * LATCH)
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
=20
+static int  bad_tsc __initdata =3D 0;
+static int __init bad_tsc_setup(char *str)
+{
+	bad_tsc =3D 1;
+	return 1;
+}
+__setup("bad-tsc", bad_tsc_setup);
+
+
 static unsigned long __init calibrate_tsc(void)
 {
        /* Set the Gate high, disable speaker */
@@ -672,16 +681,17 @@
 		unsigned long tsc_quotient =3D calibrate_tsc();
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient =3D tsc_quotient;
-			use_tsc =3D 1;
 			/*
 			 *	We could be more selective here I suspect
 			 *	and just enable this for the next intel chips ?
 			 */
-			x86_udelay_tsc =3D 1;
-#ifndef do_gettimeoffset
-			do_gettimeoffset =3D do_fast_gettimeoffset;
-#endif
-
+			if(!bad_tsc){
+				use_tsc =3D 1;
+				x86_udelay_tsc =3D 1;
+				#ifndef do_gettimeoffset
+				do_gettimeoffset =3D do_fast_gettimeoffset;
+				#endif
+			}
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =3D
 			 * clock/second. Our precision is about 100 ppm.

--=-3mfmRLwjPUxVzEkzmafq--

