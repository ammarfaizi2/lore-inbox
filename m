Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264215AbRFRPZr>; Mon, 18 Jun 2001 11:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264218AbRFRPZj>; Mon, 18 Jun 2001 11:25:39 -0400
Received: from air.lug-owl.de ([62.52.24.190]:12812 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S264215AbRFRPZX>;
	Mon, 18 Jun 2001 11:25:23 -0400
Date: Mon, 18 Jun 2001 17:25:19 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Support for SRM environment variables through procfs
Message-ID: <20010618172518.A20937@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux air 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've found a patch on Compaq's Jumpstart-CD which provides access to
SRM'S environment variables. I've ported that patch to 2.4.x and
here's the patch. Please test it. However, I've not got an Alpha
system booting via SRM handy so this patch is untested:-(

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-172-7608481 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="srm_patch-2.4.6-pre1"
Content-Transfer-Encoding: quoted-printable

diff -Nur linux-2.4.6-pre1/Documentation/Configure.help linux-2.4.6-pre1-sr=
m/Documentation/Configure.help
--- linux-2.4.6-pre1/Documentation/Configure.help	Tue Jun  5 11:24:47 2001
+++ linux-2.4.6-pre1-srm/Documentation/Configure.help	Tue Jun  5 12:15:29 2=
001
@@ -17311,6 +17311,16 @@
=20
   If you're not sure, say N.
=20
+SRM environment variables in procfs
+CONFIG_SRM_ENV
+  If you enable this option, a subdirectory called srm_environment
+  will give you access to the most important SRM environment
+  variables. If you've got an Alpha style system supporting
+  SRC, then it is a good idea to say Yes or Module to this driver.
+
+  This driver is also available as a module and will be called
+  srm_env.o if you build it as a module.
+ =20
 Footbridge internal watchdog
 CONFIG_21285_WATCHDOG
   The Intel Footbridge chip contains a builtin watchdog circuit. Say Y=20
diff -Nur linux-2.4.6-pre1/arch/alpha/config.in linux-2.4.6-pre1-srm/arch/a=
lpha/config.in
--- linux-2.4.6-pre1/arch/alpha/config.in	Tue Jun  5 11:22:08 2001
+++ linux-2.4.6-pre1-srm/arch/alpha/config.in	Tue Jun  5 12:15:29 2001
@@ -179,7 +179,7 @@
 	-o "$CONFIG_ALPHA_TAKARA" =3D "y" -o "$CONFIG_ALPHA_EB164" =3D "y" \
 	-o "$CONFIG_ALPHA_ALCOR" =3D "y"  -o "$CONFIG_ALPHA_MIATA" =3D "y" \
 	-o "$CONFIG_ALPHA_LX164" =3D "y"  -o "$CONFIG_ALPHA_SX164" =3D "y" \
-	-o "$CONFIG_ALPHA_NAUTILUS" =3D "y" ]
+	-o "$CONFIG_ALPHA_NAUTILUS" =3D "y" -o "$CONFIG_ALPHA_NONAME" =3D "y" ]
 then
   bool 'Use SRM as bootloader' CONFIG_ALPHA_SRM
 fi
@@ -235,6 +235,10 @@
 	"ELF		CONFIG_KCORE_ELF	\
 	 A.OUT		CONFIG_KCORE_AOUT" ELF
 fi
+if [ "$CONFIG_PROC_FS" !=3D "n" -a CONFIG_ALPHA_SRM =3D "y" ]; then
+   tristate 'SRM environment through procfs' CONFIG_SRM_ENV
+fi
+=20
 tristate 'Kernel support for a.out (ECOFF) binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
diff -Nur linux-2.4.6-pre1/arch/alpha/kernel/Makefile linux-2.4.6-pre1-srm/=
arch/alpha/kernel/Makefile
--- linux-2.4.6-pre1/arch/alpha/kernel/Makefile	Tue Jun  5 11:07:28 2001
+++ linux-2.4.6-pre1-srm/arch/alpha/kernel/Makefile	Tue Jun  5 12:15:29 2001
@@ -32,6 +32,7 @@
=20
 obj-$(CONFIG_SMP)    +=3D smp.o irq_smp.o
 obj-$(CONFIG_PCI)    +=3D pci.o pci_iommu.o
