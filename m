Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUCVVLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUCVVLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:11:08 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:3272 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263045AbUCVVLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:11:00 -0500
Subject: [PATCH][SELINUX] Audit compute_sid errors
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Rik Faith <faith@redhat.com>, Russell Coker <russell@coker.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NY6bxBA9q3xH9i9DyLRm"
Organization: National Security Agency
Message-Id: <1079989817.26643.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 22 Mar 2004 16:10:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NY6bxBA9q3xH9i9DyLRm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch against 2.6.5-rc2-mm1 changes an error message printk'd by
security_compute_sid to use the audit framework instead.  These errors
reflect situations where a security transition would normally occur due
to policy, but the resulting security context is not valid.  The patch
also changes the code to always call the audit framework rather than
only doing so when permissive as this was causing problems with testing
policy, and does some code cleanup.  Please apply.

--- linux-2.6.5-rc2-mm1/security/selinux/ss/services.c.orig	2004-03-22 10:5=
2:25.000000000 -0500
+++ linux-2.6.5-rc2-mm1/security/selinux/ss/services.c	2004-03-22 15:34:31.=
897927706 -0500
@@ -26,6 +26,7 @@
 #include <linux/errno.h>
 #include <linux/in.h>
 #include <linux/sched.h>
+#include <linux/audit.h>
 #include <asm/semaphore.h>
 #include "flask.h"
 #include "avc.h"
@@ -548,32 +549,34 @@
 	return rc;
 }
=20
-static inline int compute_sid_handle_invalid_context(
+static int compute_sid_handle_invalid_context(
 	struct context *scontext,
 	struct context *tcontext,
 	u16 tclass,
 	struct context *newcontext)
 {
-	int rc =3D 0;
-
-	if (selinux_enforcing) {
-		rc =3D -EACCES;
-	} else {
-		char *s, *t, *n;
-		u32 slen, tlen, nlen;
+	char *s =3D NULL, *t =3D NULL, *n =3D NULL;
+	u32 slen, tlen, nlen;
=20
-		context_struct_to_string(scontext, &s, &slen);
-		context_struct_to_string(tcontext, &t, &tlen);
-		context_struct_to_string(newcontext, &n, &nlen);
-		printk(KERN_ERR "security_compute_sid:  invalid context %s", n);
-		printk(" for scontext=3D%s", s);
-		printk(" tcontext=3D%s", t);
-		printk(" tclass=3D%s\n", policydb.p_class_val_to_name[tclass-1]);
-		kfree(s);
-		kfree(t);
-		kfree(n);
-	}
-	return rc;
+	if (context_struct_to_string(scontext, &s, &slen) < 0)
+		goto out;
+	if (context_struct_to_string(tcontext, &t, &tlen) < 0)
+		goto out;
+	if (context_struct_to_string(newcontext, &n, &nlen) < 0)
+		goto out;
+	audit_log(current->audit_context,
+		  "security_compute_sid:  invalid context %s"
+		  " for scontext=3D%s"
+		  " tcontext=3D%s"
+		  " tclass=3D%s",
+		  n, s, t, policydb.p_class_val_to_name[tclass-1]);
+out:
+	kfree(s);
+	kfree(t);
+	kfree(n);
+	if (!selinux_enforcing)
+		return 0;
+	return -EACCES;
 }
=20
 static int security_compute_sid(u32 ssid,

--=20
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-NY6bxBA9q3xH9i9DyLRm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAX1Y5ct2ZrGjsv6cRAryJAKCEOuH7Ar3FYH+0pLcWaXy3t0rW1ACbBPQH
aqBBNxkQS4prkXTtKC9oahs=
=5+vh
-----END PGP SIGNATURE-----

--=-NY6bxBA9q3xH9i9DyLRm--

