Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUGMWSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUGMWSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267168AbUGMWSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:18:02 -0400
Received: from lists.us.dell.com ([143.166.224.162]:65453 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S267164AbUGMWRB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:17:01 -0400
Date: Tue, 13 Jul 2004 17:16:23 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: David Balazic <david.balazic@hermes.si>
Cc: Dave Jones <davej@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Weird:  30 sec delay during early boot
Message-ID: <20040713221623.GA10480@lists.us.dell.com>
References: <600B91D5E4B8D211A58C00902724252C035F1D0C@piramida.hermes.si>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <600B91D5E4B8D211A58C00902724252C035F1D0C@piramida.hermes.si>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

David, Jeff, would you mind trying the patch below on your systems
which exhibit the long delays in the EDD real-mode code?

This does a few things:
1) it uses an int13 fn15 "Get Disk Type" command prior to doing the
fn02 "Read Sectors" command, to try to determine if there is a disk
present or not before reading its signature.

2) A few registers are more fully zeroed out, in case the BIOS cared
about things it shouldn't have.

Crossing my fingers that the delays are gone...
-Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

=3D=3D=3D=3D=3D arch/i386/boot/edd.S 1.2 vs edited =3D=3D=3D=3D=3D
--- 1.2/arch/i386/boot/edd.S	2004-06-29 09:44:48 -05:00
+++ edited/arch/i386/boot/edd.S	2004-07-13 16:48:50 -05:00
@@ -12,13 +12,31 @@
 #include <linux/edd.h>
=20
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
-# Read the first sector of each BIOS disk device and store the 4-byte sign=
ature
 edd_mbr_sig_start:
+	xor	%ebx, %ebx
+	xor	%edx, %edx
 	movb	$0, (EDD_MBR_SIG_NR_BUF)	# zero value at EDD_MBR_SIG_NR_BUF
+       	movw	$EDD_MBR_SIG_BUF, %bx		# store buffer ptr in bx
 	movb	$0x80, %dl			# from device 80
-	movw	$EDD_MBR_SIG_BUF, %bx		# store buffer ptr in bx
+
 edd_mbr_sig_read:
-	movl	$0xFFFFFFFF, %eax
+# Do int13 fn15 first, as BIOS should know if a disk is present or not.
+# This avoids long (>30s) delays waiting for the READ_SECTORS to a non-pre=
sent disk.
+	xor	%eax, %eax
+	xor	%ecx, %ecx
+       	movb	$GETDISKTYPE, %ah		# Function 15
+	pushw	%dx				# which stomps on dx
+	stc					# work around buggy BIOSes
+    	int	$0x13				# make the call
+	sti					# work around buggy BIOSes
+	popw	%dx				# so get back dx
+	jc	edd_mbr_sig_done		# no more BIOS devices
+	cmpb	$HARDDRIVEPRESENT, %ah		# is hard drive present?
+	jne	edd_mbr_sig_done		# no more BIOS devices
+
+# Read the first sector of each BIOS disk device and store the 4-byte sign=
ature
+	xor	%ecx, %ecx
+    	movl	$0xFFFFFFFF, %eax
 	movl	%eax, (%bx)			# assume failure
 	pushw	%bx
 	movb	$READ_SECTORS, %ah
=3D=3D=3D=3D=3D include/linux/edd.h 1.11 vs edited =3D=3D=3D=3D=3D
--- 1.11/include/linux/edd.h	2004-06-29 09:44:48 -05:00
+++ edited/include/linux/edd.h	2004-07-13 16:05:14 -05:00
@@ -49,6 +49,9 @@
 #define EDD_MBR_SIG_MAX 16        /* max number of signatures to store */
 #define EDD_MBR_SIG_NR_BUF 0x1ea  /* addr of number of MBR signtaures at E=
DD_MBR_SIG_BUF
 				     in boot_params - treat this as 1 byte  */
+#define GETDISKTYPE 0x15          /* int13 AH=3D0x15 is Get Disk Type comm=
and */
+#define HARDDRIVEPRESENT 0x03     /* int13 AH=3D15 return code in AH */
+
 #ifndef __ASSEMBLY__
=20
 #define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA9F83Iavu95Lw/AkRAoGDAJ9s1ou11mcrzTSIWRPccHn19I5kmQCdEkgi
6/XozAR3pjqgTNOIn8nO7HM=
=vIv7
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
