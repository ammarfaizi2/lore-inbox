Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbUKIBuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbUKIBuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUKIBtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:49:09 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:24797 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261351AbUKIBn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:43:59 -0500
Date: Tue, 9 Nov 2004 02:43:58 +0100
From: lsr@neapel230.server4you.de
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Manually inline shortname_info_to_lcase()
Message-ID: <20041109014358.GE6835@neapel230.server4you.de>
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
User-Agent: Mutt/1.4.1i
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

--- ./fs/vfat/namei.c.orig	2004-11-09 01:40:54.000000000 +0100
+++ ./fs/vfat/namei.c	2004-11-09 01:41:16.000000000 +0100
@@ -258,22 +258,6 @@
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
@@ -447,20 +431,22 @@
 	if (is_shortname && base_info.valid && ext_info.valid) {
 		if (vfat_find_form(dir, name_res) == 0)
 			return -EEXIST;
 
 		if (opt_shortname & VFAT_SFN_CREATE_WIN95) {
 			return (base_info.upper && ext_info.upper);
 		} else if (opt_shortname & VFAT_SFN_CREATE_WINNT) {
 			if ((base_info.upper || base_info.lower)
 			    && (ext_info.upper || ext_info.lower)) {
-				*lcase = shortname_info_to_lcase(&base_info,
-								 &ext_info);
+				if (!base_info.upper && base_info.lower)
+					*lcase |= CASE_LOWER_BASE;
+				if (!ext_info.upper && ext_info.lower)
+					*lcase |= CASE_LOWER_EXT;
 				return 1;
 			}
 			return 0;
 		} else {
 			BUG();
 		}
 	}
 	
 	if (MSDOS_SB(dir->i_sb)->options.numtail == 0)
