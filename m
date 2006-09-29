Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161417AbWI2FHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161417AbWI2FHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 01:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161416AbWI2FHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 01:07:11 -0400
Received: from ozlabs.org ([203.10.76.45]:49845 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161415AbWI2FHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 01:07:09 -0400
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20060928225452.229936605@goop.org>>
References: <20060928225444.439520197@goop.org> >
	  <20060928225452.229936605@goop.org>>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nCsNY7HkVOcDv15QmrGc"
Date: Fri, 29 Sep 2006 15:07:07 +1000
Message-Id: <1159506427.25820.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nCsNY7HkVOcDv15QmrGc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-28 at 15:54 -0700, Jeremy Fitzhardinge wrote:
> plain text document attachment (generic-bug.patch)
> This patch adds common handling for kernel BUGs, for use by
> architectures as they wish.  The code is derived from arch/powerpc.
>=20
> The advantages of having common BUG handling are:
>  - consistent BUG reporting across architectures
>  - shared implementation of out-of-line file/line data

Nice work.

> +       printk(KERN_EMERG "------------[ cut here ]------------\n");

I'm not sure I'm big on the cut here marker.

> i386 implements CONFIG_DEBUG_BUGVERBOSE, but x86-64 and powerpc do
> not.  This should probably be made more consistent.

It looks like if you do this you _might_ be able to share struct
bug_entry, or at least have consistent members for each arch. Which
would eliminate some of the inlines you have for accessing the bug
struct.

It needed a bit of work to get going on powerpc:

Generic BUG handling, Powerpc fixups

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Index: to-merge/arch/powerpc/kernel/traps.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- to-merge.orig/arch/powerpc/kernel/traps.c
+++ to-merge/arch/powerpc/kernel/traps.c
@@ -731,32 +731,9 @@ static int emulate_instruction(struct pt
 	return -EINVAL;
 }
=20
-/*
- * Look through the list of trap instructions that are used for BUG(),
- * BUG_ON() and WARN_ON() and see if we hit one.  At this point we know
- * that the exception was caused by a trap instruction of some kind.
- * Returns 1 if we should continue (i.e. it was a WARN_ON) or 0
- * otherwise.
- */
-extern struct bug_entry __start___bug_table[], __stop___bug_table[];
-
-#ifndef CONFIG_MODULES
-#define module_find_bug(x)	NULL
-#endif
-
-struct bug_entry *find_bug(unsigned long bugaddr)
-{
-	struct bug_entry *bug;
-
-	for (bug =3D __start___bug_table; bug < __stop___bug_table; ++bug)
-		if (bugaddr =3D=3D bug->bug_addr)
-			return bug;
-	return module_find_bug(bugaddr);
-}
-
 int is_valid_bugaddr(unsigned long addr)
 {
-	return addr >=3D PAGE_OFFSET;
+	return is_kernel_addr(addr);
 }
=20
 void __kprobes program_check_exception(struct pt_regs *regs)
Index: to-merge/include/asm-powerpc/bug.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- to-merge.orig/include/asm-powerpc/bug.h
+++ to-merge/include/asm-powerpc/bug.h
@@ -20,8 +20,6 @@ struct bug_entry {
 	const char	*function;
 };
=20
-struct bug_entry *find_bug(unsigned long bugaddr);
-
 /*
  * If this bit is set in the line number it means that the trap
  * is for WARN_ON rather than BUG or BUG_ON.
Index: to-merge/include/linux/bug.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- to-merge.orig/include/linux/bug.h
+++ to-merge/include/linux/bug.h
@@ -6,14 +6,16 @@
 #ifdef CONFIG_GENERIC_BUG
 #include <linux/module.h>
=20
-int report_bug(unsigned long bug_addr);
+extern int report_bug(unsigned long bug_addr);
=20
-int  module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
+extern int  module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
 			 struct module *);
-void module_bug_cleanup(struct module *);
+extern void module_bug_cleanup(struct module *);
+
+extern const struct bug_entry *find_bug(unsigned long bugaddr);
=20
 /* These are defined by the architecture */
-int is_valid_bugaddr(unsigned long addr);
+extern int is_valid_bugaddr(unsigned long addr);
=20
 #endif	/* CONFIG_GENERIC_BUG */
 #endif	/* _LINUX_BUG_H */
Index: to-merge/lib/bug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- to-merge.orig/lib/bug.c
+++ to-merge/lib/bug.c
@@ -21,7 +21,7 @@ static const struct bug_entry *module_fi
 	return NULL;
 }
=20
-static const struct bug_entry *find_bug(unsigned long bugaddr)
+const struct bug_entry *find_bug(unsigned long bugaddr)
 {
 	const struct bug_entry *bug;
=20


--=-nCsNY7HkVOcDv15QmrGc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFHKn7dSjSd0sB4dIRAh1YAJ4l2l0eEYZzOI3d8VAqAHTaoisXIACfcGWs
fNQhGwkoBaqUtJD5hYeq9bs=
=XlZl
-----END PGP SIGNATURE-----

--=-nCsNY7HkVOcDv15QmrGc--

