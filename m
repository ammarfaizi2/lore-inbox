Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbTIDUTX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTIDUTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:19:23 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:3461 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S265052AbTIDUTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:19:07 -0400
Date: Thu, 4 Sep 2003 23:18:52 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop mprotect() changing MAP_SHARED and other cleanup
Message-ID: <20030904201851.GK13947@actcom.co.il>
References: <20030904193454.GA31590@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKtFalx5NIx0HZ72"
Content-Disposition: inline
In-Reply-To: <20030904193454.GA31590@mail.jlokier.co.uk>
aFrom: Muli Ben-Yehuda <mulix@mulix.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKtFalx5NIx0HZ72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2003 at 08:34:54PM +0100, Jamie Lokier wrote:
> Linus Torvalds wrote:
> > How about something like this that at least gets it closer?
>=20
> Here's my offering, which is more like your earlier request.
> With luck it'll optimise to the same thing :)

Hi Jamie,=20

> +/* Optimisation macro. */
> +#define _calc_vm_trans(x,bit1,bit2) \
> +  ((bit1) <=3D (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
> +   : ((x) & (bit1)) / ((bit1) / (bit2))

Why is this necessary? the original version of the macro was much
simpler. If this isn't just for shaving a couple of optimization,
please document it. If it is, I urge you to reconsider ;-)=20

Here's my version of the same macro, which is a 1-to-1 copy of what
the _trans() macro did:=20

+/* check if bit1 is on in 'in'. If it is, return bit2
+ * this is used for transltating from one bit field domain to another,
+ * e.g. PROT_XXX to VM_XXX=20
+ */=20
+static unsigned long trans_bit(unsigned long in, unsigned long bit1,=20
+		             unsigned long bit2)
+{
+        if (bit1 =3D=3D bit2)
+                return (in & bit1);=20
+
+        return  (in & bit1) ? bit2 : 0;
+}

here's my version of the patch, which only touches the calc_xxx
bits. Compiles and boots.=20

Index: include/linux/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/include/linux/mman.h,v
retrieving revision 1.5
diff -u -u -r1.5 mman.h
--- include/linux/mman.h	3 Jul 2003 05:49:35 -0000	1.5
+++ include/linux/mman.h	4 Sep 2003 18:23:19 -0000
@@ -2,6 +2,7 @@
 #define _LINUX_MMAN_H
=20
 #include <linux/config.h>
+#include <linux/mm.h>=20
=20
 #include <asm/atomic.h>
 #include <asm/mman.h>
@@ -25,6 +26,33 @@
 static inline void vm_unacct_memory(long pages)
 {
 	vm_acct_memory(-pages);
+}
+
+/* check if bit1 is on in 'in'. If it is, return bit2
+ * this is used for transltating from one bit field domain to another,
+ * e.g. PROT_XXX to VM_XXX=20
+ */=20
+static unsigned long trans_bit(unsigned long in, unsigned long bit1,=20
+			       unsigned long bit2)
+{
+	if (bit1 =3D=3D bit2)
+		return (in & bit1);=20
+
+	return  (in & bit1) ? bit2 : 0;
+}
+
+/* Combine the mmap "prot" argument into a bit representation suitable for
+ * "vm_flags".  Essentially, translate the "PROT_xxx" bits into "VM_xxx".
+ */=20
+static inline unsigned long calc_vm_prot(unsigned long prot)
+{
+	unsigned long prot_bits;=20
+
+	prot_bits =3D trans_bit(prot, PROT_READ, VM_READ) |
+		trans_bit(prot, PROT_WRITE, VM_WRITE) |
+		trans_bit(prot, PROT_EXEC, VM_EXEC);=20
+
+	return prot_bits;=20
 }
=20
 #endif /* _LINUX_MMAN_H */
Index: mm/mmap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/mm/mmap.c,v
retrieving revision 1.90
diff -u -u -r1.90 mmap.c
--- mm/mmap.c	11 Jul 2003 02:46:56 -0000	1.90
+++ mm/mmap.c	4 Sep 2003 18:23:22 -0000
@@ -136,27 +136,18 @@
 	return retval;
 }