+obj-$(CONFIG_SRM_ENV)	+=3D srm_env.o
=20
 ifdef CONFIG_ALPHA_GENERIC
=20
diff -Nur linux-2.4.6-pre1/arch/alpha/kernel/alpha_ksyms.c linux-2.4.6-pre1=
-srm/arch/alpha/kernel/alpha_ksyms.c
--- linux-2.4.6-pre1/arch/alpha/kernel/alpha_ksyms.c	Tue Jun  5 11:22:08 20=
01
+++ linux-2.4.6-pre1-srm/arch/alpha/kernel/alpha_ksyms.c	Tue Jun  5 12:16:3=
5 2001
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
=20
 #include <asm/io.h>
+#include <asm/console.h>
 #include <asm/hwrpb.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -56,6 +57,11 @@
 EXPORT_SYMBOL(probe_irq_mask);
 EXPORT_SYMBOL(screen_info);
 EXPORT_SYMBOL(perf_irq);
+#ifdef CONFIG_ALPHA_SRM
+EXPORT_SYMBOL(callback_getenv);
+EXPORT_SYMBOL(callback_setenv);
+EXPORT_SYMBOL(callback_save_env);
+#endif /* CONFIG_ALPHA_SRM */
=20
 /* platform dependent support */
 EXPORT_SYMBOL(_inb);
