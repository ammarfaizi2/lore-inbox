Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUHIRP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUHIRP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUHIRP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:15:26 -0400
Received: from mout1.freenet.de ([194.97.50.132]:62105 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S266753AbUHIRPL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:15:11 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Eric Lammerts <eric@lammerts.org>
Subject: Re: dynamic /dev security hole?
Date: Mon, 9 Aug 2004 19:14:16 +0200
User-Agent: KMail/1.6.2
References: <20040808162115.GA7597@kroah.com> <200408091854.27019.mbuesch@freenet.de> <Pine.LNX.4.58.0408091302010.9426@vivaldi.madbase.net>
In-Reply-To: <Pine.LNX.4.58.0408091302010.9426@vivaldi.madbase.net>
Cc: Albert Cahalan <albert@users.sf.net>, Greg KH <greg@kroah.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, albert@users.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408091914.19412.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Eric Lammerts <eric@lammerts.org>:
> Better not do it for symlinks.

Yes, you're right.

===== udev-remove.c 1.31 vs edited =====
- --- 1.31/udev-remove.c	2004-04-01 04:12:56 +02:00
+++ edited/udev-remove.c	2004-08-09 19:12:55 +02:00
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
 

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBF7DoFGK1OIvVOP4RAklbAJ0QXZkfiDOExHqTXpue+mKJCeIBHwCgwzAa
3V4LF0jNgiDyXbm6rw4wxqI=
=wXmk
-----END PGP SIGNATURE-----
