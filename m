Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280398AbRKEJEV>; Mon, 5 Nov 2001 04:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280392AbRKEJEP>; Mon, 5 Nov 2001 04:04:15 -0500
Received: from [194.51.220.145] ([194.51.220.145]:39364 "EHLO emeraude")
	by vger.kernel.org with ESMTP id <S280398AbRKEJD6>;
	Mon, 5 Nov 2001 04:03:58 -0500
Date: Mon, 5 Nov 2001 10:03:46 +0100
From: Stephane Jourdois <stephane@tuxfinder.org>
To: Massimo Dal Zotto <dz@debian.org>
Cc: LKLM <linux-kernel@vger.kernel.org>
Subject: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011105100346.A1511@emeraude.kwisatz.net>
Reply-To: stephane@tuxfinder.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14-pre8
X-Send-From: emeraude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

First, a very big thanx to Massimo for this great piece of code :-)
I've been trying to catch those events with no sucess for weeks.

I've got a Dell Inspiron 8100, which seems to differ slightly from
i8000. Here is a patch that fixes that. Please do not hesitate to ask me
to test some new code or anything on my laptop.

You should also replace your printk("string") with printk(KERN_INFO "string=
")


PS : Massimo, which version of setmixer do you use ? mine doesn't
support {+|-}val syntax... (debian sid, setmixer 27DEC94-4)

Thanks,



--- /home/kwisatz/i8kutils-1.1/i8k.c	Fri Nov  2 16:02:24 2001
+++ drivers/char/i8k.c	Mon Nov  5 01:06:31 2001
@@ -1,5 +1,5 @@
 /*
- * i8k.c -- Linux driver for accessing the SMM BIOS on Dell I8000 laptops
+ * i8k.c -- Linux driver for accessing the SMM BIOS on Dell I8x00 laptops
  *
  * Copyright (C) 2001  Massimo Dal Zotto <dz@debian.org>
  *
@@ -25,7 +25,7 @@
 #include <linux/i8k.h>
=3D20
 #define I8K_VERSION		"1.1 02/11/2001"
-#define I8K_BIOS_SIGNATURE	"Dell System Inspiron 8000"
+#define I8K_BIOS_SIGNATURE	"Dell System Inspiron 8"
 #define I8K_BIOS_SIGNATURE_ADDR 0x000ec000
 #define I8K_BIOS_VERSION_OFFSET	32
=3D20
@@ -40,10 +40,10 @@
 #define I8K_FAN_MULT		30
 #define I8K_MAX_TEMP		127
=3D20
-#define I8K_FN_NONE		0x08
-#define I8K_FN_UP		0x09
-#define I8K_FN_DOWN		0x0a
-#define I8K_FN_MUTE		0x0c
+#define I8K_FN_NONE		0x00
+#define I8K_FN_UP		0x01
+#define I8K_FN_DOWN		0x02
+#define I8K_FN_MUTE		0x04
=3D20
 #define I8K_POWER_AC		0x05
 #define I8K_POWER_BATTERY	0x01
@@ -56,10 +56,10 @@
 int force =3D3D 0;
=3D20
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
-MODULE_DESCRIPTION("Driver for accessing the SMM BIOS on Dell I8000 laptop=
=3D
s");
+MODULE_DESCRIPTION("Driver for accessing the SMM BIOS on Dell I8x00 laptop=
=3D
s");
 MODULE_LICENSE("GPL");
 MODULE_PARM(force, "i");
-MODULE_PARM_DESC(force, "Force loading without checking for an Inspiron 80=
=3D
00");
+MODULE_PARM_DESC(force, "Force loading without checking for an Inspiron 8x=
=3D
00");
=3D20
 static ssize_t i8k_read(struct file *, char *, size_t, loff_t *);
 static int i8k_ioctl(struct inode *, struct file *, unsigned int,
@@ -157,7 +157,7 @@
 	return rc;
     }
=3D20
-    switch ((regs.eax & 0xff00) >> 8) {
+    switch ((regs.eax & 0x0700) >> 8) {
     case I8K_FN_UP:
 	return I8K_VOL_UP;
     case I8K_FN_DOWN:
@@ -439,7 +439,7 @@
 }
=3D20
 /*
- * Probe for the presence of an Inspiron I8000.
+ * Probe for the presence of an Inspiron I8x00.
  */
 static int i8k_probe(void)
 {
@@ -458,8 +458,9 @@
 	    printk("i8k: ioremap failed\n");
 	    return -ENODEV;
 	}
-	if (strncmp(buff,I8K_BIOS_SIGNATURE,sizeof(I8K_BIOS_SIGNATURE)) !=3D3D 0)=
 {
-	    printk("i8k: Inspiron 8000 BIOS signature not found\n");
+	if (strncmp(buff,I8K_BIOS_SIGNATURE,sizeof(I8K_BIOS_SIGNATURE) - 1) !=3D3=
D =3D
0) {
+	    // -1 because we don't wan't to check for \0 at the end
+	    printk("i8k: Inspiron 8x00 BIOS signature not found\n");
 	    iounmap(buff);
 	    return -ENODEV;
 	}
@@ -475,7 +476,7 @@
 	}
 	for (p=3D3Dbuff; (p-buff)<(0x00100000-0x000c0000); p+=3D3D16) {
 	    if (strncmp(p,I8K_BIOS_SIGNATURE,sizeof(I8K_BIOS_SIGNATURE))=3D3D=3D3=
D0) {
-		printk("i8k: Inspiron 8000 BIOS signature found at %08x\n",
+		printk("i8k: Inspiron 8x00 BIOS signature found at %08x\n",
 		       0x000c0000+(p-buff));
 		break;
 	    }
@@ -518,7 +519,7 @@
 {
     struct proc_dir_entry *proc_i8k;
=3D20
-    /* Are we running on an Inspiron 8000 laptop? */
+    /* Are we running on an Inspiron 8x00 laptop? */
     if (i8k_probe() !=3D3D 0) {
 	return -ENODEV;
     }
@@ -532,7 +533,7 @@
     SET_MODULE_OWNER(proc_i8k);
=3D20
     printk(KERN_INFO
-	   "Inspiron 8000 SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
+	   "Inspiron 8x00 SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
 	   I8K_VERSION);
=3D20
     return 0;


--=20
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ing?nieur d?veloppement 	\ /    AGAINST HTML MAIL    )))
 \\\   6, av. de la Belle Image	 X                         ///
  \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvmVfIACgkQk2dpMN4A2NN42wCfd28yle3aAcsaJSL+Yt9Y74kA
tVkAniQodYL0S751y+QZvEaOdlaaYWZV
=Yp7u
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
