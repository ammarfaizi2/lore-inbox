Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314709AbSEKVEW>; Sat, 11 May 2002 17:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314743AbSEKVEV>; Sat, 11 May 2002 17:04:21 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:40203 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S314709AbSEKVES>;
	Sat, 11 May 2002 17:04:18 -0400
Date: Sat, 11 May 2002 23:04:15 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Update for Alpha SRM driver
Message-ID: <20020511210414.GE18457@lug-owl.de>
Mail-Followup-To: torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus!

Please accept this patch to current 2.5.x. It has already been included
by Marcello into 2.4.x and updates my driver to its current version.

Please apply!

MfG, JBG



--- linux/arch/alpha/kernel/srm_env.c.orig	Fri May 10 00:22:06 2002
+++ linux/arch/alpha/kernel/srm_env.c	Sat May 11 22:54:54 2002
@@ -1,27 +1,20 @@
 /*
- * srm_env.c - Access to SRC environment variables through
- *             the linux procfs
+ * srm_env.c - Access to SRC environment
+ *             variables through linux' procfs
  *
- * (C)2001, Jan-Benedict Glaw <jbglaw@lug-owl.de>
+ * Copyright (C) 2001-2002 Jan-Benedict Glaw <jbglaw@lug-owl.de>
  *
  * This driver is at all a modified version of Erik Mouw's
- * ./linux/Documentation/DocBook/procfs_example.c, so: thanky
+ * ./linux/Documentation/DocBook/procfs_example.c, so: thank
  * you, Erik! He can be reached via email at
  * <J.A.K.Mouw@its.tudelft.nl>. It is based on an idea
- * provided by DEC^WCompaq's "Jumpstart" CD. They included
- * a patch like this as well. Thanks for idea!
- *
- *
- * This software has been developed while working on the LART
- * computing board (http://www.lart.tudelft.nl/). The
- * development has been sponsored by the Mobile Multi-media
- * Communications (http://www.mmc.tudelft.nl/) and Ubiquitous
- * Communications (http://www.ubicom.tudelft.nl/) projects.
+ * provided by DEC^WCompaq^WIntel's "Jumpstart" CD. They
+ * included a patch like this as well. Thanks for idea!
  *
  * This program is free software; you can redistribute
  * it and/or modify it under the terms of the GNU General
- * Public License as published by the Free Software
- * Foundation version 2.
+ * Public License version 2 as published by the Free Software
+ * Foundation.
  *
  * This program is distributed in the hope that it will be
  * useful, but WITHOUT ANY WARRANTY; without even the implied
@@ -36,6 +29,19 @@
  *
  */
=20
+/*
+ * Changelog
+ *
+ * Tue,  9 Apr 2002 18:44:40 +0200
+ * 	- Implement access by variable name and additionally
+ * 	  by number. This is done by creating two subdirectories
+ * 	  where one holds all names (like the old directory
+ * 	  did) and the other holding 256 files named like "0",
+ * 	  "1" and so on.
+ * 	- Call this "Version 0.0.3"
+ *
+ */
+
 #include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/module.h>
@@ -45,10 +51,11 @@
 #include <asm/uaccess.h>
 #include <asm/machvec.h>
