Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUKISWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUKISWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUKISWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:22:45 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:36318 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261606AbUKISWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:22:25 -0500
Date: Tue, 9 Nov 2004 19:22:24 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Move check for invalid chars to vfat_valid_longname()
Message-ID: <20041109182224.GA15288@neapel230.server4you.de>
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx> <20041109013524.GB6835@neapel230.server4you.de> <87actr5ak8.fsf@devron.myhome.or.jp> <4190EED2.5040906@lsrfire.ath.cx> <87is8fj5o7.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87is8fj5o7.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 02:25:28AM +0900, OGAWA Hirofumi wrote:
> René Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> 
> > We want to make sure filenames don't contain '*', '?' etc.
> 
> No. For example, Shift-JIS has 0x815c. It's contains the '\' (0x5c),
> but the 0x815c is a valid char for fatfs.

Oops -- of course.

But doesn't imply this we can't do any of our checks on the VFS string?
A dot (0x2E) at the end of a filename could be the half of some other
character in some encoding, right? And the same could be said about the
checks in vfat_valid_longname(), no? Do we need to convert them to
Unicode?


The patch you asked for converting IS_BADCHAR to an inline function
follows. I rolled it together with the other conversions from patch 3.
Applies directly on top of 2.6.10-rc1-bk18.

Thanks,
René


--- linux-2.6.10-rc1-bk18/fs/vfat/namei.c.orig	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6.10-rc1-bk18/fs/vfat/namei.c	2004-11-09 18:56:48.000000000 +0100
@@ -158,33 +158,34 @@ static int vfat_cmp(struct dentry *dentr
 
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
-
-static wchar_t skip_chars[] = {
-	/*  `.'     ` ' */
-	0x002E, 0x0020, 0,
-};
-#define IS_SKIPCHAR(uni) \
-	((wchar_t)(uni) == skip_chars[0] || (wchar_t)(uni) == skip_chars[1])
+static inline wchar_t vfat_bad_char(wchar_t w)
+{
+	return (w < 0x0020)
+	    || (w == 0x002A)	/* * */
+	    || (w == 0x003F)	/* ? */
+	    || (w == 0x003C)	/* < */
+	    || (w == 0x003E)	/* > */
+	    || (w == 0x007C)	/* | */
+	    || (w == 0x0022)	/* " */
+	    || (w == 0x003A)	/* : */
+	    || (w == 0x002F)	/* / */
+	    || (w == 0x005C);	/* \ */
+}
+
+static inline wchar_t vfat_replace_char(wchar_t w)
+{
+	return (w == 0x005B)	/* [ */
+	    || (w == 0x005D)	/* ] */
+	    || (w == 0x003B)	/* ; */
+	    || (w == 0x002C)	/* , */
+	    || (w == 0x002B)	/* + */
+	    || (w == 0x003D);	/* = */
+}
 
-static inline wchar_t *vfat_unistrchr(const wchar_t *s, const wchar_t c)
+static inline wchar_t vfat_skip_char(wchar_t w)
 {
-	for(; *s != c; ++s)
-		if (*s == 0)
-			return NULL;
-	return (wchar_t *) s;
+	return (w == 0x002E)	/* . */
+	    || (w == 0x0020);	/* <space> */
 }
 
 static inline int vfat_is_used_badchars(const wchar_t *s, int len)
@@ -192,7 +193,7 @@ static inline int vfat_is_used_badchars(
 	int i;
 	
 	for (i = 0; i < len; i++)
-		if (s[i] < 0x0020 || IS_BADCHAR(s[i]))
+		if (vfat_bad_char(s[i]))
 			return -EINVAL;
 	return 0;
 }
@@ -291,11 +292,11 @@ static inline int to_shortname_char(stru
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
@@ -375,7 +376,7 @@ static int vfat_create_shortname(struct 
 		 */
 		name_start = &uname[0];
 		while (name_start < ext_start) {
-			if (!IS_SKIPCHAR(*name_start))
+			if (!vfat_skip_char(*name_start))
 				break;
 			name_start++;
 		}
