Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbSIPRpB>; Mon, 16 Sep 2002 13:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbSIPRpB>; Mon, 16 Sep 2002 13:45:01 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:25478 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262747AbSIPRpA>;
	Mon, 16 Sep 2002 13:45:00 -0400
Subject: BUG: sym53c8xx_2 and highmem_io
From: Todd Inglett <tinglett@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Gerard Roudier <groudier@free.fr>
Content-Type: multipart/mixed; boundary="=-IOFYki/qUOPO+FQsuZnH"
X-Mailer: Evolution/1.0.2-5mdk 
Date: 16 Sep 2002 12:49:46 -0500
Message-Id: <1032198591.18300.22.camel@q.rchland.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IOFYki/qUOPO+FQsuZnH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've been having an interesting experience getting sym53c8xx_2 working
on ppc64 now that highio is in place.  Of course ppc64 doesn't need
highio, and it does set blk_nohighio = 1 in setup_arch().  So the
sym53c8xx driver works.

However, sym53c8xx_2 fails because after calling scsi_register() in its
attach it blindly slams highmem_io on (in sym_glue.c).  Is this
correct?  It seems to me that it should just leave it alone since
scsi_register already handled that.

I might be misunderstanding something here.  Is there anything else a
64-bit arch must do for highio?  I found we also weren't setting max_pfn
which seemed bad...though maybe irrelevant.

The trivial patch to fix it is attached, but I haven't tested it on a
system that supports highio.

-todd


--=-IOFYki/qUOPO+FQsuZnH
Content-Disposition: inline; filename=highio.sym2.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-diff; charset=ISO-8859-1

Index: drivers/scsi/sym53c8xx_2/sym_glue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linuxppc64/linuxppc64_2_4/drivers/scsi/sym53c8xx_2/sym_glue.=
c,v
retrieving revision 1.2
diff -u -r1.2 sym_glue.c
--- drivers/scsi/sym53c8xx_2/sym_glue.c	23 Aug 2002 18:43:46 -0000	1.2
+++ drivers/scsi/sym53c8xx_2/sym_glue.c	16 Sep 2002 17:45:54 -0000
@@ -2140,7 +2140,7 @@
 	instance->max_cmd_len	=3D 16;
 #endif
 	instance->select_queue_depths =3D sym53c8xx_select_queue_depths;
-	instance->highmem_io	=3D 1;
+	/* instance->highmem_io	=3D 1; */
=20
 	SYM_UNLOCK_HCB(np, flags);
=20

--=-IOFYki/qUOPO+FQsuZnH--

