Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbTAFCCk>; Sun, 5 Jan 2003 21:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbTAFCCk>; Sun, 5 Jan 2003 21:02:40 -0500
Received: from ppp-217-133-216-158.dialup.tiscali.it ([217.133.216.158]:36227
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S265736AbTAFCCi>; Sun, 5 Jan 2003 21:02:38 -0500
Date: Mon, 6 Jan 2003 03:03:51 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix sysenter (%ebp) fault handling
Message-ID: <20030106020351.GA8074@ldb>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently syscall_badsys is called to handle faults when reading the
sixth parameter in sysenter; however that routine assumes that
registers have already been pushed on the stack, and this is not the
case (in other words, it will currently try to pop beyond the end of
the thread stack).

This patch adds a new "function", syscall_fault, that saves register
and returns.

The return value is changed to EFAULT, which seems more appropriate
than ENOSYS.


diff --exclude-from=3D/home/ldb/src/exclude -urNdp --exclude=3D'speedtouch.=
*' --exclude=3D'atmsar.*' linux-2.5.54/arch/i386/kernel/entry.S linux-2.5.5=
4-ldb/arch/i386/kernel/entry.S
--- linux-2.5.54/arch/i386/kernel/entry.S	2003-01-02 04:21:27.000000000 +01=
00
+++ linux-2.5.54-ldb/arch/i386/kernel/entry.S	2003-01-04 19:06:07.000000000=
 +0100
@@ -253,11 +253,11 @@ ENTRY(sysenter_entry)
  * Careful about security.
  */
 	cmpl $__PAGE_OFFSET-3,%ebp
-	jae syscall_badsys
+	jae syscall_fault
 1:	movl (%ebp),%ebp
 .section __ex_table,"a"
 	.align 4
-	.long 1b,syscall_badsys
+	.long 1b,syscall_fault
 .previous
=20
 	pushl %eax
@@ -367,6 +373,14 @@ syscall_exit_work:
 	jmp resume_userspace
=20
 	ALIGN
+syscall_fault:
+	pushl %eax			# save orig_eax
+	SAVE_ALL
+	GET_THREAD_INFO(%ebx)
+	movl $-EFAULT,EAX(%esp)
+	jmp resume_userspace
+
+	ALIGN
 syscall_badsys:
 	movl $-ENOSYS,EAX(%esp)
 	jmp resume_userspace

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+GOQGdjkty3ft5+cRApJgAKCBuYekAjw7NrXTPDnaGp6CYc8sXACeOZaX
6y1XNedehFjnHyWL0SnH+qI=
=gFhw
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
