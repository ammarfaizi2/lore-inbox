Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSFTWyh>; Thu, 20 Jun 2002 18:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315754AbSFTWyh>; Thu, 20 Jun 2002 18:54:37 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:26614 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315748AbSFTWyf>;
	Thu, 20 Jun 2002 18:54:35 -0400
Subject: [RFC] [PATCH] tsc_disable_B2 with "soft" rdtsc
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-GSFbiFVFwdAU/Szzt5E6"
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jun 2002 15:47:51 -0700
Message-Id: <1024613272.5184.176.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GSFbiFVFwdAU/Szzt5E6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello all, 

	Here is my next rev of the tsc-disable patch. This one corrects a
Configure.in typo (Caught by Gabriel Paubert), and probably more
controversial, implements a soft rdtsc instruction via do_gettimeofday.

This avoids the earlier "box won't boot" problems with i686 optimized
glibc's that called rdtsc. The rdtsc instruction will now be caught, and
faked returning to the user program the same value of gettimeofday. Yes,
its pretty hackish, but it works, albeit slowly. 

Anyway, as always, comments and flames are welcome.
-john

--=-GSFbiFVFwdAU/Szzt5E6
Content-Disposition: attachment; filename=linux-2.4.19-pre10_tsc-disable_B2.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=linux-2.4.19-pre10_tsc-disable_B2.patch;
	charset=ISO-8859-1

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Thu Jun 20 15:14:14 2002
+++ b/Documentation/Configure.help	Thu Jun 20 15:14:14 2002
@@ -233,7 +233,23 @@
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
+  to use the PIT for gettimeofday.=20
+ =20
+  In order to avoid crashing applications that use rdtsc, this option
+  also enables a "soft" rdtsc implementation. With this option enabled
+  rdtsc instructions will be caught by the OS, and the value returned=20
+  will be the same as gettimeofday. Do note: this will cause a major=20
+  performance penalty when compared to native rdtsc calls. You've=20
+  been warned.=20
+
+Multiquad support for NUMAQ systems
 CONFIG_MULTIQUAD
   This option is used for getting Linux to run on a (IBM/Sequent) NUMA=20
   multiquad box. This changes the way that processors are bootstrapped,
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Thu Jun 20 15:14:14 2002
+++ b/arch/i386/config.in	Thu Jun 20 15:14:14 2002
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
diff -Nru a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	Thu Jun 20 15:14:14 2002
+++ b/arch/i386/kernel/traps.c	Thu Jun 20 15:14:14 2002
@@ -392,6 +392,23 @@
 	if (!(regs->xcs & 3))
 		goto gp_in_kernel;
=20
+#ifdef CONFIG_X86_NUMA
+	/* "soft" rdtsc implementation */
+	if(!cpu_has_tsc)
+	{
+		char rdtsc_inst[2] =3D {0x0f, 0x31}; /*rdtsc opcode*/
+		char* inst_ptr =3D (char*)regs->eip;
+		if((inst_ptr[0] =3D=3D rdtsc_inst[0])
+			&&(inst_ptr[1] =3D=3D rdtsc_inst[1])){
+			struct timeval tv;
+			do_gettimeofday(&tv);
+			regs->eax =3D tv.tv_usec;
+			regs->edx =3D tv.tv_sec;
+			regs->eip +=3D 2; /*=3D size of opcode*/
+			return;
+		}
+	}
+#endif
 	current->thread.error_code =3D error_code;
 	current->thread.trap_no =3D 13;
 	force_sig(SIGSEGV, current);

--=-GSFbiFVFwdAU/Szzt5E6--

