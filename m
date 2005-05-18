Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVERCGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVERCGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 22:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVERCGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 22:06:06 -0400
Received: from home.leonerd.org.uk ([217.147.80.44]:36545 "EHLO
	home.leonerd.org.uk") by vger.kernel.org with ESMTP id S262051AbVERCFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 22:05:22 -0400
Date: Wed, 18 May 2005 03:05:13 +0100
From: Paul LeoNerd Evans <leonerd@leonerd.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix to virtual terminal UTF-8 mode handling
Message-ID: <20050518030513.7fe55ef1@nim.leo>
X-Mailer: Sylpheed-Claws 1.9.6cvs45 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Wed__18_May_2005_03_05_13_+0100_Jn.OwgC9gw6vaxXO;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Wed__18_May_2005_03_05_13_+0100_Jn.OwgC9gw6vaxXO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This patch fixes a bug in the virtual terminal driver, whereby the UTF-8
mode is reset to "off" following a console reset, such as might be
delivered by mingetty, screen, vim, etc...

Rather than resetting to hardcoded "0", it gets reset on or off, as
determined by a new sysctl located in /proc/tty/vt/default_utf8_mode.
This patch is best accompanied with an addition of the following line to
the system's init scripts:

  echo 1 >/proc/tty/vt/default_utf8_mode

Following this, all resets to the console will leave it with UTF-8 mode
on.

The default behaviour of this sysctl is as before, without the patch.
Namely, UTF-8 mode is switched off on reset. [I.e applying this patch
does not affect default behaviour].


Signed-off-by: Paul Evans <leonerd@leonerd.org.uk>


--- linux-2.6.11/drivers/char/vt.c	2005-05-04 02:01:08.000000000
+0100 +++ linux-2.6.11-utfswitch/drivers/char/vt.c	2005-05-07
22:41:58.000000000 +0100 @@ -93,6 +93,7 @@
 #include <linux/pm.h>
 #include <linux/font.h>
 #include <linux/bitops.h>
+#include <linux/proc_fs.h>
=20
 #include <asm/io.h>
 #include <asm/system.h>
@@ -162,6 +163,15 @@
 static int blankinterval =3D 10*60*HZ;
 static int vesa_off_interval;
=20
+/*
+ * When resetting a console, do we start in UTF-8 mode or not?
+ * 0 =3D no, 1 =3D yes
+ */
+static int default_utf8_mode =3D 0;
+
+struct proc_dir_entry *proc_vt_dir;
+struct proc_dir_entry *proc_default_utf8_mode;
+
 static DECLARE_WORK(console_work, console_callback, NULL);
=20
 /*
@@ -1472,7 +1482,7 @@
 	charset		=3D 0;
 	need_wrap	=3D 0;
 	report_mouse	=3D 0;
-	utf             =3D 0;
+	utf             =3D default_utf8_mode;
 	utf_count       =3D 0;
=20
 	disp_ctrl	=3D 0;
@@ -2530,6 +2540,63 @@
 	reset_terminal(currcons, do_clear);
 }
=20
+static int proc_write_default_utf8_mode(struct file *file, const char
*buffer,
+			unsigned long count, void *data)
+{
+	char temp[16];
+	int len;
+
+	if (count > sizeof(temp)-1)
+		len =3D sizeof(temp)-1;
+	else
+		len =3D count;
+
+	if (copy_from_user(temp, buffer, len))
+		return -EFAULT;
+
+	temp[len] =3D 0;
+
+	/* No effect if empty or >1 character long */
+	if (temp[0] =3D=3D 0 || (temp[1] !=3D '\n' && temp[1] !=3D 0)) {
+		return len;
+	}
+
+	/* No effect if outside the range 0<=3Dx<=3D1 */
+	if (temp[0] < '0' || temp[0] > '1') {
+		return len;
+	}
+
+	default_utf8_mode =3D (temp[0] - '0');
+
+	return len;
+}
+
+static int proc_read_default_utf8_mode(char *page, char **start, off_t
off,
+			int count, int *eof, void *data)
+{
+	return sprintf(page, "default_utf8_mode =3D %d\n",
default_utf8_mode); +}
+
+static int init_proc(void)
+{
+	proc_vt_dir =3D proc_mkdir("tty/vt", NULL);
+
+	if (!proc_vt_dir)
+		return -ENOMEM;
+
+	proc_default_utf8_mode =3D create_proc_entry("default_utf8_mode",
0644, proc_vt_dir); +
+	if (!proc_default_utf8_mode)
+		return -ENOMEM;
+
+	proc_default_utf8_mode->owner =3D THIS_MODULE;
+	proc_default_utf8_mode->data =3D &default_utf8_mode;
+	proc_default_utf8_mode->write_proc =3D
proc_write_default_utf8_mode;
+	proc_default_utf8_mode->read_proc =3D proc_read_default_utf8_mode;
+
+	return 0;
+}
+
 /*
  * This routine initializes console interrupts, and does nothing
  * else. If you want the screen to clear, call tty_write with
@@ -2612,6 +2679,8 @@
=20
 int __init vty_init(void)
 {
+	int ret;
+
 	vcs_init();
=20
 	console_driver =3D alloc_tty_driver(MAX_NR_CONSOLES);
@@ -2638,6 +2707,11 @@
 #ifdef CONFIG_MDA_CONSOLE
 	mda_console_init();
 #endif
+
+	ret =3D init_proc();
+	if (ret)
+		return ret;
+
 	return 0;
 }
=20


--=20
Paul "LeoNerd" Evans

leonerd@leonerd.org.uk
ICQ# 4135350       |  Registered Linux# 179460
http://www.leonerd.org.uk/

--Signature_Wed__18_May_2005_03_05_13_+0100_Jn.OwgC9gw6vaxXO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCiqLdvcPg11V/1hgRAukeAJoCEJJWkPbRdcJiNfP3fh41Nkv7DwCfbuLP
VSr8TlWLMsFLYZRD/Yjgn3A=
=Tsja
-----END PGP SIGNATURE-----

--Signature_Wed__18_May_2005_03_05_13_+0100_Jn.OwgC9gw6vaxXO--
