Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266743AbUHIQ6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266743AbUHIQ6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUHIQ6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:58:30 -0400
Received: from mout2.freenet.de ([194.97.50.155]:46732 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S266743AbUHIQzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:55:09 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Albert Cahalan <albert@users.sf.net>, Greg KH <greg@kroah.com>
Subject: Re: dynamic /dev security hole?
Date: Mon, 9 Aug 2004 18:54:24 +0200
User-Agent: KMail/1.6.2
References: <20040808162115.GA7597@kroah.com> <200408091530.55244.mbuesch@freenet.de> <1092057570.5761.215.camel@cube>
In-Reply-To: <1092057570.5761.215.camel@cube>
Cc: Eric Lammerts <eric@lammerts.org>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       albert@users.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408091854.27019.mbuesch@freenet.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Albert Cahalan <albert@users.sf.net>:
> Pretty much, but you must change ownership first to
> keep the user from changing the mode back. There are
> ways for an evildoer to win this race if you don't
> change the ownership first.
>
> Now all we need is revoke() and we're all set.
> Ordering: chown, chmod, revoke, unlink
>
> BTW, I'm make revoke() just force re-verification
> of file access.

So what about this updated patch?
I'm running latest udev with klibc and my patch.
It seems to work. At least with my USB stick. :)

Greg? Any comments?


===== udev-remove.c 1.31 vs edited =====
- --- 1.31/udev-remove.c	2004-04-01 04:12:56 +02:00
+++ edited/udev-remove.c	2004-08-09 18:42:08 +02:00
@@ -65,6 +65,41 @@
 	return 0;
 }

+/** Remove all permissions on the device node, before
+  * unlinking it. This fixes a security issue.
+  * If the user created a hard-link to the device node,
+  * he can't use it any longer, because he lost permission
+  * to do so.
+  */
+static int secure_unlink(const char *filename)
+{
+	int retval;
+
+	retval = chown(filename, 0, 0);
+	if (retval) {
+		dbg("chown(%s, 0, 0) failed with error '%s'",
+		    filename, strerror(errno));
+		/* We continue nevertheless.
+		 * I think it's very unlikely for chown
+		 * to fail here, if the file exists.
+		 */
+	}
+	retval = chmod(filename, 0000);
+	if (retval) {
+		dbg("chmod(%s, 0000) failed with error '%s'",
+		    filename, strerror(errno));
+		/* We continue nevertheless. */
+	}
+	retval = unlink(filename);
+	if (errno == ENOENT)
+		retval = 0;
+	if (retval) {
+		dbg("unlink(%s) failed with error '%s'",
+			filename, strerror(errno));
+	}
+	return retval;
+}
+
 static int delete_node(struct udevice *dev)
 {
 	char filename[NAME_SIZE];
@@ -79,14 +114,9 @@
 	strfieldcat(filename, dev->name);

 	info("removing device node '%s'", filename);
- -	retval = unlink(filename);
- -	if (errno == ENOENT)
- -		retval = 0;
- -	if (retval) {
- -		dbg("unlink(%s) failed with error '%s'",
- -			filename, strerror(errno));
+	retval = secure_unlink(filename);
+	if (retval)
 		return retval;
- -	}

 	/* remove partition nodes */
 	if (dev->partitions > 0) {
@@ -94,7 +124,7 @@
 		for (i = 1; i <= dev->partitions; i++) {
 			strfieldcpy(partitionname, filename);
 			strintcat(partitionname, i);
- -			unlink(partitionname);
+			secure_unlink(partitionname);
 		}
 	}

@@ -108,14 +138,9 @@
 		strfieldcat(filename, linkname);

 		dbg("unlinking symlink '%s'", filename);
- -		retval = unlink(filename);
- -		if (errno == ENOENT)
- -			retval = 0;
- -		if (retval) {
- -			dbg("unlink(%s) failed with error '%s'",
- -				filename, strerror(errno));
+		retval = secure_unlink(filename);
+		if (retval)
 			return retval;
- -		}
 		if (strchr(dev->symlink, '/')) {
 			delete_path(filename);
 		}

- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBF6xAFGK1OIvVOP4RArfvAJwNf/CnIZTnEvUSNu3N4WI3tkqBOwCfe4B8
sM+KFpEX2PuDKsqcjTO9pV8=
=rd9Y
-----END PGP SIGNATURE-----
