Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVGCPoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVGCPoO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 11:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVGCPoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 11:44:13 -0400
Received: from ns.suse.de ([195.135.220.2]:26770 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261457AbVGCPne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 11:43:34 -0400
Date: Sun, 3 Jul 2005 17:43:33 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>
Subject: [PATCH 1/3] Make cap default
Message-ID: <20050703154333.GB11093@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	James Morris <jmorris@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: multipart/mixed; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This patch makes capabilities the default when no LSM is loaded,
thus resulting in more consistent behaviour with the default
behaviour being independent of CONFIG_SECURITY.

Enjoy,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=security-cap-def
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Default to capability rather than dummy if no LSM is loaded
References: SUSE40217, SUSE39439

If a kernel is compiled with CONFIG_SECURITY to enable LSM, the
default behaviour changes unless a user load capability.
This is undesirable. This patch makes capability the default.
capability can still be compiled as module and be loaded as LSM.
If loaded as primary LSM, it won't change anything. But it can
also be loaded as secondary LSM.
Note that we could think of getting rid of dummy; however, it's
still used as fallback for stubs that are not implemented by an
LSM. I did not want to change this with this patch set, though
I'd like to see it done if everyone agrees it's a good idea.

This is patch 1/5 of the LSM overhaul.

 Makefile     |    8 +++-----
 capability.c |   38 ++++++++++++++------------------------
 commoncap.c  |   37 +++++++++++++++++++++++++++++++++++++
 security.c   |   21 ++++++++++++---------
 4 files changed, 66 insertions(+), 38 deletions(-)

Signed-off-by: Kurt Garloff <garloff@suse.de>

Index: linux-2.6.10/security/security.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.10.orig/security/security.c
+++ linux-2.6.10/security/security.c
@@ -20,10 +20,11 @@
=20
 #define SECURITY_FRAMEWORK_VERSION	"1.0.0"
=20
 /* things that live in dummy.c */
-extern struct security_operations dummy_security_ops;
-extern void security_fixup_ops(struct security_operations *ops);
+extern void security_fixup_ops (struct security_operations *ops);
+/* default security ops */
+extern struct security_operations capability_security_ops;
=20
 struct security_operations *security_ops;	/* Initialized to NULL */
=20
 static inline int verify(struct security_operations *ops)
@@ -54,15 +55,17 @@ int __init security_init(void)
 {
 	printk(KERN_INFO "Security Framework v" SECURITY_FRAMEWORK_VERSION
 	       " initialized\n");
=20
-	if (verify(&dummy_security_ops)) {
+	if (verify(&capability_security_ops)) {
 		printk(KERN_ERR "%s could not verify "
-		       "dummy_security_ops structure.\n", __FUNCTION__);
+		       "capability_security_ops structure.\n", __FUNCTION__);
 		return -EIO;
 	}
=20
-	security_ops =3D &dummy_security_ops;
+	security_ops =3D &capability_security_ops;
+
+	/* Initialize compiled-in security modules */
 	do_security_initcalls();
=20
 	return 0;
 }
@@ -86,9 +89,9 @@ int register_security(struct security_op
 		       "security_operations structure.\n", __FUNCTION__);
 		return -EINVAL;
 	}
=20
-	if (security_ops !=3D &dummy_security_ops)
+	if (security_ops !=3D &capability_security_ops)
 		return -EAGAIN;
=20
 	security_ops =3D ops;
=20
@@ -103,20 +106,20 @@ int register_security(struct security_op
  * previously been registered with a successful call to register_security(=
).
  *
  * If @ops does not match the valued previously passed to register_securit=
y()
  * an error is returned.  Otherwise the default security options is set to=
 the
- * the dummy_security_ops structure, and 0 is returned.
+ * the capability_security_ops structure, and 0 is returned.
  */
 int unregister_security(struct security_operations *ops)
 {
 	if (ops !=3D security_ops) {
 		printk(KERN_INFO "%s: trying to unregister "
-		       "a security_opts structure that is not "
+		       "a security_ops structure that is not "
 		       "registered, failing.\n", __FUNCTION__);
 		return -EINVAL;
 	}
=20
-	security_ops =3D &dummy_security_ops;
+	security_ops =3D &capability_security_ops;
=20
 	return 0;
 }
=20
Index: linux-2.6.10/security/commoncap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.10.orig/security/commoncap.c
+++ linux-2.6.10/security/commoncap.c
@@ -324,8 +324,45 @@ int cap_vm_enough_memory(long pages)
 		cap_sys_admin =3D 1;
 	return __vm_enough_memory(pages, cap_sys_admin);
 }
