Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTFHRV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 13:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTFHRV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 13:21:58 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:24326 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263573AbTFHRV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 13:21:57 -0400
Subject: [PATCH] fix character subsystem initialisation panic
From: James Bottomley <James.Bottomley@steeleye.com>
To: torvalds@transmeta.com
Cc: Andrew Morton <akpm@digeo.com>, greg@kroah.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Dc1NT7gbpbpbZOvv7X/h"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Jun 2003 12:35:25 -0500
Message-Id: <1055093727.1982.17.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Dc1NT7gbpbpbZOvv7X/h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In 2.5.70 bk latest, I'm getting a panic related to character device
initialisation.  The problem seems to be that the new sysfs entries for
character devices require that everything now have a properly
initialised parent.  However, the character subsystem is set up in
drivers/char/mem.c as

__initcall(chr_dev_init);

However, __initcall() is the same priority as module_init(), so whether
character devices are initialised before their required subsystem
depends purely on link ordering (on parisc, we initialise devices/parisc
before everything else, so it is panicing reliably with this).

I think the fix is to convert the __initcall to subsys_initcall (patch
attached).  The patch allows parisc to boot properly now.

James



--=-Dc1NT7gbpbpbZOvv7X/h
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D drivers/char/mem.c 1.39 vs edited =3D=3D=3D=3D=3D
--- 1.39/drivers/char/mem.c	Fri Jun  6 01:36:40 2003
+++ edited/drivers/char/mem.c	Sun Jun  8 12:02:24 2003
@@ -713,4 +713,4 @@
 	return 0;
 }
=20
-__initcall(chr_dev_init);
+subsys_initcall(chr_dev_init);

--=-Dc1NT7gbpbpbZOvv7X/h--

