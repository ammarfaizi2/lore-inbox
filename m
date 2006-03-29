Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWC2OXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWC2OXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWC2OXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:23:11 -0500
Received: from mail.parknet.jp ([210.171.160.80]:49413 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750724AbWC2OXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:23:10 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fat: kill reserved names
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 29 Mar 2006 23:23:01 +0900
Message-ID: <87k6ade3ei.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since these names on old MSDOS is used as device, so, current fat
driver doesn't allow a user to create those names.  But many OSes and
even Windows can create those names actually, now.

This patch removes the reserved name check.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/msdos/namei.c |   15 +--------------
 fs/vfat/namei.c  |   18 ------------------
 2 files changed, 1 insertion(+), 32 deletions(-)

diff -puN fs/msdos/namei.c~fat-kill-reserved-names fs/msdos/namei.c
--- linux-2.6/fs/msdos/namei.c~fat-kill-reserved-names	2006-03-29 04:44:53.000000000 +0900
+++ linux-2.6-hirofumi/fs/msdos/namei.c	2006-03-29 04:44:53.000000000 +0900
@@ -12,14 +12,6 @@
 #include <linux/msdos_fs.h>
 #include <linux/smp_lock.h>
 
-/* MS-DOS "device special files" */
-static const unsigned char *reserved_names[] = {
-	"CON     ", "PRN     ", "NUL     ", "AUX     ",
-	"LPT1    ", "LPT2    ", "LPT3    ", "LPT4    ",
-	"COM1    ", "COM2    ", "COM3    ", "COM4    ",
-	NULL
-};
-
 /* Characters that are undesirable in an MS-DOS file name */
 static unsigned char bad_chars[] = "*?<>|\"";
 static unsigned char bad_if_strict_pc[] = "+=,; ";
@@ -40,7 +32,6 @@ static int msdos_format_name(const unsig
 	 */
 {
 	unsigned char *walk;
-	const unsigned char **reserved;
 	unsigned char c;
 	int space;
 
@@ -127,11 +118,7 @@ static int msdos_format_name(const unsig
 	}
 	while (walk - res < MSDOS_NAME)
 		*walk++ = ' ';
-	if (!opts->atari)
-		/* GEMDOS is less stupid and has no reserved names */
-		for (reserved = reserved_names; *reserved; reserved++)
-			if (!strncmp(res, *reserved, 8))
-				return -EINVAL;
+
 	return 0;
 }
 
diff -puN fs/vfat/namei.c~fat-kill-reserved-names fs/vfat/namei.c
--- linux-2.6/fs/vfat/namei.c~fat-kill-reserved-names	2006-03-29 04:44:53.000000000 +0900
+++ linux-2.6-hirofumi/fs/vfat/namei.c	2006-03-29 04:44:53.000000000 +0900
@@ -185,24 +185,6 @@ static int vfat_valid_longname(const uns
 		return -EINVAL;
 	if (len >= 256)
 		return -ENAMETOOLONG;
-
-	/* MS-DOS "device special files" */
-	if (len == 3 || (len > 3 && name[3] == '.')) {	/* basename == 3 */
-		if (!strnicmp(name, "aux", 3) ||
-		    !strnicmp(name, "con", 3) ||
-		    !strnicmp(name, "nul", 3) ||
-		    !strnicmp(name, "prn", 3))
-			return -EINVAL;
-	}
-	if (len == 4 || (len > 4 && name[4] == '.')) {	/* basename == 4 */
-		/* "com1", "com2", ... */
-		if ('1' <= name[3] && name[3] <= '9') {
-			if (!strnicmp(name, "com", 3) ||
-			    !strnicmp(name, "lpt", 3))
-				return -EINVAL;
-		}
-	}
-
 	return 0;
 }
 
_
