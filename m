Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbSJHSLe>; Tue, 8 Oct 2002 14:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbSJHSLe>; Tue, 8 Oct 2002 14:11:34 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:48910 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S261335AbSJHSLX>;
	Tue, 8 Oct 2002 14:11:23 -0400
Date: Tue, 8 Oct 2002 20:17:01 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.x on Alpha? Who wants to test this?
Message-ID: <20021008181700.GD29980@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Are *you* currently using a 2.2.x kernel on a Alpha with SRM firmware?
If so, I'd kindly like to ask you to test a backport of my srm_env.o
(used to access SRM environment variables). If you give it a try, please
report success, no success and ksymoopsed Oopses to me:-)

Here's the patch. It still has some warnings about not-used functions
(init/exit function, #define'd here to init_module and cleanup_module),
but seems I don't see the point... Could someone please enlighten me on
this?

MfG, JBG


diff -Nur linux-2.2.22-pure/Documentation/Configure.help linux-2.2.22-srm/D=
ocumentation/Configure.help
--- linux-2.2.22-pure/Documentation/Configure.help	2002-09-16 18:26:11.0000=
00000 +0200
+++ linux-2.2.22-srm/Documentation/Configure.help	2002-10-08 19:59:19.00000=
0000 +0200
@@ -15138,6 +15138,27 @@
    boards supported by this driver, and for further information=20
    on the use of this driver.=20
=20
+SRM environment access through procfs
+CONFIG_SRM_ENV
+  If you enable this option, a subdirectory inside /proc called
+  /proc/srm_environment will give you access to the all important
+  SRM environment variables (those which have a name) and also
+  to all others (by their internal number).
+
+  SRM is something like a BIOS for Alpha machines. There are some
+  other such BIOSes, like AlphaBIOS, which this driver cannot
+  support (hey, that's not SRM!).
+
+  Despite the fact that this driver doesn't work on all Alphas (but
+  only on those which have SRM as their firmware), it's save to
+  build it even if your particular machine doesn't know about SRM
+  (or if you intend to compile a generic kernel). It will simply
+  not create those subdirectory in /proc (and give you some warning,
+  of course).
+
+  This driver is also available as a module and will be called
+  srm_env.o then.
+
 Compaq Smart Array support
 CONFIG_BLK_CPQ_CISS_DA
    This is the driver for Compaq Smart Array 5xxx controllers.
diff -Nur linux-2.2.22-pure/arch/alpha/config.in linux-2.2.22-srm/arch/alph=
a/config.in
--- linux-2.2.22-pure/arch/alpha/config.in	2001-03-25 18:37:29.000000000 +0=
200
+++ linux-2.2.22-srm/arch/alpha/config.in	2002-10-08 20:05:54.000000000 +02=
00
@@ -165,7 +165,7 @@
         -o "$CONFIG_ALPHA_TAKARA" =3D "y" -o "$CONFIG_ALPHA_EB164" =3D "y"=
 \
         -o "$CONFIG_ALPHA_ALCOR" =3D "y"  -o "$CONFIG_ALPHA_MIATA" =3D "y"=
 \
         -o "$CONFIG_ALPHA_LX164" =3D "y"  -o "$CONFIG_ALPHA_SX164" =3D "y"=
 \
-        -o "$CONFIG_ALPHA_NAUTILUS" =3D "y" ]
+        -o "$CONFIG_ALPHA_NAUTILUS" =3D "y" -o "$CONFIG_ALPHA_NONAME" =3D =
"y" ]
 then
   bool 'Use SRM as bootloader' CONFIG_ALPHA_SRM
 #  if [ "$CONFIG_EXPERIMENTAL" =3D "y" ]; then
@@ -209,6 +209,9 @@
   tristate 'Kernel support for JAVA binaries (obsolete)' CONFIG_BINFMT_JAVA
 fi
 tristate 'Kernel support for Linux/Intel ELF binaries' CONFIG_BINFMT_EM86
+if [ "$CONFIG_ALPHA_SRM" =3D "y" ]; then
+  tristate 'SRM environment access through procfs' CONFIG_ALPHA_SRM_ENV
+fi
 tristate 'Parallel port support' CONFIG_PARPORT
 if [ "$CONFIG_PARPORT" !=3D "n" ]; then
   dep_tristate '  PC-style hardware' CONFIG_PARPORT_PC $CONFIG_PARPORT
diff -Nur linux-2.2.22-pure/arch/alpha/kernel/Makefile linux-2.2.22-srm/arc=
h/alpha/kernel/Makefile
--- linux-2.2.22-pure/arch/alpha/kernel/Makefile	2001-03-25 18:31:46.000000=
000 +0200
+++ linux-2.2.22-srm/arch/alpha/kernel/Makefile	2002-10-08 20:05:00.0000000=
00 +0200
@@ -17,6 +17,9 @@
 	    bios32.o ptrace.o time.o fpreg.o
 OX_OBJS  :=3D alpha_ksyms.o
=20
+ifdef CONFIG_ALPHA_SRM_ENV
+M_OBJS   :=3D srm_env.o
+endif
=20
 ifdef CONFIG_ALPHA_GENERIC
