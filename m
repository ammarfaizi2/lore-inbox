Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTEZTX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTEZTX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:23:29 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:19729 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262161AbTEZTX1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:23:27 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] fix menuconfig if saving on different fs
Date: Mon, 26 May 2003 21:35:14 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305262135.25363.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

This patch fixes the behaviour of make menuconfig, if the
file in the "Save Configuration to Alternate File" menu is
on a different file-system, than the source tree.
Without this patch saving the config to /boot/xyz fails, if
boot is on an own filesystem.

patch against 2.5.69-bk19

Linus, please apply.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 21:27:43 up  5:37,  4 users,  load average: 2.04, 1.35, 1.14



diff -urN -X /home/mb/dontdiff linux-2.5.69-bk19.vanilla/scripts/kconfig/confdata.c linux-2.5.69-bk19/scripts/kconfig/confdata.c
- --- linux-2.5.69-bk19.vanilla/scripts/kconfig/confdata.c	2003-05-26 20:24:44.000000000 +0200
+++ linux-2.5.69-bk19/scripts/kconfig/confdata.c	2003-05-26 21:23:47.000000000 +0200
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  * Released under the terms of the GNU GPL v2.0.
+ *
+ * May 26, 2003 Michael Buesch <fsdeveloper@yahoo.de>:
+ *	fixed behaviour of conf_write() if "name" is on different file system.
  */
 
 #include <sys/stat.h>
@@ -239,7 +242,7 @@
 
 int conf_write(const char *name)
 {
- -	FILE *out, *out_h;
+	FILE *out, *out_h, *out_new;
 	struct symbol *sym;
 	struct menu *menu;
 	char oldname[128];
@@ -369,8 +372,30 @@
 
 	sprintf(oldname, "%s.old", name);
 	rename(name, oldname);
- -	if (rename(".tmpconfig", name))
- -		return 1;
+
+	if (rename(".tmpconfig", name)) {
+		if (errno == EXDEV) {
+			out = fopen(".tmpconfig", "r");
+			if (!out)
+				return 1;
+			out_new = fopen(name, "w");
+			if (!out_new) {
+				fclose(out);
+				return 1;
+			}
+			while ((l = fgetc(out)) != EOF) {
+				if (fputc(l, out_new) == EOF) {
+					fclose(out);
+					fclose(out_new);
+					return 1;
+				}
+			}
+			fclose(out);
+			fclose(out_new);
+			unlink(".tmpconfig");
+		} else
+			return 1;
+	}
 
 	sym_change_count = 0;
 


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+0mx9oxoigfggmSgRAsKRAKCHoEFbU386aVjO65KIpBVkMLtF4ACcDj+s
rng5t4l/ClMytEjyal72uXs=
=ciX7
-----END PGP SIGNATURE-----