=20
+#ifdef CONFIG_SECURITY
+struct security_operations capability_security_ops =3D {
+	.ptrace =3D			cap_ptrace,
+	.capget =3D			cap_capget,
+	.capset_check =3D			cap_capset_check,
+	.capset_set =3D			cap_capset_set,
+	.capable =3D			cap_capable,
+	.settime =3D			cap_settime,
+	.netlink_send =3D			cap_netlink_send,
+	.netlink_recv =3D			cap_netlink_recv,
+
+	.bprm_apply_creds =3D		cap_bprm_apply_creds,
+	.bprm_set_security =3D		cap_bprm_set_security,
+	.bprm_secureexec =3D		cap_bprm_secureexec,
+
+	.inode_setxattr =3D		cap_inode_setxattr,
+	.inode_removexattr =3D		cap_inode_removexattr,
+
+	.task_post_setuid =3D		cap_task_post_setuid,
+	.task_reparent_to_init =3D	cap_task_reparent_to_init,
+
+	.syslog =3D                       cap_syslog,
+
+	.vm_enough_memory =3D             cap_vm_enough_memory,
+};
+
+EXPORT_SYMBOL(capability_security_ops);
+/* Note: If the capability security module is loaded, we do NOT register
+ * the capability_security_ops but a second structure that has the
+ * identical entries. The reason is that this way,
+ * - we could stack on top of capability if it was stackable
+ * - a loaded capability module will prevent others to register, which
+ *   is the previous behaviour; if capabilities are used as default (not
+ *   because the module has been loaded), we allow the replacement.
+ */
+#endif
+
 EXPORT_SYMBOL(cap_capable);
 EXPORT_SYMBOL(cap_settime);
 EXPORT_SYMBOL(cap_ptrace);
 EXPORT_SYMBOL(cap_capget);
Index: linux-2.6.10/security/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.10.orig/security/Makefile
+++ linux-2.6.10/security/Makefile
@@ -4,16 +4,14 @@
=20
 obj-$(CONFIG_KEYS)			+=3D keys/
 subdir-$(CONFIG_SECURITY_SELINUX)	+=3D selinux
=20
-# if we don't select a security model, use the default capabilities
-ifneq ($(CONFIG_SECURITY),y)
+# We always need commoncap as it's default
 obj-y		+=3D commoncap.o
-endif
=20
 # Object file lists
 obj-$(CONFIG_SECURITY)			+=3D security.o dummy.o
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+=3D selinux/built-in.o
-obj-$(CONFIG_SECURITY_CAPABILITIES)	+=3D commoncap.o capability.o
-obj-$(CONFIG_SECURITY_ROOTPLUG)		+=3D commoncap.o root_plug.o
+obj-$(CONFIG_SECURITY_CAPABILITIES)	+=3D capability.o
+obj-$(CONFIG_SECURITY_ROOTPLUG)		+=3D root_plug.o
 obj-$(CONFIG_SECURITY_SECLVL)		+=3D seclvl.o
Index: linux-2.6.10/security/capability.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.10.orig/security/capability.c
+++ linux-2.6.10/security/capability.c
@@ -23,32 +23,21 @@
 #include <linux/netlink.h>
 #include <linux/ptrace.h>
 #include <linux/moduleparam.h>
=20
-static struct security_operations capability_ops =3D {
-	.ptrace =3D			cap_ptrace,
-	.capget =3D			cap_capget,
-	.capset_check =3D			cap_capset_check,
-	.capset_set =3D			cap_capset_set,
-	.capable =3D			cap_capable,
-	.settime =3D			cap_settime,
-	.netlink_send =3D			cap_netlink_send,
-	.netlink_recv =3D			cap_netlink_recv,
-
-	.bprm_apply_creds =3D		cap_bprm_apply_creds,
-	.bprm_set_security =3D		cap_bprm_set_security,
-	.bprm_secureexec =3D		cap_bprm_secureexec,
-
-	.inode_setxattr =3D		cap_inode_setxattr,
-	.inode_removexattr =3D		cap_inode_removexattr,
-
-	.task_post_setuid =3D		cap_task_post_setuid,
-	.task_reparent_to_init =3D	cap_task_reparent_to_init,
-
-	.syslog =3D                       cap_syslog,
-
-	.vm_enough_memory =3D             cap_vm_enough_memory,
-};
+/* Note: If the capability security module is loaded, we do NOT register
+ * the capability_security_ops but a second structure capability_ops
+ * that has the identical entries. The reasons:
+ * - we could stack on top of capability if it was stackable
+ * - a loaded capability module will prevent others to register, which
+ *   is the previous behaviour; if capabilities are used as default (not
+ *   because the module has been loaded), we allow the replacement.
+ */
+
+/* Struct from commoncaps */
+extern struct security_operations capability_security_ops;
+/* Struct to hold the copy */
+static struct security_operations capability_ops;
=20
 #define MY_NAME __stringify(KBUILD_MODNAME)
=20
 /* flag to keep track of how we were registered */
@@ -59,8 +48,9 @@ module_param_named(disable, capability_d
 MODULE_PARM_DESC(disable, "To disable capabilities module set disable =3D =
1");
=20
 static int __init capability_init (void)
 {
+	memcpy(&capability_ops, &capability_security_ops, sizeof(capability_ops));
 	if (capability_disable) {
 		printk(KERN_INFO "Capabilities disabled at initialization\n");
 		return 0;
 	}


--ZfOjI3PrQbgiZnxM--

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyAelxmLh6hyYd04RAo5bAKDKRUOyzFYoRR9SdoF7FdxUQKHh3QCgoQRF
Ivx7zPpKAnUN1cTQxRJjAd8=
=knFb
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
