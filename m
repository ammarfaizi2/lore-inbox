Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbTISQYn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 12:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbTISQYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 12:24:43 -0400
Received: from mailhub4.dartmouth.edu ([129.170.17.94]:14977 "EHLO
	mailhub4.dartmouth.edu") by vger.kernel.org with ESMTP
	id S261616AbTISQYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 12:24:39 -0400
Date: Fri, 19 Sep 2003 12:24:22 -0400
From: Omen Wild <Omen.Wild@Dartmouth.EDU>
To: linux-kernel@vger.kernel.org
Subject: call_usermodehelper does not report exit status?
Message-ID: <20030919162422.GB2236@descolada.dartmouth.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
User-Agent: Mutt/1.5.4-2i
X-MailScanner: No virus detected by mailhub3.Dartmouth.EDU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aT9PWwzfKXlsBJM1
Content-Type: multipart/mixed; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As part of a LSM I am writing, I need to call a user-space program and
check its return status.  I found the call_usermodehelper function and
call it with the wait flag set, but I cannot get a non-zero return
status of the program to propagate into the kernel.  If I try to run a
non-existent program then call_usermodehelper returns -1, so at least
some errors propagate properly.  I have attached a trivial LSM test
program that hooks inode_rename, runs /bin/false and prints the return
status of call_usermodehelper. =20

This is with kernel 2.6.0-test5-mm3 compiled on an up to date Debian
unstable.

For simplicity I have also attached a patch to security/Makefile to
build this test LSM as a kernel module.

Before I break out UML or the kernel debugger, does anyone have any
ideas what I am doing wrong?

Thanks,
  Omen

--=20
There is much Obi-Wan did not tell you.

--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Makefile.patch"
Content-Transfer-Encoding: quoted-printable

--- Makefile.orig       2003-09-19 12:18:20.000000000 -0400
+++ Makefile    2003-09-19 12:14:11.000000000 -0400
@@ -18,3 +18,6 @@
=20
 obj-$(CONFIG_SECURITY_CAPABILITIES)    +=3D commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)                +=3D commoncap.o root_plug.o
+
+# Test modules
+obj-m +=3D test.o

--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test.c"

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/security.h>
#include <linux/stat.h>
#include <linux/skbuff.h>
#include <linux/netlink.h>
#include <linux/ctype.h>
#include <linux/file.h>
#include <linux/spinlock.h>

#include <linux/fs.h>
#include <net/tcp.h>
#include <linux/sched.h>
#include <linux/string.h>
#include <linux/vmalloc.h>
#include <linux/dcache.h>
#include <linux/list.h>
#include <linux/namespace.h>
#include <linux/writeback.h>
#include <linux/quotaops.h>

#if defined(CONFIG_SECURITY_enforcer_MODULE)
#define MY_NAME THIS_MODULE->name
#else
#define MY_NAME "Test"
#endif

static int test_inode_rename (struct inode *inode, int mask)
{
   int status;
   char *envp[] = {
	  "HOME=/",
	  "TERM=linux",
	  "PATH=/usr/sbin:/sbin:/bin:/usr/bin",
	  NULL };

   char *argv[] = {
	  "/bin/false",
	  NULL };

   printk(KERN_INFO "calling helper '%s'\n",
		  argv[0]);

   status = call_usermodehelper(argv[0], argv, envp, 1);

   printk(KERN_INFO "helper returned = %d\n", status);

   return 0;
}

static struct security_operations test_ops = {
   .inode_rename = test_inode_rename,
};

static int __init test_init (void)
{
   /* register ourselves with the security framework */
   if (register_security (&test_ops)) {
	  printk (KERN_INFO "Failure registering " MY_NAME " module with the kernel\n");
	  return -EINVAL;
   }

   printk (KERN_INFO MY_NAME " LSM initialized.\n");
   return 0;
}

static void __exit test_exit (void)
{
   if (unregister_security (&test_ops))
	  printk (KERN_INFO MY_NAME ": failure unregistering with the kernel.\n");
}


module_init (test_init);
module_exit (test_exit);

MODULE_AUTHOR("Omen Wild <Omen.Wild@Dartmouth.EDU>");
MODULE_DESCRIPTION("Test Module");
MODULE_LICENSE("GPL");

--i0/AhcQY5QxfSsSZ--

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ay226QDOrpNC/+sRAgiuAJ0UKrKKZll6aaeDSDcllcGFmcodOgCdHjrC
2KdCDIBQDVWhQSGkLB5ltAc=
=0s2i
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
