Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbTF1DPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 23:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTF1DPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 23:15:34 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:37124 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265054AbTF1DP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 23:15:26 -0400
Subject: [PATCH] fix for kallsyms module symbol resolution problem
From: James Bottomley <James.Bottomley@steeleye.com>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-ab34TEoF3ZQXz+GH7/JD"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 Jun 2003 22:26:27 -0500
Message-Id: <1056770789.1825.200.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ab34TEoF3ZQXz+GH7/JD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In lots of KALLSYMS symbol resolution in modules, I've noticed the
appearance of symbols with no names:

Jun 27 20:55:26 raven kernel:  [<10131440>] schedule_timeout+0x78/0xdc
Jun 27 20:55:26 raven kernel:  [<000f8240>] +0x4e0/0x598 [sunrpc]
Jun 27 20:55:26 raven kernel:  [<0014504c>] +0x150/0x43c [nfsd]
Jun 27 20:55:26 raven kernel:  [<10109c5c>] ret_from_kernel_thread+0x1c/0x24

The problem seems to be that get_ksymbol doesn't eliminate empty symbol
names when it does resolution.  The attached patch should fix this.

James


--=-ab34TEoF3ZQXz+GH7/JD
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D kernel/module.c 1.87 vs edited =3D=3D=3D=3D=3D
--- 1.87/kernel/module.c	Sat Jun 14 11:16:06 2003
+++ edited/kernel/module.c	Fri Jun 27 22:10:58 2003
@@ -1760,7 +1760,8 @@
 			continue;
=20
 		if (mod->symtab[i].st_value <=3D addr
-		    && mod->symtab[i].st_value > mod->symtab[best].st_value)
+		    && mod->symtab[i].st_value > mod->symtab[best].st_value
+		    && *(mod->strtab + mod->symtab[i].st_name) !=3D '\0')
 			best =3D i;
 		if (mod->symtab[i].st_value > addr
 		    && mod->symtab[i].st_value < nextval)

--=-ab34TEoF3ZQXz+GH7/JD--