=20
-#define DIRNAME		"srm_environment"	/* Subdir in /proc/	*/
-#define VERSION		"0.0.2"			/* Module version	*/
-#define NAME		"srm_env"		/* Module name		*/
-#define DEBUG
+#define BASE_DIR	"srm_environment"	/* Subdir in /proc/		*/
+#define NAMED_DIR	"named_variables"	/* Subdir for known variables	*/
+#define NUMBERED_DIR	"numbered_variables"	/* Subdir for all variables	*/
+#define VERSION		"0.0.3"			/* Module version		*/
+#define NAME		"srm_env"		/* Module name			*/
=20
 MODULE_AUTHOR("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
 MODULE_DESCRIPTION("Accessing Alpha SRM environment through procfs interfa=
ce");
@@ -61,8 +68,12 @@
 	struct proc_dir_entry	*proc_entry;
 } srm_env_t;
=20
-static struct proc_dir_entry	*directory;
-static srm_env_t	srm_entries[] =3D {
+static struct proc_dir_entry	*base_dir;
+static struct proc_dir_entry	*named_dir;
+static struct proc_dir_entry	*numbered_dir;
+static char			number[256][4];
+
+static srm_env_t	srm_named_entries[] =3D {
 	{ "auto_action",	ENV_AUTO_ACTION		},
 	{ "boot_dev",		ENV_BOOT_DEV		},
 	{ "bootdef_dev",	ENV_BOOTDEF_DEV		},
@@ -80,10 +91,11 @@
 	{ "tty_dev",		ENV_TTY_DEV		},
 	{ NULL,			0			},
 };
+static srm_env_t	srm_numbered_entries[256];
=20
-static int srm_env_read(char *page, char **start, off_t off, int count,
-		int *eof, void *data)
-{
+static int
+srm_env_read(char *page, char **start, off_t off, int count, int *eof,
+		void *data) {
 	int		nbytes;
 	unsigned long	ret;
 	srm_env_t	*entry;
@@ -108,10 +120,9 @@
 	return nbytes;
 }
=20
-
-static int srm_env_write(struct file *file, const char *buffer,
-		unsigned long count, void *data)
-{
+static int
+srm_env_write(struct file *file, const char *buffer, unsigned long count,
+		void *data) {
 #define BUFLEN	512
 	int		nbytes;
 	srm_env_t	*entry;
@@ -127,8 +138,8 @@
 		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
-	=09
-	//memcpy(aligned_buffer, buffer, nbytes)
+
+	/* memcpy(aligned_buffer, buffer, nbytes) */
=20
 	if(copy_from_user(buf, buffer, count)) {
 		MOD_DEC_USE_COUNT;
@@ -150,55 +161,142 @@
 	return nbytes;
 }
=20
-static void srm_env_cleanup(void)
-{
+static void
+srm_env_cleanup(void) {
 	srm_env_t	*entry;
+	unsigned long	var_num;
=20
-	if(directory) {
-		entry =3D srm_entries;
-		while(entry->name !=3D NULL && entry->id !=3D 0) {
-			if(entry->proc_entry) {
-				remove_proc_entry(entry->name, directory);
-				entry->proc_entry =3D NULL;
+	if(base_dir) {
+		/*
+		 * Remove named entries
+		 */
+		if(named_dir) {
+			entry =3D srm_named_entries;
+			while(entry->name !=3D NULL && entry->id !=3D 0) {
+				if(entry->proc_entry) {
+					remove_proc_entry(entry->name,
+							named_dir);
+					entry->proc_entry =3D NULL;
+				}
+				entry++;
 			}
-			entry++;
+			remove_proc_entry(NAMED_DIR, base_dir);
 		}
-		remove_proc_entry(DIRNAME, NULL);
+
+		/*
+		 * Remove numbered entries
+		 */
+		if(numbered_dir) {
+			for(var_num =3D 0; var_num <=3D 255; var_num++) {
+				entry =3D	&srm_numbered_entries[var_num];
+
+				if(entry->proc_entry) {
+					remove_proc_entry(entry->name,
+							numbered_dir);
+					entry->proc_entry	=3D NULL;
+					entry->name		=3D NULL;
+				}
+			}
+			remove_proc_entry(NUMBERED_DIR, base_dir);
+		}
+
+		remove_proc_entry(BASE_DIR, NULL);
 	}
=20
 	return;
 }
=20
-static int __init srm_env_init(void)
-{
+static int __init
+srm_env_init(void) {
 	srm_env_t	*entry;
-=09
+	unsigned long	var_num;
+
+	/*
+	 * Check system
+	 */
 	if(!alpha_using_srm) {
 		printk(KERN_INFO "%s: This Alpha system doesn't "
 				"know about SRM...\n", __FUNCTION__);
 		return -ENODEV;
 	}
=20
-	directory =3D proc_mkdir(DIRNAME, NULL);
-	if(directory =3D=3D NULL)
-		return -ENOMEM;
-=09
-	directory->owner =3D THIS_MODULE;
-=09
-	/* Now create all the nodes... */
-	entry =3D srm_entries;
+	/*
+	 * Init numbers
+	 */
+	for(var_num =3D 0; var_num <=3D 255; var_num++)
+		sprintf(number[var_num], "%ld", var_num);
+
+	/*
+	 * Create base directory
+	 */
+	base_dir =3D proc_mkdir(BASE_DIR, NULL);
+	if(base_dir =3D=3D NULL) {
+		printk(KERN_ERR "Couldn't create base dir /proc/%s\n",
+				BASE_DIR);
+		goto cleanup;
+	}
+	base_dir->owner =3D THIS_MODULE;
+
+	/*
+	 * Create per-name subdirectory
+	 */
+	named_dir =3D proc_mkdir(NAMED_DIR, base_dir);
+	if(named_dir =3D=3D NULL) {
+		printk(KERN_ERR "Couldn't create dir /proc/%s/%s\n",
+				BASE_DIR, NAMED_DIR);
+		goto cleanup;
+	}
+	named_dir->owner =3D THIS_MODULE;
+
+	/*
+	 * Create per-number subdirectory
+	 */
+	numbered_dir =3D proc_mkdir(NUMBERED_DIR, base_dir);
+	if(numbered_dir =3D=3D NULL) {
+		printk(KERN_ERR "Couldn't create dir /proc/%s/%s\n",
+				BASE_DIR, NUMBERED_DIR);
+		goto cleanup;
+
+	}
+	numbered_dir->owner =3D THIS_MODULE;
+
+	/*
+	 * Create all named nodes
+	 */
+	entry =3D srm_named_entries;
 	while(entry->name !=3D NULL && entry->id !=3D 0) {
-		entry->proc_entry =3D create_proc_entry(entry->name, 0644,
-				directory);
+		entry->proc_entry =3D create_proc_entry(entry->name,
+				0644, named_dir);
 		if(entry->proc_entry =3D=3D NULL)
 			goto cleanup;
-		entry->proc_entry->data		=3D entry;
+
+		entry->proc_entry->data		=3D (void *)entry;
+		entry->proc_entry->owner	=3D THIS_MODULE;
 		entry->proc_entry->read_proc	=3D srm_env_read;
 		entry->proc_entry->write_proc	=3D srm_env_write;
-		entry->proc_entry->owner	=3D THIS_MODULE;
+
 		entry++;
 	}
-=09
+
+	/*
+	 * Create all numbered nodes
+	 */
+	for(var_num =3D 0; var_num <=3D 255; var_num++) {
+		entry =3D &srm_numbered_entries[var_num];
+		entry->name =3D number[var_num];
+
+		entry->proc_entry =3D create_proc_entry(entry->name,
+				0644, numbered_dir);
+		if(entry->proc_entry =3D=3D NULL)
+			goto cleanup;
+
+		entry->id			=3D var_num;
+		entry->proc_entry->data		=3D (void *)entry;
+		entry->proc_entry->owner	=3D THIS_MODULE;
+		entry->proc_entry->read_proc	=3D srm_env_read;
+		entry->proc_entry->write_proc	=3D srm_env_write;
+	}
+
 	printk(KERN_INFO "%s: version %s loaded successfully\n", NAME,
 			VERSION);
 	return 0;
@@ -208,9 +306,8 @@
 	return -ENOMEM;
 }
=20
-
-static void __exit srm_env_exit(void)
-{
+static void __exit
+srm_env_exit(void) {
 	srm_env_cleanup();
 	printk(KERN_INFO "%s: unloaded successfully\n", NAME);
 	return;


--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjzdh04ACgkQHb1edYOZ4bugaACffXPI8NjJ1TrYMfDeBLK3bai/
AGYAnRB40eM9BRXSyrcjPnCrXYuDdhuP
=pmh4
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