diff -Nur linux-2.4.6-pre1/arch/alpha/kernel/srm_env.c linux-2.4.6-pre1-srm=
/arch/alpha/kernel/srm_env.c
--- linux-2.4.6-pre1/arch/alpha/kernel/srm_env.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.6-pre1-srm/arch/alpha/kernel/srm_env.c	Tue Jun  5 12:15:29 20=
01
@@ -0,0 +1,219 @@
+/*
+ * srm_env.c - Access to SRC environment variables through
+ *             the linux procfs
+ *
+ * (C)2001, Jan-Benedict Glaw <jbgaw@lug-owl.de>
+ *
+ * This driver is at all a modified version of Erik Mouw's
+ * ./linux/Documentation/DocBook/procfs_example.c, so: thanky
+ * you, erik! He can be reached via email at
+ * <J.A.K.Mouw@its.tudelft.nl>. It is based on an idea
+ * provided by DEC^WCompaq's "Jumpstart" CD. They included
+ * a patch like this as well. Thanks for idea!
+ *
+ *
+ * This software has been developed while working on the LART
+ * computing board (http://www.lart.tudelft.nl/). The
+ * development has been sponsored by the Mobile Multi-media
+ * Communications (http://www.mmc.tudelft.nl/) and Ubiquitous
+ * Communications (http://www.ubicom.tudelft.nl/) projects.
+ *
+ * This program is free software; you can redistribute
+ * it and/or modify it under the terms of the GNU General
+ * Public License as published by the Free Software
+ * Foundation version 2.
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
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <asm/console.h>
+#include <asm/uaccess.h>
+
+#define DIRNAME		"srm_environment"	/* Subdir in /proc/	*/
+#define VERSION		"0.0.1"			/* Module version	*/
+#define NAME		"srm_env"		/* Module name		*/
+#define DEBUG
+
+MODULE_AUTHOR("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
+MODULE_DESCRIPTION("Accessing Alpha SRM environment through procfs interfa=
ce");
+EXPORT_NO_SYMBOLS;
+
+typedef struct _srm_env {
+	char			*name;
+	unsigned long		id;
+	struct proc_dir_entry	*proc_entry;
+} srm_env_t;
+
+static struct proc_dir_entry	*directory;
+static srm_env_t	srm_entries[] =3D {
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
+
+static int srm_env_read(char *page, char **start, off_t off, int count,
+		int *eof, void *data)
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
+	entry	=3D (srm_env_t *)data;
+	ret	=3D callback_getenv(entry->id, page, count);
+
+	if((ret >> 61) =3D=3D 0)
+		nbytes =3D (int)ret;
+	else
+		nbytes =3D -EFAULT;
+
+	MOD_DEC_USE_COUNT;
+
+	return nbytes;
+}
+
+
+static int srm_env_write(struct file *file, const char *buffer,
+		unsigned long count, void *data)
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
+	=09
+	//memcpy(aligned_buffer, buffer, nbytes)
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
+		nbytes =3D (int)ret1;
+	} else
+		nbytes =3D -EFAULT;
+
+	MOD_DEC_USE_COUNT;
+
+	return nbytes;
+}
+
+static void srm_env_cleanup(void)
+{
+	srm_env_t	*entry;
+
+	if(directory) {
+		entry =3D srm_entries;
+		while(entry->name !=3D NULL && entry->id !=3D 0) {
+			if(entry->proc_entry) {
+				remove_proc_entry(entry->name, directory);
+				entry->proc_entry =3D NULL;
+			}
+			entry++;
+		}
+		remove_proc_entry(DIRNAME, NULL);
+	}
+
+	return;
+}
+
+static int __init srm_env_init(void)
+{
+	srm_env_t	*entry;
+=09
+	if(!alpha_using_srm) {
+		printk(KERN_INFO "%s: This Alpha system doesn't "
+				"know about SRM...\n", __FUNCTION__);
+		return -ENODEV;
+	}
+
+	directory =3D proc_mkdir(DIRNAME, NULL);
+	if(directory =3D=3D NULL)
+		return -ENOMEM;
+=09
+	directory->owner =3D THIS_MODULE;
+=09
+	/* Now create all the nodes... */
+	entry =3D srm_entries;
+	while(entry->name !=3D NULL && entry->id !=3D 0) {
+		entry->proc_entry =3D create_proc_entry(entry->name, 0644,
+				directory);
+		if(entry->proc_entry =3D=3D NULL)
+			goto cleanup;
+		entry->proc_entry->data		=3D entry;
+		entry->proc_entry->read_proc	=3D srm_env_read;
+		entry->proc_entry->write_proc	=3D srm_env_write;
+		entry->proc_entry->owner	=3D THIS_MODULE;
+		entry++;
+	}
+=09
+	printk(KERN_INFO "%s: version %s loaded successfully\n", NAME,
+			VERSION);
+	return 0;
+
+cleanup:
+	srm_env_cleanup();
+	return -ENOMEM;
+}
+
+
+static void __exit srm_env_exit(void)
+{
+	srm_env_cleanup();
+	printk(KERN_INFO "%s: unloaded successfully\n", NAME);
+	return;
+}
+
+module_init(srm_env_init);
+module_exit(srm_env_exit);
+
diff -Nur linux-2.4.6-pre1/include/asm-alpha/console.h linux-2.4.6-pre1-srm=
/include/asm-alpha/console.h
--- linux-2.4.6-pre1/include/asm-alpha/console.h	Tue Jun 20 02:59:33 2000
+++ linux-2.4.6-pre1-srm/include/asm-alpha/console.h	Tue Jun  5 12:15:29 20=
01
@@ -22,8 +22,8 @@
 #define CCB_GET_ENV		0x22
 #define CCB_SAVE_ENV		0x23
=20
-#define CCB_PSWITCH            0x30
-#define CCB_BIOS_EMUL          0x32
+#define CCB_PSWITCH		0x30
+#define CCB_BIOS_EMUL		0x32
=20
 /*
  * Environment variable numbers
@@ -51,6 +51,8 @@
 extern long callback_close(long unit);
 extern long callback_read(long channel, long count, const char *buf, long =
lbn);
 extern long callback_getenv(long id, const char *buf, unsigned long buf_si=
ze);
+extern long callback_setenv(long id, const char *buf, unsigned long buf_si=
ze);
+extern long callback_save_env(void);
=20
 extern int srm_fixup(unsigned long new_callback_addr,
 		     unsigned long new_hwrpb_addr);

--EeQfGwPcQSOJBaQU--

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjsuHV0ACgkQHb1edYOZ4bs9/wCdEY2eXJwIAdEtilYBEm2Enr4y
zDIAn2kacaW25A+vpN/zcOufdTAWobzM
=cbmC
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
