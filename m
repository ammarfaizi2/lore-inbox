Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVGELDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVGELDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 07:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVGELDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 07:03:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:19089 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261804AbVGEKuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 06:50:39 -0400
Date: Tue, 5 Jul 2005 09:21:11 +0200
From: Kurt Garloff <garloff@suse.de>
To: Tony Jones <tonyj@immunix.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>,
       Linux LSM list <linux-security-module@wirex.com>
Subject: Re: [PATCH 1/3] Make cap default
Message-ID: <20050705072111.GA10453@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Tony Jones <tonyj@immunix.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	James Morris <jmorris@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>,
	Linux LSM list <linux-security-module@wirex.com>
References: <20050703154333.GB11093@tpkurt.garloff.de> <20050703225152.GA25706@immunix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20050703225152.GA25706@immunix.com>
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Sun, Jul 03, 2005 at 03:51:52PM -0700, Tony Jones wrote:
> On Sun, Jul 03, 2005 at 05:43:33PM +0200, Kurt Garloff wrote:
>=20
> > Note that we could think of getting rid of dummy; however, it's
> > still used as fallback for stubs that are not implemented by an
> > LSM. I did not want to change this with this patch set, though
> > I'd like to see it done if everyone agrees it's a good idea.
>=20
> I think this needs to happen (dummy goes away or it's contents are replac=
ed
> by cap routines as appropriate).

I agree, but it's not trivial, as we need to review existing LSMs:
For whatever security_ops function that they don't implement and
where dummy and capability differ, we'll need to fix up.

Before someone goes there, we should agree that it's a good idea.

Currently, capability has only a small subset of functions implemented
and still gets the other ones patched in from dummy through verify()/
security_fixup_ops().

> Currently in security_init() verify(&dummy_security_ops) calling=20
> security_fixup_ops is a no-op in terms of modifying dummy. In your patch =
as
> you suggest verify(&capability_security_ops) now patches routines from du=
mmy=20
> into this default capability_security_ops.  The code is already too baroq=
ue,
> no point making it more complex.

The alternative would be making capability_security_ops complete.
The patching could be avoided completely by using something like
this in security.h:
	if (security_ops->OPERATION =3D=3D NULL)
		return cap_OPERTAION(x,y,z)

Or, even better, after patches 2a, 2b, 3 have been applied:

#  define COND_SECURITY(seop, def)			\
	(security_opt->seop =3D=3D NULL) ||			\
	 security_ops =3D=3D &capability_security_ops)?	\
	 def: security_ops->seop

The latter has the very nice side effect that we DON'T need to code
all the {return 0;}; and {}; functions into capability.c, but rather
use the return values we know already, because they are part of
security.h anyway for the !defined(CONFIG_SECURITY) case.

The more I think about it, the better I like that approach.
It will also be a nice performance improvement again:
Instead of unconditionally calling a function pointer (which
includes passing all the argument setup, cleanup, ...), we just
have one branch (that will be correctly predicted after the second
occurence) and know the return value immediately. Nice.
Allowing such things was one of my motivations of cleaning up
security.h.

But before, we really need to make sure all LSMs work with=20
security_fixup_ops() patching in capability ops and not dummy ops.

> I think the necessary functions need to be present in this new base struc=
ture
> and security_fixup_ops patches from it into whatever new ops a caller pas=
ses,=20
> dummy goes away. As a bonus, at this point your capability_ops struct in
> capability.c can really be different :-)

