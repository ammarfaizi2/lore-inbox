Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbUKIByn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbUKIByn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUKIBs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:48:29 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:24285 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261335AbUKIBmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:42:08 -0500
Date: Tue, 9 Nov 2004 02:42:07 +0100
From: lsr@neapel230.server4you.de
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Simplify checks for unwanted chars
Message-ID: <20041109014207.GD6835@neapel230.server4you.de>
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the macros IS_REPLACECHAR and IS_SKIPCHAR and their
static char arrays with inline functions. IMHO it makes the code
slightly more readable and shrinks both code and compiled text size.

The use of inline functions instead of macros also gives us type safety
without having to resort to casting.

--- ./fs/vfat/namei.c.orig	2004-11-08 21:18:48.000000000 +0100
+++ ./fs/vfat/namei.c	2004-11-08 21:18:19.000000000 +0100
@@ -159,25 +159,20 @@ static int vfat_cmp(struct dentry *dentr
 
 /* Characters that are undesirable in an MS-DOS file name */
 
-static wchar_t replace_chars[] = {
-	/*  `['     `]'    `;'     `,'     `+'      `=' */
-	0x005B, 0x005D, 0x003B, 0x002C, 0x002B, 0x003D, 0,
-};
-#define IS_REPLACECHAR(uni)	(vfat_unistrchr(replace_chars, (uni)) != NULL)
-
-static wchar_t skip_chars[] = {
-	/*  `.'     ` ' */
-	0x002E, 0x0020, 0,
-};
-#define IS_SKIPCHAR(uni) \
-	((wchar_t)(uni) == skip_chars[0] || (wchar_t)(uni) == skip_chars[1])
+static inline int vfat_replace_char(wchar_t w)
+{
+	return (w == 0x005B)	/* [ */
+	    || (w == 0x005D)	/* ] */
+	    || (w == 0x003B)	/* ; */
+	    || (w == 0x002C)	/* , */
+	    || (w == 0x002B)	/* + */
+	    || (w == 0x003D);	/* = */
+}
 
-static inline wchar_t *vfat_unistrchr(const wchar_t *s, const wchar_t c)
+static inline int vfat_skip_char(wchar_t w)
 {
-	for(; *s != c; ++s)
-		if (*s == 0)
-			return NULL;
-	return (wchar_t *) s;
+	return (w == 0x002E)	/* . */
+	    || (w == 0x0020);	/* <space> */
 }
 
 static int vfat_valid_longname(const unsigned char *name, unsigned int len)
@@ -285,11 +280,11 @@ static inline int to_shortname_char(stru
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
@@ -369,7 +364,7 @@ static int vfat_create_shortname(struct 
 		 */
 		name_start = &uname[0];
 		while (name_start < ext_start) {
-			if (!IS_SKIPCHAR(*name_start))
+			if (!vfat_skip_char(*name_start))
 				break;
 			name_start++;
 		}
