Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUHIPgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUHIPgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUHIPdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:33:06 -0400
Received: from mout1.freenet.de ([194.97.50.132]:52875 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S266643AbUHIP3R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:29:17 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Eric Lammerts <eric@lammerts.org>
Subject: Re: dynamic /dev security hole?
Date: Mon, 9 Aug 2004 15:30:40 +0200
User-Agent: KMail/1.6.2
References: <20040808162115.GA7597@kroah.com> <20040809000727.1eaf917b.Ballarin.Marc@gmx.de> <Pine.LNX.4.58.0408090025590.26834@vivaldi.madbase.net>
In-Reply-To: <Pine.LNX.4.58.0408090025590.26834@vivaldi.madbase.net>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Greg KH <greg@kroah.com>,
       albert@users.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408091530.55244.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Eric Lammerts <eric@lammerts.org>:
> Just an idea for a fix for this problem: If udev would change the
> permissions to 000 and ownership to root.root just before it unlinks
> the device node, the copy would become useless.

Like this?
Only compile tested against glibc.


===== udev-remove.c 1.31 vs edited =====
- --- 1.31/udev-remove.c	2004-04-01 04:12:56 +02:00
+++ edited/udev-remove.c	2004-08-09 15:23:12 +02:00
@@ -79,6 +79,23 @@
 	strfieldcat(filename, dev->name);
 
 	info("removing device node '%s'", filename);
+	/* first remove all permissions on the device node.
+	 * This fixes a security issue. If the user created
+	 * a hard-link to the device node, he can't use this
+	 * anymore, if we change permissions.
+	 */
+	retval = chmod(filename, 0000);
+	if (retval) {
+		info("chmod(%s, 0000) failed with error '%s'",
+		     filename, strerror(errno));
+		// we continue nevertheless.
+	}
+	retval = chown(filename, 0, 0);
+	if (retval) {
+		info("chown(%s, 0, 0) failed with error '%s'",
+		     filename, strerror(errno));
+		// we continue nevertheless.
+	}
 	retval = unlink(filename);
 	if (errno == ENOENT)
 		retval = 0;

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBF3yMFGK1OIvVOP4RArMrAJ0SvykBehCxPUYPLPIQuGRn3m5eHgCfShXs
e/S0iWzu/qTtDVb1+zp9LRo=
=UsXa
-----END PGP SIGNATURE-----
