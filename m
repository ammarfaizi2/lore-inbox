Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267596AbUHJRkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267596AbUHJRkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267534AbUHJQlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:41:03 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:49371 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267547AbUHJQYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:24:30 -0400
Date: Tue, 10 Aug 2004 10:15:55 -0500
From: Michael Halcrow <lkml@halcrow.us>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] BSD Secure Levels LSM (2/3)
Message-ID: <20040810151555.GB4993@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: multipart/mixed; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch modifies security/Kconfig and security/Makefile to support
the BSD Secure Levels LSM.  It also includes security/seclvl.c, which
is the module itself.

Mike
=2E___________________________________________________________________.
                         Michael A. Halcrow                         =20
       Security Software Engineer, IBM Linux Technology Center      =20
GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D
--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="seclvl_2.6.8-rc3.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.8-rc3/security/Kconfig	2004-06-16 00:19:42.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/security/Kconfig	2004-08-09 09:43:35.000000000 -=
0500
@@ -44,6 +44,17 @@
 	 =20
 	  If you are unsure how to answer this question, answer N.
=20
+config SECURITY_SECLVL
+	tristate "BSD Secure Levels"
+	depends on SECURITY
+	select CRYPTO_SHA1
+	help
+	  Implements BSD Secure Levels as an LSM.  See
+	  Documentation/seclvl.txt for instructions on how to use this
+	  module.
+
+	  If you are unsure how to answer this question, answer N.
+
 source security/selinux/Kconfig
=20
 endmenu
--- linux-2.6.8-rc3/security/Makefile	2004-06-16 00:19:43.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/security/Makefile	2004-08-09 08:03:37.000000000 =
-0500
@@ -15,3 +15,4 @@
 obj-$(CONFIG_SECURITY_SELINUX)		+=3D selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+=3D commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+=3D commoncap.o root_plug.o
