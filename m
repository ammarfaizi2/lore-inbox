Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVBMVTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVBMVTq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 16:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVBMVSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 16:18:41 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:33423 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261313AbVBMVM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 16:12:58 -0500
Date: Sun, 13 Feb 2005 16:12:38 -0500
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH] 5/5: LSM hooks rework
Message-ID: <20050213211238.GM27893@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
References: <20050213210515.GH27893@tpkurt.garloff.de> <20050213211034.GI27893@tpkurt.garloff.de> <20050213211109.GJ27893@tpkurt.garloff.de> <20050213211139.GK27893@tpkurt.garloff.de> <20050213211210.GL27893@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OGLMwEELQbPC02lM"
Content-Disposition: inline
In-Reply-To: <20050213211210.GL27893@tpkurt.garloff.de>
X-Operating-System: Linux 2.6.11-rc3-bk6-20-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OGLMwEELQbPC02lM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Test security_enabled var rather than security_ops pointer
References: 40217, 39439

Rather than doing a pointer comparison, test an integer var
for being null. Should be slightly faster.
I consider this patch as optional.

Note that it does not introduce a (new) race, as we still set
the security_ops pointer to the capability_security_ops. So no
wmb() is needed for the module unload case.

Sidenote: A wmb() in the module load and unload cases might
actually be useful to ensure that the other CPUs start using the
new LSM pointer ASAP. It's still racy, but that's by design of
LSM. Introducing locks would hurt performance tremendously.
One could do RCU ... but that's not for this patchset.

This is patch 5/5 of the LSM overhaul.

 include/linux/security.h |    7 ++++---
 security/security.c      |    7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

Signed-off-by: Kurt Garloff <garloff@suse.de>

Index: linux-2.6.10/include/linux/security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.10.orig/include/linux/security.h
+++ linux-2.6.10/include/linux/security.h
@@ -1241,10 +1241,10 @@ struct security_operations {
 };
=20
 /* global variables */
 extern struct security_operations *security_ops;
-/* default security ops */
-extern struct security_operations capability_security_ops;
+/* Security enabled? */
+extern int security_enabled;
=20
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -1253,16 +1253,17 @@ extern int mod_reg_security	(const char=20
 extern int mod_unreg_security	(const char *name, struct security_operation=
s *ops);
=20
 /* Condition for invocation of non-default security_op */
 #define COND_SECURITY(seop, def) 	\
-	(likely(security_ops =3D=3D &capability_security_ops))? def: security_ops=
->seop
+	(unlikely(security_enabled))? security_ops->seop: def
=20
 #else /* CONFIG_SECURITY */
 static inline int security_init(void)
 {
 	return 0;
 }
=20
+# define security_enabled 0
 # define COND_SECURITY(seop, def) def
 #endif
=20
 /* SELinux noop */
Index: linux-2.6.10/security/security.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.10.orig/security/security.c
+++ linux-2.6.10/security/security.c
@@ -21,10 +21,14 @@
 #define SECURITY_FRAMEWORK_VERSION	"1.0.0"
=20
 /* things that live in dummy.c */
 extern void security_fixup_ops (struct security_operations *ops);
+/* default security ops */
+extern struct security_operations capability_security_ops;
=20
 struct security_operations *security_ops;	/* Initialized to NULL */
+int security_enabled;				/* ditto */
+EXPORT_SYMBOL(security_enabled);
=20
 static inline int verify(struct security_operations *ops)
 {
 	/* verify the security_operations structure exists */
@@ -59,8 +63,9 @@ int __init security_init(void)
 		       "capability_security_ops structure.\n", __FUNCTION__);
 		return -EIO;
 	}
=20
+	security_enabled =3D 0;
 	security_ops =3D &capability_security_ops;
=20
 	/* Initialize compiled-in security modules */
 	do_security_initcalls();
@@ -91,8 +96,9 @@ int register_security(struct security_op
 	if (security_ops !=3D &capability_security_ops)
 		return -EAGAIN;
=20
 	security_ops =3D ops;
+	security_enabled =3D 1;
=20
 	return 0;
 }
=20
@@ -115,8 +121,9 @@ int unregister_security(struct security_
 		       "registered, failing.\n", __FUNCTION__);
 		return -EINVAL;
 	}
=20
+	security_enabled =3D 0;
 	security_ops =3D &capability_security_ops;
=20
 	return 0;
 }
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--OGLMwEELQbPC02lM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCD8LGxmLh6hyYd04RAmUWAJ9b/2lfrbuNRBjX+BwPF1xD/u8vTgCeOn5k
m12LmqLYyAAeAgdN9uChh6Q=
=8cav
-----END PGP SIGNATURE-----

--OGLMwEELQbPC02lM--
