Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUF1UWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUF1UWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUF1UWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:22:42 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:10441 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S265198AbUF1UVm (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:21:42 -0400
Message-Id: <200406282021.i5SKLfZV017422@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH} 2.6.7 - Add new sysctl handler
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2071372823P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Jun 2004 16:21:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2071372823P
Content-Type: text/plain; charset=us-ascii

This patch adds a 'proc_dointvec_gated' sysctl handler.  Basic use:

1) Create 2 sysctls:

int foo = 1;
int foo_lock = 1;

sysctl_1 = {... , .proc_handler = &proc_dointvec_gated, .extra1 = &foo_lock };
sysctl_2 = { ..., .proc_handler = &proc_dointvec_gated, .extra1 = &foo_lock };

Now 'foo' can be manipulated as much as you want, but when foo_lock is set
to 0, you can't change either anymore.

Also useful for a 'BSD Securelevels'-style scheme, or even for a "sysctl can't
be changed right now because the referenced device/subsystem/whatever is currently
in an inconsistent state" (just specify a suitable lock variable for .extra1).

Patch originally made against 2.6.7-rc1-mm1, but applies to 2.6.7-mm2 as welll.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--- linux-2.6.7-rc3-mm1/include/linux/sysctl.h.vt	2004-06-10 00:36:13.000000000 -0400
+++ linux-2.6.7-rc3-mm1/include/linux/sysctl.h	2004-06-14 09:37:18.415128731 -0400
@@ -769,6 +769,8 @@ extern int proc_dointvec(ctl_table *, in
 			 void __user *, size_t *);
 extern int proc_dointvec_bset(ctl_table *, int, struct file *,
 			      void __user *, size_t *);
+extern int proc_dointvec_gated(ctl_table *, int, struct file *,
+			void __user *, size_t *);
 extern int proc_dointvec_minmax(ctl_table *, int, struct file *,
 				void __user *, size_t *);
 extern int proc_dointvec_jiffies(ctl_table *, int, struct file *,
--- linux-2.6.7-rc3-mm1/kernel/sysctl.c.vt	2004-06-10 00:44:40.000000000 -0400
+++ linux-2.6.7-rc3-mm1/kernel/sysctl.c	2004-06-14 11:15:18.244304729 -0400
@@ -16,6 +16,7 @@
  *  Wendling.
  * The list_for_each() macro wasn't appropriate for the sysctl loop.
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
+ * Added proc_dointvec_gated, 06/14/04, Valdis Kletnieks
  */
 
 #include <linux/config.h>
@@ -1689,6 +1690,37 @@ static int do_proc_dointvec_minmax_conv(
 }
 
 /**
+ * proc_dointvec_gated - read a vector of integers only if a specified flag
+ *		word is non-zero
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
+ * values from/to the user buffer, treated as an ASCII string.
+ *
+ * This is identical to proc_dointvec, except that we additionally
+ * check that the location pointed to by table->extra1 is non-zero
+ * (useful for creating a 'lockdown' sysctl that allows setting of
+ * the variable only until some specified condition is fulfilled).
+ *
+ * Returns 0 on success.
+ */
+int proc_dointvec_gated(ctl_table *table, int write, struct file *filp,
+		  void __user *buffer, size_t *lenp)
+{
+	int *flag = (int *) (table->extra1);
+	if (write && flag && !(*flag)) {
+		return -EPERM;
+	}
+	return do_proc_dointvec(table, write, filp, buffer, lenp,
+				do_proc_dointvec_conv, NULL);
+}
+
+
+/**
  * proc_dointvec_minmax - read a vector of integers with min/max values
  * @table: the sysctl table
  * @write: %TRUE if this is a write to the sysctl file



--==_Exmh_-2071372823P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA4H3VcC3lWbTT17ARAtAHAKC0vdr+VPJNepf2zqdCz3AxBPPldQCgviot
nFqvqieQpcnmctU91BOfAfQ=
=Ac3T
-----END PGP SIGNATURE-----

--==_Exmh_-2071372823P--
