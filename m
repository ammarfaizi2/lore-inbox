Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266525AbVBEAoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbVBEAoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbVBEAiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:38:15 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:7058 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S266546AbVBEAdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:33:33 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
Date: Sat, 5 Feb 2005 01:22:21 +0100
User-Agent: KMail/1.6.2
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, Andrew Morton <akpm@osdl.org>,
       Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>
References: <20050204072254.GA17565@austin.ibm.com> <200502041336.59892.arnd@arndb.de> <1107560989.2189.119.camel@gaston>
In-Reply-To: <1107560989.2189.119.camel@gaston>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_CHBBCzWHaeUdQZn";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200502050122.27254.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_CHBBCzWHaeUdQZn
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnnavend 05 Februar 2005 00:49, Benjamin Herrenschmidt wrote:
> On Fri, 2005-02-04 at 13:36 +0100, Arnd Bergmann wrote:
> > I have a somewhat similar patch that does the same to the
> > systemcfg->platform checks. I'm not sure if we should use the same inli=
ne
> > function for both checks, but I do think that they should be used in a
> > similar way, e.g. CPU_HAS_FEATURE(x) and PLATFORM_HAS_FEATURE(x).
>=20
> Note that I would prefer cpu_has_feature(), it doesn't strictly have to
> be a macro and has function semantics anyway.

> > [ ... ]=20
> > which will always result in the shortest code for any combination of
> > CONFIG_PPC_ISERIES, CONFIG_PPC_PSERIES and the other platforms.
>=20
> That's a good idea !

This is the patch to evaluate CPU_HAS_FEATURE() at compile time whenever
possible. Testing showed that vmlinux shrinks around 4000 bytes with
g5_defconfig. I also checked that pSeries code is completely unaltered
semantically when support for all CPU types is enabled, although a few
instructions are emitted in a different order by gcc.

I have made cpu_has_feature() an inline function that expects the full
name of a feature bit while the CPU_HAS_FEATURE() macro still behaves
the same way as in Olofs original patch for now.

I'm not sure if I got the Kconfig dependencies right, maybe you can
check them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

=2D--
Index: linux-2.6-64/include/asm-ppc64/cputable.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/include/asm-ppc64/cputable.h	2005-02-05 01:24:58.97=
5674192 +0100
+++ linux-2.6-64/include/asm-ppc64/cputable.h	2005-02-05 01:26:17.328762712=
 +0100
@@ -66,9 +66,6 @@
 extern struct cpu_spec		cpu_specs[];
 extern struct cpu_spec		*cur_cpu_spec;
=20
=2D#define CPU_HAS_FEATURE(x)	(cur_cpu_spec->cpu_features & CPU_FTR_##x)
=2D
=2D
 /* firmware feature bitmask values */
 #define FIRMWARE_MAX_FEATURES 63
=20
@@ -154,6 +151,80 @@
 #define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_PPCAS_ARCH_V2_BASE | CPU_FTR_16M_PA=
GE)
 #endif
