Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267728AbTAITuD>; Thu, 9 Jan 2003 14:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267733AbTAITt7>; Thu, 9 Jan 2003 14:49:59 -0500
Received: from ppp-217-133-219-176.dialup.tiscali.it ([217.133.219.176]:60288
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S267738AbTAITt5>; Thu, 9 Jan 2003 14:49:57 -0500
Date: Thu, 9 Jan 2003 20:51:32 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove all register pops before sysexit
Message-ID: <20030109195132.GB2098@ldb>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch, which depends on the previous %ebx -> %ebp patch, removes
all pop instruction in the sysenter return path.

This leaks the thread_info address to user mode but this shouldn't be
a security problem.

This is what happens to the various registers:

%eax: return value from system call: already in place
%ebx, %esi, %edi: saved by the C compiler
%ecx, %edx, %ebp: restored by user mode
%esp, eip: copied to %ecx/%edx and restored by sysexit
%ds, %es: initialized to __USER_DS on kernel entry
%cs, %ss: restored by sysexit based on msr
%fs, %gs: not modified by the kernel (saved around context switch)
eflags: not preserved
FP, XMM: any code that modifies them must save/restore them

Note that while it is possible to change %ebx, %esi, %edi, %ecx, %edx
or %ebp via struct pt_regs, anything that does should set TIF_IRET or
another work flag (and it hopefully already does).


diff --exclude-from=3D/home/ldb/src/exclude -urNdp linux-2.5.54-preldb/arch=
/i386/kernel/entry.S linux-2.5.54-ldb/arch/i386/kernel/entry.S
--- linux-2.5.54-preldb/arch/i386/kernel/entry.S	2003-01-06 16:01:40.000000=
000 +0100
+++ linux-2.5.54-ldb/arch/i386/kernel/entry.S	2003-01-06 04:54:58.000000000=
 +0100
@@ -276,9 +276,9 @@ ENTRY(sysenter_entry)
 	movl TI_FLAGS(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
-	RESTORE_INT_REGS
-	movl 12(%esp),%edx
-	movl 24(%esp),%ecx
+/* if something modifies registers it must also disable sysexit */
+	movl EIP(%esp), %edx
+	movl OLDESP(%esp), %ecx
 	sti
 	sysexit
=20

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+HdLDdjkty3ft5+cRApFIAJ47GGBVI2BoZbfHIABVIN/o9x73NQCglCbw
cXNd2muhYYvFTxmYC6S8RNE=
=Gh/n
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
