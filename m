Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262561AbSJBTYZ>; Wed, 2 Oct 2002 15:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262563AbSJBTYZ>; Wed, 2 Oct 2002 15:24:25 -0400
Received: from p028.as-l031.contactel.cz ([212.65.234.220]:1664 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S262561AbSJBTYX>;
	Wed, 2 Oct 2002 15:24:23 -0400
Date: Wed, 2 Oct 2002 21:16:37 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: [PATCH] FAT/VFAT memory corruption during mount()
Message-ID: <20021002191637.GA1431@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch fixes memory corruption during vfat mount: one byte
before mount options is overwritten by ',' since strtok->strsep
conversion happened.

This patch also fixes another problem introduced by strtok->strsep
conversion: VFAT requires that FAT does not modify passed options,
but unfortunately FAT driver fails to preserve options string if
there is more than one consecutive comma in option string.

					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/fs/fat/inode.c linux/fs/fat/inode.c
--- linux/fs/fat/inode.c	2002-10-02 13:20:19.000000000 +0200
+++ linux/fs/fat/inode.c	2002-10-02 19:54:59.000000000 +0200
@@ -228,8 +228,6 @@
 	save = 0;
 	savep = NULL;
 	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
-			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
@@ -351,7 +349,7 @@
 			strncpy(cvf_options,value,100);
 		}
 
-		if (this_char != options) *(this_char-1) = ',';
+		if (options) *(options-1) = ',';
 		if (value) *savep = save;
 		if (ret == 0)
 			break;
diff -urdN linux/fs/vfat/namei.c linux/fs/vfat/namei.c
--- linux/fs/vfat/namei.c	2002-10-02 13:20:27.000000000 +0200
+++ linux/fs/vfat/namei.c	2002-10-02 19:54:28.000000000 +0200
@@ -117,8 +117,6 @@
 	savep = NULL;
 	ret = 1;
 	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
-			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
@@ -154,8 +152,8 @@
 			else
 				ret = 0;
 		}
-		if (this_char != options)
-			*(this_char-1) = ',';
+		if (options)
+			*(options-1) = ',';
 		if (value) {
 			*savep = save;
 		}
