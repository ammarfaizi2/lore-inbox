Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVBMVR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVBMVR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 16:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVBMVR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 16:17:59 -0500
Received: from mail.suse.de ([195.135.220.2]:46990 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261311AbVBMVMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 16:12:00 -0500
Date: Sun, 13 Feb 2005 16:11:39 -0500
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH] 3/5: LSM hooks rework
Message-ID: <20050213211139.GK27893@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
References: <20050213210515.GH27893@tpkurt.garloff.de> <20050213211034.GI27893@tpkurt.garloff.de> <20050213211109.GJ27893@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
Content-Disposition: inline
In-Reply-To: <20050213211109.GJ27893@tpkurt.garloff.de>
X-Operating-System: Linux 2.6.11-rc3-bk6-20-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Replace indirect calls by a branch
References: 40217, 39439

In the LSM stub collection, rather do a branch than an indirect
call. Many of the functions called do only return 0 or do nothing
for the default (capability) case.
This is a fast-path optimization; a branch is faster than an
indirect call, even more so if correctly predicted.
This shows a >3% perf. increase in netperf -t TCP_RR benchmark on IA64.
(More exactly: The benchmark was taken with the next two patches
 applied as well, but I attribute the main effect to this patch.)

This is patch 3/5 of the LSM overhaul.

 include/linux/security.h |    6 +++++-
 security/security.c      |    2 --
 2 files changed, 5 insertions(+), 3 deletions(-)

Signed-off-by: Kurt Garloff <garloff@suse.de>

Index: linux-2.6.10/include/linux/security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.10.orig/include/linux/security.h
+++ linux-2.6.10/include/linux/security.h
@@ -1241,17 +1241,21 @@ struct security_operations {
 };
=20
 /* global variables */
 extern struct security_operations *security_ops;
+/* default security ops */
+extern struct security_operations capability_security_ops;
=20
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
 extern int unregister_security	(struct security_operations *ops);
 extern int mod_reg_security	(const char *name, struct security_operations =
*ops);
 extern int mod_unreg_security	(const char *name, struct security_operation=
s *ops);
=20
-#define COND_SECURITY(seop, def) security_ops->seop
+/* Condition for invocation of non-default security_op */
+#define COND_SECURITY(seop, def) 	\
+	(security_ops =3D=3D &capability_security_ops)? def: security_ops->seop
=20
 #else /* CONFIG_SECURITY */
 static inline int security_init(void)
 {
Index: linux-2.6.10/security/security.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.10.orig/security/security.c
+++ linux-2.6.10/security/security.c
@@ -21,10 +21,8 @@
 #define SECURITY_FRAMEWORK_VERSION	"1.0.0"
=20
 /* things that live in dummy.c */
 extern void security_fixup_ops (struct security_operations *ops);
-/* default security ops */
-extern struct security_operations capability_security_ops;
=20
 struct security_operations *security_ops;	/* Initialized to NULL */
=20
 static inline int verify(struct security_operations *ops)
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCD8KLxmLh6hyYd04RAu8SAKCw73pwcZ1IWxdG9Lu2lgZmlL4JGQCeNWiZ
7JhqGHfdvh+hTNuMc8dT/rE=
=R6dX
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--