I don't consider this a bonus. Loading capability should not change
the behaviour IMVHO.[*]
The fact that the capability LSM may still be compiled, despite being
pointless (it's the default now), is that you may load it as secondary
LSM. I clarified this in the comment.

[*] Well, we could consider enhancing capability in the future and
leaving the old behaviour default for both !defined(CONFIG_SECURITY)
and the no-LSM-loaded case and have slightly enhanced semantics by
loading capability. I would prefer renaming the LSM then however.

> --- linux-2.6.10.orig/security/commoncap.c
> +++ linux-2.6.10/security/commoncap.c
> [snip]
> > +EXPORT_SYMBOL(capability_security_ops);
> > +/* Note: If the capability security module is loaded, we do NOT regist=
er
> > + * the capability_security_ops but a second structure that has the
> > + * identical entries. The reason is that this way,
> > + * - we could stack on top of capability if it was stackable
> > + * - a loaded capability module will prevent others to register, which
> > + *   is the previous behaviour; if capabilities are used as default (n=
ot
> > + *   because the module has been loaded), we allow the replacement.
> > + */
> > +#endif
>=20
> The intent here is to make it past the=20
> 	if (security_ops !=3D &capability_security_ops)
> check in security.c::register_security so that it is possible to actually
> register capability (capability_ops) subsequently as a module should you
> so desire, no?

Correct.

> The above description doesn't impart that.  Plus why would you want to st=
ack
> capability on top of this base capability, even if it it supported stacki=
ng?

I could have disabled the creation of the capability LSM completely, but
who knows whether or not capability could be useful as secondary LSM
(or as part of some stack using stacker)? I can't exclude that ...

I have improved the comment, please review attached patch.

> --- linux-2.6.10.orig/security/capability.c
> +++ linux-2.6.10/security/capability.c
>=20
> +/* Note: If the capability security module is loaded, we do NOT register
> + * the capability_security_ops but a second structure capability_ops
> + * that has the identical entries. The reasons:
> + * - we could stack on top of capability if it was stackable
> + * - a loaded capability module will prevent others to register, which
> + *   is the previous behaviour; if capabilities are used as default (not
> + *   because the module has been loaded), we allow the replacement.
>=20
> Ditto for this comment.

Yep, changed as well.

>=20
> >  static int __init capability_init (void)
> >  {
> > +	memcpy(&capability_ops, &capability_security_ops, sizeof(capability_o=
ps));
> >  	if (capability_disable) {
> >  		printk(KERN_INFO "Capabilities disabled at initialization\n");
> >  		return 0;
> >  	}
>=20
> No point doing the memcpy if capability_disable is true.

We could move it below the check.
I've done so, please review attached patch.
(Sidenote: Patch 3 will have a trivial reject after the changes here.)

Thanks a lot for your comments!
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=security-cap-def
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Default to capability rather than dummy if no LSM is loaded
References: SUSE40217, SUSE39439

If a kernel is compiled with CONFIG_SECURITY to enable LSM, the
default behaviour changes unless the admin loads capability.
This is undesirable. This patch makes capability the default.
capability can still be compiled as module and be loaded as LSM.
If loaded as primary LSM, it won't change anything. But it may
also be loaded as secondary LSM and stacked on top of another
LSM (if the other LSM allows this or if stacker is used).

Note that we could think of getting rid of dummy; however, it's
still used as fallback for stubs that are not implemented by an
LSM. I did not want to change this with this patch set, though
I'd like to see it done as a subsequent step if everyone agrees=20
it's a good idea. We'd need to review existing LSMs and see what
changes they might need.

This is patch 1/3 of the LSM overhaul.

Signed-off-by: Kurt Garloff <garloff@suse.de>
 Makefile     |    8 +++-----
 capability.c |   47 +++++++++++++++++++++++------------------------
 commoncap.c  |   37 +++++++++++++++++++++++++++++++++++++
 security.c   |   21 ++++++++++++---------
 4 files changed, 75 insertions(+), 38 deletions(-)

Index: linux-2.6.12/security/security.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/security/security.c
+++ linux-2.6.12/security/security.c
@@ -21,8 +21,9 @@
 #define SECURITY_FRAMEWORK_VERSION	"1.0.0"
=20
 /* things that live in dummy.c */
-extern struct security_operations dummy_security_ops;
 extern void security_fixup_ops(struct security_operations *ops);
+/* default security ops */
+extern struct security_operations capability_security_ops;
=20
 struct security_operations *security_ops;	/* Initialized to NULL */
=20
@@ -55,13 +56,15 @@ int __init security_init(void)
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
@@ -87,7 +90,7 @@ int register_security(struct security_op
 		return -EINVAL;
 	}
=20
-	if (security_ops !=3D &dummy_security_ops)
+	if (security_ops !=3D &capability_security_ops)
 		return -EAGAIN;
=20
 	security_ops =3D ops;
@@ -104,18 +107,18 @@ int register_security(struct security_op
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
Index: linux-2.6.12/security/commoncap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/security/commoncap.c
+++ linux-2.6.12/security/commoncap.c
@@ -325,6 +325,41 @@ int cap_vm_enough_memory(long pages)
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
+/* Note: capability_security_ops is the default for security_ops
+ * now which gets used if no LSM is loaded.
+ * If capability is loaded, a copy of capability_security_ops
+ * is registered, so we know whether or not we use a non-default
+ * security_ops. If we don't, replacement is not possible.
+ */
+#endif
+
 EXPORT_SYMBOL(cap_capable);
 EXPORT_SYMBOL(cap_settime);
 EXPORT_SYMBOL(cap_ptrace);
Index: linux-2.6.12/security/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/security/Makefile
+++ linux-2.6.12/security/Makefile
@@ -5,15 +5,13 @@
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
Index: linux-2.6.12/security/capability.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/security/capability.c
+++ linux-2.6.12/security/capability.c
@@ -24,30 +24,28 @@
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
+/* Note: Capabilities are default now, even if CONFIG_SECURITY
+ * is enabled and no LSM is loaded. (Previously, the dummy
+ * functions would have been called in that case which resulted
+ * in a slightly unusable system.)
+ * The capability LSM may still be compiled and loaded; it won't
+ * make a difference though except for slowing down some operations
+ * a tiny bit and (more severly) for disallowing loading another LSM.
+ * To have it as LSM may still be useful: It could be stacked on top
+ * of another LSM (if the other LSM allows this or if the stacker
+ * is used).
+ * If the capability LSM is loaded, we do NOT register the=20
+ * capability_security_ops but a second structure capability_ops
+ * that has identical entries. We need to differentiate
+ * between capabilities used as default and used as LSM as in
+ * the latter case replacing it by just loading another LSM is
+ * not possible.
+ */
+
+/* Struct from commoncaps */
+extern struct security_operations capability_security_ops;
+/* Struct to hold the copy */
+static struct security_operations capability_ops;
=20
 #define MY_NAME __stringify(KBUILD_MODNAME)
=20
@@ -64,6 +62,7 @@ static int __init capability_init (void)
 		printk(KERN_INFO "Capabilities disabled at initialization\n");
 		return 0;
 	}
+	memcpy(&capability_ops, &capability_security_ops, sizeof(capability_ops));
 	/* register ourselves with the security framework */
 	if (register_security (&capability_ops)) {
 		/* try registering with primary module */

--bg08WKrSYDhXBjb5--

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyjTnxmLh6hyYd04RAgSSAJ9UUXz+9Y/9ZgId3TPdm2M+8R/uowCeJcxm
aLOX/kQwzBOWMD0q1f9Eq/A=
=M0qy
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
