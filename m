Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVAQRs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVAQRs3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVAQRqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:46:10 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:1801 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262821AbVAQRnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:43:01 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/13] FAT: Manually inline shortname_info_to_lcase()
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:42:46 +0900
In-Reply-To: <87d5w4osuv.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Tue, 18 Jan 2005 02:42:00 +0900")
Message-ID: <878y6sostl.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch inlines shortname_info_to_lcase() by hand. At least my
compiler (gcc 3.3.4 from Debian) doesn't go all the way, so the compiled
text size is decreased by this patch. And IMHO the code gets more
readable, too.

The terms (base->valid && ext->valid), (ext->lower || ext->upper) and
(base->lower || base->upper) are trivially found to be true at the
single callsite of shortname_info_to_lcase(). The relevant lines are
included in this patch file.

 From lsr@neapel230.server4you.de

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/vfat/namei.c |   26 ++++++--------------------
 1 files changed, 6 insertions(+), 20 deletions(-)

diff -puN fs/vfat/namei.c~fat_lcase-cleanup fs/vfat/namei.c
--- linux-2.6.10/fs/vfat/namei.c~fat_lcase-cleanup	2005-01-08 09:07:58.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/vfat/namei.c	2005-01-08 09:07:58.000000000 +0900
@@ -262,22 +262,6 @@ struct shortname_info {
 	(x)->valid = 1;				\
 } while (0)
 
-static inline unsigned char
-shortname_info_to_lcase(struct shortname_info *base,
-			struct shortname_info *ext)
-{
-	unsigned char lcase = 0;
-
-	if (base->valid && ext->valid) {
-		if (!base->upper && base->lower && (ext->lower || ext->upper))
-			lcase |= CASE_LOWER_BASE;
-		if (!ext->upper && ext->lower && (base->lower || base->upper))
-			lcase |= CASE_LOWER_EXT;
-	}
-
-	return lcase;
-}
-
 static inline int to_shortname_char(struct nls_table *nls,
 				    unsigned char *buf, int buf_size, wchar_t *src,
 				    struct shortname_info *info)
@@ -455,10 +439,12 @@ static int vfat_create_shortname(struct 
 		if (opt_shortname & VFAT_SFN_CREATE_WIN95) {
 			return (base_info.upper && ext_info.upper);
 		} else if (opt_shortname & VFAT_SFN_CREATE_WINNT) {
-			if ((base_info.upper || base_info.lower)
-			    && (ext_info.upper || ext_info.lower)) {
-				*lcase = shortname_info_to_lcase(&base_info,
-								 &ext_info);
+			if ((base_info.upper || base_info.lower) &&
+			    (ext_info.upper || ext_info.lower)) {
+				if (!base_info.upper && base_info.lower)
+					*lcase |= CASE_LOWER_BASE;
+				if (!ext_info.upper && ext_info.lower)
+					*lcase |= CASE_LOWER_EXT;
 				return 1;
 			}
 			return 0;
_
