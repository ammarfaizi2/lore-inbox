Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUHJQrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUHJQrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUHJQnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:43:32 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:55001 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267546AbUHJQW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:22:59 -0400
Date: Tue, 10 Aug 2004 10:14:20 -0500
From: Michael Halcrow <lkml@halcrow.us>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] BSD Secure Levels LSM (1/3)
Message-ID: <20040810151420.GA4993@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This set of patches implements BSD Secure Levels as a Linux Security
Module (LSM).

The purpose of this patch is to leverage the LSM hook infrastructure
to provide administrators who are already familiar with BSD Secure
Levels the option of using a simple protection mechanism on their
Linux servers.  By using this module, those administrators who require
the security provided by BSD Secure Levels do not have to deal with
the complexity of deploying a capabilities- or SE Linux-based
mandatory access control solution.

Sys Admin Magazine is carrying an article about this module in its
September issue:

http://www.samag.com/documents/s=3D9304/sam0409a/0409a.htm

This particular patch adds a set of hooks that are necessary to catch
attempts to decrement the system time.  These hooks do not restrict
hardware devices that perform this operation, such as in
drivers/acorn/char/i2c.c.

Mike
=2E___________________________________________________________________.
                         Michael A. Halcrow                         =20
       Security Software Engineer, IBM Linux Technology Center      =20
GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="settime_2.6.8-rc3.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.8-rc3/arch/mips/kernel/sysirix.c	2004-08-09 16:15:39.00000000=
0 -0500
+++ linux-2.6.8-rc3_seclvl/arch/mips/kernel/sysirix.c	2004-08-09 16:16:33.0=
00000000 -0500
@@ -614,8 +614,14 @@
=20
 asmlinkage int irix_stime(int value)
 {
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
+	int err;
+	struct timespec tv;
+
+	tv.tv_sec =3D value;
+	tv.tv_nsec =3D 0;
+	err =3D security_settime(&tv, NULL);
+	if (err)
+		return err;
=20
 	write_seqlock_irq(&xtime_lock);
 	xtime.tv_sec =3D value;
--- linux-2.6.8-rc3/arch/ppc64/kernel/time.c	2004-08-09 16:15:42.000000000 =
-0500
+++ linux-2.6.8-rc3_seclvl/arch/ppc64/kernel/time.c	2004-08-09 16:16:35.000=
000000 -0500
@@ -435,9 +435,7 @@
 {
 	int value;
 	struct timespec myTimeval;
-
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
+	int err;
=20
 	if (get_user(value, tptr))
 		return -EFAULT;
@@ -445,6 +443,10 @@
 	myTimeval.tv_sec =3D value;
 	myTimeval.tv_nsec =3D 0;
=20
+	err =3D security_settime(&myTimeval, NULL);
+	if (err)
+		return err;
+
 	do_settimeofday(&myTimeval);
=20
 	return 0;
@@ -460,9 +462,7 @@
 {
 	long value;
 	struct timespec myTimeval;
-
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
+	int err;
=20
 	if (get_user(value, tptr))
 		return -EFAULT;
@@ -470,6 +470,10 @@
 	myTimeval.tv_sec =3D value;
 	myTimeval.tv_nsec =3D 0;
=20
+	err =3D security_settime(&myTimeval, NULL);
+	if (err)
+		return err;
+
 	do_settimeofday(&myTimeval);
=20
 	return 0;
--- linux-2.6.8-rc3/include/linux/security.h	2004-08-09 16:16:08.000000000 =
-0500
+++ linux-2.6.8-rc3_seclvl/include/linux/security.h	2004-08-09 16:17:00.000=
000000 -0500
@@ -39,6 +39,7 @@
  * as the default capabilities functions
  */
 extern int cap_capable (struct task_struct *tsk, int cap);
+extern int cap_settime (struct timespec *ts, struct timezone *tz);
 extern int cap_ptrace (struct task_struct *parent, struct task_struct *chi=
ld);
 extern int cap_capget (struct task_struct *target, kernel_cap_t *effective=
, kernel_cap_t *inheritable, kernel_cap_t *permitted);
 extern int cap_capset_check (struct task_struct *target, kernel_cap_t *eff=
ective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
@@ -999,6 +1000,12 @@
  *	See the syslog(2) manual page for an explanation of the @type values. =
=20
  *	@type contains the type of action.
  *	Return 0 if permission is granted.
+ * @settime:
+ *	Check permission to change the system time.=20
+ *	struct timespec and timezone are defined in include/linux/time.h
+ *	@ts contains new time
+ *	@tz contains new timezone
+ *	Return 0 if permission is granted.
  * @vm_enough_memory:
  *	Check permissions for allocating a new virtual mapping.
  *      @pages contains the number of pages.
@@ -1034,6 +1041,7 @@
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
 	int (*syslog) (int type);
+	int (*settime) (struct timespec *ts, struct timezone *tz);
 	int (*vm_enough_memory) (long pages);
=20
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
@@ -1289,6 +1297,12 @@
 	return security_ops->syslog(type);
 }
=20
+static inline int security_settime(struct timespec *ts, struct timezone *t=
z)
+{
+	return security_ops->settime(ts, tz);
+}
+
+
 static inline int security_vm_enough_memory(long pages)
 {
 	return security_ops->vm_enough_memory(pages);
@@ -1961,6 +1975,11 @@
 	return cap_syslog(type);
 }
=20
+static inline int security_settime(struct timespec *ts, struct timezone *t=
z)
+{
+	return cap_settime(ts, tz);
+}
+
 static inline int security_vm_enough_memory(long pages)
 {
 	return cap_vm_enough_memory(pages);
--- linux-2.6.8-rc3/kernel/time.c	2004-06-16 00:19:01.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/kernel/time.c	2004-08-09 08:05:02.000000000 -0500
@@ -28,6 +28,7 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
=20
@@ -74,13 +75,17 @@
 asmlinkage long sys_stime(time_t __user *tptr)
 {
 	struct timespec tv;
+	int err;
=20
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
 	if (get_user(tv.tv_sec, tptr))
 		return -EFAULT;
=20
 	tv.tv_nsec =3D 0;
+
+	err =3D security_settime(&tv, NULL);
+	if (err)
+		return err;
+
 	do_settimeofday(&tv);
 	return 0;
 }
@@ -142,10 +147,12 @@
 int do_sys_settimeofday(struct timespec *tv, struct timezone *tz)
 {
 	static int firsttime =3D 1;
+	int error =3D 0;
+
+	error =3D security_settime(tv, tz);
+	if (error)
+		return error;
=20
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
-	=09
 	if (tz) {
 		/* SMP safe, global irq locking makes it work. */
 		sys_tz =3D *tz;
--- linux-2.6.8-rc3/security/capability.c	2004-06-16 00:19:13.000000000 -05=
00
+++ linux-2.6.8-rc3_seclvl/security/capability.c	2004-08-09 08:03:30.000000=
000 -0500
@@ -30,6 +30,7 @@
 	.capset_check =3D			cap_capset_check,
 	.capset_set =3D			cap_capset_set,
 	.capable =3D			cap_capable,
+	.settime =3D			cap_settime,
 	.netlink_send =3D			cap_netlink_send,
 	.netlink_recv =3D			cap_netlink_recv,
=20
--- linux-2.6.8-rc3/security/commoncap.c	2004-06-16 00:19:13.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/security/commoncap.c	2004-08-09 08:06:57.0000000=
00 -0500
@@ -27,20 +27,25 @@
 int cap_capable (struct task_struct *tsk, int cap)
 {
 	/* Derived from include/linux/sched.h:capable. */
-	if (cap_raised (tsk->cap_effective, cap))
+	if (cap_raised(tsk->cap_effective, cap))
 		return 0;
-	else
+	return -EPERM;
+}
+
+int cap_settime(struct timespec *ts, struct timezone *tz)
+{
+	if (!capable(CAP_SYS_TIME))
 		return -EPERM;
+	return 0;
 }
=20
 int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
 	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
-	    !capable (CAP_SYS_PTRACE))
+	    !capable(CAP_SYS_PTRACE))
 		return -EPERM;
-	else
-		return 0;
+	return 0;
 }
=20
 int cap_capget (struct task_struct *target, kernel_cap_t *effective,
@@ -368,6 +373,7 @@
 }
=20
 EXPORT_SYMBOL(cap_capable);
+EXPORT_SYMBOL(cap_settime);
 EXPORT_SYMBOL(cap_ptrace);
 EXPORT_SYMBOL(cap_capget);
 EXPORT_SYMBOL(cap_capset_check);
--- linux-2.6.8-rc3/security/dummy.c	2004-08-09 16:16:09.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/security/dummy.c	2004-08-09 16:17:05.000000000 -=
0500
@@ -104,6 +104,13 @@
 	return 0;
 }
=20
+static int dummy_settime (struct timeval *tv, struct timezone *tz)
+{
+	if (!capable(CAP_SYS_TIME))
+		return -EPERM;
+	return 0;
+}
+
 /*
  * Check that a process has enough memory to allocate a new virtual
  * mapping. 0 means there is enough memory for the allocation to
@@ -897,6 +904,7 @@
 	set_to_dummy_if_null(ops, quota_on);
 	set_to_dummy_if_null(ops, sysctl);
 	set_to_dummy_if_null(ops, syslog);
+	set_to_dummy_if_null(ops, settime);
 	set_to_dummy_if_null(ops, vm_enough_memory);
 	set_to_dummy_if_null(ops, bprm_alloc_security);
 	set_to_dummy_if_null(ops, bprm_free_security);

--KsGdsel6WgEHnImy--

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGOZMLTz92j62YB0RAkk+AJ47E3KV+AQ6400DlgZBMxp/gZd9NwCff6oI
3EdllNDSg9L4+x5xXKbCs8A=
=kjka
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
