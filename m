Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVGCP6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVGCP6R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 11:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVGCP6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 11:58:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:31890 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261462AbVGCPoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 11:44:07 -0400
Date: Sun, 3 Jul 2005 17:44:05 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>
Subject: [PATCH 3/3] Use conditional
Message-ID: <20050703154405.GE11093@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	James Morris <jmorris@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QDIl5R72YNOeCxaP
Content-Type: multipart/mixed; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this optimizes the case where no LSM is loaded and the (new) default=20
capablities is used. These are not called via indirect calls but=20
called as hardcoded calls and might thus be inlined; the price for
this is a conditional -- benchmarks done by hp showed this to be
beneficial (on ia64).

Enjoy,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=security-avoid-indir-call
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Replace indirect calls by a branch
References: SUSE40217, SUSE39439

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

Index: linux-2.6.12/include/linux/security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/include/linux/security.h
+++ linux-2.6.12/include/linux/security.h
@@ -1246,17 +1246,21 @@ struct security_operations {
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
-#  define COND_SECURITY(seop, def) security_ops->seop
+/* Condition for invocation of non-default security_op */
+#  define COND_SECURITY(seop, def) 	\
+	(security_ops =3D=3D &capability_security_ops)? def: security_ops->seop
=20
 # else /* CONFIG_SECURITY */
 static inline int security_init(void)
 {
Index: linux-2.6.12/security/security.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/security/security.c
+++ linux-2.6.12/security/security.c
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

--lrvsYIebpInmECXG--

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyAfFxmLh6hyYd04RAnF+AKCRS7w+P6gidZp/pZcwGkMHhtqgAACdEXK5
p32xH3PBQXVi5A/RJVRd7mI=
=TqwF
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--