=20
-/* Combine the mmap "prot" and "flags" argument into one "vm_flags" used
- * internally. Essentially, translate the "PROT_xxx" and "MAP_xxx" bits
- * into "VM_xxx".
- */
-static inline unsigned long
-calc_vm_flags(unsigned long prot, unsigned long flags)
-{
-#define _trans(x,bit1,bit2) \
-((bit1=3D=3Dbit2)?(x&bit1):(x&bit1)?bit2:0)
+/* Combine the mmap "flags" argument into a bit representation suitable for
+ * "vm_flags".  Essentially, translate the "MAP_xxx" bits into "VM_xxx".
+ */=20
+static inline unsigned long calc_vm_flags(unsigned long flags)
+{
+	unsigned long flag_bits;
+
+	flag_bits =3D trans_bit(flags, MAP_GROWSDOWN, VM_GROWSDOWN) |
+		trans_bit(flags, MAP_DENYWRITE, VM_DENYWRITE) |
+		trans_bit(flags, MAP_EXECUTABLE, VM_EXECUTABLE);
=20
-	unsigned long prot_bits, flag_bits;
-	prot_bits =3D
-		_trans(prot, PROT_READ, VM_READ) |
-		_trans(prot, PROT_WRITE, VM_WRITE) |
-		_trans(prot, PROT_EXEC, VM_EXEC);
-	flag_bits =3D
-		_trans(flags, MAP_GROWSDOWN, VM_GROWSDOWN) |
-		_trans(flags, MAP_DENYWRITE, VM_DENYWRITE) |
-		_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE);
-	return prot_bits | flag_bits;
-#undef _trans
+	return flag_bits;
 }
=20
 #ifdef DEBUG_MM_RB
@@ -500,8 +491,8 @@
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags =3D calc_vm_flags(prot,flags) | mm->def_flags |
-			VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	vm_flags =3D calc_vm_flags(flags) | calc_vm_prot(prot) | mm->def_flags |=
=20
+		VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
=20
 	if (flags & MAP_LOCKED) {
 		if (!capable(CAP_IPC_LOCK))
Index: mm/mprotect.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/mm/mprotect.c,v
retrieving revision 1.24
diff -u -u -r1.24 mprotect.c
--- mm/mprotect.c	3 Jul 2003 05:49:35 -0000	1.24
+++ mm/mprotect.c	4 Sep 2003 18:23:22 -0000
@@ -224,7 +224,7 @@
 asmlinkage long
 sys_mprotect(unsigned long start, size_t len, unsigned long prot)
 {
-	unsigned long nstart, end, tmp;
+	unsigned long nstart, end, tmp, flags;=20
 	struct vm_area_struct * vma, * next, * prev;
 	int error =3D -EINVAL;
=20
@@ -239,6 +239,8 @@
 	if (end =3D=3D start)
 		return 0;
=20
+	flags =3D calc_vm_prot(prot);=20
+
 	down_write(&current->mm->mmap_sem);
=20
 	vma =3D find_vma_prev(current->mm, start, &prev);
@@ -257,7 +259,7 @@
 			goto out;
 		}
=20
-		newflags =3D prot | (vma->vm_flags & ~(PROT_READ | PROT_WRITE | PROT_EXE=
C));
+		newflags =3D flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC));
 		if ((newflags & ~(newflags >> 4)) & 0xf) {
 			error =3D -EACCES;
 			goto out;


--=20
Muli Ben-Yehuda
http://www.mulix.org


--tKtFalx5NIx0HZ72
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/V54rKRs727/VN8sRAjwuAKCaRXf7dQfxf15TpKtEbH9reb0kYQCfRBK6
1cy0F0v2unEtFzEKSZdbLR0=
=CXr3
-----END PGP SIGNATURE-----

--tKtFalx5NIx0HZ72--
