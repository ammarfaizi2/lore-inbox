Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317720AbSFSBDq>; Tue, 18 Jun 2002 21:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317721AbSFSBDp>; Tue, 18 Jun 2002 21:03:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8581 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317720AbSFSBDo>;
	Tue, 18 Jun 2002 21:03:44 -0400
Subject: [RFC] [PATCH] tsc-disable_A6
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, mikpe@csd.uu.se,
       vojtech@suse.cz
Content-Type: multipart/mixed; boundary="=-bsm4PCPsDfbLUmbi6MVK"
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 17:55:19 -0700
Message-Id: <1024448124.3030.139.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bsm4PCPsDfbLUmbi6MVK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey Marcelo, all,

	Here is the next revision of my tsc-disable patch. Thanks to everyone
for providing feedback. I will re-submit this for the 2.4.20pre series,
but wanted to get this out for additional comments as well as warn folks
who might be trying this or my previous patch. This version reverts to
the earlier implementation, which only changes config.in. I feel that
defining CONFIG_X86_HAS_TSC gives one the ability to discern between
just having a TSC and having a usable TSC, and all the current code that
uses CONFIG_X86_TSC assumes that it is usable. This way seems cleaner
and has all the benefits of the last method. Additionally I added the
previously forgotten Configure.help documentation, for which I should no
doubt receive a ruler across the knuckles.

	One semi-large (now documented in Configure.help :)caveat I found: on
systems which have glibc compiled for i686, kernels built with my old
patch would not boot. This is because disabling the tsc makes rdtsc a
privileged operation. When the kernel tries to run init, it hits the
rdtsc in glibc and dies. Therefore in this version you must enable the
option, then pass "notsc" to the kernel at boot. That way, if you run
into problems you can just remove the "notsc" option and get your system
running. Installing a non i686 optimized glibc solves this problem. 

	Next, at Benjamin and Kurt's suggestion, I'm going to start looking
into per-cpu TSC management, but for now this patch gives an immediate
fix for a known problem (at some cost to performance, but slow numbers
are better then invalid ones). 

	I know I'm going to get this comment, so I might as well deal with it
now. "Why bother with this patch when you could just compile the kernel
for 386 the net effect would be the same?" Good question, actually. I
almost decided against sending this patch out, but the ability to use
processor optimizations other then CONFIG_X86_TSC seems useful on these
large systems. Additionally having this issue explicitly documented in
the kernel might help those who are wondering why their shiny NUMA
Pentium 4 system can't seem to read its watch properly (rather then
having someone say "just compile for 386" and having them think "but its
a Pentium 4!").

comments and flames welcome.
-john



--=-bsm4PCPsDfbLUmbi6MVK
Content-Disposition: attachment; filename=linux-2.4.19-pre10_tsc-disable_A6.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=linux-2.4.19-pre10_tsc-disable_A6.patch;
	charset=ISO-8859-1

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Tue Jun 18 16:43:28 2002
+++ b/Documentation/Configure.help	Tue Jun 18 16:43:28 2002
@@ -233,7 +233,24 @@
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
+  allows you to then specify "notsc" as a boot option to force all nodes=20
+  to use the PIC for gettimeofday.=20
+ =20
+  WARNING!!! This option, along with specifying "notsc" at boot causes=20
+  the rdtsc instruction to be a privledged op. Your glibc may be=20
+  compiled for i686, in which case applications using that library will=20
+  crash. Most likely your system won't even start init. If you system=20
+  will not boot, remove the "notsc" option, then install a glibc that
+  does not depend on rdtsc before trying again.=20
+ =20
+
+Multiquad support for NUMAQ systems
 CONFIG_MULTIQUAD
   This option is used for getting Linux to run on a (IBM/Sequent) NUMA=20
   multiquad box. This changes the way that processors are bootstrapped,
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Tue Jun 18 16:43:28 2002
+++ b/arch/i386/config.in	Tue Jun 18 16:43:28 2002
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
+	bool 'Multi-node NUMA system support (Caution: Read help first)' CONFIG_X=
86_NUMA
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

--=-bsm4PCPsDfbLUmbi6MVK--

