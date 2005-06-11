Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVFKAGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVFKAGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 20:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVFKAGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 20:06:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39826 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261438AbVFKAFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 20:05:49 -0400
Date: Fri, 10 Jun 2005 20:05:48 -0400
From: Neil Horman <nhorman@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx, nhorman@redhat.com
Subject: [Patch][RFC] fcntl: add ability to stop monitored processes
Message-ID: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey there!
	I've recently developed this patch in pursuit of an ability to trap
proceses making modifcations to monitored directories, and I thought It wou=
ld be
a nice feature to add to the mainline kernel.  It basically adds a flag to =
the
F_NOTIFY fcntl which optionally sends a SIGSTOP to the process making the
flagged modifications to the monitored directories, and passes the pid of t=
he
stopped process to the monitoring process.  I've tested it, and it works qu=
ite
well for me.  Looking for comments/approvial/incorporation.

Thanks and Regards
Neil

Signed-off-by: Neil Horman <nhorman@redhat.com>

 fs/dnotify.c          |    2 ++
 fs/fcntl.c            |    1 +
 include/linux/fcntl.h |    1 +
 3 files changed, 4 insertions(+)


--- linux-2.6/include/linux/fcntl.h.orig	2005-06-10 16:04:48.000000000 -0400
+++ linux-2.6/include/linux/fcntl.h	2005-06-10 16:02:16.000000000 -0400
@@ -21,6 +21,7 @@
 #define DN_DELETE	0x00000008	/* File removed */
 #define DN_RENAME	0x00000010	/* File renamed */
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
+#define DN_STOPSND	0x40000000	/* Send a SIGSTOP to the sender */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
=20
 #ifdef __KERNEL__
--- linux-2.6/fs/dnotify.c.orig	2005-05-04 21:47:58.000000000 -0400
+++ linux-2.6/fs/dnotify.c	2005-06-10 16:02:16.000000000 -0400
@@ -138,6 +138,8 @@ void __inode_dir_notify(struct inode *in
 			changed =3D 1;
 			kmem_cache_free(dn_cache, dn);
 		}
+		if (dn->dn_mask & DN_STOPSND)
+			send_sig(SIGSTOP,current,1);
 	}
 	if (changed)
 		redo_inode_mask(inode);
--- linux-2.6/fs/fcntl.c.orig	2005-05-04 21:47:58.000000000 -0400
+++ linux-2.6/fs/fcntl.c	2005-06-10 16:05:17.000000000 -0400
@@ -438,6 +438,7 @@ static void send_sigio_to_task(struct ta
 			else
 				si.si_band =3D band_table[reason - POLL_IN];
 			si.si_fd    =3D fd;
+			si.si_pid   =3D current->pid;
 			if (!send_group_sig_info(fown->signum, &si, p))
 				break;
 		/* fall-through: fall back on the old plain SIGIO signal */
--=20
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCqircM+bEoZKnT6ERAgkiAJ9p+rIqYsDdxj66gjZ3ThYVk5aaGQCdFPOI
lh9OXRoabBJOo5s+Fsf/VHw=
=m1Dz
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
