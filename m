Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVCETGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVCETGB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVCETE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:04:56 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:30724 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261151AbVCESnn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:43:43 -0500
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/29] FAT: fat_readdirx() with dotOK=yes fix
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:43:16 +0900
In-Reply-To: <87d5uerl2j.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:42:28 +0900")
Message-ID: <878y52rl17.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the case of dotsOK, re-initialization of "ptname" pointer is needed,
otherwise, "ptname" is pointing the previous start position.

This fixes it.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff -puN fs/fat/dir.c~fat_readdirx-fix fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~fat_readdirx-fix	2005-03-06 02:36:05.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:36:05.000000000 +0900
@@ -442,9 +442,13 @@ ParseLong:
 			long_slots = 0;
 	}
 
-	if ((de->attr & ATTR_HIDDEN) && MSDOS_SB(sb)->options.dotsOK) {
-		*ptname++ = '.';
-		dotoffset = 1;
+	if (MSDOS_SB(sb)->options.dotsOK) {
+		ptname = bufname;
+		dotoffset = 0;
+		if (de->attr & ATTR_HIDDEN) {
+			*ptname++ = '.';
+			dotoffset = 1;
+		}
 	}
 
 	memcpy(work, de->name, sizeof(de->name));
_
