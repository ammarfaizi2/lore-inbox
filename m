Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTDQRU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTDQRU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:20:59 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:17926 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261825AbTDQRUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:20:53 -0400
Subject: Re: [ANNOUNCE]: version 2.00.3 megaraid driver for 2.4.x and 2.5.67
	kernels
From: James Bottomley <James.Bottomley@steeleye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Mukker, Atul" <atulm@lsil.com>, "'alan@redhat.com'" <alan@redhat.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>,
       "'linux-megaraid-announce@dell.com'" 
	<linux-megaraid-announce@dell.com>
In-Reply-To: <20030417133820.A12503@infradead.org>
References: <0E3FA95632D6D047BA649F95DAB60E570185F10F@EXA-ATLANTA.se.lsil.com> 
	<20030417133820.A12503@infradead.org>
Content-Type: multipart/mixed; boundary="=-EGWOoc3dk2gtof8+7R5R"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 17 Apr 2003 12:25:44 -0500
Message-Id: <1050600346.1784.98.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EGWOoc3dk2gtof8+7R5R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

OK, I think the attached patch fixes the try_module_get problem and also
sweeps up a compile warning issue I ran into on pa-risc.

Does this look OK to everyone?

James


--=-EGWOoc3dk2gtof8+7R5R
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1044  -> 1.1046=20
#	drivers/scsi/megaraid.c	1.38    -> 1.40  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/17	jejb@raven.il.steeleye.com	1.1045
# Fix megaraid compile warnings
# --------------------------------------------
# 03/04/17	jejb@raven.il.steeleye.com	1.1046
# Fix megaraid module ownership
#=20
# Move to using the .owner field of fops
# --------------------------------------------
#
diff -Nru a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
--- a/drivers/scsi/megaraid.c	Thu Apr 17 12:23:35 2003
+++ b/drivers/scsi/megaraid.c	Thu Apr 17 12:23:35 2003
@@ -34,6 +34,7 @@
 #include <linux/fs.h>
 #include <linux/blk.h>
 #include <asm/uaccess.h>
+#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/module.h>
@@ -87,9 +88,9 @@
  * The File Operations structure for the serial/ioctl interface of the dri=
ver
  */
 static struct file_operations megadev_fops =3D {
+	.owner		=3D THIS_MODULE,
 	.ioctl		=3D megadev_ioctl,
 	.open		=3D megadev_open,
-	.release	=3D megadev_close,
 };
=20
 /*
@@ -4039,9 +4040,6 @@
 	 */
 	if( !capable(CAP_SYS_ADMIN) ) return -EACCES;
=20
-	if (!try_module_get(THIS_MODULE)) {
-		return -ENXIO;
-	}
 	return 0;
 }
=20
@@ -4635,14 +4633,6 @@
 		}
 	}
=20
-	return 0;
-}
-
-
-static int
-megadev_close (struct inode *inode, struct file *filep)
-{
-	module_put(THIS_MODULE);
 	return 0;
 }
=20

--=-EGWOoc3dk2gtof8+7R5R--