=20
+/* We only set the altivec features if the kernel was compiled with altivec
+ * support
+ */
+#ifdef CONFIG_ALTIVEC
+#define CPU_FTR_ALTIVEC_COMP	CPU_FTR_ALTIVEC
+#define PPC_FEATURE_HAS_ALTIVEC_COMP PPC_FEATURE_HAS_ALTIVEC
+#else
+#define CPU_FTR_ALTIVEC_COMP	0
+#define PPC_FEATURE_HAS_ALTIVEC_COMP    0
+#endif
+
+enum {
+	CPU_FTR_POWER3 =3D CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			 CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | CPU_FTR_PMC8,
+	CPU_FTR_RS64   =3D CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			 CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | CPU_FTR_PMC8 |
+			 CPU_FTR_MMCRA,
+	CPU_FTR_POWER4 =3D CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			 CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 |
+			 CPU_FTR_PMC8 | CPU_FTR_MMCRA,
+	CPU_FTR_PPC970 =3D CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			 CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 |
+			 CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP |
+			 CPU_FTR_PMC8 | CPU_FTR_MMCRA,
+	CPU_FTR_POWER5 =3D CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			 CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 |
+			 CPU_FTR_MMCRA | CPU_FTR_SMT | CPU_FTR_COHERENT_ICACHE |
+			 CPU_FTR_LOCKLESS_TLBIE | CPU_FTR_MMCRA_SIHV,
+	CPU_FTR_COMPATIBLE =3D CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			 CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2,
+	CPU_FTR_POSSIBLE =3D
+#ifdef CONFIG_CPU_POWER3
+			 CPU_FTR_POWER3 |
+#endif
+#ifdef CONFIG_CPU_RS64
+			 CPU_FTR_RS64 |
+#endif
+#ifdef CONFIG_CPU_POWER4
+			 CPU_FTR_POWER4 |
+#endif
+#ifdef CONFIG_CPU_PPC970
+			 CPU_FTR_PPC970 |
+#endif
+#ifdef CONFIG_CPU_POWER5
+			 CPU_FTR_POWER5 |
+#endif
+			 0,
+	CPU_FTR_ALWAYS =3D
+#ifdef CONFIG_CPU_POWER3
+			 CPU_FTR_POWER3 &
+#endif
+#ifdef CONFIG_CPU_RS64
+			 CPU_FTR_RS64 &
+#endif
+#ifdef CONFIG_CPU_POWER4
+			 CPU_FTR_POWER4 &
+#endif
+#ifdef CONFIG_CPU_PPC970
+			 CPU_FTR_PPC970 &
+#endif
+#ifdef CONFIG_CPU_POWER5
+			 CPU_FTR_POWER5 &
+#endif
+			 CPU_FTR_POSSIBLE,
+};
+
+static inline int cpu_has_feature(unsigned long feature)
+{
+	return (CPU_FTR_ALWAYS & feature) ||
+	       (CPU_FTR_POSSIBLE & feature & cur_cpu_spec->cpu_features);
+}
+
+#define CPU_HAS_FEATURE(x) cpu_has_feature(CPU_FTR_##x)
+
 #define COMMON_PPC64_FW	(0)
 #endif
=20
Index: linux-2.6-64/arch/ppc64/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/Kconfig	2005-02-05 01:24:31.098912104 +0=
100
+++ linux-2.6-64/arch/ppc64/Kconfig	2005-02-05 01:25:01.430301032 +0100
@@ -107,6 +107,31 @@
 	bool
 	default y
=20
+config CPU_POWER3
+	bool
+	default y
+	depends on (PPC_ISERIES || PPC_PSERIES) && !POWER4_ONLY
+
+config CPU_RS64
+	bool
+	default y
+	depends on (PPC_ISERIES || PPC_PSERIES) && !POWER4_ONLY
+
+config CPU_POWER4
+	bool
+	default y
+	depends on PPC_ISERIES || PPC_PSERIES
+
+config CPU_PPC970
+	bool
+	default y
+	depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE
+
+config CPU_POWER5
+	bool
+	default y
+	depends on PPC_PSERIES
+
 # VMX is pSeries only for now until somebody writes the iSeries
 # exception vectors for it
 config ALTIVEC
Index: linux-2.6-64/arch/ppc64/kernel/cputable.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/cputable.c	2005-02-05 01:24:31.09=
8912104 +0100
+++ linux-2.6-64/arch/ppc64/kernel/cputable.c	2005-02-05 01:25:01.431300880=
 +0100
