Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVAQRoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVAQRoF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVAQRmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:42:37 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:62216 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262824AbVAQRlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:41:22 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/13] FAT: IS_BADCHAR/IS_REPLACECHR/IS_SKIPCHAR cleanup
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:41:05 +0900
In-Reply-To: <87llasosxu.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message
 of "Tue, 18 Jan 2005 02:40:13 +0900")
Message-ID: <87hdlgoswe.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 From Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/vfat/namei.c |   49 +++++++++++++++++++++----------------------------
 1 files changed, 21 insertions(+), 28 deletions(-)

diff -puN fs/vfat/namei.c~fat_check-chars-cleanup fs/vfat/namei.c
--- linux-2.6.10/fs/vfat/namei.c~fat_check-chars-cleanup	2005-01-08 09:07:50.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/vfat/namei.c	2005-01-08 09:07:50.000000000 +0900
@@ -158,33 +158,26 @@ static int vfat_cmp(struct dentry *dentr
 
 /* Characters that are undesirable in an MS-DOS file name */
 
-static wchar_t bad_chars[] = {
-	/*  `*'     `?'     `<'    `>'      `|'     `"'     `:'     `/' */
-	0x002A, 0x003F, 0x003C, 0x003E, 0x007C, 0x0022, 0x003A, 0x002F,
-	/*  `\' */
-	0x005C, 0,
-};
-#define IS_BADCHAR(uni)	(vfat_unistrchr(bad_chars, (uni)) != NULL)
-
-static wchar_t replace_chars[] = {
-	/*  `['     `]'    `;'     `,'     `+'      `=' */
-	0x005B, 0x005D, 0x003B, 0x002C, 0x002B, 0x003D, 0,
-};
-#define IS_REPLACECHAR(uni)	(vfat_unistrchr(replace_chars, (uni)) != NULL)
+static inline wchar_t vfat_bad_char(wchar_t w)
+{
+	return (w < 0x0020)
+	    || (w == 0x002A) /* * */	|| (w == 0x003F) /* ? */
+	    || (w == 0x003C) /* < */	|| (w == 0x003E) /* > */
+	    || (w == 0x007C) /* | */	|| (w == 0x0022) /* " */
+	    || (w == 0x003A) /* : */	|| (w == 0x002F) /* / */
+	    || (w == 0x005C);/* \ */
+}
 
-static wchar_t skip_chars[] = {
-	/*  `.'     ` ' */
-	0x002E, 0x0020, 0,
-};
-#define IS_SKIPCHAR(uni) \
-	((wchar_t)(uni) == skip_chars[0] || (wchar_t)(uni) == skip_chars[1])
+static inline wchar_t vfat_replace_char(wchar_t w)
+{
+	return (w == 0x005B) /* [ */	|| (w == 0x005D) /* ] */
+	    || (w == 0x003B) /* ; */	|| (w == 0x002C) /* , */
+	    || (w == 0x002B) /* + */	|| (w == 0x003D);/* = */
+}
 
-static inline wchar_t *vfat_unistrchr(const wchar_t *s, const wchar_t c)
+static wchar_t vfat_skip_char(wchar_t w)
 {
-	for(; *s != c; ++s)
-		if (*s == 0)
-			return NULL;
-	return (wchar_t *) s;
+	return (w == 0x002E) /* . */	|| (w == 0x0020);/* <space> */
 }
 
 static inline int vfat_is_used_badchars(const wchar_t *s, int len)
@@ -192,7 +185,7 @@ static inline int vfat_is_used_badchars(
 	int i;
 	
 	for (i = 0; i < len; i++)
-		if (s[i] < 0x0020 || IS_BADCHAR(s[i]))
+		if (vfat_bad_char(s[i]))
 			return -EINVAL;
 	return 0;
 }
@@ -291,11 +284,11 @@ static inline int to_shortname_char(stru
 {
 	int len;
 
-	if (IS_SKIPCHAR(*src)) {
+	if (vfat_skip_char(*src)) {
 		info->valid = 0;
 		return 0;
 	}
-	if (IS_REPLACECHAR(*src)) {
+	if (vfat_replace_char(*src)) {
 		info->valid = 0;
 		buf[0] = '_';
 		return 1;
@@ -375,7 +368,7 @@ static int vfat_create_shortname(struct 
 		 */
 		name_start = &uname[0];
 		while (name_start < ext_start) {
-			if (!IS_SKIPCHAR(*name_start))
+			if (!vfat_skip_char(*name_start))
 				break;
 			name_start++;
 		}
_