+obj-$(CONFIG_SECURITY_SECLVL)		+=3D seclvl.o
--- linux-2.6.8-rc3/security/seclvl.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.8-rc3_seclvl/security/seclvl.c	2004-08-09 16:37:53.000000000 =
-0500
@@ -0,0 +1,751 @@
+/**
+ * BSD Secure Levels LSM
+ *
+ * Maintainers:
+ *	Michael A. Halcrow <mike@halcrow.us>
+ *	Serge Hallyn <hallyn@cs.wm.edu>
+ *
+ * Copyright (c) 2001 WireX Communications, Inc <chris@wirex.com>
+ * Copyright (c) 2001 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (c) 2002 International Business Machines <robb@austin.ibm.com=
>=20
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ */
+
+/**
+ * Potential future enhancements:
+ *  - Export a kill_seclvl function to the rest of the kernel to allow
+ *    other modules to disable or change the seclvl (i.e., rootplug
+ *    could reduce the seclvl).
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/security.h>
+#include <linux/netlink.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/mount.h>
+#include <linux/capability.h>
+#include <linux/time.h>
+#include <linux/proc_fs.h>
+#include <linux/kobject.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+#include <linux/gfp.h>
+#include <linux/sysfs.h>
+
+#define SHA1_DIGEST_SIZE 20
+
+/**
+ * Module parameter that defines the initial secure level.
+ *=20
+ * When built as a module, it defaults to seclvl 1, which is the
+ * behavior of BSD secure levels.  Note that this default behavior
+ * wrecks havoc on a machine when the seclvl module is compiled into
+ * the kernel.	In that case, we default to seclvl 0.
+ */
+#ifdef CONFIG_SECURITY_SECLVL_MODULE
+static int initlvl =3D 1;
+#else
+static int initlvl;
+#endif
+module_param(initlvl, int, 0);
+MODULE_PARM_DESC(initlvl, "Initial secure level (defaults to 1)");
+
+/* Module parameter that defines the verbosity level */
+static int verbosity;
+module_param(verbosity, int, 0);
+MODULE_PARM_DESC(verbosity, "Initial verbosity level (0 or 1; defaults to "
+		 "0, which is Quiet)");
+
+/**
+ * Optional password which can be passed in to bring seclvl to 0
+ * (i.e., for halt/reboot).  Defaults to NULL (the passwd attribute
+ * file will not be registered in sysfs).
+ *
+ * This gets converted to its SHA1 hash when stored.  It's probably
+ * not a good idea to use this parameter when loading seclvl from a
+ * script; use sha1_passwd instead.
+ */
+
+#define MAX_PASSWD_SIZE	32
+static char passwd[MAX_PASSWD_SIZE];
+module_param_string(passwd, passwd, sizeof(passwd), 0);
+MODULE_PARM_DESC(passwd,
+		 "Plaintext of password that sets seclvl=3D0 when written to "
+		 "(sysfs mount point)/seclvl/passwd\n");
+
+/**
+ * SHA1 hashed version of the optional password which can be passed in
+ * to bring seclvl to 0 (i.e., for halt/reboot).  Must be in
+ * hexadecimal format (40 characters).	Defaults to NULL (the passwd
+ * attribute file will not be registered in sysfs).
+ *
+ * Use the sha1sum utility to generate the SHA1 hash of a password:
+ *
+ * echo -n "secret" | sha1sum
+ */
+#define MAX_SHA1_PASSWD	41
+static char sha1_passwd[MAX_SHA1_PASSWD];
+module_param_string(sha1_passwd, sha1_passwd, sizeof(sha1_passwd), 0);
+MODULE_PARM_DESC(sha1_passwd,
+		 "SHA1 hash (40 hexadecimal characters) of password that "
+		 "sets seclvl=3D0 when plaintext password is written to "
+		 "(sysfs mount point)/seclvl/passwd\n");
+
+static int hideHash =3D 1;
+module_param(hideHash, int, 0);
+MODULE_PARM_DESC(hideHash, "When set to 0, reading seclvl/passwd from sysf=
s "
+		 "will return the SHA1-hashed value of the password that "
+		 "lowers the secure level to 0.\n");
+
+#define MY_NAME "seclvl"
+
+/**
+ * This time-limits log writes to one per second.
+ */
+#define seclvl_printk(verb, type, fmt, arg...)			\
+	do {							\
+		if (verbosity >=3D verb) {			\
+			static unsigned long _prior;		\
+			unsigned long _now =3D jiffies;		\
+			if ((_now - _prior) > HZ) {		\
+				printk(type "%s: %s: " fmt,	\
+					MY_NAME, __FUNCTION__,	\
+					## arg);		\
+				_prior =3D _now;			\
+			}					\
+		}						\
+	} while (0)
+
+/**
+ * kobject stuff
+ */
+
+struct subsystem seclvl_subsys;
+
+struct seclvl_obj {
+	char *name;
+	struct list_head slot_list;
+	struct kobject kobj;
+};
+
+/**
+ * There is a seclvl_attribute struct for each file in sysfs.
+ *
+ * In our case, we have one of these structs for "passwd" and another
+ * for "seclvl".
+ */
+struct seclvl_attribute {
+	struct attribute attr;
+	ssize_t(*show) (struct seclvl_obj *, char *);
+	ssize_t(*store) (struct seclvl_obj *, const char *, size_t);
+};
+
+/**
+ * When this function is called, one of the files in sysfs is being
+ * written to.  attribute->store is a function pointer to whatever the
+ * struct seclvl_attribute store function pointer points to.  It is
+ * unique for "passwd" and "seclvl".
+ */
+static ssize_t
+seclvl_attr_store(struct kobject *kobj,
+		  struct attribute *attr, const char *buf, size_t len)
+{
+	struct seclvl_obj *obj =3D container_of(kobj, struct seclvl_obj, kobj);
+	struct seclvl_attribute *attribute =3D
+	    container_of(attr, struct seclvl_attribute, attr);
+	return (attribute->store ? attribute->store(obj, buf, len) : 0);
+}
+
+static ssize_t
+seclvl_attr_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct seclvl_obj *obj =3D container_of(kobj, struct seclvl_obj, kobj);
+	struct seclvl_attribute *attribute =3D
+	    container_of(attr, struct seclvl_attribute, attr);
+	return (attribute->show ? attribute->show(obj, buf) : 0);
+}
+
+/**
+ * Callback function pointers for show and store
+ */
+struct sysfs_ops seclvlfs_sysfs_ops =3D {
+	.show =3D seclvl_attr_show,
+	.store =3D seclvl_attr_store,
+};
+
+static struct kobj_type seclvl_ktype =3D {
+	.sysfs_ops =3D &seclvlfs_sysfs_ops
+};
+
+decl_subsys(seclvl, &seclvl_ktype, NULL);
+
+/**
+ * The actual security level.  Ranges between -1 and 2 inclusive.
+ */
+static int seclvl;
+
+/**
+ * flag to keep track of how we were registered
+ */
+static int secondary;
+
+/**
+ * Verifies that the requested secure level is valid, given the current
+ * secure level.
+ */
+static int seclvl_sanity(int reqlvl)
+{
+	if ((reqlvl < -1) || (reqlvl > 2)) {
+		seclvl_printk(1, KERN_WARNING, "Attempt to set seclvl out of "
+			      "range: [%d]\n", reqlvl);
+		return -EINVAL;
+	}
+	if ((seclvl =3D=3D 0) && (reqlvl =3D=3D -1))
+		return 0;
+	if (reqlvl < seclvl) {
+		seclvl_printk(1, KERN_WARNING, "Attempt to lower seclvl to "
+			      "[%d]\n", reqlvl);
+		return -EPERM;
+	}
+	return 0;
+}
+
+/**
+ * Called whenever the user reads the sysfs handle to this kernel
+ * object
+ */
+static ssize_t seclvl_read_file(struct seclvl_obj *obj, char *buff)
+{
+	return snprintf(buff, PAGE_SIZE, "%d\n", seclvl);
+}
+
+/**
+ * security level advancement rules:
+ *   Valid levels are -1 through 2, inclusive.
+ *   From -1, stuck.  [ in case compiled into kernel ]
+ *   From 0 or above, can only increment.
+ */
+static int do_seclvl_advance(int newlvl)
+{
+	if (newlvl <=3D seclvl) {
+		seclvl_printk(1, KERN_WARNING, "Cannot advance to seclvl "
+			      "[%d]\n", newlvl);
+		return -EINVAL;
+	}
+	if (newlvl > 2) {
+		seclvl_printk(1, KERN_WARNING, "Cannot advance to seclvl "
+			      "[%d]\n", newlvl);
+		return -EINVAL;
+	}
+	if (seclvl =3D=3D -1) {
+		seclvl_printk(1, KERN_WARNING, "Not allowed to advance to "
+			      "seclvl [%d]\n", seclvl);
+		return -EPERM;
+	}
+	seclvl =3D newlvl;
+	return 0;
+}
+
+/**
+ * Called whenever the user writes to the sysfs handle to this kernel
+ * object (seclvl/seclvl).  It expects a single-digit number.
+ */
+static ssize_t
+seclvl_write_file(struct seclvl_obj *obj, const char *buff, size_t count)
+{
+	unsigned long val;
+	if (count > 2 || (count =3D=3D 2 && buff[1] !=3D '\n')) {
+		seclvl_printk(1, KERN_WARNING, "Invalid value passed to "
+			      "seclvl: [%s]\n", buff);
+		return -EINVAL;
+	}
+	val =3D buff[0] - 48;
+	if (seclvl_sanity(val)) {
+		seclvl_printk(1, KERN_WARNING, "Illegal secure level "
+			      "requested: [%d]\n", (int)val);
+		return -EPERM;
+	}
+	if (do_seclvl_advance(val)) {
+		seclvl_printk(0, KERN_ERR, "Failure advancing security level "
+			      "to %lu\n", val);
+	}
+	return count;
+}
+
+/* Generate sysfs_attr_seclvl */
+struct seclvl_attribute sysfs_attr_seclvl =3D
+__ATTR(seclvl, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_file,
+       seclvl_write_file);
+
+static unsigned char hashedPassword[SHA1_DIGEST_SIZE];
+
+/**
+ * Called whenever the user reads the sysfs passwd handle.
+ */
+static ssize_t seclvl_read_passwd(struct seclvl_obj *obj, char *buff)
+{
+	/* So just how good *is* your password? :-) */
+	char tmp[3];
+	int i =3D 0;
+	buff[0] =3D '\0';
+	if (hideHash) {
+		/* Security through obscurity */
+		return 0;
+	}
+	while (i < SHA1_DIGEST_SIZE) {
+		snprintf(tmp, 3, "%02x", hashedPassword[i]);
+		strncat(buff, tmp, 2);
+		i++;
+	}
+	strcat(buff, "\n");
+	return ((SHA1_DIGEST_SIZE * 2) + 1);
+}
+
+/**
+ * Converts a block of plaintext of into its SHA1 hashed value.
+ *
+ * It would be nice if crypto had a wrapper to do this for us linear
+ * people...
+ */
+static int
+plaintext_to_sha1(unsigned char *hash, const char *plaintext, int len)
+{
+	char *pgVirtAddr;
+	struct crypto_tfm *tfm;
+	struct scatterlist sg[1];
+	if (len > PAGE_SIZE) {
+		seclvl_printk(0, KERN_ERR, "Plaintext password too large (%d "
+			      "characters).  Largest possible is %lu "
+			      "bytes.\n", len, PAGE_SIZE);
+		return -ENOMEM;
+	}
+	tfm =3D crypto_alloc_tfm("sha1", 0);
+	if (tfm =3D=3D NULL) {
+		seclvl_printk(0, KERN_ERR,
+			      "Failed to load transform for SHA1\n");
+		return -ENOSYS;
+	}
+	// Just get a new page; don't play around with page boundaries
+	// and scatterlists.
+	pgVirtAddr =3D (char *)__get_free_page(GFP_KERNEL);
+	sg[0].page =3D virt_to_page(pgVirtAddr);
+	sg[0].offset =3D 0;
+	sg[0].length =3D len;
+	strncpy(pgVirtAddr, plaintext, len);
+	crypto_digest_init(tfm);
+	crypto_digest_update(tfm, sg, 1);
+	crypto_digest_final(tfm, hash);
+	crypto_free_tfm(tfm);
+	free_page((unsigned long)pgVirtAddr);
+	return 0;
+}
+
+/**
+ * Called whenever the user writes to the sysfs passwd handle to this kern=
el
+ * object.  It hashes the password and compares the hashed results.
+ */
+static ssize_t
+seclvl_write_passwd(struct seclvl_obj *obj, const char *buff, size_t count)
+{
+	int i;
+	unsigned char tmp[SHA1_DIGEST_SIZE];
+	int rc;
+	int len;
+	if (!*passwd && !*sha1_passwd) {
+		seclvl_printk(0, KERN_ERR, "Attempt to password-unlock the "
+			      "seclvl module, but neither a plain text "
+			      "password nor a SHA1 hashed password was "
+			      "passed in as a module parameter!  This is a "
+			      "bug, since it should not be possible to be in "
+			      "this part of the module; please tell a "
+			      "maintainer about this event.\n");
+		return -EINVAL;
+	}
+	len =3D strlen(buff);
+	/* ``echo "secret" > seclvl/passwd'' includes a newline */
+	if (buff[len - 1] =3D=3D '\n') {
+		len--;
+	}
+	/* Hash the password, then compare the hashed values */
+	if ((rc =3D plaintext_to_sha1(tmp, buff, len))) {
+		seclvl_printk(0, KERN_ERR, "Error hashing password: rc =3D "
+			      "[%d]\n", rc);
+		return rc;
+	}
+	for (i =3D 0; i < SHA1_DIGEST_SIZE; i++) {
+		if (hashedPassword[i] !=3D tmp[i]) {
+			return -EPERM;
+		}
+	}
+	seclvl_printk(0, KERN_INFO,
+		      "Password accepted; seclvl reduced to 0.\n");
+	seclvl =3D 0;
+	return count;
+}
+
+/* Generate sysfs_attr_passwd */
+struct seclvl_attribute sysfs_attr_passwd =3D
+__ATTR(passwd, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_passwd,
+       seclvl_write_passwd);
+
+/**
+ * Explicitely disallow ptrace'ing the init process.
+ */
+static int seclvl_ptrace(struct task_struct *parent, struct task_struct *c=
hild)
+{
+	if (seclvl >=3D 0) {
+		if (child->pid =3D=3D 1) {
+			seclvl_printk(1, KERN_WARNING, "Attempt to ptrace "
+				      "the init process dissallowed in "
+				      "secure level %d\n", seclvl);
+			return -EPERM;
+		}
+	}
+	return 0;
+}
+
+/**
+ * Capability checks for seclvl.  The majority of the policy
+ * enforcement for seclvl takes place here.
+ */
+static int seclvl_capable(struct task_struct *tsk, int cap)
+{
+	/* init can do anything it wants */
+	if (tsk->pid =3D=3D 1)
+		return 0;
+
+	switch (seclvl) {
+	case 2:
+		/* fall through */
+	case 1:
+		if (cap =3D=3D CAP_LINUX_IMMUTABLE) {
+			seclvl_printk(1, KERN_WARNING, "Attempt to modify "
+				      "the IMMUTABLE and/or APPEND extended "
+				      "attribute on a file with the IMMUTABLE "
+				      "and/or APPEND extended attribute set "
+				      "denied in seclvl [%d]\n", seclvl);
+			return -EPERM;
+		} else if (cap =3D=3D CAP_SYS_RAWIO) {	// Somewhat broad...
+			seclvl_printk(1, KERN_WARNING, "Attempt to perform "
+				      "raw I/O while in secure level [%d] "
+				      "denied\n", seclvl);
+			return -EPERM;
+		} else if (cap =3D=3D CAP_NET_ADMIN) {
+			seclvl_printk(1, KERN_WARNING, "Attempt to perform "
+				      "network administrative task while "
+				      "in secure level [%d] denied\n", seclvl);
+			return -EPERM;
+		} else if (cap =3D=3D CAP_SETUID) {
+			seclvl_printk(1, KERN_WARNING, "Attempt to setuid "
+				      "while in secure level [%d] denied\n",
+				      seclvl);
+			return -EPERM;
+		} else if (cap =3D=3D CAP_SETGID) {
+			seclvl_printk(1, KERN_WARNING, "Attempt to setgid "
+				      "while in secure level [%d] denied\n",
+				      seclvl);
+		} else if (cap =3D=3D CAP_SYS_MODULE) {
+			seclvl_printk(1, KERN_WARNING, "Attempt to perform "
+				      "a module operation while in secure "
+				      "level [%d] denied\n", seclvl);
+			return -EPERM;
+		}
+		break;
+	default:
+		break;
+	}
+	/* from dummy.c */
+	if (cap_is_fs_cap(cap) ? tsk->fsuid =3D=3D 0 : tsk->euid =3D=3D 0)
+		return 0;	/* capability granted */
+	seclvl_printk(1, KERN_WARNING, "Capability denied\n");
+	return -EPERM;		/* capability denied */
+}
+
+/**
+ * Disallow reversing the clock in seclvl > 1
+ */
+static int seclvl_settime(struct timespec *tv, struct timezone *tz)
+{
+	struct timespec now;
+	if (seclvl > 1) {
+		now =3D current_kernel_time();
+		if (tv->tv_sec < now.tv_sec ||
+		    (tv->tv_sec =3D=3D now.tv_sec && tv->tv_nsec < now.tv_nsec)) {
+			seclvl_printk(1, KERN_WARNING, "Attempt to decrement "
+				      "time in secure level %d denied: "
+				      "current->pid =3D [%d], "
+				      "current->group_leader->pid =3D [%d]\n",
+				      seclvl, current->pid,
+				      current->group_leader->pid);
+			return -EPERM;
+		}		/* if attempt to decrement time */
+	}			/* if seclvl > 1 */
+	return 0;
+}
+
+/* claim the blockdev to exclude mounters, release on file close */
+static int seclvl_bd_claim(struct inode *inode)
+{
+	int holder;
+	struct block_device *bdev =3D NULL;
+	dev_t dev =3D inode->i_rdev;
+	bdev =3D open_by_devnum(dev, FMODE_WRITE);
+	if (bdev) {
+		if (bd_claim(bdev, &holder)) {
+			blkdev_put(bdev);
+			return -EPERM;
+		}
+		/* claimed, mark it to release on close */
+		inode->i_security =3D current;
+	}
+	return 0;
+}
+
+/* release the blockdev if you claimed it */
+static void seclvl_bd_release(struct inode *inode)
+{
+	if (inode && S_ISBLK(inode->i_mode) && inode->i_security =3D=3D current) {
+		struct block_device *bdev =3D inode->i_bdev;
+		if (bdev) {
+			bd_release(bdev);
+			blkdev_put(bdev);
+			inode->i_security =3D NULL;
+		}
+	}
+}
+
+/**
+ * Security for writes to block devices is regulated by this seclvl
+ * function.  Deny all writes to block devices in seclvl 2.  In
+ * seclvl 1, we only deny writes to *mounted* block devices.
+ */
+static int
+seclvl_inode_permission(struct inode *inode, int mask, struct nameidata *n=
d)
+{
+	if (current->pid !=3D 1 && S_ISBLK(inode->i_mode) && (mask & MAY_WRITE)) {
+		switch (seclvl) {
+		case 2:
+			seclvl_printk(1, KERN_WARNING, "Write to block device "
+				      "denied in secure level [%d]\n", seclvl);
+			return -EPERM;
+		case 1:
+			if (seclvl_bd_claim(inode)) {
+				seclvl_printk(1, KERN_WARNING,
+					      "Write to mounted block device "
+					      "denied in secure level [%d]\n",
+					      seclvl);
+				return -EPERM;
+			}
+		}
+	}
+	return 0;
+}
+
+/**
+ * The SUID and SGID bits cannot be set in seclvl >=3D 1
+ */
+static int seclvl_inode_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+	if (seclvl > 0) {
+		if (iattr->ia_valid & ATTR_MODE)
+			if (iattr->ia_mode & S_ISUID ||
+			    iattr->ia_mode & S_ISGID) {
+				seclvl_printk(1, KERN_WARNING, "Attempt to "
+					      "modify SUID or SGID bit "
+					      "denied in seclvl [%d]\n",
+					      seclvl);
+				return -EPERM;
+			}
+	}
+	return 0;
+}
+
+/* release busied block devices */
+static void seclvl_file_free_security(struct file *filp)
+{
+	struct dentry *dentry =3D filp->f_dentry;
+	struct inode *inode =3D NULL;
+=09
+	if (dentry) {
+		inode =3D dentry->d_inode;
+		seclvl_bd_release(inode);
+	}
+}
+
+/**
+ * Cannot unmount in secure level 2
+ */
+static int seclvl_umount(struct vfsmount *mnt, int flags)
+{
+	if (current->pid =3D=3D 1) {
+		return 0;
+	}
+	if (seclvl =3D=3D 2) {
+		seclvl_printk(1, KERN_WARNING, "Attempt to unmount in secure "
+			      "level %d\n", seclvl);
+		return -EPERM;
+	}
+	return 0;
+}
+
+static struct security_operations seclvl_ops =3D {
+	.ptrace =3D seclvl_ptrace,
+	.capable =3D seclvl_capable,
+	.inode_permission =3D seclvl_inode_permission,
+	.inode_setattr =3D seclvl_inode_setattr,
+	.file_free_security =3D seclvl_file_free_security,
+	.settime =3D seclvl_settime,
+	.sb_umount =3D seclvl_umount,
+};
+
+/**
+ * Process the password-related module parameters
+ */
+static int processPassword(void)
+{
+	int rc =3D 0;
+	hashedPassword[0] =3D '\0';
+	if (*passwd) {
+		if (*sha1_passwd) {
+			seclvl_printk(0, KERN_ERR, "Error: Both "
+				      "passwd and sha1_passwd "
+				      "were set, but they are mutually "
+				      "exclusive.\n");
+			return -EINVAL;
+		}
+		if ((rc =3D plaintext_to_sha1(hashedPassword, passwd,
+					    strlen(passwd)))) {
+			seclvl_printk(0, KERN_ERR, "Error: SHA1 support not "
+				      "in kernel\n");
+			return rc;
+		}
+		/* All static data goes to the BSS, which zero's the
+		 * plaintext password out for us. */
+	} else if (*sha1_passwd) {	// Base 16
+		int i;
+		i =3D strlen(sha1_passwd);
+		if (i !=3D (SHA1_DIGEST_SIZE * 2)) {
+			seclvl_printk(0, KERN_ERR, "Received [%d] bytes; "
+				      "expected [%d] for the hexadecimal "
+				      "representation of the SHA1 hash of "
+				      "the password.\n",
+				      i, (SHA1_DIGEST_SIZE * 2));
+			return -EINVAL;
+		}
+		while ((i -=3D 2) + 2) {
+			unsigned char tmp;
+			tmp =3D sha1_passwd[i + 2];
+			sha1_passwd[i + 2] =3D '\0';
+			hashedPassword[i / 2] =3D (unsigned char)
+			    simple_strtol(&sha1_passwd[i], NULL, 16);
+			sha1_passwd[i + 2] =3D tmp;
+		}
+	}
+	return 0;
+}
+
+/**
+ * Sysfs registrations
+ */
+static int doSysfsRegistrations(void)
+{
+	int rc =3D 0;
+	if ((rc =3D subsystem_register(&seclvl_subsys))) {
+		seclvl_printk(0, KERN_WARNING,
+			      "Error [%d] registering seclvl subsystem\n", rc);
+		return rc;
+	}
+	sysfs_create_file(&seclvl_subsys.kset.kobj, &sysfs_attr_seclvl.attr);
+	if (*passwd || *sha1_passwd) {
+		sysfs_create_file(&seclvl_subsys.kset.kobj,
+				  &sysfs_attr_passwd.attr);
+	}
+	return 0;
+}
+
+/**
+ * Initialize the seclvl module.
+ */
+static int __init seclvl_init(void)
+{
+	int rc =3D 0;
+	if (verbosity < 0 || verbosity > 1) {
+		printk(KERN_ERR "Error: bad verbosity [%d]; only 0 or 1 "
+		       "are valid values\n", verbosity);
+		rc =3D -EINVAL;
+		goto exit;
+	}
+	sysfs_attr_seclvl.attr.owner =3D THIS_MODULE;
+	sysfs_attr_passwd.attr.owner =3D THIS_MODULE;
+	if (initlvl < -1 || initlvl > 2) {
+		seclvl_printk(0, KERN_ERR, "Error: bad initial securelevel "
+			      "[%d].\n", initlvl);
+		rc =3D -EINVAL;
+		goto exit;
+	}
+	seclvl =3D initlvl;
+	if ((rc =3D processPassword())) {
+		seclvl_printk(0, KERN_ERR, "Error processing the password "
+			      "module parameter(s): rc =3D [%d]\n", rc);
+		goto exit;
+	}
+	/* register ourselves with the security framework */
+	if (register_security(&seclvl_ops)) {
+		seclvl_printk(0, KERN_ERR,
+			      "seclvl: Failure registering with the "
+			      "kernel.\n");
+		/* try registering with primary module */
+		if (mod_reg_security(MY_NAME, &seclvl_ops)) {
+			seclvl_printk(0, KERN_ERR, "seclvl: Failure "
+				      "registering with primary security "
+				      "module.\n");
+			goto exit;
+		}		/* if primary module registered */
+		secondary =3D 1;
+	}			/* if we registered ourselves with the security framework */
+	if ((rc =3D doSysfsRegistrations())) {
+		seclvl_printk(0, KERN_ERR, "Error registering with sysfs\n");
+		goto exit;
+	}
+	seclvl_printk(0, KERN_INFO, "seclvl: Successfully initialized.\n");
+ exit:
+	if (rc) {
+		printk(KERN_ERR "seclvl: Error during initialization: rc =3D "
+		       "[%d]\n", rc);
+	}
+	return rc;
+}
+
+/**
+ * Remove the seclvl module.
+ */
+static void __exit seclvl_exit(void)
+{
+	sysfs_remove_file(&seclvl_subsys.kset.kobj, &sysfs_attr_seclvl.attr);
+	if (*passwd || *sha1_passwd) {
+		sysfs_remove_file(&seclvl_subsys.kset.kobj,
+				  &sysfs_attr_passwd.attr);
+	}
+	subsystem_unregister(&seclvl_subsys);
+	if (unregister_security(&seclvl_ops)) {
+		seclvl_printk(0, KERN_INFO,
+			      "seclvl: Failure unregistering with the "
+			      "kernel\n");
+	}
+}
+
+module_init(seclvl_init);
+module_exit(seclvl_exit);
+
+MODULE_AUTHOR("Michael A. Halcrow <mike@halcrow.us>");
+MODULE_DESCRIPTION("LSM implementation of the BSD Secure Levels");
+MODULE_LICENSE("GPL");

--XMCwj5IQnwKtuyBG--

--3Pql8miugIZX0722
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGOarLTz92j62YB0RArYzAKDQEHzVkuaj9q626M26SbkEuwWGdACfQx1s
7cQph4sRFjO/+biru6TKW6c=
=8yFW
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
