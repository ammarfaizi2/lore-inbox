Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267093AbRGJTB0>; Tue, 10 Jul 2001 15:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbRGJTBR>; Tue, 10 Jul 2001 15:01:17 -0400
Received: from bremen.shuttle.de ([194.95.249.251]:57611 "HELO
	bremen.shuttle.de") by vger.kernel.org with SMTP id <S267093AbRGJTBB>;
	Tue, 10 Jul 2001 15:01:01 -0400
X-Checkuser-Host: 172.23.10.100
Date: Tue, 10 Jul 2001 20:58:42 +0200 (CEST)
From: Wolfram Pienkoss <wp@bszh.de>
X-X-Sender: <wp@daucus.wp.bszh.de>
To: <linux-kernel@vger.kernel.org>
Cc: Gordon Chaffee <chaffee@bmrc.berkeley.edu>
Subject: [PATCH] Linux 2.4.7-pre5 & vfat short file names & Windows 2000
Message-ID: <Pine.LNX.4.33.0107102057130.1488-100000@daucus.wp.bszh.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the patch below solves two problems.

1. Vfat upper case short names created under Linux, now are shown
   also in upper case under Windows 2000.

2. Short names created under Windows 2000 like ABC.ABC ABC.abc and so on,
   now are shown in correctly case under Linux.

The patch is also available at http://www.bszh.de/download/linux/

Best regards,
Wolfram

-- 
 Wolfram Pienkoss                          Berufsschulzentrum Hermsdorf
 Rodaer Strasse 45, D-07629 Hermsdorf      Phone: +49-36601-47407
 eMail: wp@bszh.de   www: www.bszh.de      Fax:   +49-36601-47400

diff -urdN linux-2.4.7-pre5.orig/fs/fat/dir.c linux/fs/fat/dir.c
--- linux-2.4.7-pre5.orig/fs/fat/dir.c	Wed Apr 18 11:49:12 2001
+++ linux/fs/fat/dir.c	Tue Jul 10 15:51:43 2001
@@ -10,7 +10,7 @@
  *  VFAT extensions by Gordon Chaffee <chaffee@plateau.cs.berkeley.edu>
  *  Merged with msdos fs by Henrik Storner <storner@osiris.ping.dk>
  *  Rewritten for constant inumbers. Plugged buffer overrun in readdir(). AV
- *  Short name translation 1999 by Wolfram Pienkoss <wp@bszh.de>
+ *  Short name translation 1999-2001 by Wolfram Pienkoss <wp@bszh.de>
  */

 #define ASC_LINUX_VERSION(V, P, S)	(((V) * 65536) + ((P) * 256) + (S))
@@ -271,7 +271,7 @@
 		}
 		for (i = 0, j = 0, last_u = 0; i < 8;) {
 			if (!work[i]) break;
-			if (nocase)
+			if (nocase && !(de->lcase & CASE_LOWER_BASE))
 				chl = fat_short2uni(nls_disk, &work[i], 8 - i, &bufuname[j++]);
 			else
 				chl = fat_short2lower_uni(nls_disk, &work[i], 8 - i, &bufuname[j++]);
@@ -287,7 +287,7 @@
 		fat_short2uni(nls_disk, ".", 1, &bufuname[j++]);
 		for (i = 0; i < 3;) {
 			if (!de->ext[i]) break;
-			if (nocase)
+			if (nocase && !(de->lcase & CASE_LOWER_EXT))
 				chl = fat_short2uni(nls_disk, &de->ext[i], 3 - i, &bufuname[j++]);
 			else
 				chl = fat_short2lower_uni(nls_disk, &de->ext[i], 3 - i, &bufuname[j++]);
@@ -474,7 +474,7 @@
 	}
 	for (i = 0, j = 0, last = 0, last_u = 0; i < 8;) {
 		if (!(c = work[i])) break;
-		if (nocase)
+		if (nocase && !(de->lcase & CASE_LOWER_BASE))
 			chl = fat_short2uni(nls_disk, &work[i], 8 - i, &bufuname[j++]);
 		else
 			chl = fat_short2lower_uni(nls_disk, &work[i], 8 - i, &bufuname[j++]);
@@ -498,7 +498,7 @@
 	ptname[i++] = '.';
 	for (i2 = 0; i2 < 3;) {
 		if (!(c = de->ext[i2])) break;
-		if (nocase)
+		if (nocase && !(de->lcase & CASE_LOWER_EXT))
 			chl = fat_short2uni(nls_disk, &de->ext[i2], 3 - i2, &bufuname[j++]);
 		else
 			chl = fat_short2lower_uni(nls_disk, &de->ext[i2], 3 - i2, &bufuname[j++]);
diff -urdN linux-2.4.7-pre5.orig/fs/vfat/namei.c linux/fs/vfat/namei.c
--- linux-2.4.7-pre5.orig/fs/vfat/namei.c	Fri Apr  6 10:51:19 2001
+++ linux/fs/vfat/namei.c	Tue Jul 10 15:51:43 2001
@@ -9,7 +9,7 @@
  *    what file operation caused you trouble and if you can duplicate
  *    the problem, send a script that demonstrates it.
  *
- *  Short name translation 1999 by Wolfram Pienkoss <wp@bszh.de>
+ *  Short name translation 1999-2001 by Wolfram Pienkoss <wp@bszh.de>
  *
  *  Support Multibyte character and cleanup by
  *  				OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
@@ -1056,7 +1056,7 @@
 	(*de)->starthi = 0;
 	(*de)->size = 0;
 	(*de)->attr = is_dir ? ATTR_DIR : ATTR_ARCH;
-	(*de)->lcase = CASE_LOWER_BASE | CASE_LOWER_EXT;
+	(*de)->lcase = 0;


 	fat_mark_buffer_dirty(sb, *bh);

