Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264803AbUEER77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264803AbUEER77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbUEER77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:59:59 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:40145 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264798AbUEER7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:59:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.6.6-rc3-mm2
Date: Wed, 5 May 2004 19:59:13 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20040505013135.7689e38d.akpm@osdl.org> <20040505163320.A4250@infradead.org>
In-Reply-To: <20040505163320.A4250@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_xtSmAeHXXVv5B77";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405051959.13907.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_xtSmAeHXXVv5B77
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 05 May 2004 17:33, Christoph Hellwig wrote:
> On Wed, May 05, 2004 at 01:31:35AM -0700, Andrew Morton wrote:
> >static-define_per_cpu-vs-modules-2.patch
> >=20
> >  Work around relative address displacement problems on s390.
>=20
> I'm not happy with this one.  It prevents perfectly valid optimizations
> that become more important with modern compilers because of s390 brokenne=
ss.
>=20
> Of the options listed in the patch description (why the heck didn't it ev=
er
> make it to a mailinglist??) the options to avoid the static effect in s390
> code looks most appealing but hard to implement to me, and if it doesn't
> work out we'll probably have to do the STATIC_DEFINE_PER_CPU variant.

When I prepared that patch, I was certain that the bug was not s390
specific, as it now turned out to be. The reason is that only on s390, the
kernel virtual address space for builtin code is the same as the physical
address space while modules are loaded to the vmalloc area, which may be >32
bit apart.

=46or exported symbols, we work around this by compiling modules with -fpic,
which does not work for per_cpu relocations.

Martin was now able to do a similar workaround for these by loading the
address through inline assembly without affecting the other architectures,
following a suggestion by Richard Henderson. This is his patch:

=46orce the use of a 64 bit relocation to access the per_cpu__##var
variables and fix a problem in the module loader regarding GOTENT and=20
GOTPLTENT relocs.

diff -urN linux-2.6/arch/s390/kernel/module.c linux-2.6-s390/arch/s390/kern=
el/module.c
=2D-- linux-2.6/arch/s390/kernel/module.c	Sun Apr  4 05:38:13 2004
+++ linux-2.6-s390/arch/s390/kernel/module.c	Wed May  5 19:40:22 2004
@@ -277,7 +277,8 @@
 			*(unsigned int *) loc =3D val;
 		else if (r_type =3D=3D R_390_GOTENT ||
 			 r_type =3D=3D R_390_GOTPLTENT)
=2D			*(unsigned int *) loc =3D val >> 1;
+			*(unsigned int *) loc =3D
+				(val + (Elf_Addr) me->module_core - loc) >> 1;
 		else if (r_type =3D=3D R_390_GOT64 ||
 			 r_type =3D=3D R_390_GOTPLT64)
 			*(unsigned long *) loc =3D val;
diff -urN linux-2.6/include/asm-s390/percpu.h linux-2.6-s390/include/asm-s3=
90/percpu.h
=2D-- linux-2.6/include/asm-s390/percpu.h	Sun Apr  4 05:38:20 2004
+++ linux-2.6-s390/include/asm-s390/percpu.h	Wed May  5 19:40:22 2004
@@ -5,10 +5,26 @@
 #include <asm/lowcore.h>
=20
 /*
=2D * s390 uses the generic implementation for per cpu data, with the excep=
tion that
=2D * the offset of the cpu local data area is cached in the cpu's lowcore =
memory
+ * For builtin kernel code s390 uses the generic implementation for
+ * per cpu data, with the exception that the offset of the cpu local
+ * data area is cached in the cpu's lowcore memory
+ * For 64 bit module code s390 forces the use of a GOT slot for the
+ * address of the per cpu variable. This is needed because the module
+ * may be more than 4G above the per cpu area.
  */
+#if defined(__s390x__) && defined(MODULE)
+#define __get_got_cpu_var(var,offset) \
+  (*({ unsigned long *__ptr; \
+       asm ( "larl %0,per_cpu__"#var"@GOTENT" : "=3Da" (__ptr) ); \
+       ((typeof(&per_cpu__##var))((*__ptr) + offset)); \
+    }))
+#undef __get_cpu_var
+#define __get_cpu_var(var) __get_got_cpu_var(var,S390_lowcore.percpu_offse=
t)
+#undef per_cpu
+#define per_cpu(var,cpu) __get_got_cpu_var(var,__per_cpu_offset[cpu])
+#else
 #undef __get_cpu_var
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, S390_lowcore.perc=
pu_offset))
+#endif
=20
 #endif /* __ARCH_S390_PERCPU__ */

--Boundary-02=_xtSmAeHXXVv5B77
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmStx5t5GS2LDRf4RAudCAKCX+8d+RcsfdnXUZ11aZWpmVAyN4wCcCHGV
fI95O6DxzwsM60fO41c4e64=
=/cWV
-----END PGP SIGNATURE-----

--Boundary-02=_xtSmAeHXXVv5B77--
