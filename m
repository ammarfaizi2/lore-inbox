Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVAQRpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVAQRpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVAQRpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:45:10 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:64776 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262444AbVAQRmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:42:15 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/13] FAT: Return better error codes from
 vfat_valid_longname()
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:42:00 +0900
In-Reply-To: <87hdlgoswe.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Tue, 18 Jan 2005 02:41:05 +0900")
Message-ID: <87d5w4osuv.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix error code.

 From Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/vfat/namei.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff -puN fs/vfat/namei.c~fat_nametoolong fs/vfat/namei.c
--- linux-2.6.10/fs/vfat/namei.c~fat_nametoolong	2005-01-08 09:07:53.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/vfat/namei.c	2005-01-08 09:07:53.000000000 +0900
@@ -192,10 +192,10 @@ static inline int vfat_is_used_badchars(
 
 static int vfat_valid_longname(const unsigned char *name, unsigned int len)
 {
-	if (len && name[len-1] == ' ')
-		return 0;
+	if (name[len - 1] == ' ')
+		return -EINVAL;
 	if (len >= 256)
-		return 0;
+		return -ENAMETOOLONG;
 
 	/* MS-DOS "device special files" */
 	if (len == 3 || (len > 3 && name[3] == '.')) {	/* basename == 3 */
@@ -203,18 +203,18 @@ static int vfat_valid_longname(const uns
 		    !strnicmp(name, "con", 3) ||
 		    !strnicmp(name, "nul", 3) ||
 		    !strnicmp(name, "prn", 3))
-			return 0;
+			return -EINVAL;
 	}
 	if (len == 4 || (len > 4 && name[4] == '.')) {	/* basename == 4 */
 		/* "com1", "com2", ... */
 		if ('1' <= name[3] && name[3] <= '9') {
 			if (!strnicmp(name, "com", 3) ||
 			    !strnicmp(name, "lpt", 3))
-				return 0;
+				return -EINVAL;
 		}
 	}
 
-	return 1;
+	return 0;
 }
 
 static int vfat_find_form(struct inode *dir, unsigned char *name)
@@ -617,8 +617,9 @@ static int vfat_build_slots(struct inode
 	loff_t offset;
 
 	*slots = 0;
-	if (!vfat_valid_longname(name, len))
-		return -EINVAL;
+	res = vfat_valid_longname(name, len);
+	if (res)
+		return res;
 
 	if(!(page = __get_free_page(GFP_KERNEL)))
 		return -ENOMEM;
_