=20
diff -Nur linux-2.2.22-pure/arch/alpha/kernel/srm_env.c linux-2.2.22-srm/ar=
ch/alpha/kernel/srm_env.c
--- linux-2.2.22-pure/arch/alpha/kernel/srm_env.c	1970-01-01 01:00:00.00000=
0000 +0100
+++ linux-2.2.22-srm/arch/alpha/kernel/srm_env.c	2002-10-08 20:11:56.000000=
000 +0200
@@ -0,0 +1,384 @@
+/*
+ * srm_env.c - Access to SRM environment
+ *             variables through linux' procfs
+ *
+ * Copyright (C) 2001-2002 Jan-Benedict Glaw <jbglaw@lug-owl.de>
+ *
+ * This driver is at all a modified version of Erik Mouw's
+ * ./linux/Documentation/DocBook/procfs_example.c, so: thank
+ * you, Erik! He can be reached via email at
+ * <J.A.K.Mouw@its.tudelft.nl>. It is based on an idea
+ * provided by DEC^WCompaq^WIntel's "Jumpstart" CD. They
+ * included a patch like this as well. Thanks for idea!
+ *
+ * This program is free software; you can redistribute
+ * it and/or modify it under the terms of the GNU General
+ * Public License version 2 as published by the Free Software
+ * Foundation.
+ *
+ * This program is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied
+ * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more
+ * details.
+ *=20
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place,
+ * Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+/*
+ * Changelog
+ * ~~~~~~~~~
+ *=20
+ * Tue, 08 Oct 2002 20:10:21 +0200
+ * 	- Port srm_env to 2.2.x.
+ * 	- This is v0.0.5-2.2.x-1 (1st try...)
+ *
+ * Thu, 22 Aug 2002 15:10:43 +0200
+ * 	- Update Config.help entry. I got a number of emails asking
+ * 	  me to tell their senders if they could make use of this
+ * 	  piece of code... So: "SRM is something like BIOS for your
+ * 	  Alpha"
+ * 	- Update code formatting a bit to better conform CodingStyle
+ * 	  rules.
+ * 	- So this is v0.0.5, with no changes (except formatting)
+ * =09
+ * Wed, 22 May 2002 00:11:21 +0200
+ * 	- Fix typo on comment (SRC -> SRM)
+ * 	- Call this "Version 0.0.4"
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
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/version.h>
+#include <asm/console.h>
+#include <asm/uaccess.h>
+#include <asm/machvec.h>
+
+/*
+ * 2.2.x compatibility cruft
+ */
+#if !defined(__init)
+#	define __init
+#endif
+#if !defined(__edit)
+#	define __exit
+#endif
+
+
+
+#define BASE_DIR	"srm_environment"	/* Subdir in /proc/		*/
+#define NAMED_DIR	"named_variables"	/* Subdir for known variables	*/
+#define NUMBERED_DIR	"numbered_variables"	/* Subdir for all variables	*/
+#define VERSION		"0.0.5-2.2.x-1"		/* Module version		*/
+#define NAME		"srm_env"		/* Module name			*/
+
+MODULE_AUTHOR("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
+MODULE_DESCRIPTION("Accessing Alpha SRM environment through procfs interfa=
ce");
+MODULE_LICENSE("GPL");
+
+typedef struct _srm_env {
+	char			*name;
+	unsigned long		id;
+	struct proc_dir_entry	*proc_entry;
+} srm_env_t;
+
+static struct proc_dir_entry	*base_dir;
+static struct proc_dir_entry	*named_dir;
+static struct proc_dir_entry	*numbered_dir;
+static char			number[256][4];
+
+static srm_env_t	srm_named_entries[] =3D {
+	{ "auto_action",	ENV_AUTO_ACTION		},
+	{ "boot_dev",		ENV_BOOT_DEV		},
+	{ "bootdef_dev",	ENV_BOOTDEF_DEV		},
+	{ "booted_dev",		ENV_BOOTED_DEV		},
+	{ "boot_file",		ENV_BOOT_FILE		},
+	{ "booted_file",	ENV_BOOTED_FILE		},
+	{ "boot_osflags",	ENV_BOOT_OSFLAGS	},
+	{ "booted_osflags",	ENV_BOOTED_OSFLAGS	},
+	{ "boot_reset",		ENV_BOOT_RESET		},
+	{ "dump_dev",		ENV_DUMP_DEV		},
+	{ "enable_audit",	ENV_ENABLE_AUDIT	},
+	{ "license",		ENV_LICENSE		},
+	{ "char_set",		ENV_CHAR_SET		},
+	{ "language",		ENV_LANGUAGE		},
+	{ "tty_dev",		ENV_TTY_DEV		},
+	{ NULL,			0			},
+};
+static srm_env_t	srm_numbered_entries[256];
+
+
+
+void
+srm_env_set_owner(struct proc_dir_entry *entry)
+{
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2, 4, 0)
+	/*
+	 * /proc/ entries are "owned" since 2.4.0 or so...
+	 */
+	entry->owner =3D THIS_MODULE;
+#endif /* LINUX_VERSION_CODE >=3D 2.4.0 */
+
+	  return;
+}
+
+
+static int
+srm_env_read(char *page, char **start, off_t off, int count, int *eof,
+		void *data)
+{
+	int		nbytes;
+	unsigned long	ret;
+	srm_env_t	*entry;
+
+	MOD_INC_USE_COUNT;
+
+	if(off !=3D 0) {
+		MOD_DEC_USE_COUNT;
+		return -EFAULT;
+	}
+
+	entry	=3D (srm_env_t *) data;
+	ret	=3D callback_getenv(entry->id, page, count);
+
+	if((ret >> 61) =3D=3D 0)
+		nbytes =3D (int) ret;
+	else
+		nbytes =3D -EFAULT;
+
+	MOD_DEC_USE_COUNT;
+
+	return nbytes;
+}
+
+
+static int
+srm_env_write(struct file *file, const char *buffer, unsigned long count,
+		void *data)
+{
+#define BUFLEN	512
+	int		nbytes;
+	srm_env_t	*entry;
+	char		buf[BUFLEN];
+	unsigned long	ret1, ret2;
+
+	MOD_INC_USE_COUNT;
+
+	entry =3D (srm_env_t *) data;
+
+	nbytes =3D strlen(buffer) + 1;
+	if(nbytes > BUFLEN) {
+		MOD_DEC_USE_COUNT;
+		return -ENOMEM;
+	}
+
+	/* memcpy(aligned_buffer, buffer, nbytes) */
+
+	if(copy_from_user(buf, buffer, count)) {
+		MOD_DEC_USE_COUNT;
+		return -EFAULT;
+	}
+	buf[count] =3D 0x00;
+
+	ret1 =3D callback_setenv(entry->id, buf, count);
+	if((ret1 >> 61) =3D=3D 0) {
+		do=20
+			ret2 =3D callback_save_env();
+		while((ret2 >> 61) =3D=3D 1);
+		nbytes =3D (int) ret1;
+	} else
+		nbytes =3D -EFAULT;
+
+	MOD_DEC_USE_COUNT;
+
+	return nbytes;
+}
+
+
+static void
+srm_env_cleanup(void)
+{
+	srm_env_t	*entry;
+	unsigned long	var_num;
+
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
+			}
+			remove_proc_entry(NAMED_DIR, base_dir);
+		}
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
+	}
+
+	return;
+}
+
+
+static int __init
+srm_env_init(void)
+{
+	srm_env_t	*entry;
+	unsigned long	var_num;
+
+	/*
+	 * Check system
+	 */
+	if(!alpha_using_srm) {
+		printk(KERN_INFO "%s: This Alpha system doesn't "
+				"know about SRM (or you've booted "
+				"SRM->MILO->Linux, which gets "
+				"misdetected)...\n", __FUNCTION__);
+		return -ENODEV;
+	}
+
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
+	srm_env_set_owner(base_dir);
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
+	srm_env_set_owner(named_dir);
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
+	srm_env_set_owner(numbered_dir);
+
+	/*
+	 * Create all named nodes
+	 */
+	entry =3D srm_named_entries;
+	while(entry->name !=3D NULL && entry->id !=3D 0) {
+		entry->proc_entry =3D create_proc_entry(entry->name,
+				0644, named_dir);
+		if(entry->proc_entry =3D=3D NULL)
+			goto cleanup;
+
+		srm_env_set_owner(entry->proc_entry);
+		entry->proc_entry->data		=3D (void *) entry;
+		entry->proc_entry->read_proc	=3D srm_env_read;
+		entry->proc_entry->write_proc	=3D srm_env_write;
+
+		entry++;
+	}
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
+		srm_env_set_owner(entry->proc_entry);
+		entry->id			=3D var_num;
+		entry->proc_entry->data		=3D (void *) entry;
+		entry->proc_entry->read_proc	=3D srm_env_read;
+		entry->proc_entry->write_proc	=3D srm_env_write;
+	}
+
+	printk(KERN_INFO "%s: version %s loaded successfully\n", NAME,
+			VERSION);
+
+	return 0;
+
+cleanup:
+	srm_env_cleanup();
+
+	return -ENOMEM;
+}
+
+
+static void __exit
+srm_env_exit(void)
+{
+	srm_env_cleanup();
+	printk(KERN_INFO "%s: unloaded successfully\n", NAME);
+
+	return;
+}
+
+
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2, 4, 0)
+	module_init(srm_env_init);
+	module_exit(srm_env_exit);
+#else
+#	define init_module	srm_env_init
+#	define cleanup_module	srm_env_exit
+#endif
+

--=20
   - Eine Freie Meinung in einem Freien Kopf f=FCr
   - einen Freien Staat voll Freier B=FCrger
   						Gegen Zensur im Internet
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9oyEcHb1edYOZ4bsRAhXLAJoDoKYO0tG/xgQnT7LN3wrJJ06a4gCfUJ2K
T01D+yO2YI6NSiXpBppvWGM=
=00Yd
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