@@ -33,137 +33,94 @@
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec=
);
=20
=20
=2D/* We only set the altivec features if the kernel was compiled with alti=
vec
=2D * support
=2D */
=2D#ifdef CONFIG_ALTIVEC
=2D#define CPU_FTR_ALTIVEC_COMP	CPU_FTR_ALTIVEC
=2D#define PPC_FEATURE_HAS_ALTIVEC_COMP PPC_FEATURE_HAS_ALTIVEC
=2D#else
=2D#define CPU_FTR_ALTIVEC_COMP	0
=2D#define PPC_FEATURE_HAS_ALTIVEC_COMP    0
=2D#endif
=2D
 struct cpu_spec	cpu_specs[] =3D {
     {	/* Power3 */
 	    0xffff0000, 0x00400000, "POWER3 (630)",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_IABR | CPU_FTR_PMC8,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_POWER3, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power3,
 	    COMMON_PPC64_FW
     },
     {	/* Power3+ */
 	    0xffff0000, 0x00410000, "POWER3 (630+)",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_IABR | CPU_FTR_PMC8,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_POWER3, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power3,
 	    COMMON_PPC64_FW
     },
     {	/* Northstar */
 	    0xffff0000, 0x00330000, "RS64-II (northstar)",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_IABR | CPU_FTR_PMC8 | CPU_FTR_MMCRA,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_RS64, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power3,
 	    COMMON_PPC64_FW
     },
     {	/* Pulsar */
 	    0xffff0000, 0x00340000, "RS64-III (pulsar)",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_IABR | CPU_FTR_PMC8 | CPU_FTR_MMCRA,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_RS64, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power3,
 	    COMMON_PPC64_FW
     },
     {	/* I-star */
 	    0xffff0000, 0x00360000, "RS64-III (icestar)",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_IABR | CPU_FTR_PMC8 | CPU_FTR_MMCRA,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_RS64, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power3,
 	    COMMON_PPC64_FW
     },
     {	/* S-star */
 	    0xffff0000, 0x00370000, "RS64-IV (sstar)",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_IABR | CPU_FTR_PMC8 | CPU_FTR_MMCRA,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_RS64, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power3,
 	    COMMON_PPC64_FW
     },
     {	/* Power4 */
 	    0xffff0000, 0x00350000, "POWER4 (gp)",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_PMC8 | CPU_FTR_MMCRA,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_POWER4, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power4,
 	    COMMON_PPC64_FW
     },
     {	/* Power4+ */
 	    0xffff0000, 0x00380000, "POWER4+ (gq)",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_PMC8 | CPU_FTR_MMCRA,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_POWER4, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power4,
 	    COMMON_PPC64_FW
     },
     {	/* PPC970 */
 	    0xffff0000, 0x00390000, "PPC970",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_ALTIVEC_COMP |
=2D		    CPU_FTR_CAN_NAP | CPU_FTR_PMC8 | CPU_FTR_MMCRA,
=2D	    COMMON_USER_PPC64 | PPC_FEATURE_HAS_ALTIVEC_COMP,
+	    CPU_FTR_PPC970, COMMON_USER_PPC64 | PPC_FEATURE_HAS_ALTIVEC_COMP,
 	    128, 128,
 	    __setup_cpu_ppc970,
 	    COMMON_PPC64_FW
     },
     {	/* PPC970FX */
 	    0xffff0000, 0x003c0000, "PPC970FX",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_ALTIVEC_COMP |
=2D		    CPU_FTR_CAN_NAP | CPU_FTR_PMC8 | CPU_FTR_MMCRA,
=2D	    COMMON_USER_PPC64 | PPC_FEATURE_HAS_ALTIVEC_COMP,
+	    CPU_FTR_PPC970, COMMON_USER_PPC64 | PPC_FEATURE_HAS_ALTIVEC_COMP,
 	    128, 128,
 	    __setup_cpu_ppc970,
 	    COMMON_PPC64_FW
     },
     {	/* Power5 */
 	    0xffff0000, 0x003a0000, "POWER5 (gr)",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_MMCRA | CPU_FTR_SMT |
=2D		    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE |
=2D		    CPU_FTR_MMCRA_SIHV,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_POWER5, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power4,
 	    COMMON_PPC64_FW
     },
     {	/* Power5 */
 	    0xffff0000, 0x003b0000, "POWER5 (gs)",
=2D	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_MMCRA | CPU_FTR_SMT |
=2D		    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE |
=2D		    CPU_FTR_MMCRA_SIHV,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_POWER5, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power4,
 	    COMMON_PPC64_FW
     },
     {	/* default match */
 	    0x00000000, 0x00000000, "POWER4 (compatible)",
=2D  	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
=2D		    CPU_FTR_PPCAS_ARCH_V2,
=2D	    COMMON_USER_PPC64,
+	    CPU_FTR_COMPATIBLE, COMMON_USER_PPC64,
 	    128, 128,
 	    __setup_cpu_power4,
 	    COMMON_PPC64_FW

--Boundary-02=_CHBBCzWHaeUdQZn
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCBBHC5t5GS2LDRf4RAl4SAJ9h43dYrLP1lyMv7GJFtRrHjv0ttwCfWELv
8OkfHhJ6x6ZY11po8IwTsn8=
=R0q2
-----END PGP SIGNATURE-----

--Boundary-02=_CHBBCzWHaeUdQZn--
