Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbTLFIzs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 03:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTLFIzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 03:55:48 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:18878 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S265049AbTLFIzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 03:55:45 -0500
Date: Sat, 6 Dec 2003 09:55:39 +0100
From: Michal Rokos <m.rokos@sh.cvut.cz>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.0-test11] VFAT fix for UTF-8 and trailing dots
Message-ID: <20031206085539.GA3134@nightmare.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Crypto: GnuPG/1.0.6 http://www.gnupg.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

there is one problem with vfat when UTF-8 option is on...

The problem is: even if vfat_striptail_len() counts len of name without
trailing dots and sets len to the correct value, utf8_mbstowcs() doesn't
care about len and takes whole name.
So dirs and files with dots can be created on vfat fs and that will
cause some problems as you know :)

This patch just shortens outlen to the correct value - nothing else.

Compiled, tested.

Please concider the inclusion.

Thank you.

	Michal

--- linux-2.6.0-test11/fs/vfat/namei.c.old	2003-11-26 21:44:34.000000000 +0100
+++ linux-2.6.0-test11/fs/vfat/namei.c	2003-12-06 09:34:44.000000000 +0100
@@ -573,13 +573,18 @@ xlate_to_uni(const unsigned char *name, 
 	int charlen;
 
 	if (utf8) {
+		int name_len = strlen(name);
+
 		*outlen = utf8_mbstowcs((wchar_t *)outname, name, PAGE_SIZE);
-		if (name[len-1] == '.')
-			*outlen-=2;
+
+		/* 
+		 * We stripped '.'s before and set len appropriately,
+		 * but utf8_mbstowcs doesn't care about len
+		 */
+		*outlen -= (name_len-len);
+
 		op = &outname[*outlen * sizeof(wchar_t)];
 	} else {
-		if (name[len-1] == '.') 
-			len--;
 		if (nls) {
 			for (i = 0, ip = name, op = outname, *outlen = 0;
 			     i < len && *outlen <= 260; *outlen += 1)

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Michal Rokos                         Czech Technical University, Prague
e-mail: m.rokos@sh.cvut.cz    icq: 36118339     jabber: majkl@jabber.cz
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
