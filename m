Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270350AbTGWS0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270226AbTGWS0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:26:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:41600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270350AbTGWS0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:26:23 -0400
Subject: [PATCH 2.6.0-test1-mm2] fix unable to mount root fs
From: Daniel McNeil <daniel@osdl.org>
To: Florian Huber <florian.huber@mnet-online.de>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030720125547.11466aa4.florian.huber@mnet-online.de>
References: <20030720125547.11466aa4.florian.huber@mnet-online.de>
Content-Type: multipart/mixed; boundary="=-dnvJ3X1S46na7yk/QkYD"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Jul 2003 11:42:19 -0700
Message-Id: <1058985739.23448.25.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dnvJ3X1S46na7yk/QkYD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The problem is being caused by the dev_t changes that now print out
dev_t's as major:minor instead of a hex value.  See print_dev_t().

This patch changes try_name() in init/do_mounts.c to get the major
and minor and return a MKDEV(major, minor).  I've tested this on
my machines and it boots with root=/dev/hda2.

Daniel McNeil <daniel@osdl.org>
On Sun, 2003-07-20 at 03:55, Florian Huber wrote:
> Hello ML,
> I can't boot my 2.6.0-test1-mm2 kernel (+GCC 3.3). The kernel panics
> at bootime:
> 
> VFS: Cannot open root device "hda3" or unknow-block(0,0)
> Please append a correct "root=" boot option
> Kernel Panic: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> I do have compiled support for the file system on my root partition
> (xfs). The same configuration worked well with 2.6.0-test1-mm1.
> 
> Perhaps somebody knows how to solve this.
> 
> TIA
> 	Florian Huber
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--=-dnvJ3X1S46na7yk/QkYD
Content-Disposition: attachment; filename=patch.2.6.0-test1-mm2.do_mounts
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch.2.6.0-test1-mm2.do_mounts; charset=ISO-8859-1

diff -rupN -X /home/daniel_nfs/dontdiff linux-2.6.0-test1-mm2/init/do_mount=
s.c linux-2.6.0-test1-mm2.do_mounts/init/do_mounts.c
--- linux-2.6.0-test1-mm2/init/do_mounts.c	2003-07-23 11:19:32.018914859 -0=
700
+++ linux-2.6.0-test1-mm2.do_mounts/init/do_mounts.c	2003-07-23 11:25:19.35=
6002570 -0700
@@ -58,6 +58,7 @@ static dev_t __init try_name(char *name,
 	char *s;
 	int len;
 	int fd;
+	unsigned int maj, min;
=20
 	/* read device number from .../dev */
=20
@@ -70,8 +71,12 @@ static dev_t __init try_name(char *name,
 	if (len <=3D 0 || len =3D=3D 32 || buf[len - 1] !=3D '\n')
 		goto fail;
 	buf[len - 1] =3D '\0';
-	res =3D (dev_t) simple_strtoul(buf, &s, 16);
-	if (*s)
+	/*
+	 * The format of dev is now %u:%u -- see print_dev_t()
+	 */
+	if (sscanf(buf, "%u:%u", &maj, &min) =3D=3D 2)
+		res =3D MKDEV(maj, min);
+	else
 		goto fail;
=20
 	/* if it's there and we are not looking for a partition - that's it */

--=-dnvJ3X1S46na7yk/QkYD--

